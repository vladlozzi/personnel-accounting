PARAMETERS pos,nest1
LOCAL posad,ipos0002

SELECT 0

 m.Posad=m.shlyx+'\dov\Posad'

USE (m.Posad) NOUP
ipos0002=TmpDir+[\ipos0002.idx]
INDEX ON STR(pos,3)+nest1 TO (ipos0002) COMPACT

IF SEEK(STR(m.pos,3)+m.nest1)
	m.posad=ALLT(posada)
ELSE
	m.posad=[???]
ENDIF
USE

RETURN m.posad


