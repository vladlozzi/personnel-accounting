SET DELETED ON
SET SAFETY OFF
SET ESCAPE OFF
SET TALK OFF
SET CONSOLE OFF
SET SPACE OFF
 
*
* Порівняння посад в довіднику з посадами в службових переміщеннях
*
SELECT 0
USE data\prizperm
SELECT 0
USE dov\posad
INDEX ON posada TO iii COMPACT
SET PRINTER TO prizperm.txt
SET PRINTER ON
? "ПЕРЕЛІК ВИЯВЛЕНИХ НЕВІДПОВІДНОСТЕЙ ЗАПИСІВ"
? "У БАЗІ СЛУЖБОВИХ ПЕРЕМІЩЕНЬ ЗАПИСАМ У ДОВІДНИКУ ПОСАД"
SELECT prizperm
SCAN
	m.pos=pos
	ir=RECNO()
	m.sprava=sprava
	SELECT posad
	GO TOP
	LOCATE FOR posada==m.pos
	IF NOT FOUND()
		? "Посада "+m.pos+" не знайдена в довіднику. Справа № "+ALLTRIM(m.sprava)+", запис № "+STR(ir,6,0)
	ENDIF
ENDSCAN
SET PRINTER OFF
SET PRINTER TO
USE IN prizperm
USE IN posad

MODIFY COMMAND prizperm.txt NOEDIT