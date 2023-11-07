****************************************************************************
* ������ ��� ��� �������� � ������ ����� ��������� � ���.���������   *
****************************************************************************

set century on
set safety off
set console on
TmpDir=SYS(2023)
True=.t.
False=.f.
wdOrientLandscape=1
wdPrinterDefaultBin=0
wdSectionNewPage=2
wdAlignVerticalTop=0  
wait [���������...��� ��������� �����] window nowait;
     at srows()/2,scols()/2 
dimension c(16),m(8,13),mp(8,9)
c(1)='                '
c(2)='1.���.���������'
c(3)='2.���.��������� '
c(4)='   � �.�.:      '
c(5)='2.1.������ ���- '
c(6)='    ������ ����'
c(7)='2.2.������ �����'
c(8)='���������� ���� '
c(9)='    � ���:      '
c(10)='  �)����������  '
c(11)='                '
c(12)='  �)������      '
c(13)='                '
c(14)='  �)��쳿       '
c(15)='3.  ����������� '
c(16)='    ������      '
store 000.0 to m,mp
ff3=TmpDir+[\ff3]
ff2=TmpDir+[\ff2]
 m.main=m.shlyx+'\data\main' 
 m.nest3=m.shlyx+'\dov\nest3'
 m.osvita=m.shlyx+'\data\osvita'
 m.doplnad=m.shlyx+'\data\doplnad'

CREATE TABLE osvitad(sprava c(10),zaklosv c(40))
USE (m.osvita) IN b
SELECT b
INDEX on sprava TO iosvita  comp
spravad=SPACE(10)
DO while!EOF()
IF sprava#spravad
   spravad=sprava
   zaklosvd=zaklosv
   INSERT INTO osvitad (sprava,zaklosv) values(spravad,zaklosvd)
ENDIF
SKIP
enddo 
SELECT osvitad   
GO TOP
USE IN osvita
USE IN osvitad

select main.nest1,main.nest2,main.nest3,main.sprava,main.pos, ;
       main.vzvan,main.vstup,main.sex,year(main.datanar) as rr,nest3.typkaf,SPACE(30) as doplata, ;
       main.nacion,main.name1,osvitad.zaklosv ;
       	from (m.main),osvitad,(m.nest3) into table (ff2);
    	where potstan .and. main.sprava=osvitad.sprava .and. ;
		(main.nest1='01'.or.(main.nest1='00'.and.main.pos=615)) .and. ;
		nest3.nest1=main.nest1 AND nest3.nest3=main.nest3 ;
       	order by main.nest3 
*BROWSE
*cancel       	
USE IN main
USE IN osvitad
USE IN nest3
USE IN ff2

USE (ff2) IN a
USE (m.doplnad) IN e
SELECT e
INDEX ON sprava TO zz2 comp
SELECT a
INDEX ON sprava TO zz1 COMPACT 
spravad=SPACE(10)
m.dopl=SPACE(30)
scan
spravad=sprava
SELECT e
SCAN for sprava=spravad
IF za_scho='�� ������' AND EMPTY(datzn)  
m.dopl=za_scho
 endif
ENDSCAN

SELECT a
replace doplata WITH m.dopl
spravad=SPACE(10)
m.dopl=SPACE(30)
ENDSCAN
* BROWSE

select * from ff2 into table (ff3);
       where pos=2.or.pos=615.or.doplata='�� ������' order by nest3
*BROWSE
 
USE IN ff2
*USE IN osvita
*USE IN nest3
USE IN ff3

use (ff3) NOUPDATE
iff3=TmpDir+'\iff3'
index on nest2+nest3 to (iff3) comp
scan
store 0 to g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13
   wik=year(date())-rr
   g1=1
   
   do case
      case vzvan='��������'.or.left(vstup,1)='�'
           g2=1
      case vzvan='������'.or.left(vstup,1)='�'
           g3=1
   endcase
   if left(zaklosv,1)='*'
           g4=1
   endif
   do case
      case nacion='���.'
           g5=1
      case nacion='���.'
           g6=1
      otherwise
           g7=1
   endcase         
   do case 
      case wik<40
           g8=1
      case wik>=40.and.wik<=49
           g9=1
      case wik>=50.and.wik<=59
           g10=1
      case wik>=60.and.wik<=65
           g11=1
      case wik>65
           g12=1
   endcase
   if (sex='�'.and.wik>60).or.(sex='�'.and.wik>55)
           g13=1
   endif                                           
   
   if pos=2
      i=2
      do nag with i
   else
       i=1
       do nag with i
   endif
   
   if pos=2.and.typkaf='�'
     i=8
      do nag with i
     
   endif
   if pos=2.and.typkaf='�'
     i=3       
      do nag with i
   endif
   if pos=2.and.typkaf='�'
     i=4
      do nag with i
   endif
   if pos=2.and.nest3='����'
     i=5    
     do nag with i
   endif
   if pos=2.and.nest3='���'
     i=6    
     do nag with i
   endif
   if pos=2.and.nest3='ղ�'
     i=7    
     do nag with i
   endif
   if pos=2.and.doplata='�� ������'
      i=1 
       do nag with i
    endif
