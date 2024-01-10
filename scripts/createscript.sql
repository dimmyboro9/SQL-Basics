-- Remove conflicting tables
DROP TABLE IF EXISTS club CASCADE;
DROP TABLE IF EXISTS contract CASCADE;
DROP TABLE IF EXISTS fanbase CASCADE;
DROP TABLE IF EXISTS game CASCADE;
DROP TABLE IF EXISTS league CASCADE;
DROP TABLE IF EXISTS location CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS prices CASCADE;
DROP TABLE IF EXISTS record CASCADE;
DROP TABLE IF EXISTS season CASCADE;
DROP TABLE IF EXISTS stadium CASCADE;
DROP TABLE IF EXISTS stats CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS type CASCADE;
DROP TABLE IF EXISTS season_contract CASCADE;
DROP TABLE IF EXISTS team_game CASCADE;
DROP FUNCTION IF EXISTS player_age(idx_person INTEGER, first_season INTEGER) CASCADE;
DROP FUNCTION IF EXISTS amount_of_teams(season INTEGER) CASCADE;
DROP FUNCTION IF EXISTS players_in_team(idx_club INTEGER, idx_season INTEGER) CASCADE;
DROP FUNCTION IF EXISTS which_place ( idx_club DECIMAL(2, 0), idx_season INTEGER) CASCADE;
-- End of removing

CREATE TABLE club (
    id_club SERIAL NOT NULL,
    league_name VARCHAR(64) NOT NULL,
    name VARCHAR(64) NOT NULL,
    year_of_foundation INTEGER NOT NULL,
    year_of_discontinuance INTEGER,
    check ( year_of_foundation >= 1980 AND year_of_foundation <= 2040 ),
    check ( year_of_discontinuance >= 1980 AND year_of_discontinuance <= 2040 ),
    check ( year_of_foundation < year_of_discontinuance )
);
ALTER TABLE club ADD CONSTRAINT pk_club PRIMARY KEY (id_club);

CREATE FUNCTION
    player_age ( idx_person INTEGER, idx_season INTEGER )
    RETURNS BOOLEAN AS
$$
DECLARE
    birthday_year INTEGER;
    season_year INTEGER;
BEGIN
    SELECT year_of_birthday into birthday_year
    FROM person
    WHERE id_person=idx_person;
    SELECT year into season_year
    FROM season
    WHERE  id_season=idx_season;
    RETURN season_year-birthday_year < 40 AND season_year-birthday_year > 18;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION
    players_in_team ( idx_club INTEGER, idx_season INTEGER )
    RETURNS BOOLEAN AS
$$
DECLARE
    amount_of_players INTEGER;
BEGIN
    SELECT count(*) into amount_of_players
    FROM contract
    WHERE id_season=idx_season AND id_club=idx_club AND id_type = 1;
    RETURN amount_of_players < 15;
END;
$$ LANGUAGE 'plpgsql';

CREATE TABLE contract (
    id_person INTEGER NOT NULL,
    id_season INTEGER NOT NULL,
    id_club INTEGER,
    league_name VARCHAR(64),
    id_type INTEGER NOT NULL,
    salary INTEGER,
    check ( salary >= 150000 AND salary <= 10000000 ),
    check ( id_type != 1 OR player_age ( id_person, id_season  )),
    check ( id_type != 1 OR salary IS NOT NULL ),
    check ( id_type != 1 OR players_in_team ( id_club, id_season ) )
);
ALTER TABLE contract ADD CONSTRAINT pk_contract PRIMARY KEY (id_person, id_season);

CREATE TABLE fanbase (
    id_club INTEGER NOT NULL,
    id_season INTEGER NOT NULL,
    number_of_fans INTEGER NOT NULL,
    average_age DECIMAL(2, 0) NOT NULL,
    average_country VARCHAR(32) NOT NULL,
    tshirts_selling INTEGER NOT NULL,
    check ( number_of_fans >= 100000 ),
    check ( average_age >= 18 AND average_age <= 90 ),
    check ( tshirts_selling >= 1000 )
);
ALTER TABLE fanbase ADD CONSTRAINT pk_fanbase PRIMARY KEY (id_club, id_season);

CREATE TABLE league (
    name VARCHAR(64) NOT NULL
);
ALTER TABLE league ADD CONSTRAINT pk_league PRIMARY KEY (name);

