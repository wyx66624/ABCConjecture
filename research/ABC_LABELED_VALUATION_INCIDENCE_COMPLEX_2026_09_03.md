# A labeled valuation-incidence complex for primitive nonunit \(abc\) triples

**Date:** 2026-09-03

**Status:** Exact finite object and algebraic identities proved; quantitative
gate open.

**Scope:** Throughout, \(a,b,c\) are positive integers satisfying

\[
  a>1,\qquad b>1,\qquad a+b=c,\qquad \gcd(a,b)=1.
\]

Thus every theorem in this note concerns a **primitive nonunit triple**. No
statement silently includes the unit-arm cases \(a=1\) or \(b=1\).

**Claim discipline:** The construction below is a finite incidence object and
a coordinate system. The height equivalence in Section 6 is a rewrite, not
an estimate. No uniform defect bound is proved, so this note does not prove
or disprove the \(abc\) conjecture.

## 1. Purpose

The scalar radical of \(abc\) forgets three kinds of data that remain visible
prime by prime:

1. which of the \(A,B,C\) arms contains a prime;
2. how much exponent remains after the first copy of that prime is removed;
3. which local congruence is imposed by \(a+b=c\).

The object introduced here retains all three. It is a finite labeled
simplicial complex equipped with actual valuations, six exact multiplicative
coordinates, a three-parameter defect filtration, and local congruence
incidence. The unfiltered simplex is elementary. Its labels, filtration,
and arithmetic realization are the structure being studied.

## 2. Vertices and faces

Set

\[
  x_A=a,\qquad x_B=b,\qquad x_C=c
\]

and

\[
  S_i=\{p:p\text{ is prime and }p\mid x_i\},\qquad
  e_i(p)=v_p(x_i)\quad(p\in S_i).
\]

Every \(e_i(p)\) is positive. Also

\[
  \gcd(a,c)=\gcd(a,a+b)=\gcd(a,b)=1,
\]

and similarly \(\gcd(b,c)=1\). Thus the three prime supports are pairwise
disjoint. We nevertheless retain the arm in every vertex label.

### Definition 2.1 (labeled valuation vertex)

A vertex is \((i,p)\), where \(i\in\{A,B,C\}\) and \(p\in S_i\), with label

\[
  \lambda(i,p)=(i,p,e_i(p)).
\]

### Definition 2.2 (valuation-incidence face)

A face is

\[
  F=(F_A,F_B,F_C),\qquad F_i\subseteq S_i.
\]

Write \(F\preceq G\) if \(F_i\subseteq G_i\) for every arm. Define

\[
  \varnothing_P=(\varnothing,\varnothing,\varnothing),\qquad
  \top_P=(S_A,S_B,S_C),
\]

with union and intersection taken arm by arm. The vertex count and
natural-valued dimension are

\[
  \nu(F)=|F_A|+|F_B|+|F_C|,\qquad
  \dim_{\mathbf N}(F)=\max(\nu(F)-1,0).
\]

The empty face is assigned dimension zero to avoid an integer-valued
\(-1\) convention in Lean.

### Theorem 2.3 (face-poset laws)

The relation \(\preceq\) is reflexive, transitive, and antisymmetric. The
empty face lies below every face, the top face lies above every face, and
armwise union is the least common upper bound.

**Proof.** Each assertion is checked on \(A,B,C\) separately. Subset
inclusion is reflexive and transitive. Mutual inclusion gives equality on
each arm and hence equality of faces. The empty and top assertions are the
corresponding finite-set facts. Finally \(F_i\cup G_i\) contains both sets,
and every common upper bound contains their union. \(\square\)

The faces therefore form the Boolean face lattice on
\(S_A\sqcup S_B\sqcup S_C\). If the full support has \(N>0\) vertices, its
simplex dimension is \(N-1\).

Lean counterparts: Face.ext, Face.IsSubface, Face.isSubface_refl,
Face.isSubface_trans, Face.isSubface_antisymm, Face.empty_isSubface,
Face.isSubface_full, and the three union theorems.

## 3. Six arithmetic coordinates

For a face \(F\) and arm \(i\), define

\[
\begin{aligned}
 R_i(F)&=\prod_{p\in F_i}p,\\
 D_i(F)&=\prod_{p\in F_i}p^{e_i(p)-1},\\
 M_i(F)&=\prod_{p\in F_i}p^{e_i(p)},\\
 d_i(F)&=\sum_{p\in F_i}(e_i(p)-1).
\end{aligned}
\]

