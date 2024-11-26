## Zadatak 1
```
CREATE UNIQUE INDEX uniquePredmet ON pred (nazPred, sifOrgjed);

SELECT *
FROM pred pred1
JOIN pred pred2
    ON pred1.nazPred = pred2.nazPred
    AND pred1.sifOrgjed = pred2.sifOrgjed
    AND pred1.sifPred <> pred2.sifPred;
```


## Zadatak 2
```
CREATE TEMPORARY TABLE orgjedPred (
	sifOrgjed		INTEGER		NOT NULL,
	nazOrgjed		NCHAR(60)	NOT NULL,
	sifNadorgjed	INTEGER
);
CREATE UNIQUE INDEX orgjedPredUnique ON orgjedPred (sifOrgjed);

INSERT INTO orgjedPred
    SELECT DISTINCT orgjed.*
    FROM orgjed
    JOIN pred ON pred.sifOrgjed = orgjed.sifOrgjed;

CREATE TEMPORARY TABLE orgjedNast (
	sifOrgjed		INTEGER		NOT NULL,
	nazOrgjed		NCHAR(60)	NOT NULL,
	sifNadorgjed	INTEGER
);
CREATE UNIQUE INDEX orgjedNastUnique ON orgjedNast (sifOrgjed);

INSERT INTO orgjedNast
    SELECT DISTINCT orgjed.*
    FROM orgjed
    JOIN nastavnik ON nastavnik.sifOrgjed = orgjed.sifOrgjed;
```


## Zadatak 3
```
CREATE TEMPORARY TABLE SerialTest(
	ID	SERIAL
);

INSERT INTO SerialTest VALUES(0);   --> 1
INSERT INTO SerialTest VALUES(0);   --> 2
INSERT INTO SerialTest VALUES(10);  --> 10
INSERT INTO SerialTest VALUES(0);   --> 11
INSERT INTO SerialTest VALUES(20);  --> 20
INSERT INTO SerialTest VALUES(20);  --> Error Code: 1062. Duplicate entry '20' for key 'SerialTest.ID'

```

`SERIAL` je alias za `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE`, 
duplikati automatski nisu dozvoljeni zbog `UNIQUE`.


## Zadatak 4
```
CREATE TEMPORARY TABLE nastTemp (
	rbrNast			SERIAL,
	sifNastavnik	INTEGER			NOT NULL,
	imeNastavnik	NCHAR(25)		NOT NULL,
	prezNastavnik	NCHAR(25)		NOT NULL,
	pbrStan			INTEGER			NOT NULL,
	sifOrgjed		INTEGER			NOT NULL,
	koef			DECIMAL(3, 2)	NOT NULL
);
CREATE UNIQUE INDEX nastTempUnique ON nastTemp (sifNastavnik);

INSERT INTO nastTemp
    SELECT 0, nastavnik.*
    FROM nastavnik;
```

<br>

------------------------------------------------------------------------

CREATE TEMPORARY TABLE studT (
    mbrStud		INTEGER		NOT NULL,
    imeStud		NCHAR(25)	NOT NULL,
    prezStud	NCHAR(25)	NOT NULL,
    pbrRod		INTEGER,
    pbrStan		INTEGER		NOT NULL,
    datRodStud	DATE,
    jmbgStud	CHAR(13)
);
CREATE UNIQUE INDEX studTUnique ON studT (mbrStud);
INSERT INTO studT SELECT * FROM stud;

CREATE TEMPORARY TABLE predT (
    sifPred			INTEGER		NOT NULL,
    kratPred		CHAR(8),
    nazPred			NCHAR(70)	NOT NULL,
    sifOrgjed		INTEGER,
    upisanoStud		INTEGER,
    brojSatiTjedno	INTEGER
);
CREATE UNIQUE INDEX predTUnique ON predT (sifPred);
INSERT INTO predT SELECT * FROM pred;

CREATE TEMPORARY TABLE nasT (
    sifNastavnik	INTEGER			NOT NULL,
    imeNastavnik	NCHAR(25)		NOT NULL,
    prezNastavnik	NCHAR(25)		NOT NULL,
    pbrStan			INTEGER			NOT NULL,
    sifOrgjed		INTEGER			NOT NULL,
    koef			DECIMAL(3, 2)	NOT NULL
);
CREATE UNIQUE INDEX nasTUnique ON nasT (sifNastavnik);
INSERT INTO nasT SELECT * FROM nastavnik;

