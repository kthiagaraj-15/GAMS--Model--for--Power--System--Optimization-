Set
Gen /g1*g5/
counter /c1*c11/
Loadcounter /Lc1*Lc4/;
parameter report(Loadcounter,*),rep(Loadcounter,counter,*),rep2(Loadcounter,counter,gen);
Scalars
load /400/
Eprice /0.1/
Elim;
Table data(Gen,*)
   a    b      c     d     e     f   Pmin Pmax
g1 3    20    100    2    -5     3   28   206
g2 4.05 18.07 98.87  3.82 -4.24 6.09 90   284
g3 4.05 15.55 104.26 5.01 -2.15 5.69 68   189
g4 3.99 19.21 107.21 1.1  -3.99 6.2  76   266
g5 3.88 26.18 95.31  3.55 -6.88 5.57 19   53;
variables P(gen),OF,TE,TC;
equations
eq1,eq2,eq3;
eq1 .. TC=e=sum(gen,data(gen,'a')*P(gen)*P(gen)+data(gen,'b')*P(gen)+data(gen,'c'));
eq2 .. sum(gen,P(gen))=g=load;
eq3 .. TE=e=sum(gen,data(gen,'d')*P(gen)*P(gen)+data(gen,'e')*P(gen)+data(gen,'f'));
P.lo(gen)=data(gen,'Pmin');
P.up(gen)=data(gen,'Pmax');
Model END /eq1,eq2,eq3/;
Loop(Loadcounter,
load=350+ord(Loadcounter)*50;
Solve END us qcp min TC;
report(Loadcounter,'maxTE')=TE.l;
report(Loadcounter,'minTC')=TC.l;
Solve END us qcp min TE;
report(Loadcounter,'maxTC')=TC.l;
report(Loadcounter,'minTE')=TE.l;
loop(counter,
Elim=(report(Loadcounter,'maxTE')-report(Loadcounter,'minTE'))*((ord(counter)-1)/(card(counter)-1))+report(Loadcounter,'minTE');
TE.up=Elim;
Solve END us qcp min TC;
rep(Loadcounter,counter,'TC')=TC.l;
rep(Loadcounter,counter,'TE')=TE.l;
rep2(Loadcounter,counter,gen)=P.l(gen);
);
TE.up=inf;
);
Display rep,rep2,report;