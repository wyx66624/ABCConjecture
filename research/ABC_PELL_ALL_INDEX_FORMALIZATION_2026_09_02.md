# All-index polynomial Pell identities and the complete moving witness

**Author:** ChatGPT
**Date:** 2026-09-02
**Status:** unconditional algebra and arithmetic certificates; no proof or
disproof of the standard abc conjecture.

## 1. Scope

This continuation closes two formalization gaps in the polynomial
Pell--Lucas checkpoint.  It works over `Z[T]` throughout.  Define

\[
 F_0=0,\quad F_1=1,\quad F_{n+2}=T F_{n+1}+F_n,
\]

\[
 L_0=2,\quad L_1=T,\quad L_{n+2}=T L_{n+1}+L_n.
\]

The Lean companion defines these sequences for every natural index, proves
that evaluation is compatible with both recurrences, and proves the three
identities

\[
 L_n^2-(T^2+4)F_n^2=4(-1)^n,                         \tag{1.1}
\]

\[
 L_n'=nF_n,                                           \tag{1.2}
\]

\[
 (T^2+4)F_n'=nL_n-TF_n.                              \tag{1.3}
\]

It also proves the arbitrary-polynomial Taylor--Hensel law, rather than
only its index-three instances.  Finally, all concrete hypotheses used to
refute `H-global-move` are collected in one structure and inhabited by the
single witness

\[
 (t,A,B,D)=(282,11213307,79525,19882).
\]

This does not close the fixed-parameter squarefull Pell route.  It does,
however, formalize the exact all-support squarefull/displacement equivalence
under explicit transversality hypotheses and the arbitrary finite indexed
CRT steering theorem.  The missing arithmetic input is now sharply isolated:
one must prove the required support transversality for the actual Pell
coordinates without importing an unproved Lucas-rank assertion.

## 2. Algebraic proof for every index

All following equalities are polynomial equalities in `Z[T]`.  First prove
simultaneously, by two-step induction, the companion formula

\[
 L_n=2F_{n+1}-TF_n                                    \tag{2.1}
\]

and Cassini's formula

\[
 F_{n+1}^2-TF_{n+1}F_n-F_n^2=(-1)^n.                 \tag{2.2}
\]

The initial indices are immediate.  For (2.1), if it holds at `n` and
`n+1`, substitute both formulas into
`L_{n+2}=TL_{n+1}+L_n` and use
`F_{n+2}=TF_{n+1}+F_n`.  For (2.2), one recurrence step gives

\[
\begin{aligned}
 &F_{n+2}^2-TF_{n+2}F_{n+1}-F_{n+1}^2\\
 &\qquad=F_n^2+TF_nF_{n+1}-F_{n+1}^2\\
 &\qquad=-\bigl(F_{n+1}^2-TF_{n+1}F_n-F_n^2\bigr).
\end{aligned}
\]

Formula (1.1) now follows by substituting (2.1):

\[
\begin{aligned}
 L_n^2-(T^2+4)F_n^2
 &= (2F_{n+1}-TF_n)^2-(T^2+4)F_n^2\\
 &=4(F_{n+1}^2-TF_{n+1}F_n-F_n^2)\\
 &=4(-1)^n.
\end{aligned}
\]

For the derivative formulas it is convenient to retain the equivalent
companion relation

\[
 L_{n+1}=TF_{n+1}+2F_n.                              \tag{2.3}
\]

Differentiate `L_{n+2}=TL_{n+1}+L_n`.  Assuming (1.2) at the two preceding
indices and using (2.3),

\[
\begin{aligned}
 L_{n+2}'
 &=L_{n+1}+T(n+1)F_{n+1}+nF_n\\
 &=(n+2)(TF_{n+1}+F_n)=(n+2)F_{n+2}.
\end{aligned}
\]

This proves (1.2) by two-step induction.  For (1.3), differentiate the
`F` recurrence and multiply by `Delta=T^2+4`.  The two preceding instances
of (1.3) reduce the result to the desired instance after using

\[
 \Delta F_{n+1}=TL_{n+1}+2L_n,                       \tag{2.4}
\]

which follows at once from (2.1), (2.3), and the `F` recurrence.  This is a
pure induction proof; it uses no quadratic extension and no cancellation by
a possibly zero polynomial.

Evaluation at an integer `t` is a ring homomorphism.  Applying it to the
two recurrence equations gives

