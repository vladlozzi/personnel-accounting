
    select LEFT(c.povnest3,60)+ALLTRIM(a.name1)+' '+ALLTRIM(a.name2)+' '+ALLTRIM(a.name3)+' '+ALLTRIM(d.posada);
           from data\main a,dov\nest3 c,dov\posad d;
       where  (c.nest2#'ясл╡я' and a.nest3=c.nest3)AND(a.nest1=d.nest1 AND a.pos=d.pos);
       to file stat.txt;
       order by a.nest1,a.nest2,a.nest3,a.name1,a.name2,a.name3
   