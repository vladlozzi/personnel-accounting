m.main=m.shlyx+'\data\main'
*m.main='data\main'
select alltrim(name1)+' '+alltrim(name2)+' '+alltrim(name3)+' ',STR(stod,5,2);
       from(m.main) to file form\kandzag.txt where potstan AND (nest1='01' OR (nest1='00' AND nest3='���'));
        and vstup='�';         
       order by name1,name2,name3 noco 
USE IN main
=messagebox('��� ������� � ���� form\kandzag.txt ')