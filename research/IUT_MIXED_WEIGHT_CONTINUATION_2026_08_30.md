# Rational packets, normalized volumes, and the local theta-pilot dictionary

**Author:** ChatGPT  
**Research date:** 2026-08-30  
**Status:** proved local interfaces and a scoped counterexample to a direct dictionary; no proof or disproof of ABC.

This note continues `IUT_REACHABILITY_CONTINUATION_2026_08_30.md`. It resolves
the place-weight problem for the rational Frey branch, gives the actual
maximal-order normalization used in the upper-bound source, and proves
covariance of the entire all-isomorphism collation under a change of target.
The same variables then distinguish a native, unpowered Kummer input from
the squared-exponent theta-pilot used in the cited upper-bound computation.
The last distinction is tested on a concrete rational Frey curve.

The counterexample below is to the assertion that the literal unpowered
Kummer packet can, in one fixed local field with its native normalization,
be put in the particular squared-exponent container appearing in IUT IV,
Theorem 1.10, Step (v). It is not a counterexample to IUT, to every possible
dictionary between the theories, or to ABC. A dictionary using a different
arrow, input family, or normalization must specify and prove those changes.

## 1. Primary sources and positions

The following original texts were inspected, including the formulas rather
than only abstracts or summaries. Page numbers below are physical PDF pages.

