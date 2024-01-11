-- Choose the club with the highest number of fans in history. 
-- Write out the name of the club, year, when it had the biggest fanbase, number of fans and average ticket price during this year.
/*
Categories:
A - Positive query on at least two joined tables
F2 - NATURAL JOIN|JOIN USING
*/

select cl.name, s.year, number_of_fans, average_ticket_price
from club cl
join fanbase f using ( id_club )
join season s using ( id_season )
join team t using ( id_season, id_club )
join stadium st using ( id_stadium )
join prices p using ( id_stadium )
order by number_of_fans desc
limit 1;
