## Bitni pojmovi

**r - relacija** (sadrzaj tabele)

**R(A, B, C, ...) - relacijska shema** \
spisak atributa tabele (ono sto vidis na vrhu tabele kad je otvoris), gdje su A, B, C, ... atrubuti (kolone) relacijske sheme (npr. mbrStud)

**π<sub>A,B,C,...</sub>\(r\) - projekcija** r po atrubutima A,B,C,... \
uzmi kolone A,B,C,... iz r pri cemu ni jedna n-torka (red) ne smije biti ista \
(SELECT DISTINCT A, B, C FROM r)

**σ<sub>USLOV</sub>\(r\) - selekcija** \
uzmi sve n-torke (redove) relacije r koje zadovoljavaju USLOV \
(SELECT * FROM r WHERE USLOV)

**unijska kompatibilnost** \
Dvije relacije su unijski kompatibilne ako imaju iste nazive i domene svih atributa. Nazivi ne moraju biti identicni, moze se izvrsit preimenovanje.

**PRIMJER 1**\
r1:
mbr    |imeStud|prez
-------|-------|-----
1      |ime1   |prez1
2      |ime2   |prez2

r2:
mbrStud|prez   |ime 
-------|-------|----
3      |prez3  |ime3
4      |prez4  |ime4

r1 i r2 su unijski kompatibilne jer:
mbr i mbrStud imaju isti domen i jedan se moze preimenovat u drugi (maticni brojevi)
imeStud i ime imaju isti domen i moze se izvrsit preimenovanje
prez i prez imaju isti naziv i domen
redoslijed atributa nije bitan

**PRIMJER 2** \
r3:
mbr|ime |brIndex
---|----|-------
1  |ime1|123
2  |ime2|567

r4:
mbr|ime |prez
---|----|-----
3  |ime3|prez3
4  |ime4|prez4

r3 i r4 nisu unijski kompatibilne jer brIndex i prez nemaju isti domen, a samim time se ne mogu ni preimenovati jedan u drugi


**r1 ∪ r2 - unija** \
vraca sve n-torke koje se nalaze ili u r1 ili u r2 ili u obje (ako se nalazi u obje samo se jednom prikazuje), pri cemu r1 i r2 moraju biti unijski kompatibilne

**r1 ∩ r2 - presjek** \
vraca sve n-torke koje se nalaze u obje relacije (i u r1, i u r2), pri cemu r1 i r2 moraju biti unijski kompatibilne

**r1 \ r2 - razlika** \
vraca sve n-torke koje se nalaze u r1, ali ne i u r2, pri cemu r1 i r2 moraju biti unijski kompatibilne

**r1 × r2 - cross join** \
dekartov proizvod r1 i r2 (svaka n-torka iz r1 se spaja sa svakom n-torkom iz r2)


**r1 ▷◁ r2 - natural join, prirodno spajanje** \
trazi se atribut (kolona) koji ima isto ime i domen i u r1, i u r2 (npr. mbrStud iz stud i mbrStud iz ispit), zatim se n-torke iz r1 spajaju sa n-torkama iz r2 koje imaju istu vrijednost tog atributa (npr. mbrStud), pri cemu ce se zajednicki atribut pojaviti samo jednom \
(SELECT * FROM r1 NATURAL JOIN r2)

**PRIMJER** \
r1:
A |B |C 
--|--|--
a1|b1|c1
a2|b2|c2

r2:
C |D |E 
--|--|--
c1|d1|e1
c2|d2|e2

r1 i r2 imaju zajednicki atribut C

r1 ▷◁ r2:
A |B |C |D |E 
--|--|--|--|--
a1|b1|c1|d1|e1
a2|b2|c2|d2|e2


**r1 ▷<sub>USLOV</sub>◁ r2 - uslovno spajanje (USLOV se pise ispod znaka ▷◁)** \
spajanje r1 i r2 na takav nacin da je za svaku n-torku rezultujuce relacije ispunjen USLOV \
(SELECT * FROM r1 JOIN r2 ON USLOV)

**PRIMJER**
r1:
A |B |C 
--|--|--
a1|b1|c1
a2|b2|c2

