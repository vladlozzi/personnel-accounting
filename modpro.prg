PRIVATE pr

pr=GETFILE([PRG])

IF NOT EMPTY(pr)
 _m145841=pr
 MODI COMM (pr)
ELSE
 IF NOT EMPTY(_m145841)
  MODI COMM (_m145841)
 ENDIF 
ENDIF 
