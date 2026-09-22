Sets
bus /1*24/
slack(bus) /13/
Gen /g1*g12/;
Scalar
Sbase /100/;
alias(bus,node);
Table GenData (Gen ,*)
         Pmax    Pmin    b       Qmax    Qmin    Vg      RU  RD
g1       152     30.40   13.32   192     -50     1.035   21  21
g2       152     30.40   13.32   192     -50     1.035   21  21
g3       350     75      20.70   300     0       1.025   43  43
g4       591     206.85  20.93   591     0       1.02    31  31
g5       215     66.25   21      215     -100    1.014   31  31
g6       155     54.25   10.52   155     -50     1.017   31  31
g7       400     100     5.47    400     -50     1.05    70  70
g8       400     100     5.47    400     -50     1.05    70  70
g9       300     0       0       300     -60     1.05    53  53
g10      360     248.50  10.52   310     -125    1.05    31  31;

set GBconect(bus,Gen)
/
18  .   g1
21  .   g2
1   .   g3
2   .   g4
15  .   g5
16  .   g6
23  .   g7
7   .   g8
13  .   g9
22  .   g10/;


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

parameter conex(bus,node);
conex(bus,node)$branch(bus,node,'limit')=1;
conex(bus,node)$(conex(node,bus))=1;
branch(bus,node,'x')$(branch(bus,node,'x')=0)=branch(node,bus,'x');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0)=branch(node,bus,'Limit');
branch(bus,node,'bij')$conex(bus,node)=1/branch(bus,node,'x');
Variables
OF
Pij(bus,node)
Pg(Gen)
delta(bus);
Equations const1,const2,const3;
const1(bus,node)$conex(bus,node)..  Pij(bus,node)=e=branch(bus,node,'bij')*(delta(bus)-delta(node));
const2(bus)..   +sum(Gen$GBconect(bus,Gen),Pg(Gen))-BusData(bus,'Pd')/Sbase=e=+sum(node$conex(node,bus),Pij(bus,node));
const3..    OF=g=sum(Gen,Pg(Gen)*GenData(Gen,'b')*Sbase);
Model loadflow /const1,const2,const3/;
Pg.lo(Gen)=GenData(Gen,'Pmin')/Sbase;
Pg.up(Gen)=GenData(Gen,'Pmax')/Sbase;
delta.up(bus)=pi/2;
delta.lo(bus)=-pi/2;
delta.fx(slack)=0;
Pij.up(bus,node)$((conex(bus,node)))=1*branch(bus,node,'Limit')/Sbase;
Pij.up(bus,node)$((conex(bus,node)))=-1*branch(bus,node,'Limit')/Sbase;
Solve loadflow minimizing OF using lp;