r2:
C |D |E 
--|--|--
c1|d1|e1
c2|d2|e2

r1 ▷<sub>r1.C=r2.C</sub>◁ r2:
A |B |r1.C |r2.C |D |E 
--|--|-----|-----|--|--
a1|b1|c1   |c1   |d1|e1
a2|b2|c2   |c2   |d2|e2

## Rjesenja zadatka 12

### a)
Operator presjeka cemo ostavit za malo kasnije. Imamo projekciju relacije r1 po atributima B i C. Gledamo relacijsku shemu za r1: R1(A, B, C). Znaci uzimamo drugu i trecu kolonu iz relacije r1:

PI B,C (r1):
B |C
--|-
b |c
d |k
e |m
m |k

Zatim imamo jos jednu projekciju. Gledamo shemu R3, zakljucimo da trebamo uzet prve dvije kolone (jer su prve dvije B i C, a po njima radimo projekciju), pa imamo:

PI B,C (r3):
B |C
--|-
b |c
m |k
m |m
m |k

Zatim dolazimo do presjeka. Trazimo sve n-torke koje su i u rezultatu prve projekcije, i u rezultatu druge projekcije. Vidi se da su b|c i m|k u obje kolone pa nam je to konacan rezultat:

Rezultat:
B |C
--|-
b |c
m |k


b)
Imamo projekciju r1 po B, sto znaci da uzimamo B kolonu (drugu) iz r1.
Imamo projekciju r3 po B, sto znaci da uzimamo B kolonu (prvu) iz r3.
Razlikom dobijamo sve relacije koje su u r1 koloni B, a nisu u r3 koloni B.

PI B (r1):
|B|
|-|
|b|
|d|
|e|
|m|

PI B (r3):
|B|
|-|
|b|
|m|
|m|
|m|

Rezultat:
|B|
|-|
|d|
|e|

c)
Imamo prirodno spajanje r2 i r3.
Pogledamo sheme R2 i R3, zakljucimo da spajamo po D i E, jer su im te kolone zajednicke.
Zatim vrsimo projekciju dobijene relacije po E, sto znaci uzmemo samo kolonu E pri cemu izbacujemo duplikate.
Desno od operatora razlika imamo selekciju relacije r3 po uslovu D>7, sto znaci da uzimamo sve n-torke iz r3 u kojima je atribut D veci od 7.
Zatim vrsimo projekciju dobijene relacije po E, sto znaci uzmi samo kolonu E, odbaci sve ostalo.
Konacno dolazim odo razlike. Trazimo sve n-torke koje su u lijevoj relaciji, ali ne i u desnoj.

Rezultat:
|E|
|-|
|f|

d)
Lijevo od operatora razlike imamo cross join (dekartov proizvod) relacija r1 i r2, sto znaci da svaku n-torku iz r1 spajamo sa svakom n-torkom iz r2.
Desno od operatora razlike imamo prirodno spajanje relacija r1 i r3. Pogledamo sheme, zakljucimo da cemo spajati po atrubutima B i C.
Na kraju trazimo sve n-torke koje se nalaze u lijevoj relaciji, ali ne i u desnoj.

Rezultat:
A |B |C |D |E
--|--|--|--|-
a |m |k |5 |f
a |e |m |5 |f
a |d |k |5 |f
a |e |m |7 |g
a |d |k |7 |g
a |b |c |7 |g
a |m |k |11|e
a |e |m |11|e
a |d |k |11|e
a |b |c |11|e
a |e |m |11|g
a |d |k |11|g
a |b |c |11|g

e)
Lijevo od znaka presjeka imamo projekciju r1 po atributima B i C.
Desno od znaka presjeka imamo projekciju prirodnog spajanja r2 i r3 po atributima B i C.
Prirodno spajanje r2 i r3 ce se izvrsiti po atributima D i E.
Presjekom trazimo n-torke koje postoje i u lijevoj i u desnoj relaciji.
Konacno vrsimo selekciju tako da uzimamo sve n-torke ciji je atribut B veci od 'd' i ciji atribut C nije 'm'.

Rezultat:
B |C
--|-
m |k
