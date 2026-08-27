# P31 Chebyshev BDF threshold scan

## Result and exact scope

For `K=Q(alpha)`, `alpha^31=2`, a 256-bit Sage/Arb `RealBall` scan evaluated
the unconditional Belabas--Diaz y Diaz--Friedman Corollary 5.2 expression at
the four strict cutoffs

```text
40,000,000; 80,000,000; 160,000,000; 320,000,000.
```

The scan distinguishes two quantities:

- `degree_one_margin`, obtained by retaining only degree-one prime ideals.  It
  is a rigorous lower sub-sum because every omitted BDF term is positive.
- `full_margin`, obtained by enumerating every prime ideal and every power
  satisfying the strict cutoff `N(P)^m<T`.

The first scanned cutoff with a strictly positive **full** margin is
`80,000,000`.  This means that the classes of all prime ideals with norm
strictly below `80,000,000` generate the full ideal class group, subject to the
published unconditional BDF theorem and the exact/RealBall computation.

This is not a class-number-one result.  No prime ideal in the resulting factor
base was proved principal, and no principal witness, BNF, class group,
regulator, or unit group was constructed.  The word "first" means first in
the displayed four-value scan; no claim of a minimal real or integral cutoff
between 40M and 80M is made.

## Field and formula

The polynomial `x^31-2` is Eisenstein at 2, and

```text
2^30 mod 31^2 = 187 != 1.
```

The pure-prime-degree index criterion therefore gives

```text
O_K=Z[alpha],  n=31,  r1=1,  |Delta_K|=2^30*31^31.
```

The audited source is K. Belabas, F. Diaz y Diaz, and E. Friedman, *Small
generators of the ideal class group*, Mathematics of Computation **77**
(2008), 1185--1197, Section 5, Theorem 5.1 and Corollary 5.2.  Section 5 is
unconditional.  In equation-(24) form the script checks

```text
-(31*pi^2/4+log(4))/log(T)
+ 4*sum_{P,m; N(P)^m<T}
    log(N(P))/(1+N(P)^m) * (1-log(N(P)^m)/log(T))
>
log(|Delta_K|)-31*(EulerGamma+log(4*pi))-1.
```

All inequalities and norm cutoffs are strict.

## Certified intervals

At 40M the degree-one lower sub-sum and the complete BDF expression are both
strictly negative:

```text
degree_one_margin = [-2.4772515037261957607374768951391696579315860884626068066386993533386 +/- 5.58e-68]
full_margin       = [-1.2874360454852465686444423683434162262123615146390306620574069992223 +/- 2.95e-68]
```

At 80M the distinction is decisive.  The degree-one lower sub-sum still does
not close, whereas the exhaustive full expression has positive lower endpoint:

```text
degree_one_margin = [-0.9146222408139618278930501272884521503508895685448013176455979237948 +/- 4.55e-68]
full_margin       = [ 0.2944058601757084546999811576257929871041149041402660860920359033231 +/- 5.14e-68]
full_margin_lower_endpoint = 0.2944058601757084546999811576257929871041149041402660860920359033230486824475
```

The larger scanned thresholds provide additional positive checks:

```text
T=160,000,000: degree-one lower endpoint = 0.6350568123096979277650688562340472919752720318759280837854424909586577839925
                 full lower endpoint = 1.861894059968355183819822630872668359024687885462987469977606619685324961517
T=320,000,000: degree-one lower endpoint = 2.173145456845927581853592828777477729778846257537636359784969524139916997383
                 full lower endpoint = 3.416535198764503974260584331514621177896860558407594645763611992399752455791
```

Thus the old 40M negative degree-one scout was correctly labelled
inconclusive about the full formula.  The present exhaustive calculation now
shows that the full 40M formula is also negative, while the full 80M formula
passes.

## Enumeration and computational cost

For the first scanned passing cutoff, `T=80,000,000`, exact enumeration gives

```text
rational primes below T:             4,669,382
degree-one prime ideals:              4,667,696
all factor-base prime ideals:         4,668,356
factor base by residue degree:        {1: 4667696, 2: 600, 3: 60}
degree-one prime-power terms:         4,668,998
all prime-ideal-power terms:          4,669,693
```

The scan used a single CPU, exact prime enumeration in intervals of one
million integers, and a hard container limit of 6 GiB.  The frozen cgroup
measurements are

```text
container elapsed time:       144 seconds
container peak memory:        732,934,144 bytes
container final memory:       323,555,328 bytes
```

Only primes below `sqrt(320,000,000)` can contribute residue degree above one.
For all 78 such rational primes that actually contribute a higher-degree
factor, the script directly factors `x^31-2` over the exact finite field and
compares the complete included degree multiset.  For the millions of larger
primes, the exact binomial degree-one law suffices because every higher-degree
norm already exceeds the largest cutoff.

To reduce repeated `RealBall` work without changing the expression, each term
is written exactly as

```text
A - B/log(T),
A = log(N(P))/(1+N(P)^m),
B = m*log(N(P))^2/(1+N(P)^m).
```

The exact prime-power event is placed in the first strict threshold bin it
enters; cumulative `RealBall` sums then recover each displayed cutoff.

The analytic BDF package is small, but a direct p29-style proof of
`Cl(K)=1` would additionally need principality evidence for all 4,668,356
factor-base ideals at the first passing cutoff.  That exact record count is
the only principality-certificate cost asserted here; no storage or runtime
extrapolation and no such witnesses are part of this package.

## Reproduction and trust boundary

Run from the repository root under WSL/Linux:

```console
bash Lean/audit_scripts/run_p31_chebyshev_bdf_threshold_scan.sh
bash Lean/audit_scripts/make_p31_chebyshev_bdf_threshold_scan_manifest.sh
```

The wrapper freezes the source, source ledger and wrapper hashes, exact Sage
container ID and repository digest, precision, thresholds, segment length,
timestamps, transcript, exit status, elapsed time and cgroup memory readings.

This is an **accepted-interface/exact-certificate** result, not a theorem
wholly formalized in Lean.  Its trust boundary is the published unconditional
BDF theorem, the standard pure-field integral-basis criterion, exact binomial
splitting and finite-field factorization, Sage exact prime enumeration, and
Arb directed rounding.  It assumes no GRH, BSD, `abc`, Szpiro, analytic-rank
guess, or class-group heuristic.
