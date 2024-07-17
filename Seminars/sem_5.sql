/*
Базы данных и SQL (семинары)
Урок 5. SQL – оконные функции
https://gb.ru/lessons/441879
*/

-- СТЕ
/* (таблица, создваемая в рамках одного запроса, 
после выполнения которого она удаляется) */

WITH 
<cte_name>(<colums>) AS
(
    <cte_query>
)
<main_query>


DROP TABLE IF EXISTS users;

CREATE TABLE users (
	username VARCHAR(50) PRIMARY KEY,
	password VARCHAR(50) NOT NULL,
	status VARCHAR(10) NOT NULL);

CREATE TABLE users_profile (
	username VARCHAR(50) PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE);

INSERT INTO users values
	('admin' , '7856', 'Active'),
    ('staff' , '90802', 'Active'),
    ('manager' , '35462', 'Inactive');

INSERT INTO users_profile values
	('admin', 'Administrator' , 'Dhanmondi', 'admin@test.com' ) ,
	('staff', 'Jakir Nayek' , 'Mirpur', 'zakir@test.com' ),
	('manager', 'Mehr Afroz' , 'Eskaton', 'mehr@test.com' );

/*
1.	Используя СТЕ, выведите всех пользователей из таблицы users_profile
2.	Используя СТЕ, подсчитайте количество активных пользователей . 
	Задайте псевдоним результирующему окну. 
    Пример:
*/

SELECT * FROM users;
SELECT * FROM users_profile;

-- 1
WITH cte_users AS
(
	SELECT * 
    FROM users_profile
)
SELECT * FROM cte_users;

-- 2
WITH count_status AS
(
	SELECT 
		status,
        COUNT(*) as cnt
	FROM users
    GROUP BY status
)
SELECT * 
FROM count_status
WHERE status = 'active';


WITH RECURSIVE sequence (n) AS
(
  SELECT 0
  UNION ALL
  SELECT n + 1 
  FROM sequence 
  WHERE n + 1 <= 10
)
SELECT n
FROM sequence;