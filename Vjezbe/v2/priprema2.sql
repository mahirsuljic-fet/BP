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
SELECT prezNastavnik, imeNastavnik, 800 * (koef + 0.4) AS PLATA FROM nastavnik;

-- zadatak 7
SELECT prezNastavnik FROM nastavnik WHERE 800 * (koef + 0.4) > 3500 AND 800 * (koef + 0.4) < 8000;
SELECT prezNastavnik FROM nastavnik WHERE 800 * (koef + 0.4) BETWEEN 3500 AND 8000;

-- zadatak 8
SELECT prezNastavnik, SUBSTRING(imeNastavnik, 1, 1) AS ime FROM nastavnik;
SELECT CONCAT(prezNastavnik, " ", SUBSTRING(imeNastavnik, 1, 1)) AS prezime_slovo FROM nastavnik;

-- zadatak 9
SELECT imeStud, prezStud, CONCAT(SUBSTRING(imeStud, 1, 1), ".", SUBSTRING(prezStud, 1, 1), ".") AS INICIJALI FROM stud;

-- zadatak 10
SELECT * FROM ispit WHERE MONTH(datIspit) = 7;

-- zadatak 11
SELECT * FROM ispit WHERE MONTH(datIspit) = 8 AND DAYNAME(datIspit) = "Wednesday";

-- zadatak 12
SELECT mbrStud, ocjena, datIspit, CURDATE() AS danasnji, DATEDIFF(CURDATE(), datIspit) AS razlika FROM ispit;
SELECT mbrStud, ocjena, datIspit, CURRENT_DATE AS danasnji, DATEDIFF(CURRENT_DATE, datIspit) AS razlika FROM ispit;

-- zadatak 13
SELECT * FROM stud WHERE datRodStud = SUBDATE(CURDATE(), INTERVAL 25 YEAR);

-- zadatak 14
SELECT sifNastavnik, mbrStud, ocjena, DATEDIFF("2009-01-01", datIspit) AS protekloDana FROM ispit;

-- zadatak 15
SELECT mbrStud, sifPred, ocjena, ADDDATE(datIspit, 3800) AS DATUM FROM ispit WHERE ADDDATE(datIspit, 3800) < CURDATE();

-- zadatak 16
SELECT mbrStud, sifPred, ocjena, datIspit, ADDDATE(datIspit, INTERVAL 3 YEAR) AS datum_3 FROM ispit;

-- zadatak 17
SELECT oznDvorana, oznVrstaDan, sat, sifPred AS predmet FROM rezervacija;

-- zadatak 18
SELECT pbrRod, pbrStan FROM stud;
