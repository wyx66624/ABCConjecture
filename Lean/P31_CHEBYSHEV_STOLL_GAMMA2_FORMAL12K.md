# Prime 31 Stoll/Gamma2 formal 12000-bit certificate

## Verdict and scope

The frozen SageMath 10.9 computation closes the Stoll shell calculation on
the p31 Pell dyadic disk `T+1 in 8 Z_2`, using `Gamma2=<H1,H9>` and the
15-dimensional global over-approximation `W`.  The shell maxima are

```text
n3=5, n4=6, n5=7,
```

and Stoll's tail inequality closes at `m=5` with equality `2*5-3=7=n5`.
All 48 nodes terminate in one of two exact local squareclasses, and direct
local square tests prove that neither class lies in `loc_2(W)`.

This is an accepted-interface certificate using published Stoll and
Poonen--Schaefer/Schaefer results.  Sage verifies the finite arithmetic.  This package
does not include Coleman, does not itself determine all rational points, and
does not prove abc.

## Exact inputs and p31 migration

The prerequisite manifest proves `dim W=15` and injectivity of its localization
at the unique dyadic completion.  The local field is `Q_2(a)`, `a^31=2`, with
`theta=-(2*a+a^30)`.  Genus is 15, so endpoint Kummer identities retain the
odd-genus sign `(-1)^15`.  Exact Cantor composition of the two endpoint halves
takes eight reductions.  Their dyadic signatures have rank two.

The verifier freezes columns

```text
[3,4,5,6,7,8,9,10,11,12,13,14,15,17,18]
```

and independently asserts that they equal the pivot columns and form a
`15 x 15` minor of determinant one.  Terminal membership uses this minor to
select a unique candidate in `W`, followed by a direct exact local square test.

## Precision and shells

Precision is 12000 bits and every initial-divisor and halving residual is
required to have valuation strictly greater than 2000.  The complete output is

```text
SHELL_SUMMARY M 3 UNIT_MODULUS 32 REPS 16 MAX_NU 5 MIN_ID_VAL 9795
SHELL_SUMMARY M 4 UNIT_MODULUS 32 REPS 16 MAX_NU 6 MIN_ID_VAL 7419
SHELL_SUMMARY M 5 UNIT_MODULUS 32 REPS 16 MAX_NU 7 MIN_ID_VAL 4017
TAIL_LEMMA_3_10 M 5 BOUND 7 MAX_NU 7 PASS True
TERMINAL_SQUARECLASS_COUNT 2
P31_STOLL_GAMMA2_OVERAPPROX_PASS
EXIT_CODE=0
```

The initial-divisor residuals are exactly `12021` for all 16 `m=3` nodes,
`12018` for all 16 `m=4` nodes, and `12015` for all 16 `m=5` nodes; their
global minimum is therefore `12015`.  The run lasted from
2026-08-28T03:20:21Z to 04:06:58Z (46 minutes 37 seconds).

## Provenance and trust ledger

The wrapper first validates the global-dyadic, frozen 8k-failure, and precision
diagnostic manifests.  The diagnostic manifest hash recorded here is
`46cf4a4b...`, replacing the earlier `4e50...` version solely because its
report wording was tightened: diagnostic executable artifacts did not change.
The old report had overstated the zero-threshold diagnostic as a full
initial-divisor `>2000` check.  The present formal source prints and checks that
residual explicitly.

The exact arithmetic boundary is Sage number-field, polynomial, Hilbert-symbol,
2-adic, and finite-field linear algebra.  The theorem boundary is accepted
Stoll Theorem 2.1, Lemma 2.4, Corollary 3.2, Lemma 3.10, Proposition 5.1 and
Remark 5.2, plus accepted odd-degree descent.  No Lean file is part of this
certificate.

The irreducibility/change-of-basis check shows that `theta` generates the
degree-31 dyadic field.  Transitivity on the roots of the odd-degree
hyperelliptic polynomial leaves no nontrivial Galois-stable even root subset,
so `J(Q_2)[2]=0`; any nonzero 2-power torsion point would yield nonzero
2-torsion after repeated doubling.  This is the torsion-freeness obligation in
the accepted Stoll interface.  The conclusion certified here is only the
dyadic saturation/shell condition for `Gamma2`, not a Coleman or global
rational-point conclusion.
