Sets
    bus /1*24/
    t /t1*t24/
    slack(bus) /13/
    Gen /g1*g12/;

Scalar Sbase /100/, VOLL /10000/, VOLW /50/;
alias(bus,node);

Table GD (Gen ,*)
     Pmax    Pmin    b       Qmax    Qmin    Vg      RU  RD
g1   152     30.40   13.32   192     -50     1.035   21  21
g2   152     30.40   13.32   192     -50     1.035   21  21
g3   350     75      20.70   300     0       1.025   43  43
g4   591     206.85  20.93   591     0       1.02    31  31
g5   215     66.25   21      215     -100    1.014   31  31
g6   155     54.25   10.52   155     -50     1.017   31  31
g7   400     100     5.47    400     -50     1.05    70  70
g8   400     100     5.47    400     -50     1.05    70  70
g9   300     0       0       300     -60     1.05    53  53
g10  360     248.50  10.52   310     -125    1.05    31  31;

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
   t1   0.0786666666666667  0.684511335492475
   t2   0.0866666666666667  0.644122690036197
   t3   0.117333333333333   0.6130691560297
   t4   0.258666666666667   0.599733282530006
   t5   0.361333333333333   0.588874071251667
   t6   0.566666666666667   0.5980186702229
   t7   0.650666666666667   0.626786054486569
   t8   0.566666666666667   0.651743189178891
   t9   0.484               0.706039245570585
   t10  0.548               0.787007048961707
   t11  0.757333333333333   0.839016955610593
   t12  0.710666666666667   0.852733854067441
   t13  0.870666666666667   0.870642027052772
   t14  0.932               0.834254143646409
   t15  0.966666666666667   0.816536483139646
   t16  1                   0.819394170318156
   t17  0.869333333333333   0.874071251666984
   t18  0.665333333333333   1
   t19  0.656               0.983615926843208
   t20  0.561333333333333   0.936368832158506
   t21  0.565333333333333   0.887597637645266
   t22  0.556               0.809297008954087
   t23  0.724               0.74585635359116
   t24  0.84                0.733473042484283;

parameter Wcap(bus)
/
8   200
19  150
21  100/;
parameter SOCMax(bus)
/
19  200
21  100/;

scalar eta_c /0.95/, eta_d /0.9/, VWC /50/;

parameter SOC0(bus);
SOC0(bus)=0.2*SOCMax(bus)/Sbase;

branch(bus, node, 'z')$branch(bus, node, 'Limit') = sqrt(power(branch(bus, node, 'x'), 2) + power(branch(bus, node, 'r'), 2));

branch(node, bus, 'theta')$branch(node, bus, 'limit') = arctan(branch(node, bus, 'x') / branch(node, bus, 'r'));

Parameter conex(bus, node);
conex(bus, node)$(branch(bus, node, 'limit') and branch(node, bus, 'limit')) = 1;
conex(bus, node)$(conex(node, bus)) = 1;

Variables
    OF,
    Qij(bus, node, t),
    Pij(bus, node, t),
    Pg(Gen, t),
    Qg(Gen, t),
    delta(bus, t),
    V(bus, t),
    lsh(bus, t),
    Pw(bus, t),
    pwc(bus, t),
    SOC(bus, t),
    Pd(bus, t),
    Pc(bus, t);

Equations
    const1, const2, const2B, const3, const4, const5, const6, const7, const8, constESS;

const1(bus, node, t)$conex(bus, node)..
    Pij(bus, node, t) =e= branch(bus, node, 'bij') * (delta(bus, t) - delta(node, t));

const2(bus, t)..
    lsh(bus, t)$BusData(bus, 'pd') + Pw(bus, t)$Wcap(bus) + sum(Gen$GB(bus, Gen), Pg(Gen, t)) +
    ((Pc(bus, t) + Pd(bus, t))$SOCMAX(bus)) * WD(t, 'd') * BusData(bus, 'pd') / Sbase =e=
    sum(node$conex(node, bus), Pij(bus, node, t));

