-- Write out the stats (only points, rebounds, assists, steals and blocks) of Jiri Hunka 
-- and Michal Valenta ( also write out their manes and surnames ) in the seasons in which they participate.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
*/

select name, surname, country, nickname, year, points, rebounds, assists, steals, blocks
from person 
join stats using ( id_person )
join season using ( id_season )
where ( name='Jiri' and surname='Hunka' ) or ( name='Michal' and surname='Valenta')
