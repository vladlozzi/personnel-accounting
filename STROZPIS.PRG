WAIT [Зачекайте...] WINDOW NOWAIT
True=.t.
False=.f.
wdOrientPortrait=0
wdPrinterDefaultBin=0
wdSectionNewPage=2
wdAlignVerticalTop=0
wdLineSpaceSingle=0
wdAlignParagraphLeft=0
nrow1page=65

dopb=TmpDir+'\dopb'
SELECT 0
 m.main=m.shlyx+'\data\main' 
 m.posad=m.shlyx+'\dov\posad'

SELECT a.nest1,a.nest2,a.nest3,a.pos,b.posada,b.rang,a.vzvan,a.vstup, ;
	SUM(a.stod) AS stod,a.oklad,a.pdopl,a.pnadb ;
	FROM (m.main) A, (m.posad) B ;
	WHERE(a.nest1=b.nest1.AND.a.pos=b.pos) ;
	INTO TABLE (dopb) ORDER BY a.nest1,a.nest2,a.nest3,b.rang ;
	GROUP BY a.nest1,a.nest2,a.nest3,b.posada,a.vzvan,a.vstup,a.oklad,a.pdopl,a.pnadb
USE IN main
USE IN posad
SELECT DopB
*BROWSE NOEDIT NOAPPEND NODELETE
USE
*RETURN
m.nest1=m.shlyx+'\dov\nest1'
USE (m.nest1) IN B NOUP

DEFINE POPUP menu1 FROM 5,60 TO 16,180 TITLE ' Виберіть підрозділ 1-го рівня ' ;
       FOOTER ' Esc - вихід ' PROMPT FIELD b.nest1+'|'+b.povnest1 ;
       FONT "Courier New",11
ON SELECTION POPUP menu1 DO form2 WITH PROMPT()
WAIT CLEAR
ACTIVATE POPUP menu1
*
PROC form2
PARAMETER PROM
IF EMPTY(PROM)
   USE IN nest1
   RETURN
ENDIF

a1=tmpdir+'\indopb'
a2=tmpdir+'\innest2'
a3=tmpdir+'\innest3'
a4=tmpdir+'\innest1'

USE (dopb) IN A NOUP
 m.nest2=m.shlyx+'\dov\nest2'
 m.nest3=m.shlyx+'\dov\nest3'

USE (m.nest2) IN C NOUP
USE (m.nest3) IN D NOUP

SELE B
INDEX ON nest1 TO (a4) COMP
SELE C
INDEX ON nest2 TO (a2) COMP
SELE D
INDEX ON nest3 TO(a3) COMP
SELE A
INDEX ON ' ' TO (a1) COMP FOR nest1=LEFT(PROM,2)

DIMENSION K1(6),K2(6),K3(6)

*BROWSE

oWord=CreateObject('Word.Application')
oWordDoc1=oWord.Documents.Add

? 'ШТАТHИЙ РОЗПИС'
? ''
? 'Івано-Франківського національного технічного університету нафти і газу' AT 5
pr=1
DO druk

SET RELATION TO nest2 INTO C

