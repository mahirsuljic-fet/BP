-- zadatak 1
SELECT stud.*
FROM stud
WHERE stud.mbrStud NOT IN (SELECT mbrStud FROM ispit WHERE ocjena = 1);

-- zadatak 2
SELECT mjesto.nazMjesto
FROM mjesto
JOIN nastavnik ON mjesto.pbr = nastavnik.pbrStan
WHERE mjesto.pbr NOT IN (
    SELECT stud.pbrStan 
    FROM stud 
    JOIN mjesto 
    ON stud.pbrStan = mjesto.pbr
);

-- zadatak 3
SELECT DISTINCT zupanija.nazZupanija
FROM zupanija
JOIN mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
JOIN stud   ON mjesto.pbr = stud.pbrRod
WHERE zupanija.sifZupanija NOT IN (
    SELECT zupanija.sifZupanija
    FROM zupanija
    JOIN mjesto ON zupanija.sifZupanija = mjesto.sifZupanija
    JOIN stud   ON stud.pbrStan = mjesto.pbr
);

-- zadatak 4
SELECT sifNastavnik, imeNastavnik, prezNastavnik
FROM nastavnik
WHERE sifNastavnik NOT IN (
    SELECT sifNastavnik
    FROM ispit
    WHERE 
        ocjena > 1 AND
        YEAR(datIspit) = YEAR(CURRENT_DATE()) AND
        MONTH(datIspit) IN (1, 2)
);

-- zadatak 5
SELECT imeStud, prezStud, datRodStud
FROM stud
WHERE datRodStud <= DATE_ADD((SELECT MAX(datRodStud) FROM stud), INTERVAL -200 DAY);

-- zadatak 6
SELECT pred.*
FROM pred
WHERE sifOrgJed IN (
    SELECT sifOrgJed
    FROM nastavnik
    WHERE prezNastavnik LIKE "O%"
);

-- zadatak 7
SELECT oznDvorana, kapacitet
FROM dvorana
WHERE kapacitet > (
    SELECT COUNT(sifPred)
    FROM rezervacija
    WHERE rezervacija.oznDvorana = dvorana.oznDvorana
);

-- zadatak 8
SELECT *
FROM nastavnik
JOIN mjesto ON nastavnik.pbrStan = mjesto.pbr
WHERE koef < (
    SELECT AVG(nastavnikSub.koef) 
    FROM nastavnik nastavnikSub
    JOIN mjesto mjestoSub ON nastavnikSub.pbrStan = mjestoSub.pbr
    WHERE mjesto.sifZupanija = mjestoSub.sifZupanija
    AND nastavnik.sifNastavnik <> nastavnikSub.sifNastavnik
);

-- zadatak 9
SELECT mbrStud, imeStud, prezStud
FROM stud
WHERE mbrStud NOT IN (
    SELECT stud.mbrStud
    FROM stud
    JOIN ispit ON stud.mbrStud = ispit.mbrStud
    WHERE WEEKDAY(datRodStud) = WEEKDAY(datIspit)
);

-- zadatak 10
SELECT sifNastavnik, imeNastavnik, prezNastavnik
FROM nastavnik
JOIN mjesto   ON nastavnik.pbrStan = mjesto.pbr
JOIN zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE 
    zupanija.nazZupanija = 'Dubrovačko-neretvanska' AND
    EXISTS (
        SELECT sifNastavnik
        FROM nastavnik nastavnikSub
        JOIN mjesto   ON nastavnikSub.pbrStan = mjesto.pbr
        JOIN zupanija ON mjesto.sifZupanija = zupanija.sifZupanija
        WHERE zupanija.nazZupanija = 'Splitsko-dalmatinska'
            AND nastavnik.koef > nastavnikSub.koef
    );

-- zadatak 11
SELECT stud.mbrStud, stud.imeStud, stud.prezStud
FROM stud
JOIN ispit ON stud.mbrStud = ispit.mbrStud
WHERE 
    ocjena > 1 AND
    NOT EXISTS (
        SELECT ispitSub.mbrStud
        FROM ispit ispitSub
        WHERE 
            ispitSub.ocjena > 1 AND
            ispit.mbrStud <> ispitSub.mbrStud AND
            ispit.sifNastavnik = ispitSub.sifNastavnik
    );

-- zadatak 12
CREATE TABLE r1(
    A CHAR(1),
    B CHAR(1),
    C CHAR(1)
);

CREATE TABLE r2(
    D CHAR(1),
    E INTEGER
);

CREATE TABLE r3(
    B CHAR(1),
    C CHAR(1),
    D INTEGER,
    E CHAR(1)
);

INSERT INTO r1 VALUES('a', 'b', 'c');
INSERT INTO r1 VALUES('a', 'd', 'k');
INSERT INTO r1 VALUES('a', 'e', 'm');
INSERT INTO r1 VALUES('a', 'm', 'k');

INSERT INTO r2 VALUES(5,  'f');
INSERT INTO r2 VALUES(7,  'g');
INSERT INTO r2 VALUES(11, 'e');
INSERT INTO r2 VALUES(11, 'g');

INSERT INTO r3 VALUES('b', 'c', 5,  'f');
INSERT INTO r3 VALUES('m', 'k', 7,  'g');
INSERT INTO r3 VALUES('m', 'n', 9,  'e');
INSERT INTO r3 VALUES('m', 'k', 11, 'g');


-- a)

-- Rezultat:
-- b, c
-- m, k

SELECT DISTINCT r1.B, r1.C
FROM r1
JOIN r3 
    ON  r1.B = r3.B
    AND r1.C = r3.C;


-- b)

-- Rezultat:
-- d
-- e

SELECT DISTINCT r1.B
FROM r1
WHERE r1.B NOT IN (
    SELECT DISTINCT r3.B
    FROM r3
);


-- c)

-- Rezultat:
-- f

SELECT DISTINCT r2.E
FROM r2
JOIN r3 ON
    r2.D = r3.D AND
    r2.E = r3.E
WHERE r2.E NOT IN (
    SELECT DISTINCT r3.E
    FROM r3
    WHERE D > 7
);

-- d)

-- Rezultat:
-- a, m, k, 5,  f
-- a, e, m, 5,  f
-- a, d, k, 5,  f
-- a, e, m, 7,  g
-- a, d, k, 7,  g
-- a, b, c, 7,  g
-- a, m, k, 11, e
-- a, e, m, 11, e
-- a, d, k, 11, e
-- a, b, c, 11, e
-- a, e, m, 11, g
-- a, d, k, 11, g
-- a, b, c, 11, g

SELECT DISTINCT *
FROM r1 CROSS JOIN r2
WHERE NOT EXISTS (
    SELECT *
    FROM r1 r1Sub
    INNER JOIN r3 ON
        r1Sub.B = r3.B AND
        r1Sub.C = r3.C
    WHERE 
        r1.A = r1Sub.A AND
        r1.B = r1Sub.B AND
        r1.C = r1Sub.C AND
        r2.D = r3.D AND
        r2.E = r3.E
);


-- e)

-- Rezultat:
-- m, k

SELECT DISTINCT r1.B, r1.C
FROM r1
WHERE
    r1.B > 'd' AND 
    NOT r1.C = 'm' AND 
    EXISTS (
        SELECT DISTINCT r3.B, r3.C
        FROM r2
        INNER JOIN r3 ON
            r2.D = r3.D AND
            r2.E = r3.E
    );
