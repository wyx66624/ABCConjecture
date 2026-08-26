\\ Unconditional PARI/GP certificate for Q(a), a^17=2.
default(parisizemax, 4000000000);
b = bnfinit(x^17 - 2, 1);
print("CLGP=", b.clgp);
print("CERT=", bnfcertify(b));
print("DISC=", nfdisc(x^17 - 2));
quit;
