# Fifteenth continuation: signed products and quadratic cube descents

Standard ABC remains unproved and undisproved. This checkpoint contains
independently reviewed ordinary proofs and 55 new finite Lean declarations.
The integrated manuscript and actual visual review are sealed in
`verification/manuscript_validation.json`.

The sealed PDF has 536 pages, 3,463,794 bytes and SHA-256
`ad6808a056037d3e3f5ded6f76f7017f9f7dc3207c0ea97443eabece01bda0b0`.
The stable three-pass build records 202 actual TeX inputs, with no overfull
boxes or unresolved references. All 196 predecessor child sources are
byte-identical, and the first 521 extracted-text pages are unchanged.
The title and every changed page were actually viewed: 16 rasters in all.
This does not assert an all-page visual review.

## Mathematical results

- US uses coherent unit normalization at each fixed prime and actual signed
  integer products. The finite norm-one target has at most n elements. The
  complete positive excess is at most (5/2)n log(8B) per prime, with normalized
  bound 5/B. One actual maximal-depth index contains all sufficiently deep
  layers; the remaining cost is at most 7n^(5/6) log(8B). The two support
  thresholds distinguish positive excess from any positive depth.
- GD gives explicit cube descents in Q(i) and Q(sqrt(3)), a bijective opposite
  three-isogeny on rational points, and an isogeny quotient of order three.
  Ordinary Mordell--Weil then gives rank one for both elliptic curves and rank
  two for the first genus-two Jacobian. There is no generator or all-point claim.
- The root connection uses the actual Eisenstein norm, actual products with
  integer exponents, private integer homomorphisms and two concrete finite
  squares. It derives the high-depth cardinality from actual two-element maps
  and connects it to the complete finite depth budget.

The ordinary proofs preceded implementation. Root and two independent agents
reviewed the mathematical arguments and the exact formal boundaries. Internal
agent review is not external peer review. The Gaussian cube condition is
automatic on every rational point of its elliptic curve, so it is not a new
point exclusion. Neither single-prime bounds nor exact rank close the global
signed tail or the simultaneous rational-point problem.

## Actual formal verification

| Module | New declarations | Scope |
| --- | ---: | --- |
| SignedMomentArithmetic | 22 | Finite binomial sums, actual maximum, all depth layers, individual-height normalization and natural thresholds |
| ActualGramRigidity | 4 | Actual integer Eisenstein norm and determinant divisibility criterion |
| ActualSignedProducts | 12 | Actual signed products, private homomorphisms, unit normalization and the concrete finite diamond |
| ActualSingleOwnerBridge | 2 | Actual pair rigidity implies cardinality at most one and the full finite prime budget |
| GaussianDescentArithmetic | 15 | Actual homogeneous norms, primitive mod-27 consequence, inverse rational identities and explicit chart tripling identities |

All 55 new and 56 unchanged local dependency declarations were freshly compiled
together, with all 111 explicit axiom queries checked. Their union is exactly
`propext`, `Classical.choice`, `Quot.sound`. The compiler is Lean 4.32.0;
Mathlib is pinned to `81a5d257c8e410db227a6665ed08f64fea08e997` and its compiled
cache was reused. The exact source hashes and full output are in
`verification/mathlib_validation.json` and `verification/fresh-mathlib-build.log`.

The lower-depth cardinal bound, residue rigidity and finite target size remain
explicit in the actual-product bridge. The general signed-ball cardinality
interpretation, arithmetic valuations, residue groups and unit selection remain
ordinary. The geometric arithmetic module does not formalize quadratic UFDs,
cube-root existence, curve homomorphisms, isogeny degree or ranks.

Root also reran the frozen exact descent replay: eleven rational-function
identities, a nontrivial quadratic-unit witness, and all 486 primitive hits of
the specified mod-27 model. Its certificate has no hit with ordinate divisible
by three. No rank API or finite search supplies the rank upper bound.

## Official Fermat reuse

The [official source](https://github.com/anthropics/fermats-last-theorem) remains
pinned to `aa2d8b34692b16c70f699536de0d8e75b9a3e9ef`. The separate fifteenth-round
FLT package records a completed eighteen-module compatibility milestone and
twelve named solution/export axiom queries. A subsequent bounded probe compiled
one additional unchanged definition before stopping at a local import-path
resolution error. Its network and package-root failures are preserved, not
reported as proof failures or successful completion of the batch.

The sample requests only Lean object output in isolation. Full FLT is not yet
locally imported, and none of this checkpoint's 55 declarations depends on an
assumed full-FLT theorem. See `../2026_09_07_adversarial_audit/fifteenth_round/FLT/`.

## Reproduction and remaining gates

With the exact Mathlib cache prepared, run:

```sh
python3 research/checkpoints/2026_09_07_signed_moment_descent/verify_mathlib.py --project /root/abc-lean-build
python3 research/checkpoints/2026_09_07_signed_moment_descent/verify_finite.py
```

The dedicated GitHub workflow prepares its own pinned dependency project.
The manuscript build, raster review and seal are separate steps.

The active research gates are different-prime total weights and signed credits,
the independent-domain complement, complete simultaneous rational points, and
uniform moving exponents, heights and residual coefficients. Subsequent joint
quotient and rational-simple-Jacobian candidates are outside this sealed batch.