endscan 
for i=1 to 8
   mp(i,1)=m(i,2)*100/m(i,1)                         
   mp(i,2)=m(i,3)*100/m(i,1)
   mp(i,3)=m(i,4)*100/m(i,1)
   mp(i,4)=m(i,8)*100/m(i,1)   
   mp(i,5)=m(i,9)*100/m(i,1)   
   mp(i,6)=m(i,10)*100/m(i,1)   
   mp(i,7)=m(i,11)*100/m(i,1)   
   mp(i,8)=m(i,12)*100/m(i,1)
   mp(i,9)=m(i,13)*100/m(i,1)
endfor

wait [���������...��� ���������� ������] window nowait ;
     at srows()/2,scols()/2    
oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add
     
SCATTER MEMVAR
oWordDoc1.Content.InsertAfter(padc('�����Ͳ ��Ͳ',135))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(padc('��� �������� � ������ ����� ��������� ��������� � ���.��������� �������',135))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
*oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
*oWordDoc1.Content.InsertAfter(padc('��  01.01.'+STR(YEAR(date()),4),135))
oWordDoc1.Content.InsertAfter(padc('��  01.01.'+ALLTRIM(STR(YEAR(DATE()))),135))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����

oWordDoc1.Content.InsertAfter(replicate('-',135))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter('  ������������  |� |'+space(37)+'|'+space(13)+'�   ���� ���� ��:')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|� |'+replicate('-',37)+'|'+replicate('-',77))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|� |'+space(12)+'����'+space(19)+'|������������� |')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|� |'+replicate('-',37)+'|'+replicate('-',15)+'|'+replicate('-',61))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|� |�������,| ��������.      |� ��.3 �  |���|���| ����  | �� 40   |  40-49  |  50-59  |  60-65  |����� 65 |������. ')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|� |��������.| �������       |���.���. |   |   |       | ����   |  ����  |  ����  |  ����  |  ����  | ��� ')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|  |'+replicate('-',37)+'|'+replicate('-',77))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|  |���|  %  |���|  %  |����.|���|   %  |���|���|������ |���|  %  |���|  %  |���|  %  |���|  %  |���|  %  |���|  %')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|  |���|     |���|     |2�����|���|      |���|���|       |���|     |���|     |���|     |���|     |���|     |���|')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(space(16)+'|  |   |     |   |     |�����.|   |      |   |   |       |   |     |   |     |   |     |   |     |   |     |   |')
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
oWordDoc1.Content.InsertAfter(replicate('-',135))
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����

i=1
for k=1 to 16
m.radok1=c(k)
oWordDoc1.Content.InsertAfter(m.radok1)
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
k=k+1
m.radok2=c(k)+' '+str(m(i,1),3)+str(m(i,2),3)+' '+str(mp(i,1),5,1)+' ';
+str(m(i,3),3)+' '+str(mp(i,2),5,1)+space(8)+str(m(i,4),3)+'  '+str(mp(i,3),5,1);
+' '+str(m(i,5),3)+' '+str(m(i,6),3)+space(4)+str(m(i,7),3)+'  ';
+str(m(i,8),3)+' '+str(mp(i,4),5,1)+' '+str(m(i,9),3)+' '+str(mp(i,5),5,1);
+' '+str(m(i,10),3)+' '+str(mp(i,6),5,1)+' '+str(m(i,11),3)+' ';
+str(mp(i,7),5,1)+' '+str(m(i,12),3)+' '+str(mp(i,8),5,1)+' ';
+str(m(i,13),3)+' '+str(mp(i,9),5,1) 
oWordDoc1.Content.InsertAfter(m.radok2)
i=i+1
oWordDoc1.Content.InsertParagraphAfter && ������� �� ����� �����
endfor
USE

oWord.Selection.EndKey(6) && ��� �� ����� ������
wdPage=7
oWord.Selection.InsertBreak(wdPage) && ʳ���� �������

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
m.f3=FULLPATH('')+'form\'+DTOS(DATE())+'_forma3.doc'
else
m.f3=m.shlyx+'\form\'+DTOS(DATE())+'_forma3.doc'
endif
*=MESSAGEBOX(m.f4)

oWordDoc1.SaveAs(m.f3)



*oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_forma3.doc')

oWord.Visible=.t.

*USE IN zz1
*USE IN zz2
*USE IN iosvita

USE IN doplnad

ERASE iosvita.idx
ERASE osvitad.dbf
ERASE zz1.idx
ERASE zz2.idx
*ERASE ff3

WAIT CLEAR
=MESSAGEBOX([       ������ ����������]+CHR(13)+ ;
			[��� �� ��������� �������� � Word],64,[V K A D R - ����])

proc nag
param i
   m(i,1)=m(i,1)+g1
   m(i,2)=m(i,2)+g2
   m(i,3)=m(i,3)+g3
   m(i,4)=m(i,4)+g4
   m(i,5)=m(i,5)+g5
   m(i,6)=m(i,6)+g6
   m(i,7)=m(i,7)+g7
   m(i,8)=m(i,8)+g8
   m(i,9)=m(i,9)+g9  
   m(i,10)=m(i,10)+g10
   m(i,11)=m(i,11)+g11
   m(i,12)=m(i,12)+g12
   m(i,13)=m(i,13)+g13
RETURN
*CLOSE all

