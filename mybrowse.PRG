PRIVATE pr
pr=GETFILE([DBF],[],[Відкрити],0,[Виберіть файл бази даних])
* =messagebox(pr)
IF NOT EMPTY(pr)
 IF FILE(pr)
	SELECT 0
 	USE (pr) &Upd
 	BROWSE
 	USE
 ELSE
 	=messagebox([Файл ]+pr+[ не існує])
 ENDIF
ENDIF
