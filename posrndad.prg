*=MESSAGEBOX('')
LOCAL temp
m.temp=TmpDir+[\posrndad]
SELECT 0

 m.main=m.shlyx+'\data\main' 

SELECT nest1,name1,LEFT(name2,1)+[.]+LEFT(name3,1)+[.] AS inic, ;
	pos, SPACE(30) AS posada,YEAR(datanar) AS rikn,domadr ;
	FROM (m.main) ;
	INTO TABL (m.temp) WHERE potstan ;
	ORDER BY name1,inic

USE IN main
SELECT 0
m.posad=m.shlyx+'\Dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT posrndad
SCAN
	SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
	SELECT Posad
	IF SEEK(m.n1p)
		m.posada=posada
		REPLACE posrndad.posada WITH m.posada
	ENDIF
ENDSCAN
USE IN Posad
*GO TOP
*BROWSE NOEDIT NOAP NODE
GO TOP
REPORT FORM posrndad PREVIEW
REPORT FORM posrndad TO PRINTER PROMPT
m.form=m.shlyx+'\form\'
outf=m.FORM+'posrndad.prn'
REPORT FORM posrndad TO FILE (outf)
USE IN posrndad

