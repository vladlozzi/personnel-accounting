PUBLIC nDisabledForeColor, kprac, prizv, potrec
* Блокування основного меню 
=lockmenu(.t.)
*cCurN1=[]
*cCurN2=[]

SELECT 0
m.main=m.shlyx+'\data\main'
USE (m.main) NOUP
i1=TmpDir+'\i0000001'
INDEX ON ' ' TO (i1) COMPACT FOR NOT EMPTY(name1) AND VAL(nest1)<50
COUNT TO kpracZ
COUNT TO kpracN FOR ISBLANK(pos)
IF kpracN>0
	COUNT FOR nest1=[01] TO kpracZ01
	COUNT FOR nest1=[01] AND ISBLANK(pos) TO kpracN01
	COUNT FOR nest1=[02] TO kpracZ02
	COUNT FOR nest1=[02] AND ISBLANK(pos) TO kpracN02
	COUNT FOR nest1=[03] TO kpracZ03
	COUNT FOR nest1=[03] AND ISBLANK(pos) TO kpracN03
	IF NOT lI_Am_Guest
		=MESSAGEBOX([В базі не сформовано ]+STR(kpracN,5,0)+[ справ із]+STR(kpracZ,5,0)+CHR(13)+;
			[З них:]+CHR(13)+;
			[   для персоналу 01: ]+STR(kpracN01,5,0)+[ справ із]+STR(kpracZ01,5,0)+CHR(13)+;
			[   для персоналу 02: ]+STR(kpracN02,5,0)+[ справ із]+STR(kpracZ02,5,0)+CHR(13)+;
			[   для персоналу 03: ]+STR(kpracN03,5,0)+[ справ із]+STR(kpracZ03,5,0)+CHR(13)+;
			CHR(13)+;
			[Якщо Ви повністю сформуєте всі справи,]+CHR(13)+;
			[то цього повідомлення більше не буде],48,[Увага! - НАШІ КАДРИ])
	ENDIF
ENDIF
USE
m.nest1=m.shlyx+'\dov\nest1'
SELECT nest1,LEFT(povnest1,40) AS povnest1 FROM (m.nest1) INTO CURSOR nest1C
USE IN Nest1
COUNT TO iNbazCount
IF iNbazCount>0 	&& AND iPokCount>0
	WITH oMForm
	.grdImen.Visible=.f.
	.grdImen.Enabled=.f.	
	.lblImen.Visible=.f.
*    .Acs.Visible=.f.
*	.CBExit.Enabled=.f.
	.Caption=[Вибір виду персоналу і підрозділів - ]+m.logos
	.AddObject('ZadL1','Label') && Add Label
	.AddObject('lblN1','Label') && Add Label
	.AddOBject('cboN1','Combobox')
	.AddObject('lblN2','Label') && Add Label
	.AddObject('cboN2','N2Cbo')
	.AddObject('lblN3','Label') && Add Label
	.AddObject('cboN3','N3Cbo')
	.AddObject('chkVsiPrac','VCheckBox')
	.AddObject('chkArcPrac','ACheckBox')
	.AddObject('chkNeSform','CheckBox')
	.AddObject('cmdPrac','PracList')
*	.AddObject('cmdCurSt','CurSt')
	.AddObject('cmdPCStCancel','PCStCancel')