CREATE TEMPORARY TABLE ispitT (
    mbrStud			INTEGER		NOT NULL,
    sifPred			INTEGER		NOT NULL,
    sifNastavnik	INTEGER		NOT NULL,
    datIspit		DATE		NOT NULL,
    ocjena			SMALLINT	NOT NULL	DEFAULT 1 
);
CREATE UNIQUE INDEX ispitTUnique ON ispitT (mbrStud, sifPred, datIspit);
INSERT INTO ispitT SELECT * FROM ispit;

------------------------------------------------------------------------

<br>


## Zadatak 5
```
UPDATE predT SET nazPred = CONCAT(kratPred, '-', nazPred);
```

## Zadatak 6
```
UPDATE nasT SET koef = koef * 0.9 
    WHERE sifNastavnik IN (
        SELECT sifNastavnik 
        FROM ispit
        WHERE ocjena > 1
        GROUP BY 1
        HAVING AVG(ocjena) < 2.2
    ) OR sifNastavnik IN (
        SELECT sifNastavnik 
        FROM ispit
        WHERE ocjena = 1
        GROUP BY 1
        HAVING COUNT(ocjena) > 8
    );
```


## Zadatak 7
```
UPDATE predT SET brojSatiTjedno = brojSatiTjedno + 1
    WHERE brojSatiTjedno BETWEEN 1 AND 4
        AND sifPred IN (
            SELECT sifPred
            FROM ispitT
            WHERE datIspit < DATE_SUB(CURRENT_DATE, INTERVAL 15 YEAR)
                AND ocjena = 1
            GROUP BY 1
            HAVING COUNT(ocjena) > 10
        );
```


## Zadatak 8
```
UPDATE predT SET brojSatiTjedno = brojSatiTjedno - 1
    WHERE sifPred IN (
        SELECT sifPred
        FROM ispit
        WHERE ocjena = 5
        GROUP BY 1
        HAVING COUNT(*) >= ALL (
            SELECT COUNT(*)
            FROM ispit
            WHERE ocjena = 5
            GROUP BY sifPred
        )
    );
```


## Zadatak 9
```
CREATE TEMPORARY TABLE tempKonv(
	stariMbr	INTEGER		NOT NULL,
	noviMbr		INTEGER		NOT NULL,
	noviPbrRod	INTEGER		NOT NULL,
	noviPbrStan	INTEGER		NOT NULL
);

LOAD DATA INFILE 'konverzija.unl' 
INTO TABLE tempKonv
FIELDS TERMINATED BY '#'
LINES TERMINATED BY '#\r';

UPDATE studT SET 
	mbrStud = (
		SELECT noviMbr
		FROM tempKonv
		WHERE stariMbr = mbrStud
	);
UPDATE studT SET 
	pbrRod = (
		SELECT noviPbrRod
		FROM tempKonv
		WHERE noviMbr = mbrStud
	);
UPDATE studT SET
	pbrStan = (
		SELECT noviPbrStan
		FROM tempKonv
		WHERE noviMbr = mbrStud
	);

```

Ne može se odraditi jednom update naredbom jer MySQL ne dozvoljava 
da se privremena tabela otvori više puta u istoj UPDATE naredbi.

## Zadatak 10
```
DELETE FROM studT WHERE prezStud RLIKE "^[AEIOU]";
```


## Zadatak 11
```
DELETE FROM ispitT WHERE sifNastavnik IN (
	SELECT sifNastavnik
	FROM nastavnik
	JOIN orgjed ON orgjed.sifOrgjed = nastavnik.sifOrgjed
	WHERE nazOrgjed LIKE "%fiziku%"
);

DELETE FROM nasT WHERE sifOrgjed IN (
	SELECT sifOrgjed
	FROM orgjed
	WHERE nazOrgjed LIKE "%fiziku%"
);
```


## Zadatak 12
[`initRef.sql`](./initRef.sql)

```
INSERT INTO stud VALUES(NULL, "Ime", "Prezime", 123, 123);
INSERT INTO stud VALUES(0, "Ime", "Prezime", 123, NULL);
UPDATE stud SET mbrStud = NULL;
DELETE FROM mjesto WHERE pbr IN (SELECT pbrStan FROM stud);
```