CREATE TABLE location (
    id_stadium INTEGER NOT NULL,
    country VARCHAR(32) NOT NULL,
    city VARCHAR(32) NOT NULL,
    street VARCHAR(64) NOT NULL,
    house_number DECIMAL(3, 0) NOT NULL,
    post_index DECIMAL(5, 0) NOT NULL,
    check ( post_index >= 10000 )
);
ALTER TABLE location ADD CONSTRAINT pk_location PRIMARY KEY (id_stadium);

CREATE TABLE person (
    id_person SERIAL NOT NULL,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(32) NOT NULL,
    year_of_birthday INTEGER NOT NULL,
    country VARCHAR(32) NOT NULL,
    height INTEGER NOT NULL,
    weight INTEGER NOT NULL,
    nickname VARCHAR(16),
    check ( height >= 140 AND height <= 250 ),
    check ( weight >= 40 AND weight <= 220 ),
    check ( year_of_birthday >= 1900 AND year_of_birthday <= 2022 ),
    check ( height - weight <= 115 AND height - weight >= 90)
);
ALTER TABLE person ADD CONSTRAINT pk_person PRIMARY KEY (id_person);
ALTER TABLE person ADD CONSTRAINT uc_person_nickname UNIQUE (nickname);

CREATE TABLE prices (
    id_stadium INTEGER NOT NULL,
    lowest_ticket_price INTEGER NOT NULL,
    average_ticket_price INTEGER NOT NULL,
    tshirt_price INTEGER NOT NULL,
    check ( lowest_ticket_price >= 50 AND lowest_ticket_price <= 200 ),
    check ( average_ticket_price >= 200 AND average_ticket_price <= 1000 ),
    check ( tshirt_price >= 1500 AND tshirt_price <= 3000 )
);
ALTER TABLE prices ADD CONSTRAINT pk_prices PRIMARY KEY (id_stadium);

CREATE TABLE record (
    id_record SERIAL NOT NULL,
    id_season INTEGER NOT NULL,
    id_club INTEGER NOT NULL,
    score INTEGER NOT NULL,
    name VARCHAR(128) NOT NULL
);
ALTER TABLE record ADD CONSTRAINT pk_record PRIMARY KEY (id_record);

CREATE TABLE season (
    id_season SERIAL NOT NULL,
    league_name VARCHAR(64) NOT NULL,
    year DECIMAL(4, 0) NOT NULL,
    champion VARCHAR(64) NOT NULL,
    mvp VARCHAR(128) NOT NULL,
    check ( year >= 1980 AND year <= 2040 )
);
ALTER TABLE season ADD CONSTRAINT pk_season PRIMARY KEY (id_season);

CREATE TABLE stadium (
    id_stadium SERIAL NOT NULL,
    name VARCHAR(64) NOT NULL,
    number_of_seats DECIMAL(5, 0) NOT NULL,
    opening_date INTEGER NOT NULL,
    check ( number_of_seats >= 5000 AND number_of_seats <= 50000 ),
    check ( opening_date <= 2400 )
);
ALTER TABLE stadium ADD CONSTRAINT pk_stadium PRIMARY KEY (id_stadium);

CREATE TABLE stats (
    id_person INTEGER NOT NULL,
    id_season INTEGER NOT NULL,
    points DECIMAL(3, 1) NOT NULL,
    rebounds DECIMAL(3, 1) NOT NULL,
    assists DECIMAL(3, 1) NOT NULL,
    steals DECIMAL(3, 1) NOT NULL,
    blocks DECIMAL(3, 1) NOT NULL,
    minutes DECIMAL(3, 1) NOT NULL,
    field_goals_percentage DECIMAL(5, 2) NOT NULL,
    three_point_percentage DECIMAL(5, 2) NOT NULL,
    free_throw_percentage DECIMAL(5, 2) NOT NULL,
    check ( field_goals_percentage <= 100 AND field_goals_percentage >= 0 ),
    check ( three_point_percentage <= 100 AND three_point_percentage >= 0 ),
    check ( free_throw_percentage <= 100 AND free_throw_percentage >= 0 ),
    check ( minutes <= 40 AND minutes >= 0 ),
    check ( points >= 0 ),
    check ( rebounds >= 0 ),
    check ( assists >= 0 ),
    check ( steals >= 0 ),
    check ( blocks >= 0 )
);
ALTER TABLE stats ADD CONSTRAINT pk_stats PRIMARY KEY (id_person, id_season);

