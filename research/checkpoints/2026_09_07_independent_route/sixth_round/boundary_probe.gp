\\ Compare a=0,b=1 boundary traces with the remaining modular orbits.
setrand(1); K=nfinit(t^2+3); rr=Mod(t,t^2+3);
E0=ellinit([0,12,0,6*(3+rr),0],K);
print(["j",E0.j,"global",ellglobalred(E0)[1]]);
forprime(q=5,31,L=idealprimedec(K,q); print([q,vector(#L,j,ellap(E0,L[j]))]));
quit;
