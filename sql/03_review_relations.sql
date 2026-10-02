--Expert review relation
--(Combining Expert_review with movie)
alter table expert_review -- adjust something in expert_review dataset
add foreign key (url) -- FK url which references from movie dataset
references movie(url);
 
--(checking if the relation works)
select title, -- select columns to use
	   reviewer,
	   idvscore
from expert_review -- from expert_review dataset
join movie --get data from movie
	 on expert_review.url = movie.url --link the url's
limit 10; --limit 10

--User review relation
--(combining user_review with movie)
alter table user_review -- adjust something in user_review dataset
add foreign key (url) -- FK url which references movie dataset
references movie(url);

--(checking if the relation works)
select title, -- select columns to use
	   reviewer,
	   idvscore
from user_review -- from user_review dataset
join movie --get data from movie
	 on user_review.url = movie.url --link the url's
limit 10; --limit 10
