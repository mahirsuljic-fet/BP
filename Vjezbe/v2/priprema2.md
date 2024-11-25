## Zadatak 1
```
SELECT sifNastavnik, imeNastavnik, prezNastavnik, koef 
FROM nastavnik;
```

## Zadatak 2
```
SELECT * 
FROM pred;
```

## Zadatak 3
```
SELECT DISTINCT imeStud 
FROM stud;
```

## Zadatak 4
```
SELECT DISTINCT sifNastavnik 
FROM ispit 
WHERE sifPred = 146 AND ocjena = 1;
```

## Zadatak 5
```
SELECT mbrStud 
FROM ispit 
WHERE sifPred = 262 AND ocjena > 1;
```

## Zadatak 6
```
SELECT 
    imeNastavnik, 
    prezNastavnik, 
    800 * (koef + 0.4) AS plata 
FROM nastavnik;
```

## Zadatak 7
```
SELECT prezNastavnik 
FROM nastavnik 
WHERE 800 * (koef + 0.4) BETWEEN 3500 AND 8000;
```

## Zadatak 8
```
SELECT 
    prezNastavnik, 
    SUBSTR(imeNastavnik, 1, 1) AS prvoSlovoImena 
FROM nastavnik;
```

## Zadatak 9
```
SELECT 
    imeStud, 
    prezStud, 
    CONCAT(SUBSTR(imeStud, 1, 1), '.', SUBSTR(prezStud, 1, 1), '.') AS inicijali 
FROM stud;
```

## Zadatak 10
```
SELECT * 
FROM ispit 
WHERE MONTH(datIspit) = 7;
```

## Zadatak 11
```
SELECT * 
FROM ispit 
WHERE WEEKDAY(datIspit) = 2 AND MONTH(datIspit) = 8;
```

## Zadatak 12
```
SELECT 
    mbrStud, 
    ocjena, 
    datIspit, 
    CURRENT_DATE AS danasnjiDatum, 
    DATEDIFF(CURRENT_DATE, datIspit) AS protekloDana 
FROM ispit;
```

## Zadatak 13
```
SELECT * 
FROM stud 
WHERE datRodStud = DATE_SUB(CURRENT_DATE, INTERVAL 25 YEAR);
```

## Zadatak 14
```
SELECT 
    sifNastavnik, 
    mbrStud, 
    ocjena, 
    DATEDIFF(CURRENT_DATE, "2009-01-01") AS protekloDana 
FROM ispit;
```

## Zadatak 15
```
SELECT 
    mbrStud, 
    sifPred, 
    ocjena, 
    datIspit, 
    DATE_ADD(datIspit, INTERVAL 4800 DAY) AS 3800danaIspita 
FROM ispit 
WHERE DATE_ADD(datIspit, INTERVAL 4800 DAY) >= CURRENT_DATE;
```

## Zadatak 16
```
SELECT 
    mbrStud, 
    sifPred, 
    ocjena, 
    datIspit, 
    DATE_ADD(datIspit, INTERVAL 3 YEAR) AS 3godIspita 
FROM ispit;
```

## Zadatak 17
```
SELECT 
    oznDvorana, 
    oznVrstaDan, 
    sat, 
    sifPred AS predmet 
FROM rezervacija;
```

## Zadatak 18
```
SELECT DISTINCT pbrRod, pbrStan 
FROM stud;
```
