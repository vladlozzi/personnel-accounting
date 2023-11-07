SET SAFETY OFF
SET TALK OFF
SET CONSOLE OFF

adrtel=TmpDir+[\dadrtel]
 m.main=m.shlyx+'\data\main' 

SELE name1,name2,name3,domadr, ;
    ALLT(STRTRAN(STRTRAN(domtel,'(03422)',''),'(0342)','')) as domtel ;
	FROM (m.main) WHERE potstan INTO TABLE (adrtel) ;
	ORDER BY name1,name2,name3

USE IN main

* BROWSE NODE NOED NOAP

REPORT FORM dadrtel PREVIEW
REPORT FORM dadrtel TO PRINTER PROMPT 

m.form=m.shlyx+'\form\'
adrtelf=m.FORM+'dadrtel.prn'
REPORT FORM dadrtel TO FILE (adrtelf)

USE IN dadrtel
