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