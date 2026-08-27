\\ Generate explicit principal generators for all unramified degree-one
\\ primes of K = Q(a), a^23 = 2, below the certified explicit-formula bound.
\\
\\ This is a certificate *producer*.  Its bnfinit output is deliberately not
\\ trusted by the verifier.  Every emitted generator is checked again there by
\\ modular arithmetic and an exact integer resultant.

default(parisizemax, 2000000000);
default(parisize, 256000000);

x = 'x;
F = x^23 - 2;
B = 8928769;
expected_count = 598490; \\ 598492 degree-one primes, excluding q=2,23.

b = bnfinit(F, 0);
count = 0;

print("#P23_CL2_PRINCIPAL_CERT_V1");
print("#BOUND=", B);
print("#POLYNOMIAL=x^23-2");
print("#FIELDS=q,r,c0,...,c22");

{
forprime(q = 3, B,
  if(q != 23,
    dec = idealprimedec(b, q);
    for(i = 1, #dec,
      P = dec[i];
      if(P[4] == 1,
        z = bnfisprincipal(b, P, 1);
        if(#z[1] != 0,
          error("candidate class exponent vector was not empty at q=", q)
        );

        \\ Convert from PARI's integral-basis coordinates to an explicit
        \\ polynomial in a.  The independent verifier never reads b or nf.zk.
        A = lift(nfbasistoalg(b, z[2]));
        r = lift(Mod(-P[2][1], q));

        if(lift(Mod(r, q)^23) != lift(Mod(2, q)),
          error("bad residue root at q=", q)
        );
        if(lift(Mod(23, q) * Mod(r, q)^22) == 0,
          error("non-simple residue root at q=", q)
        );
        if(lift(Mod(subst(A, x, r), q)) != 0,
          error("candidate generator is not in the prime at q=", q)
        );
        if(abs(polresultant(F, A)) != q,
          error("candidate generator has wrong exact norm at q=", q)
        );

        print1(q, "\t", r);
        for(k = 0, 22, print1("\t", polcoef(A, k)));
        print();
        count++
      )
    )
  )
);

if(count != expected_count,
  error("wrong certificate record count: ", count, " != ", expected_count)
);
print("#COUNT=", count);
print("#P23_CL2_PRINCIPAL_CERT_END");
write("/dev/stderr", "GENERATOR_RECORDS=", count);
write("/dev/stderr", "P23_CL2_PRINCIPAL_GENERATION_PASS");
}
quit;
