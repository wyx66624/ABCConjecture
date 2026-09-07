# Root ordinary-proof review of the sixth continuation

Root read the complete RW1--RW6 and the independent rank-stratified proof,
SC1--SC5, FM1--FM6 with the separate FM7 proof, and BS1--BS4. They pass
mathematical review at their stated scopes. Complete TeX transcriptions
were independently reviewed by other members of the research group;
root authored the SC and formal-scope transcriptions. This is independent
agent review, not external peer review.

RW: checked actual primitivity and nonzero boundary, the height corridor,
simple roots after removing p-powers from the exponent, and full endpoint
cost at every retained depth. The exact rank count is 3 phi(d) minus the
identity exception at d=1. The p=1 nonprime is excluded when counting the
two progressions. Their spacing cancels d from the height cap. All varying
height denominators are used only for nonnegative costs. The constants,
Markov exponents and larger windows are correct. Neither prescribed
exceptional roots nor the primes above Z are controlled. A visual concern
about the ratio derivative was rechecked against the original-resolution
image and source by both reviewers. The source and PDF already correctly
read 3(bar z-z)/(3X+bar z)^2; the concern was withdrawn and no mathematical
or TeX change was made.

SC: checked degree/signature and the nonsquare norm-13 quadratic
discriminant, the exact order discriminant, and Minkowski's bound below
two. Root actually opened Milne's Algebraic Number Theory Theorem 4.3.
The good-prime order-index argument gives exactly one degree-one ideal
factor; the ramified thirteen case instead uses its actual norm depth one.
This yields ideal norms exactly V,Q without disjoint-support assumptions.
One principal factor and one rank-one unit class determine all conjugates.
The count and height bounds are upper bounds, not assertions of seed
existence. For the rational (g,g) model, checked nonemptiness, Jacobian
rank at coordinate zeros, connected Kummer chart and absence of hidden
components, genus and fixed-basis coefficient height. A rational point
need not be an actual integral primitive seed.

FM: checked both inverse charts, actual polynomial invariants, the
two-isogeny twist coefficients and non-CM/minimum-degree argument. The
two exceptional Tate branches use the correct valuation normalization,
integral basis and residue field F4. At every q>3 dividing F, q splits,
c4 is a unit and the two minimal discriminant valuations are m and 2m.
The representation argument separately checks conjugation invariance,
oddness, finite flatness, the single-break twist bound at two and tame
induction at three. It uses the general Q-curve big-image theorem, not
the nonexistence theorem for a different generalized Fermat equation.

Root actually opened Pacetti--Villagra Torcomian's author PDF, Theorem
5.2 (the general squarefree-degree statement and N3=7), its character and
extension sections, and Koutsianas Proposition 5.4. The small-prime
improvement is retained as published external input, not a locally
reproved modular-symbol certificate. Root also opened Cremona's actual
Tate-algorithm chapter, Serre's institution-hosted 1987 paper, and the
Khare--Wintenberger author PDF. The 1987 local-weight recipe and
characteristic-zero eigenform lifting are distinguished from the modern
completed strong modularity theorem. Reduction at 2 and 3 preserves the
finite inertia conductor for p>7. Exact residual conductor excludes an
oldform lift at a proper smaller level. The Sturm-based dimension count
includes residual choice, both weights and coefficient-field degrees.
Q=1 remains allowed in the necessary theorem but is excluded from any
proposed nontrivial-power conclusion. Composite exponents require fresh
p-free residual canonicalization. No uniform candidate elimination follows.

BS: checked complete norm-25 and norm-seven point counts, the root-of-
unity tests for Frobenius eigenvalue ratios, and incompatible split/field
centralizers over Q17. The Tate-module comparison is an external structural
input, not inferred from a database CM flag. The consecutive local shadows
are actual positive primitive integers but not global power solutions.
The complete modulo-eight character table and norm-thirteen signs agree
with both independent calculations. Level-576 identification remains a
conditional membership inference. This only limits the specified residue
product; the modular parent route remains open.

All six finite replays were independently rerun by root with matching
recorded digests. Their scope is finite exact arithmetic and exact software
diagnostics. All ordinary arguments were reviewed before the new Lean
module was written. Its final fresh build covers precisely 18 new and 65
unchanged declarations; an independent signature/hash review confirms
that no Tate, geometric, modularity or ABC theorem is smuggled into its
scope. No global ABC conclusion is established here.

Primary sources opened by root include:

- https://www.jmilne.org/math/CourseNotes/ANT.pdf
- https://sweet.ua.pt/apacetti/papers/Q-curves.pdf
- https://arxiv.org/pdf/1805.07127
- https://johncremona.github.io/book/fulltext/chapter3.pdf
- https://www.college-de-france.fr/media/jean-pierre-serre/UPL5835292064138487263_Serre_Repr.modulaires_Galois.pdf
- https://www.math.ucla.edu/~shekhar/papers/results.pdf
- https://www.jmilne.org/math/Books/EC2.pdf
