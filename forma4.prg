**************************************************************************
*****************��� ��� ������������-������������ �����*****************
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
WAIT [���������... ��� ��������� �����] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2
  dimension m(16,15),c(34),mp(16,15)
  store 000 to m
  store 000.0 to mp  	
  c(1)= '������ ����.-�����- '
  c(2)= '�������� ������     '
  c(3)= '������ ���������,  '
  c(4)= '������� ����       '
  c(5)= '������ �������,    '
  c(6)='��������� ����      '
  c(7)= '                    '
  c(8)= '   � ���:           '
  c(9)= '���������,������� '
  c(10)='����                '
  c(11)='���������,�������- '
  c(12)='�� ����            '
  c(13)='�������,�������   '
  c(14)='����                '
  c(15)='��.����. �������- '
  c(16)='�� ,������� ����  '
  c(17)='�������,��������� '
  c(18)='����                '
  c(19)='������� ��� �����- '
  c(20)='���� �������        '
  c(21)='��.����.���������-'
  c(22)='��,��������� ���� '
  c(23)='��.����.���������-'
  c(24)='�� ��� ����.�������'
  c(25)='��������� ����,    '
  c(26)='��� ������� ������  '
  c(27)='������� ��� ��.����'
  c(28)='��,��� ����. �������'
  c(29)='��.����������,�����-'
  c(30)='���� ����          '
  c(31)='��.���������� ���   '
  c(32)='��������� �������   '
  c(33)='��������� ��� ����.'
  c(34)='����.,��� ��. ������'
    
  ff4=TmpDir+[\ff4]
  select 0 	
  *ff4=TmpDir+[\ff4]

 m.main=m.shlyx+'\data\main' 
 m.osvita=m.shlyx+'\data\osvita'
 
 CREATE TABLE osvitad(sprava c(10),zaklosv c(40),rzak n(4))
select 0
USE (m.osvita) &&���� b
inosvita=TmpDir+[\inosvita]
INDEX on sprava TO (inosvita)  comp
SELECT 0
USE (m.main)
inmain=TmpDir+[\inmain]
INDEX on sprava TO (inmain) FOR potstan.and.(nest1='01'.or.(nest1='00'.and.nest3='���'))  comp
SCAN
spravad=sprava
select osvita
  locate for sprava=spravad
  IF NOT FOUND()
	WAIT '� ��� ����� ���� ����� ��� ������ '+ALLTRIM(spravad) TIMEOUT 10 WINDOW    
	WAIT [���������... ��� ��������� �����] WINDOW NOWAIT AT SROWS()/2,SCOLS()/2
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
        where (nest1='01'.or.(nest1='00'.and.nest3='���')).and.potstan.and.main.sprava=osvitad.sprava;
        order by main.sprava

*BROWSE FIELDS nest1,nest2,nest3,sprava,pos,vzvan,vstup FOR EMPTY(vzvan) AND LEFT(ALLTRIM(vstup),1)='�' AND pos#12
*cancel


*SELECT ff4

*COUNT TO a FOR left(vstup,1)='�'.or.vzvan='��������'
*=MESSAGEBOX(STR(a))
 USE IN main
 USE IN osvitad
 use in ff4
 
 select 0
 use (ff4) IN 0
 inff4=TmpDir+[\inff4]
 index on nest1+nest2+nest3 to (inff4) comp
*BROWSE FOR pos=12.and.left(vstup,1)='�'
llll=0

 SCAN 
 posd=IIF(ISBLANK(pos),-999,pos)
 spravad=sprava
 m.npstag=0
 DO forstag WITH spravad
 
 stagzg=INT(m.npstag/365.25) && ��� ���� �������-�����. ����� 
 stagzm=INT((m.npstag-stagzg*365.25)/ROUND(365.25/12,4)) && �������� �����
 stagzg=stagzg+IIF(stagzm=12,1,0) && ������� ����
 stagzm=IIF(stagzm=12,0,stagzm) && ������� �����
  select ff4
 wikd=year(date())-rr
 replace  ff4.npzg with stagzg,ff4.npzm with stagzm,ff4.wik with wikd  
