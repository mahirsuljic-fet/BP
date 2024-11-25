CREATE DATABASE stusluImPr CHARACTER SET = 'utf8' COLLATE = 'utf8_croatian_ci'; 

USE stusluImPr;

CREATE TABLE zupanija (
    sifZupanija     SMALLINT        PRIMARY KEY,
    nazZupanija     NCHAR(40)       NOT NULL
);

CREATE TABLE mjesto (
    pbr             INTEGER         PRIMARY KEY,
    nazMjesto       NCHAR(40)       NOT NULL    UNIQUE,
    sifZupanija     SMALLINT        REFERENCES zupanija(sifZupanija)
);

CREATE TABLE stud (
    mbrStud         INTEGER         PRIMARY KEY,
    imeStud         NCHAR(25)       NOT NULL,
    prezStud        NCHAR(25)       NOT NULL,
    pbrRod          INTEGER         REFERENCES mjesto(pbr),
    pbrStan         INTEGER         NOT NULL    REFERENCES mjesto(pbr),
    datRodStud      DATE,
    jmbgStud        CHAR(13)
);

CREATE TABLE orgjed (
    sifOrgjed       INTEGER         PRIMARY KEY,
    nazOrgjed       NCHAR(60)       NOT NULL,
    sifNadorgjed    INTEGER         REFERENCES orgjed(sifOrgjed)
);

CREATE TABLE nastavnik (
    sifNastavnik    INTEGER         PRIMARY KEY,
    imeNastavnik    NCHAR(25)       NOT NULL,
    prezNastavnik   NCHAR(25)       NOT NULL,
    pbrStan         INTEGER         NOT NULL    REFERENCES mjesto(pbr),
    sifOrgjed       INTEGER         NOT NULL    REFERENCES orgjed(sifOrgjed),
    koef            DECIMAL(3, 2)   NOT NULL
);

CREATE TABLE pred (
    sifPred         INTEGER         PRIMARY KEY,
    kratPred        CHAR(8),
    nazPred         NCHAR(60)       NOT NULL,
    sifOrgjed       INTEGER         REFERENCES orgjed(sifOrgjed),
    upisanoStud     INTEGER,
    brojSatiTjedno  INTEGER
);

CREATE TABLE ispit (
    mbrStud         INTEGER         NOT NULL    REFERENCES stud(mbrStud),
    sifPred         INTEGER         NOT NULL    REFERENCES pred(sifPred),
    sifNastavnik    INTEGER         NOT NULL    REFERENCES nastavnik(sifNastavnik),
    datIspit        DATE            NOT NULL,
    ocjena          SMALLINT        NOT NULL    DEFAULT 1,
    PRIMARY KEY(mbrStud, sifPred, datIspit)
);

CREATE TABLE dvorana (
    oznDvorana      CHAR(5)         PRIMARY KEY,
    kapacitet       INTEGER         DEFAULT 40
);

CREATE TABLE rezervacija (
    oznDvorana      CHAR(5)         NOT NULL    REFERENCES dvorana(oznDvorana),
    oznVrstaDan     CHAR(2)         NOT NULL,
    sat             SMALLINT        NOT NULL,
    sifPred         INTEGER         NOT NULL    REFERENCES pred(sifPred),
    PRIMARY KEY(oznDvorana, oznVrstaDan, sat)
);

LOAD DATA INFILE 'zupanija.unl'     INTO TABLE zupanija     FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'mjesto.unl'       INTO TABLE mjesto       FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'stud.unl'         INTO TABLE stud         FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '\r';
LOAD DATA INFILE 'orgjed.unl'       INTO TABLE orgjed       FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'nastavnik.unl'    INTO TABLE nastavnik    FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'pred.unl'         INTO TABLE pred         FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'ispit.unl'        INTO TABLE ispit        FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '\r';
LOAD DATA INFILE 'dvorana.unl'      INTO TABLE dvorana      FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
LOAD DATA INFILE 'rezervacija.unl'  INTO TABLE rezervacija  FIELDS TERMINATED BY '#' LINES STARTING BY '\n' TERMINATED BY '#\r';
