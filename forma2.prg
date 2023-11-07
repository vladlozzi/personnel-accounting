****************************************************************************
**Зведені дані про кількісний і якісний склад викладачів по кафедрах,ф-тах**
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
k=0
 select a
 ff2=TmpDir+'\ff2'

 m.nest2=m.shlyx+'\dov\nest2' 
 m.nest3=m.shlyx+'\dov\nest3'
 select nest3.nest1,nest3.nest2,nest3.nest3,00 as n,left(nest3.povnest3,80) as nazva,;
        000 as kt,000 as dp,000.0 as dpp,;
        000 as kd,000.0 as kdp,000 as yn,000.0 as ynp,000 as ykr,000 as ros,000 as in,;
        000 as w40,000.0 as wp40,000 as w4049,000.0 as wp4049,000 as w5059,;
        000.0 as wp5059,000 as w6065,000.0 as wp6065,000 as w66,000.0 as wp66,;
        000 as pens,000.0 as pensp;
        from (m.nest3);
        into table (ff2) where (nest3.nest1='00'.and.nest3.nest3='ДИРЕК').or.nest3.nest1='01'.AND.nest3.nest2#'КВП';
        order by nest3.nest2,nest3.nest3  	  
*browse
*USE in nest2
 USE in nest3
 USE in ff2
* CANCEL
 select b
m.main=m.shlyx+'\data\main' 
use (m.main)
 inmain=TmpDir+'\inmain'
 index on nest1+nest2+nest3 to (inmain) comp for potstan.and.nest1='01'.or.(nest1='00'.and.nest3='ДИРЕК')
 *brow
 select c
 m.osvita=m.shlyx+'\data\osvita'
 use (m.osvita)
 inosvita=TmpDir+'\inosvita'
 index on sprava to (inosvita) comp
 select d
 use (m.nest2)
 innest2=Tmpdir+'\innest2'
 index on nest1+nest2 to (innest2) comp for nest1='01' OR (nest2.nest1='00'.and.nest2.nest2='РЕК')
 *brow 
 select a
 use (ff2)
 *brow
 fak=nest2
 np=0
  do while !eof()
 if nest2=fak
 kaf=nest3
 store 0 to g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,;
            g18,g19,g20,g21,g22,wik,msd,mdatanar

 *  browse fields nest2,nest3,name1,nacion,datanar,vstup,vzvan
 select main
 *brow
 scan for nest3=kaf
 sexd=sex
 spravad=sprava
 vstupd=vstup
 vzvand=vzvan
 nac=nacion
 wik=year(date())-year(datanar)
 msd=MONTH(date())
 mdatanar=MONTH(datanar)
 g1=g1+1
 do case
    case wik<40
         g11=g11+1
    case wik>=40.and.wik<=49
         g13=g13+1
    case wik>=50.and.wik<=59
         g15=g15+1
    case wik>=60.and.wik<=65
         g17=g17+1
    case wik>65
         g19=g19+1
 endcase
 if (sexd='ч'.and.wik>60) OR (sexd='ч'.and.wik=60.and.msd>=mdatanar)
         g21=g21+1
 endif
 if (sexd='ж'.and.wik>55) OR (sexd='ж'.and.wik=55.and.msd>=mdatanar)
         g21=g21+1
 endif                 
 if substr(vstupd,1,1)='д'.or.vzvand='професор'
         g2=g2+1
 endif
if (SUBSTR(vstupd,1,1)='к'.and.vzvand='доцент') OR ;
   (SUBSTR(vstupd,1,1)='к'.and.empty(vzvand)) or;
   (SUBSTR(vstupd,1,1)='к'.and.vzvand='ст.н.с') or;
   (empty(vstupd).and.vzvand='доцент')
         g4=g4+1
 ENDIF
                         
 do case
    case nac='укр.'
         g8=g8+1
    case nac='рос.'
         g9=g9+1
    otherwise
         g10=g10+1
  endcase
  select osvita
  go top
  locate for sprava=spravad
  IF NOT FOUND()
	WAIT 'В базі освіта немає даних для справи '+ALLTRIM(spravad) TIMEOUT 10 WINDOW    
  ELSE
  if substr(zaklosv,1,1)='*'
     g6=g6+1
  endif
