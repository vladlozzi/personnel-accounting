**************************************************************************
*****************Дані про професорсько-викладацький склад*****************
**************************************************************************

set century on
 set safety off
 set console on
*TmpDir=SYS(2023)
True=.t.
False=.f.
wdOrientLandscape=1
wdPrinterDefaultBin=0
wdSectionNewPage=2
wdAlignVerticalTop=0
WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
  dimension m(16,15),c(34),mp(16,15)
  store 000 to m
  store 000.0 to mp  	
  c(1)= 'Всього проф.-викла- '
  c(2)= 'дацького складу     '
  c(3)= 'Всього професорів,  '
  c(4)= 'докторів наук       '
  c(5)= 'Всього доцентів,    '
  c(6)='кандидатів наук      '
  c(7)= '                    '
  c(8)= '   з них:           '
  c(9)= 'Професорів,докторів '
  c(10)='наук                '
  c(11)='Професорів,кандида- '
  c(12)='тів наук            '
  c(13)='Доцентів,докторів   '
  c(14)='наук                '
  c(15)='Ст.наук. співробіт- '
  c(16)='ків ,докторів наук  '
  c(17)='Доцентів,кандидатів '
  c(18)='наук                '
  c(19)='Доцентів без науко- '
  c(20)='вого ступеня        '
  c(21)='Ст.наук.співробітни-'
  c(22)='ків,кандидатів наук '
  c(23)='Ст.наук.співробітни-'
  c(24)='ків без наук.ступеня'
  c(25)='Кандидатів наук,    '
  c(26)='без вченого звання  '
  c(27)='Доцентів без вч.зван'
  c(28)='ня,без наук. ступеня'
  c(29)='Ст.викладачів,канди-'
  c(30)='датів наук          '
  c(31)='Ст.викладачів без   '
  c(32)='наукового ступеня   '
  c(33)='Асистентів без наук.'
  c(34)='ступ.,без вч. звання'
    
  ff4=TmpDir+[\ff4]
  select 0 	
  *ff4=TmpDir+[\ff4]

 m.main=m.shlyx+'\data\main' 
 m.osvita=m.shlyx+'\data\osvita'
 
 CREATE TABLE osvitad(sprava c(10),zaklosv c(40),rzak n(4))
select 0
USE (m.osvita) &&було b
inosvita=TmpDir+[\inosvita]
INDEX on sprava TO (inosvita)  comp
SELECT 0
USE (m.main)
inmain=TmpDir+[\inmain]
INDEX on sprava TO (inmain) FOR potstan.and.(nest1='01'.or.(nest1='00'.and.nest3='ДЕК'))  comp
SCAN
spravad=sprava
select osvita
  locate for sprava=spravad
  IF NOT FOUND()
	WAIT 'В базі освіти немає даних для справи '+ALLTRIM(spravad) TIMEOUT 10 WINDOW    
	WAIT [Зачекайте... Іде підготовка даних] WINDOW NOWAIT AT SROWS()/2,SCOLS()/2
  ENDIF 
ENDSCAN  

SELECT osvita
GO top
spravad=SPACE(10)
DO WHILE !EOF()
IF sprava#spravad
   spravad=sprava
   zaklosvd=zaklosv
   rzakd=rzak
   INSERT INTO osvitad (sprava,zaklosv,rzak) values(spravad,zaklosvd,rzakd)
ENDIF
SKIP
ENDDO
  
USE IN osvita
USE IN osvitad

  select main.nest1,main.nest2,main.nest3,main.sprava,main.pos,;
        main.vzvan,main.vstup,00 as npzg,00 as npzm,;
        year(main.datanar) as rr,00 as wik,main.nacion,osvitad.zaklosv,osvitad.rzak ;
        from (m.main),osvitad into table (ff4);
        where (nest1='01'.or.(nest1='00'.and.nest3='ДЕК')).and.potstan.and.main.sprava=osvitad.sprava;
        order by main.sprava

*BROWSE FIELDS nest1,nest2,nest3,sprava,pos,vzvan,vstup FOR EMPTY(vzvan) AND LEFT(ALLTRIM(vstup),1)='к' AND pos#12
*cancel


