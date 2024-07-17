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

