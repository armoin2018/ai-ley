-- Comprehensive order processing stored procedure
CREATE OR ALTER PROCEDURE orders.ProcessOrder
    @CustomerID BIGINT,
    @CartSessionID NVARCHAR(128),
    @BillingAddressID BIGINT,
    @ShippingAddressID BIGINT,
    @PaymentMethodID INT,
    @PromoCode NVARCHAR(50) = NULL,
    @OrderID BIGINT OUTPUT,
    @OrderTotal DECIMAL(12,2) OUTPUT,
    @ResultMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TranCount INT = @@TRANCOUNT;
    DECLARE @ErrorNumber INT, @ErrorMessage NVARCHAR(4000);
    DECLARE @OrderNumber NVARCHAR(50);
    DECLARE @SubTotal DECIMAL(12,2) = 0.00;
    DECLARE @TaxAmount DECIMAL(12,2) = 0.00;
    DECLARE @ShippingAmount DECIMAL(12,2) = 0.00;
    DECLARE @DiscountAmount DECIMAL(12,2) = 0.00;

    BEGIN TRY
        IF @TranCount = 0
            BEGIN TRANSACTION;

        -- Generate unique order number
        SET @OrderNumber = 'ORD' + FORMAT(GETDATE(), 'yyyyMMdd') + RIGHT('00000' + CAST(NEXT VALUE FOR orders.OrderNumberSeq AS VARCHAR), 5);

        -- Validate customer
        IF NOT EXISTS (SELECT 1 FROM customers.Customers WHERE CustomerID = @CustomerID AND IsActive = 1)
        BEGIN
            RAISERROR('Invalid or inactive customer ID: %d', 16, 1, @CustomerID);
            RETURN;
        END

        -- Validate cart has items
        IF NOT EXISTS (SELECT 1 FROM customers.ShoppingCart WHERE SessionID = @CartSessionID)
        BEGIN
            RAISERROR('Shopping cart is empty for session: %s', 16, 1, @CartSessionID);
            RETURN;
        END

        -- Calculate subtotal and validate inventory
        WITH CartSummary AS (
            SELECT
                sc.ProductID,
                sc.Quantity,
                sc.UnitPrice,
                p.SKU,
                p.ProductName,
                pi.QuantityAvailable,
                sc.Quantity * sc.UnitPrice AS LineTotal
            FROM customers.ShoppingCart sc WITH (UPDLOCK)
            INNER JOIN catalog.Products p ON sc.ProductID = p.ProductID
            INNER JOIN inventory.ProductInventory pi ON p.ProductID = pi.ProductID
            WHERE sc.SessionID = @CartSessionID
              AND pi.LocationID = 1 -- Main warehouse
        )
        SELECT @SubTotal = SUM(LineTotal)
        FROM CartSummary;

        -- Check inventory availability
        IF EXISTS (
            SELECT 1
            FROM customers.ShoppingCart sc
            INNER JOIN inventory.ProductInventory pi ON sc.ProductID = pi.ProductID
            WHERE sc.SessionID = @CartSessionID
              AND sc.Quantity > pi.QuantityAvailable
              AND pi.LocationID = 1
        )
        BEGIN
            RAISERROR('Insufficient inventory for one or more items in cart', 16, 1);
            RETURN;
        END

        -- Apply promo code discount
        IF @PromoCode IS NOT NULL
        BEGIN
            SELECT @DiscountAmount = dbo.CalculatePromoDiscount(@PromoCode, @SubTotal, @CustomerID);
        END

        -- Calculate tax (simplified - would integrate with tax service)
        SELECT @TaxAmount = dbo.CalculateTax(@SubTotal - @DiscountAmount, @ShippingAddressID);

        -- Calculate shipping
        SELECT @ShippingAmount = dbo.CalculateShipping(@SubTotal, @ShippingAddressID);

        SET @OrderTotal = @SubTotal + @TaxAmount + @ShippingAmount - @DiscountAmount;

        -- Create order record
        INSERT INTO orders.Orders (
            OrderNumber, CustomerID, OrderDate, OrderStatus,
            BillingAddressID, ShippingAddressID,
            SubTotal, TaxAmount, ShippingAmount, DiscountAmount, TotalAmount,
            PaymentMethod, PaymentStatus
        )
        VALUES (
            @OrderNumber, @CustomerID, SYSUTCDATETIME(), 1, -- Pending
            @BillingAddressID, @ShippingAddressID,
            @SubTotal, @TaxAmount, @ShippingAmount, @DiscountAmount, @OrderTotal,
            'Credit Card', 1 -- Pending
        );

        SET @OrderID = SCOPE_IDENTITY();

        -- Create order items and reserve inventory
        INSERT INTO orders.OrderItems (
            OrderID, OrderDate, ProductID, SKU, ProductName,
            Quantity, UnitPrice, DiscountAmount
        )
        SELECT
            @OrderID,
            SYSUTCDATETIME(),
            sc.ProductID,
            p.SKU,
            p.ProductName,
            sc.Quantity,
            sc.UnitPrice,
            0.00 -- Item-level discount would be calculated here
        FROM customers.ShoppingCart sc
        INNER JOIN catalog.Products p ON sc.ProductID = p.ProductID
        WHERE sc.SessionID = @CartSessionID;

        -- Reserve inventory
        UPDATE pi
        SET QuantityReserved = pi.QuantityReserved + sc.Quantity,
            LastModifiedDate = SYSUTCDATETIME()
        FROM inventory.ProductInventory pi
        INNER JOIN customers.ShoppingCart sc ON pi.ProductID = sc.ProductID
        WHERE sc.SessionID = @CartSessionID
          AND pi.LocationID = 1;

        -- Clear shopping cart
        DELETE FROM customers.ShoppingCart WHERE SessionID = @CartSessionID;

        -- Process payment (would integrate with payment gateway)
        EXEC payments.ProcessPayment
            @OrderID = @OrderID,
            @PaymentMethodID = @PaymentMethodID,
            @Amount = @OrderTotal,
            @PaymentResult = @ResultMessage OUTPUT;

        IF @ResultMessage != 'Success'
        BEGIN
            RAISERROR('Payment processing failed: %s', 16, 1, @ResultMessage);
            RETURN;
        END

        -- Update order status to processing
        UPDATE orders.Orders
        SET OrderStatus = 2, -- Processing
            PaymentStatus = 2, -- Paid
            ModifiedDate = SYSUTCDATETIME()
        WHERE OrderID = @OrderID;

        -- Send order confirmation (would queue for background processing)
        INSERT INTO messaging.EmailQueue (
            ToEmail, Subject, Body, Priority, CreatedDate
        )
        SELECT
            c.Email,
            'Order Confirmation - ' + @OrderNumber,
            'Thank you for your order...',
            1,
            SYSUTCDATETIME()
        FROM customers.Customers c
        WHERE c.CustomerID = @CustomerID;

        SET @ResultMessage = 'Order processed successfully: ' + @OrderNumber;

        IF @TranCount = 0
            COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @TranCount = 0 AND @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Log error
        INSERT INTO admin.ErrorLog (
            ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine,
            UserName, CreatedDate
        )
        VALUES (
            @ErrorNumber, @ErrorMessage, ERROR_PROCEDURE(), ERROR_LINE(),
            SUSER_SNAME(), SYSUTCDATETIME()
        );

        SET @ResultMessage = 'Order processing failed: ' + @ErrorMessage;
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Helper functions for order processing
CREATE OR ALTER FUNCTION dbo.CalculatePromoDiscount(
    @PromoCode NVARCHAR(50),
    @SubTotal DECIMAL(12,2),
    @CustomerID BIGINT
)
RETURNS DECIMAL(12,2)
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @DiscountAmount DECIMAL(12,2) = 0.00;
    DECLARE @DiscountPercent DECIMAL(5,2);
    DECLARE @MaxDiscount DECIMAL(12,2);
    DECLARE @MinOrderAmount DECIMAL(12,2);

    SELECT
        @DiscountPercent = DiscountPercent,
        @MaxDiscount = MaxDiscountAmount,
        @MinOrderAmount = MinOrderAmount
    FROM marketing.PromoCodes
    WHERE PromoCode = @PromoCode
      AND IsActive = 1
      AND StartDate <= GETDATE()
      AND EndDate >= GETDATE()
      AND (MaxUses IS NULL OR UsageCount < MaxUses);

    IF @DiscountPercent IS NOT NULL AND @SubTotal >= @MinOrderAmount
    BEGIN
        SET @DiscountAmount = @SubTotal * (@DiscountPercent / 100.0);
        IF @MaxDiscount IS NOT NULL AND @DiscountAmount > @MaxDiscount
            SET @DiscountAmount = @MaxDiscount;
    END

    RETURN @DiscountAmount;
END;
GO