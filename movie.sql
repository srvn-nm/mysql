create table Movie(mID int, title text, year int, director text);
create table Reviewer(rID int, name text);
create table Rating(rID int, mID int, stars int, ratingDate date);
insert into Movie values(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');
insert into Movie values(103, 'The Sound of Music', 1965, 'Robert Wise');
insert into Movie values(104, 'E.T.', 1982, 'Steven Spielberg');
insert into Reviewer values(207, 'James Cameron');
insert into Reviewer values(208, 'Ashley White');
insert into Reviewer values(205, 'Chris Jackson');
insert into Reviewer values(201, 'Sarah Martinez');
insert into Reviewer values(202, 'Daniel Lewis');
insert into Rating values(202, 106, 4, null);
insert into Rating values(203, 103, 2, '2011-01-20');
insert into Rating values(203, 108, 4, '2011-01-12');
insert into Rating values(203, 108, 2, '2011-01-30');
insert into Rating values(204, 101, 3, '2011-01-09');
insert into Rating values(205, 103, 3, '2011-01-27');
insert into Rating values(205, 104, 2, '2011-01-22');
insert into Rating values(205, 108, 4, null);
#Q1
Select  tile
From Movie
Where director = 'Steven Spielberg';
#Q2
Select year
From Movie 
Where mID in (Select mID From Rating Where stars = '4' or stars = '5')
order by year;
#Q3
Select title 
From Movie, Rating 
Where Movie.mID = Rating.mID and Rating.stars is Null;
#Q4
Select name 
From Reviewer, Rating 
Where Reviewer.rID = Rating.rID and ratingDate is null;
#Q5
Select name, title, stars, ratingDate
From Reviewer, Movie, Rating
Where Movie.mID = Rating.mID and Reviewer.rID = Rating.rID
Order by name, title, stars;
#Q6
select name, title 
from Reviewer, Movie, Rating, Rating r2
where Rating.mID=Movie.mID and Reviewer.rID = Rating.rID and Rating.rID = r2.rID and r2.mID = Movie.mID and Rating.stars < r2.stars and Rating.ratingDate < r2.ratingDate
GROUP BY name, title
having count(*) = 1;
#Q7
Select title, stars From Movie, Rating
Where Movie.mID = Rating.mID
Group by Rating.mID 
having max(stars)
order by title;
#Q8
select t1.average - t2.average
from (select avg(s) as average
		from (select avg(stars) as s, mID 
			from Rating, Movie 
			where year < '1980' and Rating.mID = Movie.mID
			group by mID
			)  
		) t1,
	  (select avg(s) as average
	  	from (select avg(stars) as s, mID
	  		from Rating, Movie
	  		where year > '1980' and Rating.mID = Movie.mID
	  		group by mID
	  		)
		) t2;
