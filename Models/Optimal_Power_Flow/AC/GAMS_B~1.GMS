Sets
i /1*24/
slack(i) /13/
t /t1*t24/
GB(i) /1,2,7,15,16,18,21*23/;
scalars
Sbase /100/
VOLL /10000/
VWC /50/;
alias(i,j);
Table GenData (i ,*)
    Pmax    Pmin    b       Qmax    Qmin    Vg      RU  RD   
1   152     30.40   13.32   192     -50     1.035   21  21
2   152     30.40   13.32   192     -50     1.035   21  21
7   350     75      20.70   300     0       1.025   43  43
13  591     206.85  20.93   591     0       1.02    31  31
15  215     66.25   21      215     -100    1.014   31  31
16  155     54.25   10.52   155     -50     1.017   31  31
18  400     100     5.47    400     -50     1.05    70  70
21  400     100     5.47    400     -50     1.05    70  70
22  300     0       0       300     -60     1.05    53  53
23  360     248.50  10.52   310     -125    1.05    31  31;

Table BusData(i,*)
        Pd      Qd
1       108     22
2       97      20
3       180     37
4       74      15
5       71      14
6       136     28
7       125     25
8       171     35
9       175     36
10      195     40
11      0       0
12      0       0
13      265     54
14      194     39
15      317     64
16      100     20
17      0       0
18      333     68
19      181     37
20      128     26
21      0       0
22      0       0
23      0       0
24      0       0;


Table branch(i,j,*)
            r       x       b       limit
1   .   2   0.0026  0.0139  0.4611  500
1   .   3   0.0546  0.2112  0.0572  500
1   .   5   0.0218  0.0845  0.0229  500
2   .   4   0.0328  0.1267  0.0343  500
2   .   6   0.0497  0.192   0.052   500
3   .   9   0.0308  0.119   0.0322  500
3   .   24  0.0023  0.0839  0.0     1000
4   .   9   0.0268  0.1037  0.0281  175
5   .   10  0.0228  0.0883  0.0239  175
6   .   10  0.0139  0.0605  2.459   500
7   .   8   0.0159  0.0614  0.0166  500
8   .   9   0.0427  0.1651  0.0447  175
8   .   10  0.0427  0.1651  0.0447  175
9   .   11  0.0023  0.0839  0.0     1000
9   .   12  0.0023  0.0839  0.0     400
10  .   11  0.0023  0.0839  0.0     400
10  .   12  0.0023  0.0839  0.0     1000
11  .   13  0.0061  0.0476  0.0999  1000
11  .   14  0.0054  0.0418  0.0879  500
12  .   13  0.0061  0.0476  0.0999  500
12  .   23  0.0124  0.0966  0.203   1000
13  .   23  0.0111  0.0865  0.1818  500
14  .   16  0.005   0.0389  0.0818  1000
15  .   16  0.0022  0.0173  0.0364  1000
15  .   21  0.00315 0.0245  0.206   1000
15  .   24  0.0067  0.0519  0.1091  500
16  .   17  0.0033  0.0259  0.0545  1000
16  .   19  0.0030  0.0231  0.0485  1000
17  .   18  0.0018  0.0144  0.0303  1000
17  .   22  0.0135  0.1053  0.2212  1000
18  .   21  0.00165 0.01295 0.1090  1000
19  .   20  0.00255 0.01980 0.1666  1000
20  .   23  0.0012  0.0108  0.0910  1500
21  .   22  0.0087  0.0678  0.1424  1000;

Table   WD(t,*)
        w                   d
t1      0.0786666666666667  0.684511335492475
t2      0.0866666666666667  0.644122690036197
t3      0.1173333333333330  0.613069156029720
t4      0.2586666666666670  0.599733282530006
t5      0.3613333333333330  0.588874071251667
t6      0                   0
t7      0                   0
t8      0                   0
t9      0                   0
t10     0.548               0.787007048961707
t11     0                   0
t12     0                   0
t13     0                   0
t14     0                   0
t15     0                   0
t16     0                   0
t17     0                   0
t18     0                   0
t19     0                   0
t20     0.561333333333333   0.936368832158506
t21     0.565333333333333   0.887597637645266
t22     0.556               0.809297008954087
t23     0.724               0.74585635359116
t24     0.84                0.733473042484283;

parameter Wcap(i)
/
8   200
19  150
21  100/;

branch(i,j,'x')$(branch(i,j,'x')=0)=branch(j,i,'x');
branch(i,j,'r')$(branch(i,j,'r')=0)=branch(j,i,'r');

