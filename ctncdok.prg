*m.main='data\main'
*select alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3);
       from(m.main) to file form\ctncdok.txt where potstan.and.(nest1='01' OR (nest1='00' AND nest3='ДЕК'))and;
       (LEFT(vstup,1)='д' and vzvan='ст.н.с.');          
       order by name1,name2,name3 noco 
*USE IN main
*=messagebox('Форма міститься в form\ctncdok.txt ')
ERASE form\ctncdok.doc
m.ctncdok=TmpDir+"\ctncdok.dbf"
m.main='data\main'
m.nest3='dov\nest3'
select alltrim(main.name1)+' '+alltrim(main.name2)+' '+alltrim(main.name3)+' - '+LEFT(nest3.povnest3,80);
       from(m.main),(m.nest3) INTO TABLE (m.ctncdok);
       where potstan.and.(main.nest1='01' OR (main.nest1='00' AND main.nest3='ДЕК'))and;
       ( main.vstup='д' and main.vzvan='ст.н.с.') AND main.nest3=nest3.nest3 AND main.nest1=nest3.nest1;          
       order by main.nest3 noco 
USE IN main
USE IN nest3
SELECT ALLTRIM(STR(RECNO()))+". "+exp_1 FROM (m.ctncdok) TO FILE FORM\ctncdok.txt
COUNT TO m.TeachersCount
USE IN m.ctncdok
IF FILE('form\ctncdok.txt')
oWord=CREATEOBJECT('Word.Application')
oWord.Visible=.t.
oWordDoc=oWord.Documents.Add

wdOrientPortrait=0
wdPrinterDefaultBin=2
wdSectionNewPage=0
wdAlignVerticalTop=0
False=.f.
True=.t.
wdReplaceAll=2

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
	.Content.InsertAfter("Список старших наукових співробітників, докторів наук")
	.Content.InsertParagraphAfter
 	oWord.Selection.EndKey(6)
 	.Content.InsertAfter("Кількість осіб у списку - "+ALLTRIM(STR(m.TeachersCount)))
	.Content.InsertParagraphAfter
	ENDWITH
	WITH oWord
	.Selection.EndKey(6)
	.Selection.InsertFile(FULLPATH('')+'form\ctncdok.txt')
	WITH .Selection.Find
	.ClearFormatting
  	.Text = [EXP_1]
    .Replacement.Text = []
	.Forward = False
	.Execute(,,,,,,,,,,wdReplaceAll,,,,)
    ENDWITH
	WITH .Selection.Find
	.ClearFormatting
  	.Text = [^p^p]
    .Replacement.Text = []
	.Forward = False
	.Execute(,,,,,,,,,,wdReplaceAll,,,,)
    ENDWITH
	.ActiveDocument.SaveAs(FULLPATH('')+'form\ctncdok.doc')
	.Quit
	ENDWITH

	ERASE (m.ctncdok)
	ERASE form\ctncdok.txt
	=MESSAGEBOX('Список збережено у файлі form\ctncdok.doc')
ELSE

	=MESSAGEBOX('Список за цим критерієм пустий, тому файл не сформовано')

ENDIF