endif
  endscan
  select ff2
  g3=g2*100/g1                     
  g5=g4*100/g1  
  g7=g6*100/g1
  g12=g11*100/g1
  g14=g13*100/g1
  g16=g15*100/g1
  g18=g17*100/g1
  g20=g19*100/g1
  g22=g21*100/g1
  np=np+1

*DISPLAY MEMORY LIKE g* to file g.txt noconsol
*DISPLAY MEMORY LIKE np to file g.txt ADDITIVE noconsol
*DISPLAY MEMORY LIKE kaf to file g.txt ADDITIVE noconsol 
*MODIFY COMMAND g.txt  
 IF g1>0
  replace n with np,kt with g1,dp with g2,dpp with g3,kd with g4,kdp with g5,;
         yn with g6,ynp with g7,ykr with g8,ros with g9,in with g10,;
         w40 with g11,wp40 with g12,w4049 with g13,wp4049 with g14,;
         w5059 with g15,wp5059 with g16,w6065 with g17,wp6065 with g18,;
         w66 with g19,wp66 with g20,pens with g21,pensp with g22
 ELSE
	WAIT CLEAR 
	=MESSAGEBOX("У базі main немає кафедри "+ALLTRIM(kaf),48,"",10000)
 ENDIF
*browse
store 0 to g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,;
            g18,g19,g20,g21,g22
skip
else
np=0
fak=nest2
endif

enddo   
select ff2
                  
*browse noedit noap node

SELECT nest2
go top
count to kz for nest2#'ВК'
oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add
store 0 to ikt,idp,idpp,ikd,ikdp,iyn,iynp,iykr,iros,iin,i40,ip40,i4049,;
      ip4049,i5059,ip5059,i6065,ip6065,i66,ip66,ipe,ippe 
scan for nest2#'ВК'
fakd=nest2
nfak=povnest2
store 0 to fkt,fdp,fdpp,fkd,fkdp,fyn,fynp,fykr,fros,fin,f40,fp40,f4049,;
      fp4049,f5059,fp5059,f6065,fp6065,f66,fp66,fpe,fppe 
      
SCATTER MEMVAR
oWordDoc1.Content.InsertAfter(padc('ЗВЕДЕНІ ДАНІ',132))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(padc('про кількісний і якісний склад викладачів по кафедрах,факультетах ІФНТУНГ',132))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
*oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
*oWordDoc1.Content.InsertAfter('Підрозділ : '+left(m.nfak,100)+' '+'на  01.01.'+STR(YEAR(date()),4))
oWordDoc1.Content.InsertAfter('Підрозділ : '+left(m.nfak,100)+' '+'на  01.01.'+ALLTRIM(STR(YEAR(DATE()))))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок

oWordDoc1.Content.InsertAfter(replicate('-',137))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(' N |     Найменування   | В |'+space(29)+'|'+space(13)+'У   тому числі по:')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   '+'|'+space(7)+'кафедр'+space(7)+'| с |'+replicate('-',29)+'|'+replicate('-',78))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'| ь |'+space(11)+'освіті'+space(12)+'|національності |')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'| о |'+replicate('-',29)+'|'+replicate('-',15)+'|'+replicate('-',62))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'| г |докторів,|кандидат.|з гр.3 з |укр|рос| інші  | до 40   |  40-49  |  50-59  |  60-65  |понад 65 |пенсійн. ')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'| о |професор.|доцентів |унів.осв.|   |   |       | років   |  років  |  років  |  років  |  років  | віку ')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'|шт.|'+replicate('-',29)+'|'+replicate('-',78))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'|вик|всь|  %  |всь|  %  |всь|  %  |всь|всь|всього |всь|  %  |всь|  %  |всь|  %  |всь|  %  |всь|  %  |всь|  %')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter('   |'+space(20)+'|лад|ого|     |ого|     |ого|     |ого|ого|       |ого|     |ого|     |ого|     |ого|     |ого|     |ого|')
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWordDoc1.Content.InsertAfter(replicate('-',137))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок

