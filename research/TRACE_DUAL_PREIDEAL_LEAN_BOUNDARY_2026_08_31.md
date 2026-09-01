# Actual trace-dual algebra companion: proof and boundary

Author: ChatGPT. Date: 2026-08-31.

This companion follows the completed mathematical proof in
`TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md` and the independent
check in `IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md`, section 8.
The arguments below were written before the new Lean module.

## Algebraic statements and proofs

Let R be a commutative ring, K a field carrying an R-algebra
structure, and T a commutative K-algebra with the compatible
R-algebra structure. For an R-submodule L of T, use the actual
algebra trace to define

    L^vee={x in T : Tr_(T/K)(xy) belongs to image(R->K)
                     for every y in L}.

Mathlib's `(1 : Submodule R K)` is exactly that image. Its
`Algebra.traceForm` and `LinearMap.BilinForm.dualSubmodule`
therefore define this object without introducing a new pairing.
No nondegeneracy is needed for the following inclusions.

1. If L is contained in N, then N^vee is contained in L^vee:
   the tests defining L^vee are a subset of those defining N^vee.

2. For finite commutative K-algebras T1,T2 and R-submodules
   L1,L2, the trace dual of L1 times L2 is L1^vee times L2^vee.
   The absolute trace on T1 times T2 is the sum of the two
   traces. Testing against (y,0) and (0,z) proves each necessary
   coordinate condition; conversely the sum of two integral
   traces is integral. This checks the absence of a component
   multiplicity factor using actual algebra traces.

3. Let A be contained in B as R-subalgebras of T. If a belongs
   to B^vee, then aB is contained in A^vee. Indeed for b in B
   and x in A, bx belongs to B and Tr((ab)x)=Tr(a(bx)) is
   integral. Thus a single normalized-generator condition
   controls the whole pre-transport ideal by multiplicative
   closure of the order; it is not an assumed ideal inclusion.

4. If c in K is nonzero and c^(-1)z belongs to B^vee, applying
   statement 3 to c^(-1)z and multiplying back by c gives
   zB contained in c A^vee.

5. Let G be any family of K-linear maps T->T preserving A^vee.
   For x in zB, statement 4 writes x=cy with y in A^vee;
   then F(x)=cF(y) lies in c A^vee. Taking the actual B-module
   span of all these images gives

    Span_B {F(x):F in G,x in zB} contained in c Span_B(A^vee).

   No B-linearity of F is assumed or used. This is the same
   direction required before the closed-lattice argument in
   the local paper proof.

## Explicit remaining boundary

The intended local application sets R=Z_p, K=Q_p, T=E^tensor m,
c=p^k, and uses the proved tame local facts to establish the
normalized-generator trace condition. The new algebra module
does not formalize the field construction, inverse different,
valuation bound, arbitrary finite product decomposition, tensor
trace-dual basis identity, attainment by an actual Galois arrow,
or topological closedness and Haar measure. Those are not new
Lean axioms. It also does not produce ABCConjecture or its negation.

## Compilation and axiom audit

`Lean/IUTThreeClosures/TraceDualPreidealHull20260831.lean` contains
six proved theorems and three definitions/abbreviations. The direct
command `lake env lean IUTThreeClosures/TraceDualPreidealHull20260831.lean`
completed successfully without warnings on 2026-08-31.

The four representative `#print axioms` commands for dual
antitonicity, exact product duality, scaled principal-ideal inclusion,
and the transported B-span theorem reported only `propext`,
`Classical.choice`, and `Quot.sound`. No `sorry` or local axiom
was introduced. The normalized generator's trace-integrality and
stability of the dual under the chosen maps remain explicit theorem
hypotheses, not purportedly verified number-field or source inputs.
