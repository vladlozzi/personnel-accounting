USE shlax NOUPDATE
m.shlyx=ALLTRIM(shlax)

m.nest3=m.shlyx+'\dov\nest3'
select nest1,nest2,nest3,ALLTRIM(povnest3) from (m.nest3);
to file nest3.txt order by nest1,nest2,nest3 noco