*	.AddObject('cmdRozrah','RozrahRez')
*	.AddObject('cmdRozrahBaz','RozrahBaz')
	.CBExit.Enabled=.f.
	ENDWITH
	WITH oMForm.ZadL1
	.Caption=[Виберіть вид персоналу і підрозділ]
	.Alignment=0
	.Width=320
	.Left=5
	.Top=25
	.Height=25
	.FontSize=14
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.f.
	.Visible=.T.
	ENDWITH
	WITH oMForm.lblN1
	.Caption=[Персонал:]
	.Alignment=0
	.Width=100
	.Left=10
	.Top=60
	.Height=20
	.FontSize=12
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.T.
	.Visible=.T.
	ENDWITH
	WITH oMForm.cboN1
	.ControlSource='m.cCurN1'
	.StatusBarText=[Вибір виду персоналу]
	.ToolTipText=[Вибір виду персоналу]
	.Style=2
	.BoundColumn=1
	.ColumnCount=2
	.RowSource=' Nest1C.nest1,povnest1'
	.RowSourceType=6
	.Width=60
	.Left=100
	.Top=55
	.Height=30
	.FontSize=10
	.FontName='FixedSys'
	.FontBold=.f.
	.Visible=.T.
	ENDWITH
	WITH oMForm.lblN2
	.Caption=[Факультет(відділ):]
	.Alignment=0
	.Width=200
	.Left=170
	.Top=60
	.Height=20
	.FontSize=12
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.T.
	.Visible=.T.
	ENDWITH
	WITH oMForm.cboN2
	.Value=m.cCurN2
	.DisplayValue=m.cCurN2
	.ControlSource='m.cCurN2'
	.StatusBarText=[Вибір факультету(відділу)]
	.ToolTipText=[Вибір факультету(відділу)]
	.Width=100
	.Left=320
	.Top=55
	.Height=30
	.FontSize=10
	.FontName='FixedSys'
	.FontBold=.f.
	.Visible=.T.
	ENDWITH
	WITH oMForm.lblN3
	.Caption=[Кафедра(сектор,лабораторія):]
	.Alignment=0
	.Width=300
	.Left=5
	.Top=90
	.Height=20
	.FontSize=12
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.T.
	.Visible=.T.
	ENDWITH
	WITH oMForm.cboN3
	.Value=m.cCurN3
	.DisplayValue=m.cCurN3
	.ControlSource='m.cCurN3'
	.StatusBarText=[Вибір кафедри(сектора,лабораторії)]
	.ToolTipText=[Вибір кафедри(сектора,лабораторії)]
	.Width=100
	.Left=320
	.Top=85
	.Height=30
	.FontSize=10
	.FontName='FixedSys'
	.FontBold=.f.
	.Visible=.T.
	ENDWITH
	WITH oMForm.chkVsiPrac
	.Value=.F.
	.Caption=[Вивести актуальний персонал]
	.Alignment=0
	.Width=270
	.Left=350
	.Top=10
	.Height=25
	.FontSize=12
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.T.
	.Visible=.T.
	ENDWITH
	WITH oMForm.chkArcPrac
	.Value=.F.
	.Caption=[Список колишніх працівників]
	.Alignment=0
	.Width=255
	.Left=635
	.Top=10
	.Height=25
	.FontSize=12
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.T.
	.Visible=.T.
	ENDWITH
	WITH oMForm.chkNeSform
	.Value=.f.
	.Caption=[Лише несформовані справи]
	.Alignment=0
	.Width=250
	.Left=350
	.Top=30
	.Height=25
	.FontSize=12
	.ForeColor=RGB(0,0,95)
	.FontName='Arial'
	.FontBold=.T.
	.Visible=.T.
	ENDWITH
	IsV=.t.
	WITH oMForm
	.cboN1.SetFocus
		WITH .cmdPCStCancel
		.Left=450
		.Top=90
		ENDWITH
		WITH .cmdPrac
		.Left=450
		.Top=60
		ENDWITH
	ENDWITH
ELSE
	USE IN Nest1C
	=MessageBox([В довіднику підрозділів 1-го рівня немає жодного запису ]+CHR(13)+CHR(13)+;
	[Для його заповнення скористайтеся пунктом "Підрозділи" меню "Довідники"], ;
	MB_OKe,m.logos+[ - Помилка])
ENDIF

DEFINE CLASS N2Cbo AS Combobox
StatusBarText=[Вибір факультету(відділу)]
ToolTipText=[Вибір факультету(відділу)]
FUNCTION When
IF NOT EMPTY(m.cCurN1)
m.nest2=m.shlyx+'\dov\nest2'
	SELECT nest2,LEFT(povnest2,40) AS povnest2 FROM (m.nest2) INTO CURSOR nest2C ;
		WHERE nest1==m.cCurN1
	USE IN nest2
	IF RECCOUNT('nest2C')>0
		WITH This
		.Style=2
		.BoundColumn=1
		.ColumnCount=2
		.RowSourceType=6
		.RowSource=' nest2C.nest2,povnest2'
		ENDWITH
		tr=.t.
		ThisForm.Refresh
	ELSE
		=MessageBox([Для вибраного персоналу не введені підрозділи.] ;
		+CHR(13)+CHR(13)+ ;
		[Для їх введення скористайтеся пунктом "Підрозділи" меню "Довідники"], ;
		MB_OKe,m.logos+[ - Помилка])
		tr=.f.
		ThisForm.Refresh
	ENDIF
