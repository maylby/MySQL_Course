/*
Базы данных и SQL (семинары)
Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы
https://gb.ru/lessons/441880


Создайте хранимую процедуру hello(), которая будет возвращать приветствие,
в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/


DELIMITER $$ -- //
CREATE PROCEDURE hello() /* "процедура" ничего не возвращает, а только выводит результат
			    			"функция" циклично возвращает результат, для получения следующего,
			    			пока не будет выполнено условие завершения функции */ 
BEGIN
	CASE
		WHEN CURTIME() BETWEEN '06:00:00' AND '11:59:59'
			THEN SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '17:59:59'
			THEN SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '23:59:59'
			THEN SELECT 'Добрый вечер';
		ELSE SELECT 'Доброй ночи';
    END CASE;
END $$ -- //
DELIMITER ; -- после "DELIMITER" ставим пробел, затем ";"

CALL hello(); -- вызов процедуры



-- Выведите первые N чисел Фибоначчи
-- 1 2 3 4 5 6 7  8  9
-- 0 1 1 2 3 5 8 13 21

-- 3
-- 0 1 1
-- 5
-- 0 1 1 2 3

/*
f1 = 0
f2 = 1
f3 = 0

f3 = f1 + f2 -- 1 -- 2 -- 3
f1 = f2 -- 1 -- 1 -- 2
f2 = f3 -- 1 -- 2 -- 3
*/

DELIMITER $$ -- //
CREATE FUNCTION fib(num INT) -- функция принимает на вход целое число
RETURNS VARCHAR(100)
DETERMINISTIC -- указание, что фукция возвращает один и тот же результат
	      	  -- "NOT DETERMINISTIC" - возврат разных значений
BEGIN
    DECLARE f1 INT DEFAULT 0;
    DECLARE f2 INT DEFAULT 1;
    DECLARE f3 INT DEFAULT 0;
    DECLARE res VARCHAR(100) DEFAULT '0 1';
    
    IF num = 1 THEN
	RETURN f1; -- ::varchar
	ELSEIF num = 2 THEN
	    RETURN CONCAT(f1, ' ', f2);
	    ELSE
		WHILE num > 2 DO
		   SET f3 = f1 + f2;
            	   SET f1 = f2;
                   SET f2 = f3;
                   SET num = num - 1;
                SET res = CONCAT(res, ' ', f3);
	END WHILE;
    END IF;
    RETURN res;
END $$ -- //
DELIMITER ;

SELECT fib(0);

-- SELECT CONCAT(0, ' ', 1, '     ', 'sdfv'); 
-- "CONCAT" - оператор сложения
-- DROP function fib; -- команда на удаление функции



-- Транзакция

DROP TABLE IF EXISTS bankaccounts;
CREATE TABLE bankaccounts(
	accountno varchar(20) PRIMARY KEY NOT NULL,
	funds decimal(8,2));

INSERT INTO bankaccounts VALUES("ACC1", 1000);
INSERT INTO bankaccounts VALUES("ACC2", 1000);

-- Изменим баланс на аккаунтах
START TRANSACTION; 
UPDATE bankaccounts SET funds=funds-100 WHERE accountno='ACC1'; 
UPDATE bankaccounts SET funds=funds+100 WHERE accountno='ACC2'; 
ROLLBACK; -- возврат в исходное состояние

SELECT * FROM bankaccounts;



DROP PROCEDURE loop_proc;

DELIMITER $$ -- //
CREATE PROCEDURE loop_proc(x INT)
BEGIN
	DECLARE res VARCHAR(200) DEFAULT CAST(x AS char(200));
    
    REPEAT
		SET x = x - 1;
        SET res = CONCAT(res, ', ', x);
		UNTIL x <= 0
	END REPEAT;
    
    SELECT res;
END $$ -- //
DELIMITER ;

CALL loop_proc(20);

SELECT CAST(45 AS char);

SELECT CAST(1.55 AS nchar(50));

-- Реализуйте процедуру, внутри которой, с помощью цикла, выведятся числа от N до 1:
-- N = 5=>5,4,3,2,1,