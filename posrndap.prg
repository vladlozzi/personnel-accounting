****************************************************************************
********* Формування таблиці "Підрозділи, працівники, дом.адреси" **********
****************************************************************************
WAIT [Зачекайте...] WINDOW NOWAIT
True=.t.
False=.f.
wdOrientPortrait=0
wdPrinterDefaultBin=0
wdSectionNewPage=2
wdAlignVerticalTop=0
wdLineSpaceSingle=0
wdAlignParagraphLeft=0

nrow1page=65

shtat1=TmpDir+'\shtat1.dbf'

 m.main=m.shlyx+'\data\main' 
 m.posad=m.shlyx+'\dov\posad'
select a.nest1,a.nest2,a.nest3,a.pos,a.domadr,YEAR(a.datanar) AS riknar, ;
LEFT(ALLTRIM(a.name1)+[ ]+ALLTRIM(a.name2)+[ ]+ALLTRIM(a.name3),31) as prizv, ;
a.stod,a.oklad,a.pdopl,a.pnadb,e.posada,e.rang from (m.main) a, (m.posad) e ;
where potstan AND a.nest1==e.nest1 and a.pos=e.pos ;
into table (shtat1) order by a.nest1,a.nest2,a.nest3,e.rang

USE IN main
USE IN posad

SELECT shtat1
* BROWSE NOED NOAP NODE
USE
 m.nest1=m.shlyx+'\dov\nest1'
USE (m.nest1) IN b 
DEFINE POPUP menu1 FROM 5,60 TO 16,180 TITLE' Виберіть підрозділ 1-го рівня ' ;
       FOOTER ' Esc - вихід ' PROMPT FIELD b.nest1+'|'+b.povnest1 ;
       FONT "Courier New",11
ON SELECTION POPUP menu1 DO form1 WITH LEFT(PROMPT(),2)
WAIT CLEAR
ACTIVATE POPUP menu1
DEACTIVATE POPUP menu1
SET PRINTER TO
SET PRINTER OFF
USE IN nest1
erase (shtat1)

PROC form1
PARAMETER prom
IF EMPTY(prom)
   USE IN nest1
   RETURN
ENDIF

SET CURSOR OFF
WAIT 'Зачекайте, йде формування таблиці !' WINDOW NOWAIT

DIMENSION K3(6),K2(6),K1(6)
STORE 0000000000.00 TO K1,irow

a1=TmpDir+'\inshtat1'
a2=TmpDir+'\innest2'
a3=TmpDir+'\innest3'

USE (shtat1) IN a
m.nest2=m.shlyx+'\dov\nest2'
m.nest3=m.shlyx+'\dov\nest3'
USE (m.nest2) IN c
USE (m.nest3) IN d

SELE c
INDEX ON nest2 TO (a2) COMPACT FOR nest1==prom

SELE d
INDEX ON nest2+nest3 TO (a3) COMP

SELE a
*INDEX ON ALLT(nest2)+ALLT(nest3)+ALLT(row(a.rang)) TO(a1) COMP FOR ALLT(nest1)==prom
INDEX ON nest2+nest3 TO(a1) COMP FOR nest1==prom
oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add

DO druk
DO WHILE !EOF()
	STORE 0 TO K2
	m.nest2=nest2
*	IF irow>nrow1page
*		oWordDoc1.Content.InsertAfter(CHR(12))
*		oWordDoc1.Content.InsertParagraphAfter
*		DO druk
*	ENDIF
	oWordDoc1.Content.InsertParagraphAfter
	oWordDoc1.Content.InsertParagraphAfter
	SELECT nest2
	SEEK m.nest2
	m.povnest2=IIF(FOUND(),povnest2,m.nest2)
	oWordDoc1.Content.InsertAfter(SPACE(10)+LEFT(m.povnest2,110))
	irow=irow+2
	IF SUBSTR(m.povnest2,112,2)#'  '
		oWordDoc1.Content.InsertParagraphAfter
		oWordDoc1.Content.InsertAfter(SUBSTR(m.povnest2,112,60))
		irow=irow+1
	ENDIF
	SELECT a
	DO WHILE nest2=m.nest2
		STORE 0 TO K3

		oWordDoc1.Content.InsertParagraphAfter
		m.nest3=nest3
		SELECT nest3
		SEEK m.nest2+m.nest3
		m.povnest3=IIF(FOUND(),povnest3,m.nest3)
		oWordDoc1.Content.InsertAfter(SPACE(10)+LEFT(m.povnest3,110))
		irow=irow+1
		IF SUBSTR(m.povnest3,112,2)#'  '
			oWordDoc1.Content.InsertParagraphAfter
			oWordDoc1.Content.InsertAfter(SUBSTR(m.povnest3,112,60))
			irow=irow+1
		ENDIF
		SELECT a
		SCAN WHILE nest3==m.nest3
			oWordDoc1.Content.InsertParagraphAfter
			m.dopl=ROUND(a.oklad*a.stod*a.pdopl/100,2)
			m.nadb=ROUND(a.oklad*a.stod*a.pnadb/100,2)
			m.okl1=m.dopl+m.nadb
			okl=ROUND(a.stod*a.oklad,2)+okl1
			oWordDoc1.Content.InsertAfter(a.prizv) && 2
			oWordDoc1.Content.InsertAfter(' '+LEFT(a.posada,20)) && 34
			oWordDoc1.Content.InsertAfter(' '+STR(a.riknar,8,0)) && 34
			oWordDoc1.Content.InsertAfter('   '+a.domadr) && )PICT'9.99') 54
			irow=irow+1
			K3(1)=K3(1)+a.stod
			K3(2)=K3(2)+a.oklad
			K3(3)=K3(3)+m.dopl
			K3(4)=K3(4)+m.nadb
			K3(5)=K3(5)+okl
			K3(6)=K3(6)+okl1
			IF irow>nrow1page
				oWordDoc1.Content.InsertParagraphAfter
				oWordDoc1.Content.InsertAfter(CHR(12))
				DO druk
			ENDIF
		ENDSCAN
		oWordDoc1.Content.InsertParagraphAfter
		oWordDoc1.Content.InsertParagraphAfter
		irow=irow+2
		IF irow>nrow1page
			oWordDoc1.Content.InsertParagraphAfter
			oWordDoc1.Content.InsertAfter(CHR(12))
			DO druk
		ENDIF
		k2(1)=k2(1)+k3(1)
		k2(2)=k2(2)+k3(2)
		k2(3)=k2(3)+k3(3)
		k2(4)=k2(4)+k3(4)
		k2(5)=k2(5)+k3(5)
		k2(6)=k2(6)+k3(6)
	ENDDO
	IF irow>nrow1page
		oWordDoc1.Content.InsertParagraphAfter
		oWordDoc1.Content.InsertAfter(CHR(12))
		DO druk
	ENDIF
	irow=irow+2
	IF irow>nrow1page
		oWordDoc1.Content.InsertParagraphAfter
		oWordDoc1.Content.InsertAfter(chr(12))
		DO druk
	ENDIF
	k1(1)=k1(1)+k2(1)
	k1(2)=k1(2)+k2(2)
	k1(3)=k1(3)+k2(3)
	k1(4)=k1(4)+k2(4)
	k1(5)=k1(5)+k2(5)
	k1(6)=k1(6)+k2(6)
