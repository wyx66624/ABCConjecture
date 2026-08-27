\\ Unconditional class/unit certification for Q(2^(1/23)).
default(parisizemax, 12000000000);
default(parisize, 1000000000);
b = bnfinit(x^23 - 2, 1);
print("CLGP=", b.clgp);
print("CERT=", bnfcertify(b));
print("DISC=", nfdisc(x^23 - 2));
quit;
