-- Let's imagine that we want to change the rules of our game. Now all existing clubs take part in every season. 
-- How many total teams would be in our database. ( Team is a club that takes part in one particular season ).
/*
Categories:
F3 - CROSS JOIN
I1 - Aggregate functions (count|sum|min|max|avg)
*/

select count(*) as amount_of_teams
from season cross join club
