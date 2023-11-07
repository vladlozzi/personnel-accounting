*PARAM cSprava
*SET
PARAMETERS sprava
SET SAFETY OFF
SET DATE GERMAN
SET CENTURy ON 
USE shlax IN 0 NOUPDATE
SELECT shlax
m.shlyx=ALLTRIM(shlax)
USE
SELECT 0
m.posad=m.shlyx+'\dov\posad'
m.postru=m.shlyx+'\dov\postru'
TmpDir=SYS(2023)
DataDir=m.shlyx+'\DATA'

SELECT 0
forstag=TmpDir+'\forstag'
CREATE TABLE (forstag) (sprava C(18), dvstup D, dzviln D, posada C(30), ;
						nest1 C(2), nest2 C(8), nest3 C(30), place C(8), ;
						zagstag L, corpstag L, npstag L, npstagvnz L, pedstag L, nstag L)

SELECT 0
trudova=DataDir+'\trudova'
trudspr=TmpDir+'\tmp00000'
* Вибір із бази попередньої трудової діяльності
SELECT 'поперед.' AS place, sprava, dvstup, dzviln, postrud AS posada, org AS nest3, ;
		postru.npstag, postru.pedstag, postru.nstag ;
		FROM (trudova),(postru) INTO TABLE (trudspr) ;
		WHERE sprava=m.sprava AND trudova.postrud=postru.posada
USE IN trudova
USE IN tmp00000
USE IN postru
SELECT forstag
APPEND FROM (trudspr)

SELECT 0
prizperm=DataDir+'\prizperm'
prperspr=TmpDir+'\tmp00000'
* Вибір із бази переміщень по службі - основне місце роботи
SELECT 'переміщ.' AS place, sprava, prizperm.nest1, dvstup, dzviln, prizperm.pos AS posada, ;
		posad.pedstag, posad.npstag, posad.nstag ;
		FROM (prizperm),(posad) INTO TABLE (prperspr) ;
		WHERE sprava=m.sprava AND prizperm.nest1=posad.nest1 AND prizperm.pos=posad.posada ;
		AND NOT (prizperm.nest1='04' AND prizperm.odin<0.25)
USE IN prizperm
USE IN tmp00000
SELECT forstag
APPEND FROM (prperspr)

* Вибір із бази переміщень по службі - основне місце роботи (для непедаг. і ненаук. стажу)
SELECT 'переміщ.' AS place, sprava, prizperm.nest1, dvstup, dzviln, prizperm.pos AS posada ;
		FROM (prizperm),(posad) INTO TABLE (prperspr) ;
		WHERE sprava=m.sprava AND prizperm.nest1=posad.nest1 AND prizperm.pos=posad.posada
USE IN prizperm
USE IN tmp00000
SELECT forstag
APPEND FROM (prperspr)

SELECT 0
sumisnyk=DataDir+'\sumisnyk'
sumispr=TmpDir+'\tmp00000'
* Вибір із бази переміщень по службі - внутрішнє сумісництво
SELECT 'сумісн.' AS place, sprava,sumisnyk.nest1, dvstup, dzviln, sumisnyk.posada, ;
         sumisnyk.nest3, posad.pedstag, posad.npstag, posad.nstag ;
		FROM (sumisnyk),(posad) INTO TABLE (sumispr) ;
		WHERE sprava=m.sprava AND sumisnyk.nest1=posad.nest1 ;
			AND sumisnyk.posada=posad.posada AND sumisnyk.odin>=0.25
USE IN sumisnyk
USE IN tmp00000
*USE IN posad

SELECT forstag
APPEND FROM (sumispr)
REPLACE FOR EMPTY(dzviln) dzviln WITH DATE()
REPLACE ALL zagstag WITH .T. && позначка загального стажу
REPLACE FOR 'переміщ.'$place OR 'сумісн.'$place OR ;
	('поперед.'$place AND nest3='*') corpstag WITH .T. && позначка корпоративного стажу
REPLACE FOR ('переміщ.'$place OR 'сумісн.'$place OR ('поперед.'$place AND nest3='*')) AND npstag ;
		npstagvnz WITH .T. && позначка науково-педагогічного стажу в нашому ВНЗ

* BROWSE NOAPPEND NODELETE NOEDIT 

GO TOP
itmp0=TmpDir+'\tmp00000'

* Розрахунок загального трудового стажу
INDEX ON dvstup TO (itmp0) COMPACT FOR zagstag
COUNT TO ic
m.zagstag=IIF(ic>0,fstage(),0)