ELSE
	=MessageBox([Не вибрано вид персоналу],MB_OKe,m.logos+[ - Помилка])
	tr=.f.
ENDIF
RETURN tr
ENDFUNC
ENDDEFINE

DEFINE CLASS N3Cbo AS Combobox
StatusBarText=[Вибір кафедри(сектора,лабораторії)]
ToolTipText=[Вибір кафедри(сектора,лабораторії)]
FUNCTION When
IF NOT EMPTY(m.cCurN2) 
m.nest3=m.shlyx+'\dov\nest3'
	SELECT nest3,LEFT(povnest3,40) AS povnest3 FROM (m.nest3) INTO CURSOR nest3C ;
		WHERE nest1==m.cCurN1 AND nest2==m.cCurN2
	USE IN nest3
	IF RECCOUNT('nest3C')>0
		WITH This
		.Style=2
		.BoundColumn=1
		.ColumnCount=2
		.RowSourceType=6
		.RowSource=' nest3C.nest3,povnest3'
		ENDWITH
		tr=.t.
*		ThisForm.Refresh
	ELSE
		=MessageBox([Для вибраного підрозділу 2-го рівня не введені підрозділи 3-го рівня] ;
		+CHR(13)+CHR(13)+ ;
		[Для їх введення скористайтеся пунктом "Підрозділи" меню "Довідники"], ;
		MB_OKe,m.logos+[- Помилка])
		tr=.f.
	ENDIF
ELSE
	=MessageBox([Не вибрано вид персоналу або ]+ ;
		[підрозділ 2-го рівня],MB_OKe,m.logos+[ - Помилка])
	tr=.f.
ENDIF
RETURN tr
ENDFUNC
ENDDEFINE

DEFINE CLASS PracList AS CommandButton
StatusBarText=[Виведення cписку працівників]
ToolTipText=[Виведення cписку працівників]
Caption=[Вивести]
FontSize=12
Width=100
Height=25
Visible=.t.
*Enabled=NOT EMPTY(m.cCurN1) AND NOT EMPTY(m.cCurN2)
Enabled=.t.
PROCEDURE Click
	ThisForm.chkVsiPrac.Enabled=.f.
	ThisForm.chkArcPrac.Enabled=.f.
	ThisForm.chkNeSform.Enabled=.f.
	lVsiPrac=ThisForm.chkVsiPrac.Value
	lArcPrac=ThisForm.chkArcPrac.Value
	lNeSform=ThisForm.chkNeSform.Value
	um1=IIF(lVsiPrac OR lArcPrac,'.t.','NOT EMPTY(m.cCurN1) AND NOT EMPTY(m.cCurN2)')
	IF lNeSform
		um2='ISBLANK(pos)'
	ELSE
		um2=IIF(lVsiPrac,'VAL(nest1)<50','.t.')
		um2=IIF(lArcPrac,'VAL(nest1)>=50',um2)
	ENDIF
	
	IF &um1
