USE shlax NOUPDATE
m.shlyx=ALLTRIM(shlax)

m.nest2=m.shlyx+'\dov\nest2'
select nest1,nest2,ALLTRIM(povnest2) from (m.nest2);
to file nest2.txt order by nest1,nest2 noco
*where nest1='03' to file nest2.txt order by nest1,nest2 noco
