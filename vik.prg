m.main=m.shlyx+'\data\main'
*m.main='data\main'
select nest2,nest3,alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3)+', '+vstup,;
	   year(DATE())-year(datanar)                      ;
       from(m.main) to file form\vik.txt where potstan AND (nest1='01' OR (nest1='00' AND nest3='ДЕК')) ;
        AND LEFT(vstup,1)='к' AND year(DATE())-year(datanar)<40;         
       order by nest2,nest3,name1 noco 
USE IN main
=messagebox('Дані записані в файлі form\vik.txt ')       
        
	
	
       