Empty products are one and empty sums are zero. The exact multiplicative
tropical point is

\[
  T(F)=\bigl((R_A(F),D_A(F)),(R_B(F),D_B(F)),(R_C(F),D_C(F))\bigr)
  \in(\mathbf N_{>0}^{\,2})^3.
\]

This six-coordinate natural-number point is the arithmetic object used in
the proofs. Its real display is

\[
  \tau(F)=\bigl((\log R_A(F),\log D_A(F)),\ldots,
                    (\log R_C(F),\log D_C(F))\bigr)\in\mathbf R^6.
\]

No numerical logarithm decides face membership or a filtration level.

### Theorem 3.1 (exact face factorization)

For every face and arm,

\[
  R_i(F)D_i(F)=M_i(F),\qquad M_i(F)\mid x_i.
\]

At the top face,

\[
  M_i(\top_P)=x_i,\qquad
  R_i(\top_P)=\operatorname{rad}(x_i),\qquad
  \operatorname{rad}(x_i)D_i(\top_P)=x_i.
\]

**Proof.** Since \(e_i(p)>0\),

\[
  p\,p^{e_i(p)-1}=p^{e_i(p)}.
\]

Multiplication over \(F_i\) gives the first identity. The selected
prime-power product is a subproduct of the canonical factorization of
\(x_i\), so it divides \(x_i\). At the top face it is the complete
factorization and equals \(x_i\). Keeping one copy of every prime gives the
ordinary radical, and the last identity is the first identity at the top
face. \(\square\)

Lean counterparts: Face.valuation_pos_of_mem_support,
Face.armRadical_mul_armDefect, Face.armModulus_dvd_coordinate,
Face.full_armModulus, Face.full_armRadical, and
Face.full_radical_mul_defect.

### Theorem 3.2 (disjoint-union law)

If \(F_i\cap G_i=\varnothing\) on every arm, then

\[
\begin{aligned}
 R_i(F\cup G)&=R_i(F)R_i(G),\\
 D_i(F\cup G)&=D_i(F)D_i(G),\\
 M_i(F\cup G)&=M_i(F)M_i(G),\\
 d_i(F\cup G)&=d_i(F)+d_i(G).
\end{aligned}
\]

**Proof.** Each expression is a product or sum over a disjoint union of
finite sets. The valuation attached to each selected prime is unchanged.
\(\square\)

Consequently \(\tau(F\cup G)=\tau(F)+\tau(G)\) for disjoint faces. This
formula, rather than an analogy, is the precise tropical feature.

Lean counterparts: Face.ArmwiseDisjoint, Face.armRadical_union,
Face.armDefect_union, Face.armModulus_union, and Face.defectDegree_union.

## 4. Defect filtration

For \(u=(u_A,u_B,u_C)\in\mathbf N^3\), define

\[
  \mathcal K_u(P)=
  \{F:d_i(F)\le u_i\text{ for }i=A,B,C\}.
\]

### Theorem 4.1 (downward closure and graded union)

If \(G\preceq F\) and \(F\in\mathcal K_u(P)\), then
\(G\in\mathcal K_u(P)\). The empty face lies in every level. If \(F,G\)
are armwise disjoint, \(F\in\mathcal K_u(P)\), and
\(G\in\mathcal K_v(P)\), then

\[
  F\cup G\in\mathcal K_{u+v}(P).
\]

**Proof.** Every summand \(e_i(p)-1\) is nonnegative, so passage to a subset
cannot increase \(d_i\). Empty sums vanish. For disjoint union, Theorem 3.2
gives

\[
  d_i(F\cup G)=d_i(F)+d_i(G)\le u_i+v_i.
\]

\(\square\)

Lean counterparts: Face.IsBudgetFace, Face.isBudgetFace_of_isSubface,
Face.empty_isBudgetFace, and Face.union_isBudgetFace.

### Theorem 4.2 (exact zero level)

A face lies in \(\mathcal K_{(0,0,0)}(P)\) if and only if every selected
vertex has valuation exponent one.

**Proof.** Every \(e_i(p)-1\) is nonnegative. If their sum is at most zero,
each term is zero; positivity of \(e_i(p)\) gives \(e_i(p)=1\). Conversely,
if every selected exponent is one, every summand vanishes and all three
defect degrees are zero. \(\square\)

Lean counterpart: Face.zeroBudget_iff_valuation_one.

## 5. Congruence incidence and reconstruction

