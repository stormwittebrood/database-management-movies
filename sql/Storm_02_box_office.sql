--Box_office creation and cleaning
--Code 20 (create box_office)
create table box_office (
	year1 int,							   -- year, clean later to date with release_date (year1 because year is SQL language)
	release_date text,                     -- release_date, clean to date later
	title text,					   		   -- title (max 255 char)
	genre varchar(255),				  	   -- genre (max 255 char)
	international_box_office text,         -- international box office, clean to int later
    domestic_box_office text,              -- domestic box office, clean to int later
    worldwide_box_office text,             -- worldwide box office, clean to int later
    production_budget text,                -- production budget, clean to int later
    opening_weekend text,                  -- opening weekend revenue, clean to int later
    theatre_count text,                    -- theatre count, clean to int later
    avg_run_per_theatre text,              -- average run per theatre, clean to int later
    runtime text,                          -- runtime, clean to int later
    keywords text,                         -- movie keywords
    creative_type varchar(255),            -- creative type
    url text                               -- the numbers url
	
);
--Code 21
update box_office set title = lower(trim(title));

--Code 22 (replacing n/a with null)
update box_office -- for every code below: update box_office dataset
set international_box_office = null -- want null vallues instead of "n/a" text
where lower(trim(international_box_office)) = 'n/a'; -- lowering and trimming every n/a value and transfering to null

update box_office
set domestic_box_office = null
where lower(trim(domestic_box_office)) = 'n/a';

update box_office
set worldwide_box_office = null
where lower(trim(worldwide_box_office)) = 'n/a';

update box_office
set production_budget = null
where lower(trim(production_budget)) = 'n/a';

update box_office
set opening_weekend = null
where lower(trim(opening_weekend)) = 'n/a';

update box_office
set theatre_count = null
where lower(trim(theatre_count)) = 'n/a';

update box_office
set avg_run_per_theatre = null
where lower(trim(avg_run_per_theatre)) = 'n/a';

update box_office
set runtime = null
where lower(trim(runtime)) = 'n/a';

--Code 23 (now all values can be put into bigint or int)
alter table box_office --change something in box_office dataset

alter column international_box_office type bigint --change column to type bigint using bigint value type (int itself was not large enough)
	using international_box_office::numeric::bigint,
	
alter column domestic_box_office type bigint -- same for domestic
	using domestic_box_office::numeric::bigint,

alter column worldwide_box_office type bigint -- same for worldwide
	using worldwide_box_office::numeric::bigint,

alter column production_budget type bigint -- same for production
	using production_budget::numeric::bigint,

alter column opening_weekend type bigint -- same for opening_weekend
	using opening_weekend::numeric::bigint,

alter column theatre_count type int -- int instead of bigint due to smaller numbers
	using theatre_count::numeric::int,

alter column avg_run_per_theatre type int -- same as theatre_count
	using avg_run_per_theatre::numeric::int,
	
alter column runtime type int -- same as theatre_count
	using runtime::numeric::int;

--Link box_office to movie
--Code 24 (creating PK and FK for box_office)
alter table box_office -- add box_office_id as new serial primary key
add column box_office_id serial primary key,
add column movie_url text; --add movie_url which will take url from movie for the overlapping movies

--Code 25 (linking movie and box_office through url of movie table stored in box_office where title and release year match)
update box_office --change value in box_office
set movie_url = movie.url -- fill movie_url with url from movie table
from movie -- find the url from movie table
where box_office.title = movie.title -- give url to movie in box_office where titles match exactly
and box_office.year1 = extract(year from movie.release_date); -- AND the year of release is exactly the same (extract function used since release_date in movie table does not have year seperately stored)

--Code 26 (12 duplicate urls remain. Dropping these 12 almost empte rows wont affect total analysis 
delete from box_office a -- delete rows from box_office calling this a and comparing that with b
using box_office b -- using in this context means comparing box_office version a with box_office version b
where a.movie_url = b.movie_url -- for movies with the same movie_url in both versions of box_office a & b
and a.box_office_id > b.box_office_id; -- then delete the rows based on the version with a higher box_office_id 

--Code 27 (adding FK to movie_url in box_office the references to PK in movie)
alter table box_office --change in box_office
add foreign key (movie_url)   -- movie_url becomes a FK
references movie(url);    -- reference it to the PK url in movie

--Code 28 (drop and normalise columns)
alter table box_office
drop column year1,
drop column release_date,
drop column title,
drop column url,
drop column runtime,
drop column genre;
