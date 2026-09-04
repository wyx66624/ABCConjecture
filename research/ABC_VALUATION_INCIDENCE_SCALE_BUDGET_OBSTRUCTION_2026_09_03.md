# Scale-budget obstruction in the labeled valuation-incidence complex

**Date:** 2026-09-03
**Status:** ordinary proof complete before Lean; Lean formalization and
one-for-one axiom audit pass
**Scope:** the coefficient-one binary-scale correction VIC-1R, on primitive
nonunit triples

## 1. The corrected gate being tested

After the fixed absolute budget VIC-ABS-1 was refuted, the first correction
allowed the total selected summand-arm defect to grow with the binary height:

\[
 d_A(F)+d_B(F)\le \ell_2(c)+t,
 \qquad
 \ell_2(c)=\min\{s\in\mathbf N:c\le2^s\}.
\]

The proposed VIC-1R also requires \(AB\) reconstruction and a quantitative
radical-defect inequality. The present test uses only the two necessary
conditions displayed above.

## 2. A balanced two-prime family

For every \(r\ge1\), put

\[
 Q_r=(2^{2r},\,3^r,\,2^{2r}+3^r).
\]

These are primitive nonunit triples because powers of \(2\) and \(3\) are
coprime. The family is injective through its first coordinate.

### Theorem 2.1 (reconstruction forces the full two-arm face)

If a face \(F\) of \(Q_r\) is \(AB\)-reconstructing, then
\(2\in F_A\) and \(3\in F_B\). Consequently

\[
 d_A(F)+d_B(F)\ge(2r-1)+(r-1)=3r-2.
\]

#### Proof

The \(A\)-support is the singleton \(\{2\}\), and the \(B\)-support is the
singleton \(\{3\}\). If \(2\notin F_A\), then \(F_A\) is empty,
\(M_A(F)=1\), and \(M_B(F)\mid3^r\). Thus

\[
 M_A(F)M_B(F)\le3^r<c,
\]

contradicting reconstruction. The same argument with the arms reversed shows
that omitting \(3\) gives
\(M_A(F)M_B(F)\le2^{2r}<c\). Both vertices must therefore be selected.
Their valuation excesses are \(2r-1\) and \(r-1\), proving the lower bound.
\(\square\)

### Theorem 2.2 (binary scale is too small)

For every \(r\ge1\),

\[
 \ell_2(2^{2r}+3^r)\le2r+1.
\]

#### Proof

Since \(3<4\) and \(r>0\), one has \(3^r<4^r=2^{2r}\). Hence

\[
 2^{2r}+3^r<2\cdot2^{2r}=2^{2r+1}.
\]

The defining minimum \(\ell_2(c)\) is at most every exponent whose power of
two dominates \(c\), so it is at most \(2r+1\). \(\square\)

### Corollary 2.3 (infinite failure of VIC-1R)

Fix \(t\in\mathbf N\). If \(r>t+3\), no \(AB\)-reconstructing face of \(Q_r\)
satisfies

\[
 d_A(F)+d_B(F)\le\ell_2(c)+t.
\]

Thus the failure set is infinite for every fixed \(t\), and the original
all-but-finitely-many VIC-1R is false for every \(m,n\).

#### Proof

Theorems 2.1 and 2.2 give

\[
 d_A(F)+d_B(F)\ge3r-2
 >2r+1+t
 \ge\ell_2(c)+t.
\]

The triples \(Q_r\) are distinct as \(r\) varies. The extra quantitative
inequality in VIC-1R cannot create a face after these necessary conditions
have already failed. \(\square\)

## 3. Exact retirement boundary and surviving structures

This is an infinite complete-premise counterexample. It retires exactly:

* the coefficient-one binary-scale budget with fixed additive slack; and
* the corresponding all-but-finitely-many VIC-1R selector.

It does not retire the valuation-incidence complex, the exact half-space
theorem, or selectors using genuinely different information. The following
directions remain open:

1. logarithmically weighted defect rather than unweighted exponent count;
2. budgets with a coefficient large enough to survive all two-prime balance
   families, together with a nontrivial independent quantitative condition;
3. several faces whose combined CRT data reconstructs \(c\);
4. three-arm reconstruction using the \(C\)-incidence signature; and
5. a homological or sheaf-like invariant on the filtered complex that controls
   the half-space without requiring one reconstructing face.

The family shows that simply changing an absolute bound to
\(\ell_2(c)+O(1)\) does not repair the selector. No broader route is retired,
and no bounded search is used.

## 4. Lean formalization

Only after the proof above was fixed was it formalized in
`Lean/IUTThreeClosures/ABCValuationIncidenceScaleBudgetObstruction20260903.lean`.
The Lean family uses the harmless reindexing \(r=k+1\). Thus its exact defect
identity is

\[
 d_A(F)+d_B(F)=3k+1,
\]

and its binary-scale bound is

\[
 \ell_2(c)\le 2k+3.
\]

The module defines `binaryScale` by `Nat.find`, proves both its domination
property and its leastness, constructs the primitive family, proves that
reconstruction forces the singleton supports \(\{2\}\) and \(\{3\}\), and
then proves the exact defect identity above. It proves an infinite failure set
for every fixed additive slack and, in `not_coefficientOneScaleVIC1R`, negates
the all-but-finitely-many proposition whose pointwise predicate explicitly
contains the additional VIC-1R radical-defect inequality.

The matching file
`Lean/IUTThreeClosures/ABCValuationIncidenceScaleBudgetObstruction20260903AxiomAudit.lean`
prints the axioms of every public declaration one for one. Strict compilation
with warnings as errors and the module build both pass. The audit reports only
the standard Mathlib foundations `propext`, `Classical.choice`, and
`Quot.sound`; there are no custom axioms, `sorry`, `admit`, `unsafe`, or
`native_decide` declarations. No surviving replacement is assumed, and no
claim of standard \(abc\) is made.
