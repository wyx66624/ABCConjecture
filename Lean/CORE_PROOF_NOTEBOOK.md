# Core proof notebook

Author: ChatGPT

This notebook is the mandatory mathematical stage before a result is admitted
to the Lean development.  A result marked `proved on paper` has a complete
argument below but is not yet counted as formalized.  A result marked
`kernel-checked` must additionally name a module imported by the default build.

## Route B: the odd theta-root graph cover

### B.0 — Counterexample to the root-pullback graph-cover identification

**Status:** proved on paper; this retires only the proposed identification.

Let `K` be a complete nonarchimedean field, let `q,r` be nonzero with
`r^ell=q`, where `ell>1`, and write

```text
E_r = K^x / <r>,       E_q = K^x / <q>.
```

The power map `v |-> v^ell` induces a homomorphism `E_r -> E_q`.  It is not the
graph-direction cyclic cover used for a type `(1,Z/ell Z)` datum.

**Proof.**  Write `w` for the additive radial valuation.  The skeleton of
`E_r` is `R / w(r)Z`, and that of `E_q` is `R / w(q)Z`.  The power map sends
`x=w(v)` to `ell*x=w(v^ell)`.  Since `w(q)=ell*w(r)`, its expression in
normalized skeleton coordinates is

```text
x / w(r) |-> ell*x / w(q) = x / w(r).
```

It therefore has skeleton degree one, not `ell`.  Algebraically, if the class
of `v` lies in the kernel, then `v^ell=q^n=r^(ell*n)` for some integer `n`, so
`v*r^(-n)` is an `ell`-th root of unity in `K`.  Conversely every such root of unity
gives a kernel element.  No nontrivial power of `r` is a root of unity because
`0<|r|<1`; hence the kernel is the angular group `mu_ell(K)`.  Thus this map is a
cyclotomic/Kummer isogeny with radial degree one.  The required graph cover has
radial degree `ell`, so the two cannot be identified.  ∎

The already kernel-checked root-pullback results remain valid as algebraic
isogeny ingredients; only their interpretation as the graph-cusp bridge is
discarded.

### B.1 — Iterated theta automorphy

**Status:** proved on paper.  The specialization to the repository's
`thetaProd` is kernel-checked in
`IUTThreeClosures/TateThetaOddGraphDescent.lean` as
`thetaProd_qpow_smul_nat` and `thetaProd_qpow_smul_odd`.  Lean uses the
recursive triangular exponent and proves the required odd closed form; the
more general abstract-function formulation above remains a paper lemma.

Let `K` be a field, let `q,u` be nonzero, and suppose a function `Theta` obeys

```text
Theta(q*u) = (q*u)^(-1) * Theta(u).
```

For every natural number `n`, put `tau(n)=1+...+n=n(n+1)/2`.  Then

```text
Theta(q^n*u) = (q^tau(n) * u^n)^(-1) * Theta(u).       (B.1)
```

**Proof.**  For `n=0`, both powers in the multiplier are one.  Suppose the
formula holds for `n`.  Apply the functional equation at `q^n*u`:

```text
Theta(q^(n+1)*u)
 = (q^(n+1)*u)^(-1) * Theta(q^n*u)
 = (q^(n+1)*u)^(-1) * (q^tau(n)*u^n)^(-1) * Theta(u)
 = (q^(tau(n)+n+1)*u^(n+1))^(-1) * Theta(u).
```

Since `tau(n+1)=tau(n)+n+1`, this is (B.1) for `n+1`.  ∎

Now let `ell=2*k+1` and `s=k+1=(ell+1)/2`.  The identity
`tau(ell)=ell*s` specializes (B.1) to

```text
Theta(q^ell*u)
 = (q^(ell*s)*u^ell)^(-1) * Theta(u)
 = ((q^s*u)^(-1))^ell * Theta(u).                     (B.2)
```

For the repository's `thetaProd`, the hypothesis is exactly
`TateParameter.thetaProd_q_smul`.

### B.2 — Explicit descent of the odd theta-root locus

**Status:** kernel-checked in
`IUTThreeClosures/TateThetaOddGraphDescent.lean` as
`TateThetaRootPoint.oddPeriodShiftEquiv`, with explicit forward and inverse
maps and no quotient/interface assumptions.

Under the hypotheses of B.1, define

```text
Y_ell = {(u,y) in K^x x K | y^ell = Theta(u)}.
```

For `ell=2*k+1`, `s=k+1`, and `Q=q^ell`, define

```text
T(u,y) = (Q*u, (q^s*u)^(-1)*y),
S(U,Y) = (q^(-ell)*U, q^(-k)*U*Y).
```

Then `T` and `S` are mutually inverse self-maps of `Y_ell`.

**Proof.**  If `y^ell=Theta(u)`, equation (B.2) gives

```text
(((q^s*u)^(-1))*y)^ell
 = ((q^s*u)^(-1))^ell * Theta(u)
 = Theta(Q*u),
```

so `T` maps `Y_ell` to itself.  To see directly that `S` also maps the locus
to itself, apply (B.2) at `q^(-ell)*U`.  Since `s-ell=-k`, it gives

```text
Theta(U) = (q^k*U^(-1))^ell * Theta(q^(-ell)*U),
```

and therefore

