#!/usr/bin/env sage
"""Diagnostic PARI 2.17.1 class-quotient certification for p=29.

This is mathematically identical to the canonical flag-1 run, but enables
PARI debug level one so that the unconditional prime-ideal bound and tested
intervals remain visible even if the certification is interrupted.
"""

from cypari2 import Pari


pari = Pari()
pari.allocatemem(1_000_000_000, 12_000_000_000, silent=True)
pari("default(debug,1)")
print(f"PARI_VERSION={pari.version()}", flush=True)
print("PARI_DEBUG=1", flush=True)
pari("x='x; b=bnfinit(x^29-2,0)")
clgp = pari("b.clgp")
print(f"CLGP={clgp}", flush=True)
assert list(clgp) == [1, pari("[]"), pari("[]")]
cert = pari("bnfcertify(b,1)")
print(f"CLASS_QUOTIENT_CERT={cert}", flush=True)
if cert != 1:
    raise RuntimeError("class-quotient certification failed")
