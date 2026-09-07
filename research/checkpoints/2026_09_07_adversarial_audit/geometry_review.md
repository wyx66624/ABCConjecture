# Independent review of product-tripod rigidity

Reviewer: the separate adversarial-audit agent. Date: 2026-09-07.
Reviewed source: `../2026_09_07_independent_route/README.md`, sections 1--7.
Initial reviewed source SHA-256:
`5163efcacf9ccf8fdca42e6c24b76a7e0675875439b0f97cf3ef71089fdac81a`.

**Verdict:** the ordinary proofs of PR, PR2 and the mixed-map arithmetic
identities are mathematically valid with their stated hypotheses. This is
independent in-session agent review, not external peer review and not a Lean
verification of the full scheme-theoretic statements.

## Checks

1. For a field k and n >= 1, the displayed coordinate ring is the localization
   of a polynomial UFD at coordinate boundary factors. Its complete unit
   description follows directly from unique factorization; no additional
   support factor can be hidden in a unit.
2. A map to U is precisely a regular f with f and 1-f both units. Both are
   consequently products of one-variable factors. No choice of generic point
   is used as a replacement for global regularity.
3. The rectangle lemma's two determinant equations imply the stated
   row-or-column dichotomy in any integral domain, including characteristic
   two. If one coordinate factor takes different values, the entire column
   variation in every other coordinate is excluded by cancellation of
   nonzero factors.
4. Passing to an algebraic closure is legitimate and gives infinitely many
   points. A nonconstant rational function cannot be constant on all these
   points: after clearing denominators, that would give a polynomial with
   infinitely many roots. Nonconstant rational functions do take two
   different values on U. Thus the step does not assume the desired
   one-coordinate result.
5. Once only one coordinate remains, specialize all the other coordinates to
   2 (available and outside {0,1} in characteristic zero). This localization
   retraction confirms that both f and 1-f are units of the one-variable
   localized ring. This explicit sentence was recommended to the author.
6. Coprime numerator, denominator and their difference stay coprime over the
   algebraic closure. Their total distinct zero support is at most {0,1}.
   Mason yields maximum degree at most one; characteristic zero excludes
   its all-derivatives-zero alternative for a nonconstant f. The degree-one
   map permutes exactly the three boundary points, producing the six maps.
7. A dominant endomorphism of the n-dimensional product has n algebraically
   independent outputs. Constant outputs or repeated source coordinates
   would violate independence. The coordinate choices are therefore a
   permutation; each coordinate transform has an inverse regular on U.
8. For PR2 the deleted closed set has codimension at least two, so every
   codimension-one point remains. The four functions f, 1/f, 1-f and 1/(1-f)
   have nonnegative valuations there. In a UFD their reduced denominators
   have no nonunit prime factor. They lie in the original ring and yield a
   unique extension. This proof uses the factorial affine domain actually
   present and makes no unsupported extension claim for arbitrary schemes.
9. The mixed map output (ab, a^2+ab+b^2, c^2) has coprime entries because the
   new norm is coprime to abc. The radical product, quadratic height, quality
   and fixed-epsilon defect identities are exact. A bound on norm size does
   not bound its radical from below.

## Hypothesis boundaries and recommended explicit addition

In characteristic p > 0, f=x_i^p is a regular map U^n -> U because
1-x_i^p=(1-x_i)^p. It has degree p, so the six-Mobius classification is false
without the characteristic-zero hypothesis. This is a complete-premise
counterexample to that extension only. The one-active-coordinate rectangle
argument continues to hold after passage to the infinite algebraic closure.

For n=1, a codimension-at-least-two closed subset is empty; PR2 is consistent.
The theorem was deliberately stated only for n >= 1. Constants are
k-rational values outside {0,1}; dominance excludes them where needed.

The result excludes only globally regular mixing on fixed tripod products
and extensions obtained by removing codimension-two loci. It provides no
reason to discard correspondences, divisorially restricted maps, varying
spaces or geometric methods with separately controlled arithmetic costs.
