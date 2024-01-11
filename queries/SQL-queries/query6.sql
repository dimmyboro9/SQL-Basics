-- Write out the highest number of points per season every Ukrainian player had during his career.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
G3 - Nested query in SELECT clause
I1 - Aggregate functions (count|sum|min|max|avg)
I2 - Aggregate function over grouped rows - GROUP BY (HAVING)
*/

select distinct name, surname, 
( select max(points) as max_points_per_season from stats s where s.id_person = p.id_person )
from person p
join contract c using ( id_person )
where country = 'Ukraine' and id_type = 1;

select name, surname, max(points) as max_points_per_season 
from stats s 
natural join person p
where s.id_person = p.id_person and country ='Ukraine'
group by id_person, name, surname
