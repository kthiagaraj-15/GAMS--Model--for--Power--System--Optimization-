$title Min Cost PMU allocation for IEEE 14 network without considering zero injection nodes

$onText
For more details please refer to Chapter 8 (Gcode8.2), of the following book:
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

Set bus / 1*14 /;
Alias (bus,node);

Set conex 'Bus connectivity matrix'
/
   1.2
   1.5
   2.3
   2.4
   2.5
   3.4
   4.5
   4.7
   4.9
   5.6
   6.11
   6.12
   6.13
   7.8
   7.9
   9.10
   9.14
   10.11
   12.13
   13.14
/;
conex(bus,node)$(conex(node,bus)) = 1;

Parameter cost(bus);
cost(bus) = 1 + 0.1*sum(node$conex(bus,node), 1);

Variable OFc;
Binary Variable PMU(bus);

Equation const1, const2;
const1..      OFc =e= sum(bus, cost(bus)*PMU(bus));
const2(bus).. PMU(bus) + sum(node$conex(bus,node), PMU(node)) =g= 1;

option optCr = 0;
Model placement0 / const1, const2 /;
solve placement0 minimizing OFc using mip;
display pmu.l;