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


-- Рекурсивные СТЕ
/*
CTE является рекурсивным, если его подзапрос ссылается на его собственное имя. Если
планируется использовать рекурсивный CTE то в запрос должен быть включен параметр
RECURSIVE.
*/

WITH RECURSIVE <cte_name> (<colums>) AS
(
  <base_case_query> -- Выполняется 1 раз при запуске рекурсии
  UNION ALL
  <recursive_step_query> -- invoke the CTE here!
)
<main_query>


WITH RECURSIVE sequence (n) AS
(
  SELECT 0 -- первоначальное значение (выполняется 1 раз)
  UNION ALL -- объединить всё
  SELECT n + 1 -- добавлять единицу к значению
  FROM sequence -- из таблицы "sequence"
  WHERE n + 1 <= 10 -- пока значение не будет равно 10  
)
SELECT n -- вывести значение
FROM sequence; -- из таблицы "sequence"


/*
3. 	С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10: 
    (пример для чисел от 1 до 3)
*/
-- n  res
-- 1  1
-- 2  4
-- 3  9
-- 4  16

WITH RECURSIVE cte_rec AS
(
	SELECT 1 AS n, 1 AS res
    UNION ALL
    SELECT n + 1 AS n, POW(n + 1, 2) AS res
    FROM cte_rec
    WHERE n + 1 <= 10
)
SELECT * FROM cte_rec;



-- Оконные функции 

/*
SELECT
Название функции (столбец для вычислений) 
OVER (
   PARTITION BY столбец для группировки
   ORDER BY столбец для сортировки
   ROWS или RANGE выражение для ограничения строк в пределах группы
   )
*/