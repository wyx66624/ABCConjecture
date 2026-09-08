# NP1/CU1: scope fixed before implementation

This next-only module formalizes the elementary arithmetic of the two actual
families already proved in NP1 and CU1. It does not alter published modules or
their verification inventories.

For an integer `k`, the root is the literal integer coordinate pair `(3*k, 1)`
with multiplication induced by `zeta^2 = zeta - 1`. Its norm is
`N = 9*k^2 + 3*k + 1`. The square and cube are obtained by that multiplication,
not by assuming a power representation of independent output coordinates.

The new declarations will prove:

1. The two coordinate formulas and the sum of the output coordinates.
2. The full boundary products, including every displayed factor. In the cube
   formula the assertion is an identity of integers; irreducibility and
   separability of its two cubic factors are not part of this module.
3. The exact norm identities `norm(square) = N^2` and `norm(cube) = N^3`.
4. Positivity of both output coordinates, their sum and complete boundary for
   `k >= 1`, and the root norm being greater than one in this domain.
5. Actual integer coprimality, and actual `Int.gcd = 1` for each pair of the
   three output arms. No Bezout witness or primitivity premise is assumed for
   the concrete families.
6. `N % 3 = 1`, and for every natural prime `q` dividing the full boundary,
   `IsUnit (N : ZMod q)`. The prime need not be marked and is not restricted
   to `q > 3`. An integer nondivisibility corollary will make this meaning
   explicit.

Polynomial identities and coprimality hold for every integer `k`; positivity
uses the explicit `k >= 1` hypothesis. A reusable field calculation may be
included: a primitive integer pair cannot have both its norm and boundary
zero modulo a prime. This helper's primitivity premise is discharged by the
concrete family theorems in both final norm-unit statements.

Not claimed: CRT owner selection or exact prescribed depths; the complete
polynomial separability analysis in CU1; a squarefree-value theorem, density,
asymptotics, moving-packet uniformity, moving exponent families, any infinite
tail estimate, or ABC. None is introduced as a formal premise or new axiom.

Verification is a fresh compilation of this one new source module against
the existing pinned Mathlib cache (`81a5d257c8e410db227a6665ed08f64fea08e997`),
with Lean 4.32.0. Every theorem must have a matching `#print axioms` query;
only `propext`, `Classical.choice`, and `Quot.sound` are accepted. This is not
a rebuild of Mathlib or an audit of all published project modules.