branch(i,j,'b')$(branch(i,j,'b')=0)=branch(j,i,'b');
branch(i,j,'bij')$branch(i,j,'Limit')=1/branch(i,j,'x');

branch(i,j,'Limit')$(branch(i,j,'Limit')=0)=branch(j, i,'Limit');

branch(i,j,'z')$branch(i,j,'Limit')=sqrt(power(branch(i,j,'x'),2)+power(branch(i,j,'r'),2));
branch(j,i,'z')$(branch(i,j,'z')=0)=branch(i,j,'z');

branch(i,j,'th')$(branch(i,j,'Limit') and branch(i,j,'x') and branch(i,j,'r'))=arctan(branch(i,j,'x')/branch(i,j,'r'));

branch(i,j,'th')$(branch(i,j,'Limit') and branch(i,j,'x') and branch(i,j,'r')=0)=pi/2;
branch(i,j,'th')$(branch(i,j,'Limit') and branch(i,j,'r') and branch(i,j,'x')=0)= 0;

branch(j,i,'th')$branch(i,j,'Limit')= branch(i,j,'th');

Parameter cx(i, j);
cx(i,j)$(branch(i,j,'Limit') and branch(j,i,'Limit'))=1;
cx(i,j)$(cx(j,i))=1;

Variables 
    OF, 
    Pij(i,j,t), 
    Qij(i,j,t), 
    Pg(i,t), 
    Qg(i,t), 
    Va(i,t), 
    V(i,t), 
    Pw(i,t);

Equations eq1, eq2, eq3, eq4, eq5, eq6, eq7;

eq1(i,j,t)$cx(i,j).. Pij(i,j,t)=e=(V(i,t)*V(i,t)*cos(branch(j,i,'th'))-V(i,t)*V(j,t)*cos(Va(i,t)-Va(j,t)+branch(j,i,'th')))/branch(j,i,'z');
eq2(i, j, t)$cx(i, j) ..
    Qij(i, j, t) =e= (V(i, t) * V(i, t) * sin(branch(j, i, 'th')) 
    - V(i, t) * V(j, t) * sin(Va(i, t) - Va(j, t) + branch(j, i, 'th')))
    / branch(j, i, 'z')
    - branch(j, i, 'b') * V(i, t) * V(i, t) / 2;

eq3(i, t) ..
    Pw(i, t)$Wcap(i) + Pg(i, t)$GenData(i, 'Pmax') - WD(t, 'd') * BusData(i, 'pd') / Sbase
    =e= +sum(j$cx(j, i), Pij(i, j, t));

eq4(i, t) ..
    Qg(i, t)$GenData(i, 'Qmax') - WD(t, 'd') * BusData(i, 'qd') / Sbase
    =e= +sum(j$cx(j, i), Qij(i, j, t));

eq5 ..
    OF =g= sum((i, t), Pg(i, t) * GenData(i, 'b') * Sbase$GenData(i, 'Pmax'));

eq6(i, t)$(GenData(i, 'Pmax') and ord(t) > 1) ..
    Pg(i, t) - Pg(i, t - 1) =l= GenData(i, 'RU') / Sbase;

eq7(i, t)$(GenData(i, 'Pmax') and ord(t) < card(t)) ..
    Pg(i, t) - Pg(i, t + 1) =l= GenData(i, 'RD') / Sbase;

Model loadflow / eq1, eq2, eq3, eq4, eq5, eq6, eq7 /;

Pg.lo(i, t) = GenData(i, 'Pmin') / Sbase;
Pg.up(i, t) = GenData(i, 'Pmax') / Sbase;
Qg.lo(i, t) = GenData(i, 'Qmin') / Sbase;
Qg.up(i, t) = GenData(i, 'Qmax') / Sbase;

Va.up(i, t) = pi / 2;
Va.lo(i, t) = -pi / 2;
Va.l(i, t) = 0;
Va.fx(slack, t) = 0;

Pij.up(i, j, t)$(cx(i, j)) = +1 * branch(i, j, 'Limit') / Sbase;
Pij.lo(i, j, t)$(cx(i, j)) = -1 * branch(i, j, 'Limit') / Sbase;

Qij.up(i, j, t)$(cx(i, j)) = +1 * branch(i, j, 'Limit') / Sbase;
Qij.lo(i, j, t)$(cx(i, j)) = -1 * branch(i, j, 'Limit') / Sbase;

V.lo(i, t) = 0.9;
V.up(i, t) = 1.1;

Pw.up(i, t) = WD(t, 'd') * Wcap(i) / Sbase;
Pw.lo(i, t) = 0;

Solve loadflow minimizing OF using nlp;
