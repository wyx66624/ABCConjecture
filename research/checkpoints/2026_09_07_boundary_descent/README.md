# Seventh continuation: boundary descent and actual square gaps

Standard ABC remains unproved and undisproved. This checkpoint records
independently reviewed ordinary results, their scoped formal arithmetic,
and the 432-page integrated manuscript at the user-designated filename.

## Mathematical results and their precise boundaries

**SW1--SW3:** Brun--Titchmarsh on the exact-rank progressions bounds
the actual positive prime-window mean by

    10 log Y/(Y^3 log(3B))
      +36 Z sigma(n)/(Bn log(Z/(3n))) + log n/(n log(3B)).

For bounded sigma(n)/n, including prime powers, B=n^4 and
Z=floor(B sqrt(log n)) give a vanishing mean and a density-one set
of actual roots. The interval extends beyond B. Exceptional roots and
all primes above Z remain uncontrolled.

**AS1--AS4:** established effective Diophantine theorems yield
`log g<=C(1+log V+log(1+min(a,b,|a-b|)))` for actual nontrivial
power norms. Fixed V and a bounded value of that minimum give an
effectively determinable finite set across all g>=2. This constrains
the global consecutive local-shadow family. It does not give uniform
control of moving slices or all residuals with log V=o(g).

**SG1--SG3:** elementary identities give the residue-sensitive square
axis bound `2ra<9b^3`, where r is the least positive residue of
`8a^2+12ab+11b^2` modulo eight. Primitivity gives r>=3 and hence
`2a<3b^3` and its symmetric counterpart. A separate class-thirteen
diagonal gap and complete fixed-difference divisor parametrization
precede the stronger global Q13 theorem.

**BM1--BM4:** a fixed Tate-module prime, Ribet's Q-curve construction,
completed GL2-type modularity and a finite Dirichlet twist prove
weight-two modularity of the specified boundary descent. Compatibility
then supplies all local conductor checks. Only after proving membership
in the five exact levels does the previously verified complete newspace
enumeration identify the non-CM 576 orbit. This is ordinary proof plus
exact software-assisted orbit identification, not a Lean modularity
certificate. It discharges the earlier conditional boundary-membership
premise without claiming a positive global power shadow.

**BC1--BC4:** an actual residual-module isomorphism to the boundary,
possibly with a quadratic twist unramified outside six, forces F=Q^p.
Every prime divisor q satisfies `q>=(sqrt(p)-1)^2`; for q!=p it also
satisfies `p|(q+1)^2-t_q^2`. Neither seven nor thirteen divides Q.
The exact permitted GL2 proportion is
`(2p^2-p-5)/((p-1)^2(p+1))`, asymptotic to 2/p. Fixed-p Chebotarev
gives that prime-ideal density and half as much rational split-prime
density, with no uniform error in p. All embeddings of the 576 orbit
are handled by retaining chi^sigma/chi, which can be nontrivial.
No residual isomorphism is constructed, and sparse permitted support
does not exclude all polynomial values in that support.

**Q13 and IM:** a complete ordinary rational two-isogeny descent gives
`E(Q)={O,(0,0)}` for `Y^2=X^3-13X^2-507X`. The proof explicitly
excludes the three remaining descent cosets, proves rank zero via the
dual image and Mordell--Weil, and bounds torsion by full counts at five
and seven. It does not use a software rank answer as a premise.

With `c=a-b`, `A=7a^2+12ab+7b^2`, `U=13(A-26s)` and
`V=13U(a+b)`, the exact integral identity is

    V^2-U^3+13U^2 c^2+507U c^4=8788U(F-13s^2).

If F=13s^2 and c!=0, then U!=0. Thus this gives a forbidden finite
rational point with X=U/c^2 nonzero. Over all integers the complete
ordinary classification is exactly `a=b, s=+/-a^2`. Primitive positive
seeds reduce to `(1,1,+/-1)`. This closes the specified residual
square class thirteen; other residual classes and odd exponents remain.

## Formal verification

```text
python3 research/checkpoints/2026_09_07_boundary_descent/verify_round.py
```

The final fresh Lean 4.32.0 build accepts 23 new declarations and
recompiles 65 unchanged dependency declarations. All 88 have an axiom
inventory; only propext, Classical.choice and Quot.sound occur. Warnings
are errors. Both new modules have independent source/signature reviews.

`SquareGapArithmetic.lean` contains 16 declarations, including the
complete actual primitive-square implications `2a<3b^3`, `2b<3a^3`
and `a,b>1`, for signed integer q. The actual gap is proved from the
norm equation. Its sharper residue-sensitive coefficient is not the
formal conclusion claimed here.

`ThirteenMapArithmetic.lean` contains seven declarations proving the
integral identities, actual weighted curve, numerator nonvanishing,
actual nontrivial point and a conditional diagonal theorem. Its final
elliptic-point obstruction is an explicit theorem parameter. The
rational group classification and full Q13 theorem remain ordinary
proofs. No implicit axiom, full repository build or formal ABC result
is claimed.

## Exact evidence and manuscript

Root read and independently reran four new finite checks: the AS/SG
polynomial and residue certificates plus 84,490 primitive seed diagnostics
and 160 complete slices; full GL2 counts at seven primes and eight boundary
point counts; the separate Q13 polynomial/local/torsion certificate;
and an independently implemented Q13 replay. Exact byte and compact
payload hashes are distinguished in `verification/finite_replay_validation.json`.
These computations do not prove infinite statements by bounded search.

The GitHub workflow repeats the fresh scoped Lean audit and all four
new replays. The previous frozen complete modular-space certificate
and its independent replay remain separately recorded dependencies.

The full manuscript compiles from 142 actual TeX inputs. Page 1 and
pages 417--432 were actually rendered and visually inspected, for
17 reviewed pages. Pages 1--416 retain the preceding 421-page text;
all 132 previous child TeX inputs retain their sealed hashes. Only
the master changed among the previous input files. The seal records
the final PDF, source and reviewed raster hashes. It is not an all-page
visual review. Eighth-round explorations are outside this publication.

All unrefuted parent directions remain active. The full signed prime
tail, uniform moving-point heights and complete modular exclusions
remain open.
