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
        COUNT(*) as cnt -- количество в столбце "status" вывести в "cnt"
	FROM users          -- из таблицы "users"
    GROUP BY status     -- группировать "status"
)
SELECT * 
FROM count_status -- из табличного выражения "count_status"
WHERE LOWER(status) = 'active'; -- вывести, только 'active'; 
				-- "LOWER" приводит запись к нижнему регистру для корректного сравнения
				-- с эталоном из таблицы "users", где, в столбце "status", 
				-- параметр "Active" записан с заглавной буквы
				-- Сортировку можно было сделать внутри табличного выражения


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


-- Вывод последовательности чисел от 0 до 10, с помощью рекурсии

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


/*
Задача:
Собрать дэшборд, в котором содержится информация о максимальной задолженности в каждом банке, 
а также средний размер процентной ставки в каждом банке в зависимости от сегмента 
и количество договоров всего всем банкам
*/

SELECT
	*
    ,MAX(OSZ) OVER(PARTITION BY TB) AS 'максимальной задолженности в каждом банке'
    ,AVG(procent_rate) OVER(PARTITION BY TB, SEGMENT) AS 'средний размер процентной ставки в каждом банке в зависимости от сегмента'
    ,COUNT(id_dog) OVER()
FROM table1;




CREATE TABLE `bank_table` (
  `idbank_table` INT NOT NULL,
  `tb` VARCHAR(45) NULL,
  `dep` VARCHAR(45) NULL,
  `count_revisions` INT NULL,
  PRIMARY KEY (`idbank_table`));


INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('1', 'A', 'Corp', 100);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('2', 'A', 'Rozn', 47);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('3', 'A', 'IT', 86);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('4', 'B', 'Corp', 70);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('5', 'B', 'Rozn', 65);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('6', 'B', 'IT', 58);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('7', 'C', 'Corp', 42);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('8', 'C', 'Rozn', 40);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('9', 'C', 'IT', 63);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('10', 'D', 'Corp', 95);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('11', 'D', 'Rozn', 120);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('12', 'D', 'IT', 85);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('13', 'E', 'Corp', 70);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('14', 'E', 'Rozn', 72);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('15', 'E', 'IT', 80);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('16', 'F', 'Corp', 66);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('17', 'F', 'Rozn', 111);
INSERT INTO `bank_table` (`idbank_table`, `tb`, `dep`, `count_revisions`) VALUES ('18', 'F', 'IT', 33);


/*
Проранжируем таблицу по убыванию количества ревизий
*/

SELECT * FROM bank_table
ORDER BY count_revisions DESC;

SELECT 
	*
    ,ROW_NUMBER() OVER(ORDER BY count_revisions DESC) AS rn
    ,RANK() OVER(ORDER BY count_revisions DESC) AS r
    ,DENSE_RANK() OVER(ORDER BY count_revisions DESC) AS dr
    ,NTILE(3) OVER(ORDER BY count_revisions DESC) AS n
FROM bank_table;


SELECT  MAX(count_revisions) ms
FROM bank_table
WHERE count_revisions != (SELECT MAX(count_revisions) FROM bank_table);

WITH bank_num AS
(
	SELECT
		*
		,DENSE_RANK() OVER(ORDER BY count_revisions DESC) AS dr
	FROM bank_table
)
SELECT * FROM bank_num
WHERE dr = 9;



CREATE TABLE tasks (
  `id_tasks` INT NOT NULL,
  `event` VARCHAR(45) NOT NULL,
  `date_event` DATETIME NOT NULL);
  
  
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'Open', '2020-02-01');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'To_1_Line', '2020-02-02');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'To_2_Line', '2020-02-03');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'Successful', '2020-02-04');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('1', 'Close', '2020-02-05');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('2', 'Open', '2020-03-01');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('2', 'To_1_Line', '2020-03-02');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('2', 'Denied', '2020-03-03');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('3', 'Open', '2020-04-01');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('3', 'To_1_Line', '2020-04-02');
  INSERT INTO `tasks` (`id_tasks`, `event`, `date_event`) VALUES ('3', 'To_2_Line', '2020-04-03');


SELECT 
	*,
    LEAD(event, 1, 'end') OVER(PARTITION BY id_tasks ORDER BY date_event) AS next_event,
	LEAD(date_event, 1, '2099-01-01') OVER(PARTITION BY id_tasks ORDER BY date_event) AS next_date
FROM tasks;
