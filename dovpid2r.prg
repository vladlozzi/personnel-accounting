public nest2 
SELECT 0
* Блокування основного меню 
=lockmenu(.t.)
 
 m.nest2=m.shlyx+'\dov\nest2' 
*m.nest2a=m.shlyx+'\dov\nest2.cdx'
IF EMPTY(Upd)
	USE (m.nest2) &Upd EXCL
	REINDEX
	USE
ENDIF

USE (m.nest2) &Upd
=ApEBas()
WITH oMForm
	.Caption=[Підрозділи 2-го рівня - VKADR]
	.AddObject('RegGrid','MyGrid') && Add grid
	.AddObject('RegCB2','MyCB2') && Add Sort command button
	.AddObject('RegCB3','MyCB3') && Add Unsort command button
	.AddObject('CBClose','MyCBClose') && Add Close command button
	.AddObject('RegUn','MyLb2')
	
	WITH .RegGrid.Column1
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[nest2.nest1]
		.Header1.FontSize=10
		.Header1.Caption=[Код Iр.]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column2
		.Visible=.t.
		.FontSize=12
		.Width=80
		.ControlSource=[nest2.nest2]
		.Header1.FontSize=10
		.Header1.Caption=[Код IIр.]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column3
		.Visible=.t.
		.FontSize=12
		.Width=240
		.ControlSource=[nest2.povnest2]
		.Header1.FontSize=12
		.Header1.Caption=[Назва II рівня]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column4
		.Visible=.t.
		.FontSize=12
		.Width=140
		.ControlSource=[nest2.sknest2]
		.Header1.FontSize=12
		.Header1.Caption=[Кор.назва II р.]
		.Header1.Alignment=2
	ENDWITH
	
	.RegCB2.Caption=[Впорядкувати]
	.RegCB2.Left=100
	.RegCB3.Caption=[Відмінити]
	.RegCB3.Enabled=.f.
	.RegCB3.Left=250
	.CBClose.Caption=[Закрити]
	.CBClose.Left=400
	.CBExit.Enabled=.f.
	.Show

ENDWITH	

DEFINE CLASS MyGrid AS Grid
	DeleteMark=EMPTY(Upd)
	ControlSource='nest2'
	ColumnCount=4
	Visible=.T.
	FontSize=12
	Left=10
	Width=730
	Top=30
	Height=280
	AllowAddNew=IIF(EMPTY(Upd),.T.,.F.)
    FUNCTION Valid
		isUn=RecUni([nest1+nest2])
		Thisform.RegUn.Visible=NOT isUn
*		Вихід дозволити, якщо довідник 
*		містить лише унікальні записи
		Thisform.CBClose.Enabled=isUn
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

DEFINE CLASS MyCB2 AS CommandButton
Top=310
Width=125
Height=20
Visible=.T.
FontSize=12
    PROC Click
    	r=RECNO()
		SET INDEX TO (m.nest2) ORDER TAG nest12
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

DEFINE CLASS MyCBClose AS CommandButton
Top=310
Width=100
Height=20
Visible=.T.
FontSize=12
    PROC Click
    * Закриття довідника, вилучення об'єктів
		=Delecd([nest2])
		USE IN nest2
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
