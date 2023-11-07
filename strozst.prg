
****************************************************************************
*************** Формування таблиці "Штатна розстановка" ********************
****************************************************************************
*PUBLIC oWordDoc1
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

 m.doplnad=m.shlyx+'\data\doplnad'
 m.main=m.shlyx+'\data\main' 
 m.posad=m.shlyx+'\dov\posad'
select a.sprava,a.nest1,a.nest2,a.nest3,a.pos, ;
LEFT(ALLTRIM(a.name1)+[ ]+ALLTRIM(a.name2)+[ ]+ALLTRIM(a.name3),31) as prizv, ;
a.stod,a.oklad,0000.00 as pdopl,0000.00 as pnadb,0000.00 as nadbdop,e.posada,e.rang from (m.main) a, (m.posad) e ;
where potstan AND a.nest1==e.nest1 and a.pos=e.pos ;
into table (shtat1) order by a.nest1,a.nest2,a.nest3,e.rang
use in shtat1
USE IN main
USE IN posad
USE (m.doplnad) IN e
USE (shtat1) IN a
SELECT e
INDEX ON sprava TO zz2 comp
SELECT a
INDEX ON sprava TO zz1 COMPACT 
spravad=SPACE(10)
m.okl=0

scan
spravad=sprava
m.okl=oklad
STORE 0 TO m.dopl,m.nadb,m.naddop
SELECT e
SCAN for sprava=spravad
IF EMPTY(datzn)  
IF vid='доплата'
 IF odvim='%'
    m.dopl=m.dopl+ROUND(m.okl*kilkist/100,2)
 ELSE 
    m.dopl=m.dopl+kilkist
 endif
endif
IF vid='надбавка'
  IF odvim='%'
     m.nadb=m.nadb+ROUND(m.okl*kilkist/100,2)
  ELSE
     m.nadb=m.nadb+kilkist
  endif
endif
ENDIF
ENDSCAN
m.naddop=m.dopl+m.nadb
SELECT a
replace pnadb WITH m.nadb,pdopl WITH m.dopl,nadbdop WITH m.naddop
spravad=SPACE(10)
STORE 0 to okl,st
ENDSCAN
*BROWSE FOR nadbdop>0
USE IN doplnad
ERASE zz2.idx
SELECT shtat1
* BROWSE NOED NOAP NODE
USE 
ERASE zz1.idx
 m.nest1=m.shlyx+'\dov\nest1'
USE (m.nest1) IN b 
DEFINE POPUP menu1 FROM 5,40 TO 16,180 TITLE' Виберіть підрозділ 1-го рівня ' ;
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
WAIT 'Зачекайте, йде формування таблиці штатної розстановки !' WINDOW NOWAIT

DIMENSION K3(6),K2(6),K1(6)
STORE 0000000000.00 TO K1,irow

a1=TmpDir+'\inshtat1'
a2=TmpDir+'\innest2'
a3=TmpDir+'\innest3'

SELECT a
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
*browse
INDEX ON nest2+nest3 TO(a1) COMP FOR nest1==prom
oWord=CreateObject('Word.Application')
oWord.Visible=.f.

oWordDoc1=oWord.Documents.Add

DO druk
DO WHILE !EOF()
	STORE 0 TO K2
	m.nest2=nest2
	IF irow>nrow1page
		oWordDoc1.Content.InsertAfter(CHR(12))
		oWordDoc1.Content.InsertParagraphAfter
		DO druk
	ENDIF
	oWordDoc1.Content.InsertParagraphAfter
	oWordDoc1.Content.InsertParagraphAfter
	SELECT nest2
	SEEK m.nest2
	m.povnest2=IIF(FOUND(),povnest2,m.nest2)
	oWordDoc1.Content.InsertAfter(SPACE(10)+LEFT(m.povnest2,110))
*=MESSAGEBOX('Добре',64,'')
	irow=irow+2
