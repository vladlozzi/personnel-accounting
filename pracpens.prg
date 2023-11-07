LOCAL temp
m.temp=m.TmpDir+[\pracpens]
*m.pracpens=[pracpens]
*m.pracpens=TmpDir+[\pracpens]
SELECT 0
m.main=m.shlyx+'\data\main'
  

SELECT 00000 AS PNumber, sprava, nest1,name1,name2,name3,pos, ;
	SPACE(30) AS posada,datanar,domadr,{} AS dvstup ;
	FROM (m.main) ;
	INTO TABL (m.temp) WHERE potstan ;
		AND ( sex='æ' AND INT((DATE()-datanar)/365.25)>=55 ;
			OR sex='÷' AND INT((DATE()-datanar)/365.25)>=60 ) ;
	ORDER BY name1,name2,name3


USE IN main
SELECT 0
m.posad=m.shlyx+'\dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT pracpens
SCAN
	r=RECNO()
	REPLACE PNumber WITH r
	SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
	SELECT Posad
	IF SEEK(m.n1p)
		m.posada=posada
		REPLACE pracpens.posada WITH m.posada
	ENDIF
ENDSCAN
USE IN Posad
*GO TOP
SELECT 0
m.prizperm=m.shlyx+'\data\prizperm'
USE (m.prizperm) NOUPDATE
INDEX ON sprava+DTOS(dvstup) TO (m.temp) FOR NOT EMPTY(dvstup) COMPACT
SELECT pracpens
SCAN
	m.sprava=sprava
	SELECT prizperm
	LOCATE FOR sprava=m.sprava
	IF FOUND()
		REPLACE pracpens.dvstup WITH dvstup
	ENDIF
ENDSCAN
USE IN prizperm
*BROWSE NOEDIT NOAP NODE
GO TOP
REPORT FORM pracpens PREVIEW
REPORT FORM pracpens TO PRINTER PROMPT

m.form=m.shlyx+'\form\'
outf=m.FORM+'pracpens.prn'
*outf='FORM\pracpens.prn'
REPORT FORM pracpens TO FILE (outf)
USE IN pracpens

