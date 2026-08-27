# Audit of Joshi's arithmetic-Teichmuller proof of `abc`

**Status date:** 2026-08-27
**Primary target:** Kirti Joshi, *Construction of Arithmetic Teichmuller
Spaces IV: Proof of the abc-conjecture*, arXiv:2403.10430v2
**Necessary predecessor checked in detail:** *Construction of Arithmetic
Teichmuller Spaces III*, arXiv:2401.13508v4
**Method:** all ordinary, previously accepted theorems may be used.  The
negative conclusion below does not use the sociological premise that IUT or
Joshi's papers are “not accepted.”  It follows from explicit algebraic,
order-sign, and missing-interface failures in the displayed proof.

## Executive conclusion

The series does **not** presently provide an unconditional input from which
the repository can derive the standard `abc` conjecture.

The claimed final theorem has the right strength and the right quantifiers:
if Theorem 7.1.1 of Part IV were proved, its specialization to
`(P^1, {0,1,infinity}, Q, d = 1)` would imply standard `abc`, with a constant
depending only on `epsilon`.  The failure is earlier in the proof of that
theorem.

There are several independent, source-checkable obstructions.

1. Part III, PDF page 120, calls

   ```text
   product_w L'_w -> tensor_w L'_w,
   (a_w) |-> tensor_w a_w
   ```

   a homomorphism of `Q_p`-vector spaces.  It is not additive as soon as there
   are two factors.
2. Part III, PDF page 127, infers that a convex/hull locus containing certain
   distinguished cohomology classes contains a full tensor-product lattice.
   No independent-coordinate, module-stability, or reachability statement
   proving that inclusion is supplied.
3. Part III, PDF page 128, states a corollary whose left side is nonpositive
   and whose right side is positive under the paper's own normalization
   `|pi_w| = p_w^(-1)`.  Thus the displayed inequality cannot hold at a
   nontrivial Tate place.
4. Part IV, equation (6.11.7), PDF page 71, identifies the positive number
   `(1/(2 ell)) log(q-divisor)` with a sum of negative local logarithms.  This
   is a sign contradiction and also conflicts with the earlier type of
   `bold q_ell` as a positive real rather than a Tate parameter.
5. Part IV's Frobenius-shifted equality of theta-hull volumes is called a
   “tautology” on PDF page 67.  Identically normalizing the underlying number
   field does not identify the two shifted hulls or their Haar measures.  Part
   II 1/2 explicitly says that normalization coordinates move with the
   arithmeticoid and cannot in general be carried from one arithmeticoid to
   another.
6. The local upper bound in current Proposition 6.10.9, PDF page 69, is not
   proved for Joshi's newly defined theta locus; its proof is only a reference
   to IUT IV, Theorem 1.10, Step (v).  The necessary identification of
   Joshi's volume and q-depth with the quantities in that step is precisely
   what is missing, and its leading q-depth coefficient conflicts with the
   Part III local lower bound in the standard fixed-auxiliary-data test.

Correcting the two obvious minus signs would not repair items 1, 2, 5, or 6.
Consequently this is not a merely typographical rejection of the proof.

## 1. Papers and dependency path

The current versions used for this audit are:

