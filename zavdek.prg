m.main='data\main'
m.nest3='dov\nest3'
select alltrim(a.name1)+' '+alltrim(a.name2)+' '+alltrim(a.name3)+' ',ALLTRIM(b.povnest3);
       from(m.main) a,(m.nest3) b to file form\zavdek.txt ;
       where a.nest3=b.nest3 AND a.nest1=b.nest1 AND potstan.and.((a.nest1='01' AND a.pos=2) OR (a.nest1='00' AND a.pos=595));
       order by povnest3,name1,name2,name3 noco 
USE IN main
USE IN nest3
=messagebox('Дані записані в файлі form\zavdek.txt ') 