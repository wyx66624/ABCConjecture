# Eleventh continuation: integral lifting and the global radical

Standard ABC remains unproved and undisproved. This checkpoint records
reviewed ordinary results, 31 new Lean declarations and two exact finite
replays. The designated full-paper build is sealed separately in
`verification/manuscript_validation.json`, including its page count,
source hashes, predecessor preservation and actual visual-review coverage.

## Reliable mathematical results

- PC bounds actual projective content by the multiplier norm and gives an
  infinite norm-seven family disproving automatic preservation of the
  prescribed nonunit exponent by a single rational power map.
- IL proves the exact opposite-orientation content and the universal
  residual bill `rad(C)^n | V Vprime`. Its strict joint logarithmic
  threshold forces content one, even when the output root norm changes.
  CR determines the canonical residual and root exactly on the n-free
  subdomain, and gives actual counterexamples without that premise.
- CI gives the full positive rational-to-integral converse for pure
  coefficients, including ramified and infinite input coordinates. The
  prior combined-square obstruction then excludes only the even/even
  positive rational locus. Other exponent pairs remain active.
- LC gives one actual large-cutoff set for all moving reciprocal caps.
  AGS passes from its signed tail to the global radical with exact finite
  constants. SQ proves joint squarefreeness on a growing prime interval
  beyond the root block for most prime-index roots. Its window mass is
  sublinear; the farther top-rank packet and exceptional roots stay open.
- GE supplies a simultaneous actual Gaussian profile when the first norm
  is a square, with a quadratic support condition for general even first
  exponents. BK builds the corresponding fixed-biquadratic-field cover:
  gcd(g,2) geometric components, each of degree g^2/gcd(g,2) and genus
  1+(3g^2-4g)/gcd(g,2). Actual pure seeds lift through a finite unit list.
  No arbitrary-point inverse or uniform point-height bound is claimed.

Complete ordinary proofs, manuscript transcriptions and independent
internal reviews are in the three agents' `eleventh_round` directories.
The root's `ordinary_review.md` records its full mathematical review.
The root formal interfaces were written before their implementations in
`residual_bill_formal_scope.md` and `ordinary_log_threshold.md`.

## Exact formal and finite scope

The joint fresh verifier compiles seven local modules:

| Module | New declarations | Existing dependency declarations |
| --- | ---: | ---: |
| ActualProjectiveContent | 9 | 0 |
| ResidualReflectionArithmetic | 7 | 0 |
| ActualResidualLogThreshold | 6 | 0 |
| ActualGlobalSignedBridge | 9 | 0 |
| EisensteinDescent | 0 | 29 |
| ActualPrimeLogCompensation | 0 | 17 |
| ActualPrimeLogHeight | 0 | 7 |

It checks actual `Int.gcd`, integer division and norm identities, actual
`Nat.factorization` and prime products, the residual bill from its explicit
local depth premise, the strict real-log threshold, and the global signed
radical transfer. All 84 declarations have complete axiom queries; only
`propext`, `Classical.choice` and `Quot.sound` occur in their union.

The compiler is Lean 4.32.0 and Mathlib is pinned at
`81a5d257c8e410db227a6665ed08f64fea08e997`. Each listed source module is
freshly compiled with warnings as errors in a temporary source directory;
the pinned compiled Mathlib cache is reused. This is neither a full
Mathlib rebuild nor formal verification of every manuscript theorem.

The oriented UFD law giving the local reflected depths remains an ordinary
theorem. It is an explicit premise in the formal residual module, not a
custom axiom or a consequence silently inferred from the gcd module.
The sieve, actual rational inverse and geometric covering proofs also
retain ordinary-proof status. The formal global signed theorem still
assumes its height, tail and small-mass bounds.

The exact replay checks 24,192 multiplier/primitive-coordinate instances
and 128 members of the norm-seven family, at n=2,...,129. The canonical
source and JSON certificate bytes are compared. This finite enumeration
does not prove the ordinary infinite construction or double compatibility.

The second replay checks exact polynomial factorizations and nonzero
discriminants/resultants in Q(alpha), alpha^4-alpha^2+1=0, 119 relation
kernels, 52 actual square-first integer seeds with full trial division,
and 74 integer inverse cases. It does not determine a rational-point locus.

## Reproduce and inspect

In the pinned Lean/Mathlib Linux environment, run:

```sh
python3 research/checkpoints/2026_09_07_integral_lifting/verify_mathlib.py
python3 research/checkpoints/2026_09_07_integral_lifting/verify_finite.py
```

An existing compatible dependency project can be selected with
`verify_mathlib.py --project /path/to/project`; its Mathlib commit and
tracked source cleanliness are checked before compiling. For a separate
CI project use `prepare_mathlib_project.py`, followed by the dependency
and selective cache commands in `.github/workflows/abc-integral-lifting.yml`.

`build_manuscript.py` builds the complete manuscript three times and seals
the actual input inventory. `seal_manuscript.py` additionally requires
fresh formal/finite evidence, the matching rendered visual-review record,
unchanged predecessor child sources and the unchanged text prefix before
copying the PDF to the user-designated filename. Compilation alone is not
called visual inspection. Previous published checkpoints stay frozen.

The main analytic target remains the signed cost of the actual far packet
at all moving roots, including exceptional roots. Independent geometric
targets are uniform height control or an actual compatible counterfamily
meeting the complete integral requirements. No unrefuted parent route is
discarded because a tool, bound or intermediate theorem is still missing.