* browse
 ENDSCAN
 GO TOP
 SCAN
 m(1,1)=m(1,1)+1
 DO case
  CASE left(vstup,1)='�' and vzvan='��������'
        m(4,1)=m(4,1)+1
        m(2,1)=m(2,1)+1
        i=4
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='���.'
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
  CASE left(vstup,1)='�'.and.vzvan='��������'
        m(5,1)=m(5,1)+1
        m(2,1)=m(2,1)+1
        i=5
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='���.'
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
 
 CASE left(vstup,1)='�' and vzvan='������'
        m(6,1)=m(6,1)+1
        m(2,1)=m(2,1)+1
        i=6
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='���.'
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


  CASE vzvan='��.�.�.'.and.left(vstup,1)='�'
        m(7,1)=m(7,1)+1
        m(2,1)=m(2,1)+1
        i=7
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(2,2)=m(2,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(2,8)=m(2,8)+1
   case nacion='���.'
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

  CASE vzvan='������'.and.left(vstup,1)='�'
        m(8,1)=m(8,1)+1
        m(3,1)=m(3,1)+1
        i=8
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='���.'
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

  CASE vzvan='������'.and.empty(vstup)
        m(9,1)=m(9,1)+1
        m(3,1)=m(3,1)+1
        i=9
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='���.'
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
  
  CASE vzvan='��.�.�.'.and.left(vstup,1)='�'
        m(10,1)=m(10,1)+1
        m(3,1)=m(3,1)+1
        i=10
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='���.'
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

  CASE vzvan='��.�.�.'.and.empty(vstup)
        m(11,1)=m(11,1)+1
        m(3,1)=m(3,1)+1
        i=11
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='���.'
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
CASE empty(vzvan).and.left(vstup,1)='�' AND pos#12
        m(12,1)=m(12,1)+1
        m(3,1)=m(3,1)+1
        i=12
if substr(zaklosv,1,1)='*'
   m(i,2)=m(i,2)+1
   m(1,2)=m(1,2)+1
   m(3,2)=m(3,2)+1
endif
do case
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
      m(3,8)=m(3,8)+1
   case nacion='���.'
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
	case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
    case nacion='���.'
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
CASE pos=12.and.left(vstup,1)='�'
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
        case nacion='���.'
             m(i,8)=m(i,8)+1
             m(1,8)=m(1,8)+1
             m(3,8)=m(3,8)+1             
             m(12,8)=m(12,8)+1       
        case nacion='���.'
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
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
   case nacion='���.'
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
   case nacion='���.'
      m(i,8)=m(i,8)+1
      m(1,8)=m(1,8)+1
   case nacion='���.'
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
 WAIT [���������... ��� ���������� ������] WINDOW NOWAIT ;
    	AT SROWS()/2,SCOLS()/2

*browse noedit noap node
oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add

SCATTER MEMVAR
oWordDoc1.Content.InsertAfter(padc('��Ͳ ��� ������������-������������ �����',128))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(padc('�����-������������ ������������� ��������� ����������� ����� � ����',128))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
*oWordDoc1.Content.InsertAfter(padc('��  01.01.'+STR(YEAR(date()),4),132))
oWordDoc1.Content.InsertAfter(padc('��  01.01.'+ALLTRIM(STR(YEAR(DATE()))),132))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����

oWordDoc1.Content.InsertAfter(replicate('-',131))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter('  ������������'+space(6)+'|������|  �   |'+space(13)+'�� ����'+space(13)+'| �� �������������     '+'|�� ������ ����.-�������. ������') 
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|'+space(6)+'|���. |'+replicate('-',34)+'|'+replicate('-',23)+'|'+replicate('-',37))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|'+space(6)+'|���- | �� 40| 40-49| 50-59| 60-65|����� |��������|�����|����� |�� 1�.|1-3�. |3-5�. |5-10�.|����� ')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|'+space(6)+'|���   |���� |���� |���� |���� | 65 �.|'+space(9)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'|'+space(6)+'| 10 �.')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|------|------|'+replicate('-',34)+'|'+space(9)+'|'+space(6)+'|'+space(6)+'|'+replicate('-',37))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|      |      |������|������|������|������|������|         |      |      |������|������|������|������|������')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|  %   |  %   |'+replicate('-',34)+'|         |      |      |'+replicate('-',37))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(20)+'|      |      |  %   |  %   |  %   |  %   |  %   |         |      |      |  %   |  %   |  %   |  %   |  %   ')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(replicate('-',131))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����

l=1
for k=1 to 34
do case
   case k>6.and.k<9
   m.radok3=c(k)
oWordDoc1.Content.InsertAfter(m.radok3)
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
   case int(k/2)*2#k
m.radok1=c(k)+'  '+str(m(l,1),3)+'    '+str(m(l,2),3)+'    '+str(m(l,3),3);
+'    '+str(m(l,4),3)+'    '+str(m(l,5),3)+'    '+str(m(l,6),3);
+'    '+str(m(l,7),3)+'       '+str(m(l,8),3)+'    '+str(m(l,9),3);
+'    '+str(m(l,10),3)+'    '+str(m(l,11),3)+'    '+str(m(l,12),3);
+'    '+str(m(l,13),3)+'    '+str(m(l,14),3)+'    '+str(m(l,15),3)
oWordDoc1.Content.InsertAfter(m.radok1)
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
   case int(k/2)*2=k
m.radok2=c(k)+'  '+str(mp(l,1),5,1)+'  '+str(mp(l,2),5,1)+'  '+str(mp(l,3),5,1);
+'  '+str(mp(l,4),5,1)+'  '+str(mp(l,5),5,1)+'  '+str(mp(l,6),5,1);
+'  '+str(mp(l,7),5,1)+space(26);
+str(mp(l,11),5,1)+'  '+str(mp(l,12),5,1)+'  '+str(mp(l,13),5,1);
+'  '+str(mp(l,14),5,1)+'  '+str(mp(l,15),5,1)
oWordDoc1.Content.InsertAfter(m.radok2)
l=l+1
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
*oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
endcase
endfor

oWord.Selection.EndKey(6) && ��� �� ����� ������
wdPage=7
oWord.Selection.InsertBreak(wdPage) && ʳ���� �������
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
=MESSAGEBOX([       ������ ����������]+CHR(13)+ ;
			[��� �� ��������� �������� � Word],64,[V K A D R - ����])

