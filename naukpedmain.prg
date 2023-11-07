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
COUNT FOR vstup = "д" TO m.doctorsmain
COUNT FOR vstup = "к" TO m.candidatesmain
COUNT FOR vzvan = "п" TO m.professorsmain
COUNT FOR vzvan = "д" TO m.docentsmain
USE

SET PRINTER TO FORM\naukpedmain.txt
SET PRINTER ON
? "Кількість науково-педагогічних працівників за основним місцем роботи: " + ALLTRIM(STR(m.npmain))
? "Зокрема, з науковим ступенем доктора наук: " + ALLTRIM(STR(m.doctorsmain))
? "         з науковим ступенем кандидата наук: " + ALLTRIM(STR(m.candidatesmain))
? "         з ученим званням професора: " + ALLTRIM(STR(m.professorsmain))
? "         з ученим званням доцента: " + ALLTRIM(STR(m.docentsmain))
SET PRINTER OFF
SET PRINTER TO
MODIFY COMMAND FORM\naukpedmain.txt NOEDIT
