PARAMETERS field_n
	IF EMPTY(Upd)
		DELETE FOR EMPTY(&field_n)
	ENDIF
RETURN .t.
