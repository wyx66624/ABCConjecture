# Fixed-`T=2` Pell transversality computation

This bundle supports
`research/ABC_PELL_FIXED_TWO_TRANSVERSALITY_2026_09_03.md`.

It performs a finite positive-witness and counterexample search on

```text
odd prime index ell <= 20,000
support candidate prime q <= 10,000,000
q = +/-1 mod 2*ell
```

The producer uses binary powering in `Z[U]/(U^2-2)`.  The independent
verifier uses binary powering of `[[1,2],[1,1]]`.  Both compute modulo
`q^3` and agree on all 3,091,963 candidate-prime tests.

The verified result is:

* 2,261 prime indices;
* 2,373 in-bound support hits;
* 1,472 indices with an in-bound exponent-one witness;
* 789 bounded unresolved indices;
* one zero first displacement, `(ell,q,channel)=(7,13,B)`, with exact
  valuation two;
* no zero second displacement; and
* no opposite-channel repeated pair in the finite rectangle.

`fixed_two_verification.json` reports `PASS`.  This does not resolve an
unresolved index, test a support prime above the bound, prove a global
squarefull exclusion, or prove/disprove abc.

The same bundle records direct warning-as-error compilation of the new Lean
module and its 31-declaration axiom audit.  The exact axiom union is
`propext`, `Classical.choice`, and `Quot.sound`.

See `REPRODUCE.md` for commands and `SHA256SUMS.txt` for frozen hashes.
