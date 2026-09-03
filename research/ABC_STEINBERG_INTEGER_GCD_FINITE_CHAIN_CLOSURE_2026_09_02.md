# Integer exponent gcds and finite-support Steinberg chains

**Author:** ChatGPT
**Date:** 2026-09-02
**Scope:** closure report for adversarial findings S-I2 and the exact-boundary part of S-I4
**Lean companion:** `Lean/IUTThreeClosures/SteinbergIntegerFiniteChain20260902.lean`
**Axiom audit:** `Lean/IUTThreeClosures/SteinbergIntegerFiniteChain20260902AxiomAudit.lean`
**Input-ready paper section:** `paper/steinberg_integer_finite_chain_2026.tex`

## 1. Exact status

| Item | Status after this companion | Precise scope |
|---|---|---|
| S-I2: integer exponent-gcd/base bridge | **LEAN-CLOSED** | Every positive integer has the stated canonical power decomposition, including the unit convention; the normalized exponent gcd is proved to be one for the mathematically correct nonunit scope; radical, height, and defect identities are connected. |
| S-I4(a): concrete finite-support coordinates and cell norm | **LEAN-CLOSED** | Actual `Finsupp` divisor and ordered exterior-coordinate types are defined. The weighted norm/mixed-area identity is proved for every effective pairwise-disjoint finite-support triple, and specialized to canonical positive reduced rational cells. |
| S-I4(b): exact-boundary finite-chain estimate | **LEAN-CLOSED UNDER THE DISPLAYED EXACT BOUNDARY EQUALITY** | For a finite signed chain of canonical cells whose integral finite-support surfaces satisfy the stated equality, the abstract theorem `finiteFilling_boundary_le_calibratedCost` is instantiated and yields the calibrated inequality. |
| S-I4(c): chains generated inductively by the permitted rational five-term moves | **OPEN / NOT FORMALIZED** | This companion does not define the five move constructors, their side conditions, or the reflexive/symmetric/transitive/additive closure they generate, and does not prove that such generated chains satisfy the exact boundary equality. |
| Gate VF analytic estimates | **OPEN** | No uniform mixed/coherent estimate or residual estimate is assumed or proved. |

There is no full-premise counterexample here, so no exact statement is
retired.  In particular, the five-term route remains open rather than
refuted.  No abc inequality or other open gate is used.

## 2. Paper proof for S-I2

Let `n` be a positive integer.  When `n>1`, write its unique factorization as

\[
  n=\prod_{p\in S}p^{e_p},\qquad e_p>0,qquad S\ne\varnothing.
\]

Define

\[
  g(n)=\gcd_{p\in S}e_p,
  \qquad
  u(n)=\prod_{p\in S}p^{e_p/g(n)}.
\]

For the unit, set

\[
  g(1)=1,\qquad u(1)=1.
\]

This convention is necessary because the prime support of `1` is empty.
In particular, it would be false to say that the ordinary gcd over the
empty support is one: in the `Finset.gcd` convention used by Lean it is zero.
Thus the exponent-gcd-one assertion below is deliberately restricted to
`n>1`.

### Proposition 2.1 (canonical power decomposition)

For every positive integer `n`,

\[
  g(n)>0,\qquad n=u(n)^{g(n)},\qquad u(n)>0.
\]

**Proof.**  The unit case follows from the convention.  If `n>1`, its prime
support is nonempty.  The gcd of the positive exponents on a nonempty finite
support is positive, and it divides each `e_p`.  Hence

\[
  g(n)\frac{e_p}{g(n)}=e_p
\]

for every `p` in the support.  Unique factorization then gives

\[
 u(n)^{g(n)}
 =\prod_{p\in S}p^{g(n)(e_p/g(n))}
 =\prod_{p\in S}p^{e_p}=n.
\]

The displayed product is positive.  In Lean, `u(n)` is represented
canonically by `Nat.floorRoot (g(n)) n`; the factorization theorem for
`floorRoot`, together with divisibility of every exponent by `g(n)`, proves
that its factorization is exactly the quotient factorization above.  QED.

### Proposition 2.2 (primitive exponent vector)

If `n>1`, then `u(n)` has the same prime support as `n` and