### Theorem 5.1 (local incidence signature)

Every face satisfies

\[
\begin{array}{rcll}
 c&\equiv&b&\pmod {M_A(F)},\\
 c&\equiv&a&\pmod {M_B(F)},\\
 a+b&\equiv&0&\pmod {M_C(F)}.
\end{array}
\]

The three face moduli are pairwise coprime.

**Proof.** Theorem 3.1 gives \(M_A(F)\mid a\). Since \(c=a+b\), this gives
the first congruence. The second follows from \(M_B(F)\mid b\), and the
third follows from \(M_C(F)\mid c=a+b\). Each modulus divides its arm
coordinate, and divisors of the pairwise coprime numbers \(a,b,c\) are
pairwise coprime. \(\square\)

Lean counterparts: Face.localIncidenceSignature and
Face.coprime_modulus_AB, Face.coprime_modulus_AC,
Face.coprime_modulus_BC.

### Definition 5.2 (AB reconstruction window)

A face is **AB-reconstructing** if

\[
  c<M_A(F)M_B(F).
\]

### Theorem 5.3 (CRT rigidity)

The top face is AB-reconstructing. If \(F\) is AB-reconstructing and

\[
  0\le x<M_A(F)M_B(F),\qquad
  x\equiv b\pmod {M_A(F)},\qquad
  x\equiv a\pmod {M_B(F)},
\]

then \(x=c\).

**Proof.** At the top face \(M_A=a\) and \(M_B=b\). The primitive nonunit
hypotheses give \(c=a+b<ab\), proving the first assertion. For general \(F\), Theorem
5.1 gives the same two residues for \(c\). Hence \(x\equiv c\) modulo
\(M_A(F)\) and modulo \(M_B(F)\). Coprimality and the Chinese remainder
theorem give

\[
  x\equiv c\pmod {M_A(F)M_B(F)}.
\]

Both \(x\) and \(c\) lie in the half-open interval from zero to that product,
so they are equal. \(\square\)

Lean counterparts: Face.ABReconstructing, Face.full_ABReconstructing, and
Face.eq_c_of_ABReconstructing.

This is exact reconstruction, but not a radical saving: the top face always
satisfies it.

## 6. Exact height boundary in top-face coordinates

Abbreviate the top coordinates by

\[
  R_A=\operatorname{rad}(a),\quad
  R_B=\operatorname{rad}(b),\quad
  R_C=\operatorname{rad}(c),\quad
  D_C=c/R_C.
\]

Pairwise coprimality gives

\[
  R_AR_BR_C=\operatorname{rad}(abc).
\]

Lean proves this as Face.complexRadical_eq_abcRadical.

### Theorem 6.1 (rational-power half-space equation)

For all \(m,n\in\mathbf N\),

\[
\boxed{
 c^m\le\operatorname{rad}(abc)^{m+n}
 \quad\Longleftrightarrow\quad
 D_C^m\le(R_AR_B)^{m+n}R_C^n.
}
\tag{6.1}
\]

**Proof.** Substitute \(c=R_CD_C\) and
\(\operatorname{rad}(abc)=R_AR_BR_C\). The left inequality becomes

\[
 R_C^mD_C^m
 \le (R_AR_B)^{m+n}R_C^{m+n}
 =R_C^m\bigl((R_AR_B)^{m+n}R_C^n\bigr).
\]

Because \(R_C>0\), cancellation of \(R_C^m\) gives the forward implication.
Multiplying the right inequality in (6.1) by \(R_C^m\) gives the reverse
implication. \(\square\)

Lean counterparts: Face.cPower_le_complexRadical_iff_sumArmDefect and
Face.cPower_le_abcRadical_iff_sumArmDefect.

This theorem is a **coordinate rewrite only**. After logarithms it identifies
the half-space

\[
  m\log D_C\le
  (m+n)(\log R_A+\log R_B)+n\log R_C,
\]

but it gives no reason that the top point lies there.

### Theorem 6.2 (filtered-face sufficient condition)

For any face \(F\), if

\[
  D_C^m\le
  \bigl(R_A(F)R_B(F)\bigr)^{m+n}R_C^n,
\tag{6.2}
\]

then

\[
  c^m\le\operatorname{rad}(abc)^{m+n}.
\]

**Proof.** Since \(F_i\subseteq S_i\), the selected radical products divide
the top radical products, so

\[
  R_A(F)\le R_A,\qquad R_B(F)\le R_B.
\]

