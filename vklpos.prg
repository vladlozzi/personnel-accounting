LOCAL temp
WAIT [Зачекайте...] WINDOW NOWAIT 
m.temp=TmpDir+[\vop1]
 m.main=m.shlyx+'\data\main' 

SELECT 0
SELECT DIST nest1,nest2,nest3,sprava,name1,name2,name3,pos, ;
	SPACE(30) AS posada, 00 AS stagpos, 000 AS RangPos, ;
	SPACE(80) AS Povn1, SPACE(80) AS Povn2, SPACE(80) AS Povn3 ; 
	FROM (m.main) INTO TABL (m.temp) WHERE potstan ;
	ORDER BY nest1,nest2,nest3,name1,name2,name3
USE IN main

SELECT 0
m.posad=m.shlyx+'\Dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT 0
m.nest1=m.shlyx+'\Dov\nest1'
USE (m.nest1) NOUP
n1=TmpDir+'\n1'
INDEX ON nest1 TO (m.n1) COMPACT
SELECT 0
m.nest2=m.shlyx+'\Dov\nest2'
USE (m.nest2) NOUP
n2=TmpDir+'\n2'
INDEX ON nest1+nest2 TO (m.n2) COMPACT
SELECT 0
m.nest3=m.shlyx+'\Dov\nest3'
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
		name1,name2,name3,posada,rangpos ;
		FROM (m.temp) INTO TABLE (m.tpp) WHERE nest1='01' ;
		ORDER BY nest1,povn1,povn2,povn3,rangpos,name1,name2,name3

USE IN vop1
SELECT Tpp
m.form=m.shlyx+'\form\'
EXPORT TO m.FORM+'vklpos' TYPE XLS
USE
WAIT [Таблиця сформована у файлі FORM\vklpos.xls] WINDOW
