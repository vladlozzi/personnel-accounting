m.main=m.shlyx+'\data\main'
*m.main='data\main'
select alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3);
       from(m.main) to file form\kandozvik.txt where potstan AND (nest1='01' OR (nest1='00' AND nest3='ДЕК')) ;
        AND (LEFT(vstup,1)='к' or vzvan='д'); 
        AND INT((CTOD('01.01.2007')-datanar)/365.25)<=40 and stod>=1;         
       order by name1,name2,name3 noco 
USE IN main
=messagebox('Дані записані в файлі form\kandozvik.txt ')