```text
Theta(q^(-ell)*U) = (q^(-k)*U)^ell * Theta(U).
```

Thus the `ell`-th power of the proposed root coordinate of `S(U,Y)` is the
required theta value.  Finally, the base coordinates of the two composites
plainly cancel.  On root coordinates, using `ell=k+s`, the factors are

```text
T(S(U,Y)): (q^k*U^(-1)) * (q^(-k)*U) = 1,
S(T(u,y)): q^(-k)*(q^ell*u)*(q^s*u)^(-1)
           = q^(ell-k-s) = 1.
```

Thus both composites are the identity, so `S` is the inverse of `T`.  ∎

This is the precise algebraic equivariance needed to form the theta-root
locus over the `q^ell` quotient.  Away from the theta divisor, and when `ell`
is invertible in `K`, the previously proved separability theorem makes the
pointwise Kummer fibers étale.  Constructing the analytic quotient and its
tempered fundamental group is a later theorem, not part of B.2.

### B.3 — The graph-direction cyclic quotient

**Status:** kernel-checked as the abstract quotient-group equivalence
`TateGraphPeriodQuotient.graphPeriodQuotientEquivZMod` in
`IUTThreeClosures/TateGraphPeriodQuotient.lean`.  The Lean theorem works for
every natural `ell`; the graph-cover application below uses `ell>0`.

Assume `q` has infinite order and `ell>0`.  Put

```text
G = <q>,       H = <q^ell>.
```

Then `H` is a subgroup of `G`, and

```text
G/H ~= Z/ell Z,       q^n H |-> n mod ell.             (B.3)
```

**Proof.**  Every element of `G` is `q^n`.  If `q^nH=q^mH`, then
`q^(n-m)` lies in `H`, so `q^(n-m)=q^(ell*a)` for an integer `a`.  Infinite
order of `q` implies `n-m=ell*a`; hence `n` and `m` have the same residue
modulo `ell`.  This proves that the displayed map is well-defined and
injective.  Every residue has a representative `n`, so it is surjective, and
the exponent law makes it a group homomorphism.  ∎

The identity on `K^x` induces an abstract quotient homomorphism

```text
K^x/H -> K^x/G.
```

It is surjective and has kernel `G/H` by the third isomorphism theorem.  Thus
`Z/ell Z` is the exact group-theoretic deck candidate for
`E_(q^ell) -> E_q`.  After the analytic quotients and proper discontinuity are
constructed, the radial model `R/(ell*w(q))Z -> R/w(q)Z` has graph degree
`ell`; that analytic/topological conclusion is part of B.4, not a consequence
of the abstract group statement alone.  Oddness is not needed for B.3; it is
needed in B.2 to make the theta automorphy factor an `ell`-th power.

### B.4 — The integer action and its freeness

**Status:** kernel-checked in
`IUTThreeClosures/TateThetaOddGraphAction.lean`.

Let `X=Y_ell` be the theta-root locus of B.2, let `ell=2k+1`, put
`Q=q^ell`, and let `T:X->X` be the equivalence constructed there.  Define

```text
n . z = T^n(z),                    n in Z.              (B.4)
```

Then (B.4) is a free action of `Z` on `X`.

**Proof.**  The identities `T^0=id` and `T^(m+n)=T^m*T^n` give the zero and
addition laws, so (B.4) is an action.  The base-coordinate formulas for `T`
and its explicit inverse are

```text
base(T(z))      = Q*base(z),
base(T^(-1)(z)) = Q^(-1)*base(z).
```

Induction in the positive and negative directions therefore gives, for every
integer `n`,

```text
base(T^n(z)) = Q^n*base(z).                            (B.5)
```

Suppose `T^n(z)=z`.  Since `base(z)` lies in `K^x`, (B.5) permits cancellation
of this nonzero coordinate and yields `Q^n=1`.  But

```text
Q^n=(q^ell)^n=q^(ell*n).
```

A Tate parameter has infinite order: a positive natural power equal to one
would have norm both strictly below one and equal to one.  Hence `ell*n=0`.
As `ell=2k+1>0`, this forces `n=0`.  Thus every stabilizer is trivial, which is
exactly freeness.  Notice that the argument uses only the base coordinate; it
does not assume that the theta-root coordinate is nonzero.  ∎

The Lean module constructs the actual integral iterates, proves (B.5) for
all `n : ℤ`, derives the infinite order of the Tate parameter from its norm
inequality, proves the fixed-point equivalence `T^n z = z ↔ n = 0`, and
packages the result as Mathlib's `IsCancelVAdd` free-action class.  No
topological or analytic quotient is hidden in this statement.

#### B.4.1 — Proper discontinuity and the topological orbit cover

Give `X` the topology induced by the injective coordinate map

```text
X -> (K x K) x K,       (u,y) |-> ((u,u^(-1)),y).
```

This is precisely the product topology on the unit coordinate and the root
coordinate.  The explicit formulas for `T` and `T^(-1)` use only continuous
unit multiplication, unit inversion/coercion, and field multiplication, so
`T` is a homeomorphism and every integer iterate is continuous.

Put `h(u,y)=log ||u||` and `a=log ||Q||`.  Since `0<||q||<1` and
`Q=q^(2k+1)`, one has `a=(2k+1) log ||q||<0`; in particular `a` is nonzero.
Formula (B.5) gives the exact height translation law

