/*
Базы данных и SQL (семинары)
Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы
https://gb.ru/lessons/441880/homework


1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

DROP function period;

DELIMITER $$ -- //
CREATE FUNCTION period(num INT)
RETURNS VARCHAR(100)
DETERMINISTIC 
BEGIN
    DECLARE days INT DEFAULT 0;
    DECLARE hours INT DEFAULT 0;
    DECLARE minutes INT DEFAULT 0;
    DECLARE seconds INT DEFAULT 0;
    DECLARE res VARCHAR(100) DEFAULT '';
        SET seconds = num MOD 60;
        SET num = num DIV 60;
        SET minutes = num MOD 60;
        SET num = num DIV 60;
        SET hours = num MOD 24;
        SET num = num DIV 24;
        SET days = num MOD 24;
        SET res = CONCAT(
                    days,' days, '
                    , hours,' hours, '
                    , minutes,' minutes, '
                    , seconds,' seconds');
    RETURN res;
END $$ -- //
DELIMITER ;

SELECT period(123456) AS res;



/*
2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

-- v1
WITH RECURSIVE even_num (n) AS
(
    SELECT 2
    UNION ALL
    SELECT n + 2
    FROM even_num
    WHERE n + 2 <= 10
)
SELECT n
FROM even_num;


-- v2
WITH RECURSIVE counter AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 MOD 2 AS n
    FROM counter
    WHERE n + 1 <= 10
)
SELECT * 
FROM counter 
WHERE n MOD 2 = 0;


-- v3
DROP PROCEDURE even_num;

DELIMITER $$ -- //
CREATE PROCEDURE even_num(x INT)
BEGIN
    DECLARE res VARCHAR(200) DEFAULT CAST(x AS char(200));
    REPEAT
        SET x = x - 2;
        SET res = CONCAT(x, ', ', res);
        UNTIL x <= 2
    END REPEAT;
    SELECT res;
END $$ -- //
DELIMITER ;

CALL even_num(10);


-- v4
/* Не разобрался с делением на 2 для вывода ряда чётных чисел */
DROP function even_row;

DELIMITER $$ -- //
CREATE FUNCTION even_row(num INT)
RETURNS VARCHAR(100)
DETERMINISTIC 
BEGIN
    DECLARE n INT DEFAULT 0;
    DECLARE res VARCHAR(100) DEFAULT '';
		WHILE n < num DO
			-- IF n = n % 2 != 0;
				SET n = n + 1 / 2;
				SET res = CONCAT(res, ' ', n);
			-- END IF;
		END WHILE;
    RETURN res;
END $$ -- //
DELIMITER ;

SELECT even_row(10) AS result;

