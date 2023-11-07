true=.t.
false=.f.
wdCell=12
*dnest1=ThisForm.Txtnest1.Value

LOCAL temp,tpp
WAIT [Зачекайте...] WINDOW NOWAIT 
m.temp=TmpDir+[\pedst]
*potdat=Thisform.txtPredDate.Value

m.main=m.shlyx+'\data\main' 
m.posad=m.shlyx+'\dov\posad'
m.nest3=m.shlyx+'\dov\nest3'
       SELECT * FROM (m.posad) INTO TABLE posad1
       USE
       USE IN posad
       select  sprava,name1, name2,name3,nest1,nest2,nest3,SPACE(100) as povn3,pos,peddovr,peddovm, ;
       		SPACE(20) as posada,00 as rstag, 00 as mstag ;
            from (m.main) ;
            where potstan into table pedst;
            order by nest3,name1,name2,name3
USE IN main
USE 
SELECT 0 && було 1
USE posad1 NOUP
INDEX ON nest1+STR(pos,3) TO iposad COMPACT
SELECT 0 && було 2
 m.nest3=m.shlyx+'\dov\nest3'
USE (m.nest3) NOUP
n3=TmpDir+'\n3'
INDEX ON nest2+nest3 TO (n3) COMPACT
SELECT 0 && було 3
USE pedst
irec=0
nrec=RECCOUNT()
SCAN
  posd=pos
  nestd=nest1
  SCATTER MEMVAR
	m.n1p=m.nest1+STR(m.pos,3)
 posadad=SPACE(20)
 SELECT posad1
  IF SEEK (m.n1p)
    posadad=posada
 ENDIF
 
 SELECT pedst
     REPLACE posada WITH posadad   
 
  SELECT nest3
  IF SEEK(m.nest2+m.nest3)
	 m.povn3=LEFT(povnest3,100)
  ENDIF

  SELECT pedst
  REPLACE povn3 WITH m.povn3  

 
*brow
*SET &&в якій області відкриті бази

  m.pedstag=0
  DO forstag WITH sprava &&forstag ф-ія по нарах.пед стажу


*SET 

*  =MESSAGEBOX(STR(stp))
  stpr=int(m.pedstag/365.25)
  stpm=int((m.pedstag-stpr*365.25)/ROUND(365.25/12,4))
    IF stpm=12
     stpr=stpr+1
     stpm=0
    ENDIF   
  SELECT pedst
  
	m.stpr=m.stpr+peddovr && роки з пед.стажем за довідками
	m.stpm=m.stpm+peddovm && місяці з пед.стажем за довідками
	m.stpr=m.stpr+IIF(m.stpm>=12,1,0) && уточнені роки
	m.stpm=m.stpm-IIF(m.stpm<12,0,12) && уточнені місяці
*brow
  REPLACE rstag WITH stpr, mstag WITH stpm
	irec=irec+1
  WAIT 'Оброблено запис '+ALLTRIM(STR(irec))+' з '+ALLTRIM(STR(nrec)) WINDOW NOWAIT
ENDSCAN

SELECT * from pedst INTO TABLE pedst1 WHERE rstag>0 OR mstag>0 order by nest3,name1,name2,name3
USE IN pedst
USE IN nest3
USE IN posad1
SELECT pedst1
*REPLACE FOR EMPTY(nest3) nest3 WITH n3
ON ERROR =oWordNotCreated()        	      
oWord=CREATEOBJECT("Word.Application")
oWord.Visible=.T.
ON ERROR

IF alltrim(m.shlyx)=='.' 
	m.zag=FULLPATH('')+'\dov\zagpedst.doc'
else
	m.zag=m.shlyx+'\dov\zagpedst.doc'
endif

oWordDC_Z=oWord.Documents.Add(m.zag)

SELECT pedst1
INDEX ON nest3+name1+name2+name3 TO iiiiii COMP

