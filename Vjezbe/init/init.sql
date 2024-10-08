CREATE DATABASE stusluMaSu CHARACTER SET = 'utf8' COLLATE = 'utf8_croatian_ci'; -- IZMIJENITI IME BAZE PODATAKA

USE stusluMaSu; -- IZMIJENITI IME BAZE PODATAKA

CREATE TABLE zupanija (
    sifZupanija SMALLINT NOT NULL,
    nazZupanija NCHAR(40) NOT NULL
);
CREATE UNIQUE INDEX zupanijaUnique ON zupanija (sifZupanija);

CREATE TABLE mjesto (
    pbr INTEGER NOT NULL,
    nazMjesto NCHAR(40) NOT NULL,
    sifZupanija SMALLINT
);
CREATE UNIQUE INDEX mjestoPbr ON mjesto (pbr);
CREATE INDEX mjestoUnique ON mjesto (nazMjesto);

CREATE TABLE stud (
    mbrStud INTEGER NOT NULL,
    imeStud NCHAR(25) NOT NULL,
    prezStud NCHAR(25) NOT NULL,
    pbrRod INTEGER,
    pbrStan INTEGER NOT NULL,
    datRodStud DATE,
    jmbgStud CHAR(13)
);
CREATE UNIQUE INDEX studUnique ON stud (mbrStud);

CREATE TABLE orgjed (
    sifOrgjed INTEGER NOT NULL,
    nazOrgjed NCHAR(60) NOT NULL,
    sifNadorgjed INTEGER
);
CREATE UNIQUE INDEX orgjedUnique ON orgjed (sifOrgjed);

CREATE TABLE nastavnik (
    sifNastavnik INTEGER NOT NULL,
    imeNastavnik NCHAR(25) NOT NULL,
    prezNastavnik NCHAR(25) NOT NULL,
    pbrStan INTEGER NOT NULL,
    sifOrgjed INTEGER NOT NULL,
    koef DECIMAL(3 , 2 ) NOT NULL
);
CREATE UNIQUE INDEX nastavnikUnique ON nastavnik (sifNastavnik);

CREATE TABLE pred (
    sifPred INTEGER NOT NULL,
    kratPred CHAR(8),
    nazPred NCHAR(60) NOT NULL,
    sifOrgjed INTEGER,
    upisanoStud INTEGER,
    brojSatiTjedno INTEGER
);
CREATE UNIQUE INDEX predUnique ON pred (sifPred);

CREATE TABLE ispit (
    mbrStud INTEGER NOT NULL,
    sifPred INTEGER NOT NULL,
    sifNastavnik INTEGER NOT NULL,
    datIspit DATE NOT NULL,
    ocjena SMALLINT DEFAULT 1 NOT NULL
);
CREATE UNIQUE INDEX ispitUnique ON ispit (mbrStud, sifPred, datIspit);

CREATE TABLE dvorana (
    oznDvorana CHAR(5) NOT NULL,
    kapacitet INTEGER DEFAULT 40
);
CREATE UNIQUE INDEX dvoranaUnique ON dvorana (oznDvorana);

CREATE TABLE rezervacija (
    oznDvorana CHAR(5) NOT NULL,
    oznVrstaDan CHAR(2) NOT NULL,
    sat SMALLINT NOT NULL,
    sifPred INTEGER NOT NULL
);
CREATE UNIQUE INDEX rezervacijaUnique ON rezervacija (oznDvorana, oznVrstaDan, sat);

LOAD DATA INFILE 'tmp/zupanija.unl'    INTO TABLE zupanija    FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'tmp/mjesto.unl'      INTO TABLE mjesto      FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'tmp/stud.unl'        INTO TABLE stud        FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '\r';
LOAD DATA INFILE 'tmp/orgjed.unl'      INTO TABLE orgjed      FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'tmp/nastavnik.unl'   INTO TABLE nastavnik   FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'tmp/pred.unl'        INTO TABLE pred        FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'tmp/ispit.unl'       INTO TABLE ispit       FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '\r';
LOAD DATA INFILE 'tmp/dvorana.unl'     INTO TABLE dvorana     FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'tmp/rezervacija.unl' INTO TABLE rezervacija FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
