# P31 Chebyshev BDF fixed-40M negative scout

## Scope and status

This is a reproducible **negative scout**, not a class-group certificate.  It
applies the unconditional Belabas--Diaz y Diaz--Friedman Corollary 5.2 test to

```text
K = Q(alpha),  alpha^31 = 2,  T = 40,000,000,
```

using 256-bit Sage/Arb `RealBall` arithmetic.  Only the positive degree-one
prime-ideal sub-sum is used in the analytic lower bound.  Higher-residue-degree
prime ideals are counted exactly but their positive contributions are omitted.
Consequently a positive margin would prove the BDF sufficient inequality, but
a negative margin says only that this degree-one lower-bound implementation
does not close the criterion at this fixed cutoff.  It does **not** prove that
the full BDF sum is negative, and it gives no conclusion about `Cl(K)`.

No cutoff above `40,000,000` was run or extrapolated.  No principal-ideal
witness, BNF, class group, regulator, or unit group was constructed.

## Field and theorem ledger

The source is K. Belabas, F. Diaz y Diaz, and E. Friedman, *Small generators
of the ideal class group*, Mathematics of Computation **77** (2008),
1185--1197, Section 5, Theorem 5.1 and Corollary 5.2.  Section 5 is
unconditional.  The exact source identity and PDF hash are frozen in
`audit_scripts/p31_chebyshev_cl1_bdf_40m_scout.source`.

The polynomial is Eisenstein at 2.  Moreover

```text
2^30 mod 31^2 = 187 != 1,
```

so the pure-prime-degree index criterion gives
`O_K=Z[alpha]` and
`|Delta_K|=2^30*31^31`.  Thus `n=31` and `r1=1` in the equation-(24) form of
the BDF criterion.  Every cutoff in the computation is strict:
`N(p)^m < T`.

## Frozen RealBall result

The canonical one-CPU Sage 10.9 container run reports

```text
target = [29.89258148784235964520454348965212792215902393085789271269540044586865761496 +/- 8.81e-75]
archimedean_correction = [-4.448925579002030958331429787624104704537724910747871406362266865468631045672 +/- 8.33e-76]
weighted_prime_sum = [31.86425556311819484279849638213706296876516275314315731241896795799874 +/- 5.23e-69]
S_degree_one = [27.41532998411616388446706659451295826422743784239528590605670109253010 +/- 5.04e-69]
margin = [-2.477251503726195760737476895139169657931586088462606806638699353338553 +/- 8.84e-70]
margin_upper_endpoint = -2.477251503726195760737476895139169657931586088462606806638699353338552579504
```

In particular, the **upper endpoint is strictly negative**.  The frozen
mathematical outcome is therefore

```text
P31_BDF_T40000000_REALBALL_INCONCLUSIVE
```

and not a BDF pass.

## Exact enumeration profile

The run counted

```text
distinct degree-one prime ideals:       2,431,851
degree-one prime-ideal power terms:     2,432,851
strict factor base by residue degree:   {1: 2431851, 2: 450, 3: 50}
rational-prime split categories:        {ramified: 2, one_root: 2352675,
                                          thirty_one_roots: 2554,
                                          no_root: 78423}
```

For `m=1,...,25`, the multiplicity-weighted degree-one power counts are

```text
2431851, 858, 67, 22, 11, 7, 5, 4, 3, 3, 2, 2, 2,
2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1.
```

All 35 rational primes for which a higher-residue-degree ideal enters the
strict factor base were additionally checked by direct exact factorization of
`x^31-2` over the corresponding finite field.

## Reproduction and trust boundary

Run the wrapper from the repository root under WSL/Linux:

```console
bash Lean/audit_scripts/run_p31_chebyshev_cl1_bdf_40m_scout.sh
```

The `.exit` file contains `0` because the fixed-cutoff computation and all
wrapper checks completed successfully.  This operational exit status is not a
positive mathematical result; the transcript's `INCONCLUSIVE` marker and
strictly negative margin are authoritative.

The metadata freezes the script, source-ledger and wrapper hashes, Sage
version, 256-bit precision, strict cutoff, and the exact container image ID and
repository digest.  The checksum manifest binds those inputs together with the
transcript, metadata, exit ledger, this document, and its manifest maker.  The
trust boundary is the published unconditional BDF theorem, the exact
field/discriminant and splitting calculations, Sage exact prime/finite-field
arithmetic, and Arb directed rounding.  This package is an
**accepted-interface numerical audit**, not a theorem wholly checked by Lean.