DO WHILE nest1=LEFT(prom,2)
   dep2=nest2
   
   IF STR>60
      ? CHR(12)
      DO druk
   ENDIF

      ? LEFT(c.povnest2,75) AT 1
      STR=STR+1
      IF SUBSTR(c.povnest2,76,2)#'  '
         ? SUBSTR(c.povnest2,76,75) AT 1
         STR=STR+1
      ENDIF

   IF STR>60
      ? CHR(12)
      DO druk
   ENDIF
   ? ' '
   STR=STR+1
   DO WHILE dep2=nest2.AND.!EOF()
      IF a.nest3#dep3
         SET RELATION TO nest3 INTO D
         IF kposp#0
            IF STR>60
               ? CHR(12)
               DO druk
            ENDIF
            ? ' '
            STR=STR+1
            IF STR>60
               ? CHR(12)
               DO druk
            ENDIF
            ? 'Всього:' AT 24
            ?? kposp PICT '99.99' AT 31
            ?? oklp PICT '9999.99' AT 60
            ?? oklzp PICT '99999.99' AT 68
            STR=STR+1
            STORE 0 TO kposp,oklp,oklzp
            IF nest1='01'
               FOR i=1 TO 6
                  IF kp(i)#0
                     IF STR>60
                        ? CHR(12)
                        DO druk
                     ENDIF
                     ? mpos(i) AT 17
                     ?? kp(i) PICT'99.99' AT 31
                     STR=STR+1
                  ENDIF
               ENDFOR
               ? ' '
               STR=STR+1
            ENDIF
            STORE 0 TO kposp,oklp,oklzp,kp
            
         ENDIF
         IF STR>60
            ? CHR(12)
            DO druk
         ENDIF
         ? LEFT(d.povnest3,120) AT 1
         STR=STR+1
         IF SUBSTR(d.povnest3,121,2)#' '
            ? SUBSTR(d.povnest3,121,60)
            STR=STR+1
         ENDIF
      ENDIF
      dep3=a.nest3
      pos=a.posada
      stup=a.v_stup
      zvan=a.v_zvan
      dop=a.dopl
      nad=a.nadb
      
      SCAN WHILE (posada=pos.AND.v_stup=stup.AND.v_zvan=zvan.AND.dopl=dop.AND.nadb=nad)
         oklz=(a.pos_oklad*a.dopl/100)+(a.pos_oklad*a.nadb/100)+(a.pos_oklad*a.k_pos)
         K(1)=IIF(!EMPTY(a.k_pos),K(1)+a.k_pos,K(1))
         K(2)=a.pos_oklad
         K(3)=a.dopl
         K(4)=a.nadb
         K(5)=K(5)+(a.k_pos*a.pos_oklad)
         K(6)=K(6)+oklz
         N=1
         DO WHILE N<=7
            IF a.posada=mpos(N)
               kp(N)=kp(N)+a.k_pos
               EXIT
            ENDIF
            N=N+1
         ENDDO
         kp(6)=kp(6)+kp(7)
      ENDSCAN
      
      kposp=kposp+K(1)
      oklp=oklp+K(5)
      oklzp=oklzp+K(6)
      kposz=kposz+K(1)
      oklzz=oklzz+K(6)
      IF STR>60
         ? CHR(12)
         DO druk
      ENDIF
      
      ? LEFT(ALLTRIM(pos)+' '+ALLTRIM(stup)+' '+ALLTRIM(zvan),30) AT 1
      ?? IIF (K(1)#0,TRANSFORM(K(1),'99.99'),SPACE(5)) AT 31
      ?? K(2) PICT '9999.99' AT 39
      ?? IIF(K(3)#0,TRANSFORM(K(3),'99'),SPACE(4)) AT 49
      ?? IIF(K(4)#0,TRANSFORM(K(4),'99'),SPACE(4)) AT 55
      ?? K(5) PICT '9999.99' AT 60
      ?? K(6) PICT '9999.99' AT 69
      STR=STR+1
      STORE 0 TO K
   ENDDO
   
   IF STR>60
      ? CHR(12)
      DO druk
   ENDIF

   ? 'Всього:' AT 24
   ?? kposp PICT '999.99' AT 31
   ?? oklp PICT '9999.99' AT 60
   ?? oklzp PICT '99999.99' AT 68
   STR=STR+1
   IF nest1='01'
      FOR i=1 TO 6
         IF kp(i)#0
            IF STR>60
               ? CHR(12)
               DO druk
            ENDIF
            ? mpos(i) AT 17
            ?? kp(i) PICT'99.99' AT 31
            STR=STR+1
         ENDIF
      ENDFOR
      ? ' '
      STR=STR+1
   ENDIF
   STORE 0 TO kposp,oklp,oklzp,kp
ENDDO

?  'Разом:' AT 24
?? kposz PICT '999.99' AT 31
?? oklzz PICT '999999.99' AT 67
? CHR(12)

SET PRINTER TO
DEFINE WINDOW ff FROM 1,1 TO 24,78 TITLE ' Дані знаходяться в файлі .\FORM\FORMA2.TXT ';
       FOOTER ' CTRL+W - ВИХIД ' 
MODIFY COMMAND .\FORM\FORMA2.TXT WINDOW ff NOEDIT
RELEASE WINDOW ff
m.form=m.shlyx+'\form\'
SET PRINTER TO m.form+'forma2.txt' ADDITIVE
RETURN

PROC druk
('---------------------------------------------------------------------------')
('|                             |      |       |     |     |  Місячний фонд |')
('|                             |К-ть  |Посадо-|     |     |заробітної плати|')
('|        Hазва  посади        |штатн.|вий    | До- | Над-|----------------|')
('|                             |один. |оклад, |плата|бавка|за посад.|разом |')
('|                             |      |грн.   |  %  |  %  |окладом, |в грн.|')
('|                             |      |       |     |     |грн.     |      |')
('---------------------------------------------------------------------------')
RETURN
