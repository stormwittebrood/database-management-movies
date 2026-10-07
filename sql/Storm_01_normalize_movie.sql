--GENRE
--Code 1 (normalizing genre) 
create table genre (
	genre_id serial primary key, --PK consisting of numbers
	genre_name varchar(255) unique not null --unique genre name (max 255 char)
);

--Code 2
insert into genre (genre_name) --insert into genre_name column of genre table
select distinct genre_split -- select each unique genre_split value where genre_split is a temporary alias used in line 4
from movie, --from dataset movie
	 string_to_table(genre, ',') as genre_split; --split genre column at each comma and call each result genre_split

--Code 3 (junction table movie_genre)
create table movie_genre ( --create junction table between movie and genre 
	genre_id int not null, --column1 is FK genre_id
	url text not null,	 --column2 is FK url 

	primary key(genre_id,url), --(composite) PK is unique combination of genre_id and url
	foreign key (genre_id) --FK genre_id from genre_id within genre table
		references genre(genre_id), 
	foreign key (url)	--FK url from url within movie table
		references movie(url)
);

--Code 4
insert into movie_genre (genre_id, url) --insert genre id and movie url into junction table
select distinct genre.genre_id, movie.url -- selecting the unique genre and movie combinations
from movie, -- from movie data
	 string_to_table(movie.genre,',') as genre_split --splitting the genres as temporary alias genre_split with "," as seperator
join genre  -- match the split genres with the genre table
	on genre_name = genre_split; --match when genre names are equal and retrieves the corresponding genre_id

--For checking purposes
----Code 5 (checking  difference in distinct entries to validate and check results. Only 20 movies don’t have a genre)
select count(distinct url) -- number of unique URLs in movie_genre (11344)
from movie_genre;

--Code 6
select count(distinct url) -- number of unique URLs in movie (11364)
from movie;

--Code 7
alter table movie -- drop genre from movies since it is not required anymore
drop column genre;

--ACTOR
--Code 8(Do exactly the same for actor as for genre)
create table actor (
	actor_id serial primary key, --PK consisting of numbers
	actor_name varchar(255) unique not null --unique actor name (max 255 char)
);

--Code 9
insert into actor (actor_name) --insert into actor_name column of actor table
select distinct actor_split -- select each unique actor_split value where actor_split is a temporary alias used in line 4
from movie, --from dataset movie
	 string_to_table(actors, ',') as actor_split; --split actor column at each comma and call each result actor_split

--Code 10
create table movie_actor ( --create junction table between movie and actor 
	actor_id int not null, --column1 is FK actor_id
	url text not null,	 --column2 is FK url 

	primary key(actor_id,url), --(composite) PK is unique combination of actor_id and url
	foreign key (actor_id) --FK actor_id from actor_id within actor table
		references actor(actor_id), 
	foreign key (url)	--FK url from url within movie table
		references movie(url) );

--Code 11
insert into movie_actor (actor_id, url) --insert actor id and movie url into junction table
select distinct actor.actor_id, movie.url -- selecting the unique actor and movie combinations
from movie, -- from movie data
	 string_to_table(movie.actors,',') as actor_split --splitting the actors as temporary alias actor_split with "," as seperator
join actor  -- match the split actors with the actor table
	on actor_name = actor_split; --match when actor names are equal and retrieves the corresponding actor_id

--For checking purposes
--Code 12 (3702 movies do not have an actor (11364-7662))
select count(distinct url) -- number of unique URLs in movie_actor (7662)
from movie_actor;

--Code 13
alter table movie -- drop actor from movies since it is not required anymore
drop column actors;


--AWARDS
--Code 14 (repeat everything again for awards)
create table award (
	award_id serial primary key, --PK consisting of numbers
	award_name text unique not null --unique award name 
);

--Code 15
insert into award (award_name) --insert into award_name column of award table
select distinct award_split -- select each unique award_split value where award_split is a temporary alias used in line 4
from movie, --from dataset movie
	 string_to_table(awards, ',') as award_split; --split award column at each comma and call each result award_split

--Code 16
create table movie_award ( --create junction table between movie and award 
	award_id int not null, --column1 is FK award_id
	url text not null,	 --column2 is FK url 

	primary key(award_id,url), --(composite) PK is unique combination of award_id and url
	foreign key (award_id) --FK award_id from award_id within award table
		references award(award_id), 
	foreign key (url)	--FK url from url within movie table
		references movie(url)
);

--Code 17
insert into movie_award (award_id, url) --insert award id and movie url into junction table
select distinct award.award_id, movie.url -- selecting the unique award and movie combinations
from movie, -- from movie data
	 string_to_table(movie.awards,',') as award_split --splitting the awards as temporary alias award_split with "," as seperator
join award  -- match the split awards with the award table
	on award_name = award_split; --match when award names are equal and retrieves the corresponding award_id

--For checking purposes
--Code 18 (6977 movies do not have award(11364-4387))
select count(distinct url) -- number of unique URLs in movie_award (4387)
from movie_award;

--Code 19
alter table movie -- drop award from movies since it is not required anymore
drop column awards;