\[
 F_{n+2}(t)=tF_{n+1}(t)+F_n(t),\qquad
 L_{n+2}(t)=tL_{n+1}(t)+L_n(t),                       \tag{2.5}
\]

with the four evaluated initial values.  The Lean module records (2.5)
explicitly so the polynomial and integer sequences cannot be conflated.

## 3. Full polynomial Taylor--Hensel law

Let `f in Z[T]`.  Taylor expansion at `t` has an integral remainder:

\[
 f(t+z)=f(t)+z f'(t)+z^2G                            \tag{3.1}
\]

for some integer `G` depending on `f,t,z`.  This follows term by term from
the binomial theorem; in Lean it is obtained from Mathlib's polynomial
Taylor expansion theorem and then reordered in the integer ring.

Take `z=p^e h`, with `e>=1`.  Because `e+1<=2e`, the final term in (3.1) is
divisible by `p^(e+1)`.  Hence

\[
 f(t+p^e h)\equiv f(t)+p^e h f'(t)\pmod {p^{e+1}}.   \tag{3.2}
\]

If `f(t)=p^e c`, cancellation in the integral domain `Z` gives the exact
divisibility equivalence

\[
 p^{e+1}\mid f(t+p^e h)
 \quad\Longleftrightarrow\quad
 p\mid c+h f'(t).                                    \tag{3.3}
\]

When `f'(t)` and `p` are coprime, Bezout supplies a digit satisfying the
right side, and subtraction of two such congruences proves uniqueness
modulo `p`.  Thus the module proves existence and uniqueness of the next
Hensel digit without assuming that `p` is prime; coprimality and `p!=0` are
the exact algebraic hypotheses.

## 4. All-support equivalence and finite simultaneous steering

For a natural number `N`, define

\[
 \operatorname{SqFull}(N)
 \quad\Longleftrightarrow\quad
 \forall p\text{ prime},\ p\mid N\Longrightarrow p^2\mid N.       \tag{4.1}
\]

If `A` and `B` are coprime, Euclid's lemma gives

\[
 \operatorname{SqFull}(AB)
 \Longleftrightarrow
 \operatorname{SqFull}(A)\wedge\operatorname{SqFull}(B).          \tag{4.2}
\]

Indeed, a prime square dividing `AB` and supported on `A` can be cancelled
from the factor `B`, because `p^2` and `B` are coprime; the other direction
is immediate from prime divisibility of a product.

Let `f in Z[T]`, suppose `f(t)=uN`, and assume `u` is coprime to every prime
in the support of `N`.  At a support prime define zero first displacement by

