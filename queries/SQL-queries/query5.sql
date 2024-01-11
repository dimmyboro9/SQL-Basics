-- Choose people, who have all their contracts only with club "DBS Portal" and any other.
/*
Categories:
C - Select only those related to...
F2 - NATURAL JOIN|JOIN USING
H2 - Set difference - MINUS or EXCEPT
*/

select p.* 
from person p
join contract c using ( id_person )
join club cl using ( id_club )
where ( cl.name = 'DBS Portal' )
except
select p.* 
from person p
join contract c using ( id_person )
join club cl using ( id_club )
where ( cl.name != 'DBS Portal' );