ENDDO
oWordDoc1.Content.InsertParagraphAfter

WITH oWord
    .Selection.WholeStory
    WITH .Selection.Font
        .Name = "Courier New"
        .Size = 10
        .Bold = False
        .Italic = False
        .StrikeThrough = False
        .DoubleStrikeThrough = False
        .Outline = False
        .Emboss = False
        .Shadow = False
        .Hidden = False
        .SmallCaps = False
        .AllCaps = False
        .Engrave = False
        .Superscript = False
        .Subscript = False
        .Spacing = -0.7
        .Scaling = 90
        .Position = 0
        .Kerning = 0
    ENDWITH
    WITH .Selection.ParagraphFormat
        .LeftIndent = CmToPnt(0)
        .RightIndent = CmToPnt(0)
        .SpaceBefore = 0
        .SpaceBeforeAuto = False
        .SpaceAfter = 0
        .SpaceAfterAuto = False
        .LineSpacingRule = wdLineSpaceSingle
        .Alignment = wdAlignParagraphLeft
        .FirstLineIndent = CmToPnt(0)
        .CharacterUnitLeftIndent = 0
        .CharacterUnitRightIndent = 0
        .CharacterUnitFirstLineIndent = 0
        .LineUnitBefore = 0
        .LineUnitAfter = 0
    ENDWITH
	.Selection.HomeKey(6)
ENDWITH
With oWordDoc1.PageSetup
    .LineNumbering.Active = False
    .Orientation = wdOrientPortrait
    .TopMargin = CmToPnt(1)
    .BottomMargin = CmToPnt(1)
    .LeftMargin = CmToPnt(4)
    .RightMargin = CmToPnt(1)
    .Gutter = CmToPnt(0)
    .HeaderDistance = CmToPnt(0.5)
    .FooterDistance = CmToPnt(0)
    .PageWidth = CmToPnt(21.0)
    .PageHeight = CmToPnt(29.7)
    .FirstPageTray = wdPrinterDefaultBin
    .OtherPagesTray = wdPrinterDefaultBin
    .SectionStart = wdSectionNewPage
    .OddAndEvenPagesHeaderFooter = False
    .DifferentFirstPageHeaderFooter = False
    .VerticalAlignment = wdAlignVerticalTop
    .SuppressEndnotes = True
    .MirrorMargins = False
EndWith

IF alltrim(m.shlyx)=='.' 
m.f11=FULLPATH('')+'form\'+DTOS(DATE())+'_'+prom+'_posrndap.doc'
else
m.f11=m.shlyx+'\form\'+DTOS(DATE())+'_'+prom+'_posrndap.doc'
endif

oWordDoc1.SaveAs(m.f11)

oWord.Visible=.t.
USE IN a
USE IN c
USE IN d
WAIT CLEAR
=MESSAGEBOX([Таблицю сформовано]+CHR(13)+ ;
			[Для перегляду перейдіть у Word],64,m.logos+[ - Інфо])
SET CURSOR ON

RETURN

PROC druk
oWordDoc1.Content.InsertAfter('')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter(' '+b.povnest1)
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('---------------------------------------------------------------------------------------------')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter([|        Прізвище,ім'я,        |       Посада       |  Рік     |           Домашня          |])
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('|         по-батькові          |                    | народж.  |           адреса           |')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('---------------------------------------------------------------------------------------------')   
irow=10
RETURN
