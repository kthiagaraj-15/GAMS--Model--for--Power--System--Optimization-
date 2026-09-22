Set
   bus        / 1*24   /
   slack(bus) / 13     /
   Gen        / g1*g3 /
   t          / t1*t24 /;

Scalar
   Sbase /   100 /
   VOLL  / 10000 /
   VOLW  /    50 /
   VOLS  /    40 /;

Alias (bus,node);

Table GD(Gen,*) 'generating units characteristics'
        Pmax Pmin   b     Qmax   Qmin   Vg      RU   RD
   g1   400  0      5.47  1000   -150   1.02    70   70
   g2   400  0      5.47  1000   -150   1.05    70   70
   g3   591  0      20.93 1055   -235   1.05    31   31;
* -----------------------------------------------------

Set GB(bus,Gen) 'connectivity index of each generating unit to each bus'
/
   18.g1
   21.g2
   13.g3
/;

Table BusData(bus,*) 'demands of each bus in MW'
       Pd   Qd
   1   108  22
   2   97   20
   3   180  37
   4   74   15
   5   71   14
   6   136  28
   7   125  25
   8   171  35
   9   175  36
   10  195  40
   13  265  54
   14  194  39
   15  317  64
   16  100  20
   18  333  68
   19  181  37
   20  128  26
   21  0    0
   22  0    0
   23  0    0
   24  0    0;
****************************************************

Table branch(bus,node,*)
          r        x        b       limit
   1 .2   0.0026   0.0139   0.4611  175
   1 .3   0.0546   0.2112   0.0572  175
   1 .5   0.0218   0.0845   0.0229  175
   2 .4   0.0328   0.1267   0.0343  175
   2 .6   0.0497   0.192    0.052   175
   3 .9   0.0308   0.119    0.0322  175
   3 .24  0.0023   0.0839   0       1000
   4 .9   0.0268   0.1037   0.0281  175
   5 .10  0.0228   0.0883   0.0239  175
   6 .10  0.0139   0.0605   2.459   175
   7 .8   0.0159   0.0614   0.0166  500
   8 .9   0.0427   0.1651   0.0447  175
   8 .10  0.0427   0.1651   0.0447  175
   9 .11  0.0023   0.0839   0       400
   9 .12  0.0023   0.0839   0       400
   10.11  0.0023   0.0839   0       400
   10.12  0.0023   0.0839   0       400
   11.13  0.0061   0.0476   0.0999  500
   11.14  0.0054   0.0418   0.0879  500
   12.13  0.0061   0.0476   0.0999  500
   12.23  0.0124   0.0966   0.203   500
   13.23  0.0111   0.0865   0.1818  500
   14.16  0.005    0.0389   0.0818  500
   15.16  0.0022   0.0173   0.0364  500
   15.21  0.00315  0.0245   0.206   1000
   15.24  0.0067   0.0519   0.1091  500
   16.17  0.0033   0.0259   0.0545  500
   16.19  0.003    0.0231   0.0485  500
   17.18  0.0018   0.0144   0.0303  500
   17.22  0.0135   0.1053   0.2212  500
   18.21  0.00165  0.01295  0.109   1000
   19.20  0.00255  0.0198   0.1666  1000
   20.23  0.0014   0.0108   0.091   1000
   21.22  0.0087   0.0678   0.1424  500 ;
* ----------------------------------------------

Table WD(t,*)
        w                   d                    s
   t1   0.3786666666666667  0.484511335492475    0
   t2   0.4866666666666667  0.444122690036197    0
   t3   0.517333333333333   0.41306915602972     0
   t4   0.658666666666667   0.599733282530006    0
   t5   0.761333333333333   0.588874071251667    0
   t6   0.866666666666667   0.5980186702229      0
   t7   0.850666666666667   0.626786054486569    0
   t8   0.766666666666667   0.851743189178891    .40
   t9   0.784               0.806039245570585    .50
   t10  0.648               0.987007048961707    .70
   t11  0.557333333333333   0.939016955610593    .80
   t12  0.410666666666667   0.952733854067441    .85
   t13  0.370666666666667   0.970642027052772    .90
   t14  0.332               0.834254143646409    .95
   t15  0.466666666666667   0.816536483139646    .95
   t16  0.58                0.819394170318156    .95
   t17  0.599333333333333   0.874071251666984    .95
   t18  0.665333333333333   1                    .90
   t19  0.656               0.983615926843208    .80
   t20  0.861333333333333   0.936368832158506    .75
   t21  0.865333333333333   0.887597637645266    0
   t22  0.856               0.809297008954087    0
   t23  0.724               0.54585635359116     0
   t24  0.74                0.533473042484283    0;

