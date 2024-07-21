/*
Базы данных и SQL (семинары)
Урок 3. SQL – выборка данных, сортировка, агрегатные функции
https://gb.ru/lessons/441877/homework
*/

-- Условие
/*
Имеется таблица (сущность) с персоналом staff.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
firstname – имя;
lastname - фамилия.
post - должность,
seniority – стаж;
salary – заработная плата;
age - возраст.
*/

DROP TABLE IF EXISTS staff; -- Удаление существующей таблицы
-- CREATE TABLE staff -- Команда выдаст ошибку, если таблица уже существует
CREATE TABLE IF NOT EXISTS staff /* Создание таблицы при уже существующей, 
									не прерывая работу кода */
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT,
	salary INT,
	age INT
);

