# Prime 31: complete supported squareclass certificate

## Certified result

Let

```text
K=Q(a),  a^31=2,
S={prime ideals of K above 2,3,31}.
```

The already frozen accepted-interface BDF/principal-factor-base certificate
proves `Cl(K)=1`.  The present independent exact certificate proves

```text
signature(K)=(1,15),
unit rank=15,
S residue degrees: 2:(1), 3:(1,30), 31:(1),
|S|=4,
dim_F2 K(S,2)=20,
```

and supplies twenty explicit power-basis representatives forming a basis of
`K(S,2)`.  Thus the expected dimension is correct; no contrary dimension or
extra S-prime was found.

This is the minimal global squareclass input for adapting the p=29 dyadic and
Stoll--Coleman route.  It does not yet impose the local Selmer conditions,
prove dyadic injection, run a Stoll shell, apply Coleman, determine rational
points, or prove an abc case.

## Dimension and representatives

The polynomial `x^31-2` is Eisenstein at 2 and the pure-field index check
`2^30 mod 31^2=187 != 1` gives `O_K=Z[a]`.  There is one real embedding and
fifteen complex pairs.  Exact factorization gives one S-prime above 2, two
above 3 of residue degrees 1 and 30, and one above 31.  Dirichlet's theorem
and the standard S-unit/ideal-parity exact sequence therefore give, using
`Cl(K)[2]=0` (indeed `Cl(K)=1`),

```text
dim_F2 K(S,2)=1+(1+15-1)+4=20.
```

The frozen list consists of `-1`, fifteen further norm-`+/-1` units, and four
finite-place generators.  The exact norm profile is

```text
-1; fifteen further values in {+1,-1}; 2; -3; -3^30; 31.
```

Every representative is checked nonzero, integral in the certified power
basis, and supported only over `{2,3,31}`.

## Independence and completeness

The discovery producer uses PARI `bnfinit` and `bnfsunit` only to find compact
representatives.  Its displayed class group and S-class group are explicitly
labelled discovery-only and are not used by the proof verifier.

The independent Sage verifier constructs no BNF, class group, unit group, or
regulator.  It computes exact square-invariant linear functionals:

- sign and parity of rational norm valuations at 2, 3, and 31;
- exact Hilbert symbols at both completions over 3, pairing against all frozen
  global representatives; and
- exact Hilbert symbols at the unique completion over 2, pairing against the
  standard 33-element dyadic test family
  `[a]+[1+a^i: i=1,3,...,61]+[1+a^62]`.

Every global square has zero value under all these functionals.  The combined
20-row signature matrix has rank 20, hence the representatives are independent
in `K^*/K^{*2}`.  Since they lie in the already bounded 20-dimensional space
`K(S,2)`, independence plus the dimension theorem proves that they span it.
No claim that the 33 dyadic test elements are a complete local basis is needed
for this global independence argument.

The exact output includes

```text
EXPECTED_S_SQUARECLASS_DIM 20
NORM_SIGNATURE_RANK 4 P3_SIGNATURE_RANK 4 DYADIC_SIGNATURE_RANK 19
COMBINED_SQUARECLASS_DETECTION_RANK 20
NO_BNF_OR_CLASS_GROUP_USED=1
NO_UNIT_GROUP_OR_REGULATOR_USED=1
P31_S_SQUARECLASS_EXACT_VERIFY_PASS
EXIT_CODE=0
```

## Trust boundary and reproducibility

The mathematical trust boundary is:

- the frozen accepted-interface proof `Cl(Q(2^(1/31)))=1`;
- Dirichlet's S-unit theorem and the standard ideal-parity exact sequence;
- the standard pure-field integral-basis criterion; and
- Sage exact number-field, ideal factorization, Hilbert-symbol, and finite-field
  linear algebra implementations.

Run the frozen verification from `Lean/audit_scripts` with

```console
bash run_p31_chebyshev_s_squareclass_verify.sh
```

Three preliminary wrapper failures are retained as attempt ledgers.  They
occurred before Sage mathematical verification began: an omitted Docker
entrypoint, a duplicated shell argument, and insufficient permissions on the
read-only temporary mount.  The final wrapper makes the directory searchable
and source readable before mounting it.  Only the final independent verifier
exit 0 is accepted by the manifest.

The manifest maker binds the discovery source, independent verifier, wrapper,
all attempt ledgers, final transcript/meta/exit, this report, and the separate
p31 class-number-one manifest and report.  It also checks the expected support,
dimension, ranks, trust-boundary markers, final exit code, image digest, and
the class-number-one manifest before emitting the frozen SHA-256 list.
