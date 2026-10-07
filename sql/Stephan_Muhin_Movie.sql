Create table movie(
url text primary key, --pk is url
title varchar (255), -- title is max 255 char
studio varchar (255), -- studio is max 255 char
rating varchar (50), -- rating is max 50 char
runtime int, -- turns runtime into a integer
actors text, -- actors put down as text
director varchar (255), -- director is max 255 char
genre text, -- puts genre as text
summary text, -- summary as text 
awards text, -- awards as text
metascore int, -- turns metascore into a integer
userscore text, -- for the import/ will be changed
RelDate text -- RelDate as text for import
);

COPY movie FROM '/tmp/movie_utf8.csv'
DELIMITER ';'
CSV HEADER;
-- importing the database

UPDATE movie
set rating = trim(replace(rating, '| ', ''));
-- cleanes rating so you only see the rating no addition char

SELECT DISTINCT rating FROM movie;

update movie
set rating = 'PG-13'
where rating = 'PG-13`';

update movie
set rating = 'Not Rated'
where rating = 'Unrated' or rating = 'NR'
-- cleaning the rating column to fit al to 'Not Rated'

SELECT DISTINCT rating FROM movie;

UPDATE movie
SET userscore = REPLACE(userscore, ',', '.');
-- comma is being changed to p

ALTER TABLE movie
ALTER COLUMN userscore TYPE numeric(4,2)
USING userscore::numeric(4,2);

-- altering the column the type of userscore to numbers with 4 total numbers, 2 befor and behind the comma

SELECT userscore FROM movie LIMIT 10;

ALTER TABLE movie
ALTER COLUMN RelDate TYPE date
USING TO_DATE(RelDate, 'DD/MM/YYYY');
-- alters the column data from tekst to date, to reverse the import

SELECT RelDate FROM movie LIMIT 10;

SELECT COUNT(*) FROM movie;
-- how many rows are there??

SELECT COUNT(*) FROM movie
WHERE director IS NULL;
-- rows without any director??

SELECT * FROM movie LIMIT 10;

SELECT DISTINCT rating FROM movie;

Create table director (
director_id serial primary key, 
director_name varchar(255)
);
-- creates the director table and sets primary key, limits char

Insert into director (director_name)
Select distinct director from movie
where director is not null;
-- inserts data to the tabel, that is unique and and scraping null


Create table rating (
rating_id serial primary key, 
rating_name varchar(255)
);
-- creates the rating table and sets primary key, limits char

Insert into rating (rating_name)
Select distinct rating from movie
where rating is not null;
-- inserts data to the tabel, that is unique and and scraping null

Create table studio (
studio_id serial primary key, 
studio_name varchar(255)
);
-- creates the studio table and sets primary key, limits char

Insert into studio (studio_name)
Select distinct studio from movie
where studio is not null;
-- inserts data to the tabel, that is unique and and scraping null

Create table summary (
summary_id serial primary key, 
summary_name text
);
-- creates the summary table and sets primary key, limits char

Insert into summary (summary_name)
Select distinct summary from movie
where summary is not null;
-- inserts data to the tabel, that is unique and and scraping null

alter table movie add column director_id int;
update movie
set director_id= director.director_id
from director
where movie.director= director.director_name;
-- creating correct names so foreign key creation is possible

Alter table movie 
add constraint fk_director
foreign key (director_id)
references director(director_id)
--creating foreign key for the director table

alter table movie add column rating_id int;
update movie
set rating_id= rating.rating_id
from rating
where movie.rating= rating.rating_name;
-- creating correct names so foreign key creation is possible

Alter table movie 
add constraint fk_rating
foreign key (rating_id)
references rating (rating_id)
--creating foreign key for the rating table

alter table movie add column studio_id int;
update movie
set studio_id= studio.studio_id
from studio
where movie.studio= studio.studio_name;
-- creating correct names so foreign key creation is possible

Alter table movie 
add constraint fk_studio
foreign key (studio_id)
references studio (studio_id)
--creating foreign key for the studio table

alter table movie add column summary_id int;
update movie
set summary_id= summary.summary_id
from summary
where movie.summary= summary.summary_name;
-- creating correct names so foreign key creation is possible

Alter table movie 
add constraint fk_summary
foreign key (summary_id)
references summary (summary_id)
--creating foreign key for the summary table

Alter table movie
drop column director, 
drop column rating, 
drop column studio, 
drop column summary;
-- droping the unnecessary column from the movie table to match the ERD
