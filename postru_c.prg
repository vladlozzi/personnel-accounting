SET DELETED ON
SET SAFETY OFF
SET ESCAPE OFF
SET TALK OFF
SET CONSOLE OFF
SET SPACE OFF
 
*
* Порівняння посад в довіднику з посадами в трудовій діяльності
*
SELECT 0
USE data\trudova
SELECT 0
USE dov\postru
INDEX ON posada TO iii COMPACT
SET PRINTER TO trudova.txt
SET PRINTER ON
? "ПЕРЕЛІК ВИЯВЛЕНИХ НЕВІДПОВІДНОСТЕЙ ЗАПИСІВ"
? "У БАЗІ ТРУДОВОЇ ДІЯЛЬНОСТІ ЗАПИСАМ У ДОВІДНИКУ ПОСАД ПОЗА УНІВЕРСИТЕТОМ"
SELECT trudova
SCAN
	m.postru=postrud
	ir=RECNO()
	m.sprava=sprava
	SELECT postru
	GO TOP
	LOCATE FOR posada==m.postru
	IF NOT FOUND()
		? "Посада "+m.postru+" не знайдена в довіднику. Справа № "+ALLTRIM(m.sprava)+", запис № "+STR(ir,6,0)
	ENDIF
ENDSCAN
SET PRINTER OFF
SET PRINTER TO
USE IN trudova
USE IN postru

MODIFY COMMAND trudova.txt NOEDIT