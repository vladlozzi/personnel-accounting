SET DELETED ON
SET CONSOLE OFF
SET SAFETY OFF

SELECT a.name1, a.name2, a.name3, a.vstup, a.vzvan ;
FROM DATA\main a, DOV\posad b INTO TABLE naukpedmain ;
WHERE a.potstan AND NOT DELETED() AND ;
  a.pos = b.pos AND a.nest1 == b.nest1 AND ;
  b.npstag AND a.nest1 == "01"
USE IN main
USE IN posad

USE naukpedmain NOUPDATE
BROWSE
COUNT TO m.npmain
COUNT FOR vstup = "�" TO m.doctorsmain
COUNT FOR vstup = "�" TO m.candidatesmain
COUNT FOR vzvan = "�" TO m.professorsmain
COUNT FOR vzvan = "�" TO m.docentsmain
USE

SET PRINTER TO FORM\naukpedmain.txt
SET PRINTER ON
? "ʳ������ �������-����������� ���������� �� �������� ����� ������: " + ALLTRIM(STR(m.npmain))
? "�������, � �������� �������� ������� ����: " + ALLTRIM(STR(m.doctorsmain))
? "         � �������� �������� ��������� ����: " + ALLTRIM(STR(m.candidatesmain))
? "         � ������ ������� ���������: " + ALLTRIM(STR(m.professorsmain))
? "         � ������ ������� �������: " + ALLTRIM(STR(m.docentsmain))
SET PRINTER OFF
SET PRINTER TO
MODIFY COMMAND FORM\naukpedmain.txt NOEDIT
