## Zadatak 1
```
SELECT 
    pred.kratPred,
    pred.nazPred,
    AVG(ispit.ocjena) AS prosjek
FROM pred
JOIN ispit ON pred.sifPred = ispit.sifPred
WHERE ispit.ocjena > 1
GROUP BY pred.sifPred, 1, 2;
```

## Zadatak 2
```
SELECT 
    zupanija.sifZupanija, 
    COUNT(ocjena) AS brojOcjena
FROM zupanija
JOIN mjesto ON mjesto.sifZupanija = zupanija.sifZupanija
JOIN nastavnik ON nastavnik.pbrStan = mjesto.pbr
JOIN ispit ON ispit.sifNastavnik = nastavnik.sifNastavnik
WHERE ocjena = 1
GROUP BY 1;
```

## Zadatak 3
```
SELECT 
    nastavnik.imeNastavnik, 
    COUNT(ocjena) AS brojOcjena
FROM nastavnik
JOIN ispit ON ispit.sifNastavnik = nastavnik.sifNastavnik
WHERE ocjena > 1
GROUP BY nastavnik.sifNastavnik, 1;
```

## Zadatak 4
```
SELECT 
    orgjed.sifOrgjed, 
    orgjed.nazOrgjed, 
    COUNT(podOrgjed.sifOrgjed) AS brPodOrgJed
FROM orgjed
JOIN orgjed podOrgjed ON podOrgjed.sifNadorgjed = orgjed.sifOrgjed
GROUP BY 1, 2;
```

## Zadatak 5
```
SELECT 
    stud.*, 
    AVG(ispit.ocjena) AS prosjek
FROM stud
JOIN ispit ON ispit.mbrStud = stud.mbrStud
WHERE ocjena > 1
GROUP BY 1, 2, 3, 4, 5, 6, 7
HAVING AVG(ispit.ocjena) > 3;
```

## Zadatak 6
```
SELECT 
    mjesto.pbr, 
    mjesto.nazMjesto, 
    COUNT(mbrStud) AS brStud
FROM mjesto
JOIN stud ON stud.pbrRod = mjesto.pbr
GROUP BY 1, 2
HAVING COUNT(mbrStud) > 5;
```

## Zadatak 7
```
SELECT 
    stud.mbrStud, 
    stud.prezStud, 
    CONCAT(SUBSTR(stud.imeStud, 1, 1), ".", SUBSTR(stud.prezStud, 1, 1), ".") AS inicijali
FROM stud
JOIN ispit ON ispit.mbrStud = stud.mbrStud
WHERE ispit.ocjena = 1
GROUP BY 1, 2, ispit.sifPred
HAVING COUNT(ispit.ocjena) >= 3;
```

## Zadatak 8
```
-- a)
SELECT mbrStud, ocjena
FROM ispit
GROUP BY 1, 2
HAVING COUNT(DISTINCT datIspit) > 1;

-- b)
SELECT pbr, sifZupanija
FROM mjesto
GROUP BY 1, 2
HAVING COUNT(DISTINCT nazMjesto) > 1;

-- c)
SELECT imeNastavnik
FROM nastavnik
GROUP BY 1
HAVING COUNT(DISTINCT prezNastavnik) > 1;

-- d)
(
  SELECT sifPred, datIspit, ocjena
  FROM ispit
  GROUP BY 1, 2, 3
  HAVING COUNT(DISTINCT mbrStud) > 1
)
UNION
(
  SELECT sifPred, datIspit, ocjena
  FROM ispit
  GROUP BY 1, 2, 3
  HAVING COUNT(DISTINCT sifNastavnik) > 1
);
```

## Zadatak 9
```
SELECT 
    mjesto.pbr, 
    mjesto.nazMjesto, 
    COUNT(*) AS brPolIspit
FROM mjesto
JOIN stud ON stud.pbrStan = mjesto.pbr
JOIN ispit ON ispit.mbrStud = stud.mbrStud
WHERE ispit.ocjena > 1
GROUP BY 1, 2
ORDER BY mjesto.nazMjesto;
```

## Zadatak 10
```
SELECT
    stud.imeStud,
    stud.prezStud,
    COUNT(*) AS brPolIspit
FROM stud
JOIN ispit ON ispit.mbrStud = stud.mbrStud
WHERE ispit.ocjena > 1
GROUP BY 1, 2
ORDER BY 3 DESC, 2, 1;
```

## Zadatak 11
```
CREATE TEMPORARY TABLE mjestoTmp AS
SELECT mjesto.*, COUNT(*) AS brojNast
FROM mjesto
JOIN nastavnik ON nastavnik.pbrStan = mjesto.pbr
GROUP BY 1, 2, 3;
```

## Zadatak 12
```
SELECT MONTH(stud.datRodStud) AS mjesec, COUNT(mbrStud) AS studRodjeno
FROM stud
GROUP BY 1
ORDER BY 2 DESC;
```

## Zadatak 13
```
SELECT stud.*
FROM stud
JOIN ispit ON ispit.mbrStud = stud.mbrStud
WHERE ispit.ocjena > 1
GROUP BY 1, 2, 3, 4, 5, 6, 7
HAVING 
    AVG(ispit.ocjena) > (
        SELECT AVG(ispitPod1.ocjena)
        FROM stud studPod1
        JOIN ispit ispitPod1
        WHERE stud.mbrStud <> studPod1.mbrStud
    )
    OR
    COUNT(ispit.ocjena) > (
        SELECT AVG(brIspit)
        FROM brIspitTmp
        WHERE brIspitTmp.mbrStud <> stud.mbrStud
    );
```