CREATE FUNCTION
    amount_of_teams ( season INTEGER )
    RETURNS BOOLEAN AS
$$
DECLARE
     amount INTEGER;
BEGIN
    SELECT count(*) into amount
    FROM team
    WHERE id_season=season;
    RETURN amount < 16;
END;
$$ LANGUAGE 'plpgsql';

CREATE FUNCTION
    which_place ( place_tmp DECIMAL(2, 0), idx_season INTEGER )
    RETURNS BOOLEAN AS
$$
DECLARE
    repeats INTEGER;
BEGIN
    SELECT count(*) INTO repeats
    FROM team
    WHERE place = place_tmp AND id_season=idx_season;

    RETURN repeats=0;
END;
$$ LANGUAGE 'plpgsql';

CREATE TABLE team (
    id_club INTEGER NOT NULL,
    id_season INTEGER NOT NULL,
    id_stadium INTEGER NOT NULL,
    place DECIMAL(2, 0) NOT NULL,
    check ( amount_of_teams ( id_season )),
    check ( which_place ( place, id_season ))
);
ALTER TABLE team ADD CONSTRAINT pk_team PRIMARY KEY (id_club, id_season);

CREATE TABLE type (
    id_type SERIAL NOT NULL,
    name VARCHAR(32) NOT NULL
);
ALTER TABLE type ADD CONSTRAINT pk_type PRIMARY KEY (id_type);

ALTER TABLE club ADD CONSTRAINT fk_club_league FOREIGN KEY (league_name) REFERENCES league (name) ON DELETE CASCADE;

ALTER TABLE contract ADD CONSTRAINT fk_contract_club FOREIGN KEY (id_club) REFERENCES club (id_club) ON DELETE CASCADE;
ALTER TABLE contract ADD CONSTRAINT fk_contract_league FOREIGN KEY (league_name) REFERENCES league (name) ON DELETE CASCADE;
ALTER TABLE contract ADD CONSTRAINT fk_contract_person FOREIGN KEY (id_person) REFERENCES person (id_person) ON DELETE CASCADE;
ALTER TABLE contract ADD CONSTRAINT fk_contract_type FOREIGN KEY (id_type) REFERENCES type (id_type) ON DELETE CASCADE;
ALTER TABLE contract ADD CONSTRAINT fk_contract_season FOREIGN KEY (id_season) REFERENCES season (id_season) ON DELETE CASCADE;

ALTER TABLE fanbase ADD CONSTRAINT fk_fanbase_team FOREIGN KEY (id_club, id_season) REFERENCES team (id_club, id_season) ON DELETE CASCADE;

ALTER TABLE location ADD CONSTRAINT fk_location_stadium FOREIGN KEY (id_stadium) REFERENCES stadium (id_stadium) ON DELETE CASCADE;

ALTER TABLE prices ADD CONSTRAINT fk_prices_stadium FOREIGN KEY (id_stadium) REFERENCES stadium (id_stadium) ON DELETE CASCADE;

ALTER TABLE record ADD CONSTRAINT fk_record_team FOREIGN KEY (id_club, id_season) REFERENCES team (id_club, id_season) ON DELETE CASCADE;

ALTER TABLE season ADD CONSTRAINT fk_season_league FOREIGN KEY (league_name) REFERENCES league (name) ON DELETE CASCADE;

ALTER TABLE stats ADD CONSTRAINT fk_stats_contract FOREIGN KEY (id_person, id_season) REFERENCES contract (id_person, id_season) ON DELETE CASCADE;

ALTER TABLE team ADD CONSTRAINT fk_team_club FOREIGN KEY (id_club) REFERENCES club (id_club) ON DELETE CASCADE;
ALTER TABLE team ADD CONSTRAINT fk_team_season FOREIGN KEY (id_season) REFERENCES season (id_season) ON DELETE CASCADE;
ALTER TABLE team ADD CONSTRAINT fk_team_stadium FOREIGN KEY (id_stadium) REFERENCES stadium (id_stadium) ON DELETE CASCADE;

ALTER TABLE contract ADD CONSTRAINT xc_contract_id_club_name CHECK ((id_club IS NOT NULL AND league_name IS NULL) OR (id_club IS NULL AND league_name IS NOT NULL));

