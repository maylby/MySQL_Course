/*
Базы данных и SQL (семинары)
Урок 1. Установка СУБД, подключение к БД, просмотр и создание таблиц
https://gb.ru/lessons/441875
*/

-- Символы для выделения комментариев:

-- comment 
-- # comment -- решётка в MySQL на VSCode не работает, 
             -- как символ выделения комментария

/*
comment
comment
comment
*/


/*
1. Получить список с информацией обо всех студентах
2. Получить список всех студентов с именем “Антон”(или любого существующего студента)
3. Вывести имя и название курса из таблички "Студент"
4*. Выбрать студентов, фамилии которых начинаются с буквы «А».
*/

USE lesson_1;

-- 1
SELECT * FROM lesson_1.student;

-- 2
SELECT * FROM student
WHERE LOWER(name) = 'Anton'; -- "LOWER" сводит все знаки к нижнему регистру,
			                 -- "UPPER" - к верхнему регистру.
                             -- Что позволяет писать в любом регистре.

-- 3
SELECT name, course FROM student;

-- 4
/*
LIKE - оператор, позаоляющий пользоваться регулярными выражениями
Galaxy S10, Galaxy S10+, Galaxy S8, Galaxy A8
% - любое количество символов или ничего -> tel LIKE 'Galaxy S%' => Galaxy S10, Galaxy S10+, Galaxy S8
_ - строго один символ -> tel LIKE 'Galaxy S_' => Galaxy S8 (строго 1 символ после 'S')
*/

SELECT * FROM student
WHERE name LIKE 'M%';

SELECT * FROM student
WHERE name LIKE 'M_';

SELECT * FROM student
WHERE name LIKE 'M_r%'; 

-- Запросы "M_" и "M_r%" выдают один и тот же результат


-- Вывод:
/*
----------------------------------------------------
idstudent	name	email	phone	course	stip
----------------------------------------------------
1 		 Marat      vfdfd   6543 	IT 	    6000
3 		 Martin 	ghhg    7853 	IT 	    5000
5 		 Mark       fff     NULL 	IT 	    6001
6 		 Maria      ddd     7888 	Phis 	5999
----------------------------------------------------
*/




/*
1. Выбрать всех студентов,у которых стипендия больше 6000
2. Покажите всех студентов, которые принадлежат к курсу IT.
3. Отобразите всех студентов, который НЕ принадлежат к курсу IT
*/

# 1
SELECT * FROM student
WHERE stip <= 6000;

# 2
SELECT * FROM student
WHERE course = 'IT';

# 3
SELECT * FROM student
WHERE course != 'IT';

SELECT * FROM student
WHERE NOT course = 'IT';
