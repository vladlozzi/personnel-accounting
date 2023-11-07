m.main='data\main'
select nest2,nest3,alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3)+' ',STR(stod,5,2);
       from(m.main) to file stod.txt where potstan.and.nest1='01' AND stod>1;         
       order by nest2,nest3,name1 noco 
       
        
	
	
       