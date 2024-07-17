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

