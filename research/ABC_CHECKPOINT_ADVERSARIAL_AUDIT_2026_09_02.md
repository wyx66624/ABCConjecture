# Adversarial Audit of the Actual-Haar and Mersenne Sigma-One Checkpoint

**Auditor:** ChatGPT  
**Date:** 2 September 2026  
**Verdict:** pass after one critical definition correction; no unconditional
abc proof or disproof is present

## 1. Scope

This audit checks the following artifacts against their mathematical claims,
their Lean statements, and their reproducible computations:

* `ABC_IUT_ACTUAL_HAAR_ADMISSIBLE_ORBIT_2026_09_02.md`;
* `IUTActualHaarAdmissibleOrbit20260902.lean` and its axiom audit;
* `2026_09_02_iut_actual_haar_orbit/`;
* `ABC_MERSENNE_SIGMA_ONE_EXACT_ORDER_COUPLING_2026_09_02.md`;
* `MersenneSigmaOneExactOrderCoupling20260902.lean`;
* `2026_09_02_mersenne_sigma_one/`.

The checks were deliberately hostile to the intended conclusions.  In
particular, they looked for reversed Haar scaling, missing local-degree
factors, a desired volume identity smuggled in as a premise, nonuniform use of
Brun--Titchmarsh, an unjustified Yamada specialization, incomplete fibres in
the finite counterexamples, and Lean theorems weaker than their prose labels.

## 2. Finding ledger

### Finding F1 -- corrected critical error in the definition of `a_d`

The first audited version asserted

\[
 \log\frac{2^d-1}{\operatorname{rad}(2^d-1)}
 =\sum_{\operatorname{ord}_p(2)=d}
   (v_p(2^d-1)-1)\log p.
\]

This is false.  At `d=6`, one has `2^6-1=3^2*7`; the left side is
`log 3`, while the primes have orders two and three, so the displayed right
side is zero.  This was reported before sealing.  The route report has now
been corrected to define

\[
 E_d=\prod_{\operatorname{ord}_p(2)=d}
       p^{v_p(2^d-1)-1},\qquad a_d=\log E_d,
\]

and it explicitly warns that this exact-order block is not generally the full
radical loss of `2^d-1`.  With this correction, the later four-way identity is
about the canonical exact-order block and is valid.

**Disposition:** the false equality is retired.  The exact-order Mersenne
route remains active.

### Finding F2 -- no remaining fatal mathematical or formal defect

After F1 was corrected, the audited local Haar theorems, finite Mersenne
kernels, and computational witnesses passed the checks below.  This verdict
does not upgrade any open asymptotic estimate, tensor construction,
same-pilot comparison, IUT theorem, or the abc conjecture to a proved result.

### Scope qualification Q1 -- the rational-prime Lean theorem is a
factorization theorem

The Lean theorem `primeScalarPreimage_normalizedLogVolume` does not construct
the cast of a rational prime inside an actual LANA tensor summand.  It takes a
scalar `a`, a norm-one unit `u`, and the premises

\[
a=u\pi^e,\qquad |u|=1,\qquad |k|=p^f,\qquad e,f>0,
\]

and proves the normalized shift.  This is a correct general theorem, not an
assumption of the desired volume equality.  To obtain the literal public
prime-preimage law one must still set `a` equal to the image of `p` and build
these factorization/cardinality facts for every actual tensor component.  The
route report lists exactly this seam and therefore does not overclaim it.

### Scope qualification Q2 -- the raw-weight counterexample is formally
coefficient-level

`weight_sum_one_not_sufficient` proves the exact numerical obstruction
`log(p^2) != log p` for `p>1`.  Mathematically this is realized by an
unramified quadratic extension of `Q_p`, where `e=1`, `f=2`, and singleton
weight one.  The current Lean theorem does not construct that local field.
It is therefore a full counterexample to the proposed coefficient inference,
while a fully internalized local-field counterexample remains optional future
formalization.  The report's wording “numeric local datum” correctly records
this boundary.

## 3. Actual-Haar audit

### 3.1 Preimage direction and sign

For `m_a(x)=a*x`, the carrier identity is

\[
 m_a^{-1}(U)=a^{-1}U.
\]

If the distributive Haar character satisfies
`mu(aU)=Delta(a)mu(U)`, then

