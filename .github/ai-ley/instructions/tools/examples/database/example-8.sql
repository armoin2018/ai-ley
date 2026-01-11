-- Stored procedure for user registration
DELIMITER //

CREATE PROCEDURE RegisterUser(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(255),
    IN p_password_hash VARCHAR(255),
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    OUT p_user_id BIGINT,
    OUT p_result_code INT,
    OUT p_result_message VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_result_code = -1;
        SET p_result_message = 'Database error occurred';
    END;

    -- Validate input parameters
    IF p_username IS NULL OR p_username = '' THEN
        SET p_result_code = 1;
        SET p_result_message = 'Username is required';
    ELSEIF p_email IS NULL OR p_email = '' THEN
        SET p_result_code = 2;
        SET p_result_message = 'Email is required';
    ELSE
        START TRANSACTION;

        -- Check if username already exists
        IF EXISTS(SELECT 1 FROM user_accounts WHERE username = p_username) THEN
            SET p_result_code = 3;
            SET p_result_message = 'Username already exists';
        ELSEIF EXISTS(SELECT 1 FROM user_accounts WHERE email = p_email) THEN
            SET p_result_code = 4;
            SET p_result_message = 'Email already exists';
        ELSE
            -- Insert new user
            INSERT INTO user_accounts (username, email, password_hash, first_name, last_name)
            VALUES (p_username, p_email, p_password_hash, p_first_name, p_last_name);

            SET p_user_id = LAST_INSERT_ID();
            SET p_result_code = 0;
            SET p_result_message = 'User registered successfully';

            COMMIT;
        END IF;
    END IF;
END //

DELIMITER ;