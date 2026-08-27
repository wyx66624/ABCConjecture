\\ Discovery-only producer for K=Q(a), a^31=2 and S above {2,3,31}.
\\ BNF and bnfsunit output are not accepted as final evidence.
default(parisizemax,8000000000);
F=x^31-2;
b=bnfinit(F,1);
nf=b.nf;
S=concat(concat(idealprimedec(nf,2),idealprimedec(nf,3)),idealprimedec(nf,31));
su=bnfsunit(b,S);
reps=concat(concat([-1],b.fu),su[1]);
if(#S!=4,error("unexpected S size"));
if(#b.fu!=15,error("unexpected unit rank"));
if(#su[1]!=4,error("unexpected S-unit complement rank"));
if(#reps!=20,error("unexpected representative count"));
print("CLGP_DISCOVERY_ONLY=",b.clgp," SCLASS_DISCOVERY_ONLY=",su[5]," S_SIZE=",#S," NFU=",#b.fu," NSU=",#su[1]," NREPS=",#reps);
for(i=1,#reps,print("REP",i,"=",lift(reps[i])));
print("P31_S_SQUARECLASS_DISCOVERY_PASS");
quit;