select ff2
scan for nest2=fakd

m.radok1=str(n,2)+' '+substr(nazva,1,20)
oWordDoc1.Content.InsertAfter(m.radok1)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
IF LEN(ALLTRIM(nazva))<41
m.radok2=space(4)+substr(nazva,21,20)+' '+str(kt,3)+' '+str(dp,3)+' ';
+str(dpp,5,1)+' '+str(kd,3)+' '+str(kdp,5,1)+' '+str(yn,3)+' '+str(ynp,5,1)+;
' '+str(ykr,3)+' '+str(ros,3)+'  '+str(in,3)+'    '+str(w40,3)+;
' '+str(wp40,5,1)+' '+str(w4049,3)+' '+str(wp4049,5,1)+' '+str(w5059,3)+' ';
+str(wp5059,5,1)+' '+str(w6065,3)+' '+str(wp6065,5,1)+' '+str(w66,3)+' ';
+str(wp66,5,1)+' '+str(pens,3)+' '+str(pensp,5,1)  
oWordDoc1.Content.InsertAfter(m.radok2)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
endif
IF LEN(ALLTRIM(nazva))>40 AND LEN(ALLTRIM(nazva))<60
m.radok2=space(4)+substr(nazva,21,20)
oWordDoc1.Content.InsertAfter(m.radok2)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
m.radok3=space(4)+substr(nazva,41,20)+' '+str(kt,3)+' '+str(dp,3)+' ';
+str(dpp,5,1)+' '+str(kd,3)+' '+str(kdp,5,1)+' '+str(yn,3)+' '+str(ynp,5,1)+;
' '+str(ykr,3)+' '+str(ros,3)+'  '+str(in,3)+'    '+str(w40,3)+;
' '+str(wp40,5,1)+' '+str(w4049,3)+' '+str(wp4049,5,1)+' '+str(w5059,3)+' ';
+str(wp5059,5,1)+' '+str(w6065,3)+' '+str(wp6065,5,1)+' '+str(w66,3)+' ';
+str(wp66,5,1)+' '+str(pens,3)+' '+str(pensp,5,1)  
oWordDoc1.Content.InsertAfter(m.radok3)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
endif
IF LEN(ALLTRIM(nazva))>=60
m.radok2=space(4)+substr(nazva,21,20)
oWordDoc1.Content.InsertAfter(m.radok2)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
m.radok3=space(4)+substr(nazva,41,20)
oWordDoc1.Content.InsertAfter(m.radok3)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
m.radok4=space(4)+substr(nazva,61,20)+' '+str(kt,3)+' '+str(dp,3)+' ';
+str(dpp,5,1)+' '+str(kd,3)+' '+str(kdp,5,1)+' '+str(yn,3)+' '+str(ynp,5,1)+;
' '+str(ykr,3)+' '+str(ros,3)+'  '+str(in,3)+'    '+str(w40,3)+;
' '+str(wp40,5,1)+' '+str(w4049,3)+' '+str(wp4049,5,1)+' '+str(w5059,3)+' ';
+str(wp5059,5,1)+' '+str(w6065,3)+' '+str(wp6065,5,1)+' '+str(w66,3)+' ';
+str(wp66,5,1)+' '+str(pens,3)+' '+str(pensp,5,1)  
oWordDoc1.Content.InsertAfter(m.radok4)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
endif

fkt=fkt+kt
fdp=fdp+dp
fkd=fkd+kd
fyn=fyn+yn
fykr=fykr+ykr
fros=fros+ros
fin=fin+in
f40=f40+w40
f4049=f4049+w4049
f5059=f5059+w5059
f6065=f6065+w6065
f66=f66+w66
fpe=fpe+pens