Enlarge the right side of (6.2) using these inequalities, then apply the
reverse implication of Theorem 6.1. \(\square\)

Lean counterpart: Face.filteredFaceBound_forces_cPower.

The theorem asserts an implication only. It produces no such face.

## 7. Complete-premise five-dimensional witness

Consider

\[
  12+833=845,
\]

where

\[
  12=2^2\cdot3,\qquad
  833=7^2\cdot17,\qquad
  845=5\cdot13^2.
\]

The summands are nonunits and \(\gcd(12,833)=1\), so every premise is met.
The top face has the six vertices

\[
 (A,2),(A,3),(B,7),(B,17),(C,5),(C,13)
\]

and therefore has natural dimension five. Its data are:

| arm | valuations | \(R_i\) | \(D_i\) | \(M_i\) | \(d_i\) |
|---|---:|---:|---:|---:|---:|
| \(A\) | \(v_2=2,\ v_3=1\) | \(6\) | \(2\) | \(12\) | \(1\) |
| \(B\) | \(v_7=2,\ v_{17}=1\) | \(119\) | \(7\) | \(833\) | \(1\) |
| \(C\) | \(v_5=1,\ v_{13}=2\) | \(65\) | \(13\) | \(845\) | \(1\) |

Thus

\[
  T(\top_P)=((6,2),(119,7),(65,13)).
\]

The top face lies in \(\mathcal K_{(1,1,1)}\) and not in
\(\mathcal K_{(0,0,0)}\). The face

\[
  F_A=\{3\},\qquad F_B=\{17\},\qquad F_C=\{5\}
\]

has three vertices and lies in the zero level.

Lean checks the three prime-factor sets, all six valuations, the three
coordinate radicals, the full tropical point, and both filtration claims
using kernel-checkable factorization lemmas. It does not use native_decide.

### Exact counterexample boundary 7.1 (defect concentration)

The pointwise universal shortcut

> Every primitive nonunit triple has an arm \(i\) with
> \(D_i(\top_P)=1\)

is false: this witness has defects \(2,7,13\). This one complete-premise
example retires exactly that universal statement. It does not retire an
all-but-finitely-many version, a density statement, or an estimate allowing
all three arms to be defective.

Lean counterpart: witness_everyArm_defective.

### Exact counterexample boundary 7.2 (one valuation slope per arm)

The pointwise universal shortcut

> For every primitive nonunit triple and every arm, \(e_i(p)\) is constant
> as \(p\) ranges over \(S_i\)

is false. Every arm of the witness contains one exponent two and one
exponent one. This retires only the constant-exponent claim and arguments
whose full premise literally requires it. It proves no eventual or density
claim about mixed slopes.

Lean counterpart: witness_everyArm_has_mixedValuation.

## 8. Candidate boundary and obstruction-tested successors

### Candidate VIC-ABS-1 (fixed absolute defect budget)

Fix \(m\ge1\) and \(n\ge1\). Determine whether there is a budget
\(t=t(m,n)\) such that all but finitely many primitive nonunit triples admit a
face \(F\) satisfying

\[
\begin{aligned}
 d_A(F)&\le t,\qquad d_B(F)\le t,\\
 c&<M_A(F)M_B(F),\\
 D_C^m&\le
   \bigl(R_A(F)R_B(F)\bigr)^{m+n}R_C^n.
\end{aligned}
\tag{VIC-ABS-1}
\]

The first line places \(F\) in a bounded defect layer. The second makes its
two summand-arm residues reconstruct \(c\) uniquely. The third is the
quantitative requirement. Theorem 6.2 proves that VIC-ABS-1 would imply the
corresponding rational-exponent height bound on the present nonunit domain.

This fixed absolute-budget formulation is retained for comparison, but is
not classified here as live or unrefuted. A companion obstruction analysis
tests it against the full-premise dyadic family

\[
  P_k=\bigl(2^{k+4},3,2^{k+4}+3\bigr).
\]

The decisive scale issue is that selecting the sole \(A\)-prime costs defect
\(k+3\), while omitting it leaves \(M_A=1\) and \(M_AM_B\le3<c\). The
companion analysis owns the exact theorem, proof, and Lean audit for this
obstruction. Accordingly, VIC-ABS-1 is not listed among the open gates below.

The top face automatically satisfies the reconstruction line, so
reconstruction by itself is not progress.

### Retired Gate VIC-1R (coefficient-one scale-sensitive selector)

Define the binary scale