GO TOP
DO WHILE !EOF() 
IF alltrim(m.shlyx)=='.' 
m.pedstag=FULLPATH('')+'\dov\pedstag.doc'
ELSE
m.pedstag=m.shlyx+'\dov\pedstag.doc'
ENDIF

 oWordDC=oWord.Documents.Add(m.pedstag)
 SCATTER MEMVAR
 WITH oWordDC
    	oWord.SELECTION.FIND.ClearFormatting
	oWord.SELECTION.FIND.ClearFormatting
	WITH oWord.SELECTION.FIND
        .Replacement.ClearFormatting
		.TEXT = "$$kaf"
		.Replacement.TEXT = ALLTRIM(m.povn3)
		.Forward = true
		.FORMAT = false
		.MatchCase = false
		.MatchWholeWord = false
		.MatchWildcards = false
		.MatchSoundsLike = false
		.MatchAllWordForms = false
	ENDWITH
	oWord.SELECTION.FIND.Execute(,,,,,,,,,,2)
  ENDWITH

    oWord.SELECTION.FIND.ClearFormatting
	WITH oWord.SELECTION.FIND
        .Replacement.ClearFormatting
		.TEXT = "$$name"
		.Forward = true
		.FORMAT = false
		.MatchCase = false
		.MatchWholeWord = false
		.MatchWildcards = false
		.MatchSoundsLike = false
		.MatchAllWordForms = false
	ENDWITH
	oWord.SELECTION.FIND.Execute
   	
    DO WHILE nest3==m.nest3
        	pr=name1
	    im=name2
    	pobat=name3
	    dname=ALLTRIM(name1)+' '+ALLTRIM(name2)+' '+ALLTRIM(name3)
	    SCAN while name1=pr AND name2=im AND name3=pobat 
			WITH oWord.SELECTION
			.TypeText(dname)
			.MoveRight(wdCell)
			.TypeText(ALLTRIM(posada))
			.MoveRight(wdCell)
			.TypeText(STR(rstag,2)+'р. '+STR(mstag,2)+'м.')
			.MoveRight(wdCell)
	    	ENDWITH
	    ENDSCAN
 
 *CANCEL
*   Друкування пустого рядка 
*	WITH oWord.SELECTION
*		.MoveRight(wdCell)
*		.MoveRight(wdCell)
*		.MoveRight(wdCell)
*	ENDWITH
       ENDDO
    oWord.Selection.WholeStory
    oWord.Selection.Copy
    oWord.Windows("Документ1").Activate
    oWord.Selection.EndKey(6)
    oWord.Selection.Paste
	oWordDC.SaveAs(FULLPATH('')+"temp.doc")
	oWordDC.close

ENDDO

oWord.Selection.HomeKey(6)
WITH oWord.SELECTION.FIND
     .Replacement.ClearFormatting
	.TEXT = "$$DAT"
	.Replacement.TEXT = DTOC(DATE())
	.Forward = true
	.FORMAT = false
	.MatchCase = false
	.MatchWholeWord = false
	.MatchWildcards = false
	.MatchSoundsLike = false
	.MatchAllWordForms = false
ENDWITH
oWord.SELECTION.FIND.Execute(,,,,,,,,,,2)
oWord.Selection.Sections(1).Headers(1).PageNumbers.Add(2,true)
m.outfile=FULLPATH('')+"form\"+DTOS(DATE())+"_pedstag.doc"
oWordDC_Z.SaveAs(m.outfile)

oWordDC_Z.Close
oWord.quit

USE IN pedst1

ERASE pedst.dbf
ERASE pedst1.dbf
ERASE posad1.dbf
ERASE iposad.idx
ERASE iiiiii.idx
ERASE temp.doc

WAIT CLEAR
=MESSAGEBOX("Кінець розрахунків."+CHR(10)+ ;
			"Відомості про педагогічний стаж записані в файлі "+CHR(10)+ ;
			m.outfile,64,"")

FUNCTION oWordNotCreated
	=MessageBox{"На Вашому комп'ютері не встановлено WORD"} 

RETURN
