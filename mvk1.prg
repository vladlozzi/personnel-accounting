LOCAL temp
WAIT [Зачекайте...] WINDOW NOWAIT 
m.temp=TmpDir+[\mvk1]

SELECT 0

 m.main=m.shlyx+'\data\main' 

SELECT nest1,nest2,nest3,name1,name2,name3,domadr ;
	FROM (m.main) INTO TABL (m.temp) WHERE potstan ;
	AND domadr='вул' ;
	ORDER BY name1,name2,name3
USE IN main

SELECT 0
m.nest1=m.shlyx+'\Dov\nest1'
USE (m.nest1) noup 
n1=TmpDir+'\n1'
INDEX ON nest1 TO (m.n1) COMPACT
SELECT 0
m.nest2=m.shlyx+'\Dov\nest2'
USE (m.nest2) NOUP
n2=TmpDir+'\n2'
INDEX ON nest1+nest2 TO (m.n2) COMPACT
SELECT 0
m.nest3=m.shlyx+'\Dov\nest3'
USE (m.nest3) NOUP
n3=TmpDir+'\n3'
INDEX ON nest2+nest3 TO (m.n3) COMPACT
SELECT mvk1


USE IN Nest1
USE IN Nest2
USE IN Nest3

GO TOP

*BROWSE NOEDIT NOAP NODE

oWord=CREATEOBJECT('Word.Application')
oWordDoc=oWord.Documents.Add

wdOrientPortrait=0
wdPrinterDefaultBin=2
wdSectionNewPage=0
wdAlignVerticalTop=0
False=.f.
True=.t.

WITH oWordDoc.PageSetup
       	.LineNumbering.Active = False
        .Orientation = wdOrientPortrait
       	.TopMargin = CmToPnt(2)
        .BottomMargin = CmToPnt(2)
       	.LeftMargin = CmToPnt(2.5)
        .RightMargin = CmToPnt(1)
       	.Gutter = CmToPnt(0)
        .HeaderDistance = CmToPnt(1)
       	.FooterDistance = CmToPnt(0)
        .PageWidth = CmToPnt(21)
       	.PageHeight = CmToPnt(29.7)
        .FirstPageTray = wdPrinterDefaultBin
       	.OtherPagesTray = wdPrinterDefaultBin
		.SectionStart = wdSectionNewPage
		.OddAndEvenPagesHeaderFooter = False
		.DifferentFirstPageHeaderFooter = False
		.VerticalAlignment = wdAlignVerticalTop
		.SuppressEndnotes = False
		.MirrorMargins = False
ENDWITH

WITH oWordDoc
		.Content.Font.Name="Times New Roman"
		.Content.Font.Bold=False
		.Content.Font.Size=12
		.Content.Font.Spacing = 0
ENDWITH
Twidth=80

WITH oWordDoc

	m.firma='Івано-Франківський національний технічний університет нафти і газу'
	m.firmkod='Код ЄДРПОУ '
	m.listnazva='Список працівників, які проживають у м.Івано-Франківську'
	m.listkepka=[Пор.№_Прізвище,ім'я,по батькові_Адреса_Ідентифікаційний код]
	.Content.InsertParagraphAfter
	.Content.InsertAfter(m.firma)
	.Content.InsertParagraphAfter
	.Content.InsertAfter(m.firmkod)
	.Content.InsertParagraphAfter
	.Content.InsertParagraphAfter
	.Content.InsertAfter(m.listnazva)
	.Content.InsertParagraphAfter
	.Content.InsertParagraphAfter
	.Content.InsertAfter(m.listkepka)
	.Content.InsertParagraphAfter
	i=1
	SCAN
		SCATTER MEMVAR MEMO
		m.porno=ALLTRIM(STR(i))
		m.prizib=ALLTRIM(m.name1)+' '+ALLTRIM(m.name2)+' '+ALLTRIM(m.name3)
		.Content.InsertAfter(m.porno+'_')
		.Content.InsertAfter(m.prizib+'_')
		.Content.InsertAfter(m.domadr+'_'+' ')
		.Content.InsertParagraphAfter
		i=i+1
	ENDSCAN

ENDWITH

USE IN mvk1

oWord.Selection.Sections(1).Headers(1).PageNumbers.Add(2,1)

WAIT CLEAR

oWord.Visible=.t.