Parameter
   Wcap(bus)   / 1 200, 2 200, 7 350, 15 200, 16 200, 22  100 /
   Scap(bus)   / 8 200, 19  150, 23 500 /
   SOCMax(bus) / 1 300, 2 300, 7 380, 8 300, 15 300, 16 300, 19 250, 22  280, 23 340 /;

Scalar
   eta_c /  0.95 /
   eta_d /  0.9  /
   VWC   / 50    /;

Parameter SOC0(bus);
SOC0(bus) = 0.2*SOCMax(bus)/sbase;

branch(bus,node,'x')$(branch(bus,node,'x')=0)         = branch(node,bus,'x');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0) = branch(node,bus,'Limit');
branch(bus,node,'bij')$branch(bus,node,'Limit')       = 1/branch(bus,node,'x');
branch(bus,node,'z')$branch(bus,node,'Limit')         = sqrt(sqr(branch(bus,node,'x')) + sqr(branch(bus,node,'r')));
branch(node,bus,'z')                                  = branch(bus,node,'z');
branch(node, bus, 'theta')$(branch(node, bus, 'limit') and branch(node,bus,'x') and branch(node,bus,'r')) = arctan(branch(node,bus,'x')/branch(node,bus,'r'));

Parameter conex(bus,node);
conex(bus,node)$(branch(bus,node,'limit') and branch(node,bus,'limit')) = 1;
conex(bus,node)$(conex(node,bus)) = 1;

Variable OF, Pij(bus,node,t), Qij(bus,node,t), Pg(Gen,t),Qg(Gen,t), delta(bus,t), V(bus,t), lsh(bus,t), Pw(bus,t), pwc(bus,t), SOC(bus,t), Pd(bus,t), Pc(bus,t), Psol(bus,t), swc(bus,t);
Equation const2, const2B, const3, const4, const5, const6, constESS, const7, const8, const9;


const2(bus,t)..
      lsh(bus,t)$BusData(bus,'pd') + Pw(bus,t)$Wcap(bus)+Psol(bus,t)$Scap(bus)
   +  sum(Gen$GB(bus,Gen), Pg(Gen,t)) + (-Pc(bus,t)+Pd(bus,t))$SOCMAX(bus) - WD(t,'d')*BusData(bus,'pd')/Sbase
  =e= sum(node$conex(node,bus), Pij(bus,node,t));

const2B(bus,t)..
        sum(Gen$GB(bus,Gen),Qg(Gen,t))-WD(t,'d')*BusData(bus,'Qd')/Sbase =e= +sum(node$conex(node,bus),Qij(bus,node,t));

const3..
   OF =g= sum((bus,Gen,t)$GB(bus,Gen), Pg(Gen,t)*GD(Gen,'b')*Sbase)
       +  sum((bus,t), VOLL*lsh(bus,t)*Sbase$BusData(bus,'pd') + VOLW*Pwc(bus,t)*sbase$Wcap(bus)+VOLS*swc(bus,t)*sbase$Scap(bus));

const4(gen,t)..           pg(gen,t+1) - pg(gen,t) =l= GD(gen,'RU')/Sbase;
const5(gen,t)..           pg(gen,t-1) - pg(gen,t) =l= GD(gen,'RD')/Sbase;
const6(bus,t)$Wcap(bus).. pwc(bus,t) =e= WD(t,'w')*Wcap(bus)/Sbase - pw(bus,t);
const7(bus,t)$Scap(bus).. swc(bus,t) =e= WD(t,'s')*Scap(bus)/Sbase - Psol(bus,t);

constESS(bus,t)$SOCMax(bus).. SOC(bus,t) =e= SOC0(bus)$(ord(t)=1) + SOC(bus,t-1)$(ord(t)>1) + Pc(bus,t)*eta_c - Pd(bus,t)/eta_d;

const8(bus,node,t)$conex(bus,node)..    Pij(bus,node,t) =e= V(bus,t)*V(bus,t)*cos(branch(node,bus,'theta'))/branch(node,bus,'z')-V(bus,t)*V(node,t)*cos(delta(bus,t)-delta(node,t)+branch(node,bus,'theta'))/branch(node,bus,'z');

