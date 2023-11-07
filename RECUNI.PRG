PARAMETER field_n
	PRIVATE CurFv, r, NUni, Uni, re
	IF EMPTY(Upd)
		r=RECNO()
		GO BOTTOM
		IF NOT EOF()
			Uni=.t.
			SCAN
				CurFV=&field_n
				re=RECNO()
				COUNT FOR &field_n==CurFV TO Nuni
				GO re
				Uni=Uni AND (Nuni=1)
        	ENDSCAN
			GO r
			RETURN Uni
		ENDIF
		GO r
	ENDIF