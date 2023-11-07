PUBLIC postru
SELECT 0
* Блокування основного меню 
=lockmenu(.t.)
m.postru=m.shlyx+'\dov\postru' 
*m.main=m.shlyx+'\data\main' 

*IF EMPTY(Upd) 
*	USE (m.posad) &Upd EXCL
*	IF FLOCK( )
*	   REINDEX  && Can only be done if table opened exclusively
*	ELSE
*	   MESSAGEBOX('Базу не можна впорядкувати, тому що вона відкрита іншим користувачем',48,'')
*	ENDIF
*	USE
*ENDIF

USE (m.postru) &Upd
=ApEBas()
WITH oMForm
	.Caption=[Посади поза нашим університетом - VKADR]
	.AddObject('RegGrid','MyGrid') && Add grid
	.AddObject('RegCB2','MyCB2') && Add Sort command button
	.AddObject('RegCB3','MyCB3') && Add Unsort command button
	.AddObject('CBClose','MyCBClose') && Add Close command button
	.AddObject('CBPrintZ','MyPrintZ') && Add Close command button
	.AddObject('RegUn','MyLb2')
	.lblImen.Visible=.f.
	.RegGrid.Headerheight=40  &&для друк заголовка в кілька рядків
	WITH .RegGrid.Column1
		.Visible=.t.
		.FontSize=12
		.Width=30
		.ControlSource=[postru.nest1]
		.Header1.FontSize=10
		.Header1.Caption=[Код Iр.]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column2
		.Visible=.t.
		.FontSize=12
		.Width=45
		.ControlSource=[postru.pos]
		.Header1.FontSize=10
		.Header1.Caption=[Код пос.]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column3
		.Visible=.t.
		.FontSize=12
		.Width=220
		.ControlSource=[postru.posada]
		.Header1.FontSize=10
		.Header1.Caption=[Назва посади]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column4
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[postru.rang]
		.Header1.FontSize=10
		.Header1.Caption=[Ранг]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column5
		.Visible=.t.
		.FontSize=12
		.Width=65
		.ControlSource=[postru.oklad]
		.Header1.FontSize=10
		.Header1.Caption=[Оклад,грн.]
		.Header1.Alignment=2
	ENDWITH

WITH .RegGrid.Column6
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[postru.pedstag]
		.AddObject('chkP','CheckBox')
	    .CurrentControl='chkP'
	    .Sparse=.f.
	    .chkP.Enabled=.t.
	    .chkP.Caption=''
	    .chkP.ReadOnly=.f.
	    .chkP.BackStyle=0
		.chkP.Visible=.t.
		.Header1.FontSize=10
		.Header1.Caption=[Пед. стаж]
		.Header1.Wordwrap=.t.      &&для друку в кілька рядків заголовка
		.Header1.Alignment=0
	ENDWITH
	
	WITH .RegGrid.Column7
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[postru.tstp]
		.Header1.FontSize=10
		.Header1.Caption=[Поч. зарах.]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column8
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[postru.tfnp]
		.Header1.FontSize=10
		.Header1.Caption=[Кінц.зарах.]
		.Header1.Alignment=2
	ENDWITH
	
    WITH .RegGrid.Column9
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[postru.npstag]
	    .AddObject('chkNP','CheckBox')
	    .CurrentControl='chkNP'
	    .Sparse=.f.
	    .chkNP.Enabled=.t.
	    .chkNP.Caption=''
	    .chkNP.ReadOnly=.f.
	    .chkNP.BackStyle=0
		.chkNP.Visible=.t.
		.Header1.FontSize=10
		.Header1.Caption=[Н-п. стаж]
        .Header1.Wordwrap=.t.      &&для друку в кілька рядків заголовка
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column10
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[postru.tstnp]
		.Header1.FontSize=10
		.Header1.Caption=[Поч. зарах.]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column11
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[postru.tfnnp]
		.Header1.FontSize=10
		.Header1.Caption=[Кінц.зарах.]
		.Header1.Alignment=2
	ENDWITH

	WITH .RegGrid.Column12
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[postru.nstag]
		.AddObject('chkN','CheckBox')
	    .CurrentControl='chkN'
	    .Sparse=.f.
	    .chkN.Enabled=.t.
	    .chkN.Caption=''
	    .chkN.ReadOnly=.f.
	    .chkN.BackStyle=0
		.chkN.Visible=.t.
		.Header1.FontSize=10
		.Header1.Caption=[Наук. стаж]
        .Header1.Wordwrap=.t.      &&для друку в кілька рядків заголовка
		.Header1.Alignment=0
	ENDWITH
	
	WITH .RegGrid.Column13
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[postru.tstn]
		.Header1.FontSize=10
		.Header1.Caption=[Поч. зарах.]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column14
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[postru.tfnn]
		.Header1.FontSize=10
		.Header1.Caption=[Кінц.зарах.]
		.Header1.Alignment=2
	ENDWITH

	.RegCB2.Caption=[Впорядкувати]
	.RegCB2.Left=100
	.RegCB3.Caption=[Відмінити]
	.RegCB3.Enabled=.f.
	.RegCB3.Left=250
	.CBClose.Caption=[Закрити]
	.CBClose.Left=400
	.CBPrintZ.Caption=[Друк посад]
	.CBPrintZ.Left=550
	.CBExit.Enabled=.f.
	.Show

ENDWITH	

DEFINE CLASS MyGrid AS Grid
	DeleteMark=EMPTY(Upd)
	ControlSource='postru'
	ColumnCount=14
	Visible=.T.
	FontSize=12
	Left=10
	Width=990
	Top=30
	Height=280
	AllowAddNew=IIF(EMPTY(Upd),.T.,.F.)
*    FUNCTION Valid
*		isUn=RecUni([posada])
*		Thisform.RegUn.Visible=NOT isUn
*		Вихід дозволити, якщо довідник 
*		містить лише унікальні записи
*		Thisform.CBClose.Enabled=isUn
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
Height=25
Visible=.T.
FontSize=12
    PROC Click
    	r=RECNO()
		=Delecd([posada])
		SET INDEX TO (m.postru) ORDER TAG postru
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
Height=25
Visible=.T.
FontSize=12
    PROC Click
		r=RECNO()
		SET INDEX TO
		=Delecd([posada])
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
Height=25
Visible=.T.
FontSize=12
    PROC Click
    * Закриття довідника, вилучення об'єктів
		=Delecd([posada])
		USE IN postru
		WITH Thisform
		.Caption=FormTitle
		.RemoveObject('RegGrid')
		.RemoveObject('RegUn')
		.RemoveObject('RegCB2')
		.RemoveObject('RegCB3')
		.RemoveObject('CBPrintZ')
		.CBExit.Enabled=.t.
		.CBClose.Enabled=.f.
		.Refresh
		ENDWITH
		Thisform.lblImen.Visible=.t.
	*	Розблокування основного меню
		=lockmenu(.f.)
		Thisform.RemoveObject('CBClose')
	ENDPROC
ENDDEFINE

DEFINE CLASS MyPrintZ AS CommandButton
Top=310
Width=100
Height=25
Visible=.T.
FontSize=12
    PROC Click
    	SELECT posada,pedstag,npstag,nstag FROM (m.postru) INTO CURSOR posstag ;
    		ORDER BY posada
    	REPORT FORM poststag PREVIEW
    	USE IN posstag
	ENDPROC
ENDDEFINE
