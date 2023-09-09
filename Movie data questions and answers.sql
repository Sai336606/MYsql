Create Database Movie;
use Movie;

select * from movie;

# 1.	Write a SQL query to find when the movie 'American Beauty' released. Return movie release year.
select mov_title,mov_year from movie where mov_title ='American Beauty';

# 2.	Write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title,mov_year from movie where mov_year <1998;

# 3. Write a query where it should contain all the data of the movies which were released after 1995 
#and their movie duration was greater than 120.
select * from movie where mov_year >1995 and mov_time >120;

# 4. Write a query to determine the Top 7 movies which were released in United Kingdom. 
# Sort the data in ascending order of the movie year.
select * from movie where mov_rel_country = 'UK' order by mov_year asc limit 7;

# 5.Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese 
# and the movie year was 2001.
select * from movie where mov_year=2001;

update movie
set mov_lang='Chinese'
where  mov_year=2001 and mov_lang='Japanese';

# 6.	Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'.
select * from reviewer;
select * from ratings;
select * from movie;

select r.rev_name,m.mov_title from reviewer r inner join ratings using(rev_id) inner join movie m using(mov_id) where mov_title ='slumdog Millionaire';

# 7. Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors.
select act_fname,act_lname,act_gender,c.role from cast c inner join actor using(act_id) where act_gender != 'M';

# 8.	Write a SQL query to find the actors who played a role in the movie 'Annie Hall'. 
# Fetch all the fields of actor table. (Hint: Use the IN operator).
select *,m.mov_title from actor inner join cast using(act_id) inner join movie m using(mov_id) where m.mov_title = 'Annie Hall';

# 9. Write a SQL query to find those movies that have been released in countries other than the United Kingdom. 
#Return movie title, movie year, movie time, and date of release, releasing country.
select mov_title,mov_year,mov_dt_rel,mov_rel_country from movie where mov_rel_country !='UK';

# 10. Print genre title, maximum movie duration and the count the number of movies in each genre. (HINT: By using inner join)
select g.gen_title,max(mov_time) as Max_Mov_duration, count(*) as Number_of_movies from genres g inner join movie_genres using(gen_id) inner join movie using(mov_id) group by gen_id;

# 11 .	Create a view which should contain the first name, last name, title of the movie & role played by particular actor.
create view actor_info as(select act_fname,act_lname,mov_title,role from cast inner join actor using(act_id) inner join movie using(mov_id));
select * from actor_info;

# 12.	Write a SQL query to find the movies with the lowest ratings
select * from ratings;
select mov_title,num_o_ratings from ratings inner join movie using(mov_id) order by num_o_ratings asc limit 1;












