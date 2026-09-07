# Independent review of reciprocal depth compensation

Date: 2026-09-07. RC1--RC4 full ordinary review: PASS.
Reviewed source:
`2026_09_07_critical_bottleneck/tenth_round/reciprocal_depth_compensation.md`,
SHA256 `7536a882be0e3edb55f7ed5505547010e4ec043c401a8d729ba79a6cf0c4d5d9`.
No correction was required.

For every finite cap h, the supported-prime inequality
e<=h+(e-h)_+ gives 3R>=beta(S-E), beta=3/h. Infinite caps have
beta zero and retain their full negative radical term. Actual quotient
coprimality makes the signed costs additive. Thus the coefficient of
each mass S_i is 1-beta_i. If nonnegative, the correct upper bound
is S_i<=t; if negative, the actual lower height bound is required.
Summing exactly yields (3-C)t+A(Delta+log c1), and the remaining
small-prime term is at most B*L because all L_i are nonnegative and
their sum is at most L. The overlap step with T1 is valid without
coprime supports. This proves every term and sign of RC2.

The input-height bound is
(A+3+2A log(2/sqrt(3))/log 7)/n <= (2A+3)/n. The same reviewed
positive-sector representation supplies the all-prime and archimedean
two-place inputs with lambda=1/n. Since h>=1 or infinity, beta is
between zero and three; hence A<=6 and B<=2 uniformly, even for
caps changing with each root and exponent. For C>=3 and satisfied
finite caps the excess contribution is nonpositive. The positive-part
conclusion, the weaker net-credit condition, and the negative margin
for C>=3+delta all follow with the stated one-sided scope. Bounded
indices with moving roots are not swept into a finite exception set.

The five maximal cap patterns are exhaustive. After sorting, h1>=4
is impossible; h1=3 forces (3,3,3). If h1=2, h2=2 allows infinity,
h2=3 forces h3<=6, and h2>=4 forces (2,4,4). If h1=1, every
pattern is below (1,infinity,infinity). Each listed maximal pattern
has reciprocal sum one. The special one-squarefree-arm inequality
has A=B=2 and C=3, giving exactly the coefficients in RC9. The
patterns (2,3,6) and (2,4,4) have A=B=1/2 as asserted.

The sharpness construction for C<3 is correctly confined to an
abstract finite integer-weight ledger. Taking t as a multiple of all
finite caps makes their weights integers, while an infinite-cap list
has depth t and weight one. Each mass equals t and the signed sum
is (3-C)t-3r. This is a real counterexample to the corresponding
abstract implication, with no assertion of prime factorization,
actual additive arm relations or an Eisenstein norm. It does not
exclude an arithmetic improvement in the C<3 regime.

The result gives additional rigorous sufficient subclasses, including
one squarefree arm and two unrestricted arms. It proves no automatic
membership statement. The actual TD construction can make every arm
have a depth at least four above the moving cutoff. Any finite caps
that then bound the actual depths must be at least four, so their
reciprocal sum is at most 3/4, even allowing infinite caps. Thus the
whole cap-pattern union need not contain every actual root. This
does not challenge RC's quantitative net-credit sufficient conditions.

This review concerns ordinary proofs. The ninth-round Lean module
formalizes only the specified special integer-weight inequalities,
not this entire new family or its real logarithmic inputs.
