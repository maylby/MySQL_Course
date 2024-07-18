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
			            ,hours,' hours, ' 
                        ,minutes,' minutes, ' 
                        ,seconds,' seconds'
                        );
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