```text
h(T^n z) = n*a + h(z).                                  (B.6)
```

For compact subsets `C,D` of `X`, the two height images are compact.  If
`T^n(C)` meets `D`, choose `z in C` with `T^n z in D`.  Then by (B.6)

```text
n*a = h(T^n z)-h(z)
```

belongs to the compact difference of the two height images.  The map
`Z -> R`, `n |-> n*a`, has finite inverse image on every compact set when
`a != 0`.  Hence only finitely many integer translates of `C` meet `D`.
This is exactly `ProperlyDiscontinuousVAdd`, and is kernel-checked in
`IUTThreeClosures/TateThetaOddGraphProperness.lean`.

There is also a direct local covering argument which does not assume local
compactness.  Around `e in X` take the inverse image under `h` of

```text
(h(e)-|a|/4, h(e)+|a|/4).
```

If this neighborhood meets its `n`-th translate, (B.6) and the two interval
bounds imply `|n*a|<|a|`.  Since `a != 0`, this gives `|n|<1`, hence `n=0`.
Thus the translates are pairwise disjoint.  Together with the quotient-map
property and the exact orbit equivalence relation, this supplies all fields
of Mathlib's `IsAddQuotientCoveringMap` for the orbit projection.  This is a
statement about an ordinary topological covering only.  It does **not**
construct a rigid-analytic or Berkovich quotient and does not identify a
tempered fundamental group.

The disjoint-neighborhood and orbit-cover conclusions are kernel-checked in
the same module as `oddPeriodShiftAddAction_disjoint_nhds` and
`oddPeriodShift_orbitQuotient_isAddQuotientCoveringMap`.

### B.5 — From the topological orbit cover toward the Tate skeleton

#### B.5.0 — The honest valuation-circle comparison

**Status:** default-imported and kernel-checked in
`IUTThreeClosures/TateThetaValuationCircleComparison.lean`.

The local API audit gives an important distinction.  The current
`TateParameter.AnalyticQuotient` is the group quotient `K^x/q^Z`, equipped
with Mathlib's quotient topology.  The current `tateUniformization` is a group
isomorphism on `K`-points.  Neither object carries a rigid, adic, Huber, or
Berkovich analytic-space structure.

There is nevertheless a genuine first comparison.  Let `X` be the odd
theta-root locus, `T` its graph-period homeomorphism, and `ell=2k+1`.  Then

```text
beta : X/<T> -> K^x/q^Z,       beta([z])=[base(z)]       (B.7)
```

is well-defined and continuous.  Indeed, if `z'=T^n z`, then B.5 gives

```text
base(z')=(q^ell)^n*base(z)=q^(ell*n)*base(z),
```

so the two bases have the same class modulo `q^Z`.  Continuity follows from
continuity of the base coordinate and the universal property of the two
quotient topologies.

Now put

```text
v(u)=-log ||u||,             L=ord(q)=-log ||q||>0.
```

Multiplicativity of the norm gives `v(uv)=v(u)+v(v)`, while

```text
v(q^n)=n*L.
```

Consequently `v` descends to a continuous homomorphism

```text
rho : K^x/q^Z -> R/LZ,       rho([u])=v(u) mod L.        (B.8)
```

Equations (B.7) and (B.8) give an explicit continuous valuation-circle
coordinate on the verified orbit quotient.

This map is not, in general, a skeleton equivalence on `K`-rational points.
If `u` is a nontrivial norm-one unit, then `rho([u])=0`.  On the other hand
`[u]` is nontrivial in `K^x/q^Z`: if `u=q^n`, taking norms gives
`1=||q||^n`, hence `n=0` because `0<||q||<1`, and then `u=1`, a
contradiction.  Thus every such unit gives a concrete nonzero kernel element.
For example, over any field of characteristic different from two, `u=-1`
does so; in particular this gives a witness-free corollary in characteristic
zero.  This invariant rules out replacing the missing Berkovich skeleton
comparison by an equivalence between the present `K`-point quotient and the
full real circle.  It does **not** refute the usual Berkovich retraction onto
a skeleton: that retraction is defined on a larger analytic-point space and
is not asserted to be injective on all analytic or `K`-rational points.

The continuous maps (B.7)--(B.8), their explicit value on representatives,
the conditional norm-one kernel theorem, and the characteristic-zero
`u=-1` corollary are formalized in
`IUTThreeClosures/TateThetaValuationCircleComparison.lean`.

#### B.5.1 — Exact remaining analytic/tempered statement

The next unproved proposition is not another abstract interface.  It is:

> On the punctured analytic Tate curve, the quotient of the explicit locus in
> B.2 by the free, properly discontinuous action generated by `T` is the
> Kummer torsor representing the theta-root `H^1` class on `E_(q^ell)`, and
> the map to `E_q` induces on the tempered graph quotient the concrete group
> in B.3.

This proposition requires an analytic quotient, puncture/divisor control, and
comparison with the tempered skeleton.  It remains open until those objects
and maps are constructed.

## Route A: honest local hulls and normalized Haar volume

### A.0 — Counterexample to the public total-set scaling law

**Status:** already kernel-checked in
`IUTThreeClosures/PublicLogVolumeInconsistency.lean`.

