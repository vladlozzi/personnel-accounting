ERASE form\ctvukbezct.doc
m.main='data\main'
m.nest3='dov\nest3'
m.ctvukbezct=TmpDir+"\ctvukbezct.dbf"
select alltrim(main.name1)+' '+alltrim(main.name2)+' '+alltrim(main.name3)+' - '+LEFT(nest3.povnest3,80);
       from(m.main),(m.nest3) INTO TABLE (m.ctvukbezct);
       where potstan.and.(main.nest1='01' OR (main.nest1='00' AND main.nest3='ДЕК'))and;
       (EMPTY(main.vstup) and main.pos=12) AND main.nest3=nest3.nest3 AND main.nest1=nest3.nest1;          
       order by main.nest3 noco 
USE IN main
USE IN nest3
SELECT ALLTRIM(STR(RECNO()))+". "+exp_1 FROM (m.ctvukbezct) TO FILE FORM\ctvukbezct.txt
COUNT TO m.TeachersCount
USE IN ctvukbezct
IF FILE('form\ctvukbezct.txt')
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
	.Content.InsertAfter("Список старших викладачів без наукового ступеня")
	.Content.InsertParagraphAfter
 	oWord.Selection.EndKey(6)
 	.Content.InsertAfter("Кількість осіб у списку - "+ALLTRIM(STR(m.TeachersCount)))
	.Content.InsertParagraphAfter
	ENDWITH
	WITH oWord
	.Selection.EndKey(6)
	.Selection.InsertFile(FULLPATH('')+'form\ctvukbezct.txt')
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
	.ActiveDocument.SaveAs(FULLPATH('')+'form\ctvukbezct.doc')
	.Quit
	ENDWITH

	ERASE form\ctvukbezct.txt
	ERASE (m.ctvukbezct)

	=MESSAGEBOX('Список збережено у файлі form\ctvukbezct.doc')
ELSE
	=MESSAGEBOX('Список за цим критерієм пустий, тому файл не сформовано')
ENDIF