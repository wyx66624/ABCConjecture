# Thirteenth continuation: uniform moments and cubic local gates

Standard ABC remains unproved and undisproved. This checkpoint integrates
four independently reviewed ordinary developments and 37 new finite Lean
declarations. The full manuscript is maintained at the user-designated
historical PDF filename. Its final page count, input hashes, predecessor
preservation and actual visual review are recorded separately in
`verification/manuscript_validation.json`.

The sealed PDF has 513 pages and SHA-256
`fefb61573ea9408f26f5c7d85f5383899bd9f29e8175033cc1f86998a993a74a`.
All 191 actual TeX inputs are recorded. The three-pass build has no
overfull boxes or unresolved references. All 184 predecessor child
sources are byte-identical, and the first 497 extracted-text pages are
unchanged. The title and every changed page were actually viewed,
covering 17 page rasters in total; this is not an all-page visual review.

## Reviewed mathematical results

- UM proves determinant rigidity for every finite moment at q>8B, with
  constants uniform in the moment. Actual private valuations give the
  symmetric-product count. Low and high layers together bound all positive
  excess up to Bn(log n)^(1-delta) on a domain asymptotically at least half
  the actual prime-index block. The unbounded signed tail remains explicit.
- NC colors actual norm support using an explicit degree bound, with
  private valuations in each color. Complete small-prime endpoint estimates
  give a uniform density bound on compact theta ranges. Combining colors
  with UM yields domain fraction (5-kappa)/8 at the window
  B n^kappa(log n)^(1-delta), for fixed 0<kappa<=1. The norm-smooth
  complement remains open. The comparison with MC below kappa=1/2 is explicit.
- CL proves that the identity-unit quotient has no Q_3 point, and excludes
  the corresponding smooth projective curve for every positive odd
  exponent divisible by three. Both nontrivial unit classes remain open.
- EQ gives two explicit elliptic quotients of a nontrivial cubic-unit
  genus-two curve, a Q-defined product isogeny, and an exact rational
  square condition for lifting through one quotient. Each elliptic factor
  has a proved point of infinite order, so the Jacobian rank is at least
  two. This excludes only its rank-less-than-genus criterion. Simultaneous
  square conditions at a common source and higher descents remain live.

Complete proofs and TeX transcriptions are in the three agents'
`thirteenth_round` directories. Root's `ordinary_review.md` records its
full reviews. The two root ordinary interface proofs were written before
their formal implementations. Internal agent review is not external peer
review. Later adaptive-precision, owner-concentration and further density
candidates stay outside this sealed batch.

## Exact formal verification

| Module | New declarations | Main scope |
| --- | ---: | --- |
| PrivateValuationMultisets | 8 | Actual products and injectivity from private integer homomorphisms |
| UniformMomentArithmetic | 15 | Numerical counts, actual lists, complete layers and normalization |
| ActualUniformDepthBudget | 8 | Actual depth subtypes and private-witness-to-weighted-budget connection |
| CubicUnitLocalArithmetic | 6 | Actual integer sextic, mod-27 kernel table and primitive-square obstruction |

All 37 declarations and all 37 explicit axiom queries passed a fresh joint
compilation with Lean 4.32.0 and Mathlib revision
`81a5d257c8e410db227a6665ed08f64fea08e997`. Their axiom union is only
`propext`, `Classical.choice`, and `Quot.sound`; the finite table itself
has no axioms. No `sorry`, admitted theorem, new axiom, or native decision
axiom is accepted by the verifier. All four local sources are compiled
fresh with warnings as errors; the pinned Mathlib cache is reused.

The depth bridge uses actual finite index subtypes and a sum of natural
truncated excesses before casting to the reals. It derives the binomial
counts from supplied private witnesses and actual-product rigidity.
Arithmetic ideal constructions, modular rigidity, finite torsion targets,
depth interpretation, height caps, analytic estimates and geometry are
explicit external inputs to this finite core. The six local declarations
do not formalize Q_3, projective curves or their maps.

`verification/mathlib_validation.json` and `fresh-mathlib-build.log`
record the successful final bytes. Initial compile failures were corrected
before that fresh run; none is counted as successful verification.

The separate exact replay checks nine actual quotient polynomials, both
elliptic maps, the even sextic transformation and inverse discriminant,
two exact doubles/discriminants, and all 648 primitive mod-27 pairs.
Its GP 2.15.4 search has numerator/denominator bound 1000; a separate
exact Python search checks 70,767 curve-abscissa cases at bound 80.
The 24 observed affine points do not constitute an all-rational-points
theorem. Diagnostic rank outputs are not ordinary rank certificates.

## Reproduction

From the repository root with the pinned Lean project:

```sh
python3 research/checkpoints/2026_09_07_uniform_moments/verify_mathlib.py --project /root/abc-lean-build
python3 research/checkpoints/2026_09_07_uniform_moments/verify_finite.py
python3 research/checkpoints/2026_09_07_uniform_moments/build_manuscript.py
```

The finite replay requires PARI/GP 2.15.4. The dedicated GitHub workflow
prepares a Mathlib-only project and installs the Ubuntu 24.04 GP package.
Rendering and actual visual inspection are mandatory separate steps before
`seal_manuscript.py`; a TeX build alone does not assert visual review.

The nearest remaining obligations are the full signed far tail, exceptional
roots and norm-smooth support, plus uniform control of the surviving
positive common-source geometric loci and moving residuals. No unrefuted
parent route has been discarded, and this is not a complete ABC proof.
