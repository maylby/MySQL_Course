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

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

SELECT * FROM staff;

/*
1. Выведите все записи, отсортированные по полю "age" по возрастанию
2. Выведите все записи, отсортированные по полю " firstname "
3. Выведите записи полей " firstname ", "lastname","age",  
   отсортированные по полю " firstname " в алфавитном порядке по убыванию
4. Выполните сортировку по полям " firstname " и "age" по убыванию
*/

-- 1
SELECT * FROM staff
ORDER BY age; -- сортировка в порядке возрастания задана по умолчанию

-- 2
SELECT * FROM staff
ORDER BY firstname;

-- 3
SELECT 
	# Выводить, только перечисленные поля (для читабельности - в столбик)  
	firstname
	,lastname
	,age 
FROM staff
ORDER BY firstname DESC;

SELECT 
	firstname
	,lastname
	,age 
FROM staff
WHERE firstname = "Юрий" -- выводить те, где имя Юрий
	AND age > 24 -- и возраст больше 24
ORDER BY firstname DESC;

SELECT 
	firstname
	,lastname
	,age 
FROM staff
WHERE 1=1 /* заглушка "1=1" нужна для исключения ошибок в случае, если
			 ниже идущие условия будут выключены (закомментированы) */
	-- AND firstname = "Юрий" 
	AND age >= 24 
ORDER BY firstname DESC;

-- 4
SELECT 
	firstname
	,lastname
	,age 
FROM staff
ORDER BY firstname, age DESC;

SELECT * FROM staff
ORDER BY firstname DESC, age DESC;


/*
1. Выведите уникальные (неповторяющиеся) значения полей "firstname"
2. Отсортируйте записи по возрастанию значений поля "id". Выведите первые две записи данной выборки
3. Отсортируйте записи по возрастанию значений поля "id". Пропустите первые 4 строки данной выборки и извлеките следующие 3
4. Отсортируйте записи по убыванию поля "id". Пропустите две строки данной выборки и извлеките следующие за ними 3 строки
*/

-- 1
SELECT DISTINCT firstname, age -- Выводить уникальные строки по имени и возрасту
FROM staff; -- из таблицы "staff"

SELECT firstname, MAX(age)
FROM staff
GROUP BY firstname;

SELECT firstname, age
FROM staff
GROUP BY firstname, age;

-- 2
SELECT *
FROM staff
ORDER BY id
LIMIT 2;

-- 3
SELECT *
FROM staff
ORDER BY id 
LIMIT 4, 2;

-- 4
SELECT *
FROM staff
ORDER BY id desc
LIMIT 2, 3;


-- Агрегатные функции.

DROP TABLE IF EXISTS employee_tbl;
CREATE TABLE employee_tbl (
    id_emp INT AUTO_INCREMENT PRIMARY KEY,
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    work_date DATE,
    daily_typing_pages INT
);

-- Наполнение данными
INSERT INTO employee_tbl (id, name, work_date, daily_typing_pages)
VALUES
(1, 'John', '2007-01-24', 250),
(2, 'Ram', '2007-05-27', 220),
(3, 'Jack', '2007-05-06', 170),
(3, 'Jack', '2007-04-06', 100),
(4, 'Jill', '2007-04-06', 220),
(5, 'Zara', '2007-06-06', 300),
(5, 'Zara', '2007-02-06', 350);

/*
1. Рассчитайте общее количество всех страниц daily_typing_pages
2. Выведите общее количество напечатанных страниц каждым человеком (с помощью предложения GROUP BY)
3. Посчитайте количество записей в таблице
4. Выведите количество имен, которые являются уникальными
5. Найдите среднее арифметическое по количеству ежедневных страниц для набора (daily_typing_pages)
*/

-- 1
SELECT SUM(daily_typing_pages) AS summ 
FROM employee_tbl;

-- 2
SELECT name, SUM(daily_typing_pages) AS summ
FROM employee_tbl
GROUP BY name;

SELECT name, SUM(daily_typing_pages) AS summ, COUNT(daily_typing_pages) AS cnt
FROM employee_tbl
GROUP BY name;

-- 3
SELECT COUNT(*)
FROM employee_tbl;

-- 4
SELECT COUNT(DISTINCT name) AS cnt_name -- вывод числа уникальных имён
FROM employee_tbl;

-- 5
SELECT AVG(daily_typing_pages) AS avg -- среднее арифметическое общего числа страниц
FROM employee_tbl;

SELECT ROUND(AVG(daily_typing_pages)) AS avg -- округление результата до целого числа
FROM employee_tbl;

SELECT ROUND(AVG(daily_typing_pages), 2) AS avg -- округление до 2-го знака после запятой
FROM employee_tbl;

SELECT *
FROM employee_tbl;



CREATE TABLE employee_salary (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
age INT,
salary INT
);