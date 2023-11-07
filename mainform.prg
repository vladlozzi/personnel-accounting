m.curdate=DATE()
m.date1=m.curdate
m.date2=m.curdate+6
m.main=m.shlyx+'\data\main'
m.posady=m.shlyx+'\dov\posad'
m.imeniny=m.tmpdir+'\imeniny'
SELECT IIF(NOT lI_Am_Guest,DTOC(a.datanar),LEFT(DTOC(a.datanar),5)) AS birthday, ;
	a.nest1,a.nest2,a.nest3, ;
	ALLTRIM(a.name1)+" "+ALLTRIM(a.name2)+" "+ALLTRIM(a.name3)+", "+ALLTRIM(b.posada) AS fname, ;
	IIF(NOT lI_Am_Guest,YEAR(curdate)-YEAR(datanar),"") AS vik, ;
	SPACE(6) AS jubilee,datanar,name1,name2,name3 ;
FROM (m.main) a, (m.posady) b INTO TABLE (m.imeniny) ;
WHERE potstan AND a.nest1=b.nest1 AND a.pos=b.pos AND ;
	RIGHT(DTOS(date1),4)<=RIGHT(DTOS(datanar),4) AND RIGHT(DTOS(datanar),4)<=RIGHT(DTOS(date2),4)
USE IN main
USE IN posad
USE IN imeniny
USE (m.imeniny)
REPLACE nest3 WITH IIF(nest3=nest2,"",nest3), ;
	jubilee WITH IIF(YEAR(curdate)-YEAR(datanar)=75 OR ;
		(YEAR(curdate)-YEAR(datanar)>49 AND MOD(YEAR(curdate)-YEAR(datanar), 10) = 0),"ювілей","") ALL
*BROWSE NOEDIT
USE
SELECT 25
USE (m.imeniny) NOUPDATE
INDEX ON RIGHT(DTOS(datanar),4)+name1+name2+name3 TO (m.imeniny) COMPACT
oMform=CreateObject('MForm')
WITH oMform
	.ShowTips=.t.
	.Caption=[Іменинники за певний період]
	.MinButton=.f.
	.MaxButton=.f.
	.Visible=.T.
	.Top=0
	.Height=600
	.Left=0
	.Width=1300
	.Closable=.F.
	.AddObject('Acs','MyLbl')
	.AddObject('lblImen','MyLbl3')
	.AddObject('CBExit','MyCBExit') && Add Exit command button
	.AddObject('grdImen','ImenGrid')
	.lblImen.Caption=[Іменинники за період: ]+DTOC(m.date1)+" - "+DTOC(m.date2)
	WITH .grdImen.Columns(1)
		.Header1.Caption=''
		.Width=100
	ENDWITH
	WITH .grdImen.Columns(2)
		.Header1.Caption='Код перс.'
	ENDWITH
	WITH .grdImen.Columns(3)
		.Header1.Caption='Підрозділ'
	ENDWITH
	WITH .grdImen.Columns(4)
		.Header1.Caption=''
	ENDWITH
	WITH .grdImen.Columns(5)
		.DynamicForeColor="IIF(nest1='01',RGB(0,0,255),RGB(0,0,0))"
		.Header1.Caption=[Прізвище, ім'я, по батькові, посада]
		.Width=450
	ENDWITH
	WITH .grdImen.Columns(6)
		.Header1.Caption='Вік'
		.Width=IIF(NOT lI_Am_Guest,30,0)
		.Alignment=2
	ENDWITH
	WITH .grdImen.Columns(7)
		.Header1.Caption=''
		.Alignment=2
	ENDWITH
	FOR iCol=1 TO 7
	.grdImen.Columns(iCol).FontSize=12
	ENDFOR
	.grdImen.Columns(7).FontBold=.t.
	.grdImen.Columns(7).ForeColor=RGB(255,0,0)
ENDWITH

READ EVENTS

DEFINE CLASS MForm AS Form
ScrollBars=3

PROCEDURE Init
	DO MainMenu
ENDPROC

PROCEDURE Destroy
	CLOSE ALL
	m.imen=IIF(m.shlyx==".",FULLPATH("")+"Data\",m.shlyx+"\"+"Data\")+"imeniny.dbf"
	ERASE (m.imen)
	ERASE vk.tmp
	IF NOT (lI_Am_Rector OR lI_Am_Guest)
		DO Backup
	ENDIF
	CLEAR EVENTS
ENDPROC

ENDDEFINE

DEFINE CLASS MyLbl AS Label
Caption=IIF(EMPTY(Upd),[Зміна],[Перегляд])
Left=0
Top=580
Width=80
Height=15
Visible=.T.
FontSize=10
FontBold=.f.
ForeColor=RGB(255,255,0)
BackColor=RGB(0,82,255)
Alignment=2
ENDDEFINE

DEFINE CLASS MyLbl2 AS Label
Caption=[Виберіть команду з головного меню програми ] + ;
	[(Кадри, Накази, Статистика, Довідники, Редагування) у другому рядку згори]
Left=310
Top=150
Width=270
Height=150
WordWrap=.t.
BorderStyle=1
Visible=.T.
FontSize=14
FontBold=.t.
ForeColor=RGB(0,64,96)
Alignment=2
ENDDEFINE

DEFINE CLASS MyLbl3 AS Label
Left=130
Top=5
Width=450
Height=20
Visible=.T.
FontSize=14
FontBold=.t.
ForeColor=RGB(0,64,96)
ENDDEFINE

DEFINE CLASS MyCBExit AS CommandButton
Caption=[Вихід]
StatusBarText=[Закінчення роботи з ]+m.logos
ToolTipText=[Закінчення роботи з ]+m.logos
Left=50
Top=5
Width=70
Height=25
Visible=.T.
FontSize=12
PROC Click
*	USE IN Imeniny
*	DO Backup
	Thisform.Release
ENDPROC
ENDDEFINE

DEFINE CLASS ImenGrid AS Grid
	ColumnCount=7
	Enabled=.T.
	Visible=.T.
	RowSource='Imeniny'
	RowSourceType=5
	FontName='Arial'
	FontSize=14
	Width=1200
	Left=5
	Top=30
	Height=450
ENDDEFINE
