***************************************************************************
**********   Довідка про особовий склад деканів       *********************
***************************************************************************

true=.t. 
False=.f.
wdCell=12
 WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
 Tmpdir=SYS(2023)				
 select 0 	
 stform=Tmpdir+'\stform'
 stformd=Tmpdir+'\stformd'
 store 0 to zaw,prof,doz,stwk,wk,ast

 m.main=m.shlyx+'\data\main'
 select nest1,nest2,nest3,00 as n,alltrim(name1) as priz,;
        alltrim(name2) as imy,alltrim(name3) as bat,;
        sprava,pos,space(30) as posada,000 as rng,0000 rpos,dis,;
        vzvan,vstup,00 as npwg,00 as npwm,00 as npzg,00 as npzm,;
        ostpkval,datanar,day(datanar) as dr,;
        mont(datanar) as mr,year(datanar) as rr,sex,space(80) as zakl,SPACE(40) as mzakl,;
        0000 as rz,pochzvan,left(inmov,3) as mov,stod,space(40) as orgn,;
        space(40) as ador,SPACE(40) as pidstava,SPACE(40) as po,SPACE(30) as doplata,;
        nomkontr,DTOC(datkontr) as datkontr,DTOC(tzakkontr) AS tzakkontr,ROUND((tzakkontr-datkontr)/365.25,1) as TermKon;
        from (m.main) into table(stformd) where potstan.and.((nest1='00'.and.nest3='ДЕК').or.nest1='01');
        order by nest2,nest3 
*         browse
USE IN main
USE IN stformd
m.prizperm=m.shlyx+'\data\prizperm'
 SELECT * from (m.prizperm) INTO TABLE prizp.dbf ORDER BY sprava,dvstup DESC 
 USE IN prizperm
 USE IN prizp
SELECT 0 && було e   
 m.doplnad=m.shlyx+'\data\doplnad'
USE (m.doplnad) 
indopl=tmpdir+[\indopl]
INDEX ON sprava TO (indopl) comp
*BROWSE FIELDS SPRAVA,PIDSTAVA

SELECT 0 && було a
USE (stformd)   
instformd=tmpdir+[\instformd]
INDEX ON sprava TO (instformd) COMPACT FOR nest1='01' 
spravad=SPACE(10)
m.dopl=SPACE(30)
m.rposad=0
m.pidstav=SPACE(40)
scan
spravad=sprava
SELECT doplnad
SCAN for sprava=spravad
IF (za_scho='за декана'.or.za_scho='за заст.декана') AND EMPTY(datzn)  
m.dopl=za_scho
m.rposad=YEAR(datnad)
m.pidstav=pidstava
 endif
ENDSCAN

SELECT stformd
replace doplata WITH m.dopl,rpos WITH m.rposad,pidstava WITH m.pidstav
spravad=SPACE(10)
m.dopl=SPACE(30)
m.rposad=0
m.pidstav=SPACE(40)

ENDSCAN
select * from stformd into table (stform);
       where doplata='за декана'.or.doplata='за заст.декана'.or.nest3='ДЕК' order by nest1,nest2,nest3
*brow 
USE IN stformd       
USE IN stform

 select 0 && було 1 
 m.osvita=m.shlyx+'\data\osvita'
 use (m.osvita) noup
 inosvita=TmpDir+[\inosvita]
 index on sprava to (inosvita) comp
 select 0 && було 2
 m.trudova=m.shlyx+'\data\trudova.dbf'
 COPY FILE (m.trudova) TO trudstf.dbf
 use trudstf noup
 intrud=TmpDir+[\intrud]
 index on sprava+dtos(dvstup) to (intrud) comp
 SELECT 0 && було 3
 m.prizperm=m.shlyx+'\data\prizperm.dbf'
 COPY FILE (m.prizperm) TO prizpstf.dbf
 use prizpstf noup
  inperem=TmpDir+[\inperem]
 index on sprava+dtos(dvstup) to (inperem) comp
 select 0 && було 7
 use prizp noup

 select 0
 use (stform)
 instform=TmpDir+[\instform]
 index on nest1+nest2+nest3 to (instform) comp

 scan
*posd=IIF(ISBLANK(pos),-999,pos)
nzap=RECNO()
 IF stform.doplata='за заст.декана' 
