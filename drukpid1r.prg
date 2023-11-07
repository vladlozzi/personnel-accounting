USE shlax NOUPDATE
m.shlyx=ALLTRIM(shlax)

m.nest1=m.shlyx+'\dov\nest1'
select nest1,ALLTRIM(povnest1) from (m.nest1);
to file nest1.txt order by nest1 noco
*where nest1='03' to file nest2.txt order by nest1,nest2 noco