\[
  \gcd_{p\mid u(n)}v_p(u(n))=1.
\]

**Proof.**  For `p\in S`, both `e_p` and `g(n)` are positive and
`g(n)\mid e_p`, so `e_p/g(n)>0`.  No supported prime disappears, and no new
prime occurs; hence the supports agree.  Dividing all members of a finite
nonzero family by their gcd gives a family with gcd one:

\[
 \gcd_{p\in S}\frac{e_p}{g(n)}=1.
\]

These quotients are precisely the positive prime exponents of `u(n)`.  QED.

The same support equality also gives

\[
  \operatorname{rad}(u(n))=\operatorname{rad}(n)
\]

for every positive `n`, including `n=1`.

### Proposition 2.3 (height and defect split)

Put

\[
 h(n)=\log n,\quad h_u(n)=\log u(n),\quad r(n)=\log\operatorname{rad}(n),
\]

and define the coherent and residual thicknesses by

\[
 \nu(n)=(g(n)-1)h_u(n),
 \qquad
 \sigma(n)=h_u(n)-r(n).
\]

Then, for every positive `n`,

\[
 h(n)=g(n)h_u(n),
 \qquad
 h(n)-r(n)=\nu(n)+\sigma(n),
 \qquad
 \nu(n),\sigma(n)\ge0.
\]

**Proof.**  The power decomposition and the logarithm-of-a-natural-power
identity give `h(n)=g(n)h_u(n)`.  Since `g(n)>=1` and `h_u(n)>=0`, the coherent
term is nonnegative.  Support preservation gives
`r(n)=log rad(u(n))`, and `rad(u(n))<=u(n)` gives `sigma(n)>=0`.  Finally,

\[
 \begin{aligned}
 h(n)-r(n)
 &=g(n)h_u(n)-r(n)\\
 &=(g(n)-1)h_u(n)+(h_u(n)-r(n))\\
 &=\nu(n)+\sigma(n).
 \end{aligned}
\]

For `n=1`, all three heights and both thicknesses are zero.  QED.

Applying this split to the three positive legs of a primitive rational cell
and polarizing the quadratic contact area gives the concrete cell identity

\[
  2\Phi=M+V+R,
\]

where `M` is the one-sided radical polarization, `V` is the contact loss
formed from the three coherent thicknesses, and `R` is the contact loss
formed from the three primitive residual thicknesses.  This is an equality;
no analytic estimate is inserted.

## 3. Paper proof for the exact finite-support part of S-I4

### 3.1 Actual finite-support coordinates

Use the integral divisor lattice

\[
  D=\mathbb N\to_0\mathbb Z
\]

and the ordered-pair coordinate module

\[
  E=(\mathbb N\times\mathbb N)\to_0\mathbb Z.
\]

Here `to_0` denotes finite support.  The indexing type contains all natural
numbers, but valuation divisors are supported only on primes.  Define

\[
 (X\otimes Y)_{p,q}=X_pY_q,
 \qquad
 X\wedge Y=X\otimes Y-Y\otimes X,
\]

and

\[
 \Omega(A,B,C)=(A-C)\wedge(B-C).
\]

This is a concrete signed ordered-coordinate encoding of the exterior
surface.  Both orientations are stored, so its weighted `ell^1` expression
is divided by two.

For a finite set `S`, nonnegative weights `w_p`, and effective divisors
`A,B,C : N ->_0 N`, set

\[
 L_{S,w}(A)=\sum_{p\in S}A_pw_p
\]

and

\[
 \|\Omega\|_{S,w}
 =\frac12\sum_{p,q\in S}|\Omega_{p,q}|w_pw_q.
\]

### Proposition 3.1 (pointwise six-block formula)

If the supports of `A,B,C` are pairwise disjoint, then for every ordered
pair `(p,q)`,

\[
\begin{aligned}
 |\Omega_{p,q}|={}&A_pB_q+B_pA_q+B_pC_q+C_pB_q\\
                  &+C_pA_q+A_pC_q.
\end{aligned}
\]

**Proof.**  At each coordinate `p`, pairwise disjointness says that at most
one of `A_p,B_p,C_p` is nonzero.  Apply the resulting three cases at `p` and
again at `q` to the three-leg expansion

