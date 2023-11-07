LOCAL temp
WAIT [Зачекайте...] WINDOW NOWAIT 
m.temp=TmpDir+[\vop1]

SELECT 0
 m.main=m.shlyx+'\data\main' 

SELECT DIST nest1,nest2,nest3,sprava,name1,name2,name3,pos, ;
	SPACE(30) AS posada, 00 AS stagpos, 000 AS RangPos, ;
	SPACE(80) AS Povn1, SPACE(80) AS Povn2, SPACE(80) AS Povn3 ; 
	FROM (m.main) INTO TABL (m.temp) WHERE potstan ;
	ORDER BY nest1,nest2,nest3,name1,name2,name3
USE IN main

SELECT 0
m.posad=m.shlyx+'\dov\posad'
USE (m.posad) NOUP
INDEX ON nest1+STR(pos,3) TO (m.temp) COMPACT
SELECT 0
m.nest1=m.shlyx+'\dov\nest1'
USE (m.nest1) NOUP
n1=TmpDir+'\n1'
INDEX ON nest1 TO (m.n1) COMPACT
SELECT 0
m.nest2=m.shlyx+'\dov\nest2'
USE (m.nest2) NOUP
n2=TmpDir+'\n2'
INDEX ON nest1+nest2 TO (m.n2) COMPACT
SELECT 0
m.nest3=m.shlyx+'\dov\nest3'
USE (m.nest3) NOUP
n3=TmpDir+'\n3'
INDEX ON nest2+nest3 TO (m.n3) COMPACT
SELECT vop1

SCAN
	SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
	SELECT Posad
	IF SEEK(m.n1p)
		m.posada=posada
		m.rang=rang
		REPLACE vop1.posada WITH m.posada
		REPLACE vop1.RangPos WITH m.Rang
	ENDIF
	SELECT nest1
	IF SEEK(m.nest1)
		m.povn1=povnest1
		REPLACE vop1.povn1 WITH m.povn1
	ENDIF
	SELECT nest2
	IF SEEK(m.nest1+m.nest2)
		m.povn2=povnest2
		REPLACE vop1.povn2 WITH m.povn2
	ELSE
		REPLACE vop1.povn2 WITH m.nest2
	ENDIF
	SELECT nest3
	IF SEEK(m.nest2+m.nest3)
		m.povn3=povnest3
		REPLACE vop1.povn3 WITH m.povn3
	ELSE
		REPLACE vop1.povn3 WITH m.nest3
	ENDIF
ENDSCAN

USE IN Posad
USE IN Nest1
USE IN Nest2
USE IN Nest3

GO TOP

SELECT 0
m.tpp=TmpDir+'\tpp.dbf'
m.prizperm=m.shlyx+'\data\prizperm.dbf'
COPY FILE (m.prizperm) TO (m.tpp)
USE (tpp) 
REPLACE pos WITH 'зав.кафедри' FOR pos='зав.каф'
REPLACE pos WITH 'зав.лабораторії' FOR pos='зав.лаб'
*REPLACE pos WITH '' FOR posada='зав.лаб'
*REPLACE pos WITH 'зав.лабораторії' FOR posada='зав.лаб'

INDEX ON sprava+DTOS(Dvstup) TO (m.temp) COMPACT

SELECT vop1
SCAN
	m.cSprava=sprava
	m.cPosada=posada
	SELECT Tpp
	st=0
	COUNT FOR sprava==cSprava AND pos=m.cPosada TO kd
	IF kd>0
		SCAN FOR sprava==cSprava AND pos=m.cPosada
			st=st+(IIF(EMPTY(dzviln),DATE(),dzviln)-dvstup)
		ENDSCAN
	ENDIF
	SELECT vop1
	REPLACE stagpos WITH IIF(kd>0,INT(st/365.25),-1)
ENDSCAN

USE IN Tpp
*BROWSE NOEDIT NOAP NODE
USE IN vop1

SELECT nest1,povn1,povn2,povn3,name1,name2,name3,posada,stagpos,rangpos ;
		FROM (m.temp) INTO TABLE (m.tpp) ;
		WHERE 'зав.каф'$posada OR 'нач'$posada ;
			OR 'рект'$posada OR 'інженер'$posada ;
			OR ('технік'$posada AND NOT 'сантех'$posada) ;
			OR 'фахівець'$posada ;
			OR 'зав.бюро'$posada OR 'зав.лаб'$posada;
			OR 'доцент'$posada OR 'професор'$posada ;
			OR 'бухг'$posada OR 'касир'$posada ;
		ORDER BY nest1,povn1,povn2,povn3, ;
		rangpos,name1,name2,name3

USE IN vop1
SELECT Tpp
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

DO WHILE NOT EOF()
	m.povn1=povn1
	.Content.InsertParagraphAfter
	.Content.InsertAfter(m.povn1)
	.Content.InsertParagraphAfter
	DO WHILE povn1=m.povn1
		m.povn2=povn2
		.Content.InsertAfter('  '+m.povn2)
		.Content.InsertParagraphAfter
		DO WHILE povn2=m.povn2
			m.povn3=povn3
			.Content.InsertAfter('    '+m.povn3)
			.Content.InsertParagraphAfter
			SCAN WHILE povn3=m.povn3
				m.PosPib=ALLTRIM(Posada)+' '+ ;
					ALLTRIM(name1)+' '+ALLTRIM(name2)+' '+ ;
					ALLTRIM(name3)
				m.PosPib=m.PosPib+IIF(stagpos>=0, ;
					' - стаж на посаді '+ALLTRIM(STR(stagpos))+' р.', ;
					' - НЕМАЄ ДАНИХ про стаж ')
				.Content.InsertAfter(m.PosPib)
				.Content.InsertParagraphAfter
			ENDSCAN 
		ENDDO 
		.Content.InsertParagraphAfter
	ENDDO
	.Content.InsertParagraphAfter
ENDDO
ENDWITH

USE IN Tpp

oWord.Selection.Sections(1).Headers(1).PageNumbers.Add(2,1)

WAIT CLEAR

oWord.Visible=.t.