| Text | Version and inspected positions | Use |
| --- | --- | --- |
| [Joshi III](https://arxiv.org/pdf/2401.13508v4) | v4, arXiv 2025-02-24; pp. 27–29, 32–35, 100–105, 109–117, 121–128 | Initial fields; selected places; tensor packet; the precise Kummer classes; collation; hull and volume conventions. |
| [Joshi IV](https://arxiv.org/pdf/2403.10430v2) | v2, arXiv 2025-02-24; pp. 38, 51–53, 66–70 | Rational moduli field; level extensions; the two-target comparison; citation of IUT IV Step (v). |
| [Joshi II-half](https://arxiv.org/pdf/2305.10398v12) | v12, 2025-02-24; pp. 35–37, 47–49 | The perfected-monoid Frobenius; Kummer description; the all-isomorphism collation. |
| [Mochizuki, IUT IV, author's PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf) | Title-page date **April 2020**, 87 pp.; pp. 9–14, 17, 26–29 | Different/logarithm containers; maximal-order-normalized log-volume; mixed-place weights; the actual squared-exponent pilot in Step (v). |

The fourth file was obtained directly from the author's Kyoto website and
is archived at
`research/sources/continuation_2026_08_30/Mochizuki_IUT_IV_April2020.pdf`.
It has 632,447 bytes and SHA-256
`5bf4b1e0a8c2686562a6859e5009d301335044cfb5efec5d3a9edf764e4af87f`.
It is an author-hosted April 2020 version, not silently described as the
paginated 2021 journal file. Joshi IV cites journal p. 658; the corresponding
Step (v) computation inspected here is on PDF pp. 27–29.

## 2. The rational Frey branch really has one selected place per prime

Let `a,b,c` be positive integers with `a+b=c` and `gcd(a,b)=1`, and let

```text
C/Q : y^2 = x(x-a)(x+b),       X = C minus its origin.
```

Its discriminant is `16*a^2*b^2*c^2`, so it is nonsingular. Its three
nonzero 2-torsion points are rational. The Legendre parameter is
`lambda=-b/a in Q minus {0,1}`. After `x=aX`, the Frey curve is a quadratic
twist of the Legendre curve `Y^2=X(X-1)(X-lambda)`; both have rational
`j`-invariant and rational field of moduli.

**Proposition 2.1.** In the initial-data construction of III, sections 3.1
and 3.3, starting with this `X` gives `L_mod=Q`. Passing to the indicated
torsion fields does not change this `L_mod`. There is a place-compatible
selected set for which `W_p` has exactly one element for every finite prime
`p`.

**Proof.** The field in III, 3.1(4), is the field of moduli of the underlying
curve `X`, before the later level structures. Since `X` is defined over `Q`,
each element of `Gal(Qbar/Q)` preserves its isomorphism class. The fixed
field defining its absolute field of moduli is therefore `Q`. In the
Legendre description, IV, section 5.3, explicitly identifies the field of
moduli of the unlevelled moduli point with `Q(j_lambda)`, giving the same
answer.

The extensions in IV, 4.1.2 and 5.7.1, have the form

```text
L_tpd = L_mod(C[2]),
L     = L_mod(i,C[2*3*5]),
L'    = L(C[ell]).
```

For this rational full-2-torsion curve, `L_tpd=Q`. Adjoining these torsion
points does not change which object was used to define `L_mod`. Both `L/Q`
and `L'/Q` are Galois: Galois automorphisms permute each full finite torsion
group, and also preserve the field obtained by adjoining `i`.

Choose one extension `w(p)` to `L'` of each rational prime `p`. This gives
the bijection of III, 3.3(14), with the place compatibility used by the local
restriction/corestriction maps in Proposition 9.4.2.4. It follows that the
set `W_p` of III, 9.4.1, is `{w(p)}`. This is the selected set, not the set
of *all* places of `L'` over `p`. The bare word “bijection” in 3.3(14)
alone would not imply place compatibility; the choice here satisfies it
explicitly and is the one required by 9.4.2.4(4). QED.

Consequently, at a fixed finite prime, set

```text
E=L'_{w(p)},        d=[E:Q_p],        gamma=1/d.
```

The field `E/Q_p` is Galois. A block with `m` tensor slots has

```text
T_m = tensor^m_{Q_p} E,
A_m = tensor^m_{Z_p} O_E,
D_m = dim_{Q_p}(T_m)=d^m.
```

It still has its internal finite-etale field decomposition; eliminating
mixed *places* does not eliminate that decomposition. For the procession
used in IUT IV, Step (iv), `m=j+1`, `1<=j<=s=(ell-1)/2`.
III's procession displays contain indexing inconsistencies; here the
explicit slot set `{0,...,j}` in III 9.4.5 / IUT IV Step (iv) fixes the
meaning of `m`. No missing slot is filled by an unstated theta power.

This proposition concerns the fields and the selected-place choice. It
does not prove the global existence theorem IV 5.7.1 for every Frey triple,
its exceptional-set assertion, or all its compactness and prime-window
hypotheses.

## 3. Two normalizations, with the exact conversion

For a finite extension `F/Q_p`, write

```text
|x|_F = |Norm_{F/Q_p}(x)|_p,      mu_F(O_F)=1.
```

Thus `mu_F(x O_F)=|x|_F` and `|p|_F=p^{-[F:Q_p]}`. This is the
module absolute value forced by the Haar identities in III, 9.10.2. It is
not an arbitrarily rescaled untilt absolute value.

Let `T=E_1 tensor ... tensor E_m = product_alpha F_alpha`, let
`A=O_{E_1} tensor ... tensor O_{E_m}`, and let
`B=product_alpha O_{F_alpha}`. Put `d_i=[E_i:Q_p]` and
`D=product_i d_i`. The embeddings of the finite free tensor order into
the separable tensor algebra are injective. Both `A` and `B` are full
`Z_p`-lattices, and `I=[B:A]` is finite.

Normalize additive Haar measures by `mu_A(A)=1` and `mu_B(B)=1`. Then

```text
mu_A = I * mu_B,
V_A(U) = log(mu_A(U))/D,
V_B(U) = log(mu_B(U))/D,
V_A(U) = V_B(U) + log(I)/D.                         (3.1)
```

The corresponding positive functionals are `nu_A=mu_A^(1/D)` and
`nu_B=mu_B^(1/D)`. They are not asserted to be additive measures when
`D>1`; the additive objects are the underlying Haar measures.

**Proposition 3.1 (complete tensor determinant formula).** For nonzero
`tau_i in E_i` and `t=tensor_i tau_i`,

```text
V_B(tB) = sum_i log(|tau_i|_{E_i})/d_i,
V_A(tB) = log(I)/D + sum_i log(|tau_i|_{E_i})/d_i.   (3.2)
```

If `H` is a measurable `B`-module containing `t`, both equalities give
lower bounds for `V_B(H)` and `V_A(H)`, respectively.

**Proof.** The element `t` is invertible, with inverse the tensor of the
`tau_i^{-1}`. Multiplication by `t` is the tensor of the multiplication
operators on the `E_i`. A tensor operator has determinant

```text
det(m_t) = product_i Norm_{E_i/Q_p}(tau_i)^(D/d_i).
```

This identity follows by extending scalars to an algebraic closure and
multiplying all eigenvalues, each eigenvalue from the `i`-th factor
occurring `D/d_i` times. The Haar modulus of a `Q_p`-linear automorphism
is the `p`-adic absolute value of its determinant, so (3.2) follows from
`mu_B(B)=1` and (3.1). Finally, `t in H` and `B`-linearity imply `tB subset H`;
monotonicity of Haar measure gives the lower bounds. QED.

For completeness, let `delta(F)` be the exponent of `p` in the
discriminant ideal of `O_F/Z_p`. Trace-pairing matrices give

```text
delta(A) = sum_i (D/d_i)*delta(E_i),
delta(B) = sum_alpha delta(F_alpha),
log_p(I) = (delta(A)-delta(B))/2.                    (3.3)
```

Indeed, the tensor basis has trace Gram matrix the tensor of the individual
Gram matrices, giving the first formula by the tensor determinant identity.
The trace form is the orthogonal direct sum on the field decomposition,
giving the second. Changing an integral basis from `B` to `A` multiplies
the discriminant by the square of its lattice index, giving the third.

**Corollary 3.2 (rational Galois packet).** In section 2, put
`delta=delta(E)`. The explicit decomposition

```text
E tensor ... tensor E -> product_{(sigma_2,...,sigma_m) in Gal(E/Q_p)^(m-1)} E,
a_1 tensor ... tensor a_m |-> (a_1*sigma_2(a_2)*...*sigma_m(a_m))_sigma
```

is a `Q_p`-algebra isomorphism. Thus

```text
log_p[B_m:A_m] = (m-1)*d^(m-1)*delta/2,
V_A(U)-V_B(U) = (m-1)*delta/(2d)*log(p).             (3.4)
```

**Proof.** Separability proves the usual Galois tensor decomposition first
for two factors; iteration gives the displayed map. Each of its
`d^(m-1)` field factors is `E`. Formula (3.3) has
`delta(A)=m*d^(m-1)*delta` and `delta(B)=d^(m-1)*delta`, proving (3.4).
QED.

For tensor lattices `U=V_1 tensor ... tensor V_m` in `T_m`, the
`A_m` normalization satisfies exactly

```text
nu_A(U) = product_i mu_E(V_i)^(1/d).                (3.5)
```

One proves this by taking integral bases of the `V_i` and applying the
determinant formula to their basis-change matrices. Thus the repeated
weight `gamma=1/d` is well-defined on the rational packet, including
nonsplit internal tensor algebras.

There is an actual source normalization difference here. III 9.10.3.1
assigns value `1` to `A_m`, by its factor prescription. IUT IV,
Proposition 1.4(i), PDF p. 13, instead normalizes the log-volume of the
maximal order `B_m` to zero. These are compatible **after** (3.4), not
before it. In the Galois case all internal field components are isomorphic,
so the canonical normalized average of their degree-normalized log-Haar
volumes is exactly `V_B`. Its invariance under permutation of the
isomorphic components gives equal weights. It satisfies the displayed
normalizations of IUT IV 1.4(i), and also the tensor-lattice correction
identity used in its proof on p. 14.

The previous note's positive index term in the native lower bound is
therefore available with `V_A`, but must not be carried into an upper
estimate computed with `V_B`. This does not destroy the native lower bound:
`V_B(tB)` still has exactly the desired unpowered root contribution.

## 4. A native point and the complete all-isomorphism target change

Let `b_p=p` for odd `p` and `b_p=4` for `p=2`. For `a in O_E`, put

```text
lambda(a)=log(1+b_p*a)/b_p.
```

The logarithm-series proof in the preceding note gives

```text
a != 0  ->  lambda(a) != 0 and |lambda(a)|_E=|a|_E;
|lambda(1)|_E=1.                                  (4.1)
```

This is the normalized coefficient printed in III 9.7.2.2. Calling it
`lambda` avoids silently replacing the source's `1/b_p` convention by an
unscaled Bloch-Kato logarithm.

Suppose a split multiplicative rational curve at `p` has its native Tate
parameter `q in Q_p`, and `a in E` satisfies `a^(2ell)=q`. Every
marking-preserving copy of this data has

```text
|lambda(a)|_E^(1/d) = |q|_p^(1/(2ell)).             (4.2)
```

Indeed, take the native norm of `a^(2ell)=q`, and use
`|q|_E=|q|_p^d` and (4.1). In a block with one theta entry and `m-1`
background entries, write

```text
t = lambda(1) tensor ... tensor lambda(1) tensor lambda(a).
Q_pilot = -log(|q|_p)/(2ell) > 0.
```

For the `B_m`-module hull `H_m` containing this actual collated point,

```text
V_B(H_m) >= V_B(tB_m) = -Q_pilot.                  (4.3)
```

This is also the correct component of the normalized Tate degree in
IV 4.4 and 5.4. For a number field `M` over `Q`, base changing this
split Tate curve and summing the primes over `p` gives

```text
(1/[M:Q])*sum_{v|p} ord_v(q)*log(Norm(v))
 = (1/[M:Q])*sum_{v|p} e_v*f_v*v_p(q)*log(p)
 = v_p(q)*log(p),
```

because `sum_{v|p}e_v*f_v=[M:Q]`. Dividing by `2ell` gives
`Q_pilot`. Thus the selected-place calculation and the normalized
all-place Tate-degree calculation agree on these native inputs.

The construction of this point uses one coherent field-marking-induced
Kummer isomorphism for each arithmetic label. It does not require independent
linear actions on repeated slots. Its occurrence in the set-theoretic
tensor image follows from III 9.8.1.1(4)–(6), since convex closure retains
each original collated tuple. The `B_m` hull then retains `tB_m` by the
proved module argument. No assertion about the raw tensor image being a
module is involved.

We next prove a statement about the **whole** output set, not just `t`.

Fix once and for all:

* a family of source labels and source cohomology groups `C_y`;
* a set of source configurations, with a finite typed list of classes in
  the appropriate `C_y` for each configuration;
* the requirement that the same isomorphism is used whenever a source
  label is repeated in a configuration;
* the allowed isomorphisms, either all topological group isomorphisms, or
  the groupoid of Galois-induced isomorphisms.

Denote by `Psi_k` the union of all the resulting collated tuples with
target `C_k`. This is the all-isomorphism construction of III 9.7.5.1 and
II-half 7.5.1, with its source classes held fixed. In the Galois-induced
case, composition with a field-marking-induced isomorphism stays in the
same groupoid. An arbitrarily selected, non-composition-closed subclass
would require a separate hypothesis; no such subclass is assumed below.

**Theorem 4.1 (full target-reset covariance).** Let `c:C_0 -> C_1` be an
allowed target isomorphism. Then

```text
Psi_1 = c^{slots}(Psi_0).                          (4.4)
```

If, in logarithmic coordinates, `c` is induced by a local field marking,
the same covariance holds for closed convex closure, tensor image, and
maximal-order module hull. In particular,

```text
H_1 = c_tensor(H_0),       V_{A_1}(H_1)=V_{A_0}(H_0),
                          V_{B_1}(H_1)=V_{B_0}(H_0). (4.5)
```

**Proof.** Postcomposition gives a bijection

```text
Iso(C_y,C_0) -> Iso(C_y,C_1),      f |-> c composed with f,
```

whose inverse is postcomposition by `c^{-1}`. Apply this to the whole
family of maps attached to a configuration. Any equality constraint
requiring repeated labels to use the same map remains true after
postcomposition, in both directions. The source classes and configurations
are unchanged. Taking the union over them proves (4.4).

A continuous additive homomorphism of finite-dimensional `Q_p` vector
spaces is `Q_p`-linear: first use integer linearity, then continuity and
density to obtain `Z_p` linearity, and invert powers of `p`. The product
map `c^{slots}` is therefore a linear homeomorphism. It sends closed
convex subsets to closed convex subsets, and its inverse does the same;
minimality of convex closure proves covariance of that step. The
tuple-to-tensor map commutes with the tensor of the field maps, by its
definition on pure tensors.

A field marking induces an algebra isomorphism of the finite-etale
tensor targets and carries their maximal orders to one another, because
integrality over `Z_p` is preserved by an algebra isomorphism. It also
carries the tensor orders `A_0` and `A_1` to one another. Transport the
smallest `B_0`-module containing the first tensor-image set; its image is
a `B_1`-module containing the second image. Apply the inverse map and
minimality for the reverse inclusion. This proves the hull equality.

The pushforward of Haar measure normalized on `A_0` is Haar measure
normalized on `A_1`, by uniqueness; the same holds for `B_0,B_1`.
Dimensions agree, so the normalized log-volumes agree. QED.

**Corollary 4.2 (compatible source reindexing).** Replacing the source
configuration index by a bijective copy, and pulling back both its label
map and every class along that bijection, leaves the all-isomorphism
collation unchanged. A tuple witness on either side gives one on the
other by the bijection or its inverse. In particular, reindexing the
arithmetic labels is harmless only after the asserted class compatibility
has been included in the data.

The ordinary module span of a collated set also commutes with target
reset: a linear equivalence sends the least module containing a set to
the least module containing its image, as follows by applying the
equivalence and its inverse to the two minimality inclusions. This
algebraic observation does not identify that span with the source's
holomorphic hull.

For a bounded source set with a unit point in each field component, the
fractional `B`-module hull used here exists: component valuations have an
integer lower bound, their nonempty sets of values attain minima, and the
ideals with those minima form the unique smallest product of fractional
ideals containing the set. This also proves measurability and compactness.
In the finite-prime all-isomorphism construction, boundedness follows
already because integral cohomology is carried into one fixed integral
log-shell lattice; convex closure stays in its finite product and the
tensor image stays in a compact tensor lattice. The source's additional
printed restriction `lambda_alpha in O_{F_alpha}` in III 9.10.7 requires
the image set to be integral. Fractional existence alone does not prove
that stronger restriction. Integrality is checked explicitly for the
counterexample block below.

The source family `tilde Sigma` is introduced before the choice of a
standard target. III 9.7.5.1 uses that target for collation. Thus (4.4)
is applicable to the literal construction with the same source family.
Also, III 4.4 defines a standard point by its image in the Frobenius
quotient curve; moving it along that Frobenius orbit keeps it above the
same canonical quotient point. Thus the reset may use `phi(y_0)` as
target. This proves (4.5) for this reset interpretation; it does not
identify every additional operation intended by IV 6.10.1 with that reset.

## 5. Frobenius and theta powers, in the same variables

Write a possibly rescaled untilt norm on the marked finite field as

```text
N_y(x)=|x|_E^(s_y),                 s_y>0.
```

The native Haar quantity associated to one input is always

```text
|lambda(a)|_E^(1/d) = N_y(lambda(a))^(1/(d*s_y)).    (5.1)
```

Consequently, changing `s_y` alone does not amplify the native weighted
Haar contribution. Omitting the factor `1/s_y` would produce a different
numerical functional. This assertion uses only the displayed local
formula; it does not assume a comparison of unmarked untilt rings.

There are several different operations that must not be substituted for
one another. In this table `q`, `a^(2ell)=q`, `u=1+b_p*a`, and
`tau=lambda(a)` refer to the same initial marked data throughout.

| Operation | Data actually preserved or changed | Native coefficient and volume effect | What follows about a full hull |
| --- | --- | --- | --- |
| Field-marking target reset | Source configurations, `q,a,u`, Kummer classes, and degree weights are fixed; only the target copy changes. | `tau` is transported by a field isomorphism; `|tau|_E^(1/d)` is unchanged. | Theorem 4.1 proves equality after transport for the whole all-isomorphism hull. |
| Rescale only the untilt norm | `q,a,u,tau` and the native tensor orders are fixed; `s_y` changes. | Raw `N_y(tau)` changes, but (5.1) exactly compensates. | No native Haar amplification results from this change. |
| Replace the Tate parameter by `q^p` | The native root becomes `a^p` up to a root of unity; the input is rebuilt as `1+b_p*a^p`. | Coefficient `lambda(a^p)` has native root contribution `|a|_E^(p/d)`. | This is a different source family. Its hull is not related by the fixed-source proof without another theorem. |
| Raise the principal unit `u` to its `p`-th power | The Kummer class is multiplied by `p`; this is not rebuilding it from `q^p`. | The normalized logarithm is `p*tau`, not `lambda(a^p)` in general; its weighted norm is `p^{-1}*|a|_E^(1/d)`. | Multiplication by `p` is not an automorphism of the nonzero integral Kummer lattice. Powering all `m` slots scales the tensor hull by `p^m` and changes `V_B` by `-m*log(p)`. |
| Replace the root in block `j` by `a^(j^2)` | The input becomes `1+b_p*a^(j^2)`; this changes the theta class even with the same curve and native norm. | The one-theta block contributes `-j^2*Q_pilot`, rather than `-Q_pilot`. | Target-reset covariance can be proved for this new family too, but does not identify it with the old family. |

The fourth row follows from the identity

```text
log(u^p)/b_p = p*log(u)/b_p.
```

The integral logarithmic lattice is a free `Z_p`-module of positive
rank `d`. Its quotient by `p` has cardinality `p^d`, so multiplication
by `p` is not surjective on that lattice. If it is applied to every
slot, the tensor map is multiplication by `p^m`; its Haar modulus
is `p^(-mD)`, proving the claimed `-m*log(p)` change after division
by `D`.

Its distinction from the third row is not merely formal. For `p=3`,
`E=Q_3`, and `a=3`, equation (4.1) gives

```text
v_3(p*lambda(a))=2,       v_3(lambda(a^p))=3.
```

They are unequal. Thus a diagram that identifies these two coefficients
without an extra operation has a strict counterexample. Also, for
`0<|q|_p<1`, the Tate `j`-expansion gives
`v_p(j(q))=-v_p(q)`, while `v_p(j(q^p))=-p*v_p(q)`; the latter
curve is not the same marked elliptic curve.

The Frobenius power map in II-half, Corollary 5.6.2, is explicitly a map
of the **perfected multiplicative monoids** `tilde K`. Such a monoid is
not the finite-field integral Kummer lattice. III 9.8.1.1(3) instead
defines the action on class families by relabelling
`phi(xi_z):=xi_{phi(z)}`. That displayed definition does not say that the
map is multiplication by `p` on the fixed logarithmic lattice. A coherent
native root choice `a_y=i_y(a)` is compatible with relabelling via
field markings and with Theorem 4.1. It is not simultaneously a native
`q -> q^p` operation.

In particular, the same convention that makes (4.3) give

```text
(1/s)*sum_{j=1}^s V_B(H_j) >= -Q_pilot
```

does not obtain a `j^2` factor from a norm rescaling. If the source classes
are actually replaced by the squared-root-power classes, the single-point
lower bound becomes only

```text
(1/s)*sum_j V_B(H_j) >= -((s+1)*(2s+1)/6)*Q_pilot.  (5.2)
```

Since `(s+1)*(2s+1)/6=ell*(ell+1)/12`, this is a different bound.
It does not imply the unpowered bound. Finding a stronger lower bound
for the correctly powered possible-image family remains a legitimate
research task; its absence is not treated as a counterexample.

## 6. The upper estimate's set and an explicit local dictionary test

### 6.1 What the original Step (v) estimates

IUT IV, Theorem 1.10, Step (iv), PDF pp. 26–27, explicitly describes
the object to be bounded as the holomorphic hull of the union of possible
images of a theta-pilot, with its relevant Kummer isomorphisms and
indeterminacies. For a block `{0,...,j}`, Step (v) then uses

```text
lambda_theta = j^2 * v_p(q)/(2ell)                 (6.1)
```

at a bad place. The `j^2` is explicit both in the pilot on p. 27 and
in the coefficient `j^2/(2ell)` on p. 28. It is not inferred by us
from the notation of a different paper.

For each local field factor, write `e_i` for its ramification index and
`differ_i` for the `v_p`-valuation of a different generator. The source
Propositions 1.1–1.4 use

```text
a_i = (1/e_i)*ceil(e_i/(p-2))          (p>2),
b_i = floor(log(p*e_i/(p-1))/log(p)) - 1/e_i,
d_I = sum_i differ_i,   a_I=sum_i a_i,   b_I=sum_i b_i.
```

Their final maximal-order container is

```text
C_theta = p^(floor(lambda_theta-d_I-a_I)-b_I) * B.  (6.2)
```

Here a rational exponent means the fractional ideal of the corresponding
valuation, in the relevant field components; it is not an arbitrary
choice of a real-power scalar. The proof estimates the log-volume of
this container. It does not prove (6.2) contains an unrelated family of
unpowered principal-unit classes.

### 6.2 A Frey curve realizing incompatible native valuations

**Proposition 6.1 (failure of the direct native dictionary).** Let

```text
p=109,     ell=7,     s=3,
(a_Frey,b_Frey,c_Frey) = (1,109^36-1,109^36),
C/Q : y^2=x(x-1)(x+109^36-1),
L=Q(i,C[30]),       L'=L(C[7]),       E=L'_w  (w|109).
```

Use the native field marking and normalized coefficient of section 4.
In the block `j=2`, `m=3`, the explicitly specified local/native
implementation of the one-theta, two-background recipe of III 9.8.1.1,
using coherent marking maps, has a holomorphic hull containing a unit
tensor `t` whose componentwise `v_p`-valuation is `180/35`.
This is not an additional assertion that the full global source
construction has been instantiated for this curve and this `ell`.
The container (6.2), with
the powered pilot (6.1) in the *same* local field, has componentwise
valuation `598/35`. In particular,

```text
t notin C_theta,        H_native notsubset C_theta. (6.3)
```

This disproves the asserted direct containment of that native packet in
that powered-pilot container. It does not assert that IUT proves this
direct dictionary, or that no different dictionary can work.

**Proof.** The triple is positive, primitive, and satisfies `a+b=c`.
Put `b=109^36-1`. The invariants of the displayed Weierstrass equation are

```text
Delta=16*b^2*(b+1)^2,       c4=16*(1+b+b^2).
```

At `p=109`, `b=-1 mod p`, hence `c4` is a unit and
`v_p(Delta)=72`. The model is minimal and has multiplicative reduction.
The reduced cubic is `x(x-1)^2`; at the node `(1,0)`, its tangent
cone is `y^2=(x-1)^2`. Both tangent directions are rational, so the
reduction is split. Its Tate parameter `q in Q_p` has

```text
v_p(q)=72.                                        (6.4)
```

The field of full `n`-torsion of a split Tate curve over `Q_p`, for
`p` prime to `n`, is `Q_p(mu_n,q^(1/n))`. One sees this directly
from `C(Qpbar)=Qpbar^*/q^Z`: torsion is represented by
`zeta*q^(k/n)`. Galois fixes all such torsion classes precisely when
it fixes the indicated roots and roots of unity. Here the coprimality
of 30 and 7 gives

```text
E=Q_p(i,mu_210,q^(1/210)).
```

The factor `i` is already in `Q_109`, although this fact is not needed
for ramification. All roots of unity of order prime to 109 and all
210-th roots of units lie in a finite unramified extension: over the
maximal unramified extension their residue equations have roots, and
Hensel's lemma applies because 210 is a unit. Thus the ramification
comes from the valuation of `q^(1/210)`, namely `72/210=12/35`.
After an unramified extension it generates the same ramified field as
`p^(1/35)`, since `gcd(12,35)=1`. Consequently

```text
e(E/Q_p)=35,
v_p(Different(E/Q_p))=(35-1)/35=34/35.             (6.5)
```

The latter identity is the tame different formula. It also follows by
differentiating `X^35-p` after the unramified base change; the different
exponent is 34, and unramified base change does not alter it.

Let `a_0 in E` be a chosen 14-th root of `q`. Each marked source
copy can use the corresponding root; a different choice differs by a
root of unity and has the same valuation. Thus

```text
v_p(a_0)=72/14=36/7,
tau=lambda(a_0),       u=lambda(1),
v_p(tau)=36/7,         v_p(u)=0.
```

For the recipe with one theta entry and two background entries,
`t=u tensor u tensor tau`. Section 4 proves its membership in the
native tensor-image set of this implementation under a coherent
marking collation, and hence
`tB subset H_native`. As `E/Q_p` is Galois, section 3 decomposes
the tensor into copies of `E`; all its automorphisms preserve `v_p`.
Every component of `t` therefore has valuation `36/7=180/35`.

For the Step (v) computation, `j=2`, `m=3`, and (6.4) give

```text
lambda_theta=4*(72/14)=144/7,
d_I=3*(34/35)=102/35,
a_I=3/35,
b_I=-3/35.
```

To check the last two quantities directly, `35<=109-2`, so
`ceil(35/107)=1`, while `1<109*35/108<109`, giving floor zero
in the definition of `b_i`. Hence `d_I+a_I=3` and

```text
floor(lambda_theta-d_I-a_I)-b_I
 = floor(144/7-3)+3/35
 = 17+3/35
 = 598/35.
```

This is strictly larger than `180/35`; membership in (6.2) requires
every component to have at least the former valuation. The nonzero
components of `t` fail that requirement, proving (6.3). QED.

There is no hidden `A` versus `B` normalization in this set-theoretic
failure. It is computed in one algebra and one maximal order, before
taking volume. With `B`-normalized volume, its numerical witness is

```text
V_B(tB)=-(180/35)*log(109).
```

The second bound of IUT IV Proposition 1.4(iii), with `I*=empty`
because `35<=107`, is

```text
(-lambda_theta+d_I+1)*log(109)=-(583/35)*log(109),
```

which is also strictly smaller than `V_B(tB)`. Its application to
`H_native` would therefore be false. The correct application is to
the powered-pilot source for which the container was proved.

### 6.3 Integral hull and the initial-data arithmetic checks

For this example the relevant local hull does not fail merely because
the printed source asks for integral ideal generators. Since the
extension is tame and `e=35<=p-2`, logarithm gives

```text
log(O_E^*)=m_E,
I=(1/p)*log(O_E^*)=pi_E^(1-e) O_E,
min v_p(I)=-34/35.
```

The theta coefficient satisfies `tau in p^6 I`, since
`36/7 >= 6-34/35`. Integral topological collation maps preserve
the sublattice `p^6 I`. Each background coefficient remains in `I`.
Their convex closure therefore remains in the corresponding product
of these lattices. For `m<=4`, every component of its tensor image
has valuation at least

```text
6-m*(34/35) >= 74/35 > 0.
```

Here the same marked curve and root valuations are retained throughout
the native family. Thus its local tensor-image sets are bounded and
integral, and the `B`-hulls exist with the integral convention in
III 9.10.7. This check does not assume arbitrary independent actions
on repeated labels; restricting the allowed action only preserves the
stated lattice containment.

The elementary Galois/level requirements of III 3.3 can also be checked
for this example; the local example is not based on an impossible field
degree. The curve has rational full 2-torsion and

```text
[L:Q] divides 2*|GL_2(F_3)|*|GL_2(F_5)|=46080.
```

It follows that `L/Q` is Galois, has no real embeddings, contains
`C[6]`, and has degree prime to 7. To check the mod-7 image, at the
good prime 17 the equation reduces to `y^2=x(x-1)(x+3)`. There are
three zero right-hand sides, at `x=0,1,14`, and six nonzero square
right-hand sides, at `x=3,4,6,8,12,16`. Hence

```text
#C(F_17)=1+3+2*6=16,
trace(Frob_17)=2,
disc(T^2-2T+17) mod 7 = 6.
```

The squares modulo 7 are `0,1,2,4`; this characteristic polynomial
is irreducible. Thus the mod-7 image over `Q` acts irreducibly.
At the split multiplicative prime 109, (6.4) is not divisible by 7,
so the Tate inertia representation contains a nonidentity unipotent
of order 7.

For clarity, an irreducible subgroup `G` of `GL_2(F_7)` containing
a transvection contains `SL_2(F_7)`: choose a conjugate of that
transvection with a different fixed line, possible by irreducibility.
In a basis of their two fixed lines, the transvections are an upper
and a lower elementary unipotent with nonzero coefficients. Their
integer powers give every coefficient in `F_7`; upper and lower
elementary matrices generate `SL_2(F_7)` by row elimination.

Finally the image of `G_L` is normal in the image of `G_Q`, with
index prime to 7. It contains an order-7 unipotent, and therefore all
of its `G_Q`-conjugates; the same generation argument shows that it
contains `SL_2(F_7)`. This checks III 3.3(11)–(13), not only the
existence of the local Tate root.

These checks are not a claim that every further hypothesis or auxiliary
choice in IUT's full initial theta data, the strict-Belyi formalism, or
IV 5.7.1's compact domain or exceptional set has been discharged.
In fact, this example **does not satisfy the prime window** in IV 5.7.1:
the normalized Tate quantity `Q=Tate(C/L)` has the nonnegative
109-component `72*log(109)>49`, by the preceding base-change
calculation, whereas that theorem requires `sqrt(Q)<=ell=7`.
Thus it is not an instance of the window-based construction invoked
in IV 6.10.1, and is not presented as a counterexample to that theorem.
Nor is a violation of the final coarse inequality of
IV 6.10.9 asserted. Proposition 6.1 already has the narrower precise
scope needed here: the direct local identification that would transfer
the indicated sharp container to the unpowered recipe is false.

### 6.4 What “same hull” now means

It would be misleading to base the dictionary objection only on the
absence of the word `hull` in IV 6.10.9. III, PDF p. 121, already
explains its volume notation as the volume of a smallest suitable
containing compact region. IUT IV Step (iv) itself explicitly uses a
holomorphic hull. The unresolved identification is of the **input
families, allowed arrows, and numerical normalization** of these
containing regions, not a typographical difference in `Vol(Theta)`.

The explicit dictionary test shows why this distinction matters. The
native single-root input gives the favorable local lower bound and
the full target-reset equality proved here. The imported Step (v)
container has a squared-exponent input. These three statements cannot
be combined by treating the two input families as the same set. A
different faithful comparison remains possible in principle and must
be proved on its stated source objects.

## 7. General mixed places: the original upper source supplies the weights

This paragraph records the general construction, without making it a
barrier to the rational branch. Let `F=L_mod`, `n=[F:Q]`, select
one `w(v)` over each `v|p`, and put

```text
h_v=[F_v:Q_p],   d_v=[E_w:Q_p],   r_v=[E_w:F_v],
gamma_v=1/r_v=h_v/d_v,            sum_{v|p} h_v=n.
```

For a word `f:{1,...,m}-> {v|p}`, the tensor algebra contains

```text
T_f=tensor_i E_{w(f(i))},    D_f=product_i d_{f(i)},
rho_f=(product_i h_{f(i)})/n^m.
```

Let `B_f` be its maximal order, and let `mu_{B_f}(B_f)=1`.
For a product of local ideal hulls `H=product_f H_f`, define

```text
V_B,p,m(H)=sum_f rho_f * log(mu_{B_f}(H_f))/D_f.    (7.1)
```

These `rho_f` are precisely the normalized word weights displayed in
IUT IV, Remark 1.7.1, PDF p. 17. That remark explicitly replaces the
raw weights `1/[E_w:F_v]` by `[F_v:Q_p]` when switching to
degree-normalized local log-volumes, and then normalizes their products
over words. Thus this construction is not an arbitrary choice of a
joint distribution added without a source.

**Proposition 7.1.** For a pure tensor whose `i,v` coordinate is the
nonzero element `tau_{i,v}`, the `B`-hull has

```text
V_B,p,m(tB)
 = (1/n)*sum_i sum_{v|p} gamma_v*log(|tau_{i,v}|_{E_w}). (7.2)
```

The analogous `A_f`-normalized expression differs by exactly

```text
sum_f (rho_f/D_f)*log[B_f:A_f],                    (7.3)
```

with every index computable by (3.3).

**Proof.** The weights sum to one by expanding
`(sum_v h_v)^m=n^m`. Their marginal at a fixed slot is
`sum_{f:f(i)=v}rho_f=h_v/n`. Proposition 3.1 gives the contribution
of a word as `sum_i log(|tau_{i,f(i)}|)/d_{f(i)}`. Sum over
words and use the marginals; `h_v/d_v=gamma_v`, giving (7.2).
Equation (3.1) in each word gives (7.3). QED.

Multiplying (7.1) by `n` recovers the convention without the final
base-field degree normalization. This last `n` must be coordinated
with the global normalized arithmetic degree; it is `1` in the
rational branch. Formula (7.1) is being used on product ideal hulls,
not asserted to be a product formula for an arbitrary non-product
measurable set. Field-marking tensor maps preserve `h_v,d_v`, the
orders, the indices, and these weights, so Theorem 4.1 also preserves
this functional under a full fixed-source target reset.

For comparison, an *unqualified* demand that an individual mixed word
satisfy the raw factor prescription with arbitrary `gamma_i` is false.
Moving `p` from one factor to another represents the same tensor
lattice and forces `d_i*gamma_i` to be constant. For example, with
`E_1=Q_5`, `E_2` an unramified quadratic extension, and
`gamma_1=gamma_2=1`, it would assign `5^{-1}` and `5^{-2}` to
the same lattice `p*(O_{E_1} tensor O_{E_2})`. This small
counterexample only rejects that unrestricted prescription. The
degree-normalized, word-weighted construction (7.1) is well-defined
and is the source-supported positive replacement.

## 8. Formalization and remaining boundary

All mathematical arguments in this note were written before any new
formalization of them. The previous checked module
`IUTThreeClosures/IUTReachabilityContinuation20260830.lean` proves
the tensor-unit and module-containment core, including why a unit
point supplies a full lattice in a coefficient-ring hull. It does not
thereby formalize the local class field theory, ramification, Haar
determinants, or the initial-data checks used here.

The new companion
`Lean/IUTThreeClosures/IUTTargetReset20260830.lean` formalizes the
fixed-source linear-algebra core with a dependent source-label map;
repeated labels necessarily share one chosen isomorphism. Its three
declarations are `image_coherentCollation`,
`map_span_coherentCollation`, and `coherentCollation_reindex`.
The direct command `lake env lean IUTThreeClosures/IUTTargetReset20260830.lean`
completed with exit code 0 and no warnings. An independent scratch
file containing the same module followed by `#print axioms` for all
three declarations also completed with exit code 0. The first and
third use only `[propext, Quot.sound]`; the span theorem uses
`[propext, Classical.choice, Quot.sound]`. No `sorryAx`, custom
axiom, IUT premise, or ABC premise occurs. This is not a formalization
of the entirety of IV's source family or of the numerical examples.

The new positive work consists of the singleton selected-place
construction for the rational branch, the complete `A/B` conversion,
the source-supported mixed-word weights, and covariance of the full
all-isomorphism output under a fixed-source target change. The
counterexample isolates the direct unpowered/powered dictionary; it
does not justify abandoning the IUT route. A continuing route must
construct and compare the intended powered possible-image family,
prove the required native q-pilot lower bound for that same family,
and verify the same normalization in the upper estimate. Global and
archimedean aggregation, all uniform quantifiers, and an unconditional
Lean term for `ABCConjecture` remain unproved.
