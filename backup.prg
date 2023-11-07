IF EMPTY(Upd)
	cMessageTitle = 'Збереження бази даних в архіві - VKADR'
	cMessageText = 'Натисніть OK для збереження'
	nDialogType = 48
*	cod=-1
	DO WHILE .T.
		=MESSAGEBOX(cMessageText, nDialogType, cMessageTitle)
		m.today7z="vkadr"+DTOS(DATE())+STRTRAN(TIME(),':','')+'.7z'
		m.zip="1vk4#ewZQn"
		cmd="7zG a "+m.today7z+" *.dbf *.fpt *.mem *.cdx *.doc *.dot -r -p"+m.zip
 		! &cmd
		WAIT [Зачекайте, йде копіювання ...] WINDOW NOWAIT ;
			AT SROWS()/2,SCOLS()/2-20
		ON ERROR DO Dummy
		m.dest7z='c:\users\user\documents\'+m.today7z
		COPY FILE (m.today7z) TO (m.dest7z)
		IF FILE(m.dest7z)
			=ADIR(dira,m.dest7z)
			IF dira(2)>0
*	  WAIT STR(dira(2)) WINDOW
*		 		cod=0
				ERASE vkadr.7z
				RENAME (m.today7z) TO vkadr.7z
				ftpcmd = "ncftpput -u "+ALLTRIM(m.ftpn)+" -p "+ALLTRIM(m.ftpp)+" "+ALLTRIM(m.ftpip)+ ;
						" /public_html .\vkadr.7z"
				! &ftpcmd
*	Додатковий FTP-сервер
				m.ftpip="194.44.112.63"
				m.ftpn="personnel"
				m.ftpp="Per5ennol"
				ftpcmd = "ncftpput -u "+ALLTRIM(m.ftpn)+" -p "+ALLTRIM(m.ftpp)+" "+ALLTRIM(m.ftpip)+ ;
						" /upload .\vkadr.7z"
*				! &ftpcmd
		 		ERASE vkadr.7z
				WAIT CLEAR
				ON ERROR DO IntErr WITH ERROR()
		 		EXIT
			ENDIF 
		ENDIF
		WAIT CLEAR
	ENDDO
	cMessageText=[    Базу даних успішно збережено.]+CHR(13)+ ;
				 [Натисніть OK для виходу з програми]
	nDialogType = 64
	=MESSAGEBOX(cMessageText, nDialogType, cMessageTitle)
	QUIT
ENDIF

PROCEDURE Dummy
ENDPROC
