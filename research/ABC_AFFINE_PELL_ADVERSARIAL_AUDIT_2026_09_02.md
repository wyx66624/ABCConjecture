# Adversarial audit of the affine inverse-period and Pell--Lucas curvature checkpoints

**Auditor:** ChatGPT  
**Date:** 2026-09-02  
**Status:** mathematical and computational checks pass within the stated scopes; formalization is partial; the standard abc conjecture remains open

## 1. Audit rule and conclusion

This audit treats a route as retired only when a counterexample satisfies every
premise of a precisely stated claim.  A difficult missing estimate, a failed
proof attempt, or a bounded computation is not a reason to retire a route.

The audited artifacts are:

* `research/ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md`;
* `Lean/IUTThreeClosures/AffineInversePeriodCatalogueNovelty20260902.lean`;
* `research/computation/2026_09_02_affine_inverse_period_catalogue/`;
* `research/ABC_PELL_LUCAS_FACTOR_QUOTIENT_PROJECTIVE_COUPLING_2026_09_02.md`;
* `Lean/IUTThreeClosures/PellLucasFactorQuotientProjectiveCoupling20260902.lean` and its axiom audit; and
* `research/computation/2026_09_02_pell_factor_quotient_coupling/`.

No fatal mathematical error was found in the new unconditional theorems.  The
reported counterexamples have the premises claimed for them, and the reports do
not turn a finite search into an asymptotic theorem.  There are, however,
important formalization boundaries: several central affine estimates are still
paper proofs rather than Lean theorems, and the Pell theorem for arbitrary
actual Pell indices is represented in Lean by generic algebraic theorems with
explicit hypotheses rather than by a fully instantiated Pell-sequence theorem.
Consequently neither checkpoint closes `ABCConjecture`.

## 2. Affine route

### 2.1 Incidence identities and optimal constants

The class-incidence identity

\[
 \sum_d w_d n_d=\sum_\kappa m_\kappa L_\kappa
\]

is a finite change of summation and does not assume disjoint class tails.  The
pointwise factorization

\[
 n+6(n-1)^3-n^3=(n-1)(n-2)(5n-3)
\]

proves the coefficient-six bridge, with equality at (n=2).  Likewise the
coefficient-three refinement for (n\ge3) is sharp at (n=3), and
(n^3\le8(n-1)^3) for (n\ge2) is sharp at (n=2).  The deductions

\[
 \sum_\kappa(m_\kappa^3-m_\kappa)L_\kappa\le6E_{\rm sh}
\]

and

\[
 \sum_{m_\kappa\ge2}m_\kappa^3L_\kappa\le8E_{\rm sh}
\]

correctly account for singleton labels and singleton classes.  The novelty
ledger (J=A_1+\Omega) and weighted Hölder inequality
((A_1+\Omega)^3\le(A_0-\Omega)^2E_{\rm sh}) are also exact.

The corresponding Lean theorems kernel-check.  The optimality results were
strengthened from isolated failures at coefficients (5,2,7) to quantified
lower bounds on any proposed coefficient; these strengthened declarations also
kernel-check.

### 2.2 Pair catalogue and direction filter

For a common kernel coordinate (g_Z), putting
(c_Z=\gcd(g_Z,|A_Z|)) gives (g_Z/c_Z\mid q).  Pairwise coprimality of
the three coordinates justifies multiplying these divisibilities.  The local
Euler factor was independently expanded:

\[
 F(p^e,a)=
 \begin{cases}
 p^e,&v_p(a)\ge e,\\
 p^r+p^{r-1}(1-p^{-(e-r)}),&r=\min(e,v_p(a))<e.
 \end{cases}
\]

It yields the stated exact product

\[
 \prod_ZF(g_Z,|A_Z|)=C_g
 \prod_{p^r\parallel T_g}\left(1+\frac1p-\frac1{p^{r+1}}\right).
\]

All three terms in the hybrid bound were checked directly.  They arise,
respectively, by dropping the large-tail condition, by using
(T_d>N^2/C_g), and by writing
(w_d/T_d^2=(w_d/D_d)(C_d^2/D_d)).  No direction of an inequality is
reversed.

The powerful-excess implication is valid:

\[
\mathfrak E(G)>N,\qquad
 \mathfrak E(G)\le T_g\mathfrak E(C_g)
 \le T_g\mathfrak E(P_0),
\]

so (mathfrak E(P_0)>L).  The proof of the subsequent
(O(CN^{11/6})) direction count needs the following explicit transition:

\[
 \mathfrak E(|A_Z|^{(R)})>L^{1/3}
 \Longrightarrow \mathfrak E(|A_Z|)>L^{1/3}.
\]

One then counts the original coefficient values, which are at most two-to-one
after taking absolute values.  The (R)-free map itself is not injective.
The final report now states this transition, so the counting proof is sound.
It also correctly intersects the estimate with the trivial direction count:

