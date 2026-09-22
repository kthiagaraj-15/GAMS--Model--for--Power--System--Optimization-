$title Transmission Expansion Planning

$onText
For more details please refer to Chapter 9 (Gcode9.1), of the following book:
Soroudi, Alireza. Power System Optimization Modeling in GAMS. Springer, 2017.
--------------------------------------------------------------------------------
Model type: MIP
--------------------------------------------------------------------------------
Contributed by
Dr. Alireza Soroudi
IEEE Senior Member
email: alireza.soroudi@gmail.com
We do request that publications derived from the use of the developed GAMS code
explicitly acknowledge that fact by citing
Soroudi, Alireza. Power System Optimization Modeling in GAMS. Springer, 2017.
DOI: doi.org/10.1007/978-3-319-62350-4
$offText

Set
   bus        / 1*6   /
   slack(bus) / 1     /
   Gen        / g1*g3 /
   k          / k1*k4 /;

Scalar
   Sbase /  100 /
   M     / 1000 /;

Alias (bus,node);

Table GenData(Gen,*) 'generating units characteristics'
       b   pmin  pmax
   g1  20  0     400
   g2  30  0     400
   g3  10  0     600;
* -----------------------------------------------------

Set GBconect(bus,Gen) 'connectivity index of each generating unit to each bus' / 1.g1, 3.g2, 6.g3 /;

Table BusData(bus,*) 'demands of each bus in MW'
      Pd
   1  80
   2  240
   3  40
   4  160
   5  240;

Table branch(bus,node,*) 'network technical characteristics'
        X    LIMIT  Cost  stat
   1.2  0.4  100    40    1
   1.4  0.6  80     60    1
   1.5  0.2  100    20    1
   2.3  0.2  100    20    1
   2.4  0.4  100    40    1
   2.6  0.3  100    30    0
   3.5  0.2  100    20    1
   4.6  0.3  100    30    0;

Set conex(bus,node) 'Bus connectivity matrixl';
conex(bus,node)$(branch(bus,node,'x')) = yes;
conex(bus,node)$conex(node,bus)        = yes;

branch(bus,node,'x')$branch(node,bus,'x')             =  branch(node,bus,'x');
branch(bus,node,'cost')$branch(node,bus,'cost')       =  branch(node,bus,'cost');
branch(bus,node,'stat')$branch(node,bus,'stat')       =  branch(node,bus,'stat');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0) =  branch(node,bus,'Limit');
branch(bus,node,'bij')$conex(bus,node)                =1/branch(bus,node,'x');
M = smax((bus,node)$conex(bus,node),branch(bus,node,'bij')*3.14*2);
*****************************************************

Variable OF, Pij(bus,node,k), Pg(Gen), delta(bus), LS(bus);
Binary Variable alpha(bus,node,k);
alpha.l(bus,node,k) = 1;
alpha.fx(bus,node,k)$(conex(bus,node) and ord(k)=1 and branch(node,bus,'stat')) = 1;

Equation const1A, const1B, const1C, const1D, const1E, const2, const3;
***********************************************************************

const1A(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k) - branch(bus,node,'bij')*(delta(bus) - delta(node)) =l=  M*(1 - alpha(bus,node,k));

const1B(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k) - branch(bus,node,'bij')*(delta(bus) - delta(node)) =g= -M*(1 - alpha(bus,node,k));

const1C(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k)   =l= alpha(bus,node,k)*branch(bus,node,'Limit')/Sbase;

const1D(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k)   =g=-alpha(bus,node,k)*branch(bus,node,'Limit')/Sbase;

const1E(bus,node,k)$conex(node,bus)..
   alpha(bus,node,k) =e= alpha(node,bus,k);

const2(bus)..
   LS(bus) + sum(Gen$GBconect(bus,Gen), Pg(Gen))-BusData(bus,'pd')/Sbase =e= sum((k,node)$conex(node,bus), Pij(bus,node,k));

const3..
   OF =g= 10*8760*(sum(Gen, Pg(Gen)*GenData(Gen,'b')*Sbase)+100000*sum(bus ,LS(bus)))
       +  1e6*sum((bus,node,k)$conex(node,bus), 0.5*branch(bus,node,'cost')*alpha(bus,node,k)$(ord(k)>1 or branch(node,bus,'stat')=0));

Model loadflow / all /;

LS.up(bus) = BusData(bus,'pd')/Sbase;
LS.lo(bus) = 0;
Pg.lo(Gen) = GenData(Gen,'Pmin')/Sbase;
Pg.up(Gen) = GenData(Gen,'Pmax')/Sbase;

delta.up(bus)   = pi/3;
delta.lo(bus)   =-pi/3;
delta.fx(slack) = 0;
Pij.up(bus,node,k)$((conex(bus,node))) = 1*branch(bus,node,'Limit')/Sbase;
Pij.lo(bus,node,k)$((conex(bus,node))) =-1*branch(bus,node,'Limit')/Sbase;

option optCr = 0;
solve loadflow minimizing OF using mip;