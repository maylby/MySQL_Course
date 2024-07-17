/*
Базы данных и SQL (Лекции)
Урок 2. SQL – создание объектов, изменение данных, логические операторы
https://gb.ru/lessons/443257
*/

-- Создание базы данных

CREATE DATABASE MySampleDB;
	Query OK, 1 row affected (0.00 sec) -- Сгенерированный вывод
	
	-- ERROR 1007 (HY000): Can't create database 'MySampleDB';
    database exists -- указанное имя базы данных конфликтует с существующей базой данных MySQL


-- Просмотр созданных баз данных

show databases; -- вызывает список всех баз данных
use MySampleDB; -- Подключение к базе


-- Создание сущности в MySQL

CREATE TABLE table_name
(
    column_name_1 column_type_1,
    column_name_2 column_type_2,
    ...,
    column_name_N column_type_N
);

-- table_name - имя таблицы
-- column_name - имя столбца
-- column_type - тип данных столбца



-- Типы данных в MySQL

-- Числовые типы

INT — целочисленные значения от −2147483648 до 2147483647, 4 байта.

DECIMAL -- хранит числа с заданной точностью. 
        -- Использует два параметра (N,n)
        -- максимальное количество цифр всего числа (precision) и количество цифр дробной части (scale).
        -- Рекомендуемый тип данных для работы с валютами и координатами.   
NUMERIC, DEC, FIXED -- синонимы.

TINYINT -- целые числа от −127 до 128, занимает 1 байт хранимой памяти.

BOOL -- 0 или 1. Однозначный ответ на однозначный вопрос — false или true. 

/* Название столбцов типа boolean часто начинается с is, has, can, allow. 
По факту, это псевдоним для типа TINYINT (1). B MySQL для него создали встроенные константы 
FALSE (0) или TRUE (1). Можно использовать синоним BOOLEAN.*/

FLOAT -- дробные числа с плавающей запятой (точкой).


-- Символьные

VARCHAR(N) -- N определяет максимально возможную длину строки. 
/* Создан для хранения текстовых данных переменной длины, поэтому 
память хранения зависит от длины строки.
Наиболее часто используемый тип строковых данных.*/

TEXT -- подходит для хранения большого объема текста до 65KB, например, целой статьи.


-- Дата и время

DATE -- только дата. Диапазон от 1000-01-01 по 9999-12-31.
/* Подходит для хранения дат рождения, исторических дат, 
начиная с 11 века. Память хранения — 3 байта. */

TIME -- только время — часы, минуты, секунды — «hh:mm:ss». Память хранения — 3 байта

DATETIME -- соединяет оба предыдущих типа — дату и время.Использует 8 байтов памяти.

TIMESTAMP -- хранит дату и время начиная с 1970 года.
/* Подходит для большинства бизнес-задач. Потребляет 4 байта памяти, что 
в два раза меньше, чем DATETIME, поскольку использует более скромный диапазон дат.
*/


-- Бинарные

/* Используются для хранения файлов, фото, документов, аудио и видеоконтента. 
Все это хранится в бинарном виде. */

BLOB -- до 65 КБ бинарных данных

LARGEBLOB -- до 4 ГБ.
Отдельно используется NULL.
NULL -- «пустое поле» null, то есть «поле, не содержащее никакого значения». 
     -- значит отсутствие, неизвестность информации.
/* Введено для того, чтобы различать в полях БД пустые (визуально не отображаемые) значения (строку нулевой длины) и отсутствующие значения 
(когда в поле не записано вообще никакого значения, даже пустого). */


-- Установка первичного ключа на уровне таблицы:

CREATE TABLE Customers
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Age INT,
    FirstName VARCHAR(20),
    LastName VARCHAR(20)
);


-- Связь таблиц посредством внешнего ключа:

CREATE TABLE Customers
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Age INT,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Phone VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE Orders
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	CustomerId INT,
	CreatedAt Date,
	FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
);



-- Арифметические операции
/*
В MySQL можно применять обычные арифметические операторы. 
Если один из аргументов - беззнаковое целое число, а второй аргумент - также
целое число, то результат будет беззнаковым целым числом
*/

-- Сложение “+”:
mysql> SELECT 3+5;
-> 8

-- Вычитание “-”:
mysql> SELECT 3-5;
-> -2

-- Умножение “*”:
mysql> SELECT 3*5;
-> 15

mysql> SELECT 18014398509481984*18014398509481984;
-> 0

/*
В последнем выражении мы получим неверный результат, так как
произведение данных чисел выходит за границы 64-битового
диапазона для вычислений с точностью BIGINT.
*/

-- Деление “/”:
mysql> SELECT 3/5;
-> 0.60

-- Деление на ноль приводит к результату NULL:
mysql> SELECT 102/0;
-> NULL



-- Логические операторы

AND -- операция логического И. Она объединяет два выражения - выражение1 AND выражение2
/*
Если оба выражения одновременно истинны, то и
общее условие оператора AND также будет истинно. 
*/

OR -- операция логического ИЛИ. 
/*
Она также объединяет два выражения: выражение1 OR выражение2
Если хотя бы одно из этих выражений истинно, то 
общее условие оператора OR также будет истинно.
*/

NOT -- операция логического отрицания. 
/*
Если выражение в этой операции ложно, то общее условие истинно.
NOT выражение
*/