\[
 O\!\left(\min\{N^2,CN^{11/6}\}\right).
\]

This is an exponent saving for fixed (C); it is not asserted to be a uniform
saving when (C) varies with (N).

The all-pair identity counts a label exactly
(\binom{n_\lambda}{2}) times.  The class-support skeleton covers both
possible sources of repetition: a loop in a class of multiplicity at least two,
or an edge between distinct singleton classes.  Large-label collinearity makes
the period independent of the supporting pair.  These observations justify the
two skeleton inequalities without assuming that different catalogues are
disjoint.

### 2.3 Full-premise affine boundaries

The three main witnesses were independently replayed.

1. For (B=5,C=6,R=30,M=388,N=387), the complete admissible fibre of
   ((361,841,1)) is exactly ((12,283),(373,363)).  Their common powerful
   kernel is the label itself, the primitive direction is ((361,80)), all
   three direction coefficients are nonzero, and (C_\lambda=D_\lambda),
   hence (T_\lambda=1).  The unique large downward label has weight
   (277704), and the coefficient-six bridge is an equality.
2. For (B=3,C=4,R=6,M=170,N=169), the two points in the complete fibre
   have distinct kernel classes, each of multiplicity one.  Their only common
   large label has period one and weight (29920).  This is a genuine
   singleton-class-overlap obstruction.
3. For (B=8,C=9,R=6<C,M=22143,N=22142), the congruences defining the
   common label ((137^2,173^2,1)) have exactly the two stated solutions in
   the complete box.  Both are admissible, their kernel classes are distinct,
   (T=1), and the common-tail charge is exactly
   (554413792).  Thus the obstruction survives the subcritical condition
   (R<C).

The (q_0)-boundary example at (B=10,C=11) also checks:
(G=1323), (C_g=P_0=441), (T_g=q_0=3), and the exact Euler mass is
(539>441).  It refutes deletion of the reduced-period factor, not the proved
Euler bound.

These examples retire only the exact stronger claims listed in Section 5
below.  None is a counterexample to the affine mother route.

### 2.4 Affine formalization boundary

The Lean module proves the occupancy bridges, finite incidence exchange,
baseline-free comparison, novelty ledger, owner moment, abstract pair double
count and cover, inverse-period rational algebra, and several numerical
certificates.  It does **not** yet formalize the paper's prime-power Euler
formula, the full three-term hybrid tail bound, the powerful-excess theorem,
the (O(CN^{11/6})) direction count, or the complete high-level construction
of the support skeleton from canonical affine points.  The computation scripts
test these formulas but are not substitutes for Lean proofs.  This is the
largest gap between the mathematical report and the user's requested
math-then-Lean workflow.

## 3. Pell--Lucas route

### 3.1 Quotient jets

The three-copy elementary-symmetric identities are exact.  Substitution of

\[
 a\equiv K_A+xC_A+x^2H_A\pmod{x^3},\qquad x=2\ell,
\]

into (v=6+8xa+4x^2a^2) gives the stated (A)-jet modulo (x^4); the
same calculation with (v=6+16xb+8x^2b^2) gives the (B)-jet.

The report initially described equality of the two jets as equivalent to the
complete third-order ledger.  That converse is too strong because it loses the
2-adic factor.  The corrected report records the exact relation

\[
 V_A-V_B=16\ell L-64\ell^4(C_A^2-2C_B^2).
\]

Thus (L\equiv0\pmod{8\ell^3}) implies jet equality modulo
(16\ell^4), whereas jet equality alone yields only
(L\equiv0\pmod{\ell^3}).  The unconditional companion-jet theorem itself
was always correct.  The corrected Lean module now proves both directions at
their exact moduli and gives the coefficient-level witness
((\ell,K_A,K_B,C_A,C_B,H_A,H_B)=(3,27,0,0,0,0,0)): its jets agree modulo
(6^4), while its ledger is (2214\equiv54\pmod{216}).  This is a
full-premise counterexample to the explicitly coefficient-only converse R3;
it is not asserted to be Pell-realizable.

### 3.2 Endpoint curvature and sharpness

At (	heta=(\ell-1)/2), the relation
((\ell-2)\alpha_{\theta-1}=\ell\beta_{\theta-1}) cancels the constant
term in the top adjacent determinant.  The remaining coefficient is exactly

\[
 \Delta_{\rm top}=2v\alpha_\theta^2U^2
 =2v32^{\ell-1}U^2.
\]

For odd Pell index, (U=A_\ell B_\ell) is odd.  From
(v^2-32U^2=4), every common divisor of (v) and (U) divides (4),
so the quotient (2v32^{\ell-1}) is a unit at every prime of (U).
Therefore

\[
 v_p(\Delta_{\rm top})=2v_p(U)
\]