*		=MessageBox([Зараз буде список працівників],0,[]+m.logos+[ - Інфо])
		WITH ThisForm
		.cboN1.Enabled=.f.
		.cboN2.Enabled=.f.
		.cboN3.Enabled=.f.
		.cmdPCStCancel.Enabled=.f.
		.cmdPrac.Enabled=.f.
		
		.AddObject('cmdClosPracL','ClosPracL')
			WITH .cmdClosPracL
			.Top=530
			.Left=200     
			ENDWITH
		SELECT 0
		USE (m.Main) &Upd
		IF EMPTY(m.Upd) && видалити порожні записи
			DELETE FOR EMPTY(name1) AND EMPTY(name2) AND EMPTY(nest1)
		ENDIF
		i1=TmpDir+'\i0000001'
		IF NOT (ThisForm.chkVsiPrac.Value OR ThisForm.chkArcPrac.Value)
			INDEX ON Name1+Name2+Name3 TO (i1) COMPACT ;
				FOR Nest1==cCurN1 AND Nest2==cCurN2 ;
					AND Nest3==cCurN3 AND &um2
		ELSE
			INDEX ON Name1+Name2+Name3 TO (i1) COMPACT FOR &um2
		ENDIF
		SELECT 0
		m.places=m.shlyx+"\Dov\posad"
		USE (m.places) ALIAS Places
		SET ORDER TO posad && nest1+STR(pos,3)
		SELECT main
		SET RELATION TO nest1+STR(pos,3) INTO Places
