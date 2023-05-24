use moviedb;
select * from actors;
select * from movie;
select * from movie_cast;

select mov_id from movie where mov_title = 'Annie Hall' ;
select act_id from movie_cast where mov_id = 911;
select act_fname , act_lname from actors where act_id = 111;

---- 1. Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.

select a.act_fname , a.act_lname ,mc.role from actors as a inner join movie_cast as mc 
on mc.act_id = a.act_id inner join movie as m on m.mov_id = mc.mov_id where mov_title = 'Annie Hall';

select a.* , mc.* from actors as a inner join movie_cast as mc 
on mc.act_id = a.act_id inner join movie as m on m.mov_id = mc.mov_id where mov_title = 'Annie Hall';


select * from director;
select * from movie_direction;
select * from movie_cast;
select * from movie ;

----2. From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'.
 Return director first name, last name and movie title.


select d.dir_fname, d.dir_lname, m.mov_title from director as d inner join movie_direction as md 
on d.dir_id = md.dir_id inner join movie as m on m.mov_id = md.mov_id where mov_title  = 'Eyes Wide Shut';

select * from director;
select * from movie_direction;
select * from movie_cast;
select * from movie ;

---- 3. Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. 
Return director first name, last name and movie title.


select d.dir_fname , d.dir_lname, m.mov_title  from director as d inner join movie_direction as md
on d.dir_id = md. dir_id inner join movie as m on m.mov_id = md.mov_id inner join movie_cast as mc on mc.mov_id = m.mov_id
where role = 'Sean Maguire';

select * from actors;
select * from movie;
select * from movie_cast;
select * from 


---- 4. Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.).
 Return actor first name, last name, movie title and release year.
 
 select a.act_fname , a.act_lname , m.mov_title, m.mov_year from actors as a inner join movie_cast as mc on a.act_id = mc.act_id 
 inner join movie as m on m.mov_id = mc.mov_id where mov_year not between 1990 and 2000;
 
 select * from director;
 select * from genres;
 select * from movie;
 select * from movie_genres;
 select * from movie_direction;
 
 
 ----5. Write a SQL query to find the directors with the number of genres of movies. Group the result set on director 
 first name, last name and generic title. Sort the result-set in ascending order by director first name and last name. 
 Return director first name, last name and number of genres of movies.
 
 select d.dir_fname, d.dir_lname, g.gen_title, count(gen_title) from director as d inner join movie_direction as md on d.dir_id = md.dir_id
 inner join movie_genres as mg on mg.mov_id = md.mov_id inner join genres as g on g.gen_id = mg.gen_id 
 group by d.dir_fname , d.dir_lname, g.gen_title order by d.dir_fname , d.dir_lname ;
 
 
 
 
 