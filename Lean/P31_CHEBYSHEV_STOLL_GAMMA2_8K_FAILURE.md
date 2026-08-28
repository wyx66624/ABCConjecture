# Prime 31 Stoll/Gamma2: frozen 8000-bit precision failure

## Outcome

The p31 Stoll/Gamma2 adaptation is not yet a completed certificate.  The
formal SageMath 10.9 run at precision 8000 ended with `EXIT_CODE=1` at the
first `m=5` shell node.  No Stoll tail lemma or final Stoll PASS was obtained.

Before that failure, exact checks established the already frozen global
dyadic injection, an eight-round exact Cantor sum, local independence of the
two Gamma2 endpoint classes, and the explicit signature minor

```text
[3,4,5,6,7,8,9,10,11,12,13,14,15,17,18], determinant 1.
```

The complete `m=3` and `m=4` shells passed their finite covering tests:

```text
m=3: modulus 32, 16 representatives, max depth 5,
     minimum identity valuation 5795, tail bound 3 (not enough);
m=4: modulus 32, 16 representatives, max depth 6,
     minimum identity valuation 3419, tail bound 5 (not enough).
```

Because `5<6`, the accepted Stoll Lemma 3.10 interface requires continuing
to `m=5`.  At its first node the exact halving routine could not certify that
the retained identity valuation was strictly above the required threshold
2000.  The assertion stopped the run.  This is a precision/certificate-cost
failure, not evidence that the mathematical Stoll statement is false, but it
also supplies no license to extrapolate a PASS.

## Migration audit

Three earlier scouts are separately retained:

1. a variable-name mismatch (`Gamsig` versus `Gamma2sig`) after the exact
   Cantor computation and before shell work;
2. an omitted integer binding `n=len(reps)`, again before shell work; and
3. a 4000-bit scout that completed `m=3` but lost its required valuation
   margin at the first `m=4` node.

The odd-genus endpoint sign is handled as `(-1)^15`; the p31 local field is
defined by `a^31=2`, with `theta=-(2*a+a^30)`, `W` has dimension 15, and every
15-dimensional loop and signature solve was adjusted accordingly.

## Trust boundary

The finite computations use exact rational/polynomial arithmetic, exact
Hilbert symbols, and certified 2-adic arithmetic in Sage.  Their mathematical
interpretation uses the accepted Poonen--Schaefer/Schaefer descent interface
and Stoll's published saturation lemmas.  These interfaces are not re-proved
in Lean.  No Lean scalar PASS core is emitted for this failed run.

The frozen artifacts record the exact source, wrapper, three scout ledgers,
formal transcript, metadata, exit status, base global manifest, image digest,
this report, and manifest maker.  No Coleman output, rational-point theorem,
or abc conclusion follows from this package.