The public component scaling law is quantified over every set `U`.  At
`U=empty`, multiplication-preimage is again empty, so the law asserts

```text
volume(empty) = volume(empty) + log(p).
```

For a rational prime `p`, `log(p)>0`, which is impossible over `R`.  This is a
counterexample to that total real-valued specification, not to Haar measure
or to Corollary 3.12.  The correct domain must exclude zero- or infinite-measure
sets (or use an extended codomain with carefully defined arithmetic).

### A.1 — Least scaled-integral hull in a finite local packet

**Status:** the existence, leastness, and uniqueness of the least hull as a
set are kernel-checked in
`IUTThreeClosures/MaximalValuationRingHull.lean`.  The final characterization
of all presenting scales modulo coordinatewise valuation-ring units remains
proved only on paper.

Let `C` be a nonempty finite set.  For every `c in C`, let `K_c` be a
nontrivial nonarchimedean local field, with absolute value `|.|_c` and maximal
integer ring

```text
O_c = {x in K_c | |x|_c <= 1}.
```

Put `X=product_c K_c`, and for `a in product_c K_c^x` put

```text
B(a) = product_c a_c O_c.
```

Suppose `U` is a subset of `X` such that:

1. the closure of `U` is compact;
2. for each `c`, some `x in U` has `x_c != 0`.

Then the family of scaled integral products containing `U` has a unique least
member under inclusion.  A scale representing this member is unique only
coordinatewise modulo `O_c^x`.

**Proof.**  For a fixed `c`, the function
`x |-> |x_c|_c` is continuous on the compact closure of `U`, hence has a
maximum `r_c`.  Assumption 2 gives `r_c>0`.  Choose `y^(c)` in the closure at
which this maximum is attained, and put `a_c=y^(c)_c`.  Then every `x in U`
satisfies `|x_c|_c<=|a_c|_c`, so `U` is contained in `B(a)`.

If `U` is contained in `B(b)`, then its closure is contained in `B(b)` because
`B(b)` is closed.  In particular `a_c=y^(c)_c` lies in `b_c O_c`, so
`|a_c|_c<=|b_c|_c` and hence `a_c O_c` is contained in `b_c O_c`.  This holds
in every coordinate, proving `B(a) subset B(b)`.  Thus `B(a)` is least, and
two least members are equal by mutual inclusion.

Finally, `a_c O_c=b_c O_c` holds exactly when the two radii agree, equivalently
when `a_c/b_c` is a unit of `O_c`.  This proves the stated uniqueness.  ∎

The nonzero-projection hypothesis is necessary.  If one projection is
identically zero, every ball `pi_c^n O_c` contains it and these balls shrink
strictly forever, so no least hull with nonzero scale exists.

### A.2 — Finite-positive Haar volume and source normalization

**Status:** the identification with the maximal valuation ring, normalization
`mu(O)=1`, and construction of every nonzero scaled ball as an honest
finite-positive region are kernel-checked in
`IUTThreeClosures/MaximalValuationRingHull.lean`.  The residue-cardinality
formula for an irreducible DVR uniformizer, its logarithmic form, the bridge
from the repository's norm-uniformizer to irreducibility, and the resulting
Tate-q/order formula are kernel-checked in
`HaarResidueNormalization.lean`, `TateHaarResidueNormalization.lean`, and
`ActualBadPlaceHaarNormalization.lean`.  The arbitrary-element/product form
of (A.1)--(A.2) and the degree-normalized p-preimage formulas (A.3)--(A.4)
remain paper proofs.

Normalize additive Haar measure `mu_c` by `mu_c(O_c)=1`.  Let `pi_c` be a
uniformizer, let the residue-field cardinality be `q_c`, and write
`ord_c(a_c)=n`.  Then

```text
mu_c(a_c O_c) = q_c^(-n).                              (A.1)
```

Consequently the product measure `mu=product_c mu_c` satisfies

```text
mu(B(a)) = product_c q_c^(-ord_c(a_c)),
log mu(B(a)) = -sum_c ord_c(a_c) log(q_c).             (A.2)
```

Every `B(a)` is compact-open, hence Borel with finite positive measure.

**Proof.**  The maximal integer ring is compact-open, and multiplication by a
nonzero scalar is a homeomorphism; finite products preserve both properties.
A nonempty open set has positive Haar measure and a compact set has finite
Haar measure.

Write `a_c=u*pi_c^n`, with `u` a unit.  Since `u O_c=O_c`, it suffices to
measure `pi_c^n O_c`.  For `n>=0`, `O_c/pi_c^n O_c` has `q_c^n` cosets of
equal measure, proving (A.1).  For negative `n`, apply the same argument to
`pi_c^(-n) O_c` and scale back.  The finite product formula and the logarithm
of a finite product give (A.2).  ∎

For the source's actual Tate parameter this argument is now formal at one
place.  If `pi` generates the norm value group and `qOrder` is the canonical
positive integer with `||q||=||pi||^qOrder`, the Lean theorems derive, rather
than assume,

```text
Delta_K(pi) = (# residue(K))^(-1),
log Delta_K(q) = -qOrder * log(# residue(K)).          (A.2a)
```

