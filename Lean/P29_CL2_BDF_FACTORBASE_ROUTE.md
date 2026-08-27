# P29 class-group parity route via the unconditional BDF factor-base criterion

## Status

The unconditional factor-base gate has passed in 256-bit Arb real-ball
arithmetic.  This is not yet a class-group-triviality certificate: it proves
that all prime ideals of norm below `40,000,000` generate the full class group.
The remaining finite task is to verify relations that kill those factor-base
classes (modulo two for the descent goal, or integrally for the stronger
class-number-one result).

## Primary source and exact criterion

K. Belabas, F. Diaz y Diaz, and E. Friedman, *Small generators of the ideal
class group*, Mathematics of Computation **77** (2008), 1185--1197,
DOI 10.1090/S0025-5718-07-02003-0.  Author PDF:

<https://www.math.u-bordeaux.fr/~kbelabas/research/OnBach.pdf>

Section 5, headed “Unconditional results”, starts on printed page 1194 (PDF
page 10).  Theorem 5.1 is on printed pages 1194--1195 (PDF pages 10--11), and
Corollary 5.2 is on printed page 1195 (PDF page 11), equations (23)--(24).

Theorem 5.1 takes a number field of degree `n` with `r1` real embeddings and a
function `f` supported on `[0, log T]`.  It assumes `f(0)=1`, that the Fourier
cosine transform of `f` is nonnegative, and that
`F(x)=f(x)/cosh(x/2)` satisfies the hypotheses of Weil's explicit formula.
Its strict inequality (16) implies that the classes of prime ideals
`p` with **strictly** `N(p) < T` generate the full ideal class group.

Corollary 5.2 specializes to

```text
f(x) = 1 - x/log(T),  0 <= x <= log(T),
f(x) = 0,             x > log(T),
```

which is the `c=log(T)` specialization of the triangular test function.  Thus
`T=exp(c)`; there is no independent `c` parameter in (23).  Its criterion is

```text
4 sum_{p,m >= 1; N(p)^m < T}
    log N(p)/(1+N(p)^m) * (1-log(N(p)^m)/log(T))
>
log Delta_K
- n * (gamma + log(4*pi) - (pi^2/4)/log(T))
- r1 * (1 - log(4)/log(T)).
```

Equivalently, with equation (24),

```text
S_uncond(T) := -(n*pi^2/4+r1*log(4))/log(T)
               + 4 sum_{p,m; N(p)^m<T} (...)
>
log Delta_K - n*(gamma+log(4*pi)) - r1.
```

Both inequalities are strict.  The only numerical restriction is `T>1`.
The sum is over **all** nonzero prime ideals of `O_K`, including ramified prime
ideals and prime ideals of every residue degree, and over every `m>=1` satisfying
the strict prime-power cutoff.  The conclusion likewise uses every prime ideal
with `N(p)<T`, not `N(p)<=T`.

The proof is unconditional.  It uses the maximum principle, in the form
attributed there to Odlyzko/Poitou, to obtain positivity on the whole critical
strip.  It is not the GRH-dependent Theorem 2.1/Corollary 2.2 of the same paper.

## Input field

For `K=Q(alpha)`, `alpha^29=2`, the polynomial is Eisenstein at 2 and
`O_K=Z[alpha]` (the pure-prime-degree index criterion gives no index contribution
at 29 because `2^28` is not congruent to 1 modulo `29^2`).  Hence

```text
n = 29, r1 = 1, Delta_K = 2^28 * 29^29.
```

The constant on the right of the equation-(24) form is approximately
`25.920742681032337`, but the script recomputes it as a real ball.

For a rational prime `q`, the number of degree-one primes above `q` is exactly

```text
1   if q=2 or q=29;
1   if q != 1 (mod 29);
29  if q = 1 (mod 29) and 2^((q-1)/29) = 1 (mod q);
0   otherwise.
```

Every term is positive.  Therefore retaining only these degree-one primes, but
retaining all their powers `q^m<T`, gives a certified lower bound for the full
BDF sum.  Higher-degree prime ideals are deliberately omitted from the audit.

## Reproducible audit

Run from the repository root:

```console
sage Lean/audit_scripts/p29_chebyshev_cl2_bdf_factorbase_plan.sage
```

The script enumerates rational primes independently, performs the modular
29th-power test, and reports the archimedean term, weighted prime term, strict
margin, distinct degree-one ideal count, multiplicity-weighted prime-power
record count, splitting categories, and a separate contribution for each `m`.
It declares `PASS` only when the lower endpoint of the 256-bit margin ball is
strictly positive.

The canonical Sage 10.9 container run at 256-bit precision gives:

