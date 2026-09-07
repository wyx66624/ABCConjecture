\\ Exact PARI modular-form computation used for exploration, pending audit.
setrand(1);
for(e=2,6,N=9*2^e; M=mfinit([N,2,12],0); B=mfeigenbasis(M); print([N,mfdim(M),mffields(M)]); for(j=1,#B,print([N,j,mfisCM(B[j]),mfcoefs(B[j],25)])));
quit;
