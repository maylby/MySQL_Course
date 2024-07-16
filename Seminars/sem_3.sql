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