\[
 \mu(m_a^{-1}U)=\Delta(a^{-1})\mu(U),\qquad
 L(m_a^{-1}U)=L(U)+\log\Delta(a^{-1}).
\]

For a uniformizer, `Delta(pi)=q^{-1}`.  Hence a uniformizer **preimage**
adds `log q`; direct multiplication by the uniformizer subtracts `log q`.
This agrees with IUT III, Proposition 3.9(i), where multiplication by the
residue characteristic subtracts `log p`.  No sign reversal was found in the
report or Lean.

### 3.2 Finite-positive and compact-open domains

`mulPreimageRegion` derives measurability, finite measure, and nonzero measure
from the actual normalized additive Haar measure and the genuine
change-of-variables theorem.  It does not store the target logarithmic shift
as a field.  `HaarCompactOpenRegion.mulPreimage` separately proves compactness
and openness under the scalar homeomorphism.  Thus the empty-set and
whole-space fixed-point counterexamples to total-domain scaling do not apply
to the finite-positive source domain.

The structure packages a finite-positive proof in addition to compactness and
openness.  For a nonempty compact-open subset of a locally compact field,
those measure properties are automatic, so this is mathematically the source
domain with proof data attached.  Lean does not currently provide the reverse
constructor from an arbitrary nonempty compact-open set; no later theorem
depends on such a constructor.

### 3.3 The `e*f` normalization

At a finite extension of `Q_p`, write

\[
 p=u\pi^e,\qquad |u|=1,\qquad q=p^f.
\]

Raw additive Haar measure gives

\[
 \Delta(p)=q^{-e},\qquad
 L(p^{-1}U)-L(U)=e\log q=ef\log p.
\]

Dividing each raw component log-volume by the positive local degree `ef`
therefore gives exactly `log p`.  A subsequent weighted sum gives `log p`
when the weights sum to one.  The Lean proof follows precisely these steps:
`distribHaarChar_primeScalar`, then `primeScalarPreimage_logVolume`, then
division in `primeScalarPreimage_normalizedLogVolume`, and finally
`weighted_normalized_primeScalarPreimage`.  The target shift is not among the
premises.

This calculation is source-compatible, but it is not yet a construction of
the log-volume on a LANA tensor summand.  Tensor decomposition, local degrees
of the resulting summands, and the connection to `componentVol` remain open.

### 3.4 Orbit and envelope obstruction

The orbit `B_n=pi^{-n} O_K` satisfies

\[
 m_\pi^{-1}(B_n)=B_{n+1},\qquad L(B_n)=n\log q.
\]

Since `q>1`, equality of two orbit regions forces equality of their indices.
If one finite-positive region contained every `B_n`, monotonicity would bound
`n log q` above by one finite real number, a contradiction.  This eliminates
only a common finite-positive envelope for the complete orbit; it does not
contradict a least hull attached to one fixed relatively compact region.

## 4. Mersenne sigma-one audit

### 4.1 Exact four-way split after F1

For a prime in the exact-order block, put

\[
 w_p=v_p(2^{d_p}-1),\qquad r_p=(p-1)/d_p.
\]

When `w_p>=2`, one copy of `log p` belongs to exactly one of `U` or `B`,
according to the size cutoff.  The remaining `w_p-2` copies belong to exactly
one of `V` or `G`, according to the multiplier cutoff.  Thus

\[
 a_d=U_d+B_d+V_d+G_d
\]

is exact for the corrected canonical `a_d`.  There is neither overlap nor a
missing boundary: the size split uses `<=` versus `>`, and the multiplier
split uses `<` versus `>=`.

### 4.2 Weighted Brun--Titchmarsh and uniformity

Put `X=d^2/F_m`.  Every prime in `U_d` is `1 mod d`, hence
`U_d<=theta(X;d,1)`.  In the fixed polylogarithmic window,

\[
 d>m/A_m^k,\qquad d/F_m\longrightarrow\infty,\qquad F_m^2<d
\]

uniformly.  The last inequality is exactly equivalent to
`d<X^(2/3)`.  Murty--Seguin, Theorem 2.4, states the weighted
Brun--Titchmarsh inequality for fixed exponent below one and sufficiently
large `X`, so its use with `2/3` is uniform in this window.  Also

