\\ Exact exploratory newspace replay. No global-power exclusion is claimed.
\\ Character 12 denotes the Kronecker character (12/.), psi_3.
default(parisizemax, 536870912);
{
  my(levels=[36,72,144,288,576],expected=[2,0,2,4,8]);
  print(["PARI_VERSION",version()]);
  for(j=1,#levels,
    my(N=levels[j],M=mfinit([N,2,12],0),forms,degree_sum=0);
    if(mfdim(M)!=expected[j],error("unexpected newspace dimension"));
    forms=mfeigenbasis(M);
    print(["SPACE",N,mfdim(M),mffields(M),#forms]);
    for(i=1,#forms,
      my(f=forms[i],params=mfparams(f),K=params[4]);
      degree_sum+=poldegree(K);
      print(["ORBIT",N,i,K,mfisCM(f),mfcoefs(f,25)]);
    );
    if(degree_sum!=mfdim(M),error("eigenorbit degree sum does not equal dimension"));
  );
  print("EXACT_NEWSPACE_REPLAY_PASS");
}
quit;
