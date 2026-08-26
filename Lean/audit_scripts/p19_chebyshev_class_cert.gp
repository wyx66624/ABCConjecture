\\ Unconditional class/unit certification for Q(2^(1/19)), PARI/GP 2.15.4.
default(parisizemax, 4000000000);
b = bnfinit(x^19 - 2, 1);
print("CLGP=", b.clgp);
print("CERT=", bnfcertify(b));
print("DISC=", nfdisc(x^19 - 2));
quit;
