 WAIT [���������... ��� ��������� �����] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
* TmpDir=SYS(2023)
 select 0 	
 stform=Tmpdir+'\stform'
 state=Tmpdir+'\state'

 m.nest2=m.shlyx+'\dov\nest2'
 m.nest3=m.shlyx+'\dov\nest3'
 select nest2.nest1,nest2.nest2,nest3.nest3,;
        nest2.povnest2,nest3.povnest3 ;
        from (m.nest2),(m.nest3);
        into table (state);
        where nest2.nest2=nest3.nest2.AND.(nest2.nest1='01'.OR.nest2.nest1='00').AND.(nest3.nest1='01'.OR.nest3.nest1='00');
        .AND.nest2.nest2#[�� ] ;
        order by nest2.nest1,nest2.nest2,nest3
 
* BROWSE NOED NOAP NODE
 use in nest2
 use in nest3
SELECT state 
oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add
oWordDoc1.Content.InsertAfter(padc('����',100))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
GO TOP
ik=0
DO WHILE NOT EOF()
SCATTER MEMVAR
oWordDoc1.Content.InsertAfter(STRTRAN(left(m.povnest2,100),[  ],[..]))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
SCAN WHILE nest2=m.nest2
SCATTER MEMVAR
oWordDoc1.Content.InsertAfter(IIF(ik>0,[ ]+STR(ik,2)+[. ],[])+STRTRAN(left(m.povnest3,95),[  ],[..]))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
ik=ik+1
ENDSCAN
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
ENDDO
USE IN state
radok='������ ��� ��� �������� � ������ ����� ���������� �� ��������,����������� �������'
radok=radok+REPL('.',100-LEN(radok))
oWordDoc1.Content.InsertAfter(radok)
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
radok='������ ��� ��� �������� � ������ ����� ������ � ���.��������� �������'
radok=radok+REPL('.',100-LEN(radok))
oWordDoc1.Content.InsertAfter(radok)
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
radok=[�]+LOWER('�Ͳ ��� ������������-������������ ����� ')+'�������'
radok=radok+REPL('.',100-LEN(radok))
oWordDoc1.Content.InsertAfter(radok)
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����

WITH oWord
    .Selection.WholeStory
    WITH .Selection.Font
        .Name = "Courier New"
        .Size = 10
        .Bold = False
        .Italic = False
		.Underline = False
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
        .Spacing = 0
        .Scaling = 80
        .Position = 0
        .Kerning = 0
    ENDWITH
	.Selection.HomeKey(6)
ENDWITH
With oWordDoc1.PageSetup
    .LineNumbering.Active = False
    .Orientation = wdOrientLandscape
    .TopMargin = CmToPnt(1)
    .BottomMargin = CmToPnt(1)
    .LeftMargin = CmToPnt(5.5)
    .RightMargin = CmToPnt(1)
    .Gutter = CmToPnt(0)
    .HeaderDistance = CmToPnt(0.5)
    .FooterDistance = CmToPnt(0)
    .PageWidth = CmToPnt(29.7)
    .PageHeight = CmToPnt(21)
    .FirstPageTray = wdPrinterDefaultBin
    .OtherPagesTray = wdPrinterDefaultBin
    .SectionStart = wdSectionNewPage
    .OddAndEvenPagesHeaderFooter = False
    .DifferentFirstPageHeaderFooter = False
    .VerticalAlignment = wdAlignVerticalTop
    .SuppressEndnotes = True
    .MirrorMargins = False
EndWith

oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_zmstform.doc')

oWord.Visible=.t.
WAIT CLEAR
=MESSAGEBOX([         ���� �����������]+CHR(13)+ ;
			[��� ���� ��������� �������� � Word],64,[V K A D R - ����])

