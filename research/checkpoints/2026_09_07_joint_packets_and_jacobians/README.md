# Sixteenth continuation: joint packets and quotient Jacobians

Standard ABC remains unproved and undisproved. This checkpoint contains
reviewed ordinary arguments and 27 new scoped Lean declarations. Its designated
manuscript has 544 pages, 3,508,264 bytes and SHA-256
`aec9b8b9f59fd51d8830abcaaab64dd15f69e0248064d09ea9b042f247cc6cd7`.

The stable three-pass TeX build used 208 actual source files. All 201 previous
child sources remain byte-identical, and the first 530 extracted-text pages
are unchanged. Root actually viewed the title and every changed page: fifteen
final PNGs, pages 1 and 531--544. No layout or reference warning remained.
This does not claim an all-page visual review.

## Mathematical results

* JP constructs a prime-independent norm-one quotient by cubic units. Combined
  precision forces signed-ball injectivity on a common-hit rectangle. The
  target size is n to the number of primes, not n. The theorem does not bound
  different primes with distinct singleton owners.
* The actual phase bridge proves d=x+y and N(z)N(w)=x^2+xy+y^2 for the three
  integer determinants, together with the exact discriminant square. It gives
  a product-modulus zero criterion and finite joint capacity while retaining
  all actual collision, height, separation and target-size premises.
* QS proves that the two remaining genus-two Jacobians are Q-simple, not
  Q-isogenous, torsion-free over Q and of positive even ranks at least two.
  The genus-six Jacobian consequently has rank at least six. This obstructs
  only the direct classical strict rank-less-than-genus criterion.
* QH supplies rational Picard-rank lower bounds and proves a finite five-adic
  container for all rational points through the first genus-two quotient.
  That container is not computed or identified with the intrinsic level-two
  genus-six locus. The separate direct finiteness assertion retains an
  unproved rank upper bound.

Ordinary proofs preceded formalization and received independent internal
reviews, not external peer review. The exact source and theorem boundaries
are recorded in `ordinary_review.md` and `ordinary_formal_scope.md`.

## Formal and finite verification

`JointPhasePackets.lean` has ten new declarations and
`QuotientCurveArithmetic.lean` has seventeen. Their exact scopes are actual
integer/group arithmetic, finite-map implications and complete square-fibre
enumeration in the displayed finite models. Jacobians, field interpretation,
good reduction, Frobenius, Picard groups, ranks and quadratic Chabauty remain
the separate ordinary proofs. No such geometric theorem is relabelled as
formal because its numerical inputs passed.

All 27 new declarations and 45 unchanged local dependencies were freshly
compiled together with warnings as errors and all 72 explicit axiom queries
checked. Their axiom union is exactly `propext`, `Classical.choice`, `Quot.sound`.
Lean is 4.32.0; Mathlib is pinned to
`81a5d257c8e410db227a6665ed08f64fea08e997`, with its compiled cache reused.
See `verification/mathlib_validation.json` and `fresh-mathlib-build.log`.

The frozen QS finite certificate was actually regenerated and compared byte
for byte. The separate CI checks start by invalidating checked-in PASS records;
standalone verifier preflights also write NOT_RUN before doing work. Three
actual negative-path checks in isolated copies ensure missing prerequisites
cannot leave historical PASS records behind. This prevents misleading evidence
uploads; it does not substitute for successful compilation.

From the repository root, with the pinned Lean project available:

```text
python research/checkpoints/2026_09_07_joint_packets_and_jacobians/verify_mathlib.py
python research/checkpoints/2026_09_07_joint_packets_and_jacobians/verify_finite.py
python research/checkpoints/2026_09_07_joint_packets_and_jacobians/verify_ci_failure_paths.py
```

The new GitHub workflow independently builds these sources on Linux against
a Mathlib-only dependency project. Its run status must be read live before
claiming remote success. Local PASS is not a claim about an unobserved CI job.

## Open target and continuation

The cross-prime signed tail, exceptional roots, independent-domain complement,
and arbitrary ABC representation remain open. So do complete rational points
and uniform heights with varying exponents and residual parameters.

The local seventeenth-round group has separately developed collective input
content, an exact complement-determinant cancellation boundary, scalar-optimal
actual FCRT families and explicit five-adic Jacobian closure. Those have their
own ordinary reviews and next formalization tasks. They are not included in
the present manuscript or the 27-declaration formal scope; see `RESUME.md`
for the current local handoff. All unrefuted parent routes remain available.
