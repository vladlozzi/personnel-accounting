m.main=m.shlyx+'\data\main'
*m.main='data\main'
select alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3)+' ',STR(stod,5,2);
       from(m.main) to file form\kandb1.txt where potstan.and.(nest1='01'.or.(nest1='00'.and.nest3='ДЕК')); 
       .and.vstup='к'.AND.stod>=1;         
       order by name1,name2,name3 noco 
USE IN main
=messagebox('Дані записані в файлі form\kandb1.txt ')