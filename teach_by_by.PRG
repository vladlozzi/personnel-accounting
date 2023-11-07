m.shlyx = '.'
IF ALLTRIM(m.shlyx)=='.' 
	m.maind=FULLPATH('')+'data\main'
	m.posadc=FULLPATH('')+'dov\posad'
	m.nest3c=FULLPATH('')+'dov\nest3'
ELSE
	m.maind=m.shlyx+'data\main'
	m.posadc=m.shlyx+'dov\posad'
	m.nest3c=m.shlyx+'dov\nest3'
ENDIF

* Науково-педагогічні штатні працівники
SELECT a.name1, a.name2, a.name3, a.pos, b.posada, c.povnest3, a.datanar ;
	FROM (m.maind) a, (m.posadc) b, (m.nest3c) c ;
	INTO CURSOR teachers ;
	WHERE a.potstan AND b.pos=a.pos ;
		AND b.nest1=a.nest1 AND c.nest1=a.nest1 AND c.nest3=a.nest3 ;
		AND YEAR(a.datanar) = 1973 ;
		AND (b.npstag OR ALLTRIM(b.posada)="директор" AND b.nest1='00') ;
	ORDER BY a.datanar,c.povnest3,a.name1,a.name2,a.name3
USE IN main
USE IN nest3
USE IN posad
SELECT teachers
BROWSE NOEDIT NOAPPEND NODELETE
EXPORT TO .\FORM\by_birth_year.xls TYPE XL5
USE
