-- Event 

DELIMITER $$

CREATE EVENT InsertDailyAmazonSale
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURDATE(), '10:00:00')
DO
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 10 DO
        CALL InsertRandomAmazonSale();
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
