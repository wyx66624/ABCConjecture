# Fixed-budget obstruction in the labeled valuation-incidence complex

**Date:** 2026-09-03
**Status:** ordinary proof completed before formalization; Lean closure complete
**Scope:** primitive nonunit triples and the exact absolute-budget selector
VIC-ABS-1 proposed in
ABC_LABELED_VALUATION_INCIDENCE_COMPLEX_2026_09_03.md

## 1. Exact claim being tested

For a primitive nonunit triple \(P=(a,b,c)\), a valuation-incidence face
\(F=(F_A,F_B,F_C)\) has

\[
 M_i(F)=\prod_{p\in F_i}p^{v_p(x_i)},
 \qquad
 d_i(F)=\sum_{p\in F_i}(v_p(x_i)-1).
\]

It is \(AB\)-reconstructing when

\[
 c<M_A(F)M_B(F).
\]

The original form of VIC-ABS-1 asks, for fixed positive \(m,n\), for one
absolute integer budget \(t=t(m,n)\) such that all but finitely many primitive
nonunit triples have a face satisfying

\[
 d_A(F)\le t,\qquad d_B(F)\le t,\qquad
 c<M_A(F)M_B(F),
\]

together with a further quantitative radical-defect inequality. It is enough
to test the first three necessary conditions.

## 2. Dyadic fixed-arm family

For \(k\ge0\), set

\[
 P_k=(2^{k+4},\,3,\,2^{k+4}+3).
\]

Every \(P_k\) is a primitive nonunit triple: both summands exceed one,
\(2^{k+4}+3\) is their sum, and
\(\gcd(2^{k+4},3)=1\). The triples are pairwise distinct because their first
coordinates are strictly increasing.

### Theorem 2.1 (no fixed-budget reconstruction on the dyadic tail)

Let \(t,k\in\mathbf N\) and suppose \(t<k+3\). No face of \(P_k\) can satisfy
both

\[
 d_A(F)\le t
 \quad\text{and}\quad
 c<M_A(F)M_B(F).
\]

#### Proof

The \(A\)-coordinate is \(2^{k+4}\), so its prime support consists only of
\(2\), with valuation \(k+4\). If \(2\in F_A\), then its contribution to the
\(A\)-defect degree is

\[
 v_2(2^{k+4})-1=k+3>t,
\]

contradicting \(d_A(F)\le t\). Therefore \(F_A\) is empty and
\(M_A(F)=1\).

Every selected \(B\)-modulus divides the \(B\)-coordinate \(3\), so
\(M_B(F)\le3\). Hence

\[
 M_A(F)M_B(F)\le3<2^{k+4}+3=c.
\]

Thus \(F\) is not \(AB\)-reconstructing. \(\square\)

### Corollary 2.2 (infinite complete-premise failure at every budget)

For every fixed \(t\in\mathbf N\), infinitely many primitive nonunit triples
have no \(AB\)-reconstructing face with \(d_A(F)\le t\). Consequently, for
every \(m,n\in\mathbf N\), the original absolute-budget VIC-ABS-1 is false.

#### Proof

For fixed \(t\), every \(k\ge t\) satisfies \(t<k+3\), so Theorem 2.1 applies
to the infinite injective tail \((P_k)_{k\ge t}\). A face satisfying the full
VIC-ABS-1 conditions would in particular satisfy the two conditions ruled out
by Theorem 2.1. Therefore the additional quantitative inequality cannot
restore the selector. \(\square\)

## 3. Exact retirement boundary

This infinite family satisfies every premise of the relevant domain and
therefore retires:

* the absolute fixed-\(t\) \(AB\)-reconstructing selector; and
* the displayed original form of VIC-ABS-1, for every fixed \(m,n\).

It does **not** retire the labeled valuation-incidence complex, its proved
face, filtration, congruence, CRT, or half-space theorems. It also does not
refute any of the following corrected directions:

1. a budget allowed to grow sublinearly with a conductor or height coordinate;
2. a weighted budget that discounts a single high-multiplicity arm when the
   opposite arm carries sufficient reconstructing modulus;
3. reconstruction using all three labeled congruence arms rather than only
   the \(A/B\) product window;
4. a cover by several low-defect faces whose combined congruence data
   reconstructs the endpoint; or
5. a selector stated directly in the six logarithmic coordinates and proved
   to imply the required half-space.

The first precise corrected gate in the companion incidence report is
VIC-1R:

\[
 d_A(F)+d_B(F)\le\ell_2(c)+t,
\]

together with the same reconstruction and quantitative half-space
requirements. It remains open. Difficulty in proving it is not a retirement
criterion; positive proof construction and complete-premise counterexample
search continue in parallel.

## 4. Lean formalization and trust boundary

After the ordinary proof above was fixed, the companion files

* Lean/IUTThreeClosures/ABCValuationIncidenceFixedBudgetObstruction20260903.lean;
* Lean/IUTThreeClosures/ABCValuationIncidenceFixedBudgetObstruction20260903AxiomAudit.lean

were written. The main module defines the exact face selector, proves Theorem
2.1, proves that its failure set is infinite for every budget by injectivity of
the dyadic family, and derives the negation of the original
all-but-finitely-many VIC-ABS-1 proposition.

Direct warning-as-error compilation and the dedicated target build pass. The
declaration-level axiom audit reports only propext, Classical.choice, and
Quot.sound. The module does not assume a corrected gate and does not claim a
proof or disproof of standard \(abc\).