\[
\log X\le2\log d,\qquad
 \log(X/d)=\log(d/F_m)\ge\tfrac12\log d.
\]

Consequently

\[
 U_d\ll\frac{d^2}{F_m\varphi(d)}
 \ll\frac d{A_m}.
\]

Summing with `d=m/q` and `q<Q_m=A_m^k` gives

\[
 \sum U_d\ll\frac m{A_m}\sum_{q<Q_m}\frac1q
 =O_k(mL_m/A_m)=o(m).
\]

The quantifier order is correct: `k` and the Brun--Titchmarsh exponent are
fixed before `m` tends to infinity.  The source used for the theorem was the
authors' paper, available at
`https://mast.queensu.ca/~murty/murty-seguin.pdf`, Theorem 2.4.

### 4.3 Yamada specialization

Yamada's Theorem 1.2, equation (7), gives

\[
 v_p(2^{p-1}-1)
 \le \left\lfloor
 C_Y\frac{p-1}{(\log p)^2}\right\rfloor+4,
 \qquad C_Y=283\log3\log6.
\]

For `d=ord_p(2)` and `r=(p-1)/d`, odd-prime LTE gives

\[
 v_p(2^{p-1}-1)=v_p(2^d-1)+v_p(r)=w_p,
\]

because `1<=r<p`.  Therefore, for `w_p>=3`,

\[
 (w_p-2)\log p
 \le C_Y\frac{dr}{\log p}+2\log p.
\]

This is exactly the pointwise estimate assumed in the transfer theorem.  It
is not silently assumed to imply the unresolved Farey-energy bound.  The
primary manuscript checked was `https://arxiv.org/abs/math/0607072`.

### 4.4 Farey energy and stable layers

The common-index relations `dq=m` and `p-1=dr` give

\[
 r/q=(p-1)/m.
\]

Equality of two slopes forces equality of `dr`, then of the represented
prime, its exact order, `q`, and `r`.  The Lean `EndpointExactOrderRow`
encodes exactly the algebra needed for this conclusion.  Primality and depth
are intentionally absent because they are not used by the injectivity proof.

The bound `E_k(m)=o(log m)` is not proved or encoded in Lean.  The report
correctly labels it as the surviving conditional input.  Its abstract Farey
counterexample uses reduced pairs only to refute the inference from slope
injectivity alone and is explicitly not presented as a Mersenne
counterexample.

For an odd prime, order modulo `p^j` equals the base order exactly when
`j<=w_p`.  The Lean proof establishes both divisibilities and then uses the
factorization criterion for `p^j | 2^d-1`.  The layer count separates layer
two from layers three through `w_p` without changing weights.

### 4.5 Eventual multiplier coupling

If `p=1+dr`, `r<H`, and `d>0`, integrality gives
`p<=dH`.  Thus the hypotheses `dH<=d^2/F` and `p>d^2/F` force `r>=H`.
In the fixed window,

\[
 F_mH_m\le A_m^{3/2}\sqrt{L_m}<d
\]

eventually and uniformly, since `d>m/A_m^k`.  The eventual inclusion of the
`B` support in the high-multiplier support is therefore valid.  The finite
3511 witness does not contradict this theorem because its `m` precedes the
unspecified eventual threshold.

## 5. Counterexample audit

### 5.1 The 1093 complete-fibre witness

The verifier recomputes the complete factorization

\[
 \Phi_{364}(2)=1093^2\cdot4733\cdot8861085190774909
 \cdot556338525912325157.
\]

Lucas certificates establish primality of every factor.  Exact-order
residues establish order 364 for every factor.  Prime-power residues give
depth two only for 1093 and depth one for the other factors.  The exact
rational logarithmic certificate proves `q<Q_m`, the strict `B` cutoff, and
`H_m=3=r_p` for `q=10^12`, `m=364q`, `k=8`.  Hence the complete fibre has

\[
 U=V=G=0,\qquad B=a_{364}=\log1093>0.
\]

This is a full-premise counterexample to `B=0`, every finite pointwise
`B<=C G`, and “high-multiplier repeated implies depth at least three.”  It is
not an asymptotic counterexample.

### 5.2 The 3511 finite-quantifier witness

