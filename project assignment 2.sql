select * from comments;
select * from follows;
select * from likes;
select * from photo_tags;
select * from photos;
select * from tags;
select * from users;
USE ig_clone;

-- 1.Create an ER diagram or draw a schema for the given database.
-- Ans. created a pdf of this .


-- 2.We want to reward the user who has been around the longest, Find the 5 oldest users.
select * from users;
-- ANS
select * from users ORDER BY created_at limit 5;

-- 3.To understand when to run the ad campaign, figure out the day of the week most users register on?
select * from users;
-- ANS
SELECT DAYOFWEEK("2017-06-15 09:34:21"); 

select dayname(created_at) as day ,
DAYOFWEEK(created_at) as days ,
date(created_at) as date ,
count(id) as users_registered
from users 
GROUP BY date
ORDER BY users_registered desc;

-- 4.To target inactive users in an email ad campaign, find the users who have never posted a photo.
select * from users;
select * from photos;
-- ANS
select * from users as u where exists (select * from photos as p where p.user_id=u.id);

select * from users as u where not exists (select * from photos as p where p.user_id=u.id);

select u.id as user_id,u.username,p.id as photos from users as u 
LEFT JOIN photos as p on p.user_id =u.id where p.id is null;

-- 5.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
select * from users;
select * from photos;
select * from likes;
-- ANS
select u.id,u.username as names,l.photo_id as photo_id ,p.image_url as images,count(l.user_id) as likes  from users as u 
INNER JOIN photos as p on u.id=p.user_id 
INNER JOIN likes as l on l.photo_id=p.id 
GROUP BY L.photo_id 
ORDER BY likes desc;

select (select u.username from users as u where u.id=l.user_id ) as usernames,photo_id,
count(user_id) as likes from likes as l 
GROUP BY photo_id 
ORDER BY likes desc;


-- 6.The investors want to know how many times does the average user post
select * from users;
select * from photos;
-- ANS
with cte as 
(select username,p.user_id, count(p.id) as counts  from users as u 
INNER JOIN photos as p on u.id = p.user_id 
GROUP BY p.user_id)
select ct.username,ct.user_id,ct.counts ,avg(counts) as average_user_post from cte as ct 
GROUP BY ct.user_id;

with cte as 
(select p.user_id,username, count(p.id) as counts  from users as u 
INNER JOIN photos as p on u.id = p.user_id 
GROUP BY p.user_id)
select round(avg(counts)) as average_user_post from cte as ct;

-- 7.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select * from photo_tags;
select * from tags;
-- ANS
-- with correlated query
select tag_id, count(tag_id)as counts ,(select tag_name from tags as t where t.id=pt.tag_id) as hashtags
from photo_tags as pt 
GROUP BY tag_id 
ORDER BY counts desc limit 5;

-- with inner join 
select t.id,t.tag_name as hashtags ,count(pt.tag_id) as counts from tags as t 
INNER JOIN photo_tags as pt on t.id=pt.tag_id 
GROUP BY hashtags
ORDER BY counts desc
limit 5;

-- 8.To find out if there are bots, find users who have liked every single photo on the site.
select * from users;
select * from likes;
-- ANS
select user_id,count(user_id) as counts,(select username from users as u where u.id=l.user_id) as names 
from likes as l
GROUP BY user_id 
HAVING counts = 257 
ORDER BY counts desc ;

-- this is for who have liked photos
select * from users as u where exists (select * from likes as l where u.id=l.user_id);
-- this is for who have not liked any photos
select * from users as u where not exists (select * from likes as l where u.id=l.user_id);

-- 9.To know who the celebrities are, find users who have never commented on a photo.
select * from comments;
select * from users;
-- ANS
select * from users as u where not exists (select * from comments as c where u.id=c.user_id);


-- 10.Now it's time to find both of them together, 
-- find the users who have never commented on any photo or have commented on every photo
select * from comments;
select * from users;
-- ANS
-- this is with who have not commented on any photo and who have commented on every photos.
with not_commented as 
(select * from users as u 
where not exists (select * from comments as c where u.id=c.user_id))
select * from not_commented
union
(select user_id,count(user_id) as counts,(select username from users as u where u.id=c.user_id) as names 
from comments as c
GROUP BY  user_id 
HAVING counts = 257 
ORDER BY counts desc);

-- this is with who have not commented on any photo and who have commented on photos.
with not_commented as 
(select * from users as u 
where not exists (select * from comments as c where u.id=c.user_id))
select * from not_commented
union
(select user_id,count(user_id) as counts,(select username from users as u where u.id=c.user_id) as names 
from comments as c
GROUP BY user_id 
ORDER BY counts desc) ;


with not_commented as 
(select * from users as u 
where not exists (select * from comments as c where u.id=c.user_id))
select * from not_commented;

with commented as 
(select user_id,count(user_id) as counts,(select username from users as u where u.id=c.user_id) as names 
from comments as c
group by user_id order by counts desc) 
select * from commented;









