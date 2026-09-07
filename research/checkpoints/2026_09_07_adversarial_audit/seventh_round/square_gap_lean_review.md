# Independent review of the actual square-gap Lean proof

Date: 2026-09-07. Full source and statement review PASS.

Read all of critical_bottleneck's seventh-round
`Lean/SquareGapArithmetic.lean`, including its sixteen declarations
and sixteen axiom queries. No source change or duplicate full build
was made by this reviewer; the author and root own the fresh build
and complete dependency inventory.

Reviewed source SHA256:
`a7b0dbb5ca5065d1a33a8437976e1c229f5b2eea5e5ed94a1c28e9159ff6612a`.

The imported `second` is explicitly rewritten to the actual quartic,
so the polynomial identity applies to actual seeds. The finite mod-eight
table is proved by kernel evaluation and its Int bridge invokes the
already proved primitive-not-both-zero lemma. In particular the
residue restriction is derived from gcd(a,b)=1, not assumed in the
final axis bound.

For q>=0 the proof derives 8q<S from the actual square equation and
strict positivity of D=S²−64F. The primitive residue restriction gives
S−8q>=3, and multiplying nonnegative factors proves D>=6S−9.
Under the opposite proposed axis bound, the two explicit nonnegative
products yield D<6S−9; this is a contradiction. Thus the actual
primitive square implies 2a<3b³. The next declaration replaces negative
q by −q, so the public conclusion holds for every integer q, not merely
a chosen positive square root. Symmetry proves both coordinate bounds.

The last declarations prove that 13 is not a square by the exact
mod-eight table, then combine both strict axis bounds to exclude
either coordinate equal to one. Positivity forces both coordinates
to be one in the exceptional case, and the actual second norm there
is 13, giving the contradiction. No hidden bound on a,b,q or finite
seed-search assertion is used.

These declarations genuinely formalize the actual elementary SG1
inequality and coordinate-one exclusion. They do not formalize the
full r-sensitive inequality, SG2/SG3's thirteen-class parametrization,
elliptic descent, analytic estimates, or ABC. The module documentation
and mathematical statements maintain this scope.
