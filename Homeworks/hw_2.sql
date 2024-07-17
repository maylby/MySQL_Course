/*
Базы данных и SQL (семинары)
Урок 2. SQL – создание объектов, простые запросы выборки
https://gb.ru/lessons/441876/homework
*/

-- Условие:
/*
Имеется таблица (сущность) с мобильными телефонами mobile_phones.
У сущности имеются следующие поля(атрибуты):
id – идентификатор;
product_name – название;
manufacturer – производитель;
product_count – количество;
price – цена.

Сущность mobile_phones имеет следующие записи:
| id | product_name | manufacturer | product_count | price | 
| 1 | iPhone X | Apple | 156 | 76000 | 
| 2 | iPhone 8 | Apple | 180 | 51000 | 
| 3 | Galaxy S9 | Samsung | 21 | 56000 | 
| 4 | Galaxy S8 | Samsung | 124 | 41000 | 
| 5 | P20 Pro | Huawei | 341 | 36000 |

*/

-- Создание таблицы:

CREATE TABLE mobile_phones
(
	id SERIAL PRIMARY KEY,
	name_product VARCHAR(60) NOT NULL,
    manufacturer VARCHAR(60) NOT NULL,
    product_count INT,
    price INT
);
SELECT * FROM mobile_phones;


-- наполнение данными 

INSERT INTO mobile_phones (name_product, manufacturer, product_count, price)
VALUES
('iPhone X', 'Apple', 156, 76000),
('iPhone 8', 'Apple', 180, 51000),
('Galaxy S9', 'Samsung', 21, 56000),
('Galaxy S8', 'Samsung', 124, 41000),
('P20 Pro', 'Huawei', 341, 36000);

SELECT * FROM mobile_phones;


-- Задача 1
/*
Создайте таблицу (сущность) с заказами manufacturer. 
При создании необходимо использовать DDL-команды.

Перечень полей (атрибутов):
  id – числовой тип, автоинкремент, первичный ключ;
  name – строковый тип;

Используя CRUD-операцию INSERT, наполните сущность manufacturer в соответствии с данными, 
имеющимися в атрибуте manufacturer сущности mobile_phones.
*/


CREATE TABLE manufacturer 
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(45)
);

INSERT INTO manufacturer (name)
SELECT DISTINCT manufacturer
FROM mobile_phones;

SELECT * FROM manufacturer;



-- Задача 2
/*
Статусы количества мобильных телефонов 
(в зависимости от количества): 
	меньше 100 – «little»; 
	от 100 до 300 – «many»; 
	больше 300 – «lots».
Необходимо вывести название, производителя и статус количества для мобильных телефонов
*/


SELECT
	name_product,
	manufacturer,
	CASE
		WHEN name_product > 300 THEN 'lots'
		WHEN (product_count <= 300 AND product_count >= 100) THEN 'many'
		ELSE 'little'
	END AS state
FROM mobile_phones;



-- Задача 3
/*
Имеется таблица-справочник (сущность) производителей manufacturer.

У сущности имеются следующие поля(атрибуты):
	id – идентификатор;
	name – название.

Сущность manufacturer имеет следующие записи:
id	name
1	Apple
2	Samsung
3	Huawei

Создайте для сущности mobile_phones внешний ключ manufacturer_id (идентификатор производителя), направленный на атрибут id сущности manufacturer. 
Установите каскадное обновление - CASCADE, 
а при удалении записи из сущности manufacturer – SET NULL.

Используя CRUD-операцию UPDATE обновите данные 
в атрибуте manufacturer_id сущности mobile_phones согласно значений, 
имеющихся в атрибуте manufacturer.

Удалите атрибут manufacturer из сущности mobile_phones.
Выведите идентификатор, название и идентификатор производителя сущности mobile_phones.
*/


ALTER TABLE mobile_phones
ADD COLUMN manufacturer_id BIGINT;

ALTER TABLE mobile_phones
ADD FOREIGN KEY(manufacturer_id) REFERENCES manufacturer(id)
ON UPDATE CASCADE ON DELETE SET NULL;

UPDATE mobile_phones
SET manufacturer_id = (SELECT id FROM manufacturer WHERE mobile_phones.manufacturer = name);

ALTER TABLE mobile_phones
DROP COLUMN manufacturer;

SELECT id, product_name, manufacturer_id FROM manufacturer;



-- Задача 4
/*
Необходимо вывести идентификатор и подробное описание статуса заказа.
*/

