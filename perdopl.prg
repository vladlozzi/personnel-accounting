 select a
 use .\data\main
 select b
 use .\data\doplnad
 SELECT a
 INDEX ON sprava TO zz comp
 SCAN
 spravad=sprava
 STORE 0 TO pnadbd,pdopld
 nadbavkad=SPACE(17)
 doplatad=SPACE(17) 
 IF !EMPTY(pnadb)
     nadbavkad=nadbavka
     pnadbd=pnadb
 SELECT b
 INSERT INTO doplnad(sprava,vid,za_scho,kilkist) values(spravad,'надбавка',nadbavkad,pnadbd)

 SELECT a
 ENDIF
 IF !EMPTY(pdopl)
     doplatad=doplata
     pdopld=pdopl
 SELECT b
 INSERT INTO doplnad (sprava,vid,za_scho,kilkist) values(spravad,'доплата',doplatad,pdopld)
 SELECT a
 ENDIF
  endscan