endscan
fdpp=fdp*100/fkt
fkdp=fkd*100/fkt
fynp=fyn*100/fkt
fp40=f40*100/fkt
fp4049=f4049*100/fkt
fp5059=f5059*100/fkt
fp6065=f6065*100/fkt
fp66=f66*100/fkt
fppe=fpe*100/fkt

ikt=ikt+fkt
idp=idp+fdp
ikd=ikd+fkd
iyn=iyn+fyn
iykr=iykr+fykr
iros=iros+fros
iin=iin+fin
i40=i40+f40
i4049=i4049+f4049
i5059=i5059+f5059
i6065=i6065+f6065
i66=i66+f66
ipe=ipe+fpe
oWordDoc1.Content.InsertAfter(replicate('-',137))
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
m.radok3=space(4)+'Разом:'+space(15)+str(fkt,3)+' '+str(fdp,3)+' ';
+str(fdpp,5,1)+' '+str(fkd,3)+' '+str(fkdp,5,1)+' '+str(fyn,3)+' '+str(fynp,5,1)+;
' '+str(fykr,3)+' '+str(fros,3)+'  '+str(fin,3)+'    '+str(f40,3)+;
' '+str(fp40,5,1)+' '+str(f4049,3)+' '+str(fp4049,5,1)+' '+str(f5059,3)+' ';
+str(fp5059,5,1)+' '+str(f6065,3)+' '+str(fp6065,5,1)+' '+str(f66,3)+' ';
+str(fp66,5,1)+' '+str(fpe,3)+' '+str(fppe,5,1)  
oWordDoc1.Content.InsertAfter(m.radok3)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
k=k+1
if k<kz
oWord.Selection.EndKey(6) && Йти на кінець тексту
wdPage=7
oWord.Selection.InsertBreak(wdPage) && Кінець сторінки
endif
ENDSCAN
idpp=idp*100/ikt
ikdp=ikd*100/ikt
iynp=iyn*100/ikt
ip40=i40*100/ikt
ip4049=i4049*100/ikt
ip5059=i5059*100/ikt
ip6065=i6065*100/ikt
ip66=i66*100/ikt
ippe=ipe*100/ikt
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
m.radok4='Всього по інституту :'+space(4)+str(ikt,3)+' '+str(idp,3)+' ';
+str(idpp,5,1)+' '+str(ikd,3)+' '+str(ikdp,5,1)+' '+str(iyn,3)+' '+str(iynp,5,1)+;
' '+str(iykr,3)+' '+str(iros,3)+'  '+str(iin,3)+'    '+str(i40,3)+;
' '+str(ip40,5,1)+' '+str(i4049,3)+' '+str(ip4049,5,1)+' '+str(i5059,3)+' ';
+str(ip5059,5,1)+' '+str(i6065,3)+' '+str(ip6065,5,1)+' '+str(i66,3)+' ';
+str(ip66,5,1)+' '+str(ipe,3)+' '+str(ippe,5,1)  
oWordDoc1.Content.InsertAfter(m.radok4)
oWordDoc1.Content.InsertParagraphAfter && Перехід на новий рядок
oWord.Selection.EndKey(6) && Йти на кінець тексту
wdPage=7
oWord.Selection.InsertBreak(wdPage) && Кінець сторінки

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
m.f2=FULLPATH('')+'form\'+DTOS(DATE())+'_forma2.doc'
else
m.f2=m.shlyx+'\form\'+DTOS(DATE())+'_forma2.doc'
endif
*=MESSAGEBOX(m.f2)

oWordDoc1.SaveAs(m.f2)


*oWordDoc1.SaveAs(FULLPATH('')+'form\'+DTOS(DATE())+'_forma2.doc')

oWord.Visible=.t.
WAIT CLEAR
=MESSAGEBOX([       Довідка сформована]+CHR(13)+ ;
			[Для її перегляду перейдіть у Word],64,[V K A D R - Інфо])

 use in nest2
 use in osvita
 use in main
 use in ff2
* erase ff2.dbf
  
 
     
