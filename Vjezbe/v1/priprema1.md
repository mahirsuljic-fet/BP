## Zadatak 1
```
CREATE DATABASE MS22128;
USE MS22128;
```

## Zadatak 2
```
CREATE TABLE stud(
  mbrStud     NCHAR(8)     NOT NULL   UNIQUE,
  prezStud    NCHAR(20)    NOT NULL,
  imeStud     NCHAR(20)    NOT NULL,
  datRodStud  DATE,
  pbrRodStud  INTEGER,
  adrStud     NCHAR(40),
  prosjOcjena DECIMAL(3,2) NOT NULL
);
```

## Zadatak 3
```
SELECT * FROM stud;
```

## Zadatak 4
```
INSERT INTO stud VALUES(1, 'Prezime1', 'Ime1', 2001-01-01, 0, 'Mjesto1', 8.00);
INSERT INTO stud VALUES(2, 'Prezime2', 'Ime2', 2002-02-02, 2, 'Mjesto2', 9.00);
INSERT INTO stud VALUES(3, 'Prezime3', 'Ime3', 2003-03-03, 3, 'Mjesto3', 10.00);
```

## Zadatak 5
```
SELECT * FROM stud;
```

## Zadatak 6
```
UPDATE stud SET pbrRodStud=1 WHERE mbrStud=1;
```

## Zadatak 7
```
SELECT * FROM stud INTO OUTFILE 'studenti.unl' 
FIELDS TERMINATED BY '#' 
LINES TERMINATED BY '\r';
```

## Zadatak 8
```
DELETE * FROM stud;
```

## Zadatak 9
```
SELECT * FROM stud;
```

## Zadatak 10
```
LOAD DATA INFILE 'studenti.unl'
INTO TABLE stud
FIELDS TERMINATED BY '#' 
LINES STARTING BY '\n' LINES TERMINATED BY '\r';
```

## Zadatak 11
```
DELETE * FROM stud;
```

## Zadatak 12
[lab1.sql](./lab1.sql)

## Zadatak 13
_pokrenuti skriptu_

## Zadatak 14
```
SELECT * FROM stud;
```