The first equality comes from the equal-measure cosets of the maximal ideal;
the norm-defined uniformizer is proved irreducible by comparing it with a DVR
uniformizer.  Equality of norms gives equality of the corresponding scaled
integer balls and hence equality of their Haar characters.  The thin actual
bad-place wrapper identifies the pre-existing `qOrder` definition with this
canonical order.  No component-volume or desired-estimate field enters
(A.2a).  At present that wrapper explicitly assumes the standard local-field
instances (DVR valuation ring, finite residue field, properness, and Borel
measurability); deriving them for every repository adic completion is a
separate source-construction obligation.

Now suppose `K_c/Q_p` has ramification degree `e_c`, residue degree `f_c`, and
local degree `d_c=e_c f_c`.  On a finite-positive measurable set define

```text
lambda_c(A) = (1/d_c) log(mu_c(A)).
```

Since `p` is a unit times `pi_c^e_c` and `q_c=p^f_c`, additive Haar scaling
gives

```text
mu_c((x |-> p*x)^(-1)(A)) = p^d_c mu_c(A),
lambda_c((x |-> p*x)^(-1)(A)) = lambda_c(A) + log(p),  (A.3)
lambda_c(a_c O_c) = -(ord_c(a_c)/e_c) log(p).          (A.4)
```

This is the consistent finite-positive replacement for the public scaling
law.  Packet volume must then use the intended weighted sum of the normalized
component logarithms; it must not be conflated with the raw logarithm of an
unnormalized product Haar measure.

### A.3 — Exact limitation

A.1--A.2 apply only when each integral region is the maximal valuation ring
(or has first been identified with the appropriate fractional ideal).  The
current public `DirectSumPresentation.integral` is an arbitrary subring, and
the comparison between tensor orders and maximal factor rings is not yet
proved.  More importantly, A.1--A.2 construct honest hulls and volumes but do
not construct the multiple arithmetic holomorphic structures, genuine
Theorem 3.11 Ind1--Ind3 possible images, or the disputed degree-line `j^2`
scale comparison.  They therefore do not by themselves imply Corollary 3.12.

### A.4 — Fixed-place scale rigidity over `Q`

**Status:** the prime-specialized two-term rigidity calculation is
kernel-checked as
`MaximalValuationRingHull.rational_prime_specialization_scale_rigidity`.
The derivation of that specialization from a fully formalized product formula
over all rational places remains on paper.

Use the standard real and p-adic absolute values on `Q`.  Suppose real numbers
`s_infty` and `s_p` satisfy the reweighted product formula

```text
s_infty log|x|_infty + sum_p s_p log|x|_p = 0          (A.5)
```

for every nonzero rational `x`; the sum is finite for each `x`.  Then
`s_p=s_infty` for every rational prime `p`.

**Proof.**  Substitute `x=p`.  Standard normalization gives
`log|p|_infty=log p`, `log|p|_p=-log p`, and
`log|p|_r=0` at every other prime `r`.  Thus (A.5) becomes

```text
(s_infty-s_p) log p = 0.
```

Since `p>1`, `log p` is nonzero, so `s_p=s_infty`.  ∎

Hence one cannot insert a `j^2` scale at selected finite places while keeping
the same places, absolute values, and product formula, unless all other
weights change by the same common factor.  This is a concrete failure
criterion for any proposed scale bridge that lives inside one fixed valued
field.  It does not refute a construction based on genuinely different
untilts or arithmeticoids; such a construction must prove that it changes the
valued-field/place identifications rather than merely restating
`|q^(j^2)|=|q|^(j^2)` in a fixed field.

## Route C: source-faithful IUT IV q-pilot

### C.0 — Counterexample to replacing the odd bad q-divisor by `h(j)`

**Status:** proved on paper; Lean formalization pending.  This retires the
direct complete-global-j-packet substitution route, not the source-faithful
odd-q route and not abc.

Three quantities must remain distinct:

1. for a reduced rational `j=u/v`, the complete Weil height is
   `H(j)=log(max(|u|,v))`;
2. its complete finite negative-valuation contribution is `F(j)=log v`;
3. the IUT IV q-divisor `Q(j)` sums `ord(q_p) log p` only over the selected odd
   multiplicative bad places, where locally `ord(q_p)=-ord(j)`.

The current `PublicFreyTheorem110Bridge.componentFormula` uses the first
quantity in the slot occupied by the third quantity in IUT IV, Theorem 1.10.
The difference cannot be put into a uniformly negligible error.

For `m>=4`, put

```text
N=2^m,  P_m=(1,N,N+1),  A=N^2+N+1.
```

This is a primitive abc triple.  Its Frey invariant is

```text
j_m = 256 A^3 / (N^2 (N+1)^2).                        (C.1)
```

**Reduction of (C.1).**  We have `A=1 mod N` and, since `N=-1 mod N+1`, also
`A=1 mod N+1`.  Hence `gcd(A,N(N+1))=1`.  Moreover `A` is odd and `N^2` is
divisible by `256`.  The numerator in (C.1) has 2-adic valuation exactly
eight, so the numerator-denominator gcd is exactly `256`.  Thus

```text
j_m=A^3/D_m,  D_m=N^2(N+1)^2/256,  gcd(A^3,D_m)=1.    (C.2)
```

