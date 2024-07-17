/*
Базы данных и SQL (семинары)
Урок 4. SQL – работа с несколькими таблицами
https://gb.ru/lessons/441878
*/

/*
Типы объединения:

INNER JOIN -- сбор информации, общей для обеих таблиц
FULL OUTER JOIN -- сбор всей имеющейся в обеих таблицах информации
LEFT JOIN -- сбор информации из левой таблицы и совпадающей с ней информации из правой
	-- при отсутствии в правой таблице соответствующей информации, проставляется "NULL"
RIGHT JOIN -- сбор информации из правой таблицы и совпадающей с ней информации из левой
	   -- при отсутствии в левой таблице соответствующей информации, проставляется "NULL"
*/

-- INNER JOIN

SELECT * 
FROM tableA 
INNER JOIN tableB
ON tableA.name = tableB.name;


CREATE TABLE members
(
member_id INT AUTO_INCREMENT,
name VARCHAR (100) ,
PRIMARY KEY (member_id)
);

CREATE TABLE committees
(
committee_id INT AUTO_INCREMENT,
name VARCHAR (100),
PRIMARY KEY (committee_id)
);

INSERT INTO members (name)
VALUES("John"), ("Jane"), ("wary"), ("David"), ("2melia");
INSERT INTO committees (name)
VALUES ("John"), ("Mary"), ("Amelial"), ("Joe");
SELECT * FROM members;


/*
Задание:
Выведите участников, которые также являются членами комитета, 
используйте INNER JOIN (пересечение 2 таблиц по имени);
*/

-- 1
SELECT *
FROM members AS m
JOIN committees AS c
	ON m.name = c.name;
    
-- 2
SELECT *
FROM members AS m
JOIN committees AS c
	USING(name); -- Объединение одноимённых полей из двух таблиц

SELECT
	m.name -- поле "name" из таблицы "members"
    ,c.committee_id -- поле "id" из таблицы "committees"
FROM members AS m
JOIN committees AS c
	USING(name);


/*
Задание:
1. Выведите участников, которые являются членами комитета (Используя LEFT JOIN, выполните соединение двух таблиц по полю “Имя”)
2.* Выведите участников, которые не являются членами комитета
*/

-- LEFT JOIN
/*
SELECT * FROM tableA 
LEFT OUTER JOIN tableB 
ON tableA.name = tableB.name
*/

-- 1 
SELECT *
FROM members AS m
LEFT JOIN committees AS c
	ON m.name = c.name;    

-- 2 (только те из таблицы "members", кого нет в "committees" - анти "JOIN")
SELECT *
FROM members AS m
LEFT JOIN committees AS c
	ON m.name = c.name
WHERE
	c.name IS NULL;



-- RIGHT JOIN
-- Используется редко, т.к. снижается читабельность
-- Обычно используют "LEFT JOIN", чтобы все данные находились в левой части таблицы

SELECT * FROM tableA 
RIGHT OUTER JOIN tableB 
ON tableB.name = tableA.name

/*
Задание:
1. Найти членов комитета, которых нет в members с помощью RIGHT JOIN
2. Выполнить RIGHT JOIN между 2 таблицами по полю “Имя”
*/

-- 1
SELECT *
FROM members AS m
RIGHT JOIN committees AS c
	ON m.name = c.name;      
    
 -- 2
SELECT *
FROM members AS m
RIGHT JOIN committees AS c
	ON m.name = c.name
WHERE
	m.name IS NULL;



-- CROSS JOIN
-- Объединяет каждую строку первой таблицы со всеми строками второй

SELECT select_list
FROM table_1
CROSS JOIN table_2;

/*
Задание:
1. Найти членов комитета, которых нет в members с помощью RIGHT JOIN
2. Выполнить RIGHT JOIN между 2 таблицами по полю “Имя”
*/

SELECT *
FROM members AS m
CROSS JOIN committees AS c;



-- UNION и UNION ALL
-- "UNION" выводит, только уникальную информацию
-- "UNION ALL" выводит всю имеющуюся в таблицах информацию, с дубликатами

create table users
(
id int auto_increment primary key,
login varchar(255) null,
pass varchar(255) null,
male tinyint null
);

create table clients
(
id int auto_increment primary key,
login varchar(255) null,
pass varchar(255) null,
male tinyint null
);

INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO users (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO users (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO users (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

INSERT INTO clients (login, pass, male) VALUES ('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2);
INSERT INTO clients (login, pass, male) VALUES ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1);
INSERT INTO clients (login, pass, male) VALUES ('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);
INSERT INTO clients (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

/*
Задание:
1. Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей
2. Получить список пользователей и клиентов. Дубликаты удалять не нужно
*/

-- Вывод уникальных имён из обеих таблиц ("users" и "clients")
SELECT login FROM users
UNION
SELECT login FROM clients;

-- Вывод всего списка имён, с их дубликатами
SELECT login FROM users
UNION ALL
SELECT login FROM clients -- Количество столбцов в таблице должно быть одинаковым.
			  -- Нельзя вызвать в 1-й таблице один столбец, а во 2-й два
              -- или столбцы с разным типом данных.
              -- MySQL может преобразовывать разные типы данных,
              -- в других СУБД, это может вызвать ошибку
ORDER BY login; -- сортировка всегда проводится в конце, чтобы отсортировать весь список


-- FULL JOIN
-- Объединяет информацию обеих таблиц

SELECT *
FROM members AS m
LEFT JOIN committees AS c
	ON m.name = c.name
--
UNION -- объединяет выводы левой и правой таблицы
--
SELECT *
FROM members AS m
RIGHT JOIN committees AS c
	ON m.name = c.name;



-- Оператор IN 

SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...);

/*
Проверьте, присутствует ли буква “А” в последовательности 'A', 'B', 'C', 'D'
Проверьте, присутствует ли буква “Z” в последовательности 'A', 'B', 'C', 'D'
Получить столбцы из таблицы “clients” , в которых первое имя является набором значений.
Выберите все логины из таблицы “users”, кроме “Mikle”.
*/

-- 1
SELECT 'A' IN ('A', 'B', 'C', 'D') AS symbol;

-- 2
SELECT 'V' IN ('A', 'B', 'C', 'D') AS symbol;

-- 3
SELECT login FROM clients
-- WHERE login IN ('alex', 'Mikle', 'Leonid');
WHERE login = 'alex' OR login = 'Mikle' OR login = 'Leonid';

-- 4
SELECT login FROM clients
WHERE login NOT IN ('Mikle'); 



-- Оператор EXISTS 

CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Name VARCHAR(45) NOT NULL,
    Department VARCHAR(45) NOT NULL,
    Salary FLOAT NOT NULL,
    Gender VARCHAR(45) NOT NULL,
    Age INT NOT NULL,
    City VARCHAR(45) NOT NULL
);

INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1001, 'John Doe', 'IT', 35000, 'Male', 25, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1002, 'Mary Smith', 'HR', 45000, 'Female', 27, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1003, 'James Brown', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1004, 'Mike Walker', 'Finance', 50000, 'Male', 28, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1005, 'Linda Jones', 'HR', 75000, 'Female', 26, 'London');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1006, 'Anurag Mohanty', 'IT', 35000, 'Male', 25, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1007, 'Priyanla Dewangan', 'HR', 45000, 'Female', 27, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1008, 'Sambit Mohanty', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1009, 'Pranaya Kumar', 'IT', 50000, 'Male', 28, 'Mumbai');
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) VALUES (1010, 'Hina Sharma', 'HR', 75000, 'Female', 26, 'Mumbai');

CREATE TABLE Projects (
    ProjectId INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    ClientId INT,
    EmployeeId INT,
    StartDate DATETIME,
    EndDate DATETIME
);

INSERT INTO Projects ( Title, ClientId, EmployeeId, StartDate, EndDate) VALUES
('Develop ecommerse website from scratch', 1, 1003, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('WordPress website for our company', 1, 1002, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Manage our company servers', 2, 1007, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Hosting account is not working', 3, 1009, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY)),
('MySQL database from my desktop application', 4, 1010, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
('Develop new WordPress plugin for my business website', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY)),
('Migrate web application and database to new server', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
('Android Application development', 4, 1004, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY));


-- Задание на EXISTS
/*
1. Получите из таблицы "Сотрудники" только тех сотрудников, которые в данный момент работают над любым из активных проектов.
2. Проверьте, существует ли сотрудник с идентификатором 1004 в таблице сотрудников или нет.
*/

