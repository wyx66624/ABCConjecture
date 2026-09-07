# Independent review of the non-finite-flat modular budget

Date: 2026-09-07. Read the complete ordinary note
`2026_09_07_independent_route/sixth_round/nonflat_weight_budget.md`
and its full `paper/nonflat_weight_budget.tex` transcription.
Result: second independent ordinary and final transcription PASS.
The earlier FM1--FM6 inputs retain their separately reviewed scope.

Independently opened Serre's primary1987 paper, Section2.9 Proposition5,
printed191, and Section3.1.6, printed194--195:
https://www.college-de-france.fr/media/jean-pierre-serre/UPL5835292064138487263_Serre_Repr.modulaires_Galois.pdf
The former gives weight2 at good reduction and, at multiplicative
reduction, weight2 exactly when p divides the j valuation, otherwise
weight p+1. Its proof allows an unramified quadratic extension. The
latter lifts an eigensystem with the same weight, level and multiplicative
lift of its character. This is not attributed as a proof of full
Serre modularity; the completed Khare--Wintenberger theorem and its
Kisin input are separately identified and were opened in the author
paper https://www.math.ucla.edu/~shekhar/papers/results.pdf .

For an actual p-power-free residual V, r=vp(V)>0 gives p|F and hence
a split multiplicative prime. The two minimal discriminant valuations
m,2m have m=r+p vp(Q), so neither is divisible by p>7. The fixed
character is unramified here. This proves precisely the claimed
weight p+1 branch. If r=0, good reduction or finite-flat Tate torsion
gives weight2. The previously reviewed descent and large-image premises
hold for actual positive seeds independently of the factorization.

Away6p, residual monodromy survives exactly at primes dividing V.
Removing p^r gives the exact factor rad(R), including support shared
with Q. The earlier local conductor bounds at2 and3 remain unchanged.
The determinant and k-1 congruent1 modulo p-1 identify the same
quadratic character. A lift from a proper lower level would contradict
the exact residual conductor, justifying newness at the stated level.

The dimension arithmetic is correct: the factors at2 and3 have
product2, so I<=2N rad(R)<=1152V^2. The generous Sturm dimension
bound gives at most1+96(p+1)V^2 per level. The five-level sum is
at most485(p+1)V^2; summing V^2 for1<=V<=floor(e^(Lp)) costs
at most e^(3Lp). The logarithmic dimension budget is sublinear in p
when L tends to zero. This counts candidate orbits with field degrees,
not actual points or congruence exclusions.

The statement deliberately allows Q=1 as a necessary modular condition
but restricts the research target to Q>1. Composite exponents first
require reducing the original V to its p-power-free representative;
smallness after replacing g by p does not follow without the stated
additional comparison. Those limitations and the conditional boundary
curve identification are preserved faithfully in the TeX. No new
Lean theorem or global family exclusion is asserted.
