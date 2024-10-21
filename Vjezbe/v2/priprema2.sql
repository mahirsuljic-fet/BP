-- zadatak 1
SELECT sifNastavnik, imeNastavnik, prezNastavnik, koef FROM nastavnik;

-- zadatak 2
SELECT * FROM pred;

-- zadatak 3
SELECT DISTINCT imeStud FROM stud;

-- zadatak 4
SELECT DISTINCT sifNastavnik FROM ispit WHERE sifPred = 146 AND ocjena = 1;

-- zadatak 5
SELECT mbrStud FROM ispit WHERE sifPred = 262 AND ocjena > 1;

-- zadatak 6
SELECT imeNastavnik, prezNastavnik, 800 * (koef + 0.4) AS plata FROM nastavnik;

-- zadatak 7
SELECT prezNastavnik FROM nastavnik WHERE 800 * (koef + 0.4) BETWEEN 3500 AND 8000;

-- zadatak 8
SELECT prezNastavnik, SUBSTR(imeNastavnik, 1, 1) AS prvoSlovoImena FROM nastavnik;

-- zadatak 9
SELECT imeStud, prezStud, CONCAT(SUBSTR(imeStud, 1, 1), '.', SUBSTR(prezStud, 1, 1), '.') AS inicijali FROM stud;

-- zadatak 10
SELECT * FROM ispit WHERE MONTH(datIspit) = 7;

-- zadatak 11
SELECT * FROM ispit WHERE WEEKDAY(datIspit) = 2 AND MONTH(datIspit) = 8;

-- zadatak 12
SELECT mbrStud, ocjena, datIspit, CURRENT_DATE AS danasnjiDatum, DATEDIFF(CURRENT_DATE, datIspit) AS protekloDana FROM ispit;

-- zadatak 13
SELECT * FROM stud WHERE datRodStud = DATE_SUB(CURRENT_DATE, INTERVAL 25 YEAR);

-- zadatak 14
SELECT sifNastavnik, mbrStud, ocjena, DATEDIFF(CURRENT_DATE, "2009-01-01") AS protekloDana FROM ispit;

-- zadatak 15
SELECT mbrStud, sifPred, ocjena, datIspit, DATE_ADD(datIspit, INTERVAL 4800 DAY) AS 3800danaIspita FROM ispit WHERE DATE_ADD(datIspit, INTERVAL 4800 DAY) >= CURRENT_DATE;

-- zadatak 16
SELECT mbrStud, sifPred, ocjena, datIspit, DATE_ADD(datIspit, INTERVAL 3 YEAR) AS 3godIspita FROM ispit;

-- zadatak 17
SELECT oznDvorana, oznVrstaDan, sat, sifPred AS predmet FROM rezervacija;

-- zadatak 18
SELECT DISTINCT pbrRod, pbrStan FROM stud;
