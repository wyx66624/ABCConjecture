\\ Exact field-discriminant checks, not merely polynomial discriminants.
\\ Author: ChatGPT. All cases use actual composita of radical fields.
default(parisizemax, 1500000000);
ispow(n,l) = {my(f=factor(n)); for(i=1,matsize(f)[1],if(f[i,2]%l,return(0)));1};
rep(n,l) = {my(f=factor(n),v=1);for(i=1,matsize(f)[1],v*=f[i,1]^(f[i,2]%l));v};
cl(u,l) = {my(e=valuation(u,l),v=u/l^e,k=lift(Mod(v,l^2)^(l-1)));[e%l,((k-1)/l)%l]};
rank2(u,v,l) = {if(u==[0,0] && v==[0,0],return(0));if((u[1]*v[2]-u[2]*v[1])%l,return(2));1};
checkcase(a,b,l) = {
 my(c=a+b,r=min(2,3-ispow(a,l)-ispow(b,l)-ispow(c,l)),u=cl(a/c,l),v=cl(b/c,l));
 my(j=rank2(u,v,l),typ=if(j==0,0,if(j==2,3,if(u[1]||v[1],2,1))));
 my(base=(l-2)/(l-1),beta=if(typ==0,0,if(typ==1,2/l,if(typ==2,(l+1)/l,1+1/l+2/l^2))));
 my(de=l^r,df=de*(l-1),ce=base*(1-1/de)+beta,cf=base+beta);
 my(A=rep(a*c^(l-1),l),B=rep(b*c^(l-1),l),polE,polF,w,DE,DF,predE=l^(de*ce),predF=l^(df*cf),fac=factor(a*b*c));
 if(r==0, polE=x, if(r==1,polE=x^l-if(A==1,B,A),w=polcompositum(x^l-A,x^l-B);if(#w!=1,error("unexpected compositum components"));polE=w[1]));
 if(poldegree(polE)!=de,error("point field degree mismatch"));
 polE=polredbest(polE);
 w=polcompositum(polE,polcyclo(l));if(#w!=1,error("cyclotomic compositum not unique"));polF=polredbest(w[1]);
 if(poldegree(polF)!=df,error("normal closure degree mismatch"));
 for(i=1,matsize(fac)[1],my(p=fac[i,1],e=fac[i,2]);if(p!=l && e%l,predE*=p^(de*(l-1)/l);predF*=p^(df*(l-1)/l)));
 DE=abs(nfdisc(polE));DF=abs(nfdisc(polF));
 print("CASE ",[a,b,c,l,r,j,typ,de,df]," E=",DE," F=",DF," vE=",valuation(DE,l)," vF=",valuation(DF,l));
 if(DE!=predE,error(Str("point discriminant mismatch: expected ",predE)));
 if(DF!=predF,error(Str("Galois discriminant mismatch: expected ",predF)));
 if(valuation(a*b*c,l)==1 && j!=2,error("additive rank-two law"));
 if(r==2,
  my(Q0=if(c%2==0,a,c),N1=if(c%2==0,c,a),N2=b);
  my(Dorder=abs(poldisc(x^l-N1*Q0^(l-1)))^l*abs(poldisc(x^l-N2*Q0^(l-1)))^l);
  if(Dorder%DE,error("order discriminant divisibility"));
  if(!issquare(Dorder/DE),error("order index is not an integer square"));
  if(Q0%2 && (a*b*c)%2==0,
    my(e=valuation(a*b*c,2),idx=l*(l-1)/2*(e-(e%l!=0)));
    if(valuation(Dorder/DE,2)!=2*idx,error("local horizontal order index"));
    print("ORDER_INDEX_AT_2 ",idx)
  )
 );
 print("PASS");
};
cases=[[1,2,3],[1,7,3],[1,8,3],[1,26,3],[1,17,3],[1,53,3],[1,269,3],[1,31,5],[1,1024,5],[1,3124,5],[1,4,5],[1,63,5],[1,2047,5]];
for(i=1,#cases,iferr(checkcase(cases[i][1],cases[i][2],cases[i][3]),err,print(err);quit(1)));
print("ALL_ACTUAL_FIELD_DISCRIMINANTS_PASS");
quit(0);
