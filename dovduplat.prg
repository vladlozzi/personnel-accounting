***Корегування довідника - документи про наук.степені та вч.звання DOVDUPLAT.DBF****
SELECT 0
=lockmenu(.t.)
m.dovduplat=m.shlyx+'\dov\dovduplat'
USE (m.dovduplat) &Upd
=ApEBas()
WITH oMForm
	.Caption=[Документи про наук.ступені та вч.звання - VKADR]
	.AddObject('RegGrid','MyGrid') && Add grid
	.AddObject('CBClose','MyCBClose') && Add Close command button
	
	WITH .RegGrid.Column1
		.Visible=.t.
		.FontSize=12
		.Width=350
		.ControlSource=[dovduplat.nazvadok]
		.Header1.FontSize=12
		.Header1.Caption=[Документи про наук.ступені та вч.звання]
		.Header1.Alignment=2
	ENDWITH
		
	.CBClose.Caption=[Закрити]
	.CBClose.Left=450
	.CBExit.Enabled=.f.
	.Show

ENDWITH	

DEFINE CLASS MyGrid AS Grid
	DeleteMark=EMPTY(Upd)
	ControlSource='dovduplat'
	ColumnCount=1
	Visible=.T.
	FontSize=12
	Left=10
	Width=600
	Top=30
	Height=280
	AllowAddNew=IIF(EMPTY(Upd),.T.,.F.)
ENDDEFINE

DEFINE CLASS MyCBClose AS CommandButton
Top=310
Width=100
Height=20
Visible=.T.
FontSize=12
    PROC Click
   * Закриття довідника, вилучення об'єктів
	*	=Delecd([nazvadok])
		USE IN dovduplat
		WITH Thisform
		.Caption=FormTitle
		.RemoveObject('RegGrid')
    	.CBExit.Enabled=.t.
		.CBClose.Enabled=.f.
		.Refresh
		ENDWITH
	*	Розблокування основного меню
		=lockmenu(.f.)
		Thisform.RemoveObject('CBClose')
	ENDPROC
ENDDEFINE
