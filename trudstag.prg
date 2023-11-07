*
* ¬изначенн€ трудового стажу
*
LOCAL sprava,stZag,stUn,stNP,stP

* «агальний трудовий стаж (у дн€х)
m.zagstag=0

* Ќеперервний корпоративний стаж (у дн€х)
m.corpstag=0

* Ќауково-педагог≥чний стаж (у дн€х)
m.npstag=0

* ѕедагог≥чний стаж (у дн€х)
m.pedstag=0

* Ќауковий стаж (у дн€х)
m.nstag=0

m.sprava=sprava 

*MESSAGEBOX(m.sprava)

IF NOT EMPTY(m.sprava)
	DO forstag WITH m.sprava
ENDIF

* ѕереведенн€ дн≥в у роки й м≥с€ц≥

m.stzagr=INT(m.zagstag/365.25) && ц≥л≥ роки загального стажу 
m.stzagm=INT((m.zagstag-m.stzagr*365.25)/ROUND(365.25/12,4)) && залишков≥ м≥с€ц≥ загального стажу 
m.stzagr=m.stzagr+IIF(m.stzagm=12,1,0) && уточнен≥ роки
m.stzagm=IIF(m.stzagm=12,0,m.stzagm) && уточнен≥ м≥с€ц≥

m.stunir=INT(m.corpstag/365.25) && ц≥л≥ роки корпоративного стажу 
m.stunim=INT((m.corpstag-m.stunir*365.25)/ROUND(365.25/12,4)) && залишков≥ м≥с€ц≥
m.stunir=m.stunir+IIF(m.stunim=12,1,0) && уточнен≥ роки
m.stunim=IIF(m.stunim=12,0,m.stunim) && уточнен≥ м≥с€ц≥

m.stnpr=INT(m.npstag/365.25) && ц≥л≥ роки науково-педаг. стажу 
m.stnpm=INT((m.npstag-m.stnpr*365.25)/ROUND(365.25/12,4)) && залишков≥ м≥с€ц≥
m.stnpr=m.stnpr+IIF(m.stnpm=12,1,0) && уточнен≥ роки
m.stnpm=IIF(m.stnpm=12,0,m.stnpm) && уточнен≥ м≥с€ц≥

m.stpr=INT(m.pedstag/365.25) && ц≥л≥ роки педагог≥чного стажу
m.stpm=INT((m.pedstag-m.stpr*365.25)/ROUND(365.25/12,4))  && залишков≥ м≥с€ц≥
m.stpr=m.stpr+IIF(m.stpm=12,1,0) && уточнен≥ роки
m.stpm=IIF(m.stpm=12,0,m.stpm) && уточнен≥ м≥с€ц≥

m.stpr=m.stpr+main.peddovr && роки з пед.стажем за дов≥дками
m.stpm=m.stpm+main.peddovm && м≥с€ц≥ з пед.стажем за дов≥дками
m.stpr=m.stpr+IIF(m.stpm>=12,1,0) && уточнен≥ роки
m.stpm=m.stpm-IIF(m.stpm<12,0,12) && уточнен≥ м≥с€ц≥

m.stnr=INT(m.nstag/365.25) && ц≥л≥ роки наукового стажу
m.stnm=INT((m.nstag-m.stnr*365.25)/ROUND(365.25/12,4))  && залишков≥ м≥с€ц≥
m.stnr=m.stnr+IIF(m.stnm=12,1,0) && уточнен≥ роки
m.stnm=IIF(m.stnm=12,0,m.stnm) && уточнен≥ м≥с€ц≥

*=MESSAGEBOX('«агальний:'+ALLTRIM(STR(stzagr))+'р. '+ALLTRIM(STR(stzagm))+'м.')
*=MESSAGEBOX('Ќауково-педагог≥чний:'+ALLTRIM(STR(stnpr))+'р. '+ALLTRIM(STR(stnpm))+'м.')
*=MESSAGEBOX('ѕедагог≥чний: '+ALLTRIM(STR(stpr))+'р. '+ALLTRIM(STR(stpm))+'м.')
*MESSAGEBOX('5')