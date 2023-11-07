PUBLIC posad
SELECT 0
* Блокування основного меню 
=lockmenu(.t.)
m.posad=m.shlyx+'\dov\posad' 
m.main=m.shlyx+'\data\main' 
IF EMPTY(Upd)
	=MESSAGEBOX("Для редагування довідника потрібно вийти з програми на всіх комп'ютерах!")
	USE (m.posad) &Upd EXCL
	REINDEX
	USE
ENDIF

*IF EMPTY(Upd) 
*	USE (m.posad) &Upd EXCL
*	IF FLOCK( )
*	   REINDEX  && Can only be done if table opened exclusively
*	ELSE
*	   MESSAGEBOX('Базу не можна впорядкувати, тому що вона відкрита іншим користувачем',48,'')
*	ENDIF
*	USE
*ENDIF
* REINDEX
USE (m.posad) &Upd
=ApEBas()
WITH oMForm
	.Caption=[Посади - VKADR]
	.AddObject('RegGrid','MyGrid') && Add grid
	.AddObject('RegCB2','MyCB2') && Add Sort command button
	.AddObject('RegCB3','MyCB3') && Add Unsort command button
	.AddObject('CBClose','MyCBClose') && Add Close command button
	.AddObject('CBPrintZ','MyPrintZ') && Add Close command button
	.AddObject('CBPrintS','MyPrintS') && Add Close command button
	.AddObject('RegUn','MyLb2')
	.lblImen.Visible=.f.
	.RegGrid.Headerheight=40  &&для друк заголовка в кілька рядків
	WITH .RegGrid.Column1
		.Visible=.t.
		.FontSize=12
		.Width=30
		.ControlSource=[posad.nest1]
		.Header1.FontSize=10
		.Header1.Caption=[Код Iр.]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column2
		.Visible=.t.
		.FontSize=12
		.Width=45
		.ControlSource=[posad.pos]
		.Header1.FontSize=10
		.Header1.Caption=[Код пос.]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column3
		.Visible=.t.
		.FontSize=12
		.Width=220
		.ControlSource=[posad.posada]
		.Header1.FontSize=10
		.Header1.Caption=[Назва посади]
		.Header1.Alignment=2
	ENDWITH
	WITH .RegGrid.Column4
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[posad.rang]
		.Header1.FontSize=10
		.Header1.Caption=[Ранг]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column5
		.Visible=.t.
		.FontSize=12
		.Width=60
		.ControlSource=[posad.tvidposn]
		.Header1.FontSize=10
		.Header1.Caption=[Осн.відп.]
		.Header1.Alignment=2
	ENDWITH

	WITH .RegGrid.Column6
		.Visible=.t.
		.FontSize=12
		.Width=60
		.ControlSource=[posad.tvidpdod]
		.Header1.FontSize=10
		.Header1.Caption=[Дод.відп.]
		.Header1.Alignment=2
	ENDWITH
		
	WITH .RegGrid.Column7
		.Visible=.t.
		.FontSize=12
		.Width=65
		.ControlSource=[posad.oklad]
		.Header1.FontSize=10
		.Header1.Caption=[Оклад,грн.]
		.Header1.Alignment=2
	ENDWITH

	WITH .RegGrid.Column8
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[posad.pedstag]
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
	
	WITH .RegGrid.Column9
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[posad.tstp]
		.Header1.FontSize=10
		.Header1.Caption=[Поч. зарах.]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column10
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[posad.tfnp]
		.Header1.FontSize=10
		.Header1.Caption=[Кінц.зарах.]
		.Header1.Alignment=2
	ENDWITH
	
    WITH .RegGrid.Column11
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[posad.npstag]
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
	
	WITH .RegGrid.Column12
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[posad.tstnp]
		.Header1.FontSize=10
		.Header1.Caption=[Поч. зарах.]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column13
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[posad.tfnnp]
		.Header1.FontSize=10
		.Header1.Caption=[Кінц.зарах.]
		.Header1.Alignment=2
	ENDWITH

	WITH .RegGrid.Column14
		.Visible=.t.
		.FontSize=12
		.Width=40
		.ControlSource=[posad.nstag]
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
	
	WITH .RegGrid.Column15
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[posad.tstn]
		.Header1.FontSize=10
		.Header1.Caption=[Поч. зарах.]
		.Header1.Alignment=2
	ENDWITH
	
	WITH .RegGrid.Column16
		.Visible=.t.
		.FontSize=12
		.Width=70
		.ControlSource=[posad.tfnn]
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
	.CBExit.Enabled=.f.
	.CBPrintZ.Caption=[Друк посад]
	.CBPrintZ.Left=550
	.CBPrintS.Caption=[За стажем]
	.CBPrintS.Left=650
	.Show

ENDWITH	

DEFINE CLASS MyGrid AS Grid
	DeleteMark=EMPTY(Upd)
	ControlSource='posad'
	ColumnCount=16
	Visible=.T.
	FontSize=12
	Left=5
	Width=1020
	Top=30
	Height=280
	AllowAddNew=IIF(EMPTY(Upd),.T.,.F.)
    FUNCTION Valid
		isUn=RecUni([nest1+STR(Pos,3)])
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
Height=25
Visible=.T.
FontSize=12
    PROC Click
    	r=RECNO()
		=Delecd([posada])
		SET INDEX TO (m.posad) ORDER TAG posad
*		GO r
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
		USE IN posad
		WITH Thisform
		.Caption=FormTitle
		.RemoveObject('RegGrid')
		.RemoveObject('RegUn')
		.RemoveObject('RegCB2')
		.RemoveObject('RegCB3')
		.RemoveObject('CBPrintZ')
		.RemoveObject('CBPrintS')		
		.CBExit.Enabled=.t.
		.CBClose.Enabled=.f.
		.Refresh
		ENDWITH
		IF EMPTY(Upd)
			IF MESSAGEBOX('Встановити посадові оклади з довідника всім особам?',4+32+256)=6
				WAIT [Зачекайте... Іде встановлення посадових окладів особам] WINDOW NOWAIT
				USE (m.posad) NOUPDATE
				in1pos=TmpDir+'\in1pos'
				INDEX ON nest1+STR(pos,4) TO (in1pos) COMPACT
				SELECT 0
				USE (m.main)
				SELECT Posad
				SCAN
					m.n1pos=nest1+STR(pos,4)
					m.oklad=oklad
					SELECT main
					REPLACE oklad WITH m.oklad FOR nest1+STR(pos,4)==m.n1pos
				ENDSCAN
				USE 
				USE IN main
				WAIT CLEAR
				=MESSAGEBOX('Посадові оклади встановлені успішно',0+64+0)
			ENDIF
		ENDIF
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
    	SELECT nest1,posada,pedstag,npstag,nstag FROM (m.posad) INTO CURSOR posstag ;
    		ORDER BY nest1,posada
    	REPORT FORM posstagz PREVIEW
    	USE IN posstag
	ENDPROC
ENDDEFINE

DEFINE CLASS MyPrintS AS CommandButton
Top=310
Width=100
Height=25
Visible=.T.
FontSize=12
    PROC Click
    	SELECT nest1,posada,pedstag,npstag,nstag FROM (m.posad) INTO CURSOR posstag ;
    		WHERE pedstag OR npstag OR nstag ORDER BY nest1,posada
    	REPORT FORM posstags PREVIEW
    	USE IN posstag
	ENDPROC
ENDDEFINE
