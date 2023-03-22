select "movie_name", max("number_of_ratings")
from "movie_table" mt
inner join "facts_table_ratings"
on mt."movie_id" = mt."movie_id"
group by "movie_name"
limit 10

select aat."author_id", aat."author_name", sum("number_of_ratings")
from "author_table" aat
join "facts_table_ratings" ft
on aat."author_id" = ft."author_id"
where "number_of_ratings" is not null
group by aat."author_id", aat."author_name", ft."number_of_ratings"
order by "number_of_ratings" desc
limit 5

select aat."author_id", aat."author_name", count("stars_awarded")
from  "author_table" aat
join "facts_table_ratings" ft
on aat."author_id" = ft."author_id"
where "stars_awarded" = 5
group by aat."author_id", aat."author_name", ft."stars_awarded"
order by count("stars_awarded") desc
limit 5