\[
 p\mid f(t),\qquad \gcd(f'(t),p)=1,\qquad p^2\mid f(t).             \tag{4.3}
\]

The last condition is equivalent to the Hensel digit being zero by (3.3).
After cancelling the scale `u`, (4.1) is equivalent to (4.3) at every
support prime.  Combining this with (4.2) proves the exact two-channel
statement.  The Lean theorem
`pell_squarefull_packet_iff_all_support_displacements` specializes it to

\[
 L_\ell(2)=2A_\ell,\qquad F_\ell(2)=B_\ell.                         \tag{4.4}
\]

The factor `2` and both derivative-transversality assertions occur as
explicit premises.  Thus no Lucas rank or squarefreeness theorem is hidden
in the formal statement.

For finite steering, let `i` run through a finite list, let the `p_i` be
pairwise distinct primes, and assume

\[
 p_i\mid f_i(t_0),\qquad \gcd(f_i'(t_0),p_i)=1.                    \tag{4.5}
\]

Equation (3.3) supplies a unique digit `h_i mod p_i`, hence a unique local
class

\[
 r_i=t_0+p_i h_i\pmod {p_i^2}.                                    \tag{4.6}
\]

Distinct primes have pairwise coprime square moduli.  An inductive integer
CRT therefore supplies one class `t mod product_i p_i^2` satisfying every
(4.6).  Polynomial evaluation respects congruence, so every
`p_i^2 | f_i(t)`.  Conversely, if `u` retains each base root class and every
selected square divides `f_i(u)`, the one-digit uniqueness in (3.3) puts
`u` in each class (4.6); CRT uniqueness then puts `u` in the joint class.
This proves the existence and uniqueness assertion at the full finite-list
quantifiers, formalized as `finite_simultaneous_hensel_steering`.

## 5. One object containing every `H-global-move` premise

At index three set

\[
 F_3(T)=T^2+1,\qquad L_3(T)=T^3+3T.
\]

At the base parameter `2`, the selected primes are genuine simple roots:

\[
 7\mid L_3(2),\quad 7\nmid L_3'(2),\qquad
 5\mid F_3(2),\quad 5\nmid F_3'(2).
\]

The joint lifted parameter satisfies

\[
 282\equiv37\pmod {49},\qquad
 282\equiv7\pmod {25},
\]

and hence retains the base residues modulo `7` and `5`.  With

\[
 A=L_3(282)/2=11213307,\quad B=F_3(282)=79525,
 \quad D=(282^2+4)/4=19882,
\]

one has

\[
 A=3^2 7^2 47\,541,\qquad B=5^2 3181,\qquad D=2\,9941.
\]

All seven displayed factors `3,5,7,47,541,3181,9941` are prime.  Therefore
`49|A` and `25|B`, while `47^2` and `541^2` do not divide `A` and
`3181^2` does not divide `B`.  The latter facts explicitly delimit the
counterexample: it has the selected repeated pair but is not a whole-channel
squarefull packet.  The coefficient is positive and squarefree because
`D=2*9941` with distinct prime factors.  Direct evaluation of (1.1) gives

\[
 A^2-DB^2=-1.
\]

The Lean structure `HGlobalMoveWitness` has fields for the odd prime index,
both base simple roots, both lifted residue classes, both repeated
divisibilities, the coordinate and coefficient identities, positivity,
the global norm, all claimed primalities, coefficient squarefreeness, and
the three exponent-one/non-squarefull checks.  The definition
`indexThree_full_HGlobalMoveWitness` fills every field for the one tuple
above, and `indexThree_full_HGlobalMoveWitness_nonempty` proves its
existence as a proposition.  Consequently no premise is assembled only
informally from separate declarations.

## 6. Exact boundary

The following are proved unconditionally and kernel-checked:

1. the two polynomial recurrences and evaluated recurrences for all natural
   indices;
2. (1.1)--(1.3) for every natural index in `Z[T]`;
3. the exact integral Taylor remainder, congruence (3.2), divisibility law
   (3.3), and existence/uniqueness of one Hensel digit;
4. the all-prime two-channel squarefull/displacement equivalence, under the
   exact scale-unit and derivative-transversality premises;
5. finite simultaneous steering and uniqueness for a list of pairwise
   distinct simple prime roots;
6. one bundled full-premise witness refuting `H-global-move`.

The remaining **OPEN ARITHMETIC ITEM** is to discharge the all-support
transversality premises for the actual fixed Pell packet at every relevant
index from proved rank information.  This module does not assume polynomial
squarefreeness, a Lucas rank theorem, abc, or a global fixed-parameter
exclusion.  Consequently it closes the formal algebraic interface while
leaving the hard Diophantine route active.

## 7. Closure and verification inventory

**Lean-closed.**  The module contains 52 explicitly audited public
declarations: 43 theorems, 8 definitions, and 1 structure.  These cover all
six items in Section 6, including the finite-list CRT uniqueness statement
and the inhabited full-premise moving witness.  The audit file has exactly
one `#print axioms` command for each declaration, with no missing or extra
name.  Both direct checks succeed with warnings treated as errors:

```text
lake env lean IUTThreeClosures/PellPolynomialAllIndexFormalization20260902.lean -DwarningAsError=true
lake env lean IUTThreeClosures/PellPolynomialAllIndexFormalization20260902AxiomAudit.lean -DwarningAsError=true
```

The source and audit contain no `sorry`, `admit`, declared `axiom`, or
`native_decide`.  The only principles reported by `#print axioms` are
Mathlib's standard `propext`, `Classical.choice`, and `Quot.sound`.

**Paper-only presentation.**  The separate journal fragment restates the
Lean-closed results as conventional mathematical proofs and records the
research interpretation of the witness.  Its prose is explanatory rather
than an additional unchecked hypothesis.  It compiles as a three-page
`amsart` input fragment; the only standalone warning is its intentional
cross-reference to the preceding Pell section in the full article.

**Still open.**  No theorem here proves the support transversality premises
for the actual fixed parameter `T=2`, excludes all simultaneous zero
displacements there, proves a Lucas rank theorem, proves a polynomial
squarefreeness theorem, or proves/disproves standard abc.  No counterexample
to that full fixed-parameter route is known in this work, so that route is
not retired.
