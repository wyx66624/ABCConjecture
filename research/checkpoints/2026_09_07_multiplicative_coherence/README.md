# Twelfth continuation: multiplicative coherence and rational quotient curves

Standard ABC remains unproved and undisproved. This checkpoint records
reviewed ordinary results and 21 new scoped Lean declarations. The complete
manuscript seal records the actual page count, source hashes, unchanged
predecessor sources and rendered visual-review coverage in
`verification/manuscript_validation.json`.

The sealed PDF has 502 pages and SHA-256
`78fa137947ea385f432d4e97394270d2064283b3a0062595544676057e02e024`.
The three-pass build records 185 actual TeX inputs and zero unresolved
references or overfull boxes. All 175 predecessor child sources and the
first 481 pages of extracted text are unchanged. The title and every
changed page were actually viewed, covering 22 rasters in total.

## Mathematical results and remaining obligations

- MC proves actual pair-product rigidity at fourth depth for q>6n^3,
  B=n^4. Positive divisor fibers give a square-root count of deep roots
  and a simultaneous cap-three interval up to B n^(1/2-delta) on a set
  of relative size tending to one. The farther signed packet stays open.
- PN proves that at least half of the block asymptotically has a globally
  private simple norm prime above 12B. These oriented valuations give an
  actual multiplicatively independent set. Fixed higher moments control
  all positive excess in (B, B n^(1-1/nu-delta)] on a positive-density
  domain. Every intermediate layer is included. The complement and
  unbounded farther tail are not controlled, and nu is fixed here.
- PF gives an exact divisor congruence, a denominator-sensitive fiber
  bound, and actual two- and three-pair collisions. Only the displayed
  universal injectivity/cardinality claims are refuted. Common deep-prime
  membership of the examples is not asserted. A multiple-mark interface
  retains its product target size and low-denominator remainder.
- RL gives the exact rational point domain and positive integral inverse
  of the odd simultaneous quadratic cover. Every positive rational point
  of the first Eisenstein curve has one rational Gaussian lift.
- UG proves that the relative cover is finite etale and exhibits an
  exact-order-g Jacobian divisor class over the fixed biquadratic field.
  It is a mu_g group-scheme torsor; constant arithmetic deck transformations
  are not presumed. Its positive rational fibers all lift.
- HG expresses the first curve as a rational V4 cover with three genus
  g-1 hyperelliptic quotients. Q-defined norm and pullback maps give a
  product isogeny and preserve the exact odd torsion order in the product.
  The three genus-two curves at g=3 have explicit equations; no rank or
  complete rational-point enumeration has been proved here.

Ordinary proofs, complete transcriptions and independent internal reviews
are in the three agents' `twelfth_round` directories. The root records its
complete reviews in `ordinary_review.md`. The finite count bridge's ordinary
proof preceded implementation in `ordinary_count_bridge.md`.

## Exact formal scope

| Module | New declarations | Unchanged dependency declarations |
| --- | ---: | ---: |
| DeepRootPhaseArithmetic | 15 | 0 |
| ActualDeepRootCount | 6 | 0 |
| EisensteinDescent | 0 | 29 |

The formal statements use actual integer coordinate multiplication,
conjugate cross differences, positive divisor factors, finite sets of
ordered pairs, integer block heights, the finite divisor envelope and a
real square-root bound. The product-image target size and same-image
modular divisibility are explicit hypotheses. No finite-ring construction,
torsion lifting, ideal factorization, divisor asymptotics, sieve or
geometric theorem is silently formalized by these finite statements.

All 50 declarations have complete axiom queries. The fresh compiler run
passes with only `propext`, `Classical.choice` and `Quot.sound` in their
union. Lean is 4.32.0 and Mathlib is pinned to
`81a5d257c8e410db227a6665ed08f64fea08e997`. Every listed local source is
freshly compiled with warnings as errors; the pinned compiled Mathlib
cache is reused. This is not a whole-repository or Mathlib rebuild.

Finite certificates retain their explicitly bounded domains. In particular
the phase replay checks 2,870 actual block pairs, 1,540 block phase fibers,
1,599 positive inputs and 1,201 specified integer phases. Its full divisor
enumerations establish the displayed examples but no uniform theorem by
testing. Private-support and curve replays likewise do not prove the
asymptotic density or determine complete rational-point sets.

## Reproduce

In the pinned Linux Lean/Mathlib environment:

```sh
python3 research/checkpoints/2026_09_07_multiplicative_coherence/verify_mathlib.py --project /path/to/pinned/project
python3 research/checkpoints/2026_09_07_multiplicative_coherence/verify_finite.py
```

`prepare_mathlib_project.py` creates a dependency-only CI project. The
workflow `.github/workflows/abc-multiplicative-coherence.yml` specifies the
compiler and cache restoration. The verifier checks the exact Mathlib
commit and tracked source cleanliness before compiling the local sources.

`build_manuscript.py` compiles the full manuscript three times and records
its actual input hashes. `seal_manuscript.py` requires matching formal and
finite evidence, actually reviewed page rasters, unchanged predecessor
child sources and an unchanged extracted-text prefix before replacing
the designated PDF. Successful compilation alone is not visual inspection.

The primary analytic target is the unbounded signed cost and exceptional
roots. Independent targets are actual point computation and uniform height
control on the quotient curves, ramified first norms and moving residuals.
Subsequent `next_*.md` explorations are outside this sealed continuation.
All unrefuted parent routes remain available.
