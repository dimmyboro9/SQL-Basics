-- Write down the name of the team and the total number of fans in all seasons for that team. Sort the table in descending order of total number of fans.
/*
Categories:
G3 - Nested query in SELECT clause
I1 - Aggregate functions (count|sum|min|max|avg)
*/

select name, ( select sum(number_of_fans) as total_number_of_fans from fanbase f where f.id_club=cl.id_club  )
from club cl
order by ( select sum(number_of_fans) from fanbase f where f.id_club=cl.id_club  ) desc
