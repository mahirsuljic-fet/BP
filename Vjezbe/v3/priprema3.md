## Zadatak 1
```
SELECT DISTINCT sifZupanija 
FROM mjesto 
WHERE nazMjesto LIKE 'Z%';

SELECT DISTINCT sifZupanija 
FROM mjesto 
WHERE nazMjesto RLIKE '^Z';
```

## Zadatak 2
```
SELECT * 
FROM stud 
WHERE 
    datRodStud BETWEEN STR_TO_DATE('1.5.1982.', '%d.%m.%Y') 
    AND STR_TO_DATE('1.9.1982.', '%d.%m.%Y') 
    AND (
        prezStud LIKE 'R%' 
        OR prezStud LIKE 'P%' 
        OR prezStud LIKE 'S%' 
        OR prezStud LIKE 'V%'
    );
```

## Zadatak 3
```
SELECT * 
FROM stud 
WHERE 
    datRodStud BETWEEN '1982-05-01' AND '1982-09-01' 
    AND prezStud RLIKE '^[RPSV]';
```

## Zadatak 4
```
SELECT nazMjesto 
FROM mjesto 
WHERE (
        nazMjesto LIKE 'A%'  OR
        nazMjesto LIKE 'E%'  OR
        nazMjesto LIKE 'I%'  OR
        nazMjesto LIKE 'O%'  OR
        nazMjesto LIKE 'U%'
    ) AND (
        nazMjesto LIKE '%a'  OR
        nazMjesto LIKE '%e'  OR
        nazMjesto LIKE '%i'  OR
        nazMjesto LIKE '%o'  OR
        nazMjesto LIKE '%u'
    );
```

## Zadatak 5
```
SELECT nazMjesto 
FROM mjesto 
WHERE nazMjesto RLIKE '^[^AEIOU]' 
    AND nazMjesto RLIKE '[^aeiou]$';
```

## Zadatak 6
```

SELECT nazMjesto 
FROM mjesto 
WHERE nazMjesto RLIKE '^[^AEIOU]' 
    OR nazMjesto RLIKE '[^aeiou]$';
```

## Zadatak 7
```
SELECT * 
FROM stud 
WHERE
    SUBSTR(jmbgStud, 1, 2) <> DAY(datRodStud)
    OR SUBSTR(jmbgStud, 3, 2) <> MONTH(datRodStud)
    OR SUBSTR(jmbgStud, 5, 3) <> (YEAR(datRodStud) % 1000);
```

## Zadatak 8
```
SELECT AVG(koef) AS prosjecniKoef 
FROM nastavnik 
WHERE pbrStan = 10000;
```

## Zadatak 9
```
SELECT 
    MIN(datIspit) AS datumPrvogIspita, 
    MAX(datIspit) AS datumZadnjegIspita 
FROM ispit;
```

## Zadatak 10
```
SELECT COUNT(DISTINCT sifOrgJed) AS razOrgJed 
FROM nastavnik 
WHERE pbrStan = 10000;
```

## Zadatak 11
```
SELECT 
    DATEDIFF(MAX(datRodStud), 
    MIN(datRodStud)) AS razlika 
FROM stud;
```

## Zadatak 12
```
SELECT AVG(ocjena) prosjecnaOcjena 
FROM ispit 
WHERE YEAR(datIspit) = 1999 AND ocjena > 1;
```

## Zadatak 13
```
SELECT 
    COUNT(ocjena) AS brojPolozenih, 
    AVG(ocjena) prosjecnaOcjena 
FROM ispit 
WHERE sifPred = 146 AND ocjena > 1;
```

## Zadatak 14
```
SELECT AVG(DATEDIFF(CURRENT_DATE, datRodStud)) 
FROM stud 
WHERE pbrRod = 10000 
    AND (imeStud RLIKE '^[AEIOU]' OR imeStud RLIKE '[aeiou]$');
```

## Zadatak 15
```
SELECT COUNT(DISTINCT sifPred) AS brojPredmeta 
FROM rezervacija 
WHERE oznDvorana LIKE 'B%' 
    AND oznVrstaDan IN ('UT', 'SR');
```

## Zadatak 16
```
SELECT COUNT(*), AVG(ocjena) 
FROM ispit 
WHERE MONTH(datIspit) = 7 
    AND WEEKDAY(datIspit) = 4 
    AND DATE_ADD(datIspit, INTERVAL 5 YEAR) < CURRENT_DATE;
```

## Zadatak 17
```
SELECT SUM(upisanoStud) AS brojStudenata 
FROM pred 
WHERE brojSatiTjedno > 3 AND nazPred LIKE '%tehnike%'
```
