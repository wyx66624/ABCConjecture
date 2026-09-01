# A native marked point and its holomorphic hull in Joshi's tensor packet

**Author:** ChatGPT  
**Research date:** 2026-08-30  
**Status:** new proved local source interfaces; no proof or disproof of ABC.

This continuation corrects an unnecessarily strong requirement in the preceding
session: independent linear actions are one way to fill an ordinary module
span, but are **not necessary** for the holomorphic hull actually described in
Part III, section 9.10.7. That hull is a module over the full product of local
integer rings in the semisimple tensor algebra. One invertible tensor point
already generates a full lattice inside it. The required point can be obtained
from a coherent, marking-preserving collation; independently chosen actions on
repeated factors are not needed for this construction.

The principal advance below is a containment statement about the source's
actual type of hull, after putting all coefficients in its fixed target. It
does not identify ordinary convex closure with holomorphic hull, does not put
the whole tensor lattice inside the raw tensor-image set, and does not identify
two hulls before and after Frobenius shifting.

## 1. Primary sources and exact positions

The archived originals from the preceding session were reread:

- [Part III, arXiv:2401.13508v4](https://arxiv.org/pdf/2401.13508v4), arXiv date 2025-02-24, title-page date 2025-02-25: pp. 100–105, sections 9.4.1–9.4.9; pp. 109–112, sections 9.6.2–9.7.5; pp. 113–117, Theorem-Definition 9.8.1.1 and its aftermath; pp. 123–127, sections 9.10.2–9.11.
- [Part IV, arXiv:2403.10430v2](https://arxiv.org/pdf/2403.10430v2): pp. 66–67, Theorem 6.10.1 and the comparison of the two hull volumes; p. 69, Proposition 6.10.9. Those later comparisons are not proved here.
- The reference actually invoked by III, Proposition 9.7.5.1, was followed: [Part II½, arXiv:2305.10398v12](https://arxiv.org/pdf/2305.10398v12), arXiv date 2025-02-24. Its pp. 46–47, Proposition 7.2.2 and Definition 7.2.4, specify the Kummer description and product cohomology; pp. 48–49, Propositions 7.4.1 and 7.5.1, supply the factorwise topological-isomorphism collation. The corresponding [official HTML](https://arxiv.org/html/2305.10398v12#S7) was also checked.

The newly downloaded Part II½ PDF is cached at
`tmp/iut_reachability_continuation_2026_08_30/Joshi_IIhalf_2305.10398v12.pdf`.
It has 75 physical pages, 978,340 bytes, and SHA-256
`6fd09e29096eeafc52589f6ef3f06dee2f944614c116ef9892316c2b4e3c74c0`.
The arXiv abstract's page-count comment is not used in place of inspecting the
PDF. No archived original was modified.

## 2. Objects, arrows, and quantifiers of the construction

Fix one rational prime `p`. Let `W` be the finite set of selected places over
`p` in III, section 9.4.1. This is the selected set denoted there by underlined
`V_p`, not necessarily all places of `L'` above `p`. Put

```text
E_w = L'_w,       R_p = product_{w in W} E_w,
O_p = product_{w in W} O_{E_w}.
```

For each arithmetic label `y`, there is a marked copy of these local fields
and a local cohomology factor `C_{y,w}`. The product over `w` is part of the
cohomology object of the arithmeticoid. A source collation maps these local
cohomology factors into the factors of a chosen standard arithmeticoid. A
topological group isomorphism alone is not a field isomorphism or a stated
isometry for a chosen numerical absolute value.

For a finite factor index set `A`, III, equations (9.4.6.2) and (9.4.6.4), give
the two different targets

```text
P_A = product_{a in A} R_p,
T_A = tensor_{a in A, Q_p} R_p.
```

In the Mochizuki-style packet, `A` is one of the procession index sets. In the
simplified Joshi packet the factors are indexed by the theta labels. The
source's tensor target is therefore not merely the tensor product at one
fixed place. It contains the mixed-place summands

```text
T_A = product_{f : A -> W} tensor_{a in A, Q_p} E_{f(a)},
```

and each summand further decomposes as a finite product of local fields.

The construction relevant to this note is the following sequence of set maps:

```text
marked Kummer classes
   -- coherent factorwise cohomology isomorphisms --> collated classes
   -- the normalized logarithmic coefficient --> Psi_A subset P_A
   -- an extensive convex-closure operation --> C_A subset P_A
   -- (x_a)_a |-> tensor_a x_a --> S_A subset T_A
   -- the holomorphic hull in the fixed algebra T_A --> H_A.
```

The last-but-one arrow is a well-defined multilinear construction on tuples;
it need not, and here does not, serve as an additive homomorphism from the
cartesian product. Only membership in its set-theoretic image is used.

Here are the individual source permissions and their limits:

| Source clause | What is used here | What is not inferred |
| --- | --- | --- |
| III, Proposition 9.7.5.1 | Images under the specified topological isomorphisms; a coherent marking-preserving family is constructed below. | A product of independent arbitrary general linear actions on repeated tuple slots. |
| III, Theorem-Definition 9.8.1.1(2)–(3) | The stated Galois and Frobenius operations may add points. | Independent Galois or Frobenius choices in each slot. |
| (4)–(5) | The convex closure contains the original collated points. | Equality with a holomorphic hull, or a product of coordinatewise hulls. |
| (6) | The tensor image contains the pure tensor of each retained tuple. | That the tensor image is a module. |
| III, section 9.10.7 | After the finite-etale decomposition, the hull is a product of principal local ideals. | That the raw tensor-image set already contains those ideals. |

Proposition 9.7.5.1 is phrased for several classes in one cohomology object;
Theorem-Definition 9.8.1.1 uses tuples of arithmetic labels. A typed expansion
therefore keeps a map `C_y -> C_0` for every label that occurs, and uses the
same map every time that label is repeated. The family below is coherent under
composition, so it works with this constraint. No unresolved question about
whether additional, independent maps were intended is needed for the point
constructed here. The procession index displays in 9.8.1.1(1)(e) should still
be reconciled with the factor sets fixed in section 9.4.6 before claiming a
complete formalization of all packet indices.

Likewise, the subscripts `L_mod`, `L`, and `L'` in the cohomology displays of
9.8.1.1 must be aligned with the restriction/corestriction arrows of
9.4.2.4. The explicit local transport below is at the `L'_w` factors of the
codomain fixed in 9.4.6. It does not by itself finish that global typing task.

## 3. A coherent native Kummer collation

Let `E/Q_p` be a fixed finite extension. Suppose `E_y` is the copy of `E`
inside an untilt attached to label `y`, with the given field marking
`i_y:E -> E_y`. Define the multiplicative pro-p completion

```text
K(E) = inverse_limit_n E^* / (E^*)^(p^n).
```

Kummer theory identifies the corresponding integral first cohomology group
with `K(E)`. This is exactly the nonarchimedean identification used in Part
II½, Proposition 7.2.2(2). The unit completion gives the relevant rational
finite/Bloch-Kato part for the Tate representation; it suffices below to work
on the image of the particular principal units that occur.

**Proposition 3.1 (marking-preserving transport).** There are topological
group isomorphisms

```text
F_{y -> z}: K(E_y) -> K(E_z)
```

such that, for every `u in E^*`,

```text
F_{y -> z}(kappa_y(i_y(u))) = kappa_z(i_z(u)),
F_{z -> r} o F_{y -> z} = F_{y -> r},
F_{y -> y} = identity.
```

These isomorphisms preserve the unit-completion subgroups. They may be
assembled place by place in the product cohomology used by the source.

**Proof.** The field isomorphism `i_z o i_y^(-1)` induces, for every `n`, an
isomorphism of the quotient multiplicative groups by `p^n`th powers. These
maps commute with the transition maps. Their inverse limit is `F_{y -> z}`;
the inverse-limit topology makes it a topological isomorphism, with inverse
`F_{z -> y}`. The coset system defined by `i_y(u)` maps to the coset system
defined by `i_z(u)` at every level, proving the displayed formula. Composition
and the identity assertion also hold at every finite level. A field marking
preserves the valuation-ring unit group, so its completion is preserved.
Taking products gives a topological isomorphism on the source's product
cohomology. QED.

Equivalently, one may choose an `E`-isomorphism between the two algebraic
closures and transport the Kummer cocycle `g(r_n)/r_n`. It becomes
`g(F(r_n))/F(r_n)`, the Kummer cocycle for the same marked element `u`.
This supplies the isomorphism through the Galois-group construction as well.
It does not require a topological isomorphism between the complete untilts.

This is one allowed family under the literal factorwise topological-group
collation of the cited propositions. It is not an assertion that every
cohomology automorphism preserves the marked arithmetic element or its norm.
If a narrower family is required for comparison with anabelian IUT outputs,
membership in that narrower family is an additional comparison theorem.

Now set `b=p` if `p` is odd and `b=4` if `p=2`. For `a in O_E`, define

```text
lambda_b(a) = log_E(1+b*a) / b.
```

This is the normalized coefficient explicitly used in III, equation
(9.7.2.2), when `a` is the chosen root of a Tate parameter. The denominator
is part of this stated coefficient; it must not be dropped or silently
identified with an unscaled convention for the Bloch-Kato logarithm.

**Lemma 3.2 (native normalized coefficient).** If `a != 0`, then
`lambda_b(a) != 0`, `lambda_b(a) in O_E`, and

```text
|lambda_b(a)|_E = |a|_E
```

for the normalized local module absolute value
`|x|_E = |Norm_{E/Q_p}(x)|_p`. Marking-preserving transport commutes with this
coefficient on the corresponding principal-unit Kummer classes. In
particular, `lambda_b(1)` is a unit.

**Proof.** Extend the additive p-adic valuation so that `v(p)=1`. Put `x=ba`.
In the logarithm series, every term after the first has strictly larger
valuation than `x`: for `n>=2`,

```text
v(x^n/n)-v(x) = (n-1)*v(x)-v_p(n) > 0.
```

For odd `p`, use `v(x)>=1` and `v_p(n)<n-1`; for `p=2`, use `v(x)>=2` and
`v_2(n)<=n-1`. The terms tend to zero, so the ultrametric inequality gives
`v(log(1+x))=v(x)`. Dividing by `b` gives the valuation of `a`, proving the
three assertions. A continuous field marking fixes the rational
coefficients of the convergent power series and its limit; Proposition 3.1
preserves its input principal unit. Hence the normalized coefficient is
transported to the same element of the fixed marked field. QED.

III, section 9.6.2, permits a choice of `a=q^(1/(2*ell))` in the specified
finite extension. Choosing the images of this single root through the field
markings gives a coherent local subconstruction. After transport to the
standard target, every theta coefficient from this choice is the same
`lambda_b(a)`. Background entries coming from `1+b` become
`lambda_b(1)`. These statements use the native normalized absolute value in
the fixed target field, not the different numerical valuations that may
have been attached to the untilts before transport.

This does not assume preservation of the entire arithmetic holomorphic
structure: it explicitly chooses one cohomological identification preserving
the fixed field marking. It also does not prove an equality between the full
sets obtained using all collations at two Frobenius-shifted labels.

## 4. The actual holomorphic hull fills the required lattice

Let `E_1,...,E_m` be finite extensions of `Q_p`, with `m>=1`, and let

```text
T = E_1 tensor_{Q_p} ... tensor_{Q_p} E_m = product_alpha F_alpha,
B = product_alpha O_{F_alpha},
A = image(O_{E_1} tensor_{Z_p} ... tensor_{Z_p} O_{E_m}) subset T.
```

The field decomposition exists because these characteristic-zero extensions
are separable. Every pure product of integral elements is integral over
`Z_p`; hence `A subset B`. Both are full `Z_p`-lattices of rank
`D=product_i [E_i:Q_p]`. To see the assertion for `A`, choose integral bases
and tensor them: they give a `Z_p`-basis whose scalar extension is a
`Q_p`-basis of `T`. Thus `A -> T` is injective and `B/A` is finite. Write
`I=[B:A]` for its positive integer cardinality.

By III, section 9.10.7, the image of a holomorphic hull in the displayed
decomposition has the form

```text
H = product_alpha lambda_alpha O_{F_alpha}.
```

In particular, it is a `B`-submodule of the same algebra `T`. This conclusion
uses the entire product ring `B`, not only `Z_p` and not only a diagonal
scalar ring.

**Theorem 4.1 (one point suffices after the source hull).** Let
`tau_i in E_i^*`, put `t=tensor_i tau_i`, and let `S subset T` contain `t`.
Every `B`-submodule `H subset T` containing `S` satisfies

```text
t*B subset H,
image(tau_1*O_{E_1} tensor_{Z_p} ... tensor_{Z_p} tau_m*O_{E_m})
    = t*A subset t*B subset H.
```

Moreover, `t` is a unit in `T`, and `t*A` and `t*B` are full lattices. The
smallest such module for the singleton `S={t}` is exactly `t*B`.

**Proof.** The element `tensor_i tau_i^(-1)` is the inverse of `t`, by the
multiplication rule for tensor products of algebras. Since `t in H` and `H`
is a `B`-module, `b*t in H` for every `b in B`. This proves `t*B subset H`.
The inclusion `A subset B` gives the next containment. Expanding in integral
bases, or just using the tensor multiplication rule on generators, identifies
`t*A` with the displayed tensor lattice: every generator
`tensor_i(tau_i*u_i)` equals `t*(tensor_i u_i)`, and these generators span
both sides. Multiplication by the unit `t` is a `Q_p`-linear automorphism,
so it carries both full lattices to full lattices. Finally, `t*B` is itself a
`B`-module containing `t`, so the minimal module for the singleton is
exactly `t*B`. QED.

**Important distinction.** If `S` contains more points, equality
`hull(S)=t*B` need not hold; only the containment is asserted. The theorem
does not assert `t*A subset S` or `t*A subset ConvexClosure(S)`.

**Existence and integrality boundary.** As printed, section 9.10.7 requires
the nonzero generators `lambda_alpha` to lie in `O_{F_alpha}`. Such a hull
can only contain integral `S`. This note does not infer that all images
under all topological cohomology isomorphisms are integral in `B`. Theorem
4.1 applies to every source hull that exists with the stated form. If one
instead allows fractional generators, a bounded set containing a unit of
`T` has a unique smallest such hull: in each component take the smallest
valuation attained by a nonzero element of that projection of `S`. Boundedness
gives an integer lower bound, discreteness gives a minimum, and the unit
ensures each projection is nonzero. This proves existence for the fractional
version; it is a stated extension, not a silent alteration of the original.

**Corollary 4.2 (the entire finite tensor packet).** The preceding point-to-
lattice construction also applies to `T_A=tensor_{a in A,Q_p} R_p` from
section 2. If a collated tuple has every local coordinate nonzero, then its
tensor image is a unit of this full finite-etale algebra. Its holomorphic
hull contains its multiple of the full integral tensor lattice, including
the mixed-place summands.

**Proof.** An element of `R_p=product_w E_w` is a unit exactly when each
coordinate is nonzero. The tensor of the inverses is again the inverse of
the tensor point. The tensor integral lattice embeds in the product of the
integer rings of all field summands, by the same integrality argument used
above. Apply the `B`-module argument of Theorem 4.1 in this algebra. QED.

The marked coefficients of section 3 meet the nonzero condition at bad
places, and their background coefficients are units. Convex closure retains
the tuple, and the tensor-image arrow retains its tensor. Consequently the
source's hull, whenever defined on that output set, contains the required
full lattice. This completes the local inclusion needed for a lower bound
**after taking that hull**. It avoids the unsupported stronger step at III,
p. 127, of placing a whole tensor lattice inside the raw theta image merely
because that image contains a class.

**Counterexample 4.3 (the hull cannot be replaced by ordinary convex
closure).** Take `p=3`, `E=Q_3(pi)` with `pi^2=3`, and

```text
T=E tensor_{Q_3} E,
f:T -> E x E,       f(a tensor b)=(a*b, sigma(a)*b),
sigma(pi)=-pi.
```

Then `f` is an algebra isomorphism, and `B=O_E x O_E` is its maximal integer
ring. The holomorphic hull of the singleton `{1 tensor 1}` is `B`, whereas
its ordinary `Z_3` convex closure is contained in
`Z_3*(1,1)`, a proper subset of `B`. If convexity is defined in the
absolutely convex sense, that closure is exactly `Z_3*(1,1)`; the strict
inequality does not require choosing between conventions because this
module is convex under either convention used for linear topological spaces.

There is a second example using a full tensor lattice. Put
`A=O_E tensor_{Z_3} O_E`. Then

```text
f(A) = {(x,y) in O_E x O_E : x-y in pi*O_E},
[B:f(A)] = 3,
ConvexClosure(f(A)) = f(A),
holomorphicHull(f(A)) = B.
```

**Proof.** A square root of `3` cannot belong to `Q_3`, by the parity of its
valuation, so `E/Q_3` is quadratic. For `a,b in Q_3`, the valuations of `a`
and `b*pi` have different fractional parts when both are nonzero. Thus
`a+b*pi` is integral exactly when `a,b in Z_3`, proving
`O_E=Z_3+Z_3*pi`. Over the second copy of `E`, the images of
`1 tensor 1` and `pi tensor 1` are `(1,1)` and `(pi,-pi)`. Their determinant
is `-2*pi != 0`, proving that `f` is an isomorphism.

Every `B`-module containing `(1,1)` contains `B`, and `B` itself is an
allowed hull. This proves the singleton hull assertion. The module
`Z_3*(1,1)` is compact, convex, and contains `(1,1)`, but does not contain
`(1,0)`, proving strictness for the convex closure.

The four integral basis images of `A` are

```text
(1,1), (pi,-pi), (pi,pi), (3,-3).
```

Their coordinate differences are divisible by `pi`. Conversely, write
`x=a+b*pi`, `y=c+d*pi` with `a,b,c,d in Z_3`. The congruence says that
`a-c` is divisible by `3`. The coefficients

```text
(a+c)/2,   (b-d)/2,   (b+d)/2,   (a-c)/6
```

are all in `Z_3` and express `(x,y)` in the displayed basis images.
This proves the formula for `f(A)`. The map
`(x,y) |-> (x-y) mod pi` is onto `O_E/pi=F_3` and has this kernel, so the
index is three. The lattice is already a compact `Z_3`-module and hence
already convex; its ordinary convex closure is itself. Its holomorphic hull
is `B` because it contains `(1,1)`. QED.

This is a counterexample to the general assertion at III, Proposition
9.10.8.1(1), that the displayed holomorphic hull is the minimal ordinary
convex set containing the input. The tensor-lattice example also rules out
using a blanket equality of the two closures on such tensor regions. It is
not a disproof of IUT or ABC. The positive construction in Theorem 4.1 is
valid precisely on the holomorphic-hull side of this distinction.

The source sets must therefore be kept separate when comparing lower and
upper bounds. III, Theorem-Definition 9.8.1.1(4)–(6), defines a convex
closure in a product and then its tensor image. III, the prose beginning at
section 9.10 on pp. 121–122, introduces volume through a further containing
compact region; section 9.10.7 specifies the holomorphic hull. IV, Theorem
6.10.1, explicitly writes the hulls in its inequalities and in the middle
equality. In contrast, IV, Proposition 6.10.9, writes the theta-set symbol
without a hull and refers to IUT IV for the estimate; equation (6.11.1)
returns to hull notation. This note supplies its lower bound for the
explicit holomorphic hull. It does not transfer an upper bound from an
ordinary convex set to this larger hull, and does not assume that the
notation change alone proves that the same region is estimated.

## 5. Volume and the allowed normalization

Write `d_i=[E_i:Q_p]` and `D=product_i d_i`. Normalize additive Haar measure
`mu` on `T` by `mu(A)=1`; this is not the same as normalizing `mu(B)=1`
when `I=[B:A]>1`.

**Proposition 5.1 (exact singleton-hull measure).** In the notation of
Theorem 4.1,

```text
mu(t*B) = I * product_i |tau_i|_{E_i}^{D/d_i}.
```

Every measurable `H` containing `t*B` has measure at least this quantity.

**Proof.** The `I` cosets of `A` partition `B` and all have measure one, so
`mu(B)=I`. The determinant of multiplication by `tau_i` on `E_i` is
`Norm_{E_i/Q_p}(tau_i)`. On `T`, multiplication in this tensor factor
repeats that determinant `D/d_i` times. The full multiplication map is the
composition of these factor maps, hence its p-adic determinant modulus is
`product_i |tau_i|_{E_i}^{D/d_i}`. Haar measure transforms by this modulus.
This gives the equality; containment gives the inequality. QED.

For `c>0`, the positive volume functional

```text
nu_c(U) = mu(U)^(c/D)
```

is monotone, though it is not in general an additive measure. It satisfies

```text
nu_c(H) >= I^(c/D) * product_i |tau_i|_{E_i}^{c/d_i}
          >= product_i |tau_i|_{E_i}^{c/d_i}.
```

Thus the factor weights `gamma_i=c/d_i` have a well-defined interpretation.
The index of the maximal order supplies a favorable factor, not an omitted
loss.

**Proposition 5.2 (balancing is necessary).** Suppose a function on tensor
lattices is prescribed by

```text
V(V_1 tensor_{Z_p} ... tensor_{Z_p} V_m)
    = product_i mu_i(V_i)^gamma_i,
mu_i(O_{E_i})=1,
```

and this value is independent of a presentation of the same tensor lattice.
Then `d_i*gamma_i` must be the same number for every `i`.

**Proof.** Multiplication by `p` may be placed in any factor without changing
the tensor lattice `p*A`. Placing it in factor `i` gives the proposed value
`p^(-d_i*gamma_i)`. These positive real numbers must agree for every `i`.
Since `p>1`, equality of these powers is equivalent to equality of the
exponents. QED.

When `d_i*gamma_i=c>0`, the formula is indeed realized by `nu_c` for all
full tensor lattices: apply the determinant computation to the integral
basis-change matrices of each lattice. This proves sufficiency for this
class as well as the stated necessity. Arbitrary weights in an unqualified
version of III, equation (9.10.3.1), cannot simply be presumed well-defined.

## 6. A native one-place bound, and what it does not imply

For a fixed selected place `w`, all the marked factors have underlying field
`E=L'_w`. Let `F=L_mod,v`, `e=[E:F]`, `d=[E:Q_p]`, and
`gamma=1/e`. These are the weights specified at III, equation (9.10.5.1),
on this one-place part. They satisfy

```text
d*gamma = [F:Q_p] = c.
```

For `m` copies of this field, choose the standard tensor-lattice normalization
and take `nu_c=mu^(c/d^m)`. If a tuple has `r` theta entries equal to
`tau=lambda_b(a)` and its other entries equal to `u=lambda_b(1)`, then
Theorem 4.1 and Proposition 5.1 give

```text
nu_c(hull(S)) >= |tau|_E^(r*gamma) * |u|_E^((m-r)*gamma)
              = |a|_E^(r*gamma).
```

For `0<|a|_E<1`, `gamma<=1`, so this is at least `|a|_E^r`.
This is a proved one-sided native lower bound, with both the point and its
normalization specified. It applies to the fixed-place projection of the
marked tuple: the simplified tuple has theta entries throughout, while the
displayed procession blocks also have background unit entries.

Agreement with the factor prescription on tensor lattices is not, by itself,
proof that an unspecified weighted-volume extension on every holomorphic
hull equals `nu_c`. This note explicitly selects `nu_c` and proves its
properties. Its equality with every intended source volume on the larger
maximal-order hulls must be checked as part of the numerical interface.

It would be invalid to multiply bounds for fixed-place projections and call
the result a bound for the whole packet without specifying its volume
functional. The actual `T_A` contains mixed-place summands. III, section
9.10.5, supplies place-indexed weights, while section 9.10.3 writes a tensor-
factor prescription. A full source application must type these two index
sets, specify the weights on all resulting field summands, and verify that
the prescriptions agree. Corollary 4.2 settles containment on the entire
packet, but does not settle this remaining assignment of numerical weights.

There is also no assertion here that a general topological collation preserves
the native coefficient's valuation. The explicitly chosen marking-preserving
family does. Nor is the different absolute value attached to an untilt used
as a substitute for the Haar module absolute value in Proposition 5.1.

## 7. Consequence for the continuing route

The following former obstacle is now resolved at the stated local interface:

```text
one genuine collated tensor point, with every local coordinate nonzero
    -> a unit in the actual finite-etale tensor target
    -> a full lattice inside the source's holomorphic hull.
```

It is therefore too strong to require independent general linear generation
as a prerequisite for this hull inclusion. The earlier simultaneous-action
counterexample concerns an ordinary module span; it is not an obstruction to
the present holomorphic-hull construction.

The route remains open. The outstanding steps are concrete:

1. Finish the global indexing and volume prescription on the mixed-place
   field summands, using the source's restriction/corestriction degrees.
2. Prove existence of the hull for the entire allowed output set with its
   actual integrality or fractional-ideal convention; a boundedness claim
   alone does not justify the printed integral-generator restriction.
3. Identify the full hull and its numerical normalization across the
   Frobenius shift used in IV, Theorem 6.10.1. A preserved marked point is
   not equality of the two full output hulls.
4. Establish the IUT IV upper estimate for this very same hull, and obtain
   the uniform global quantifiers needed for ABC.

No missing step is called a counterexample, and none is installed as a Lean
axiom. In particular, this note proves neither Theorem 6.10.1 of Part IV nor
an unconditional instance of the repository's `ABCConjecture`.

## 8. Formalization boundary

The mathematical proofs were written before the new Lean module. The parent
agent independently reviewed the pure-tensor inverse and module-containment
argument before implementation. The checked companion is
`Lean/IUTThreeClosures/IUTReachabilityContinuation20260830.lean`.

The formal scope is the algebraic tensor-unit and module-containment
core of Theorem 4.1. Local class field/Kummer comparison, the full source
packet, Haar determinants, logarithm convergence, and the remaining global
comparisons are not thereby claimed to be formalized.

The direct command `lake env lean IUTThreeClosures/IUTReachabilityContinuation20260830.lean`
completed with exit code 0 and no warnings. A separate scratch source with
the same file contents followed by `#print axioms` for all eleven theorem
declarations also completed with exit code 0. The declarations are:

- `mem_principalHull_iff`;
- `coefficient_multiple_mem`;
- `principalHull_le`;
- `coefficient_multiple_injective`;
- `isUnit_tmul`;
- `tmul_mul_inverse`;
- `linearIndependent_tmul_mul`;
- `scaledIntegralTensorSpan_eq_map`;
- `integral_tmul_mem`;
- `scaled_integral_tmul_mem`;
- `scaledIntegralTensorSpan_le_hull`.

Only the last-mentioned linear-independence result and the span-image
identity use `Classical.choice`; all eleven have dependencies contained in
`[propext, Classical.choice, Quot.sound]`. No `sorryAx`, custom axiom, IUT
conclusion, or ABC premise occurs. No aggregate imports, old reports,
repository verification records, or source originals were edited.
