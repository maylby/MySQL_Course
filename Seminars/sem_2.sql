/*
Базы данных и SQL (семинары)
Урок 2. SQL – создание объектов, простые запросы выборки
https://gb.ru/lessons/441876


Создать таблицу с подборкой фильмов. 
Связать ключом с произвольной табличкой.

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
					|	|	|	|		|__-- Уникальный (???)
					|	|	|	|__-- Авто присвоение id
					|	|	|__-- Не нулевой
					|	|__-- Брать, только положительную часть "BIGINT"
					|__-- Расширенный "integer" (64 бита, от -9 до 9 млрд.) 
                    
    title VARCHAR(60) NOT NULL,
    title_eng VARCHAR(60),
    year_movie YEAR NOT NULL,
    count_min INT,
    storyline TEXT
);


-- наполнение данными 
INSERT INTO movies (title, title_eng, year_movie, count_min, storyline)
VALUES 
('Игры разума', 'A Beautiful Mind', 2001, 135, 'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
('Иван Васильевич меняет профессию', NULL, 1998, 128,'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);

SELECT * FROM movies;



CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE actors (
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100)
);

/*
1 Переименовать сущность movies в cinema.
2 Добавить сущности cinema новый атрибут status_active (тип BOOL) и атрибут genre_id после атрибута title_eng.
3 Удалить атрибут status_active сущности cinema. 
4 Удалить сущность actors из базы данных
5 Добавить внешний ключ на атрибут genre_id сущности cinema и направить его на атрибут id сущности genres.
6 Очистить сущность genres от данных.
*/

-- 1
RENAME TABLE movies TO cinema; -- ПЕРЕИМЕНОВАТЬ ТАБЛИЦУ "movies" НА "cinema"

-- 2
ALTER TABLE cinema -- ИЗМЕНИТЬ ТАБЛИЦУ "cinema"
ADD COLUMN status_active BOOL DEFAULT True; -- ДОБАВИТЬ СТОЛБЕЦ "status_active" ПО УМОЛЧАНИЮ "True" (=1)

ALTER TABLE cinema
ADD COLUMN genre_id BIGINT UNSIGNED AFTER title_eng; /* ДОБАВИТЬ СТОЛБЕЦ "genre_id", 
							связанный с полем "id", т.е.  
							имеющий тот же тип данных "BIGINT UNSIGNED",
							внести ИЗМЕНЕНИЕ после поля "title_eng" */
-- 3
ALTER TABLE cinema
DROP COLUMN status_active; -- УДАЛИТЬ СТОЛБЕЦ "status_active"

-- 4
DROP TABLE actors; -- УДАЛИТЬ ТАБЛИЦУ "actors" 
                    /* Атрибут "DROP" используют для удаления сущностей
					(таблицы, столбцы, функции и пр.) */

-- 5
ALTER TABLE cinema -- ИЗМЕНИТЬ ТАБЛИЦУ "cinema"
ADD FOREIGN KEY(genre_id) REFERENCES genres(id); /* ДОБАВИТЬ ВНЕШНИЙ КЛЮЧ (genre_id), который 
						    ССЫЛАЕТСЯ на таблицу "genres", столбец "id" */

SHOW CREATE TABLE cinema;


-- 6 Очистить сущность genres от данных.
TRUNCATE TABLE genres;

ALTER TABLE cinema
DROP FOREIGN KEY cinema_ibfk_1; /* Имя внешнего ключа ищем командой "SHOW CREATE TABLE [имя_таблицы]",
				   во вкладке "Forms Editor" выведенной таблицы  
				   (см. скриншот 09_(С-02)_01-04-07_CONSTRAINT) */

ALTER TABLE cinema
ADD FOREIGN KEY(genre_id) REFERENCES genres(id)
ON DELETE SET NULL;
-- ON DELETE CASCADE;

TRUNCATE TABLE genres; /* "TRUNCATE" не применим для связанных таблиц, 
			  в данном случае, "genres" и "cinema", т.е.
			  предварительно нужно удалить внешний ключ командой "DROP FOREIGN KEY",
			  отлько потом вызывать команду усечения "TRUNCATE" */

ALTER TABLE cinema
DROP FOREIGN KEY cinema_ibfk_1;

TRUNCATE TABLE genres;

DELETE FROM genres -- "DELETE" - аналог "TRUNCATE", но работает медленнее (есть отличия?)  
WHERE 1=1; /* Всё равно "True". Добавление "1=1" к команде "DELETE" обходит ограничение в MySQL 
	      на удаление пустой таблицы (так объяснено лектором на семинаре).  
	      Т.е., таблицы, в которой не прописаны значения, т.е. стоит NULL, 
	      или на которую ссылается внешний ключ, ввиду чего таблицу нельзя удалить
	      без предварительного предварительного удаления связей (внешних ключей)??? */



CREATE TABLE studentMarks (
    stud_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total_marks INT,
    grade VARCHAR(5));

INSERT INTO studentMarks(total_marks, grade)
VALUES
(450, 'A'),
(480, 'A+'),
(490, 'A++'),
(440, 'B+'),
(400, 'C+'),
(380, 'C'),
(250, 'D'),
(200, 'E'),
(100, 'F'),
(150, 'F'),
(220, 'E');

SELECT * FROM studentMarks; -- Просмотр данных созданной таблицы

/*
Задача 3. В зависимости от поля “grade”, установите еще один столбец с именем class в 
зависимости от значений: A++ – DISTINCTION,A+ – FIRST CLASS, A – SECOND CLASS, B+ – SECOND CLASS,
 C+ – THIRD CLASS, ALL OTHERS – FAIL 
*/

