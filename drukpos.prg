USE shlax NOUPDATE
m.shlyx=ALLTRIM(shlax)
*USE

m.posad=m.shlyx+'\dov\posad'
select nest1+' '+posada+' '+ALLTRIM(STR(pos))+' '+ALLTRIM(STR(rang))+' '+skposad+' '+ALLTRIM(STR(oklad));
       from (m.posad) to file posad.txt  order by nest1,pos noco
       
       