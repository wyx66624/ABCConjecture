\\ p=23 class-only unconditional certification.
\\
\\ PARI/GP 2.15.4 User Guide, bnfcertify(b, flag): with flag != 0,
\\ success certifies that the true class group is a quotient of b.clgp.
\\ Since the provisional group below is trivial, a returned value 1 proves
\\ Cl(Q(2^(1/23))) = 1.  No GRH flag or conjectural class-group bound is used.
default(parisizemax, 12000000000);
default(parisize, 1000000000);
x = 'x;
b = bnfinit(x^23 - 2, 0);
print("CLGP=", b.clgp);
c = bnfcertify(b, 1);
print("CLASS_QUOTIENT_CERT=", c);
if(c != 1, error("class-quotient certification failed"));
quit;
