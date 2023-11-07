****************************************************************************
******************Довідка про особовий склад сумісників підрозділу*********************
****************************************************************************
PUBLIC posadad
rposd=0
 WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
 pos1=SPACE(30)
*set
select 0 	
true=.t.
false=.f.
wdCell=12
 stform=Tmpdir+'\stform'
 state=Tmpdir+'\state'
 store 0 to zaw,prof,doz,stwk,wk,ast
m.main=m.shlyx+'\data\main'
 select space(100) as nazkaf,nest1,nest2,nest3,00 as n,alltrim(name1) as priz, ;
        alltrim(name2) as imy,alltrim(name3) as bat, ;
        name1,name2,name3, ;
        sprava,pos,space(30) as posada,000 as rng,0000 as rpos, ;
        vzvan,vstup,0000 as npwg,0000 as npwm, ;
        datanar,day(datanar) as dr, ;	
        mont(datanar) as mr,year(datanar) as rr,sex,space(80) as zakl,SPACE(40) as mzakl, ;
        0000 as rz,stod,space(40) as orgn, ;
        space(40) as ador,nomkontr,DTOC(datkontr) AS datkontr,DTOC(tzakkontr) AS tzakkontr, ;
	ROUND((tzakkontr-datkontr)/365.25,1) AS TermKon, ;
	space(30) as pidstava,space(30) as po, .F. AS obrobl ;
        from (m.main) into table (stform) where potstan.and.nest1='04' order by nest2,nest3 
*browse
 
m.prizperm=m.shlyx+'\data\prizperm'
SELECT * from (m.prizperm) INTO TABLE prizp.dbf ORDER BY sprava,dvstup DESC 
*brow
 use in prizp    
 use in stform
 use in main
 USE IN prizperm  
 select 0 &&Було 4 
m.posad=m.shlyx+'\dov\posad.dbf'
 COPY FILE (m.posad) TO posadstf.dbf
 use posadstf noup
 inposad=TmpDir+[\inposad]
 index on nest1+str(pos,3) to (inposad) comp for nest1='04'
 select 0 &&Було 1 
m.osvita=m.shlyx+'\data\osvita' 
use (m.osvita) noup
 inosvita=TmpDir+[\inosvita]
 index on sprava to (inosvita) comp
 select 0 &&Було 2 
 m.trudova=m.shlyx+'\data\trudova.dbf'
 COPY FILE (m.trudova) TO trudovastf.dbf
use trudovastf noup
 intrud=TmpDir+[\intrud]
 index on sprava+dtos(dvstup) to (intrud) comp
 select 0 &&Було 3
m.prizperm=m.shlyx+'\data\prizperm.dbf' 
COPY FILE (m.prizperm) TO prizpermstf.dbf
use prizpermstf noup
 inperem=TmpDir+[\inperem]
 index on sprava+dtos(dvstup) to (inperem) comp
 select 0 &&Було 6
m.nest3=m.shlyx+'\dov\nest3' 
use (m.nest3) noup
 innest3=TmpDir+[\innest3]
 index on nest2+nest3 to (innest3) comp
 select 0 &&Було 7
 use prizp noup
 select 0
 use (stform)
 instform=TmpDir+[\instform]
 index on nest1+nest2+nest3 to (instform) comp
* browse fields nest3,priz,posada,pos,rng,stod
  kaf=nest3
 scan
 posd=IIF(ISBLANK(pos),-999,pos)
 spravad=sprava
 m.npstagvnz=0
 DO forstag WITH spravad

 stagug=INT(m.npstagvnz/365.25) && цілі роки науково-педаг. стажу в вузі
 stagum=INT((m.npstagvnz-stagug*365.25)/ROUND(365.25/12,4)) && залишкові місяці в вузі
 stagug=stagug+IIF(stagum=12,1,0) && уточнені роки в вузі
 stagum=IIF(stagum=12,0,stagum) && уточнені місяці в вузі
 
select stform
	 replace stform.npwg with stagug,stform.npwm with stagum
if vstup=space(10)
   replace stform.vstup with 'не має'
