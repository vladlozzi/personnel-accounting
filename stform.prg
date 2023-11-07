****************************************************************************
******************Довідка про особовий склад підрозділу*********************
****************************************************************************

PUBLIC posadad
rposd=0
 WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
 pos1=SPACE(30)
  select 0 	
true=.t.
false=.f.
wdCell=12
 stform=Tmpdir+'\stform'
 state=Tmpdir+'\state'
* set
 store 0 to zaw,prof,doz,stwk,wk,ast
m.main=m.shlyx+'\data\main'
 select nest1,nest2,nest3,00 as n,alltrim(name1) as priz, ;
        alltrim(name2) as imy,alltrim(name3) as bat, ;
        name1,name2,name3, ;
        sprava,pos,space(30) as posada,000 as rng,0000 as rpos, ;
        vzvan,vstup,0000 as npwg,0000 as npwm,0000 as npzg,0000 as npzm, ;
        ostpkval,datanar,day(datanar) as dr, ;	
        mont(datanar) as mr,year(datanar) as rr,sex,space(80) as zakl,SPACE(40) as mzakl, ;
        0000 as rz,pochzvan,left(inmov,3) as mov,stod,space(40) as orgn, ;
        space(40) as ador,nomkontr,DTOC(datkontr) AS datkontr,DTOC(tzakkontr) AS tzakkontr, ;
	ROUND((tzakkontr-datkontr)/365.25,1) AS TermKon, ;
	space(30) as pidstava,space(30) as po, dis, .F. AS obrobl ;
        from (m.main) into table (stform) where potstan.and.(nest1='01';
        .or.(nest1='00'.and.nest2='РЕК')) order by nest2,nest3 
*browse
 select 0
m.nest2=m.shlyx+'\dov\nest2'
m.nest3=m.shlyx+'\dov\nest3'
 select nest2.nest1,nest2.nest2,nest3.nest3,;
        00.00 as stod1,00.00 as stod2,00.00 as stod3,00.00 as stod4,;
        00.00 as stod5,00.00 as stod6,space(100) as nkaf;
        from (m.nest2),(m.nest3);
        into table (state);
        where nest2.nest2=nest3.nest2.and.(nest2.nest1='01'.or.nest2.nest1='00');
        .and.nest2.nest2#[ВК ].and.nest2.nest2#[ДЕК ];
        .and.nest2.nest1=nest3.nest1;
        order by nest2.nest1,nest2.nest2,nest3.nest3

m.prizperm=m.shlyx+'\data\prizperm'
SELECT * from (m.prizperm) INTO TABLE prizp.dbf ORDER BY sprava,dvstup DESC 
*brow
 use in prizp    
 use in nest2
 use in nest3
 
 use in state
 use in stform
 use in main
 USE IN prizperm  
* USE IN osvita
 
 select 0 && було 4
 m.posad=m.shlyx+'\dov\posad.dbf'
 COPY FILE (m.posad) TO posadstf.dbf
 use posadstf noup
 inposad=TmpDir+[\inposad]
 index on nest1+str(pos,3) to (inposad) comp for nest1='01'.or.nest1='00'
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
 select 0 && було 3
m.prizperm=m.shlyx+'\data\prizperm.dbf' 
COPY FILE (m.prizperm) TO prizpstf.dbf
use prizpstf noup
 inperem=TmpDir+[\inperem]
 index on sprava+dtos(dvstup) to (inperem) comp
 select 0 && було 5 
 use (state)
 select 0 && було 6
m.nest3=m.shlyx+'\dov\nest3' 
use (m.nest3) noup
 innest3=TmpDir+[\innest3]
 index on nest2+nest3 to (innest3) comp
 select 0 && було 7
 use prizp noup
 m.data_na='01.01.'+STR(YEAR(date()),4)
 date_saved=DATE()
 cmd='DATE '+m.data_na
 ! &cmd
 select 0
 use (stform)
 instform=TmpDir+[\instform]
 index on nest1+nest2+nest3 to (instform) comp
