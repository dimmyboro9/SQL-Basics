# SQL-Basics
There is a repository containing my SQL project and shows my experience in working with relational databases. I created it during my studies at FIT CTU.

## Project description
This project shows the beginning of my introduction to **SQL**. In it, I attempted to manually create a database, fill it with data, and then interact with it using queries. In this repository, you will find the following folders: 
* `scripts`, containing **createscript** and **insertscript**, 
* `schemes`, housing conceptual and relational diagrams,
* `queries`, where a substantial number of **SQL** queries are written (some of them are also written using relational algebra).

Below is a more detailed description of the database I tried to create.

Basketball is a world famous game which unites hundreds of millions people. There is an NBA in North America, but we don't have a good alternative in Europe, so the best solution, how to solve this problem, is create this **League**.  But we want to create a long-term project, so there will be many **Seasons** and we will keep all the necessary information about each of them.

There will be amount of different **Clubs** from different cities and even countries. But in one season may participate only 16 **Teams**. It means, that the club must field a team to participate in the season and there will be clubs, that didn't create team for some season. Each team registers the **Stadium** in which it will play mathces. It is important to understand that the stadium doesn't belong to the teams, they only rent them. Every stadium is situated somewhere and sells tickets, so we will save this information too in entities **Location** and **Prices**. Each team also has its own **Fanbase**. And it is very important to khow some basic information about your fans like average age and most popular nationality.

Of course, our league isn't possible without **People**.  So there will be players, staff, employees and comissioners. Everyone has his own role and we are interested in different information about each of them. Everyone also must have **Contracts** whether with the league or with a club.  Evidently players don't play their whole lives on the same team, so they may change clubs and sign contracts with others. In addition, a player can become a coach or even a comissioner after his career ends. It isn't forbidden. 

Every player want to know how good is he, so he must be able to view his **Stats** like points, rebounds, assists, steals and blocks. Every league also has his own **Records** and we won't be an exception, because everybody likes records.
