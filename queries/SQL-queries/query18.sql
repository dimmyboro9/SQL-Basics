-- League has a new commissioner. He decided that it was unfair that the minimum ticket price for some games was higher than for others. 
-- So he introduced new rules, where the lowest ticket prices in all stadiums would be the same and equal to the current league average. 
-- Update this information in database.
/*
Categories:
I1 - Aggregate functions (count|sum|min|max|avg)
O - UPDATE with nested SELECT statement
*/

begin;

select *
from prices;

update prices
set lowest_ticket_price = ( select avg(lowest_ticket_price) from prices );

select *
from prices;

rollback;
