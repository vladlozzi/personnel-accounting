*WAIT m.nest1+STR(m.pos) WINDOW
*m.main=m.shlyx+'\data\main'
SELECT main
potrec=RECNO()
IF NOT ISBLANK(main.pos)
	SELECT 0
m.posad=m.shlyx+'\dov\posad'
	USE (m.posad) NOUP AGAIN
	LOCATE FOR nest1==m.Nest1 AND pos=m.Pos
	IF FOUND()
		m.cPosada=ALLTRIM(posada)
	ELSE
		m.cPosada=''
	ENDIF
	USE
ELSE
	m.cPosada='???'
ENDIF

Stzagr=0
Stzagm=0
StUnir=0
StUnim=0
StNPr=0
StNPm=0
StPr=0 && обнуленн€ пед стажу-роки 
StPm=0 && обнуленн€ пед стажу-м≥с€ц≥ 
StNr=0 && обнуленн€ наук стажу-роки 
StNm=0 && обнуленн€ наук стажу-м≥с€ц≥ 

SELECT main

GO PotRec

DO TrudStag && “рудовий стаж
*USE (m.main)
SELECT main
*	MESSAGEBOX('6')
GO PotRec

DO FORM Daniprac
