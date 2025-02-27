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
CREATE TABLE IF NOT EXISTS staff -- Создание таблицы при уже существующей, не прерывая работу кода
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


-- Задача 1
/*
Вывести идентификатор (id), имя, фамилию, заработную плату (salary) из сущности staff, 
данные отсортировать в порядке возрастания заработной платы.
*/

SELECT 
    id
    , firstname
    , lastname
    , salary
FROM staff
ORDER BY salary;


-- Задача 2
/*
Вывести идентификатор (id), имя, фамилию, заработную плату (salary) из сущности staff, 
данные отсортировать в порядке убывания заработной платы.
*/

SELECT 
    id
    , firstname
    , lastname
    , salary
FROM staff
ORDER BY salary DESC;


-- Задача 3
/*
Необходимо вывести идентификатор, имя, фамилию, заработную плату 
пяти самых высокооплачиваемых сотрудников из сущности staff.
*/

SELECT 
    id
    , firstname
    , lastname
    , salary
FROM staff
ORDER BY salary
LIMIT 5;


/* 
Вывести id, фамилии, имена 5-ти первых сотрудников, 
отсортированых в порядке убывания заработной платы
*/

SELECT 
    id
    , firstname
    , lastname
    , MAX(salary)
FROM staff
GROUP BY id, firstname, lastname
LIMIT 5;


-- Задача 4
/*
Посчитайте и выведите суммарную зарплату (salary) 
по каждой специальности (post) из сущности staff.
Порядок вывода атрибутов: должность, суммарная зарплата.
*/

SELECT post, SUM(salary) AS summ
FROM staff
GROUP BY post;


-- Задача 5
/*
Посчитайте и выведите количество сотрудников с должностью 'Рабочий' 
и возрастом не моложе 24 лет и не старше 49 лет.
*/
-- Выводил "Рабочих" по лимиту. Как вывести по названию профессии?

SELECT
    firstname
    , lastname
    , post
    , age 
FROM staff
GROUP BY firstname, lastname, post, age
HAVING age > 24 AND age < 49
LIMIT 3, 4;

SELECT
    firstname
    , lastname
    , post
    , age
FROM staff
WHERE age > 24 AND age < 49
GROUP BY firstname, lastname, post, age
LIMIT 3, 4;


-- Задача 6
/*
Посчитайте и выведите количество уникальных должностей, 
имеющихся у сотрудников в сущности 'staff'.
*/

SELECT COUNT(DISTINCT post) AS post_count
FROM staff;


-- Задача 7
/*
Найдите средний возраст сотрудников по каждой должности из сущности staff.
Выведите только те должности, у которых средний возраст меньше 30 лет.
*/

SELECT DISTINCT post, ROUND(AVG(age)) AS avg
FROM staff
GROUP BY post, age
HAVING age < 30;
