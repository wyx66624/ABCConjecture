# Version 9 theorem-first formalization plan

The new mathematics is divided into statements that can be formalized without
assuming any unresolved global source theorem.

## A. Power-core package

Formalize for `n,k : Nat`, `2 <= k`:

1. the canonical exponent-rounded power core `U_k(n)`;
2. `U_k(n)^k | n`;
3. `n / rad(n)^(k-1) <= U_k(n)^k` in a divisibility or valuation form;
4. the abc-violation consequence after passing to real logarithms;
5. the square--cube horizon inequality.

This package is elementary finite-prime arithmetic and should be the first Lean
target.

## B. Exceptional-set incidence package

For finite input/output types with height predicates, formalize the double-count
inequality

`inputCount * lowerMultiplicity <= overlap * outputCount`.

The asymptotic exponent corollary can then be stated separately over real
powers. This package is independent of any particular amplifier.

## C. Torsion coefficient finite identities

Formalize the scalar equalities

`A_ell + ell * B_ell = 0`

and

`B_ell + (A_ell - B_ell)/(ell+1) = 0`,

then the finite weighted-average cancellation theorem. These results require no
elliptic-curve library.

## D. Three-point rational-map obstruction

Preferred route: import or formalize Riemann--Hurwitz for separable maps of
projective curves, then prove

`card (f^{-1} {0,1,infinity}) >= degree f + 2`.

Fallback route: use the function-field Mason--Stothers theorem on reduced
numerator/denominator polynomials to derive the same support inequality.

## E. Good-place determinant unitness

This requires an elliptic scheme over a DVR, finite etale subgroup divisors,
relative Picard functor, perfect derived pushforward, and determinant of
cohomology. Until those APIs exist, formalize the algebraic finite-free model:
an exact sequence of perfect complexes over a DVR induces a unit determinant.
The geometric application must remain a separate theorem, not an axiom.

## Merge rule

Only the mathematical documents and Lean theorems whose full hypotheses are
visible may be merged. The parabolic arithmetic specialization theorem, IUT
source comparison, and any final `ABCConjecture` theorem remain outside `main`
until independently proved.
