-- zadatak 1
SELECT 
    CONCAT(SUBSTR(imeStud, 1, 1), '.', SUBSTR(prezStud, 1, 1), '.') AS inicijaliStud, 
    SUBSTR(nazPred, 1, 25) AS predmet, 
    datIspit 
FROM stud 
JOIN ispit ON stud.mbrStud = ispit.mbrStud
JOIN pred  ON ispit.sifPred = pred.sifPred
WHERE ocjena = 5;

-- zadatak 2
SELECT DISTINCT nad.sifOrgJed, nad.nazOrgJed
FROM orgjed nad
JOIN orgjed pod ON pod.sifNadorgjed = nad.sifOrgJed
WHERE pod.nazOrgjed LIKE "%matem%";

-- zadatak 3
SELECT pred.nazPred, pred.kratPred
FROM pred
JOIN orgjed pod ON pod.sifOrgjed = pred.sifOrgjed
JOIN orgjed nad ON pod.sifNadorgjed = nad.sifOrgjed
WHERE nad.nazOrgjed LIKE "%tehnike%";

-- zadatak 4
SELECT DISTINCT nazOrgjed
FROM ispit 
JOIN pred      ON ispit.sifPred = pred.sifPred
JOIN orgjed    ON pred.sifOrgjed = orgjed.sifOrgjed
JOIN nastavnik ON ispit.sifNastavnik = nastavnik.sifNastavnik
JOIN mjesto    ON nastavnik.pbrStan = mjesto.pbr
JOIN zupanija  ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE YEAR(ispit.datIspit) = 2000
    AND MONTH(ispit.datIspit) = 4
    AND zupanija.nazZupanija = "Dubrovačko-neretvanska";

-- zadatak 5
SELECT DISTINCT stud.*
FROM stud
JOIN ispit     ON stud.mbrStud = ispit.mbrStud
JOIN nastavnik ON ispit.sifNastavnik = nastavnik.sifNastavnik
JOIN mjesto    ON nastavnik.pbrStan = mjesto.pbr
JOIN zupanija  ON mjesto.sifZupanija = zupanija.sifZupanija
WHERE ispit.ocjena = 1
    AND zupanija.nazZupanija = 'Osječko-baranjska';

-- zadatak 6
SELECT SUM(pred.upisanoStud) brojStud
FROM pred
JOIN orgjed pod ON pred.sifOrgjed = pod.sifOrgjed
JOIN orgjed nad ON pod.sifNadorgjed = nad.sifOrgjed
WHERE nad.nazOrgjed = 'Fakultet elektrotehnike i računarstva';

-- zadatak 7
SELECT nastavnik.imeNastavnik, nastavnik.prezNastavnik, orgjed.nazOrgjed
FROM nastavnik
JOIN orgjed ON nastavnik.sifOrgjed = orgjed.sifOrgjed;

-- zadatak 8
SELECT 
    stud.imeStud, 
    stud.prezStud, 
    mjestoStan.nazMjesto AS stanMjesto, 
    mjestoRod.nazMjesto  AS rodMjesto, 
    zupanija.nazZupanija AS rodZupanija
FROM stud
JOIN mjesto mjestoStan ON stud.pbrStan = mjestoStan.pbr
JOIN mjesto mjestoRod  ON stud.pbrRod = mjestoRod.pbr
JOIN zupanija          ON mjestoRod.sifZupanija = zupanija.sifZupanija;

-- zadatak 9
SELECT COUNT(ispit.ocjena) AS negOcjena
FROM ispit
JOIN nastavnik ON ispit.sifNastavnik = nastavnik.sifNastavnik
JOIN mjesto    ON nastavnik.pbrStan = mjesto.pbr
WHERE ispit.ocjena = 1
    AND mjesto.nazMjesto RLIKE '^Z';

