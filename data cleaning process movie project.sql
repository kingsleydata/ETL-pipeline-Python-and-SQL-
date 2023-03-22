select *
from raw_movie_table
order by index 

--Removing unwanted statements in rows
select replace("author", 'Writtenby:', '')
from raw_movie_table

update raw_movie_table
set "author" = replace("author", 'Writtenby:', '')

update raw_movie_table
set "narrator" = replace("narrator", 'Narratedby:', '')

update raw_movie_table
set "releasedate" = to_date("releasedate", 'dd-mm-yyyy')

--Converting releasedate column from text data type to date data type
alter table raw_movie_table
alter column "releasedate" type date
using "releasedate"::date

select split_part("stars", 'out of 5 stars', '1')
from raw_movie_table
where "stars" != 'Not rated yet'

--adding new column to star rating
alter table raw_movie_table
add column "stars_awarded" text

--adding new column for number of ratings
alter table raw_movie_table
add column "number_of_ratings" text

--Implement
update raw_movie_table
set "stars_awarded" = split_part("stars", 'out of 5 stars', '1')
where "stars" != 'Not rated yet'

update raw_movie_table
set "number_of_ratings" = split_part("stars", 'out of 5 stars', '2')
where "stars" != 'Not rated yet'

select split_part("stars", 'out of 5 stars', '2')
from raw_movie_table
where "stars" != 'Not rated yet'


alter table raw_movie_table
add column "time_hours" text

alter table raw_movie_table
add column "time_mins" text

update raw_movie_table
set "time_hours" = split_part("time", 'and', '1')

update raw_movie_table
set "time_mins" = split_part("time", 'and', '2')


--Converting price column from text data type to float data type
alter table raw_movie_table
alter column "price" type float
using "price"::float

select "index", "price"
from raw_movie_table
where "price" !~ '^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$'
--With code above we discovered some columns which rows having non-numeric 
--characters, hereby we need to remove them becuase withut removing them
--the price column cannot be converted to a float data type

select "index", replace("price", ',', '')
from raw_movie_table
order by "index"

--Implement
--Replacing rows having , with nothing
update raw_movie_table
set "price" = replace("price", ',', '')


--We also discovered that some rows have the word "Free" in the "price" column 
--Lets remove this

select "index", replace("price", 'Free', '0')
from raw_movie_table
order by "index"

update raw_movie_table
set "price" = replace("price", 'Free', '0')

--Now that we have removed all contradicting rows, lets convert the price colm=umn 
--to float

--Converting price column from text to float
alter table raw_movie_table
alter column "price" type float
using "price"::float

select *
from raw_movie_table
order by index

--Converting stars_awarded column from text data type to float data type
alter table raw_movie_table
alter column "stars_awarded" type float
using "stars_awarded"::float

--Now lets remove the word 'ratings' in the "number_of_ratings" column and then 
--convert to an integer column

update raw_movie_table
set "number_of_ratings" = replace("number_of_ratings", 'ratings', '')

--Discovered some rows have the word rating, lets replace with nothing
update raw_movie_table
set "number_of_ratings" = replace("number_of_ratings", 'rating', '')

--Discovered some rows have the ",". Lets replace with nothing
update raw_movie_table
set "number_of_ratings" = replace("number_of_ratings", ',', '')

alter table raw_movie_table
alter column "number_of_ratings" type integer
using "number_of_ratings"::integer


--Final view of all columns and moving on to the next step
select *
from raw_movie_table
order by "index"


--Confirming there are no duplicate values
select "name", "author", "narrator", "time", "releasedate", "language", "stars",
"price", "stars_awarded", "number_of_ratings"
from raw_movie_table
group by "name", "author", "narrator", "time", "releasedate", "language", "stars",
"price", "stars_awarded", "number_of_ratings"
having count(*) > 1



