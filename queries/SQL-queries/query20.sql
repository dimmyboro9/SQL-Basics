-- Write out the city where Batz LLC Stadium is located.
/*
Categories:
A - Positive query on at least two joined tables
*/

select city
from stadium s
join location l on ( s.id_stadium=l.id_stadium )
where name = 'Batz LLC Stadium'
