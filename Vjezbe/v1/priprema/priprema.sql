-- zadatak 1
CREATE DATABASE MS22128;
USE MS22128;

-- zadatak 2
CREATE TABLE stud(
  mbrStud     NCHAR(8)     NOT NULL UNIQUE,
  prezStud    NCHAR(20)    NOT NULL,
  imeStud     NCHAR(20)    NOT NULL,
  datRodStud  DATE,
  pbrRodStud  INTEGER,
  adrStud     NCHAR(40),
  prosjOcjena DECIMAL(3,2) NOT NULL
);

-- zadatak 3
SELECT * FROM stud;

-- zadatak 4
INSERT INTO stud VALUES(1, 'Prezime1', 'Ime1', 2001-01-01, 0, 'Mjesto1', 8.00);
INSERT INTO stud VALUES(2, 'Prezime2', 'Ime2', 2002-02-02, 2, 'Mjesto2', 9.00);
INSERT INTO stud VALUES(3, 'Prezime3', 'Ime3', 2003-03-03, 3, 'Mjesto3', 10.00);

-- zadatak 5
SELECT * FROM stud;

-- zadatak 6
UPDATE stud SET pbrRodStud=1 WHERE mbrStud=1;

-- zadatak 7
SELECT * FROM stud INTO OUTFILE 'studenti.unl' 
FIELDS TERMINATED BY '#' 
LINES TERMINATED BY '\r';

-- zadatak 8
DELETE * FROM stud;

-- zadatak 9
SELECT * FROM stud;

-- zadatak 10
LOAD DATA INFILE 'studenti.unl'
INTO TABLE stud
FIELDS TERMINATED BY '#' 
LINES STARTING BY '\n' LINES TERMINATED BY '\r';

-- zadatak 11
DELETE * FROM stud;

-- zadatak 12
-- kreiran lab1.sql

-- zadatak 13
-- pokrenuti skriptu

-- zadatak 14
SELECT * FROM stud;
