LOCAL temp
WAIT [Зачекайте...] WINDOW NOWAIT 
m.temp=TmpDir+[\women1]
 m.main=m.shlyx+'\data\main' 

SELECT 0
SELECT DIST nest1,nest2,nest3,sprava,name1,name2,name3,pos, ;
	SPACE(30) AS posada	FROM (m.main) INTO TABL (m.temp) ;
	WHERE potstan AND sex='ж';
	ORDER BY name1,name2,name3
USE IN main

SELECT 0
m.posad=m.shlyx+'\dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT women1
SCAN
	SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
	SELECT Posad
	IF SEEK(m.n1p)
		m.posada=posada
		REPLACE women1.posada WITH m.posada
	ENDIF
ENDSCAN

USE IN Posad

GO TOP

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
		.Content.Font.Name="Courier New"
		.Content.Font.Bold=False
		.Content.Font.Size=12
		.Content.Font.Spacing = 0
ENDWITH
Twidth=60

WITH oWordDoc
i=1
SCAN
	m.PosPib=STR(i,4)+'.'+ALLTRIM(name1)+' '+ALLTRIM(name2)+' '+ ;
		ALLTRIM(name3)+', '+ALLTRIM(Posada)+' '+ALLTRIM(nest3)
	.Content.InsertAfter(m.PosPib)
	.Content.InsertParagraphAfter
	i=i+1
ENDSCAN 
ENDWITH

USE

oWord.Selection.Sections(1).Headers(1).PageNumbers.Add(2,1)

WAIT CLEAR

oWord.Visible=.t.
