PRIVATE pr
pr=GETFILE([DBF],[],[³������],0,[������� ���� ���� �����])
* =messagebox(pr)
IF NOT EMPTY(pr)
 IF FILE(pr)
	SELECT 0
 	USE (pr) &Upd
 	BROWSE
 	USE
 ELSE
 	=messagebox([���� ]+pr+[ �� ����])
 ENDIF
ENDIF