| Part | arXiv source | Role in the claimed implication |
|---|---|---|
| I | [2106.11452](https://arxiv.org/abs/2106.11452) | local arithmetic-Teichmuller spaces, untilts, and actions |
| II | [2303.01662](https://arxiv.org/abs/2303.01662) | local theta/Tate estimates; rewritten successor to 2111.04890 |
| II 1/2 | [2305.10398](https://arxiv.org/abs/2305.10398) | adelic arithmeticoids, global Frobenius, and normalization |
| III | [2401.13508v4](https://arxiv.org/abs/2401.13508) | collation, product-to-tensor theta loci, and the lower volume bound |
| IV | [2403.10430v2](https://arxiv.org/abs/2403.10430) | upper volume bound, q/height comparison, Vojta inequality, and `abc` |

The decisive path is

```text
local theta classes
  -> adelic collated class locus
  -> tensor/hull theta locus with positive lower volume       [III]
  -> Frobenius-shifted lower/upper volume corridor             [IV]
  -> Tate-divisor / Frey-height inequality                    [IV]
  -> Vojta for the fundamental tripod
  -> standard abc.
```

The audit may grant the local geometric constructions in I, II, and II 1/2.
The first explicit false algebraic assertion encountered on the displayed
`abc` path is then the Part III product-to-tensor “homomorphism” on PDF page
120.  This claim is locally repairable only by changing it to a nonlinear set
map.  The first unrepaired positive-volume step is Theorem 9.11.1 on PDF page
127, and the immediately following sign contradiction on page 128 is fatal to
the theorem as printed.  This ordering does not claim that every earlier page
of the series has otherwise been fully certified.

## 2. Exact strength of the claimed main theorem

### 2.1 Theorem 7.1.1

Part IV, Theorem 7.1.1 (PDF page 72), states that for every

* number field `L`,
* geometrically connected smooth projective curve `X/L`,
* reduced divisor `D` with `U = X - D` hyperbolic,
* natural number `d`, and
* real `epsilon > 0`,

one has on all `P in U(Qbar)` with `[L(P):L] <= d`

```text
h_{omega_X(D)}(P)
  <= (1 + epsilon) (log-diff_X(P) + log-con_D(P))
     + A_{X,D,L,d,epsilon},
```

where the existence of a point-independent constant
`A_{X,D,L,d,epsilon}` is exactly the paper's definition of `lesssim` on PDF
page 28.  Theorem 7.2.1 (PDF page 75) then declares `abc` and arithmetic
Szpiro over `Q` true.

### 2.2 Conversion to the standard `abc` quantifiers

Fix

```text
L = Q,  X = P^1,  D = {0,1,infinity},  d = 1.
```

For a primitive integral triple `a+b=c`, use the rational point `P=a/c`.
Then, with the standard bounded-discrepancy conventions,

```text
log-diff(P) = 0,
log-con_D(P) = log rad(abc) + O(1),
h_{omega_X(D)}(P) = log max(|a|,|c|) + O(1),
```

because `omega_{P^1}(D)` is `O(1)`.  Hence Theorem 7.1.1 would give

```text
log max(|a|,|c|)
  <= (1+epsilon) log rad(abc) + A'_epsilon.
```

Since `|b| <= |a|+|c| <= 2 max(|a|,|c|)`, exponentiation gives

```text
max(|a|,|b|,|c|)
  <= C(epsilon) rad(abc)^(1+epsilon),

C(epsilon) = 2 exp(A'_epsilon).
```

The quantifier order is therefore exactly

```text
forall epsilon > 0,
  exists C(epsilon) > 0,
    forall primitive integral a,b,c with a+b=c, ... .
```

The fixed choices of `L,X,D,d` make `C(epsilon)` absolute.  The notation
`lesssim` only proves existence of this constant; it does not by itself give a
computable numerical value.  None of this conversion is the disputed step.

## 3. First false map: product is not sent linearly to pure tensors

Part III, PDF page 120 (source paragraph following the reduction to
Bloch--Kato logarithms), writes

```text
product_{w|p} L'_w -> tensor_{w|p} L'_w,
(a_w) |-> tensor_{w|p} a_w
```

and calls the first arrow “the natural homomorphism of `Q_p`-vector spaces.”
The canonical pure-tensor rule is multilinear in its separate inputs, not
linear on their direct product.

Already over `Q`, identify `Q tensor_Q Q` with `Q`.  The proposed rule becomes
`F(x,y)=xy`, but

```text
F((1,0)+(0,1)) = F(1,1) = 1,
F(1,0)+F(0,1) = 0.
```

Thus the asserted homomorphism does not exist in the stated form.  A free
vector space on the underlying set does map to the tensor product, but that is
not a linear map from the original direct product.  Replacing the arrow by a
continuous set map can preserve the cross-norm identity for individual pure
tensors; it does not justify later statements that its image is a linear
lattice or that linear/convex hull and volume operations commute with it.

The companion Lean theorem
`pureTensorScalar_not_additive` checks this counterexample without any IUT
axiom.

## 4. The missing positive-volume source in Part III

Theorem-definition 9.8.1.1, PDF pages 115--116, defines theta loci as convex
closures of collated cohomology-class values and then defines the tensor locus
as the image under the purported homomorphism.  Its proof says that the
remaining assertions are “easily assembled.”

Theorem 9.11.1, PDF page 127, claims

```text
Vol(Theta_M)
  >= product_{w in V_odd,ss} |q_w^(1/(2 ell))|^(ellStar).
```

The proof moves from “the locus contains the classes xi_z” to

```text
(tau_1 O_{L'_{w,1}}) tensor_{Z_p} ... tensor_{Z_p}
  (tau_ellStar O_{L'_{w,ellStar}})
  subset Theta_M
```

and calls that inclusion clear from construction.  Point-membership does not
imply this full-lattice inclusion.  One needs, at minimum, a theorem that the
actual reachable theta outputs permit the required independent integral
scalar variations in every tensor factor and that the chosen hull is stable
under those operations.  Neither the construction statement nor its short
proof supplies such a theorem.

This is not a harmless measure-zero issue.  A finite set, a diagonal family,
or a pure-tensor image can contain every displayed distinguished point while
having no full-rank lattice and zero Haar measure in the ambient space.  The
claimed lower bound requires an actual positive-measure source region.

The compactness corollary on the preceding pages also does not prove this:
compact containment gives an upper finiteness statement, not nonempty
interior or positive Haar volume.  Moreover, finiteness of a global product is
not a consequence merely of compactness of each factor; one must establish
that all but finitely many local factors have the normalized unit volume, a
fact asserted separately in Part IV.

## 5. Part III's Corollary 9.11.1.1 (claimed Corollary 3.12) has the wrong sign

Part III fixes, on PDF page 61, the local normalization

```text
|pi_w|_{C_{p_w}} = p_w^(-1).
```

At a genuine Tate place, `ord_w(q_w)>0`, so

```text
0 < |q_w^(1/(2 ell))| < 1,
log |q_w^(1/(2 ell))| < 0.
```

On PDF page 128, immediately before Corollary 9.11.1.1, the paper explicitly
assumes `log Vol(Theta_{M,p}) <= 0`.  The corollary is printed as

```text
-(1/ellStar) |log Vol(Theta_M)|
  >= - sum_{p,w} log |q_w^(1/(2 ell))|.
```

Its left side is nonpositive.  If there is any nontrivial Tate contribution,
the sum on the right before the outer minus sign is negative, so the printed
right side is positive.  The inequality is impossible.

The logarithmic consequence of Theorem 9.11.1 would instead have the
orientation/sign pattern

```text
(1/ellStar) log Vol(Theta_M)
  >= sum_{p,w} log |q_w^(1/(2 ell))|,
```

or, under the paper's nonpositive-log convention,

```text
-(1/ellStar) |log Vol(Theta_M)|
  >= sum_{p,w} log |q_w^(1/(2 ell))|.
```

The Lean theorem `corollary_9_11_1_1_sign_impossible` certifies the elementary
order contradiction in the printed formula.

## 6. Independent failures in Part IV

### 6.1 Frobenius shift does not tautologically preserve the hull volume

Theorem 6.10.1, PDF page 66, uses the lower bound at
`y'_0 = phi(y_0)`, the upper bound at `y_0`, and inserts the middle equality

```text
Vol(hull(Theta_M^{I,phi(y_0)}))
  = Vol(hull(Theta_M^{I,y_0})).
```

On PDF page 67, this is called a tautology because the number fields supplied
by the two arithmeticoids are identically normalized.  No isomorphism of the
two theta-output regions preserving hull construction and Haar measure is
constructed.

This inference is particularly unsupported by the series' own normalization
statements.  Part II 1/2 says that the product-formula normalization
coordinate `alpha_y` moves with `y`, that there is no uniform choice over the
arithmeticoid space, and that the normalization of one normalized
arithmeticoid cannot in general be carried over to another (source paragraphs
around its normalization discussion and height-dependence proposition).
Part IV, Remark 6.10.2 on PDF page 66, likewise says that the concurrent
normalization “precludes direct comparison of various local quantities.”

Equal normalization on the common base number field controls only that base
scale.  The desired equation concerns Frobenius-shifted theta hulls in
different local ambient data.  It needs a genuine equivariance and
measure-preservation theorem, not the product formula alone.

### 6.2 Proposition 6.10.9 imports, rather than proves, the upper interface

Current Proposition 6.10.9, PDF page 69 (Proposition 6.10.7 in v1), states
locally

```text
-|log Vol(Theta_{M,p})| / ellStar
  <= (ell+1)/4 * {
       (1+4/ell) log d_{L',p}
       -(1/6) log q_p
       +(4/ell) log s_{Q,p}
       +(20/3) e_mod* log s_p^<= }.
```

The entire proof is the sentence that this is the last equation in IUT IV,
Theorem 1.10, Step (v), page 658, and that its proof is all of Step (v).  A
citation can transfer a theorem only after its objects and hypotheses have
been identified.  Here the required identification between IUT IV's
log-shell/theta quantities and the Part III convex/tensor locus, volume, local
normalization, and Tate divisor is not proved.

The coefficient test makes the missing identification visible.  Ignoring
bounded auxiliary terms, the repaired Part III lower estimate has leading
q-depth slope

```text
-1/(2 ell),
```

whereas Proposition 6.10.9 has upper leading slope

```text
-(ell+1)/24.
```

For every odd `ell >= 5`, `(ell+1)/24 > 1/(2 ell)`.  Thus, in a family with
increasing multiplicative depth and the remaining local data bounded, the
putative upper endpoint becomes more negative than the lower endpoint.  A
valid application must either show a compensating growth theorem for the
other terms or show that the two q-depths are not being compared on that
family.  The paper proves neither.  This is the concrete content of Peter
Scholze's public observation that the claimed local lower theorem and the
then-numbered Proposition 6.10.7 contradict each other; the present v2
renumbers the proposition but still gives only the Step (v) citation.

The audit does not infer that no proof of `abc` could ever use local
inequalities.  It finds that these two particular local bounds have not been
placed in one valid common normalization.

### 6.3 Equation (6.11.7) is sign- and type-inconsistent

Part IV defines the Tate divisor by

```text
mathfrak q_M = sum_w ord_w(q_w) w,
log(mathfrak q_M) = deg(mathfrak q_M)/[M:Q].
```

For a nonzero effective Tate divisor this logarithmic arithmetic degree is
positive.  Theorem 6.10.1 then defines

```text
bold q_ell^{y_0} = (1/(2 ell)) log(mathfrak q),
```

again a positive real number.

Equation (6.11.7), PDF page 71, subsequently declares

```text
|log(bold q_ell)|
  := sum_{p,w} log |q_w^(1/(2 ell))|_{L'_w}
```

and then asserts

```text
(1/(2 ell)) log(mathfrak q) = |log(bold q_ell)|.
```

The left side is positive and the displayed sum on the right is negative.
Furthermore, if `bold q_ell` retains its earlier definition as the positive
real `(1/(2 ell)) log(mathfrak q)`, then `|log(bold q_ell)|` means the absolute
value of the real logarithm of that number, not the number itself.  The same
notation is therefore being used with incompatible types/meanings.

The correct product-formula relation would include a minus sign and the
appropriate local degree weights.  Merely inserting that minus sign does not
prove the Frobenius-hull equality or the source/upper-bound interfaces above.
The Lean theorem `positive_degree_ne_negative_localLogSum` certifies the
printed sign conflict.

## 7. Relation to the repository's eta-orbit and Frey gaps

Joshi's papers do not bypass the repository's existing honest interfaces.
They instantiate each missing interface by an assertion that is either
unproved or inconsistent as displayed.

| Repository interface | What a genuine closure needs | Corresponding step in Joshi | Audit result |
|---|---|---|---|
| `EtaOrbitMinimalGap.VolumeQuotientInterface.etaMap_eq_iff_volume_eq` | equality of the two represented scalar volumes | Part IV p. 67 calls the Frobenius-shifted hull-volume equality a tautology | equality is assumed, not derived from an equivariant measure-preserving map |
| `HonestGeneratedSource` | an actually reachable finite-positive source region, inclusion in theta output, and monotone volume | Part III p. 127 asserts the full tensor lattice lies in the theta locus | distinguished points do not establish full-lattice reachability or positive measure |
| `CanonicalQPilotCorridor` | one source-fixed q-log and a verified lower/upper coefficient corridor | Part III p. 128 plus Part IV pp. 69--71 | sign contradiction and incompatible q-depth coefficients |
| `FreyCalibratedIUTIVBridge.qLog_eq_freyJHeight` | equality between the canonical source q-log and the actual Frey `j`-height | Part IV equation (6.11.7) | the proposed calibration equates positive and negative quantities |
| `FreyConductorCalibratedIUTIVBridge` | a uniform estimate of the actual canonical main term by the Frey discriminant/conductor | Part IV Proposition 6.10.9 and subsequent global sum | the local upper inequality is imported without identifying Joshi's locus/normalization with IUT IV's |

Thus the proof reaches the same four bottlenecks already isolated in the
repository:

```text
genuine eta/Frobenius volume equality,
honest positive-volume theta source,
native q-log/Frey-height calibration,
uniform source main-term/conductor estimate.
```

No accepted theorem cited in Parts I--IV supplies these four statements for
the objects actually constructed there.  Standard theorems about Tate curves,
Bloch--Kato logarithms, product formulas, Haar measure, Vojta reductions, or
Frey curves may all be granted; none turns a collection of reachable points
into the required full tensor lattice or identifies two different shifted
hull volumes.

## 8. Machine-checked companion and its limits

The file
[`IUTThreeClosures/JoshiArithmeticTeichmullerAudit.lean`](IUTThreeClosures/JoshiArithmeticTeichmullerAudit.lean)
contains four unconditional elementary results:

1. the scalar pure-tensor model is not additive;
2. the logarithm of a normalized Tate norm in `(0,1)` is negative;
3. a positive normalized divisor degree cannot equal a negative local-log
   sum;
4. `-|logVolume|/ellStar` cannot dominate a positive right-hand side.

These lemmas use Mathlib only and introduce no axiom.  They certify the local
algebra/sign objections, not the semantic assertion that every object in the
papers has been formalized.  They are therefore audit certificates, not a new
unconditional theorem toward `abc`.

## 9. Verdict

Even under the expanded rule allowing every previously accepted theorem,
arXiv:2403.10430v2 does not yield an unconditional `abc` input for this
repository.  The standard-`abc` specialization and its constants are fine;
the volume-to-q-to-height bridge is not.

The earliest explicit false assertion on the checked dependency path is the
Part III page-120 vector-space homomorphism.  The earliest decisive missing
source theorem is the Part III page-127 full-lattice inclusion.  Part III page
128 and Part IV page 71 then give direct sign contradictions.  Part IV pages
67 and 69 respectively assume the eta/Frobenius volume equality and import the
IUT IV upper estimate without proving that it applies to Joshi's quantities.

Accordingly, no `ABCConjecture` theorem, bridge inhabitant, or new axiom should
be added on the basis of this paper series.

## References

* Kirti Joshi, [Construction of Arithmetic Teichmuller Spaces IV: Proof of the
  abc-conjecture, arXiv:2403.10430](https://arxiv.org/abs/2403.10430).
* Kirti Joshi, [Construction of Arithmetic Teichmuller Spaces III,
  arXiv:2401.13508](https://arxiv.org/abs/2401.13508).
* Kirti Joshi, [Construction of Arithmetic Teichmuller Spaces II 1/2,
  arXiv:2305.10398](https://arxiv.org/abs/2305.10398).
* [MathOverflow: Global character of ABC/Szpiro
  inequalities](https://mathoverflow.net/questions/467696/global-character-of-abc-szpiro-inequalities),
  especially the explicit comparison of the local lower theorem with the
  former Proposition 6.10.7.
* [MathOverflow: Is there a mistake in Mochizuki's proof of Theorem 1.10 in
  IUTT IV?](https://mathoverflow.net/questions/468079/is-there-a-mistake-in-mochizukis-proof-of-theorem-1-10-in-iutt-iv),
  which distinguishes an error in Joshi's identification/application from a
  claim that the cited IUT IV line is itself the same statement.