\[
  \ell_2(c)=\min\{s\in\mathbf N:c\le2^s\}.
\]

Fix \(m\ge1\) and \(n\ge1\). Determine whether there is a slack
\(t=t(m,n)\) such that all but finitely many primitive nonunit triples admit a
face \(F\) satisfying

\[
\begin{aligned}
 d_A(F)+d_B(F)&\le \ell_2(c)+t,\\
 c&<M_A(F)M_B(F),\\
 D_C^m&\le
   \bigl(R_A(F)R_B(F)\bigr)^{m+n}R_C^n.
\end{aligned}
\tag{VIC-1R}
\]

This replaces a fixed absolute defect cap by a budget that grows with the
height being reconstructed.  A second companion obstruction proves that this
repair is still false.  For

\[
 Q_r=(2^{2r},3^r,2^{2r}+3^r),\qquad r\ge1,
\]

every reconstructing face must select both singleton summand supports.  Its
defect is therefore at least \(3r-2\), whereas
\(\ell_2(2^{2r}+3^r)\le2r+1\).  For every fixed \(t\), all
\(r>t+3\) fail the first line of VIC-1R.  This is an infinite
complete-premise counterfamily, independent of the third line, and hence
retires the all-but-finitely-many VIC-1R selector for every \(m,n\).
The companion report and Lean module own the exact theorem and audit.

### Surviving replacement program

The parent complex remains active.  A successor must use information absent
from the two refuted one-face budgets.  Current precise design tasks are:

1. define logarithmically weighted defect and determine the sharp weights on
   all two-prime balance families;
2. combine several filtered faces and prove a joint CRT reconstruction lemma;
3. incorporate the \(C\)-arm congruence signature in a genuine three-arm
   reconstruction theorem; or
4. define a homological or sheaf-like invariant whose boundedness implies
   (6.2) without choosing one reconstructing face.

No existence theorem for any of these replacements is asserted.  A bounded
no-hit search retires nothing, while a complete-premise infinite family
retires only the exact replacement it violates.

## 9. Boundary ledger

### Proved finite or algebraic statements

* face-poset laws and armwise union/intersection operations;
* facewise radical-defect-modulus factorization;
* six-coordinate realization and disjoint-union laws;
* downward-closed defect filtration and exact zero level;
* local congruence signatures and pairwise-coprime moduli;
* CRT uniqueness in an AB reconstruction window;
* top-face recovery of \(\operatorname{rad}(abc)\);
* rational-power equivalence (6.1);
* filtered-face implication (6.2); and
* every stated property of the \(12+833=845\) witness.

### Retired by complete-premise examples

* only the pointwise claim that some arm must have trivial defect;
* only the pointwise claim that the valuation exponent is constant on every arm.

The Section 7 witness retires nothing broader.

### Routed to a companion obstruction audit

* VIC-ABS-1 is not treated as a live gate here. Its dyadic obstruction and
  exact retirement boundary belong to the companion proof and Lean audit,
  rather than to the declarations in this module;
* VIC-1R is likewise retired by the balanced two-prime companion obstruction,
  whose ordinary proof precedes its Lean formalization.

### Still open

* every eventual bound on \(D_C\) in terms of the radical coordinates;
* every weighted, multi-face, three-arm, or homological successor to the two
  retired one-face budgets;
* a mechanism forcing such a successor to satisfy (6.2);
* extension to unit-arm triples outside the present interface; and
* the standard \(abc\) conjecture.

Theorem 6.1 is in the proved list, but it is only a coordinate rewrite and is
not evidence for the open inequality.

## 10. Lean formalization and trust boundary

The independent files are

* Lean/IUTThreeClosures/ABCValuationIncidenceComplex20260903.lean;
* Lean/IUTThreeClosures/ABCValuationIncidenceComplex20260903AxiomAudit.lean.

The main module uses the existing primitive nonunit interface and remains
independently compilable regardless of whether a later integration imports
it elsewhere. Faces use Nat.primeFactors and valuations use Nat.factorization.

The witness uses kernel-checkable factorization lemmas and ordinary
norm_num/simp proofs. There is no native_decide, sorry, admit, custom axiom,
oracle, or asymptotic hypothesis. The axiom audit reports only

\[
  \texttt{propext},\qquad
  \texttt{Classical.choice},\qquad
  \texttt{Quot.sound}.
\]

Every unconditional finite and natural-number algebraic theorem stated above
has a declaration in the main module. The eventual gates are deliberately
absent as hypotheses.