*	IF SUBSTR(m.povnest2,112,2)#'  '
*		oWordDoc1.Content.InsertParagraphAfter
*		oWordDoc1.Content.InsertAfter(SUBSTR(m.povnest2,112,60))
*		irow=irow+1
*	ENDIF
	SELECT a
	DO WHILE nest2=m.nest2
		STORE 0 TO K3
		oWordDoc1.Content.InsertParagraphAfter
		m.nest3=nest3
		SELECT nest3
		SEEK m.nest2+m.nest3 
	*GO top
	*LOCATE FOR nest2=m.nest2 AND nest3=m.nest3 
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
*			m.dopl=ROUND(a.oklad*a.stod*a.pdopl/100,2)
*			m.nadb=ROUND(a.oklad*a.stod*a.pnadb/100,2)
*			m.okl1=m.dopl+m.nadb
			okl=ROUND(a.stod*a.oklad,2)+a.nadbdop
			oWordDoc1.Content.InsertAfter(a.prizv) && 2
			oWordDoc1.Content.InsertAfter(' '+LEFT(a.posada,20)) && 34
			oWordDoc1.Content.InsertAfter(' '+STR(a.stod,6,2)) && )PICT'9.99') 54
			oWordDoc1.Content.InsertAfter('  '+STR(a.oklad,7,2)) && PICT '999.99') 62
			oWordDoc1.Content.InsertAfter(SPACE(1)+STR(a.pdopl,7,2)) && PICT '99.9') 72
			oWordDoc1.Content.InsertAfter(SPACE(1)+STR(a.pnadb,7,2)) && PICT '99.9') 79
			oWordDoc1.Content.InsertAfter(' '+STR(okl,10,2)) && PICT '9999.99') 85
			oWordDoc1.Content.InsertAfter(STR(a.nadbdop,9,2)) && PICT '999.99') 95
			irow=irow+1
			K3(1)=K3(1)+a.stod
			K3(2)=K3(2)+a.oklad
			K3(3)=K3(3)+a.pdopl
			K3(4)=K3(4)+a.pnadb
			K3(5)=K3(5)+okl
			K3(6)=K3(6)+a.nadbdop
			IF irow>nrow1page
				oWordDoc1.Content.InsertParagraphAfter
				oWordDoc1.Content.InsertAfter(CHR(12))
				DO druk
			ENDIF
		ENDSCAN
		oWordDoc1.Content.InsertParagraphAfter
		oWordDoc1.Content.InsertParagraphAfter
		oWordDoc1.Content.InsertAfter(SPACE(42)+'Всього:')
		oWordDoc1.Content.InsertAfter(SPACE(3)+STR(k3(1),7,2)) &&53
		oWordDoc1.Content.InsertAfter(SPACE(9)) && PICT '99999.99') 61
		oWordDoc1.Content.InsertAfter(SPACE(7)) && PICT '999') 72
		oWordDoc1.Content.InsertAfter(SPACE(8)) && PICT '999') 79
		oWordDoc1.Content.InsertAfter(STR(k3(5),11,2)) && PICT '99999.99') 85
		oWordDoc1.Content.InsertAfter(STR(k3(6),9,2)) && PICT '999.99') 95
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
	oWordDoc1.Content.InsertParagraphAfter
	oWordDoc1.Content.InsertParagraphAfter
	oWordDoc1.Content.InsertAfter(SPACE(30)+'Всього на '+m.nest2+':')
	oWordDoc1.Content.InsertAfter(SPACE(3)+STR(k2(1),7,2)) &&53
	oWordDoc1.Content.InsertAfter(SPACE(9)) && PICT '99999.99') 61
	oWordDoc1.Content.InsertAfter(SPACE(7)) && PICT '999') 72
	oWordDoc1.Content.InsertAfter(SPACE(8)) && PICT '999') 79
	oWordDoc1.Content.InsertAfter(STR(k2(5),11,2)) && PICT '99999.99') 85
	oWordDoc1.Content.InsertAfter(STR(k2(6),9,2)) && PICT '999.99') 95
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
oWordDoc1.Content.InsertAfter('Разом у підрозділі 1-го рівня') && 1
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter(PADC(["]+ALLTRIM(b.povnest1)+["],50)) && AT 1
oWordDoc1.Content.InsertAfter(STR(k1(1),9,2)) &&53
oWordDoc1.Content.InsertAfter(SPACE(9)) && PICT '99999.99') 61
oWordDoc1.Content.InsertAfter(SPACE(7)) && PICT '999') 72
oWordDoc1.Content.InsertAfter(SPACE(8)) && PICT '999') 79
oWordDoc1.Content.InsertAfter(STR(k1(5),11,2)) && PICT '99999.99') 85
oWordDoc1.Content.InsertAfter(STR(k1(6),9,2)) && PICT '999.99') 95
*IF .f.
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
    .LeftMargin = CmToPnt(2)
    .RightMargin = CmToPnt(0.5)
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
*ENDIF

IF alltrim(m.shlyx)=='.' 
m.f2=FULLPATH('')+'form\'+DTOS(DATE())+'_'+prom+'_strozst.doc'
else
m.f2=m.shlyx+'\form\'+DTOS(DATE())+'_'+prom+'_strozst.doc'
endif
*=MESSAGEBOX(m.f2)

oWordDoc1.SaveAs(m.f2)

oWord.Visible=.t.
USE IN a
USE IN c
USE IN d
WAIT CLEAR
=MESSAGEBOX([Штатну розстановку сформовано]+CHR(13)+ ;
			[Для перегляду перейдіть у Word],64,m.logos+[ - Інфо])
SET CURSOR ON

RETURN

PROC druk
*=MESSAGEBOX('Добре',64,'Druk')
oWordDoc1.Content.InsertAfter('Ш Т А Т Н А   Р О З С Т А Н О В К А')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter(' '+b.povnest1)
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('--------------------------------------------------------------------------------------------------------------')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter([|       Прізвище,ім'я,         |                    | К-ть  |Посадо-|Допл. і надб. |Місячний  |У т.ч.  |     |])
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('|        по-батькові           |       Посада       |посадо-|вий    |до окл.(грн.) |фонд заро-|доплата,|При- |')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('|                              |                    |вих    |оклад, |--------------|бітної    |надбав- |мітка|')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('|                              |                    |одиниць|грн.   |Допла-|Надбав-|плати,грн.|ка, грн.|     |')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('|                              |                    |       |       |та    |ка     |          |        |     |')
oWordDoc1.Content.InsertParagraphAfter
oWordDoc1.Content.InsertAfter('--------------------------------------------------------------------------------------------------------------')   
irow=10
*=MESSAGEBOX('Добре',64,'Druk')
RETURN
