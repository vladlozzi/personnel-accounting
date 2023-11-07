SET CENTURY ON
SET SAFETY OFF

LOCAL temp
m.temp=[dnarzav]
SELECT 0
SELECT DIST nest1,name1,name2,name3,pos, ;
	SPACE(30) AS posada,datanar	FROM DATA\main ;
	INTO TABL (m.temp) WHERE potstan ;
	ORDER BY name1,name2,name3


USE IN main
SELECT 0
  m.posad=m.shlyx+'\dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT dnarzav
SCAN
	SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
	SELECT Posad
	IF SEEK(m.n1p)
		m.posada=posada
		REPLACE dnarzav.posada WITH m.posada
	ENDIF
ENDSCAN
USE IN Posad
*GO TOP
*BROWSE NOEDIT NOAP NODE
GO TOP
INDEX ON STR(MONTH(datanar))+STR(DAY(datanar))+name1+name2+name3 ;
		TO (m.temp) COMPACT FOR 'прор'$posada OR 'зав'$posada OR 'нач'$posada

COPY TO dnarker FIELDS DATANAR,NAME1,NAME2,NAME3,POSADA TYPE XL5

USE