replace stform.posada with 'заступник  декана'
else
 replace stform.posada with 'декан'
endif 
 spravad=sprava
 
 m.npstag=0
 m.npstagvnz=0

 DO forstag WITH spravad

 stagug=INT(m.npstagvnz/365.25) && цілі роки науково-педаг. стажу в вузі
 stagum=INT((m.npstagvnz-stagug*365.25)/ROUND(365.25/12,4)) && залишкові місяці в вузі
 stagug=stagug+IIF(stagum=12,1,0) && уточнені роки в вузі
 stagum=IIF(stagum=12,0,stagum) && уточнені місяці в вузі
 
 stagzg=INT(m.npstag/365.25) && цілі роки науково-педаг. стажу 
 stagzm=INT((m.npstag-stagzg*365.25)/ROUND(365.25/12,4)) && залишкові місяці
 stagzg=stagzg+IIF(stagzm=12,1,0) && уточнені роки
 stagzm=IIF(stagzm=12,0,stagzm) && уточнені місяці

select stform
	 replace stform.npwg with stagug,stform.npwm with stagum, ;
         stform.npzg with stagzg,stform.npzm with stagzm  

if vstup=space(10)
   replace stform.vstup with 'не має'
endif  
*? 'posd=',posd at 2
 
		WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
    
  select osvita && було 1
 go top
 locate for sprava=spravad
 if found()
    zakld=zaklosv
    mzakld=mzaklosv
    rzd=rzak
    replace stform.zakl with zakld,stform.mzakl with mzakld,stform.rz with rzd
 endif

 select trudstf && було 2
 set filter to sprava=spravad
  go bottom
 ord=org
 adord=adrorg
 if ord=space(25)
    ord='Після ВУЗу'
 endif
 replace stform.orgn with ord,stform.ador with adord
 IF stform.rpos=0  &&для штатних деканів 
 
 select prizpstf && було 3
 set filter to sprava=spravad
 go bottom
pidstavd=pidvstup
IF !EMPTY(dzviln)
pidstavd1=DTOC(dzviln)
ELSE 
pidstavd1=SPACE(30)
endif
 replace stform.pidstava WITH pidstavd,stform.po WITH pidstavd1

 select prizp && було 7
 set filter to sprava=spravad  
*BROWSE FOR sprava='360-1'
COUNT TO kz FOR sprava=spravad
   
  SCAN FOR ALLTRIM(sprava)=ALLTRIM(spravad)
    posadad=pos
    rposd=year(dvstup)
    pidstavd=pidvstup  
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
ENDSCAN 

*IF spravad='179-1'
*   WAIT STR(rposd)+  +spravad window
*   WAIT CLEAR
*ENDIF    
SELECT stform
*replace stform.rpos with rposd,stform.pidstava with pidstavd FOR stform.sprava=spravad 
replace stform.rpos with rposd FOR stform.sprava=spravad
ENDIF
GO nzap
 endscan
*select 5
*browse
istform=TmpDir+[\istform]
index on nest1+nest2+nest3 to (istform) comp 

np=0
scan 
np=np+1
if stform.posada='заступник  декана' OR (stform.nest1='01' AND stform.posada='декан') OR ;
   (stform.nest1='00' AND EMPTY(stform.nomkontr))
   replace stform.TermKon WITH 0
   IF EMPTY(pidstava)
   replace stform.nomkontr WITH SPACE(10),stform.datkontr WITH SPACE(10),stform.TermKon WITH 0   
   else

    j=at('від',pidstava)
   nnakaz=substr(pidstava,2,j-2)
   dnakaz=substr(pidstava,j+4)
   
   *j=at('від ',pidstava)
   *j1=at('від  ',pidstava)
   *if j>2
	*nnakaz=substr(pidstava,2,j+1)
	*dnakaz=substr(pidstava,IIF(j1>0,j+3,j+4),10)
   *	replace stform.nomkontr with nnakaz,stform.datkontr with dnakaz
   *ENDIF
   	replace stform.nomkontr with nnakaz,stform.datkontr with dnakaz
   endif
endif   
replace stform.n with np
endscan  

