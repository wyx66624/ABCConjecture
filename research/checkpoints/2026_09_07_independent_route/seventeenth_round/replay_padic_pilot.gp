if(version()!=[2,15,4], error("PARI version must be 2.15.4"));
pack(z)={my(v=valuation(z,5),ap=padicprec(z,5)); if(ap<=v,error("insufficient precision")); [v,ap,lift(z/5^v) % 5^(ap-v)]};
for(j=1,2, E=if(j==1,ellinit([-9,-9]),ellinit([-189,999])); P=if(j==1,[-2,1],[6,9]); R=ellmul(E,P,9); print([0,j,vector(2,k,[numerator(R[k]),denominator(R[k])]),ellcard(ellinit(E,5)),ellorder(ellinit(E,5),P)]); W=ellsaturation(E,[P],11); if(W!=[P],error("unexpected bounded saturation change")); print([1,j,W]); forstep(n=12,24,12,L=ellpadiclog(E,5,n,R)/9; s2=ellpadics2(E,5,n); H=ellpadicheight(E,5,n,P)*[1,-s2]~; print([2,j,n,pack(L),pack(H),pack(H/L^2),pack(s2)])));
print([99,1]);
quit;
