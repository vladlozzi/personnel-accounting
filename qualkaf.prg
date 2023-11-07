SET SAFETY OFF 

*TmpDir='C:\WINDOWS\TEMP'
LOCAL temp,tpp
WAIT [Зачекайте...] WINDOW NOWAIT 
m.temp=TmpDir+[\vop1]

potdat=Thisform.txtPredDate.Value
SELECT 0
 m.main=m.shlyx+'\data\main' 


SELECT DIST nest1,nest2,nest3,sprava,name1,name2,name3,sex,pos, ;
	vstup,vzvan,INT((potdat-datanar)/365.25) AS vik, datazah, ;
	SPACE(30) AS posada, SPACE(30) AS txtpos, 000 AS stagpos, ;
	000 AS RangPos, ;
	SPACE(80) AS Povn1, SPACE(80) AS Povn2, SPACE(80) AS Povn3 ; 
	FROM (m.main) INTO TABL (m.temp) WHERE potstan ;
	ORDER BY nest1,nest2,nest3,name1,name2,name3
USE IN main

SELECT 0
 m.posad=m.shlyx+'\dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT 0
 m.nest1=m.shlyx+'\dov\nest1'
USE (m.nest1) NOUP
n1=TmpDir+'\n1'
INDEX ON nest1 TO (m.n1) COMPACT
SELECT 0
m.nest2=m.shlyx+'\dov\nest2'
USE (m.nest2) NOUP
n2=TmpDir+'\n2'
INDEX ON nest1+nest2 TO (m.n2) COMPACT
SELECT 0
m.nest3=m.shlyx+'\dov\nest3'
USE (m.nest3) NOUP
n3=TmpDir+'\n3'
INDEX ON nest2+nest3 TO (m.n3) COMPACT
SELECT vop1

SCAN
	SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
	SELECT Posad
	IF SEEK(m.n1p)
		m.posada=posada
		m.rang=rang
		REPLACE vop1.posada WITH m.posada
		REPLACE vop1.RangPos WITH m.Rang
	ENDIF
	SELECT nest1
	IF SEEK(m.nest1)
		m.povn1=povnest1
		REPLACE vop1.povn1 WITH m.povn1
	ENDIF
	SELECT nest2
	IF SEEK(m.nest1+m.nest2)
		m.povn2=povnest2
		REPLACE vop1.povn2 WITH m.povn2
	ELSE
		REPLACE vop1.povn2 WITH m.nest2
	ENDIF
	SELECT nest3
	IF SEEK(m.nest2+m.nest3)
		m.povn3=povnest3
		REPLACE vop1.povn3 WITH m.povn3
	ELSE
		REPLACE vop1.povn3 WITH m.nest3
	ENDIF
ENDSCAN

USE IN Posad
USE IN Nest1
USE IN Nest2
USE IN Nest3

GO TOP

SELECT 0
m.tpp=TmpDir+'\tpp.dbf'
m.prizperm=m.shlyx+'\data\prizperm.dbf'
=messagebox(m.prizperm)
COPY FILE (m.prizperm) TO (m.tpp)
USE (tpp) 
REPLACE pos WITH 'зав.кафедри' FOR pos='зав.каф'
REPLACE pos WITH 'зав.лабораторії' FOR pos='зав.лаб'

INDEX ON sprava+DTOS(Dvstup) TO (m.temp) COMPACT

SELECT vop1
SCAN
	m.cSprava=sprava
	m.cPosada=posada
	SELECT Tpp
	st=0
	COUNT FOR sprava==cSprava AND pos=m.cPosada TO kd
	IF kd>0
		SCAN FOR sprava==cSprava AND pos=m.cPosada
			st=st+(IIF(EMPTY(dzviln),DATE(),dzviln)-dvstup)
		ENDSCAN
	ENDIF
	SELECT vop1
	REPLACE stagpos WITH IIF(kd>0,INT(st/365.25),-1)
ENDSCAN

USE IN Tpp
*BROWSE NOEDIT NOAP NODE
USE IN vop1

SELECT  nest1,nest2,nest3,povn2,povn3, ;
		name1,name2,name3,posada,txtpos,vik,sex,rangpos, ;
		vstup,vzvan,datazah ;
		FROM (m.temp) INTO TABLE (m.tpp) WHERE nest1='01' ;
		ORDER BY nest1,povn1,povn2,povn3,rangpos,name1,name2,name3
USE IN vop1
fakkaf=TmpDir+'\fakkaf'
SELECT  DIST nest2 AS fak,nest3 AS kaf,povn2,povn3 FROM (m.tpp) INTO TABLE (m.fakkaf) ;
		ORDER BY povn2,povn3
* BROWSE NOEDIT NOAP NODE
SELECT Tpp

m.form=m.shlyx+'\form\'
EXPORT TO m.FORM+'quaskkaf' TYPE XLS

