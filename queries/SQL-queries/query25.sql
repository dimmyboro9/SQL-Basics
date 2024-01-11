-- Write out the name and surname of person, who is taller than 215 cm and all names of clubs, with which this player had contracts. 
-- If person had no contract, write HAS NO CONTRACT in column club, if club had never a contract with such people, 
-- write NO PLAYERS HIGNER THAN 215 CM in columns name and surname.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
F4 - LEFT|RIGHT OUTER JOIN
F5 - FULL (OUTER) JOIN
G2 - Nested query in FROM clause
*/

select coalesce ( ht.name, 'NO PLAYERS HIGNER THAN 215 CM') as name, 
coalesce ( ht.surname, 'NO PLAYERS HIGNER THAN 215 CM') as surname,
coalesce ( cl.name, 'HAS NO CONTRACT' ) as club
from 
( 
    select *
    from person p
    left join contract c using ( id_person )
    where p.height > 215
) as ht
full outer join club cl using ( id_club )
