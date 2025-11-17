--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author Adam Byle
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerProperty;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer,
	cash integer,
	location integer
	);

CREATE TABLE Property (
	ID integer PRIMARY KEY,
	name varchar(50)
	);

CREATE TABLE PlayerProperty (
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	propertyID integer REFERENCES Property(ID),
	houses integer,
	hotel boolean
	);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);

INSERT INTO Property VALUES (1, 'Mediterranean Avenue');
INSERT INTO Property VALUES (2, 'Baltic Avenue');
INSERT INTO Property VALUES (3, 'Boardwalk');
INSERT INTO Property VALUES (4, 'Park Place');
INSERT INTO Property VALUES (5, 'Illinois Avenue');

-- Game 1
INSERT INTO PlayerProperty VALUES (1, 1, 1, 0, false);  -- me@calvin.edu owns Mediterranean Ave
INSERT INTO PlayerProperty VALUES (1, 2, 3, 2, false);  -- The King owns Boardwalk with 2 houses
INSERT INTO PlayerProperty VALUES (1, 3, 4, 4, true);  -- Dogbreath owns Park Place with hotel

-- Game 2
INSERT INTO PlayerProperty VALUES (2, 1, 2, 1, false);  -- me@calvin.edu owns Baltic Ave
INSERT INTO PlayerProperty VALUES (2, 3, 5, 0, false);  -- Dogbreath owns Illinois Ave

-- Game 3
INSERT INTO PlayerProperty VALUES (3, 2, 3, 0, false);  -- The King owns Boardwalk
INSERT INTO PlayerProperty VALUES (3, 3, 4, 3, false);  -- Dogbreath owns Park Place with 3 houses
