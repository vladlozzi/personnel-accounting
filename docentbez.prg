*m.main='data\main'
*select alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3);
       from(m.main) to file form\docentbez.txt where potstan.and.(nest1='01' OR (nest1='00' AND nest3='���'))and;
       ( EMPTY(vstup) and vzvan='������');          
       order by name1,name2,name3 noco 
*USE IN main
*=messagebox('����� �������� � form\docentbez.txt ')
ERASE form\docentbez.doc
m.main='data\main'
m.nest3='dov\nest3'
m.docentbez=TmpDir+"\docentbez.dbf"
select alltrim(main.name1)+' '+alltrim(main.name2)+' '+alltrim(main.name3)+' - '+LEFT(nest3.povnest3,80);
       from(m.main),(m.nest3) INTO TABLE (m.docentbez) ;
       where potstan.and.(main.nest1='01' OR (main.nest1='00' AND main.nest3='���'))and;
       ( EMPTY(main.vstup) and main.vzvan='������') AND main.nest3=nest3.nest3 AND main.nest1=nest3.nest1;          
       order by main.nest3 noco 
USE IN main
USE IN nest3
SELECT ALLTRIM(STR(RECNO()))+". "+exp_1 FROM (m.docentbez) TO FILE FORM\docentbez.txt
COUNT TO m.TeachersCount
USE IN docentbez
IF FILE('form\docentbez.txt')
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
	.Content.InsertAfter("������ ������� ��� ��������� �������")
	.Content.InsertParagraphAfter
 	oWord.Selection.EndKey(6)
 	.Content.InsertAfter("ʳ������ ��� � ������ - "+ALLTRIM(STR(m.TeachersCount)))
	.Content.InsertParagraphAfter
	ENDWITH
	WITH oWord
	.Selection.EndKey(6)
	.Selection.InsertFile(FULLPATH('')+'form\docentbez.txt')
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
	.ActiveDocument.SaveAs(FULLPATH('')+'form\docentbez.doc')
	.Quit
	ENDWITH

	ERASE form\docentbez.txt
	ERASE (m.docentbez)

	=MESSAGEBOX('������ ��������� � ���� form\docentbez.doc')
ELSE

	=MESSAGEBOX('������ �� ��� ������� ������, ���� ���� �� ����������')

ENDIF