* browse fields nest3,priz,posada,pos,rng,stod
  kaf=nest3
 scan
 posd=IIF(ISBLANK(pos),-999,pos)
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
 if nest3=kaf
    do case
       case posd=2
       zaw=zaw+stod
       case posd=1 
       prof=prof+stod
       case posd=4
       doz=doz+stod
       case posd=12
       stwk=stwk+stod
       case posd=13
       wk=wk+stod
       case posd=3
       ast=ast+stod
    endcase
  else
    select nest3 && було 6
    locate for nest3=kaf
    if found()
    nkafd=left(povnest3,100) 
    endif
    select state && було 5
    locate for nest3=kaf
     if found()
    replace state.stod1 with zaw,state.stod2 with prof,;
    state.stod3 with doz,state.stod4 with stwk,state.stod5 with wk,;
    state.stod6 with ast,state.nkaf with nkafd
      else
    	WAIT 'В довіднику кафедр немає шифру кафедри '+kaf WINDOW TIMEOUT 2 ;
    	AT SROWS()/2,SCOLS()/2
		WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
     endif  
    store 0 to zaw,prof,doz,stwk,wk,ast
    nkafd=space(100)
    kaf=stform.nest3
select 0
do case
       case posd=2
       zaw=zaw+stform.stod
       case posd=1 
       prof=prof+stform.stod
       case posd=4
       doz=doz+stform.stod
       case posd=12
       stwk=stwk+stform.stod
       case posd=13
       wk=wk+stform.stod
       case posd=3
       ast=ast+stform.stod
    endcase
  endif  
       
  select posadstf && було 4 
 locate for pos=posd
 if found()
   posadad=posada
   rangd=rang 
  replace stform.posada with posadad ,stform.rng with rangd
*? 'posada=',stform.posada at 9
  endif
 select osvita && було 1
 go top
 locate for sprava=spravad
 if found()
    zakld=zaklosv
    mzakld=mzaklosv 
    rzd=rzak
    replace stform.zakl with zakld,stform.mzakl with mzakld,stform.rz with rzd
 endif

 select prizp && було 7
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
 
 select trudstf && було 2
 set filter to sprava=spravad
 go bottom
 ord=org
 adord=adrorg
 if ord=space(25)
    ord='Після ВУЗу'
 endif
 replace stform.orgn with ord,stform.ador with adord
 
ENDSCAN
 
 cmd='DATE '+DTOC(m.date_saved)
 ! &cmd

select nest3 && було 6
    locate for nest3=kaf
    if found()
    nkafd=left(povnest3,100) 
    endif
    select state && було 5
    locate for nest3=kaf
     if found()
    replace state.stod1 with zaw,state.stod2 with prof,;
    state.stod3 with doz,state.stod4 with stwk,state.stod5 with wk,;
    state.stod6 with ast,state.nkaf with nkafd
    endif
*select 5
*browse
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
endscan  
enddo
SELE stform
*replace for '84/3'$nomkontr datkontr with ctod('31.08.2001')
*replace for '81/3'$nomkontr datkontr with ctod('30.08.2001')
*replace for '6/3'$nomkontr datkontr with ctod('17.01.2001')
*replace for '112/3'$nomkontr datkontr with ctod('02.11.2001')
*replace for '73/3'$nomkontr datkontr with ctod('18.10.2001')
*replace for '74/3'$nomkontr datkontr with ctod('23.10.2001')
*replace for '62/3'$nomkontr datkontr with ctod('29.06.2001')
*replace for '89/3'$nomkontr datkontr with ctod('03.09.2001')
*replace for '98/3'$nomkontr datkontr with ctod('02.10.2001')
*replace for '54/3'$nomkontr datkontr with ctod('31.05.2001')
*replace for '2/5'$nomkontr datkontr with ctod('03.01.2001')
*replace for '130/3'$nomkontr and priz=[Пилип ] datkontr with ctod('26.07.1994')
*replace for '94/3'$nomkontr and priz=[Галущак ] datkontr with ctod('24.09.2001')

GO TOP
*browse fields nest3,priz,posada,pos,rng,nomkontr,datkontr
 select state
 go top
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
SELECT stform
rect=[ректор]
LOCATE FOR posada=m.rect
SCATTER MEMVAR
LOCATE FOR name1+name2+name3=m.name1+m.name2+m.name3 AND posada#m.rect
IF FOUND()
	SCATTER MEMVAR
	LOCATE FOR posada=m.rect
	REPLACE npwg with m.npwg, npwm with m.npwm, npzg with m.npzg, npzm with m.npzm  
ENDIF

DIMENSION kerpos(5)
kerpos(1)=[прор]
kerpos(2)=[директор]
kerpos(3)=[начальник]
FOR ikp=1 TO 3
SET FILTER TO m.kerpos(ikp)$posada
GO TOP
* BROWSE NOEDIT NODELETE NOAPPEND 
DO WHILE NOT EOF()
	r=RECNO()
	LOCATE FOR NOT obrobl && черговий необроблений кер
	IF FOUND()
		m.name1=name1
    	m.name2=name2
	    m.name3=name3
