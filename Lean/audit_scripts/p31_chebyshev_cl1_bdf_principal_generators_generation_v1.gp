\\ Producer for an unconditional BDF factor-base principality certificate in
\\ K = Q(a), a^31 = 2.
\\
\\ bnfinit/bnfisprincipal are discovery tools only.  The independent Sage
\\ verifier constructs no BNF or class group and checks every emitted ideal
\\ equality by finite-field arithmetic and an exact integer resultant.

default(parisizemax, 3000000000);
default(parisize, 320000000);

x = 'x;
F = x^31 - 2;
T_string = getenv("P31_BDF_T");
T = if(T_string == 0, 100000, eval(T_string));
if(type(T) != "t_INT" || T <= 2, error("P31_BDF_T must be an integer > 2"));
Q_lo_string = getenv("P31_Q_LO");
Q_hi_string = getenv("P31_Q_HI");
Q_lo = if(Q_lo_string == 0, 2, eval(Q_lo_string));
Q_hi = if(Q_hi_string == 0, T, eval(Q_hi_string));
if(type(Q_lo) != "t_INT" || type(Q_hi) != "t_INT" || Q_lo < 2 || Q_lo >= Q_hi || Q_hi > T,
  error("require integer range 2 <= P31_Q_LO < P31_Q_HI <= P31_BDF_T"));

b = bnfinit(F, 0);
count = 0;

print("#P31_BDF_PRINCIPAL_CERT_V1");
print("#STRICT_NORM_BOUND=", T);
print("#RATIONAL_Q_RANGE=[", Q_lo, ",", Q_hi, ")");
print("#POLYNOMIAL=x^31-2");
print("#FIELDS=q,f,beta_c0,...,beta_c30,alpha_c0,...,alpha_c30");

{
forprime(q = Q_lo, Q_hi - 1,
  dec = idealprimedec(b, q);
  selected = List();
  for(i = 1, #dec,
    P = dec[i];
    residue_degree = P[4];
    norm_P = q^residue_degree;
    if(norm_P < T,
      beta = lift(nfbasistoalg(b, P[2]));
      h = lift(gcd(Mod(F, q), Mod(beta, q)));
      h_coefficients = vector(residue_degree + 1, k,
                              lift(Mod(polcoef(h, k - 1), q)));
      key = residue_degree * q^32 +
            sum(k = 0, residue_degree, h_coefficients[k + 1] * q^k);
      listput(selected, [key, P, beta])
    )
  );

  selected = vecsort(Vec(selected), 1);
  for(i = 1, #selected,
      P = selected[i][2];
      beta = selected[i][3];
      residue_degree = P[4];
      norm_P = q^residue_degree;
      z = bnfisprincipal(b, P, 1);
      if(#z[1] != 0,
        error("candidate class exponent vector was not empty at q=", q,
              ", f=", residue_degree)
      );
      alpha = lift(nfbasistoalg(b, z[2]));
      if(abs(polresultant(F, alpha)) != norm_P,
        error("candidate generator has wrong exact norm at q=", q,
              ", f=", residue_degree)
      );

      print1(q, "\t", residue_degree);
      for(k = 0, 30, print1("\t", polcoef(beta, k)));
      for(k = 0, 30, print1("\t", polcoef(alpha, k)));
      print();
      count++
  )
);

print("#COUNT=", count);
print("#P31_BDF_PRINCIPAL_CERT_END");
write("/dev/stderr", "GENERATOR_RECORDS=", count);
write("/dev/stderr", "P31_BDF_PRINCIPAL_GENERATION_PASS");
}
quit;
