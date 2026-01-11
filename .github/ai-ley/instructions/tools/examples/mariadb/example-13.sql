-- Create archive tables
CREATE TABLE orders_archive LIKE orders;
CREATE TABLE order_items_archive LIKE order_items;

-- Archive old completed orders
DELIMITER //
CREATE PROCEDURE ArchiveOldOrders()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cutoff_date DATE DEFAULT DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

    -- Start transaction
    START TRANSACTION;

    -- Move order items first (foreign key dependency)
    INSERT INTO order_items_archive
    SELECT oi.*
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.created_at < cutoff_date
        AND o.status IN ('delivered', 'cancelled');

    -- Move orders
    INSERT INTO orders_archive
    SELECT *
    FROM orders
    WHERE created_at < cutoff_date
        AND status IN ('delivered', 'cancelled');

    -- Delete from original tables
    DELETE oi FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.created_at < cutoff_date
        AND o.status IN ('delivered', 'cancelled');

    DELETE FROM orders
    WHERE created_at < cutoff_date
        AND status IN ('delivered', 'cancelled');

    COMMIT;
END//
DELIMITER ;

-- Schedule archiving (run monthly)
CREATE EVENT ArchiveOldOrdersEvent
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-01-01 02:00:00'
DO CALL ArchiveOldOrders();