For `p=3511`, `d=1755`, `q=10^71`, and `k=32`, the certificates prove
primality, exact order, depth two, `q<Q_m`, the strict `B` cutoff, and
`r=2<H_m=5`.  This meets every premise of the all-`m` inclusion
`B implies r>=H` and refutes it.  It does not meet the negation of an eventual
fixed-window theorem and therefore does not retire that theorem.

### 5.3 Exhaustive finite boundary

A fresh rebuild and full scan of all 50,847,534 primes through `10^9`
reproduced the archived file byte for byte.  The only hits were 1093 and
3511, and the independent exact verifier established depth two for both.
The absence of depth-three hits in this bounded range is not used as an
asymptotic assertion.

## 6. Lean audit

The following commands passed with warnings promoted to errors:

```text
lake env lean -DwarningAsError=true \
  IUTThreeClosures/IUTActualHaarAdmissibleOrbit20260902.lean
lake env lean -DwarningAsError=true \
  IUTThreeClosures/IUTActualHaarAdmissibleOrbit20260902AxiomAudit.lean
lake env lean -DwarningAsError=true \
  IUTThreeClosures/MersenneSigmaOneExactOrderCoupling20260902.lean
```

The IUT audit prints axioms for 33 declarations; the Mersenne module prints
axioms for 19 declarations.  Every audited declaration depends only on
`propext`, `Classical.choice`, and `Quot.sound`.  No `sorryAx` appears.  A
static scan found no declaration of a custom `axiom` or `opaque` constant and
no use of `sorry`, `admit`, or `native_decide` in the three Lean files.

The formalization boundary is faithful:

* Lean proves the actual Haar change-of-variables identities and finite
  normalization algebra;
* Lean does not construct the LANA tensor/place realization or same-pilot
  comparison;
* Lean proves finite Mersenne injectivity, energy, stable-layer, and ledger
  kernels;
* Lean does not prove Brun--Titchmarsh, the totient bound, Yamada's theorem,
  any little-oh statement, or the full finite window certificates.

## 7. Computation audit

Both archived checksum manifests passed.  Independent replay hashes were:

```text
IUT normalization output
  e7404985aa91505a61d284e63dd3bd542897a3b449f853385032c2495605bda2

Mersenne exact-witness output
  ab4d3ae848cb5ab96d16a84e0b5fab1f86bc04db5853bb7cbae37ccab6992a69

Mersenne full p<=10^9 scan
  b1fdc1854d0936be526fee6b8e9df27e3d3db7dc8e312f2fc25cc57c8d1fa7e1
```

Each replay matched its archived artifact byte for byte.  The Haar Python
check uses floating point only as supporting evidence; the corresponding
identities and strict obstruction are symbolic Lean theorems.  The Mersenne
window booleans use exact rational exponential enclosures, and the displayed
Decimal values are not trusted by the certificate.

## 8. Exact retirements and active routes

The audit supports retiring only the following exact claims:

* the erroneous identification of one exact-order block with the full
  radical loss of `2^d-1`;
* a nonzero Haar shift on all subsets or all nonempty subsets;
* a single finite-positive envelope for the whole expanding uniformizer
  orbit;
* raw Haar volume plus weight sum one as a sufficient normalization in
  residue degree two;
* `B=0`, finite pointwise `B<=C G`, the all-`m` implication
  `B implies r>=H`, and “high-multiplier repeated implies deep”;
* the abstract inference that distinct Farey slopes alone force little-oh
  energy.

The following routes remain active:

* construction of the normalized actual-Haar volume on every LANA tensor
  component and its admissible class;
* global possible-image realization and the horizontal same-pilot/IUT
  comparison;
* the exact-order energy estimate `E_k(m)=o(log m)`;
* the stable small-order prime-power mass estimate for the `B+G` packet;
* the stronger common high-multiplier packet estimate.

Difficulty, lack of a current estimate, and a bounded no-hit computation are
not reasons to retire any of these active routes.

## 9. Sealing recommendation

The checkpoint may be sealed after carrying the corrected canonical
definition of `a_d` into every paper occurrence.  Any future claim that the
raw-weight counterexample is Lean-formalized as an actual local field should
first instantiate an unramified quadratic extension.  Any future claim that
the rational-prime Haar law closes the LANA seam should first construct the
cast-prime factorization, residue-degree identity, normalized component
volume, and tensor packet transport rather than merely reusing the abstract
factorization theorem.