*		BROWSE FIELDS name1,name2,name3,obrobl NOEDIT NODELETE NOAPPEND 
	ELSE
		EXIT
	ENDIF
	SET FILTER TO
	GO TOP
	LOCATE FOR name1+name2+name3=m.name1+m.name2+m.name3 AND NOT (m.kerpos(ikp)$posada) && відповідна справа - не кер
	IF FOUND()
		m.npwg=npwg
		m.npwm=npwm
		m.npzg=npzg
		m.npzm=npzm
		GO TOP && знайдено - прочитано стаж - повернутися до кер
		GO r
		REPLACE npwg with m.npwg, npwm with m.npwm, npzg with m.npzg, npzm with m.npzm, ;
			obrobl WITH .T. && записати стаж для кер
	ELSE
		GO r
		REPLACE obrobl WITH .T.
	    =MESSAGEBOX([Не знайдений ]+m.kerpos(ikp)+[ у ПВ складі: ]+ALLTRIM(m.name1)+' '+ALLTRIM(m.name2)+' '+ALLTRIM(m.name3)+ ;
	    	[. Стаж науково-педагогічної роботи йому може бути нарахований неправильно])
	ENDIF
	SET FILTER TO m.kerpos(ikp)$posada
	GO TOP
	GO r
	SKIP
ENDDO
GO TOP
*BROWSE FIELDS name1,name2,name3,obrobl,posada,npzg,npzm,npwg,npwm NOEDIT NODELETE NOAPPEND 
SET FILTER TO
ENDFOR

SELECT stform
*BROWSE

SELECT state
*BROWSE

*CANCEL
oWord=CreateObject('Word.Application')
oWord.VISIBLE=.T.

SCAN

IF alltrim(m.shlyx)=='.' 
m.foss=FULLPATH('')+'dov\ossklad.doc'
else
m.foss=m.shlyx+'\dov\ossklad.doc'
endif

oWordDoc1=oWord.Documents.Add(m.foss)
SCATTER MEMVAR
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

	oWord.SELECTION.FIND.ClearFormatting
	WITH oWord.SELECTION.FIND
        .Replacement.ClearFormatting
		.TEXT = "$$zavkaf"
		.Replacement.TEXT = str(m.stod1,5,2)
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
		.TEXT = "$$prof"
		.Replacement.TEXT = str(m.stod2,5,2)
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
		.TEXT = "$$docent"
		.Replacement.TEXT = str(m.stod3,5,2)
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
		.TEXT = "$$stvikl"
		.Replacement.TEXT = str(m.stod4,5,2)
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
		.TEXT = "$$vikl"
		.Replacement.TEXT = str(m.stod5,5,2)
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
		.TEXT = "$$asist"
		.Replacement.TEXT = str(m.stod6,5,2)
		.Forward = true
		.FORMAT = false
		.MatchCase = false
		.MatchWholeWord = false
		.MatchWildcards = false
		.MatchSoundsLike = false
		.MatchAllWordForms = false
	ENDWITH
	oWord.SELECTION.FIND.Execute(,,,,,,,,,,2)

rjd=17
select stform
scan for nest3=m.nest3
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
*		.TypeText(ALLTRIM(m.dis))
*		.MoveRight(wdCell)
*		.TypeText('штат.')
*       	.MoveRight(wdCell)
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
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(pochzvan))
		.MoveRight(wdCell)
 		.TypeText(ALLTRIM(mov)+'.')
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
m.f1=FULLPATH('')+'form\'+DTOS(DATE())+'_ossklad_'+ALLTRIM(m.nest3)+'.doc'
else
m.f1=m.shlyx+'\form\'+DTOS(DATE())+'_ossklad_'+ALLTRIM(m.nest3)+'.doc'
endif
*=MESSAGEBOX(m.f1)

oWordDoc1.SaveAs(m.f1)

*oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_ossklad_'+ALLTRIM(m.nest3)+'.doc')
oWordDoc1.Close
ENDSCAN
uSE IN nest3
USE IN state
use in posadstf
use in trudstf
use in prizpstf
use in osvita
use in stform
USE IN prizp

ERASE posadstf.dbf
ERASE prizpstf.dbf
ERASE prizp.dbf
ERASE trudstf.dbf

WAIT CLEAR
=MESSAGEBOX([       Довідка сформована]+CHR(13)+ ;
			[Для її перегляду перейдіть у Word],64,[V K A D R - Інфо])
