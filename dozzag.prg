m.main=m.shlyx+'\data\main'
*m.main='data\main'
select alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3);
       from(m.main) to file form\dozzag.txt where potstan.and.nest1='01' AND pos=4;
              order by name1,name2,name3 noco 
USE IN main
=messagebox('Дані записані в файлі form\dozzag.txt ')