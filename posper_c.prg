SET DELETED ON
SET SAFETY OFF
SET ESCAPE OFF
SET TALK OFF
SET CONSOLE OFF
SET SPACE OFF
 
*
* ��������� ����� � �������� � �������� � ��������� �����������
*
SELECT 0
USE data\prizperm
SELECT 0
USE dov\posad
INDEX ON posada TO iii COMPACT
SET PRINTER TO prizperm.txt
SET PRINTER ON
? "����˲� ��������� ��²���²������� ����Ѳ�"
? "� ��ǲ ��������� ����̲���� ������� � ��²����� �����"
SELECT prizperm
SCAN
	m.pos=pos
	ir=RECNO()
	m.sprava=sprava
	SELECT posad
	GO TOP
	LOCATE FOR posada==m.pos
	IF NOT FOUND()
		? "������ "+m.pos+" �� �������� � ��������. ������ � "+ALLTRIM(m.sprava)+", ����� � "+STR(ir,6,0)
	ENDIF
ENDSCAN
SET PRINTER OFF
SET PRINTER TO
USE IN prizperm
USE IN posad

MODIFY COMMAND prizperm.txt NOEDIT