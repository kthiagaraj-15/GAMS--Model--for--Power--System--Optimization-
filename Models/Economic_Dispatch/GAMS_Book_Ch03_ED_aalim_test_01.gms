set Gen / g1*g5 / ;
scalar load / 400 /;
Table data (Gen ,*)
   a    b      c     d     e     f   Pmin Pmax
g1 3    20    100    2    -5     3   28   206
g2 4.05 18.07 98.87  3.82 -4.24 6.09 90   284
g3 4.05 15.55 104.26 5.01 -2.15 5.69 68   189
g4 3.99 19.21 107.21 1.1  -3.99 6.2  76   266
g5 3.88 26.18 95.31  3.55 -6.88 5.57 19   53;
variables P( gen ) ,OF;
equations
eq1 , eq2;
eq1 .. OF=e=sum(gen,data (gen,'a')*P(gen)*P(gen)+data(gen,'b')*P(gen)+data(gen,'c'));
eq2 .. sum(gen ,P(gen))=g=load ;
P.lo (gen)=data( gen ,'Pmin');
P.up (gen)=data( gen ,'Pmax');
model ECD / eq1 , eq2 /;
solve ECD us qcp min of;