Since `A>N^2` and `D_m<A^3`, (C.2) gives

```text
H_m := H(j_m) = 3 log A,
F_m := F(j_m) = 2log N+2log(N+1)-8log 2.              (C.3)
```

The odd bad primes are precisely the primes dividing `N+1`.  At each such
prime, the Frey `c_4` is a unit while
`ord_p(Delta)=2ord_p(N+1)`, so reduction is multiplicative and
`ord_p(q_p)=-ord_p(j_m)=2ord_p(N+1)`.  Therefore

```text
Q_m := Q(j_m) = 2log(N+1).                            (C.4)
```

In particular `F_m-Q_m=(2m-8)log 2>=0`; this is exactly the excluded 2-adic
denominator contribution.

**Uniform lower bound for the missing packet.**  From `A>N^2` and
`N+1<=2N`,

```text
H_m-F_m > 2log N+6log 2 = (2m+6)log 2.                (C.5)
```

On the other hand,

```text
cond(P_m)=log(rad(N(N+1)))
         <=log(2(N+1))<=log(4N)=(m+2)log 2.           (C.6)
```

Equations (C.5)--(C.6), together with `Q_m<=F_m`, imply the explicit bound

```text
H_m-Q_m > 2cond(P_m)+log 4.                           (C.7)
```

Thus no inequality `H-Q<=alpha*cond+C`, uniform in all abc points, can hold
with `alpha<2`.  Indeed, replace `alpha` by `max(alpha,0)`, which preserves the
putative upper bound and is still less than two.  Equations (C.5)--(C.6) would
then give, for every `m`,

```text
(2m+6)log 2 < alpha*(m+2)log 2+C,
```

which is impossible as `m` tends to infinity because `2-alpha>0`.

This also contradicts the existing asymptotic error target quantitatively.
For `ell>=7`, put

```text
k_ell=(1/6)(1-12/ell^2) >= 37/294.
```

Changing an authentic component expression
`main+10E-k_ell Q` into `main+10E'-k_ell H` requires

```text
E'-E >= k_ell(H-Q)/10.
```

After the final factor `20` on the error, (C.7) forces an added conductor
slope at least `74/147`, which is positive and independent of `ell`.  It
therefore cannot tend to zero as required by
`AsymptoticRelativeSourceTermAbsorption`.  This is a mathematical
counterexample to the bridge target, not merely an unimplemented lemma.  ∎

### C.1 — A source-faithful sublinear q-absorption inequality

**Status:** kernel-checked in
`IUTThreeClosures/SublinearQPilotAbsorption.lean` as
`sqrt_mul_log_le_linear_explicit`, its multiplicatively weighted corollary,
and `proposition21_absorption_with_sqrtLog`.

For `x>=1`, `A>=1`, and `rho>0`,

```text
sqrt(x) log(Ax)
  <= rho*x + 216/rho^3 + (log A)^2/(2rho).             (C.8)
```

**Proof.**  Put `t=sqrt(sqrt x)`, so `t^4=x` and `t^2=sqrt x`.  Since
`t>=1`,

```text
log x=4log t<=4t,
sqrt(x)log x<=4t^3.                                   (C.9)
```

For every `s>0`, the identity

```text
y^4-4y^3+27=(y-3)^2(y^2+2y+3)>=0
```

at `y=st`, divided by `s^3`, gives

```text
4t^3<=s t^4+27/s^3.                                  (C.10)
```

The square-completion form of Young's inequality gives

```text
t^2 log A<=s t^4+(log A)^2/(4s).                      (C.11)
```

Use `log(Ax)=log A+log x`, add (C.9)--(C.11), and take `s=rho/2`.
The two linear terms add to `rho*x`, while
`27/(rho/2)^3=216/rho^3` and
`(log A)^2/(4(rho/2))=(log A)^2/(2rho)`.  This is
(C.8).  ∎

Inequality (C.8) is tailored to the surviving compact-tripod/GenEll route,
where the auxiliary-prime error has shape `sqrt(q) log(Aq)`.  It absorbs that
error into an arbitrarily small multiple of the authentic q-pilot plus an
explicit constant.  It does not construct the compact comparison or the
required initial theta data.

### C.2 — Exact surviving route and remaining constructions

The source-faithful route must retain the odd bad q-divisor and prove the IUT
IV component estimate from local and procession calculations, rather than
storing it as `componentFormula`.

The first local source step is now kernel-checked.  For the actual Tate
parameter, `SourceFaithfulTheorem110.lean` constructs the finite-positive
regions `q^n O_K` and proves their logarithmic volume is
`n * log Delta_K(q)`.  The three Haar-normalization modules cited in A.2 then
identify this with the residue-normalized numerical term
`-n*qOrder*log(#k)` and provide a thin wrapper at an actual bad
Hodge-theater place.  This replaces the inconsistent total-set volume law at
this one component, but it does not produce an Ind1--Ind3 possible-image
upper bound or the Theorem 1.10 component inequality.

The next concrete stages are:

1. prove that the three nonzero 2-torsion points of the rational Frey curve
   are rational, and deduce `F_tpd=Q`, moduli degree one, and zero relative
   different in the intended source definitions;
2. prove on the genuine compact locus the comparison among the odd q-divisor,
   the all-bad q-divisor, and the tripod height;
