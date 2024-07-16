/*
Базы данных и SQL (семинары)
Урок 3. SQL – выборка данных, сортировка, агрегатные функции
https://gb.ru/lessons/441877
*/

DROP TABLE IF EXISTS staff; /* 	Вставка "IF EXISTS" выдаст предупреждение, вместо ошибки,
				при удалении таблицы в случае, если такой таблицы нет */
-- CREATE TABLE staff 	-- Повтор этой команды выдаст ошибку (Error)
			-- с сообщением о существовании таблицы
CREATE TABLE IF NOT EXISTS staff /* вставка "IF NOT EXISTS" позволяет создать таблицу в случае,							если таблица уже существует, не прерывая работу кода */
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT,
	salary INT,
	age INT
);