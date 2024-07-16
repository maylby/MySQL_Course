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
