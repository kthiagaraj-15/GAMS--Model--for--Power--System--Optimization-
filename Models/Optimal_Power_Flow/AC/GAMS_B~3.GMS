Sets
bus /1*24/
slack(bus) /13/
t /t1*t24/
Gen /g1*g10/;
scalars
Sbase /100/
VOLL /10000/
VWC /50/;
alias(bus,node);
Table GD (bus ,*)
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

Set GB(bus,Gen) /
    1  .   g1
    2  .   g2
    7  .   g3
    13 .   g4
    15 .   g5
    16 .   g6
    18 .   g7
    21 .   g8
    22 .   g9
    23 .   g10
/;

Table BusData(bus,*)
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


Table branch(bus,node,*)
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
t6      0.3613333333333330  0.588874071251667
t7      0.3613333333333330  0.588874071251667
t8      0.3613333333333330  0.588874071251667
t9      0.3613333333333330  0.588874071251667
t10     0.548               0.787007048961707
t11     0.548               0.787007048961707
t12     0.548               0.787007048961707
t13     0.548               0.787007048961707
t14     0.548               0.787007048961707
t15     0.548               0.787007048961707
t16     0.548               0.787007048961707
t17     0.548               0.787007048961707
t18     0.548               0.787007048961707
t19     0.548               0.787007048961707
t20     0.561333333333333   0.936368832158506
t21     0.565333333333333   0.887597637645266
t22     0.556               0.809297008954087
t23     0.724               0.74585635359116
t24     0.84                0.733473042484283;


parameter Wcap(bus)
/
8   200
19  150
21  100/;

branch(bus,node,'x')$(branch(bus,node,'x')=0)=branch(node,bus,'x');
branch(bus,node,'r')$(branch(bus,node,'r')=0)=branch(node,bus,'r');

branch(bus,node,'b')$(branch(bus,node,'b')=0)=branch(node,bus,'b');
branch(bus,node,'bij')$branch(bus,node,'Limit')=1/branch(bus,node,'x');

branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0)=branch(node, bus,'Limit');

branch(bus, node, 'z')$branch(bus, node, 'Limit') = sqrt(power(branch(bus, node, 'x'), 2) + power(branch(bus, node, 'r'), 2));

branch(node, bus, 'theta')$branch(node, bus, 'limit') = arctan(branch(node, bus, 'x') / branch(node, bus, 'r'));
branch(node,bus,'th')$branch(bus,node,'Limit')= branch(bus,node,'th')

Parameter conex(bus, node);
conex(bus, node)$(branch(bus, node, 'limit') and branch(node, bus, 'limit')) = 1;
conex(bus, node)$(conex(node, bus)) = 1;

Variables
    OF,
    Pij(bus,node,t),
    Qij(bus,node,t),
    Pg(bus,t),
    Qg(bus,t),
    Va(bus,t),
    V(bus,t),
    Pw(bus,t);

Equations eq1, eq2, eq3, eq4, eq5, eq6, eq7;

eq1(bus,node,t)$conex(bus,node).. Pij(bus,node,t)=e=(V(bus,t)*V(bus,t)*cos(branch(node,bus,'th'))-V(bus,t)*V(node,t)*cos(Va(bus,t)-Va(node,t)+branch(node,bus,'th')))/branch(node,bus,'z');
eq2(bus, node, t)$conex(bus, node) ..
    Qij(bus, node, t) =e= (V(bus, t) * V(bus, t) * sin(branch(node, bus, 'th'))
    - V(bus, t) * V(node, t) * sin(Va(bus, t) - Va(node, t) + branch(node, bus, 'th')))
    / branch(node, bus, 'z')
    - branch(node, bus, 'b') * V(bus, t) * V(bus, t) / 2;

eq3(bus, t) ..
    Pw(bus, t)$Wcap(bus) + Pg(bus, t)$GD(bus, 'Pmax') - WD(t, 'd') * BusData(bus, 'pd') / Sbase
    =e= +sum(node$conex(node, bus), Pij(bus, node, t));

eq4(bus, t) ..
    Qg(bus, t)$GD(bus, 'Qmax') - WD(t, 'd') * BusData(bus, 'qd') / Sbase
    =e= +sum(node$conex(node, bus), Qij(bus, node, t));

eq5 ..
    OF =g= sum((bus, t), Pg(bus, t) * GD(bus, 'b') * Sbase$GD(bus, 'Pmax'));

eq6(bus, t)$(GD(bus, 'Pmax') and ord(t) > 1) ..
    Pg(bus, t) - Pg(bus, t - 1) =l= GD(bus, 'RU') / Sbase;

eq7(bus, t)$(GD(bus, 'Pmax') and ord(t) < card(t)) ..
    Pg(bus, t) - Pg(bus, t + 1) =l= GD(bus, 'RD') / Sbase;

Model loadflow / eq1, eq2, eq3, eq4, eq5, eq6, eq7 /;

Pg.lo(bus, t) = GD(bus, 'Pmin') / Sbase;
Pg.up(bus, t) = GD(bus, 'Pmax') / Sbase;
Qg.lo(bus, t) = GD(bus, 'Qmin') / Sbase;
Qg.up(bus, t) = GD(bus, 'Qmax') / Sbase;

Va.up(bus, t) = pi / 2;
Va.lo(bus, t) = -pi / 2;
Va.l(bus, t) = 0;
Va.fx(slack, t) = 0;

Pij.up(bus, node, t)$(conex(bus, node)) = +1 * branch(bus, node, 'Limit') / Sbase;
Pij.lo(bus, node, t)$(conex(bus, node)) = -1 * branch(bus, node, 'Limit') / Sbase;

Qij.up(bus, node, t)$(conex(bus, node)) = +1 * branch(bus, node, 'Limit') / Sbase;
Qij.lo(bus, node, t)$(conex(bus, node)) = -1 * branch(bus, node, 'Limit') / Sbase;

V.lo(bus, t) = 0.9;
V.up(bus, t) = 1.1;

Pw.up(bus, t) = WD(t, 'd') * Wcap(bus) / Sbase;
Pw.lo(bus, t) = 0;

Solve loadflow minimizing OF using nlp;