-- zadatak 10
SELECT COUNT(DISTINCT ispit.sifNastavnik) AS brNastavnik
FROM ispit
JOIN nastavnik ON ispit.sifNastavnik = nastavnik.sifNastavnik
JOIN orgjed    ON nastavnik.sifOrgjed = orgjed.sifOrgjed
WHERE orgjed.nazOrgjed = 'Zavod za primijenjenu matematiku';

-- zadatak 11
SELECT rezervacija.oznDvorana, dvorana.kapacitet
FROM rezervacija
JOIN pred    ON rezervacija.sifPred = pred.sifPred
JOIN dvorana ON rezervacija.oznDvorana = dvorana.oznDvorana
WHERE rezervacija.oznVrstaDan IN ('PO', 'SR', 'PE')
    AND pred.nazPred = 'Energetska elektronika-izabrana poglavlja';

-- zadatak 12
SELECT DISTINCT orgjed.nazOrgjed
FROM orgjed
JOIN nastavnik ON orgjed.sifOrgjed = nastavnik.sifOrgjed;

-- zadatak 13
SELECT COUNT(DISTINCT pred.sifPred) AS brPred
FROM pred
JOIN rezervacija ON pred.sifPred = rezervacija.sifPred
JOIN dvorana     ON rezervacija.oznDvorana = dvorana.oznDvorana
WHERE dvorana.kapacitet <= 60;

-- zadatak 14
SELECT DISTINCT mjestoRod.nazMjesto AS nazMjesto
FROM stud
JOIN mjesto mjestoRod  ON stud.pbrRod = mjestoRod.pbr
JOIN mjesto mjestoStan ON stud.pbrStan = mjestoStan.pbr
WHERE mjestoRod.pbr = mjestoStan.pbr;

-- zadatak 15
SELECT
    stud.imeStud, 
    stud.prezStud, 
    mjestoRod.nazMjesto AS rodMjesto,
    mjestoStan.nazMjesto AS stanMjesto
FROM stud
JOIN ispit             ON stud.mbrStud = ispit.mbrStud
JOIN pred              ON ispit.sifPred = pred.sifPred
JOIN mjesto mjestoRod  ON stud.pbrRod = mjestoRod.pbr
JOIN mjesto mjestoStan ON stud.pbrStan = mjestoStan.pbr
WHERE pred.nazPred = 'Elektronički sklopovi'
    AND ispit.ocjena > 1;

-- zadatak 16
SELECT stud.*
FROM stud
JOIN mjesto mjestoRod      ON stud.pbrRod = mjestoRod.pbr
JOIN mjesto mjestoStan     ON stud.pbrStan = mjestoStan.pbr
JOIN zupanija zupanijaRod  ON mjestoRod.sifZupanija = zupanijaRod.sifZupanija
JOIN zupanija zupanijaStan ON mjestoStan.sifZupanija = zupanijaStan.sifZupanija
WHERE mjestoRod.pbr <> mjestoStan.pbr
    AND zupanijaRod.sifZupanija = zupanijaStan.sifZupanija;

-- zadatak 17
SELECT DISTINCT nastavnik.*
FROM ispit
JOIN stud                  ON ispit.mbrStud = stud.mbrStud
JOIN nastavnik             ON ispit.sifNastavnik = nastavnik.sifNastavnik
JOIN mjesto mjestoStud     ON stud.pbrStan = mjestoStud.pbr
JOIN mjesto mjestoNast     ON nastavnik.pbrStan = mjestoNast.pbr
WHERE mjestoStud.sifZupanija = mjestoNast.sifZupanija;

-- zadatak 18
SELECT
    stud1.imeStud  AS imeStud1,
    stud1.prezStud AS prezStud1,
    stud2.imeStud  AS imeStud2,
    stud2.prezStud AS prezStud2
FROM stud stud1
JOIN stud stud2
WHERE   stud1.imeStud  LIKE 'K%'
    AND stud1.prezStud LIKE 'K%'
    AND stud2.imeStud  LIKE 'K%'
    AND stud2.prezStud LIKE 'K%';