endif  
       
  select posadstf &&posad було 4
 locate for pos=posd
 if found()
   posadad=posada
   rangd=rang 
  replace stform.posada with posadad ,stform.rng with rangd
*? 'posada=',stform.posada at 9
  endif
 select osvita && osvita було 1
 go top
 locate for sprava=spravad
 if found()
    zakld=zaklosv
    mzakld=mzaklosv 
    rzd=rzak
    replace stform.zakl with zakld,stform.mzakl with mzakld,stform.rz with rzd
 endif

 select prizp &&було 7
 set filter to sprava=spravad  
*BROWSE FOR sprava='360-1'
COUNT TO kz FOR sprava=spravad
   
  SCAN FOR ALLTRIM(sprava)=ALLTRIM(spravad)
    posadad=pos
    rposd=year(dvstup)
*    pidstavd=pidvstup  
  IF kz=1
     EXIT
  ELSE
     scan WHILE ALLTRIM(pos)=ALLTRIM(posadad)
        rk1=year(dvstup)
        pidst1=pidvstup
     ENDSCAN
     rposd=rk1
     pidstavd=pidst1
     
 EXIT
 ENDIF
*sprava=spravad
ENDSCAN 

*IF spravad='179-1'
*   WAIT STR(rposd)+  +spravad window
*   WAIT CLEAR
*ENDIF    
replace stform.rpos with rposd FOR stform.sprava=spravad 
 ord=SPACE(25)

select prizpermstf && prizperm було 3
 set filter to sprava=spravad
 go bottom
pidstavd=pidvstup
IF !EMPTY(dzviln)
pidstavd1=DTOC(dzviln)
ELSE 
pidstavd1=SPACE(30)
endif
 replace stform.pidstava WITH pidstavd,stform.po WITH pidstavd1
 
 select trudovastf && було 2
 ord=SPACE(40)
 adord=SPACE(40)
 set filter to sprava=spravad
 go bottom
 ord=org
 adord=adrorg
* if ord=space(25)
*    ord='Після ВУЗу'
* endif
 replace stform.orgn with ord,stform.ador with adord
 
 endscan

SELECT stform
istform=TmpDir+[\istform]
index on nest1+nest2+nest3+str(rng)+priz to (istform) comp 
do while !eof()
kaf=nest3
np=0
scan while nest3=kaf
np=np+1
if empty(nomkontr)
   j=at('від',pidstava)
   nnakaz=substr(pidstava,2,j-2)
   dnakaz=substr(pidstava,j+4)
   replace stform.nomkontr with nnakaz,datkontr with dnakaz 
endif   
replace stform.n with np
SELECT nest3 && було 6
    locate for nest3=kaf
    if found()
    nkafd=left(povnest3,100) 
    endif
   replace stform.nazkaf WITH nkafd
endscan  
enddo
*SELE stform
*brow
*GO TOP
*browse fields nest3,priz,posada,pos,rng,nomkontr,datkontr
 WAIT [Зачекайте... Іде формування довідки] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2

oWord=CreateObject('Word.Application')
oWord.VISIBLE=.T.

SELE stform
GO top
*SCAN
DO WHILE !EOF()
IF alltrim(m.shlyx)=='.' 
m.foss=FULLPATH('')+'dov\ossklad04.doc'
else
m.foss=m.shlyx+'\dov\ossklad04.doc'
endif

oWordDoc1=oWord.Documents.Add(m.foss)
*SCATTER MEMVAR
    m.nkaf=nazkaf