* Розрахунок педагогічного стажу
INDEX ON dvstup TO (itmp0) COMPACT FOR pedstag
* BROWSE FIELDS dvstup,dzviln,nest1,posada NOEDIT NOAPPEND NODELETE
COUNT TO ic
m.pedstag=IIF(ic>0,fstage(),0)
*=MESSAGEBOX('Пед.стаж, днів - '+STR(m.pedstag,6))

* Розрахунок науково-педагогічного стажу
INDEX ON dvstup TO (itmp0) COMPACT FOR npstag
COUNT TO ic
m.npstag=IIF(ic>0,fstage(),0)

* Розрахунок наукового стажу
INDEX ON dvstup TO (itmp0) COMPACT FOR nstag
COUNT TO ic
m.nstag=IIF(ic>0,fstage(),0)

* Розрахунок науково-педагогічного стажу в нашому ВНЗ 

INDEX ON dvstup TO (itmp0) COMPACT FOR npstagvnz
COUNT TO ic
m.npstagvnz=IIF(ic>0,fstage(),0)

* Розрахунок корпоративного стажу
INDEX ON dvstup TO (itmp0) COMPACT FOR corpstag
COUNT TO ic
m.corpstag=IIF(ic>0,fstage(),0)
USE IN forstag

FUNCTION fstage
*WAIT CLEAR
GO TOP
kilkist=1
IF NOT EMPTY(dvstup)
	datt=dvstup && Початкова дата стажу
	DO WHILE datt<=DATE()
		k=0
		SCAN
			IF NOT EMPTY(dvstup)
				IF k=0 AND BETWEEN(datt,dvstup,dzviln)
					kilkist=kilkist+1
					k=1
				ENDIF
			ELSE
				=MESSAGEBOX('Стаж роботи не може бути нарахований через порожні дати вступу на посаду!'+CHR(10)+ ;
				'Перевірте службові переміщення, трудову діяльність і сумісництво та виправте помилки!',48,'')

			ENDIF
		ENDSCAN
		datt=datt+1
	ENDDO
ELSE
	=MESSAGEBOX('Стаж роботи не може бути нарахований через порожні дати вступу на посаду!'+CHR(10)+ ;
				'Перевірте службові переміщення, трудову діяльність і сумісництво та виправте помилки!',48,'')
ENDIF
*rizn=0
*=MESSAGEBOX('1checkpoint-vxid v cukl-riznuca dniv= '+STR(rizn)+' zagalna syma= '+STR(kilkist)+' data vxodzenn= '+DTOC(datt)+' poc period'+DTOC(dvstup)+' kin period'+DTOC(dzviln))
*	SCAN
*=MESSAGEBOX('2checkpoint-pered emovamu-riznuca dniv= '+STR(rizn)+' zagalna syma= '+STR(kilkist)+' data vxodzenn= '+DTOC(datt)+' poc period'+DTOC(dvstup)+' kin period'+DTOC(dzviln))	
*	IF datt>=dvstup AND datt<dzviln  
*           rizn=dzviln-datt
*		   datt=dzviln
*		   kilkist=kilkist+rizn
*=MESSAGEBOX('3checkpoint-perwa ymova stpracuvala! riznuca dniv= '+STR(rizn)+' zagalna syma= '+STR(kilkist))	
*	ELSE    
*      IF !BOF() 
*           SKIP -1  
*	       ddt=dzviln
*           SKIP 
*           ENDIF 
*       IF (!(datt>=dvstup AND datt<dzviln )AND ddt<dzviln)
*           datt=dvstup
*	       rizn=dzviln-datt+1
*	       kilkist=kilkist+rizn
*	       datt=dzviln
*=MESSAGEBOX('dryga ymova stpracuvala riznuca dniv= '+STR(rizn)+' zagalna syma= '+STR(kilkist))	
*=MESSAGEBOX('4chekpoint-perevirka dat- data vxodzenn= '+DTOC(datt)+' poc period'+DTOC(dvstup)+' kin period= '+DTOC(dzviln)+' poperedn data kin= '+DTOC(ddt))	
*       ENDIF 
*       ENDIF
*    ENDIF  
*=MESSAGEBOX('5checkpoint-riznuca dniv= '+STR(rizn)+' zagalna syma= '+STR(kilkist)+' data vxodzenn= '+DTOC(datt)+' poc period'+DTOC(dvstup)+' kin period'+DTOC(dzviln))	
*	ENDSCAN
*=MESSAGEBOX(STR(kilkist)+' '+STR(kilkist/365.25))

RETURN kilkist