# Independent review: private products and complete finite-depth arithmetic

Reviewer: adversarial_audit, 2026-09-07. Complete ordinary/source semantic
review PASS for the eight private-product, fifteen numeric and five finite-index statements.
The final reviewed source bytes and all 28 recorded axiom outputs were
independently audited in `verification/moment_source_audit.json`.
I did not rerun the compiler. The final aggregate record now supersedes
the earlier scoped audit made during implementation.

## Actual private-valuation products: eight statements

Source `research/checkpoints/2026_09_07_uniform_moments/Lean/PrivateValuationMultisets.lean`, SHA256 `0a28ed0c5ea812ba89c64b3dec801e86e83293dc9db8d6a99b9c7312ec4871f7`.
The ordinary preimplementation proof was read in full before the source.

The source defines the literal mapped multiset product `(s.map a).prod`
and proves its regrouping by multiplicities. Private integer-valued monoid
homomorphisms evaluate that product to count_i(s)*d_i in additive notation.
The proof of equality of counts cancels a nonzero integer d_i; no positivity,
valuation-one or chosen-sign condition is required. Equality of all counts
then proves actual multiset equality, followed by Sym injectivity.

The finite H-product injection uses an explicit rigidity implication from
equal H-products to equal actual G-products, rather than assuming the
wanted cardinality result. Stars and bars is Mathlib's actual Sym cardinality.
Natural subtraction in choose(M+nu-1,nu) correctly covers M=0 and nu=0:
one empty multiset and no positive-length multiset over the empty type.
H is a monoid and is therefore inhabited. Its final card<=3n condition
remains explicit. This does not construct arithmetic ideal valuations,
prove norm-support coloring or density, or formalize modular rigidity.

## Complete finite-depth arithmetic: fifteen statements

Source `research/checkpoints/2026_09_07_critical_bottleneck/thirteenth_round/Lean/UniformMomentArithmetic.lean`, SHA256 `646308163a102479ea842b33b2f06eb8b1adf342e459f13cf8b4a51c597d1568`.
The complete source and `ordinary_arithmetic_scope.md` were read in full.
All theorem signatures match the stated limited scope.

The exact choose identity, monotonicity and symmetry prove the three-root
gate. The explicit r=floor(sqrt n)+1 is valid for every positive natural n,
including squares; at prime n>324 it has the same required numerical bounds
as the ordinary ceiling. The low-layer inequality includes the zero cases.

countAbove is proved equal to the actual filtered-list length. The complete
sum of natural truncated excesses is bounded term by term, then over the
whole list. Thus no intermediate depth layer is omitted. The explicit
low-count and high-count conditions give 10n+3H. Multiplication by a
nonnegative real weight and the depth-height condition give 10nw+9nL.
The real normalization theorems prove constants 38 and 80 with all positive
denominators and the eligible-prime-budget interface explicit.

The list contains arbitrary finite nonnegative depths. The source does
not assert that it has constructed actual prime valuations, a torsion group,
private ideal witnesses, the determinant estimate, Brun--Titchmarsh,
an asymptotic density theorem, or unbounded signed-tail membership.

The separate aggregate ActualUniformDepthBudget module was under active
implementation during the first log audit. A failed trial exposed a genuine
sum-parsing issue: the desired conclusion must be `sum_i (e_i-3)`, with
parentheses inside the summand, not subtraction after summation. I reported
this to root before any PASS assertion for that new module. Its final source
and fresh aggregate verification will receive a separate review if supplied.

## UM final paper transcription

Source `research/checkpoints/2026_09_07_critical_bottleneck/thirteenth_round/paper/uniform_moments.tex`, SHA256 `d87e28d3df6aa21dd825bfaf789998c98b19e653ce4d302dd3c508f9d8bd121c`.
Complete final transcription PASS. I first read the full TeX against the
previously reviewed UM1--UM4 proof, then actually reread the final domain
amendment explicitly making q prime and nu a positive integer in the
multiset theorem. Uniformity in finite nu, the three-root threshold, all
positive layers, the 80 bound, the low interval up to 8B, the whole-block
normalization, the half-domain and its explicit farther signed gate are
faithfully retained. The fifteen-claim formal paragraph accurately matches
the source reviewed above.

## Final actual-index bridge: five statements and 28-query audit

I subsequently read the complete final ActualUniformDepthBudget.lean source,
SHA256 c2c8b749c243e5904e6bab565b1710e9386372ab661419e30709ffd3925c46a4.
All five theorem signatures and proofs pass independent semantic review.
The deep subset is the actual subtype of indices satisfying a threshold.
Restriction of private homomorphisms proves the Sym bound on that subtype;
the cardinality is then linked to the exact sum of indicator functions.
The finite-index conclusion now sums the truncated term (e_i-3) at each
index. The proof uses the full pointwise bound and the actual subtype
cardinalities; the final two moment bounds supply the low and high counts.
These are arbitrary finite integer depths until ordinary arithmetic supplies
prime valuations, private ideal homomorphisms, rigidity and finite group size.

The final root manifest SHA256 is
a174f2a0cd0de898bf980e0337a69d86bef4bcbad5c7d047119691ab2ad2aa74,
and the recorded fresh log SHA256 is
ff8073891cb97d9a954cc914cb96ccc21e5cbc6fbaaef9de41b029753734325d.
I independently recalculated all three source hashes, extracted all 28
unique declarations and axiom queries, and checked every recorded output.
There are no errors or sorryAx dependencies in the final log; all outputs
use only propext, Classical.choice and Quot.sound. The pinned Mathlib
cache was reused by root's fresh local-source build. This is not an
independent compiler rerun or a whole-repository rebuild.
