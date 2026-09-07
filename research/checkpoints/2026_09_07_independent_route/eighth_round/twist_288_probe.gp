\\ Exact exploratory comparison, with a full common-level Sturm cutoff.
default(parisizemax,2000000000);
setrand(1);
M288=mfinit([288,2,12],0);
M576=mfinit([576,2,12],0);
f288=mfeigenbasis(M288)[1];
f576=mfeigenbasis(M576)[3];
cutoff=12288;
v288=mfcoefs(f288,cutoff);
v576=mfcoefs(f576,cutoff);
print(["version",version(),"params",mfparams(f288),mfparams(f576),"common_level",36864,"sturm_cutoff",cutoff]);
for(j=1,7,if(j%2,for(k=1,2,D=if(k==1,-8,8);bad=0;for(n=1,cutoff,if(subst(lift(v288[n+1]),y,Mod(y^j,y^4+1))!=kronecker(D,n)*v576[n+1],bad=n;break));print(["twist",D,"image_power",j,"first_mismatch",bad]))));
quit;
