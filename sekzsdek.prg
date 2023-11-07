WAIT 'Зачекайте...' WINDOW NOWAIT
tmpdIR=SYS(2023)
dopb=TmpDir+'\dopb'
SELECT 0
m.main=m.shlyx+'\data\posad'
m.posad=m.shlyx+'\dov\posad'
SELECT a.nest1,a.nest2,a.nest3,a.name1,name2,name3,a.pos,b.posada, ;
	a.doplata ;
	FROM (m.main) A, (m.posad) B ;
	WHERE(a.nest1=b.nest1.AND.a.pos=b.pos) ;
	INTO TABLE (dopb) ORDER BY a.nest1,a.nest2,a.nest3,b.rang ;
	GROUP BY a.nest1,a.nest2,a.nest3,b.posada,a.vzvan,a.vstup,a.oklad,a.pdopl,a.pnadb
USE IN main
USE IN posad
SELECT DopB
* BROWSE NOEDIT NOAPPEND NODELETE
SELECT nest2,ALLT(name1)+' '+ALLT(name2)+' '+ALLT(name3) AS priz,posada ;
	FROM (dopb) INTO TABLE sekzsdek WHERE posada=[секр] OR posada=[мет] OR doplata=[за заст.декана] ;
	ORDER BY nest2 

USE
RETURN

