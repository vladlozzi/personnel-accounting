public vstup
SELECT 0

 m.vstup=m.shlyx+'\dov\vstup'

* Блокування основного меню 
=lockmenu(.t.)
IF EMPTY(Upd)
	USE (m.vstup) &Upd EXCL
	REINDEX
	USE
ENDIF

USE (m.vstup) &Upd
=ApEBas()
WITH oMForm
	.Caption=[Наукові ступені - VKADR]
	.AddObject('RegGrid','MyGrid') && Add grid
	.AddObject('RegCB2','MyCB2') && Add Sort command button
	.AddObject('RegCB3','MyCB3') && Add Unsort command button
	.AddObject('CBClose','MyCBClose') && Add Close command button
	.AddObject('RegUn','MyLb2')
	
	WITH .RegGrid.Column1
		.Visible=.t.
		.FontSize=12
		.Width=90
		.ControlSource=[vstup.vstup]
		.Header1.FontSize=12
		.Header1.Caption=[Наук.ступінь]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column2
		.Visible=.t.
		.FontSize=10
		.Width=175
		.ControlSource=[vstup.povvstup]
		.Header1.FontSize=12
		.Header1.Caption=[Родовий відмінок]
		.Header1.Alignment=2
	ENDWITH
		
	.RegCB2.Caption=[Впорядкувати]
	.RegCB2.Left=100
	.RegCB3.Caption=[Відмінити]
	.RegCB3.Enabled=.f.
	.RegCB3.Left=250
	.CBClose.Caption=[Закрити]
	.CBClose.Left=450
	.CBExit.Enabled=.f.
	.Show

*	WITH .CB1
*		PROCEDURE Click
*			USE
*	ENDWITH		
ENDWITH	

DEFINE CLASS MyGrid AS Grid
	DeleteMark=EMPTY(Upd)
	ControlSource='vstup'
	ColumnCount=2
	Visible=.T.
	FontSize=12
	Left=310
	Width=325
	Top=30
	Height=280
	AllowAddNew=IIF(EMPTY(Upd),.T.,.F.)
    FUNCTION Valid
		isUn=RecUni([vstup])
		Thisform.RegUn.Visible=NOT isUn
*		Вихід дозволити, якщо довідник 
*		містить лише унікальні записи
		Thisform.CBClose.Enabled=isUn
ENDDEFINE

DEFINE CLASS MyCB2 AS CommandButton
Top=310
Width=125
Height=20
Visible=.T.
FontSize=12
    PROC Click
    	r=RECNO()
		SET INDEX TO (m.vstup) ORDER TAG nstup
*		REINDEX
		WITH Thisform
		.RegCB3.Enabled=.t.	
		.RegCB2.Enabled=.f.
		.Refresh
		ENDWITH
    ENDPROC
ENDDEFINE

DEFINE CLASS MyCB3 AS CommandButton
Top=310
Width=100
Height=20
Visible=.T.
FontSize=12
    PROC Click
		r=RECNO()
		SET INDEX TO
		GO TOP
		GO r
		WITH Thisform
		.RegCB2.Enabled=.t.	
		.RegCB3.Enabled=.f.
		.Refresh
		ENDWITH
   ENDPROC
ENDDEFINE

DEFINE CLASS MyLb2 AS Label
Left=130
Top=10
Width=490
Height=16
FontSize=8
FontBold=.f.
ForeColor=RGB(255,192,0)
BackColor=RGB(0,128,128)
Caption=[ Довідник містить неунікальні коди ! Для їх пошуку скористайтеся ]+;
		[кнопкою "Впорядкувати" ]
Alignment=2
ENDDEFINE

DEFINE CLASS MyCBClose AS CommandButton
Top=310
Width=100
Height=20
Visible=.T.
FontSize=12
    PROC Click
    * Закриття довідника, вилучення об'єктів
	*	=Delecd([nest1])
		USE IN vstup
		WITH Thisform
		.Caption=FormTitle
		.RemoveObject('RegGrid')
		.RemoveObject('RegUn')
		.RemoveObject('RegCB2')
		.RemoveObject('RegCB3')
		.CBExit.Enabled=.t.
		.CBClose.Enabled=.f.
		.Refresh
		ENDWITH
	*	Розблокування основного меню
		=lockmenu(.f.)
		Thisform.RemoveObject('CBClose')
	ENDPROC
ENDDEFINE
