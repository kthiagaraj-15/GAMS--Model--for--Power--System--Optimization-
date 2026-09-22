Sets t /t1*t24/, i /g1*g4/, k /1*100/;
table gendata(i,*)
        a       b       c      d        e      f      Pmin      Pmax      RUO      RDO
g1      0.12    14.80   89     1.2      -5     3      28        200       40       40
g2      0.17    16.57   83     2.3      -4.24  6.09   20        290       30       30
g3      0.15    15.55   100    1.1      -2.15  5.69   30        190       30       30
g4      0.19    16.21   70     1.1      -3.99  6.2    20        260       50       50;
Parameter demand(t)
/t1       510
t2        530
t3        516
t4        510
t5        515
t6        544
t7        646
t8        686
t9        741
t10       734
t11       748
t12       760
t13       754
t14       700
t15       686
t16       720
t17       714
t18       761
t19       727
t20       714
t21       618
t22       584
t23       578
t24       544/;
Variables       OF
                p(i,t)
                Pk(i,t,k);
Parameter data(k,i,*);
data(k,i,'DP')=(gendata(i,"Pmax")-gendata(i,"Pmin"))/card(k);
data(k,i,'Pini')=(ord(k)-1)*data(k,i,'DP')+gendata(i,"Pmin");
data(k,i,'Pfin')=data(k,i,'Pini')+data(k,i,'DP');
data(k,i,'Cini')=gendata(i,"a")*power(data(k,i,'Pini'),2)+gendata(i,"b")*data(k,i,'Pini')+gendata(i,"c");
data(k,i,'Cfin')=gendata(i,"a")*power(data(k,i,'Pfin'),2)+gendata(i,"b")*data(k,i,'Pfin')+gendata(i,"c");
data(k,i,'s')=(data(k,i,'Cfin')-data(k,i,'Cini'))/data(k,i,'DP');
p.up(i,t)=gendata(i,"Pmax");
p.lo(i,t)=gendata(i,"Pmin");
Pk.up(i,t,k)=data(k,i,'DP');
Pk.lo(i,t,k)=0;
Equations eq1, eq2, eq3, eq4, eq5;

eq1.. OF=e=sum((t,i), gendata(i,'a')*power(gendata(i,"Pmin"),2)+gendata(i,'b')*gendata(i,"Pmin")+gendata(i,'c')+sum(k,data(k,i,'s')*pk(i,t,k)));

eq2(i,t)..  p(i,t+1)-p(i,t)=l=gendata(i,'RUO');
eq3(i,t)..  p(i,t-1)-p(i,t)=l=gendata(i,'RDO');
eq4(t).. sum(i,p(i,t))=g=demand(t);
eq5(i,t).. p(i,t)=e=gendata(i,"Pmin")+sum(k,Pk(i,t,k));


Model DEDLP /all/;
Solve DEDLP us LP min OF;