3. construct the actual forbidden prime set from the local heights, prove its
   mass bound, and select a prescribed-size prime satisfying the P1--P7
   conditions of the general-position argument;
4. build the source-faithful local/procession bridge and use C.1 for its
   q-relative error absorption;
5. formalize the remaining ramified-covering, noncritical Belyi, and height
   comparisons needed to pass from the compact statement to all abc triples.

None of these steps may replace the odd q-divisor by `completeGlobalJPacket`,
or use an arbitrary `different`, `error`, or target estimate field.

## Route D: the IUT III multiradial scale bridge

### D.0 — Fixed-place common-scale obstruction

**Status:** default-imported and kernel-checked in
`IUTThreeClosures/MultiradialScaleCompatibilityNoGo.lean`.  This is a
necessary compatibility test for a proposed
degree-line bridge, not a refutation of a bridge that genuinely changes the
valued fields or their place identifications.

Let `K` be a normed field, let `q` be a Tate parameter, and put

```text
L = log ‖q‖ < 0.
```

For the repository's concrete theta-labeled Kummer points

```text
thetaPoint(j) = q^(j^2),
```

one has

```text
log ‖thetaPoint(j)‖ = j^2 * L.                        (D.1)
```

**Proof.**  The norm is multiplicative on natural powers, so
`‖q^(j^2)‖=‖q‖^(j^2)`.  Since `‖q‖>0`, the logarithm-of-a-power identity gives
(D.1).  The Tate inequality `‖q‖<1` gives `L<0`, in particular `L!=0`.  ∎

Suppose now that a single real scale `s` is used at every procession label,
as is forced by a literal common-place interpretation of the tensor
identifications of multiplication by integers.  If the horizontal comparison
is power-faithful and calibrates both the labels `1` and `2` back to the same
q-pilot degree, then it asserts

```text
s * log ‖thetaPoint(1)‖ = L,
s * log ‖thetaPoint(2)‖ = L.                          (D.2)
```

There is no such `s`.

**Proof.**  By (D.1), equations (D.2) are `sL=L` and `4sL=L`.
The first and `L!=0` give `s=1`; the second then gives `4L=L`, hence
`3L=0`, contradicting `L!=0`.  ∎

Thus the missing bridge cannot consist merely of the identities
`‖q^(j^2)‖=‖q‖^(j^2)` inside one fixed normed field followed by one common
rescaling.  A surviving construction must provide genuinely different
arithmetic holomorphic structures (or valued-place identifications), explain
which compatibility in (D.2) is replaced, and then prove that the replacement
still supports the global product formula and procession log-volume.  This is
the exact point at which an untilt/arithmeticoid proposal must add mathematics;
storing a family of arbitrary real scales is not a construction.

### D.1 — Unique labelwise calibration and its exact limitation

**Status:** default-imported and kernel-checked in
`IUTThreeClosures/MultiradialLabelScaleCalibration.lean`.

Let `L != 0`, let `j` be a positive integer, and consider the label-`j`
degree `j^2 L`.  There is a unique real scale `s_j` which calibrates this
degree back to `L`, namely

```text
s_j = 1/j^2.                                           (D.3)
```

Moreover `s_j>0`, and the scales are multiplicatively coherent:

```text
s_(jk) = s_j s_k.                                      (D.4)
```

**Proof.**  Since `j>0`, the real number `j^2` is nonzero.  Hence
`(1/j^2)(j^2 L)=L`, which proves existence, and `1/j^2>0`.  Conversely, if
`s(j^2 L)=L`, cancellation of `L!=0` gives `s j^2=1`, hence `s=1/j^2`.
Finally `(jk)^2=j^2k^2`, and taking inverses in `R` gives (D.4).  ∎

This pointwise result also calibrates every finite weighted procession.  If
`j_i>0` and `w_i` are real weights, then termwise application of (D.3) gives

```text
sum_i w_i s_(j_i)(j_i^2 L) = (sum_i w_i)L.            (D.5)
```

In particular, normalized weights with sum one give `L`.  Equation (D.5) is
an algebraic consequence of the explicit scales; it does not assume a target
log-volume estimate.

There is a simple local model realizing (D.3): on a copy of a valued field,
replace every logarithmic absolute value `lambda_v` by
`lambda_(v,j)=j^(-2)lambda_v`.  Then

```text
lambda_(v,j)(q^(j^2)) = lambda_v(q).
```

If the original global logs satisfy a product formula, rescaling *all* places
in the label-`j` copy by the same `j^(-2)` preserves a product formula for
that copy, since its product-formula sum is merely multiplied by `j^(-2)`.
Thus local calibration and a separate product formula at each label are not,
by themselves, contradictory.

They do not, however, supply Theorem 3.11.  Step (x) of the proof of
Corollary 3.12 states that the tensor products identify multiplication by
elements of `Z`, including the log-volume effect of that multiplication,
across distinct labels.  In the rescaled-copy model, multiplication by an
integer `a` has log effect `j^(-2)lambda_v(a)` at label `j`; for any `a,v`
with `lambda_v(a)!=0`, these effects differ between labels `1` and `2`.
Hence this model fails the stated cross-label tensor compatibility.