\[
 \Omega_{p,q}
 =A_pB_q-A_qB_p+B_pC_q-B_qC_p+C_pA_q-C_qA_p.
\]

In each of the nine cases, the nonzero summands have one sign, and taking
absolute values gives the displayed six nonnegative rectangular terms.
QED.

### Proposition 3.2 (exact weighted mixed-area identity)

Under the same support hypothesis,

\[
 \boxed{
 \|\Omega(A,B,C)\|_{S,w}
 =L_{S,w}(A)L_{S,w}(B)
  +L_{S,w}(B)L_{S,w}(C)
  +L_{S,w}(C)L_{S,w}(A). }
\]

**Proof.**  Substitute Proposition 3.1 and distribute the two finite sums.
For example,

\[
 \sum_{p,q\in S}A_pB_qw_pw_q=L_{S,w}(A)L_{S,w}(B).
\]

Every unordered cross-leg block occurs in its two orientations.  The factor
`1/2` cancels that duplication and leaves the three displayed products.
All sums are finite, so no convergence or interchange issue arises.  QED.

### 3.2 Canonical positive rational cells

A canonical cell consists of positive naturals `(a,b,c)` satisfying

\[
 a+b=c,\qquad \gcd(a,b)=1.
\]

It represents the reduced rational number `a/c` in `(0,1)`.  The two
additional coprimalities follow immediately:

\[
 \gcd(a,c)=\gcd(b,c)=1.
\]

Therefore the three factorization divisors have pairwise disjoint supports.
Take `S` to be the finite union of those supports and `w_p=log p`.  Unique
factorization gives

\[
 L_{S,w}(v(a))=\log a,\quad
 L_{S,w}(v(b))=\log b,\quad
 L_{S,w}(v(c))=\log c.
\]

Proposition 3.2 now yields the exact concrete identity

\[
 \Phi(a,b,c)
 =\log a\log b+\log b\log c+\log c\log a.
\]

Combining it with Proposition 2.3 proves `2 Phi=M+V+R` for the actual
finite-support surface of every canonical cell.

### 3.3 Exact-boundary finite chains

Let `I` be finite.  A concrete chain in this companion consists of a target
cell `P_0`, cells `P_j`, coefficients $n_j\in\mathbb Z$, and the exact equality in
the integral finite-support coordinate module

\[
  \Omega(P_0)=\sum_{j\in I}n_j\Omega(P_j).                 \tag{3.1}
\]

Let `S` be the finite union of all prime supports in the target and the
cells.  Evaluate (3.1) at each $(p,q)\in S\times S$, cast to the reals, and
multiply by `(1/2) log(p) log(q)`.  This gives the coordinate boundary
identity required by the already-proved abstract finite filling theorem.
The logarithmic weights are nonnegative on `S`, because every member of `S`
is prime.  The concrete norm lemma identifies every coordinate sum with the
cell's `Phi`; the cell identity identifies `2 Phi_j` with `M_j+V_j+R_j`.
The abstract finite triangle inequality therefore gives

\[
 \boxed{
 \Phi(P_0)\le
 \frac12\left(
   \sum_j|n_j|(M_j+V_j)+\sum_j|n_j|R_j
 \right). }
\]

This theorem is exact at its stated scope.  Equality (3.1) is a field of the
chain structure, hence a premise.  The theorem does **not** prove the
existence of a filling of a prescribed target and does **not** prove that a
chain obtained from the intended five-term moves has (3.1).

## 4. The remaining S-I4 gap

The following construction remains **OPEN / UNFORMALIZED**:

1. define the permitted positive rational five-term moves, with all domain
   and sign conditions;
2. define the inductively generated equivalence or relation, including the
   required closure operations;
3. prove that each generator has zero finite-support boundary;
4. prove by induction that every generated chain satisfies (3.1);
5. if the intended route needs existence, construct a generated filling for
   the target class in question.

The present exact-boundary theorem can be used after items 1--4, but it
cannot replace them.  It also supplies no bound for either analytic term in
Gate VF.

## 5. Lean declaration inventory

### S-I2 arithmetic bridge