const2B(bus, t)..
    sum(Gen$GB(bus, Gen), Qg(Gen, t)) * WD(t, 'd') * BusData(bus, 'Qd') / Sbase =e=
    sum(node$conex(node, bus), Qij(bus, node, t));

const3..
    OF =g= sum((bus, Gen, t)$GB(bus, Gen), Pg(Gen, t) * GD(Gen, 'b') * Sbase) +
         sum((bus, t), VOLL * lsh(bus, t) * Sbase$BusData(bus, 'pd') + VOLW * Pwc(bus, t) * Sbase$Wcap(bus));

const4(Gen, t)..
    Pg(Gen, t + 1) - Pg(Gen, t) =l= GD(Gen, 'RU') / Sbase;

const5(Gen, t)..
    Pg(Gen, t - 1) - Pg(Gen, t) =l= GD(Gen, 'RD') / Sbase;

const6(bus, t)$Wcap(bus)..
    pwc(bus, t) =e= WD(t, 'w') * Wcap(bus) / Sbase - pw(bus, t);

constESS(bus, t)$SOCMax(bus)..
    SOC(bus, t) =e= SOC0(bus)$(ord(t) = 1) + SOC(bus, t - 1)$(ord(t) > 1) + Pc(bus, t) * eta_c - Pd(bus, t) / eta_d;

const7(bus, node, t)$conex(bus, node)..
    Pij(bus, node, t) =e=
    V(bus, t) * V(bus, t) * cos(branch(node, bus, 'theta')) / branch(node, bus, 'z') -
    V(bus, t) * V(node, t) * cos(delta(bus, t) - delta(node, t) + branch(node, bus, 'theta')) / branch(node, bus, 'z');

const8(bus, node, t)$conex(bus, node)..
    Qij(bus, node, t) =e=
    V(bus, t) * V(bus, t) * sin(branch(node, bus, 'theta')) / branch(node, bus, 'z') -
    V(bus, t) * V(node, t) * sin(delta(bus, t) - delta(node, t) + branch(node, bus, 'theta')) / branch(node, bus, 'z') -
    branch(node, bus, 'b') * V(bus, t) * V(bus, t) / 2;

Model loadflow /all/;

Pg.lo(Gen, t) = GD(Gen, 'Pmin') / Sbase;
Pg.up(Gen, t) = GD(Gen, 'Pmax') / Sbase;

Qg.lo(Gen, t) = GD(Gen, 'Qmin') / Sbase;
Qg.up(Gen, t) = GD(Gen, 'Qmax') / Sbase;

delta.up(bus, t) = pi / 2;
delta.lo(bus, t) = -pi / 2;
delta.fx(slack, t) = 0;

V.up(bus, t) = 1.05;
V.lo(bus, t) = 0.95;
V.l(bus, t) = 1;

Pij.up(bus, node, t)$(conex(bus, node)) = branch(bus, node, 'Limit') / Sbase;
Pij.lo(bus, node, t)$(conex(bus, node)) = -branch(bus, node, 'Limit') / Sbase;

Qij.up(bus, node, t)$(conex(bus, node)) = branch(bus, node, 'Limit') / Sbase;
Qij.lo(bus, node, t)$(conex(bus, node)) = -branch(bus, node, 'Limit') / Sbase;

lsh.up(bus, t) = WD(t, 'd') * BusData(bus, 'pd') / Sbase;
lsh.lo(bus, t) = 0;

Pw.up(bus, t) = WD(t, 'w') * Wcap(bus) / Sbase;
Pw.lo(bus, t) = 0;

Pwc.up(bus, t) = WD(t, 'w') * Wcap(bus) / Sbase;
Pwc.lo(bus, t) = 0;

SOC.up(bus, t) = SOCmax(bus) / Sbase;
SOC.lo(bus, t) = 0 * SOCmax(bus) / Sbase;
SOC.fx(bus, 't24') = SOC0(bus);

Pc.up(bus, t) = 0.2 * SOCmax(bus) / Sbase;
Pc.lo(bus, t) = 0;

Pd.up(bus, t) = 0.2 * SOCmax(bus) / Sbase;
Pd.lo(bus, t) = 0;

Solve loadflow minimizing OF using nlp;




