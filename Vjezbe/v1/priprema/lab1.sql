CREATE TABLE stud(
  mbrStud     NCHAR(8)     NOT NULL UNIQUE,
  prezStud    NCHAR(20)    NOT NULL,
  imeStud     NCHAR(20)    NOT NULL,
  datRodStud  DATE,
  pbrRodStud  INTEGER,
  adrStud     NCHAR(40),
  prosjOcjena DECIMAL(3,2) NOT NULL
);

LOAD DATA INFILE 'studenti.unl'
INTO TABLE stud
FIELDS TERMINATED BY '#' 
LINES STARTING BY '\n' LINES TERMINATED BY '\r';
