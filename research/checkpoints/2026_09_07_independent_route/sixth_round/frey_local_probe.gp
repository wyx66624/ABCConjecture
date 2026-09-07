\\ Exploratory PARI/GP local reduction; not an infinite proof.
setrand(1); K=nfinit(t^2+3); r=Mod(t,t^2+3);
P2=idealprimedec(K,2)[1]; P3=idealprimedec(K,3)[1];
for(a=1,16,for(b=1,16,if(gcd(a,b)==1,xx=a^2+b^2; yy=a+b; E=ellinit([0,12*yy,0,6*(3*yy^2+xx*r),0],K); print([a,b,valuation(yy,2),valuation(yy,3),elllocalred(E,P2),elllocalred(E,P3)]))));
quit;
