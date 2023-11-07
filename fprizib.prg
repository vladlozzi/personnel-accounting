PARAMETERS osprava
LOCAL posad,iosp0002

SELECT 0

 m.main=m.shlyx+'\data\main'

USE (m.main) NOUP
iosp0002=TmpDir+[\iosp0002.idx]
INDEX ON sprava TO (iosp0002) COMPACT
IF SEEK(m.osprava)
	m.prizib=ALLT(name1)+[ ]+ ;
			ALLT(name2)+[ ]+ ;
			ALLT(name3)
ELSE
	m.prizib=[???]
ENDIF
USE

RETURN m.prizib