* Definitions: `rawExponentGCD`, `exponentGCD`, `primitiveBase`,
  `primitiveBaseHeight`, `coherentThickness`,
  `primitiveResidualThickness`.
* Unit convention: `exponentGCD_one`, `primitiveBase_one`,
  `primitiveBaseHeight_one`, `coherentThickness_one`,
  `primitiveResidualThickness_one`.
* Positivity and divisibility: `rawExponentGCD_pos`, `exponentGCD_pos`,
  `exponentGCD_dvd_factorization`, `primitiveBase_pos`.
* Power and primitive-base statements: `primitiveBase_factorization`,
  `primitiveBase_pow_exponentGCD`, `exponentGCD_power_decomposition`,
  `primitiveBase_support_eq`, `primitiveBase_exponent_gcd_one`,
  `primitiveBase_radical_eq`.
* Height and defect statements:
  `legHeight_eq_exponentGCD_mul_primitiveBaseHeight`,
  `primitiveBaseHeight_eq_height_div_exponentGCD`,
  `exponentDefect_integer_veronese_residual`,
  `primitiveBaseHeight_nonneg`, `coherentThickness_nonneg`, and
  `primitiveResidualThickness_nonneg`.

### S-I4 finite-support and exact-boundary bridge

* Concrete coordinate types and operations: `FiniteDivisor`,
  `ExteriorCoordinate`, `FiniteExteriorSurface`, `finiteTensor`,
  `finiteWedge`, `finiteContact`, `finiteValuationDivisor`.
* Canonical cells: `PositiveRationalCell`, `PositiveRationalCell.value`,
  `PositiveRationalCell.surface`, and
  `positiveRationalCell_pairwiseDisjoint`.
* Exact cell norm: `EffectiveDivisor`, `integralize`,
  `effectiveContactSurface`, `effectiveContactSurface_natAbs`,
  `weightedMassOn`, `weightedContactNormOn`,
  `weightedContactNormOn_eq_mixedArea`,
  `weightedMassOn_factorization_eq_legHeight`,
  `PositiveRationalCell.logWeightedNorm`, and
  `PositiveRationalCell.logWeightedNorm_eq_fullContactArea`.
* Integer split inside the concrete cell:
  `PositiveRationalCell.mixedCost`,
  `PositiveRationalCell.coherentCost`,
  `PositiveRationalCell.residualCost`, and
  `PositiveRationalCell.two_logWeightedNorm_eq_mixed_coherent_residual`.
* Finite chain instantiation: `FiniteRationalCellChain`,
  `restrictedWeightedCoordinate`,
  `sum_abs_restrictedWeightedCoordinate`,
  `FiniteRationalCellChain.coordinateNorm_eq_cellNorm`,
  `FiniteRationalCellChain.coordinate_boundary`, and
  `FiniteRationalCellChain.boundary_le_calibratedCost`.

## 6. Verification and axiom boundary

The following commands are the direct checks for the two new Lean files:

```text
cd Lean
lake env lean -DwarningAsError=true IUTThreeClosures/SteinbergIntegerFiniteChain20260902.lean
lake env lean -DwarningAsError=true IUTThreeClosures/SteinbergIntegerFiniteChain20260902AxiomAudit.lean
```

Both commands exit with code `0` and no warnings.  The audit prints every
listed theorem as depending only on Lean's standard logical/quotient
principles

```text
propext, Classical.choice, Quot.sound
```

with no project-specific axioms.  A lexical scan of the companion and audit
finds no `sorry`, `admit`, or `axiom` declaration.

The input-ready English paper section was also compiled independently with
the bundled Tectonic engine via

```text
python scripts/compile_latex.py \
  E:\AImath\abc猜想\output\latex_2026_09_02_steinberg_integer_finite_chain\steinberg_integer_finite_chain_smoke.tex \
  --compiler tectonic \
  --output-directory E:\AImath\abc猜想\output\latex_2026_09_02_steinberg_integer_finite_chain\build_verified \
  --json
```

The command exits with code `0`; its resolved second pass has no undefined
references or overfull boxes and produces
`output/latex_2026_09_02_steinberg_integer_finite_chain/build_verified/steinberg_integer_finite_chain_smoke.pdf`.