Nor can one repair this merely by multiplying the local degree weight at
label `j` by `j^2`.  Such a weight makes the integer effect label-independent,
but it also changes the weighted degree of `q^(j^2)` back to `j^2` times the
q-degree.  Abstractly, if `a_j` is the combined norm/degree coefficient,
integer compatibility gives `a_1=a_2!=0`, while theta calibration gives
`a_1*1=a_2*4`; these equations are inconsistent.

Thus genuinely different field copies help only if the comparison is not a
scalar renormalization of one fixed family of places.  A viable untilt/AHS
construction must specify which ring-theoretic identifications are absent,
construct the log-Kummer and horizontal comparison maps that replace them,
and prove the retained tensor/procession and global-degree compatibilities.
The explicit translations in `ActualHodgeTheaterOutput.horizontalEquiv`
cannot play this role: they send `q^(j^2)` to `q^(k^2)` in the same normed
field and are not log-norm preserving for, e.g., `j=1`, `k=2`.

The zero label is necessarily excluded from (D.3): `thetaPoint(0)=1` has
log-norm zero, so no finite real scale can calibrate it to the nonzero Tate
log-degree.  This agrees with the use of nonzero theta labels in the source;
the separate `0`/average-label identification used for the q-pilot must not be
silently treated as another instance of pointwise division by `j^2`.

### D.2 — Exact positive target

The next positive theorem must construct, rather than postulate:

1. the valued fields or untilts attached to at least the labels `1` and `2`;
2. comparison maps carrying the theta and q pilots between their genuinely
   different arithmetic holomorphic structures;
3. normalized local degree maps compatible with the relevant global product
   formula;
4. the procession/tensor compatibility actually retained by those maps; and
5. a proof that these data yield `-|log q| <= -|log Theta|` without assuming
   that inequality as a field.

Any candidate that reduces to a common fixed-place scale is rejected by D.0.

## Route E: concrete GenEll covering and Belyi geometry

### E.0 — Finite étale Kummer cover of a unit

**Status:** default-imported and kernel-checked in
`IUTThreeClosures/ConcreteGenEllKummerCover.lean` and
`IUTThreeClosures/ConcreteGenEllTripodCover.lean`.

Let `R` be a commutative ring, let `n>0`, and assume both `u:R` and the image
of `n` in `R` are units.  Put

```text
f(X)=X^n-u.
```

Then the monogenic algebra `R[X]/(f)` is finite étale over `R`.

**Proof.**  The polynomial is monic, so its quotient is finite free with basis
`1,X,...,X^(n-1)`.  Its derivative is `f'=n X^(n-1)`.  Write `nInv` and
`uInv` for the inverses of `n` and `u`.  The polynomial identity

```text
f' * ((nInv*uInv) X) + f * (-uInv) = 1               (E.1)
```

holds: the first summand is `uInv X^n`, while the second is
`-uInv X^n+1`.  Hence `f` and `f'` generate the unit ideal.  Equivalently the
class of `f'` is a unit in `R[X]/(f)`, so the standard monic presentation is
formally étale.  Finite presentation together with finite freeness proves
that the algebra is finite étale.  ∎

Take now

```text
A = K[t, t^(-1), (1-t)^(-1)],
```

the coordinate ring of the tripod over a characteristic-zero field `K`.
Both `t` and `1-t` are units and every positive integer `n` is invertible in
`K`.  Applying E.0 twice gives the finite étale algebra

```text
B = A[x,y]/(x^n-t, y^n-(1-t)),                       (E.2)
```

of rank `n^2`.  Its affine equation is `x^n+y^n=1`, and the map to the tripod
is `t=x^n`.  If `K` contains the `n`-th roots of unity, coordinatewise
multiplication gives the expected `mu_n^2` action.  Thus (E.2) is the explicit
affine Fermat/Kummer cover that should supply the ramified-covering step for
the tripod after compactification.

The Lean development constructs the two actual standard étale algebras and
their composite algebra map, proves `Algebra.Etale`, `Module.Finite`, and
`Module.Free` for the composite, and proves the exact tower rank

```text
finrank_A(B) = n^2.
```

The nontriviality needed for this rank statement is not assumed: the tripod
localization is shown nontrivial from `X(1-X) != 0`, and each Kummer algebra is
shown nontrivial from its explicit positive-dimensional power basis.  The
distinguished elements in the final algebra satisfy both Kummer equations and
`x^n+y^n=1`.  Positive freeness then gives `Module.FaithfullyFlat`, and the
standard faithfully-flat theorem gives surjectivity of the induced
`PrimeSpectrum.comap`.  Thus the affine ring map is now an honest finite
étale cover on prime spectra.  A scheme-level `Spec` morphism object,
connectedness, geometric irreducibility, compactification, and boundary
ramification remain separate.

### E.1 — Exact remaining GenEll geometry

The following facts are not part of E.0 and remain to be proved and
formalized: connectedness/geometric irreducibility of the Fermat cover;
normal projective compactification and ramification index `n` over
`0,1,infinity`; the canonical-height, different, and conductor comparisons;
existence of a noncritical Belyi map on the resulting divisor-free curve; and
the compactness argument producing the actual `BelyiDescent`.  Only after
these constructions are available may the two fields of
`Genl.HeightTheory.ProofPackage` be replaced by concrete theorems.