const9(bus,node,t)$conex(bus,node)..    Qij(bus,node,t) =e= V(bus,t)*V(bus,t)*sin(branch(node,bus,'theta'))/branch(node,bus,'z')-V(bus,t)*V(node,t)*sin(delta(bus,t)-delta(node,t)+branch(node,bus,'theta'))/branch(node,bus,'z');

Model loadflow / all /;

Pg.lo(Gen,t)      = GD(Gen,'Pmin')/Sbase;
Pg.up(Gen,t)      = GD(Gen,'Pmax')/Sbase;
Qg.lo(Gen,t)      = GD(Gen,'Qmin')/Sbase;
Qg.up(Gen,t)      = GD(Gen,'Qmax')/Sbase;
delta.up(bus,t)   = pi/2;
delta.lo(bus,t)   =-pi/2;
delta.fx(slack,t) = 0;

V.up(bus,t)       = 1.05;
V.lo(bus,t)       = 0.95;
V.l(bus,t)        = 1;

Pij.up(bus,node,t)$((conex(bus,node))) = 1*branch(bus,node,'Limit')/Sbase;
Pij.lo(bus,node,t)$((conex(bus,node))) =-1*branch(bus,node,'Limit')/Sbase;
Qij.up(bus,node,t)$((conex(bus,node))) = 1*branch(bus,node,'Limit')/Sbase;
Qij.lo(bus,node,t)$((conex(bus,node))) =-1*branch(bus,node,'Limit')/Sbase;
lsh.up(bus,t) = WD(t,'d')*BusData(bus,'pd')/Sbase;
lsh.lo(bus,t) = 0;
Pw.up(bus,t)  = WD(t,'w')*Wcap(bus)/Sbase;
Pw.lo(bus,t)  = 0;
Pwc.up(bus,t) = WD(t,'w')*Wcap(bus)/Sbase;
Pwc.lo(bus,t) = 0;
Psol.up(bus,t)  = WD(t,'s')*Scap(bus)/Sbase;
Psol.lo(bus,t)  = 0;
Swc.up(bus,t) = WD(t,'s')*Scap(bus)/Sbase;
Swc.lo(bus,t) = 0;

SOC.up(bus,t)     = SOCmax(bus)/sbase;
SOC.lo(bus,t)     = 0*SOCmax(bus)/sbase;
SOC.fx(bus,'t24') = SOC0(bus);

Pc.up(bus,t) = 0.2*SOCmax(bus)/sbase;
Pc.lo(bus,t) = 0;
Pd.up(bus,t) = 0.2*SOCmax(bus)/sbase;
Pd.lo(bus,t) = 0;

solve loadflow minimizing OF using nlp;


Parameter report(t,bus,*), Congestioncost, lmp(bus,t), report2(bus,t,*);
report(t,bus,'Gen(MW)') = 1*sum(Gen$GB(bus,Gen), Pg.l(Gen,t))*sbase;
report(t,bus,'Gen(MVAR)') = 1*sum(Gen$GB(bus,Gen), Qg.l(Gen,t))*sbase;
report(t,bus,'Pd')      = Pd.l(bus,t)*sbase;
report(t,bus,'Pc')      = Pc.l(bus,t)*sbase;
report(t,bus,'SOC')     = SOC.l(bus,t)*sbase;
report(t,bus,'Angle')   = delta.l(bus,t);
report(t,bus,'LSH')     = lsh.l(bus,t)*sbase;
report(t,bus,'LMP($/MWh)') = const2.m(bus,t)/sbase;
report(t,bus,'Wind(MW)')   = Pw.l(bus,t)/sbase;
report(t,bus,'WCurtailment(MW)') = Pwc.l(bus,t)/sbase;
report(t,bus,'Solar(MW)')   = Psol.l(bus,t)/sbase;
report(t,bus,'SCurtailment(MW)') = Psol.l(bus,t)/sbase;
Congestioncost = sum((bus,node,t)$conex(bus,node), Pij.l(bus,node,t)*(-const2.m(bus,t) + const2.m(node,t)))/2;
lmp(bus,t) = report(t,bus,'LMP($/MWh)');

report2(bus,t,'Pd')  = Pd.l(bus,t)*sbase;
report2(bus,t,'Pc')  = Pc.l(bus,t)*sbase;
report2(bus,t,'SOC') = SOC.l(bus,t)*sbase;

display report, Pij.l, Qij.l, Congestioncost, report2;

execute_unload "loadflow.gdx" OF.l
execute 'gdxxrw.exe loadflow.gdx var=OF rng=OF!a1'