```text
target                         [25.9207426810323294980496814931 +/- 1.25e-74]
archimedean correction         [-4.16700760316056406461507473690 +/- 4.86e-76]
weighted degree-one sum        [30.6908111342617348909499432648 +/- 4.06e-69]
S_degree_one                   [26.5238035311011708263348685279 +/- 1.27e-69]
margin                         [0.603060850068841328285187034766 +/- 8.60e-70]
margin lower endpoint           0.603060850068841328285187034766...

rational primes used                 2,349,857
distinct degree-one prime ideals     2,434,529
prime-ideal-power terms              2,435,493
ramified rational primes                     2
one-root rational primes             2,346,831
29-root rational primes                  3,024
zero-root rational primes               83,797
```

The multiplicity-weighted term counts by exponent `m=1,2,...,25` were

```text
2434529, 824, 66, 21, 11, 7, 5, 4, 3, 3, 2, 2, 2,
2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1.
```

The archived transcript prints the corresponding real-ball contribution for
every exponent and ends with `P29_BDF_FACTORBASE_REALBALL_PASS`.

## What this certifies, and what remains

The successful run certifies only that prime ideals of norm below forty million
generate `Cl(K)`.  It does not show that these ideals are principal and does not
show `Cl(K)[2]=0`.

For the parity goal it is enough to add an independently checkable relation
certificate showing that the factor-base classes span zero in
`Cl(K)/2 Cl(K)`.  Concretely, principal-ideal relations must make the relation
matrix have full column rank over `F_2`; one need not exhibit a separate
principal generator for every factor-base ideal.  An alternative generating set
may compress this certificate, but must retain verifiable translations back to
the BDF factor base.

### Principal-generator implementation

The selected interface is stronger and simpler than a general relation
matrix.  For every factor-base prime it records

```text
q, f, beta_0,...,beta_28, alpha_0,...,alpha_28,
```

where `p=(q,beta(a))` and `alpha(a)` is a candidate generator.  The producer
may use the provisional BNF to find `alpha`; the independent verifier builds
no BNF, class group, regulator or unit group.  It checks exactly that

```text
h=gcd(X^29-2,beta) mod q
```

is the selected irreducible factor of degree `f`, that `h` divides `alpha`
modulo `q`, and that

```text
abs(Res(X^29-2,alpha))=q^f.
```

Thus `(alpha)` is contained in `p` and both integral ideals have norm `q^f`,
so `(alpha)=p`.  The verifier independently enumerates every rational prime,
uses the exact binomial splitting law, directly factors the small cases in
which a higher-degree prime can enter, rejects duplicate or noncanonical
records, and accepts only contiguous half-open shard ranges covering
`[2,T)`.

Exact enumeration gives the prospective full certificate profile

```text
residue degree 1: 2,434,529
residue degree 2:       406
residue degree 4:        14
residue degree 7:         4
total:             2,434,953.
```

The configurable producer, streaming multi-shard verifier and 16-worker
acceptance wrapper are

```text
audit_scripts/p29_chebyshev_cl1_bdf_principal_generators.gp
audit_scripts/p29_chebyshev_cl1_bdf_principal_verify.sage
audit_scripts/run_p29_chebyshev_cl1_bdf_principal_full.sh.
```

At `T=100,000`, independent one-worker and two-worker streams were
byte-identical and all 9,529 ideals passed the exact verifier.  This is a
pilot, not the full result.  Only a completed `T=40,000,000` run with the
expected counts and final marker will promote the tentative class number one
to the unconditional theorem `Cl(K)=1`.

`IUTThreeClosures/P29BDFFactorbaseCore.lean` kernel-checks the abstract final
step: a finite additive group generated by doubles has no two-torsion, and a
group generated by zero classes is trivial.  It deliberately does not encode
the analytic BDF theorem as an axiom.

Trust boundaries for the numerical certificate are Sage's certified
prime enumeration and modular arithmetic, Arb/RealBall directed rounding, the
exact field/discriminant calculation above, and the published BDF theorem.
The later relation certificate additionally requires certified ideal
factorization and exact principal-ideal valuations.  Finite-height verification
of zeros of `zeta_K` is neither assumed nor sufficient for this route.

The primary-source PDF used for the theorem audit has SHA256

```text
e619d0f0c52bfddd0316e354d72c1b3b7946d85a1cdcbad05aac990cf911fc78
```

and is identified independently in
`audit_scripts/p29_chebyshev_cl2_bdf_factorbase.source`.  The wrapper freezes
the executable-input hashes, exact container image, transcript, metadata and
exit status.  The checksum manifest also hashes its generator; as usual it
does not try to hash the self-referential manifest file itself.
