select *
from raw_movie_table
order by "id"

--Creating a duplicate table incase needed
create table raw_movie_table_2 as
table raw_movie_table

--Lets look at the table
select *
from public.facts_table_ratings
order by "id"

--alter data types when needed
alter table raw_movie_table
alter column "index" type integer
using "index"::integer

--NOW LETS LOAD DATA INTO THE DATABASE TABLES, I ENSURE TO LOAD THE DIMENSION TABLES
--FIRST BEFORE LOADING THE FACT TABLE

--inserting data into tables
insert into public.movie_table
select "id", "name"
from raw_movie_table

--Check table you just loaded data into
select *
from public.movie_table
order by "movie_id"


--inserting data into tables
insert into public.author_table
select "id", "author"
from raw_movie_table


--inserting data into tables
insert into public.narrator
select "id", "narrator"
from raw_movie_table

--Lets insert data into the necessary tables
insert into public.facts_table_ratings
select "id", "releasedate", "stars_awarded", "number_of_ratings", "price", "id", "id","id"
from raw_movie_table

--Lets use a join query to confirm all tables are related
select mt.movie_id, ft.price, aat.author_id, na.narrator_id
from "movie_table" mt
join public.facts_table_ratings ft
on mt.movie_id = ft.movie_id
join "author_table" aat
on aat.author_id = ft.author_id
join "narrator" na
on ft.narrator_id = na.narrator_id


insert into public.facts_table_ratings ("narrator_id")
select "id"
from raw_movie_table
where "id" is null








select *
from raw_movie_table
order by "id"

select mt."movie_name", ft."number_of_ratings", ft."price"
from "movie_table" mt
join "facts_table_ratings" ft
on mt.movie_id = ft.movie_id
where "number_of_ratings" is not null
order by "number_of_ratings" asc

select mt."movie_name", ft."number_of_ratings", ft."price"
from "movie_table" mt
join "facts_table_ratings" ft
on mt.movie_id = ft.movie_id
where "number_of_ratings" is not null
order by "number_of_ratings" desc


select mt."movie_name", aat."author_name"
from public.movie_table mt
join public.author_table aat
on mt.movie_id = aat.author_id
join public.fact_table_ratings ftr
on aat.author_id = ftr.author_id
order by "price" asc


truncate table facts_table_ratings


truncate table movie_table cascade

truncate table author_table cascade

truncate table narrator cascade



alter table raw_movie_table
add column id serial primary key 


select *
from raw_movie_table





