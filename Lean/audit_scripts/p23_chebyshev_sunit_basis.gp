\\ Deterministic S-unit basis companion for Q(a), a^23=2.
\\ Completeness is supplied by the separate class-quotient run returning
\\ CLASS_QUOTIENT_CERT=1 with exit code zero.
default(parisizemax,8000000000);
b=bnfinit(x^23-2,1);
nf=b.nf;
S=concat(concat(idealprimedec(nf,2),idealprimedec(nf,3)),idealprimedec(nf,23));
su=bnfsunit(b,S);
reps=concat(concat([-1],b.fu),su[1]);
if(#S!=5,error("unexpected S size"));
if(#b.fu!=11,error("unexpected fundamental-unit rank"));
if(#su[1]!=5,error("unexpected S-unit complement rank"));
if(#reps!=17,error("unexpected S-squareclass basis size"));
print("CLGP=",b.clgp," SCLASS=",su[5]," S_SIZE=",#S," NFU=",#b.fu," NSU=",#su[1]," NREPS=",#reps);
for(i=1,#reps,print("REP",i,"=",lift(reps[i])));
print("P23_SUNIT_BASIS_PASS");
quit;
