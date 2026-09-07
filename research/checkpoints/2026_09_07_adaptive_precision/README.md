# Fourteenth continuation: adaptive precision and simultaneous elliptic gates

Standard ABC remains unproved and undisproved. This checkpoint integrates
five independently reviewed ordinary developments and 35 new finite Lean
declarations. The complete designated manuscript, its final page count,
source hashes and actual visual review are recorded in
`verification/manuscript_validation.json`.

The sealed PDF has 527 pages, 3,409,592 bytes and SHA-256
`86a0273b4cd06f877fbcfa19b2aaecb74749665200ad9cabfbdd64e62fe3b8a3`.
The stable three-pass build records 197 actual TeX inputs, with no overfull
boxes or unresolved references. All 190 predecessor child sources are
byte-identical, and the first 507 extracted-text pages are unchanged.
The title and every changed page were actually viewed: 21 rasters in all.
This does not assert an all-page visual review.

## Reviewed ordinary results

- AP separates moment length from prime precision and uses the actual
  single-arm height cap. Every q>8B has complete positive cost at most
  13n log(8B), with no upper-prime restriction. Its normalized bound is
  26/B; the finite progression sum has constant 55.
- OC chooses the two actual largest depths. All other positive layers
  cost at most 39n^(5/6) log(8B) at a fixed prime. The remaining bound
  cannot be summed over an uncontrolled number of prime labels.
- DG proves a cofactor-uniform upper sieve with fixed discriminant -27,
  full least-common-multiple remainders and an epsilon-uniform exceptional
  set. It gives an actual private norm domain of density at least
  1/2+delta0 for an absolute delta0>0. It uses full-block mass once.
- VG proves simultaneous actual prime-power divisibility, bounds the
  degree on individual arms and constructs a matching decomposition.
  Its abstract weighted example only limits the displayed finite
  inequalities; it is not an arithmetic counterexample or an ABC family.
- SS gives a reversible positive quartic gate over a fixed elliptic
  curve for the surviving cubic-unit branch, keeping the same source
  for both squares. It proves an exact integer prime-depth allocation
  and a rational three-isogeny between the two elliptic quotients.

Complete ordinary arguments precede the formal implementations. All six
complete TeX inputs were independently reviewed; root records its full
reviews in `ordinary_review.md` and `verification/root_transcription_review.json`.
Internal agent review is not external peer review. The full signed tail,
complementary roots, simultaneous rational points and moving-residual
height problem remain substantive open obligations. Subsequent bounded-
length and three-descent candidates are separate from this batch.

## Exact formal scope

| Module | New declarations | Verified scope |
| --- | ---: | --- |
| PrivateDensityMass | 11 | Cofactor identities, actual finite mass cuts, strict density with both remainders and a finite logarithmic weight cutoff |
| AdaptiveOwnerArithmetic | 12 | Actual ceiling thresholds, two maximal indices, deep-set containment and complete weighted finite costs |
| SimultaneousEllipticArithmetic | 12 | Actual quartic/conic identities, integer square divisibility and exact prime depth from the primitive equations |

All 35 new declarations and 15 unchanged UniformMomentArithmetic
dependencies were freshly compiled together using Lean 4.32.0 and Mathlib
`81a5d257c8e410db227a6665ed08f64fea08e997`. All 50 explicit axiom
queries passed with union `propext`, `Classical.choice`, `Quot.sound`.
Local sources were freshly compiled with warnings as errors; the pinned
Mathlib cache was reused. No admitted proof or added axiom is accepted.
The full-source adversarial audit checks all final hashes and queries.

The density theorem includes loss+epsilon R/B+c/ell explicitly. The
owner theorem actually constructs the selected finite set and retains
natural truncated subtraction inside each sum. The SS depth theorem
derives its required unit from gcd and the actual elliptic equation;
it does not assume a unit or valuation conclusion. Their analytic,
arithmetic-group and geometric dependencies retain the exact ordinary
scope stated in the paper; 39/78 fractional-power estimates are ordinary.

Two independently implemented standard-library replays passed with frozen
certificates: fifteen polynomial identities and eighty specified signed
multiples in one; eight coefficient identities and three rational group-
law checks in the other. This is not a complete rational-point search,
rank computation or proof of an asymptotic estimate.

## Official Fermat dependency reuse

The [official Anthropic repository](https://github.com/anthropics/fermats-last-theorem)
is pinned to `aa2d8b34692b16c70f699536de0d8e75b9a3e9ef`.
Its complete theorem and `flt_mathlib` wrapper were inspected. A useful
small dependency, vanishing of weight-two cusp forms on Gamma0(2), was
actually compiled from two unchanged official sources in isolation with
the present compiler, and directly called on Mathlib's actual type.
Its two axiom queries passed; two upstream deprecation warnings are
preserved. It is separate from the 35 new local declarations.

The full Fermat import and the official independent kernel replays have
not been locally rerun. Exact pins, compatible small-source closure,
full output, resource measurements and reproducible import script are in
`../2026_09_07_adversarial_audit/fourteenth_round/FLT/README.md`.
Exact pure-power exclusion does not by itself control the signed near-
power tail. Larger applicable closures remain a reuse target.

## Reproduction

From the repository root with the pinned Lean project:

```sh
python3 research/checkpoints/2026_09_07_adaptive_precision/verify_mathlib.py --project /root/abc-lean-build
python3 research/checkpoints/2026_09_07_adaptive_precision/verify_finite.py
python3 research/checkpoints/2026_09_07_adaptive_precision/build_manuscript.py
```

The two finite replays require only Python's standard library. The
dedicated GitHub workflow prepares an isolated Mathlib-only project and
repeats the scoped formal and finite verification. Rendering and actual
visual inspection remain separate requirements before the final seal.
Successful compilation alone is not a visual review or an ABC proof.