*    m.data_na='01.01.'+STR(YEAR(date()),4)
    m.data_na=DTOC(date())
   	m.nest3=nest3
   	oWord.SELECTION.FIND.ClearFormatting
	WITH oWord.SELECTION.FIND
                .Replacement.ClearFormatting
		.TEXT = "$$dat"
		.Replacement.TEXT = m.data_na
		.Forward = true
		.FORMAT = false
		.MatchCase = false
		.MatchWholeWord = false
		.MatchWildcards = false
		.MatchSoundsLike = false
		.MatchAllWordForms = false
	ENDWITH
	oWord.SELECTION.FIND.Execute(,,,,,,,,,,2)

	oWord.SELECTION.FIND.ClearFormatting
	WITH oWord.SELECTION.FIND
                .Replacement.ClearFormatting
		.TEXT = "$$kaf"
		.Replacement.TEXT = alltrim(m.nkaf)
		.Forward = true
		.FORMAT = false
		.MatchCase = false
		.MatchWholeWord = false
		.MatchWildcards = false
		.MatchSoundsLike = false
		.MatchAllWordForms = false
	ENDWITH
	oWord.SELECTION.FIND.Execute(,,,,,,,,,,2)


*rjd=17
*select stform
*rjd=0
scan while nest3=m.nest3
	oWord.SELECTION.FIND.ClearFormatting
	WITH oWord.SELECTION.FIND
        .Replacement.ClearFormatting
		.TEXT = "$$pr"
		.Replacement.TEXT = str(n,2)
		.Forward = true
		.FORMAT = false
		.MatchCase = false
		.MatchWholeWord = false
		.MatchWildcards = false
		.MatchSoundsLike = false
		.MatchAllWordForms = false
	ENDWITH
	oWord.SELECTION.FIND.Execute
*	m.dis=STRTRAN(dis,["],[])
	m.zakl=STRTRAN(STRTRAN(zakl,["],[]),[*],[])
	m.mzakl=STRTRAN(mzakl,["],[])
	m.orgn=STRTRAN(orgn,["],[])
	m.ador=STRTRAN(ador,["],[])
	m.kontrakt='№ '+nomkontr+ ;
			IIF(EMPTY(nomkontr),'    ',datkontr)+ ;
			IIF(TermKon=0 and !EMPTY(po),' по '+po,' ')+ ;
	        IIF(TermKon>0,' по '+tzakkontr,' ')
	*		IIF(TermKon>0,' по '+tzakkontr+' на '+ ;
				IIF(INT(TermKon)=TermKon, ;
						STR(TermKon,2,0),STR(TermKon,4,1))+' р.','')
	WITH oWord.Selection
		.TypeText(str(n,2))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(priz)+' '+chr(10)+ALLTRIM(imy)+' '+chr(10)+ALLTRIM(bat))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(posada))
		.MoveRight(wdCell)
		.TypeText(STR(rpos,4))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(vzvan))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(vstup))
		.MoveRight(wdCell)
		.TypeText(STR(npwg,2)+'р. '+STR(npwm,2)+'м.')
		.MoveRight(wdCell)
		.TypeText(DTOC(datanar))
		.MoveRight(wdCell)
		.TypeText(sex)
		.MoveRight(wdCell)
 		.TypeText(m.zakl+chr(10)+m.mzakl+chr(10)+STR(rz,4))
		.MoveRight(wdCell)
 		.TypeText(STR(stod,4,2))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(m.orgn)+' '+ALLTRIM(m.ador))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(m.kontrakt))
		.MoveRight(wdCell)
	ENDWITH	
endscan

IF alltrim(m.shlyx)=='.' 
m.f1=FULLPATH('')+'form\'+DTOS(DATE())+'_ossklad04_'+ALLTRIM(m.nest3)+'.doc'
else
m.f1=m.shlyx+'\form\'+DTOS(DATE())+'_ossklad04_'+ALLTRIM(m.nest3)+'.doc'
endif
*=MESSAGEBOX(m.f1)

oWordDoc1.SaveAs(m.f1)

*oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_ossklad_'+ALLTRIM(m.nest3)+'.doc')
oWordDoc1.Close
ENDdo
uSE IN nest3
USE IN prizp
use in posadstf
use in osvita
use in prizpermstf
use in stform
USE IN trudovastf

ERASE prizp.dbf
ERASE posadstf.dbf
ERASE trudovastf.dbf
ERASE prizpermstf.dbf
WAIT CLEAR
=MESSAGEBOX([       Довідка сформована]+CHR(13)+ ;
			[Для її перегляду перейдіть у Word],64,[V K A D R - Інфо])