REPLACE ALL txtpos WITH posada
REPLACE txtpos WITH 'професор, д.н.' ;
	FOR posada='професор' AND vstup='д.'
REPLACE txtpos WITH 'професор, к.н.' ;
	FOR posada='професор' AND vstup='к.'
REPLACE txtpos WITH 'доцент, к.н.' ;
	FOR posada='доцент' AND (NOT EMPTY(vstup) OR NOT EMPTY(vzvan))
REPLACE txtpos WITH 'професор, д.н.' ;
	FOR posada='зав.каф' AND vstup='д.'
REPLACE txtpos WITH 'професор, к.н.' ;
	FOR posada='зав.каф' AND vstup='к.' AND vzvan='професор'
REPLACE txtpos WITH 'доцент, к.н.' ;
	FOR (posada='зав.каф') AND (vzvan='доцент' OR vzvan='ст.н.с' OR vstup=[к.])
REPLACE txtpos WITH 'доцент б/д' ;
	FOR (posada='зав.каф' OR posada='доцент') AND EMPTY(vzvan) AND EMPTY(vstup)
REPLACE txtpos WITH 'асистент, к.н.' ;
	FOR posada='асистент' AND NOT EMPTY(vstup)

REPLACE ALL rangpos WITH 0

REPLACE rangpos WITH 1 FOR txtpos=[професор, д.н.]
REPLACE rangpos WITH 2 FOR txtpos=[професор, к.н.]
REPLACE rangpos WITH 3 FOR txtpos=[доцент, к.н.]
REPLACE rangpos WITH 4 FOR txtpos=[доцент б/д]
REPLACE rangpos WITH 5 FOR txtpos=[асистент, к.н.]
REPLACE rangpos WITH 6 FOR txtpos=[асистент ]
REPLACE rangpos WITH 7 FOR txtpos=[ст.викладач]
REPLACE rangpos WITH 8 FOR txtpos=[викладач]
REPLACE rangpos WITH 9 FOR txtpos=[стажист-викладач]
GO TOP
* BROWSE NOEDIT NOAP NODE

m.temp=TmpDir+[\temppos]
SELECT DIST txtpos,rangpos AS nstup ;
	FROM (m.tpp) INTO TABLE (m.temp) ORDER BY rangpos
* BROWSE NOEDIT NOAP NODE
m.tab1=TmpDir+[\tab1]
CREATE TABLE (m.tab1) (fak C(10),kaf C(10),txtpos C(30), ;
		ndo30 N(3),n3135 N(3),n3640 N(3),n4145 N(3),n4650 N(3), ;
		n5155m N(3),n5155w N(3),n5660m N(3),n5660w N(3), ;
		n6165m N(3),n6165w N(3),n6670m N(3),n6670w N(3), ;
		n71stm N(3),n71stw N(3),nsum N(3))
SELECT fakkaf		
SCAN && факульт. і каф.
	m.fak=fak
	m.kaf=kaf
	SELECT temppos
	GO TOP
	SCAN && особовий склад
		m.txtpos=txtpos
		SELECT Tpp
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik<=30 TO m.ndo30
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=31 AND vik<=35 TO m.n3135
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=36 AND vik<=40 TO m.n3640
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=41 AND vik<=45 TO m.n4145
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=46 AND vik<=50 TO m.n4650
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=51 AND vik<=55 AND sex=[ч] TO m.n5155m
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=51 AND vik<=55 AND sex=[ж] TO m.n5155w
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=56 AND vik<=60 AND sex=[ч] TO m.n5660m
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=56 AND vik<=60 AND sex=[ж] TO m.n5660w
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=61 AND vik<=65 AND sex=[ч] TO m.n6165m
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=61 AND vik<=65 AND sex=[ж] TO m.n6165w
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=66 AND vik<=70 AND sex=[ч] TO m.n6670m
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=66 AND vik<=70 AND sex=[ж] TO m.n6670w
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=71 AND sex=[ч] TO m.n71stm
		COUNT FOR nest3=m.kaf AND txtpos=m.txtpos AND vik>=71 AND sex=[ж] TO m.n71stw
		m.nsum=m.ndo30+m.n3135+m.n3640+m.n4145+m.n4650+ ;
			m.n5155m+m.n5155w+m.n5660m+m.n5660w+ ;
			m.n6165m+m.n6165w+m.n6670m+m.n6670w+ ;
			m.n71stm+m.n71stw
		INSERT INTO (m.tab1) FROM MEMVAR
	ENDSCAN
ENDSCAN
USE IN Temppos
USE IN Tpp
SELECT Tab1
GO TOP
BROWSE NOEDIT NOAP NODE

EXPORT TO m.FORM+'quaskkaf' TYPE XLS
*EXPORT TO FORM\tqualkaf TYPE XLS
USE
USE IN fakkaf
*WAIT [Таблиця сформована] WINDOW
WAIT [Таблиця сформована у файлі FORM\tqualkaf.xls] WINDOW
