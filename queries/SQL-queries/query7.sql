-- Find clubs that were in top 5 of the league more than once. Write out name of clubs, their biggest fanbases 
-- and amount of seasons they were in top 5 and sort them in descending order of their biggest fanbases.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
I1 - Aggregate functions (count|sum|min|max|avg)
I2 - Aggregate function over grouped rows - GROUP BY (HAVING)
K - All clauses in one query - SELECT FROM WHERE GROUP BY HAVING ORDER BY
*/

select name, max(number_of_fans) as maximal_number_of_fans, count ( distinct year ) as top5_count
from club c
join team t using ( id_club )
join season s using ( id_season )
join fanbase f using ( id_club, id_season )
where place < 5
group by name, id_club
having count( distinct year ) > 1
order by max(number_of_fans) desc
