# Final thirteenth-continuation formal and root-paper review

Reviewer: adversarial_audit, 2026-09-07. Complete final review PASS.
This is a new record for the 37-statement build; the earlier 28-statement
records are preserved and are not relabeled as a larger verification.
No independent compiler rerun is claimed.

## Final actual-index coupler source

File: `research/checkpoints/2026_09_07_uniform_moments/Lean/ActualUniformDepthBudget.lean`
SHA256: `20a0b16f9b72aa11fe322bfad777090060ab415b915a2409d75eed63c5233af4`.

I read the whole final eight-theorem source. Its earlier five finite-index
statements retain the corrected termwise natural subtraction. The last three
statements now discharge the two binomial-count premises by applying the
proved private-valuation symmetric-product theorem on the actual two depth
subtypes. Separate finite commutative targets are permitted at depth four
and at twice (floor(sqrt(n))+1); the explicit rigidity and cardinality
conditions must be supplied at both precisions. The restricted witnesses
retain their nonzero diagonal and zero off-diagonal valuations.

The resulting full finite sum is sum_i (e_i-3) with natural truncation at
each index. In the weighted and normalized statements the term and sum are
both explicitly natural before the full sum is cast to Real. Thus no
negative low-depth contribution or subtraction after summation is hidden
by an expected type. The nonnegative weight, cap-times-weight bound and
positive normalization denominators are all explicit. These are actual
products and actual finite index sets with supplied natural depths, not a
formal construction of prime valuations from a factorized integer.

## Complete fresh-output audit

The canonical independent evidence is `verification/final_formal_review.json`.
I checked all four final source hashes, all 37 unique declarations and
matching axiom queries, and every recorded output in root's final fresh log.
The log contains no errors or sorryAx dependencies. The axiom union is
exactly propext, Classical.choice and Quot.sound; the complete mod-27 table
has no axiom dependencies. Counts are 8+15+8+6=37, with zero older local
source declarations in this scoped build. Root reused the pinned Mathlib
cache; this is neither an entire Mathlib/repository rebuild nor a repeat
compiler execution by this reviewer.

Manifest SHA256: 19ce620410d052bfafdee049243980fc6e01ec689eb45f32e27d1f2d93870121.
Fresh log SHA256: 7e66abb22e3dd3cb76e3d9fe17229b5916316362c989e48c26d696f9d81ba5bb.

## Complete root-paper transcription

I read both TeX files in full and then actually reread the final two domain
clarifications: the ordinary moment is a positive integer, and the cap C
in the isolated finite proposition is a natural number. These prevent the
ordinary binomial/empty-domain conventions from silently broadening the
formal statement.

- `paper/actual_private_depth_bridge.tex`: `935d66417edea27dfa5c12e5808770c862711bc51b1a28e4d14ee33ab401276e`.
- `paper/thirteenth_research_status.tex`: `161ac1f55af1092d6449d1cddd45fb969dedbe11c1c2469a758a64b9809f2d93`.

Both are in the 2026_09_07_uniform_moments checkpoint. Final transcription
and scope PASS. The first proves ordinary multiset injectivity directly
from private homomorphisms, then the complete finite cap argument, weighted
bound and normalization. The 37-claim paragraph matches the actual modules
and distinguishes the kernel mod-27 table from the ordinary Q3 geometry.
It accurately leaves arithmetic valuations, finite torsion/lifting, cap,
sieve and domain-membership statements as separately proved or open inputs.
The status paper distinguishes the proved analytic windows and the local
identity-unit branch from the unresolved common-source nonidentity locus
and unbounded signed packet. It does not enlarge the NC coverage claim.

I independently opened Milne's Abelian Varieties notes and read Theorem 16.7
on printed page 69 (PDF page 75), confirming the finite-generation input
for abelian varieties over number fields used by the status paragraph:
[primary source](https://www.jmilne.org/math/CourseNotes/AVc.pdf).
No software rank output is needed for the ordinary rank lower bound.
Subsequent adaptive-precision and owner-concentration notes remain separate
next candidates and are not included in this source/scope certification.
