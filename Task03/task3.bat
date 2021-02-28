#!/bin/bash
chcp 65001

sqlite3 movies_rating.db<db_init.sql

echo 1. Составить список фильмов, имеющих хотя бы одну оценку. Список фильмов отсортировать по году выпуска и по названиям. В списке оставить первые 10 фильмов.
echo --------------------------------------------------
sqlite3 movies_rating.db -box echo "select distinct m.id, m.title, m.genres from movies m join ratings r on m.id = r.movie_id order by year, title limit 10;"
echo " "

echo 2. Вывести список всех пользователей, фамилии (не имена!) которых начинаются на букву 'A'. Полученный список отсортировать по дате регистрации. В списке оставить первых 5 пользователей.
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select * from users where name like '\% A\%' order by register_date limit 5;"
echo " "

echo 3. Написать запрос, возвращающий информацию о рейтингах в более читаемом формате: имя и фамилия эксперта, название фильма, год выпуска, оценка и дата оценки в формате ГГГГ-ММ-ДД. Отсортировать данные по имени эксперта, затем названию фильма и оценке. В списке оставить первые 50 записей.
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select substr(u.name, 0, instr(name, ' ')) as first_name, substr(u.name, instr(name, ' ') + ;"
echo " "

echo 4. Вывести список фильмов с указанием тегов, которые были им присвоены пользователями. Сортировать по году выпуска, затем по названию фильма, затем по тегу. В списке оставить первые 40 записей.
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT movies.id, title, year, genres, tag FROM movies, tags WHERE (tags.movie_id=movies.id) ORDER BY year, title, tag LIMIT 40;"
echo " "

echo 5. Вывести список самых свежих фильмов. В список должны войти все фильмы последнего года выпуска, имеющиеся в базе данных. Запрос должен быть универсальным, не зависящим от исходных данных (нужный год выпуска должен определяться в запросе, а не жестко задаваться).
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "SELECT movies.id, title, year, genres FROM movies GROUP BY movies.id HAVING year = (SELECT MAX(year) FROM movies);"