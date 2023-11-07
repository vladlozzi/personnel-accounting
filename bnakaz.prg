PUBLIC ikna0001
=lockmenu(.t.)
WAIT WINDOW [Зачекайте...] NOWAIT
WITH oMForm
.Caption=[Формування та реєстрація наказів у відділі кадрів - V K A D R]
.CBExit.Enabled=.f.
.ShortRules.Enabled=.f.
.ShortRules.Visible=.f.
.Act.Visible=.f.
.AddObject('cmdNakazClose','NakazClose')
.AddObject('lblKatNak','Label')
	WITH .lblKatNak
	.Visible=.t.
	.Top=5
	.Left=0
	.Width=250
	.FontSize=12
	.Height=25
	.Caption=[Зміст наказу]
	.Alignment=2
	ENDWITH
	SELECT 0
        m.katnakaz=m.shlyx+'\dov\katnakaz'

	USE (m.katnakaz) NOUP
	ikna0001=TmpDir+'\ikna0001.idx'
	INDEX ON kodkat TO (ikna0001) COMPACT
	.AddObject('lstKatNak','ListBox')
		WITH .lstKatNak
		.Enabled=.t.
		.Visible=.t.
		.Top=30
		.Left=0
		.Width=250
		.FontSize=12
		.Height=200
		.ColumnCount=2
		.BoundColumn=1
		.ItemTips=.t.
		.RowSource='Katnakaz.kodkat,katnak'
		.RowSourceType=6
		.Selected(1)=.t.
		ENDWITH
	.AddObject('cmdProjNak','NakazProj')
	.AddObject('cmdArcNak','NakazArc')
		WITH .cmdProjNak
		ENDWITH
	WAIT CLEAR
	.lstKatNak.SetFocus
*	BROWSE
ENDWITH

DEFINE CLASS NakazClose AS CommandButton
Caption=[Закрити]
Height=25
Width=100
Left=150
Top=308
Visible=.t.
Enabled=.t.
FontSize=12

PROC Click
*	SET INDEX TO 
	USE IN Katnakaz
	ERASE (ikna0001)
	WITH ThisForm
	.RemoveObject('cmdProjNak')
	.RemoveObject('cmdArcNak')
	.RemoveObject('lblKatNak')
	.RemoveObject('lstKatNak')
	.ShortRules.Enabled=.t.
	.ShortRules.Visible=.t.
	.Act.Visible=.t.
	.CBExit.Enabled=.t.
	=lockmenu(.f.)
	.RemoveObject('cmdNakazClose')
	ENDWITH
	
ENDPROC
ENDDEFINE

DEFINE CLASS NakazProj AS CommandButton
Caption=[Проекти наказів]
Visible=.t.
Enabled=.t.
Top=240
Left=0
Width=250
FontSize=12
Height=30
PROC Click
	m.kodzmist=ThisForm.lstKatNak.Value
*	WAIT m.kodzmist WINDOW
	SELECT KatNakaz
	LOCATE FOR kodkat=m.KodZmist
	m.fbaznak='Nakaz\'+ALLTRIM(archname)
	SELECT 0
	USE (fbaznak) &Upd
	inak0001=TmpDir+[\inak0001.idx]
	INDEX ON idnak TO (inak0001) COMPACT ;
		UNIQUE FOR NOT DELETED()
	COUNT TO knak && Кількість наказів у архіві
	INDEX ON idnak TO (inak0001) COMPACT
	IF knak=0
		IF EMPTY(Upd)
			APPEND BLANK
			REPLACE idnak WITH 1
		ENDIF
	ENDIF
	INDEX ON idnak FOR NOT Pidpker TO (inak0001) COMPACT
	GO BOTTOM
	DO CASE
	CASE ThisForm.lstKatNak.Value='01'
		DO FORM osskladp
	CASE .f.
	ENDCASE
ENDPROC
ENDDEFINE

DEFINE CLASS NakazArc AS CommandButton
Caption=[Архів наказів]
Visible=.t.
Enabled=.t.
Top=275
Left=0
Width=250
FontSize=12
Height=30
PROC Click
	m.kodzmist=ThisForm.lstKatNak.Value
*	WAIT m.kodzmist WINDOW
	SELECT KatNakaz
	LOCATE FOR kodkat=m.KodZmist
	m.fbaznak='Nakaz\'+ALLTRIM(archname)
	SELECT 0
	USE (fbaznak) &Upd
	inak0001=TmpDir+[\inak0001.idx]
	INDEX ON datanak FOR Pidpker TO (inak0001) COMPACT
	BROW
	USE
ENDDEFINE