*		BROW
*		WAIT WINDOW cCurN1+cCurN2+cCurN3
		COUNT TO kprac FOR potstan	&& Якщо працівників немає, 
						&& створити пустий запис
		GO TOP
		IF EMPTY(Upd) AND kprac=0 
			INSERT INTO (m.main) (nest1,nest2,nest3) ;
				VALUES (cCurN1,cCurN2,cCurN3)
		ENDIF
		SET CARRY ON
		SET CARRY TO Nest1,Nest2,Nest3
		.AddObject('grdPrac','PracGrid')
			WITH .grdPrac
			.Top=120
			.Left=20
			.Height=400
			.Width=1250
			.Visible=.t.
			.AllowAddNew=.f.
			.DeleteMark=.f.
				WITH .Columns(4)
				.ControlSource='LEFT(DTOC(Main.datanar),5)'
				.Width=60
				.Enabled=.t.
				.Header1.Caption='День народж.'
				ENDWITH
				WITH .Columns(5)
				.ControlSource='" "+Main.Nest1'
				.Width=IIF(lVsiPrac OR lArcPrac,30,0)
				.Enabled=lVsiPrac OR lArcPrac
				.Header1.Caption='Код перс.'
				ENDWITH
				WITH .Columns(6)
				.ControlSource='IIF(ALLTRIM(Main.Nest2)==ALLTRIM(Main.Nest3),ALLTRIM(Main.Nest2),ALLTRIM(Main.Nest2)+" -> "+ALLTRIM(Main.Nest3))'
				.Width=IIF(lVsiPrac OR lArcPrac,200,0)
				.Enabled=lVsiPrac OR lArcPrac
				.Header1.Caption='Підрозділ'			
				ENDWITH
				WITH .Columns(7)
				.ControlSource='places.posada'
				.Width=200
				.Enabled=.t.
				.Header1.Caption='Посада'
				ENDWITH
				WITH .Columns(8)
				.ControlSource='Main.vstup'
				.Width=80
				.Enabled=.t.
				.Header1.Caption='Наук.ст.'
				ENDWITH
				WITH .Columns(9)
				.ControlSource='Main.vzvan'
				.Width=90
				.Enabled=.t.
				.Header1.Caption='Вч.зван.'
				ENDWITH
				WITH .Columns(1)
				.ControlSource='Main.Name1'
				.Width=220
				.Enabled=.t.
				.Header1.Caption='Прізвище'
				ENDWITH
				WITH .Columns(2)
				.ControlSource='Main.Name2'
				.Width=IIF(lVsiPrac OR lArcPrac,130,180)
				.Enabled=.t.
				.Header1.Caption=[Ім'я]
				ENDWITH
				WITH .Columns(3)
				.ControlSource='Main.Name3'
				.Width=IIF(lVsiPrac OR lArcPrac,150,180)
				.Enabled=.t.
				.Header1.Caption='По батькові'
				ENDWITH
				FOR icol=1 TO .ColumnCount
					WITH .Columns(icol).Header1
					.Alignment=2
					.FontSize=14
					ENDWITH
					WITH .Columns(icol)
					.Alignment=0
					.FontSize=14
					.ReadOnly=.t.
					ENDWITH
				ENDFOR
				.Columns(4).Header1.FontSize=10
				.Columns(4).Header1.WordWrap=.t.
				.Columns(5).Header1.FontSize=10
				.Columns(5).Header1.WordWrap=.t.
*				WITH .Columns(7)
*				.ControlSource='Main.Pos'
*				.Width=150
*				.Enabled=.t.
*				ENDWITH
			.SetFocus
			ENDWITH
			.AddObject('cmdDaniPrac','DaniPrac')
			.AddObject('cmdPoshukPrac','PoshukPrac')
			.AddObject('cmdArxivPrac','ArxivPrac')
			.AddObject('cmdEditPrac','EditPrac')
			.AddObject('cmdDelPrac','DelPrac')
			.AddObject('cmdNewPrac','AddNewPrac')
			.AddObject('cmdRozarxivPrac','RozarxivPrac')
			WITH .cmdDaniPrac
			.Left=10
			.Top=530
			ENDWITH
			WITH .cmdPoshukPrac
			.Left=140
			.Top=530
			ENDWITH
			WITH .cmdArxivPrac
			.Left=270
			.Top=530
			ENDWITH
			WITH .cmdEditPrac
			.Left=360
			.Top=530
			ENDWITH
			WITH .cmdDelPrac
			.Left=420
			.Top=530
			ENDWITH
			WITH .cmdNewPrac
			.Left=480
			.Top=530
			ENDWITH
			WITH .cmdRozarxivPrac
			.Left=540
			.Top=530
			ENDWITH
			.AddObject('lblkPrac','Label')
			WITH .lblkPrac
			.Left=700
			.Top=530
			.Width=200
			.FontSize=14
			.Height=25
			.Visible=.t.
			.Caption=[Працівників : ]+STR(kprac,5)
			ENDWITH
*		USE IN Main
		ENDWITH
	ELSE
		=MessageBox([Не вибрано підрозділ],MB_OKe,m.logos+[ - Помилка])
		WITH ThisForm
		.cmdPrac.Enabled=.t.
		.cmdPCStCancel.Enabled=.t.
		.cboN1.Enabled=.t.
		.cboN2.Enabled=.t.
		.cboN3.Enabled=.t.
		.chkVsiPrac.Enabled=.t.
		.cboN1.SetFocus
		ENDWITH
	ENDIF
ENDPROC
ENDDEFINE

DEFINE CLASS PracGrid AS Grid
*RowSource='Main'
ColumnCount=9
HeaderHeight=40
RowHeight=25
ENDDEFINE

DEFINE CLASS ClosPracL AS CommandButton
Caption=[Закрити]
StatusBarText=[Закриття cписку працівників]
ToolTipText=[Закриття cписку працівників]
Width=70
Height=23
FontSize=12
Visible=.t.
PROCEDURE Click
	SELECT Main
	SET CARRY TO
	SET CARRY OFF
	IF USED('Main')
		USE IN Main
	ENDIF
	IF USED('Places')
		USE IN Places
	ENDIF
	WITH ThisForm
	.RemoveObject('grdPrac')
	.RemoveObject('lblkPrac')
	.RemoveObject('cmdPoshukPrac')
	.RemoveObject('cmdClosPracL')
	.RemoveObject('cmdDaniPrac')
	.RemoveObject('cmdArxivPrac')
	.RemoveObject('cmdEditPrac')
	.RemoveObject('cmdDelPrac')
	.RemoveObject('cmdNewPrac')	
	.RemoveObject('cmdRozarxivPrac')
	.cmdPCStCancel.Enabled=.t.
	.cmdPrac.Enabled=.t.
	.cboN1.Enabled=.t.
	.cboN2.Enabled=.t.
	.cboN3.Enabled=.t.
	.chkVsiPrac.Enabled=.t.
	.chkVsiPrac.Enabled=.t.
	.chkNeSform.Enabled=.t.
	.cboN1.SetFocus
	ENDWITH
ENDPROC
ENDDEFINE

DEFINE CLASS PCStCancel AS CommandButton
StatusBarText=[Назад до головного меню]
ToolTipText=[Назад до головного меню]
Caption=[Закрити]
FontSize=12
Width=100
Height=25
Visible=.t.
Enabled=.t.
PROCEDURE Click
	=lockmenu(.f.)
	WITH ThisForm
	.RemoveObject('ZadL1')
	.RemoveObject('lblN1')
	.RemoveOBject('cboN1')
	.RemoveObject('lblN2')
	.RemoveObject('cboN2')
	.RemoveObject('lblN3')
	.RemoveObject('cboN3')
	.RemoveObject('cmdPrac')
	.RemoveObject('chkVsiPrac')
	.RemoveObject('chkArcPrac')
	.RemoveObject('chkNeSform')
	.CBExit.Enabled=.t.
	.grdImen.Visible=.t.
	.grdImen.Enabled=.t.
	.lblImen.Visible=.t.
	
 *   .Acs.Visible=.f.

	ENDWITH
	IF USED('Nest1C')
		USE IN Nest1C
	ENDIF
IF USED('Nest2C')
		USE IN Nest2C
	ENDIF
	IF USED('Nest3C')
		USE IN Nest3C
	ENDIF
	ThisForm.RemoveObject('cmdPCStCancel')
ENDPROC
ENDDEFINE

DEFINE CLASS DaniPrac AS CommandButton
StatusBarText=[Виведення особистих даних про працівника]
ToolTipText=[Виведення особистих даних про працівника]
Caption=[Дані працівника]
FontSize=12
Width=130
Height=23
Visible=.t.
Enabled=NOT lI_Am_Guest
PROCEDURE Click
	SELECT Main
	SCATTER MEMVAR MEMO
*	MESSAGEBOX('')
	DO daniprac
ENDPROC
ENDDEFINE

DEFINE CLASS PoshukPrac AS CommandButton
StatusBarText=[Пошук особистих даних про працівника]
ToolTipText=[Пошук особистих даних про працівника]
Caption=[Пошук]
FontSize=12
Width=60
Height=23
Visible=.t.
Enabled=.t.
PROCEDURE Click
	SELECT main
	potrec=RECNO()
	m.prizv=''
	DO FORM Poshprac
ENDPROC
ENDDEFINE

DEFINE CLASS ArxivPrac AS CommandButton
StatusBarText=[Архівування працівника-запис працівника в архів відповідного виду персоналу]
ToolTipText=[Архівування працівника-запис працівника в в архів відповідного виду персоналу]
Caption=[Архівувати]
FontSize=12
Width=90
Height=23
Visible=.t.
Enabled=EMPTY(Upd)

PROCEDURE Click
PUBLIC aAccess
LOCAL nest1,nest2,nest3,iPravZm
 
	SELECT main                              
	SCATTER MEMVAR MEMO
	m.nest1=ALLTRIM(main.nest1)
	*   Перевірка прав на зміну
	SET EXACT ON
	m.iPravZm=ASCAN(aAccess,m.nest1)
	SET EXACT OFF
	IF m.iPravZm=0
		=MESSAGEBOX('У Вас немає прав на архівування цього запису',16,'Помилка')
	*    return
	ELSE
		IF EMPTY(aAccess(m.iPravZm+1))
			spravad=sprava
			dname1=ALLTRIM(name1)
			spravaarx=ALLTRIM(sprava)+ALLTRIM(DTOC(DATE()))
			*m.sprava=spravaarx
			DO case
			case m.nest1='00' 
   				dnest1='50'
   			case m.nest1='01' 
   				dnest1='51'
   			case m.nest1='02' 
   				dnest1='52'
   			case m.nest1='03' 
   				dnest1='53'
   			case m.nest1='04' 
   				dnest1='54'
   			case m.nest1='05' 
				dnest1='55'
			case m.nest1='06' 
				dnest1='56'
 			case m.nest1='08' 
 				dnest1='58'
 			OTHERWISE
				=MESSAGEBOX('Для цього виду персоналу архівування не передбачене',48,'Увага!')
 				RETURN
 			ENDCASE
 			dpotstan=.F.
			replace sprava WITH spravaarx,nest1 WITH dnest1,potstan WITH dpotstan && FOR ALLTRIM(sprava)=ALLTRIM(spravad) 
			*SELECT main
			*GO top
			ThisForm.grdPrac.SetFocus
 			select 0 
			m.osvitas=m.shlyx+'\data\osvita' 
			use (m.osvitas) 
 			inosvitas=TmpDir+[\inosvitas]
 			index on sprava to (inosvitas) comp
 			select 0 
			m.prizperm=m.shlyx+'\data\prizperm' 
			use (m.prizperm) 
			inprizperm=TmpDir+[\inprizperm]
			index on sprava to (inprizperm) comp
			select 0 
			m.trudova=m.shlyx+'\data\trudova' 
			use (m.trudova) 
 			intrudova=TmpDir+[\intrudova]
 			index on sprava to (intrudova) comp
 			select 0 
			m.doplnad=m.shlyx+'\data\doplnad' 
			use (m.doplnad) 
 			indoplnad=TmpDir+[\indoplnad]
 			index on sprava to (indoplnad) comp
 			select 0 
			m.vidpustk=m.shlyx+'\data\vidpustk' 
			use (m.vidpustk) 
 			invidpustk=TmpDir+[\invidpustk]
 			index on sprava to (invidpustk) comp
 			select 0 
			m.sumisnyk=m.shlyx+'\data\sumisnyk' 
			use (m.sumisnyk) 
 			insumisnyk=TmpDir+[\insumisnyk]
 			index on sprava to (insumisnyk) comp
 			select 0 
			m.rodstans=m.shlyx+'\data\rodstan' 
			use (m.rodstans) 
 			inrodstans=TmpDir+[\inrodstans]
 			index on sprava to (inrodstans) comp
 			select 0 
			m.duplat=m.shlyx+'\data\duplat' 
			use (m.duplat) 
 			induplat=TmpDir+[\induplat]
 			index on sprava to (induplat) comp
			select osvita
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			select prizperm
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			select trudova
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			select doplnad
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			select vidpustk
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			select sumisnyk
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			select rodstan
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			SELECT duplat
			replace sprava WITH spravaarx FOR ALLTRIM(sprava)==ALLTRIM(spravad)
			USE IN osvita
			USE IN prizperm
			USE IN trudova
			USE IN doplnad
			USE IN vidpustk
			USE IN sumisnyk
			USE IN rodstan
			USE IN duplat
			SELECT main
			=MESSAGEBOX('Запис про працівника на прізвище '+dname1+' перенесено в архів',64,'Інфо')
		ELSE
			=MESSAGEBOX('У Вас немає прав на архівування даного запису',16,'Помилка')
		ENDIF
	ENDIF
	ThisForm.grdPrac.SetFocus
ENDPROC
ENDDEFINE

DEFINE CLASS EditPrac AS CommandButton
StatusBarText=[Зміна імені та підроздіду працівника]
ToolTipText=[Зміна імені та підроздіду працівника]
Caption=[Редаг.]
FontSize=12
Width=60
Height=23
Visible=.t.
Enabled=EMPTY(Upd)
PROCEDURE Click
	PUBLIC aAccess
	LOCAL nest1,nest2,nest3,iPravZm
	SELECT main
	m.nest1=ALLTRIM(main.nest1)
*	DISPLAY MEMORY LIKE aA* TO FILE mem.txt
*	MODIFY COMMAND mem.txt NOEDIT
*   Перевірка прав на зміну
	SET EXACT ON
	m.iPravZm=ASCAN(aAccess,m.nest1)
	SET EXACT OFF
*	=MESSAGEBOX(STR(m.iPravZm))
	IF m.iPravZm=0
		=MESSAGEBOX('У Вас немає прав на редагування записів у базі!',16,'Помилка')
		RETURN
	ELSE
		IF EMPTY(aAccess(m.iPravZm+1))
			cMode='Edit'
			DO FORM EditPrac
		ELSE
			=MESSAGEBOX('У Вас немає прав на редагування цього запису!',16,'Помилка')
		ENDIF
	ENDIF
ENDPROC
ENDDEFINE

DEFINE CLASS DelPrac AS CommandButton
StatusBarText=[Видалення працівника з бази]
ToolTipText=[Видалення працівника з бази]
Caption=[Видал.]
FontSize=12
Width=60
Height=23
Visible=.t.
Enabled=EMPTY(Upd)
PROCEDURE Click
	PUBLIC aAccess
	LOCAL nest1,iPravZm
	SELECT main
	m.nest1=ALLTRIM(main.nest1)
*	DISPLAY MEMORY LIKE aA* TO FILE mem.txt
*	MODIFY COMMAND mem.txt NOEDIT
*   Перевірка прав на зміну
	SET EXACT ON
	m.iPravZm=ASCAN(aAccess,m.nest1)
	SET EXACT OFF
*	=MESSAGEBOX(STR(m.iPravZm))
	IF m.iPravZm=0
		=MESSAGEBOX('У Вас немає прав на видалення записів з бази!',16,'Помилка')
	ELSE
		IF EMPTY(aAccess(m.iPravZm+1))
			IF MESSAGEBOX('Ви дійсно бажаєте видалити цей запис?',4+32+256,'Підтвердження')=6
   				DELETE
				ThisForm.grdPrac.SetFocus
				=MESSAGEBOX('Запис видалено успішно',64,'Інфо')
			ELSE
				=MESSAGEBOX('Видалення запису з бази скасовано',64,'Інфо')
			ENDIF
		ELSE 
			=MESSAGEBOX('У Вас немає прав на видалення цього запису!',16,'Помилка')
		ENDIF		
	ENDIF
	ThisForm.grdPrac.SetFocus
ENDPROC
ENDDEFINE

DEFINE CLASS AddNewPrac AS CommandButton
StatusBarText=[Додавання нового працівника]
ToolTipText=[Додавання нового працівника]
Caption=[Додати]
FontSize=12
Width=60
Height=23
Visible=.t.
Enabled=EMPTY(Upd)
PROCEDURE Click
	cMode='AddNew'
	DO FORM EditPrac
ENDPROC
ENDDEFINE

DEFINE CLASS RozarxivPrac AS CommandButton
StatusBarText=[Розархівування працівника-запис працівника з архіву в відповідний підрозділ]
ToolTipText=[Розрхівування працівника-запис працівника з архіву в відповідний підрозділ]
Caption=[Розархівувати]
FontSize=12
Width=110
Height=23
Visible=.t.
Enabled=EMPTY(Upd)
PROCEDURE Click
	PUBLIC aAccess
	LOCAL nest1,nest2,nest3,iPravZm
	SELECT main
	m.nest1=ALLTRIM(main.nest1)
*	DISPLAY MEMORY LIKE aA* TO FILE mem.txt
*	MODIFY COMMAND mem.txt NOEDIT
*   Перевірка прав на зміну
	SET EXACT ON
	m.iPravZm=ASCAN(aAccess,m.nest1)
	SET EXACT OFF
*	=MESSAGEBOX(STR(m.iPravZm))
	IF m.iPravZm=0
		=MESSAGEBOX('У Вас немає прав на редагування записів у базі!',16,'Помилка')
		RETURN
	ELSE
		IF EMPTY(aAccess(m.iPravZm+1))
			cMode='Edit'
			DO FORM rozarxpr
		ELSE
			=MESSAGEBOX('У Вас немає прав на редагування цього запису!',16,'Помилка')
		ENDIF
	ENDIF
ENDPROC
ENDDEFINE

DEFINE CLASS VCheckBox AS CheckBox
PROCEDURE InteractiveChange
	ThisForm.chkArcPrac.Value=.f.
	IF This.Value
		ThisForm.chkArcPrac.Enabled=.f.
	ELSE
		ThisForm.chkArcPrac.Enabled=.t.
	ENDIF
	ThisForm.chkArcPrac.Refresh
ENDPROC
ENDDEFINE

DEFINE CLASS ACheckBox AS CheckBox
PROCEDURE InteractiveChange
	ThisForm.chkVsiPrac.Value=.f.
	IF This.Value
		ThisForm.chkVsiPrac.Enabled=.f.
	ELSE
		ThisForm.chkVsiPrac.Enabled=.t.
	ENDIF
	ThisForm.chkVsiPrac.Refresh
ENDPROC
ENDDEFINE

