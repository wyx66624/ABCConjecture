if(version()!=[2,15,4], error("PARI version must be 2.15.4"));
pack(z)={my(v=valuation(z,5),ap=padicprec(z,5)); if(ap<=v,error("nonzero ball required")); [v,ap,lift(z/5^v)%5^(ap-v)]};
for(j=1,2, E=if(j==1,ellinit([-9,-9]),ellinit([-189,999])); F=if(j==1,ellinit([0,-27,0,99,-9]),ellinit([0,99,0,243,81])); P=if(j==1,[-2,1],[6,9]); Q=if(j==1,[1,8],[-9,72]); r=if(j==1,9,-33); ch=ellglobalred(F)[2]; if(ch!=[2,r,0,0],error("unexpected model change")); if(ellchangecurve(F,ch)[1..5]!=E[1..5] || ellchangepoint(Q,ch)!=P,error("isomorphism failed")); forstep(n=12,24,12, a=ellpadicheight(E,5,n,P); b=ellpadicheight(F,5,n,Q); s=ellpadics2(E,5,n); t=ellpadics2(F,5,n); L=ellpadiclog(E,5,n,ellmul(E,P,9))/9; M=ellpadiclog(F,5,n,ellmul(F,Q,9))/9; print([j,n,ch,vector(2,k,pack(a[k])),vector(2,k,pack(b[k])),pack(s),pack(t),pack(L),pack(M)])));
print([99,1]);
quit;
