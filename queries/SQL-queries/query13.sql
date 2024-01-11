-- Choose all the players who played for the team "Strahov Dinosaurs" and had a salary of over 800000 (not necessarily in the same season).
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
H3 - Set intersection - INTERSECT
*/

select p.* 
from person p
join contract c using ( id_person )
where c.salary > 8000000
intersect
select p.*
from person p
join contract c using ( id_person )
join club cl using ( id_club )
where cl.name = 'Strahov Dinosaurs'
