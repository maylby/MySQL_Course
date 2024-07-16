/*
Базы данных и SQL (семинары)
Урок 2. SQL – создание объектов, простые запросы выборки
https://gb.ru/lessons/441876



В таблице имеются следующие атрибуты:
id -- уникальный идентификатор фильма,
title -- название фильма
title_eng -- название фильма на английском языке
year_movie  --  год выхода
count_min -- длительность фильма в минутах
storyline -- сюжетная линия, небольшое описание фильма
Все поля (кроме title_eng, count_min и storyline) обязательны для заполнения. 
Поле id : первичный ключ, который заполняется автоматически.
*/

USE lesson_1;
CREATE TABLE movies
(
	-- id INT PRIMARY KEY AUTO_INCREMENT,
    id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
					|	|	|	|		|_-- Уникальный (???)
					|	|	|	|_-- Авто присвоение id
					|	|	|_-- Не нулевой
					|	|_-- Брать, только положительную часть "BIGINT"
					|_-- Расширенный "integer" (64 бита, от -9 до 9 млрд.)
    title VARCHAR(60) NOT NULL,
    title_eng VARCHAR(60),
    year_movie YEAR NOT NULL,
    count_min INT,
    storyline TEXT
);