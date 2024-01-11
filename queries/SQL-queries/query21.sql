-- Write out the names of the clubs that set records and the names of these records.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
*/

select r.name as record_name, c.name as club_name
from record r
join club c using ( id_club )
