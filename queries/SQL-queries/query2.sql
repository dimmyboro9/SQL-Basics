-- Write out all information about players, who had the contract with club "Real Stockholm" during season 2023, and their stats.
/*
Categories:
A - Positive query on at least two joined tables
F1 - JOIN ON
F2 - NATURAL JOIN|JOIN USING
*/

Select p.*, s.*
From person p 
Join stats s using ( id_person )
Join season ss using ( id_season )
Join contract c on c.id_person = s.id_person AND c.id_season = s.id_season
Join club cl on cl.id_club = c.id_club
Where ss.year=2023 AND cl.name='Real Stockholm';