*SELECT ff4

*COUNT TO a FOR left(vstup,1)='д'.or.vzvan='професор'
*=MESSAGEBOX(STR(a))
 USE IN main
 USE IN osvitad
 use in ff4
 
 select 0
 use (ff4) IN 0
 inff4=TmpDir+[\inff4]
 index on nest1+nest2+nest3 to (inff4) comp
*BROWSE FOR pos=12.and.left(vstup,1)='к'
llll=0

 SCAN 
 posd=IIF(ISBLANK(pos),-999,pos)
 spravad=sprava
 m.npstag=0
 DO forstag WITH spravad
 
 stagzg=INT(m.npstag/365.25) && цілі роки науково-педаг. стажу 
 stagzm=INT((m.npstag-stagzg*365.25)/ROUND(365.25/12,4)) && залишкові місяці
 stagzg=stagzg+IIF(stagzm=12,1,0) && уточнені роки
 stagzm=IIF(stagzm=12,0,stagzm) && уточнені місяці
  select ff4
 wikd=year(date())-rr
 replace  ff4.npzg with stagzg,ff4.npzm with stagzm,ff4.wik with wikd  
* browse
 ENDSCAN
 GO TOP
 SCAN
 m(1,1)=m(1,1)+1
 DO case
  CASE left(vstup,1)='д' and vzvan='професор'
        m(4,1)=m(4,1)+1
        m(2,1)=m(2,1)+1
        i=4
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(2,9)=m(2,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(2,10)=m(2,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(2,3)=m(2,3)+1                      
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(2,4)=m(2,4)+1             
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(2,5)=m(2,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1       
       m(2,6)=m(2,6)+1 
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(2,7)=m(2,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1
          m(2,11)=m(2,11)+1         
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1
          m(2,12)=m(2,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1
          m(2,13)=m(2,13)+1     
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1 
          m(2,14)=m(2,14)+1    
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,14)=m(1,14)+1
          m(2,14)=m(2,14)+1
 endcase
  CASE left(vstup,1)='к'.and.vzvan='професор'
        m(5,1)=m(5,1)+1
        m(2,1)=m(2,1)+1
        i=5
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(2,9)=m(2,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(2,10)=m(2,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(2,3)=m(2,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1      
       m(2,4)=m(2,4)+1
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(2,5)=m(2,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
       m(2,6)=m(2,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(2,7)=m(2,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1 
          m(2,11)=m(2,11)+1        
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(2,12)=m(2,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(2,13)=m(2,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(2,14)=m(2,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(2,15)=m(2,15)+1
 endcase
 
 CASE left(vstup,1)='д' and vzvan='доцент'
        m(6,1)=m(6,1)+1
        m(2,1)=m(2,1)+1
        i=6
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(2,9)=m(2,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(2,10)=m(2,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(2,3)=m(2,3)+1                      
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(2,4)=m(2,4)+1             
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(2,5)=m(2,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1       
       m(2,6)=m(2,6)+1 
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(2,7)=m(2,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1
          m(2,11)=m(2,11)+1         
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1
          m(2,12)=m(2,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1
          m(2,13)=m(2,13)+1     
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1 
          m(2,14)=m(2,14)+1    
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,14)=m(1,14)+1
          m(2,14)=m(2,14)+1
 endcase


  CASE vzvan='ст.н.с.'.and.left(vstup,1)='д'
        m(7,1)=m(7,1)+1
        m(2,1)=m(2,1)+1
        i=7
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(2,9)=m(2,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(2,10)=m(2,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(2,3)=m(2,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(2,4)=m(2,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(2,5)=m(2,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
       m(2,6)=m(2,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(2,7)=m(2,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
          m(2,11)=m(2,11)+1
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(2,12)=m(2,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(2,13)=m(2,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(2,14)=m(2,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(2,15)=m(2,15)+1
 endcase

  CASE vzvan='доцент'.and.left(vstup,1)='к'
        m(8,1)=m(8,1)+1
        m(3,1)=m(3,1)+1
        i=8
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(3,9)=m(3,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(3,10)=m(3,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(3,3)=m(3,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(3,4)=m(3,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(3,5)=m(3,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
       m(3,6)=m(3,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(3,7)=m(3,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
          m(3,11)=m(3,11)+1
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(3,12)=m(3,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(3,13)=m(3,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(3,14)=m(3,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(3,15)=m(3,15)+1
 endcase

  CASE vzvan='доцент'.and.empty(vstup)
        m(9,1)=m(9,1)+1
        m(3,1)=m(3,1)+1
        i=9
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1   
      m(3,9)=m(3,9)+1
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(3,10)=m(3,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1           
       m(3,3)=m(3,3)+1
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1      
       m(3,4)=m(3,4)+1 
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(3,5)=m(3,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1       
       m(3,6)=m(3,6)+1
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(3,7)=m(3,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
          m(3,11)=m(3,11)+1
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(3,12)=m(3,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(3,13)=m(3,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(3,14)=m(3,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(3,15)=m(3,15)+1
 endcase
  
  CASE vzvan='ст.н.с.'.and.left(vstup,1)='к'
        m(10,1)=m(10,1)+1
        m(3,1)=m(3,1)+1
        i=10
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(3,9)=m(3,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(3,10)=m(3,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(3,3)=m(3,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(3,4)=m(3,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(3,5)=m(3,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
       m(3,6)=m(3,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(3,7)=m(3,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
          m(3,11)=m(3,11)+1
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(3,12)=m(3,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(3,13)=m(3,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(3,14)=m(3,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(3,15)=m(3,15)+1
 endcase

  CASE vzvan='ст.н.с.'.and.empty(vstup)
        m(11,1)=m(11,1)+1
        m(3,1)=m(3,1)+1
        i=11
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1   
      m(3,9)=m(3,9)+1
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(3,10)=m(3,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1           
       m(3,3)=m(3,3)+1
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1      
       m(3,4)=m(3,4)+1 
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(3,5)=m(3,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1       
       m(3,6)=m(3,6)+1
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(3,7)=m(3,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
          m(3,11)=m(3,11)+1
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(3,12)=m(3,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(3,13)=m(3,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(3,14)=m(3,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(3,15)=m(3,15)+1
 endcase
CASE empty(vzvan).and.left(vstup,1)='к' AND pos#12
        m(12,1)=m(12,1)+1
        m(3,1)=m(3,1)+1
        i=12
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
      m(3,9)=m(3,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
      m(3,10)=m(3,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(3,3)=m(3,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(3,4)=m(3,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(3,5)=m(3,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
       m(3,6)=m(3,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(3,7)=m(3,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
          m(3,11)=m(3,11)+1
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
          m(3,12)=m(3,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
          m(3,13)=m(3,13)+1
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(3,14)=m(3,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(3,15)=m(3,15)+1
 endcase

CASE empty(vzvan).and.empty(vstup).and.(pos=4 OR pos=2)
        m(13,1)=m(13,1)+1
        i=13
	if substr(zaklosv,1,1)='*'
		m(i,2)=m(i,2)+1
		m(1,2)=m(1,2)+1
	endif
	do case
	case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
    case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1
    otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
    endcase
	do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
    endcase
	do case
    case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
    case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
    case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
    case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
    case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
    endcase
**********************************************************
CASE pos=12.and.left(vstup,1)='к'
*     BROWSE
     m(14,1)=m(14,1)+1
     m(3,1)=m(3,1)+1
     i=14
     if substr(zaklosv,1,1)='*'
        m(i,2)=m(i,2)+1
        m(1,2)=m(1,2)+1
        m(3,2)=m(3,2)+1
        m(12,2)=m(12,2)+1     
     endif
     DO CASE 
        case nacion='укр.'
             m(i,8)=m(i,8)+1
             m(1,8)=m(1,8)+1
             m(3,8)=m(3,8)+1             
             m(12,8)=m(12,8)+1       
        case nacion='рос.'
             m(i,9)=m(i,9)+1
             m(1,9)=m(1,9)+1
             m(3,9)=m(3,9)+1                               
             m(12,9)=m(12,9)+1
        otherwise
             m(i,10)=m(i,10)+1
             m(1,10)=m(1,10)+1
             m(3,10)=m(3,10)+1
             m(12,10)=m(12,10)+1
     ENDCASE 
     DO CASE 
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1
       m(3,3)=m(3,3)+1
       m(12,3)=m(12,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1
       m(3,4)=m(3,4)+1
       m(12,4)=m(12,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
       m(3,5)=m(3,5)+1
       m(12,5)=m(12,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1
       m(3,6)=m(3,6)+1       
       m(12,6)=m(12,6)+1
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
       m(3,7)=m(3,7)+1
       m(12,6)=m(12,6)+1
     ENDCASE 
     DO CASE 
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1
          m(3,11)=m(3,11)+1
          m(12,11)=m(12,11)+1         
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1
          m(3,12)=m(3,12)+1     
          m(12,12)=m(12,12)+1
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1                                                     
          m(1,13)=m(1,13)+1     
          m(3,13)=m(3,13)+1
          m(12,13)=m(12,13)+1          
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
          m(3,14)=m(3,14)+1
          m(12,14)=m(12,14)+1
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
          m(3,15)=m(3,15)+1
          m(12,15)=m(12,15)+1
      ENDCASE 
************************************************************************************
  CASE pos=12.and.empty(vstup)
        m(15,1)=m(15,1)+1
        i=15
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
 endcase
  
  CASE (pos=13.or.pos=3.or.pos=5).and.empty(vstup).and.empty(vzvan)
        m(16,1)=m(16,1)+1
        i=16
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
endif
do case
   case nacion='укр.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
   case nacion='рос.'
      m(i,9)=m(i,9)+1
      m(1,9)=m(1,9)+1   
   otherwise
      m(i,10)=m(i,10)+1
      m(1,10)=m(1,10)+1
 endcase
 do case
    case wik<40
       m(i,3)=m(i,3)+1
       m(1,3)=m(1,3)+1           
    case  wik>=40.and.wik<=49
       m(i,4)=m(i,4)+1 
       m(1,4)=m(1,4)+1      
    case  wik>=50.and.wik<=59
       m(i,5)=m(i,5)+1
       m(1,5)=m(1,5)+1
    case  wik>=60.and.wik<=65
       m(i,6)=m(i,6)+1
       m(1,6)=m(1,6)+1       
    case  wik>65
       m(i,7)=m(i,7)+1
       m(1,7)=m(1,7)+1
  endcase
  do case
     case npzg<1 && stag>0.and.stag<365
          m(i,11)=m(i,11)+1
          m(1,11)=m(1,11)+1         
     case npzg>=1.and.npzg<3
          m(i,12)=m(i,12)+1
          m(1,12)=m(1,12)+1     
     case npzg>=3.and.npzg<5
          m(i,13)=m(i,13)+1
          m(1,13)=m(1,13)+1     
     case npzg>=5.and.npzg<=10
          m(i,14)=m(i,14)+1
          m(1,14)=m(1,14)+1     
     case npzg>10
          m(i,15)=m(i,15)+1     
          m(1,15)=m(1,15)+1
 endcase
 ENDCASE 
*=MESSAGEBOX(STR(m(i,1)))
*r=RECNO()
*BROWSE FOR RECNO()=r
                                                    
 ENDSCAN

* =MESSAGEBOX( STR(m(15,1))+STR(m(15,2))+STR(m(15,3))+STR(m(15,4))+STR(m(15,5))+STR(m(15,6))+STR(m(15,7))+STR(m(15,8)))
* browse

 for i=1 to 16
 if m(i,1)#0
  mp(i,1)=m(i,1)*100/m(1,1)
  for k=2 to 7
  mp(i,k)=m(i,k)*100/m(i,1)
  endfor
  for k=11 to 15 
    mp(i,k)=m(i,k)*100/m(i,1)
  endfor
 endif 
 endfor 
 WAIT [Зачекайте... Іде формування довідки] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2

*browse noedit noap node
oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add

SCATTER MEMVAR
oWordDoc1.Content.InsertAfter(padc('ДАНІ ПРО ПРОФЕСОРСЬКО-ВИКЛАДАЦЬКИЙ СКЛАД',128))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(padc('Івано-Франківського національного технічного університету нафти і газу',128))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
*oWordDoc1.Content.InsertAfter(padc('на  01.01.'+STR(YEAR(date()),4),132))
oWordDoc1.Content.InsertAfter(padc('на  01.01.'+ALLTRIM(STR(YEAR(DATE()))),132))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок

oWordDoc1.Content.InsertAfter(replicate('-',131))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('  Найменування'+space(6)+'|Всього|  З   |'+space(13)+'за віком'+space(13)+'| по національності     '+'|за стажем наук.-педагог. роботи') 
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|'+space(6)+'|унів. |'+replicate('-',34)+'|'+replicate('-',23)+'|'+replicate('-',37))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|'+space(6)+'|осві- | до 40| 40-49| 50-59| 60-65|понад |українців|росіян|інших |до 1р.|1-3р. |3-5р. |5-10р.|понад ')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|'+space(6)+'|тою   |років |років |років |років | 65 р.|'+space(9)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'| 10 р.')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|------|------|'+replicate('-',34)+'|'+space(9)+'|'+space(6)+'|'+space(6)+'|'+replicate('-',37))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|      |      |всього|всього|всього|всього|всього|         |      |      |всього|всього|всього|всього|всього')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|  %   |  %   |'+replicate('-',34)+'|         |      |      |'+replicate('-',37))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(space(20)+'|      |      |  %   |  %   |  %   |  %   |  %   |         |      |      |  %   |  %   |  %   |  %   |  %   ')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(replicate('-',131))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок

l=1
for k=1 to 34
do case
   case k>6.and.k<9
   m.radok3=c(k)
oWordDoc1.Content.InsertAfter(m.radok3)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
   case int(k/2)*2#k
m.radok1=c(k)+'  '+str(m(l,1),3)+'    '+str(m(l,2),3)+'    '+str(m(l,3),3);
+'    '+str(m(l,4),3)+'    '+str(m(l,5),3)+'    '+str(m(l,6),3);
+'    '+str(m(l,7),3)+'       '+str(m(l,8),3)+'    '+str(m(l,9),3);
+'    '+str(m(l,10),3)+'    '+str(m(l,11),3)+'    '+str(m(l,12),3);
+'    '+str(m(l,13),3)+'    '+str(m(l,14),3)+'    '+str(m(l,15),3)
oWordDoc1.Content.InsertAfter(m.radok1)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
   case int(k/2)*2=k
m.radok2=c(k)+'  '+str(mp(l,1),5,1)+'  '+str(mp(l,2),5,1)+'  '+str(mp(l,3),5,1);
+'  '+str(mp(l,4),5,1)+'  '+str(mp(l,5),5,1)+'  '+str(mp(l,6),5,1);
+'  '+str(mp(l,7),5,1)+space(26);
+str(mp(l,11),5,1)+'  '+str(mp(l,12),5,1)+'  '+str(mp(l,13),5,1);
+'  '+str(mp(l,14),5,1)+'  '+str(mp(l,15),5,1)
oWordDoc1.Content.InsertAfter(m.radok2)
l=l+1
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
*oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
endcase
endfor

oWord.Selection.EndKey(6) && Йти на кінець тексту
wdPage=7
oWord.Selection.InsertBreak(wdPage) && Кінець сторінки
USE IN ff4

WITH oWord
    .Selection.WholeStory
    WITH .Selection.Font
        .Name = "Courier New"
        .Size = 10
        .Bold = False
        .Italic = False
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
    .LeftMargin = CmToPnt(2.5)
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
IF alltrim(m.shlyx)=='.' 
m.f4=FULLPATH('')+'form\'+DTOS(DATE())+'_forma4.doc'
else
m.f4=m.shlyx+'\form\'+DTOS(DATE())+'_forma4.doc'
endif
*=MESSAGEBOX(m.f4)

oWordDoc1.SaveAs(m.f4)

*oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_forma4.doc')

ERASE osvitad.dbf
oWord.Visible=.t.
WAIT CLEAR
=MESSAGEBOX([       Довідка сформована]+CHR(13)+ ;
			[Для її перегляду перейдіть у Word],64,[V K A D R - Інфо])