*browse fields nest3,priz,posada,pos,rng
 select stform
 
 SCAN
  mov1=SPACE(3)
  DO CASE
  CASE mov='а'
	mov1=[анг]
  CASE mov='ф'
	mov1=[фр]    
  CASE mov='н'
    mov1=[нім]
  CASE mov='і'
    mov1=[ісп]
  ENDCASE
  REPLACE mov WITH mov1
 ENDSCAN
 go top
 WAIT [Зачекайте... Іде формування довідки] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2

*browse noedit noap node
*cancel
nkaf='декани'
oWord=CreateObject('Word.Application')
oWord.VISIBLE=.T.
*SCAN
* m.dek=m.shlyx+'\dov\dek.doc'

IF alltrim(m.shlyx)=='.' 
m.dek=FULLPATH('')+'dov\dek.doc'
else
m.dek=m.shlyx+'\dov\dek.doc'
endif


oWordDoc1=oWord.Documents.Add(m.dek)

SCATTER MEMVAR
*    m.data_na='01.01.'+STR(YEAR(date()),4)
    m.data_na='01.01.2011'
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



rjd=11
select stform

scan 

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
	m.dis=STRTRAN(dis,["],[])
*    m.dis=SPACE(40) 
	m.zakl=STRTRAN(STRTRAN(zakl,["],[]),[*],[])
	m.mzakl=STRTRAN(mzakl,["],[])
	m.orgn=STRTRAN(orgn,["],[])
	m.ador=STRTRAN(ador,["],[])
	m.kontrakt='№ '+nomkontr+ ;
			IIF(EMPTY(nomkontr),'    ',datkontr)+ ;
			IIF(TermKon=0 and !EMPTY(po),' по '+po,' ')+ ;
        	IIF(TermKon>0,' по '+tzakkontr,' ')
	*		IIF(TermKon>0,' по '+tzakkontr+' на '+ ;
	*		IIF(TermKon>0,' на '+ ;
				IIF(INT(TermKon)=TermKon, ;
				STR(TermKon,2,0),STR(TermKon,4,1))+' р.','')
	m.stod=IIF(TermKon=0,' ',STR(stod,4,2))
	WITH oWord.Selection
		.TypeText(str(n,2))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(priz)+' '+chr(10)+ALLTRIM(imy)+' '+chr(10)+ALLTRIM(bat))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(posada))
		.MoveRight(wdCell)
		.TypeText(STR(rpos,4))
		.MoveRight(wdCell)
*		.TypeText(ALLTRIM(m.dis))
*		.MoveRight(wdCell)
*		.TypeText('штат.')
*       .MoveRight(wdCell)
		.TypeText(ALLTRIM(vzvan))
		.MoveRight(wdCell)
		.TypeText(ALLTRIM(vstup))
		.MoveRight(wdCell)
		.TypeText(STR(npzg,2)+'р. '+STR(npzm,2)+'м.')
		.MoveRight(wdCell)
		.TypeText(STR(npwg,2)+'р. '+STR(npwm,2)+'м.')
		.MoveRight(wdCell)
		.TypeText(IIF(EMPTY(ostpkval),'',STR(ostpkval,4)))
		.MoveRight(wdCell)
		.TypeText(DTOC(datanar))
		.MoveRight(wdCell)
		.TypeText(sex)
		.MoveRight(wdCell)
        .TypeText(m.zakl+chr(10)+m.mzakl+chr(10)+STR(rz,4))
* 		.TypeText(m.zakl+chr(10)+STR(rz,4))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(pochzvan))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(mov)+'.')
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(m.stod))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(m.orgn)+' '+ALLTRIM(m.ador))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(m.kontrakt))
		.MoveRight(wdCell)
	ENDWITH	
endscan

IF alltrim(m.shlyx)=='.' 
m.f11=FULLPATH('')+'form\'+DTOS(DATE())+'_dek.doc'
else
m.f11=m.shlyx+'\form\'+DTOS(DATE())+'_dek.doc'
endif
*=MESSAGEBOX(m.f11)

oWordDoc1.SaveAs(m.f11)

*oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_dek.doc')
oWordDoc1.Close
USE IN doplnad
use in osvita
use in stform
USE IN trudstf
USE IN prizpstf
USE IN prizp

ERASE trudstf.dbf
ERASE prizpstf.dbf
ERASE prizp.dbf
WAIT CLEAR
=MESSAGEBOX([       Довідка сформована]+CHR(13)+ ;
			[Для її перегляду перейдіть у Word],64,[V K A D R - Інфо])