at every support prime.  The claimed failure of (U^3)-divisibility follows
provided (U) is a nonunit, which holds at the stated odd prime indices.

The generic Lean proofs accurately encode this algebra.  Their hypotheses
explicitly include the adjacent-coefficient relation, tail definitions, norm
identity, nonunit condition, and coprimality of the top coefficient; they do not
smuggle in an unproved Pell or abc theorem.

### 3.3 Counterexamples and finite search

The local witness ((\ell,q,r)=(3,7,797)) satisfies the complete premises of
the explicitly local claim L3.  Both carrier primes and the index are prime;
the quotient residues, mod-eight kernel table, square cores, and three negative
Legendre/Jacobi signs hold; the lists have exactly three carrier copies; and
the complete ledger is divisible by (8\ell^3=216).  It is deliberately not
an actual Pell point:

\[
 q^6-2r^6+1=-512601560592751008\ne0.
\]

It therefore retires only the local-only inconsistency claim.

The index-seven witness is actual Pell data.  Direct recomputation gives
(A_7=239), (B_7=169), (U=40391), (v=228486), the stated top tails,
and

\[
 \Delta_{\rm top}\bmod U^3=24354030047568\ne0.
\]

This retires the proposed universal (U^3) strengthening.  It is not a
squarefull packet because (239\parallel A_7).

The finite evidence contains 57 index rows.  An independent enumeration
confirmed that these rows are exactly all odd primes from (3) through (271),
with no duplicate or omitted index.  At each row a certified prime divides one
Pell coordinate exactly once; the only witness above (2^{64}) has a complete
Pocklington certificate whose factorization covers all of (q-1).  Hence the
finite statement

\[
 A_\ell B_\ell\text{ is not squarefull for every odd prime }
 3\le\ell\le271
\]

is justified.  It is not an unbounded exclusion, and neither the report nor the
verification JSON presents it as one.

### 3.4 Pell formalization boundary

The Lean module proves the elementary-symmetric fingerprints, the exact
jet/ledger relation in both valid directions, conditional companion jets,
exact generic endpoint determinant, coprimality from the norm identity, generic
sharpness, and the displayed local and index-seven numerical certificates.  It
does not construct (A_\ell,B_\ell,E_r,F_r) and prove the
sharpness theorem for all odd prime indices inside one fully instantiated Lean
theorem.  Nor is the 57-row finite exclusion imported as a Lean certificate.
The theorem is mathematically unconditional because the missing instantiation
facts were proved in the ordinary mathematics and checked computationally, but
the current Lean artifact remains a conditional algebraic kernel plus finite
numerical boundary cases.

## 4. Reproducibility and axiom audit

All six affine replay and scan scripts listed in the report were rerun under
Python 3.13.5 and exited successfully.  They replay the complete fibres, Euler
identities, hybrid bounds, subcritical catalogues, an independent implementation,
and the six-box catalogue scan.  The Pell producer and independent verifier were
rerun; the verifier returned `PASS`.  The 15-entry Pell SHA-256 manifest also
returned `PASS` after reproduction.

The two Lean source files were checked directly with
`-DwarningAsError=true`; both exited with code zero.  The Pell axiom-audit file
also exited with code zero.  Every printed dependency was among Lean's standard
logical implementation axioms `propext`, `Classical.choice`, and `Quot.sound`.
The affine file prints its own axiom dependencies, with the same result.

The finite scripts are reproducibility evidence for arithmetic statements.
They do not prove a density estimate, an unbounded Pell exclusion, or the abc
conjecture.

## 5. Exact retirement ledger

The following claims are refuted by complete-premise witnesses and may be
retired exactly as written:

* every repeated canonical non-arm affine label has (T\ge2);
* a fixed strict fractional saving for (S_{\rm non}) against the exact
  common-tail skeleton mass;
* charging every repeated affine label only to kernel classes with
  multiplicity at least two;
* deleting (q_0) from (G\mid q_0P_0), or replacing the exact Euler factor
  by the false bound (F(g,A)\le C_g);
* the local-only claim L3 that the quotient residue, kernel-character and
  third-order-ledger premises are mutually inconsistent; and
* the coefficient-only converse R3 that companion-jet equality modulo (6^4)
  forces the complete ledger modulo (216); and
* universal (U^3)-divisibility of the highest adjacent Pell--Lucas
  determinant.

The following routes and targets remain active because no full-premise
counterexample was found:

* aggregation of divisibility-maximal affine powerful intersections using the
  exact Euler/tail minimum and both multiplicity and novelty;
* a global Pell theorem coupling squarefullness, opposite depth-three carriers,
  the full quotient ledger, all Lucas tails, endpoint curvature, and character
  incidence;
* construction of an actual counterexample to the standard abc conjecture; and
* an unconditional proof of the standard abc conjecture.
