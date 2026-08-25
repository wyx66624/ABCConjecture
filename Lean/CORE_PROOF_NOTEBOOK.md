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

#### B.6 — The angular kernel and the discrete `K`-rational skeleton image

**Status:** target-compiled and kernel-checked in
`IUTThreeClosures/TateThetaDiscreteSkeletonImage.lean`.  The exact kernel and
first-isomorphism statements are `valuationCircleMap_ker_eq_angularKernel` and
`angularQuotientEquivValuationCircleRange`; the discrete comparison, finite
cyclic range, and exact cardinality are
`discreteSkeletonMap_ker_eq_angularKernel`,
`valuationCircleRangeEquivZMod`, and
`natCard_valuationCircleMap_range`.

Let

```text
U^1 = {u in K^x : ||u||=1}
```

and let `iota : U^1 -> K^x/q^Z` be the restriction of the quotient map.  The
map `iota` is injective.  Indeed, if a norm-one unit belongs to `q^Z`, it is
`q^n` for some integer `n`; taking norms gives `1=||q||^n`, hence `n=0`
because `0<||q||<1`, and the unit is one.

The exact kernel of the valuation-circle map (B.8) is

```text
ker(rho) = iota(U^1).                                  (B.9)
```

One inclusion follows immediately from `-log ||u||=0` on `U^1`.  Conversely,
suppose `rho([u])=0`.  Equality to zero in `R/LZ` gives an integer `n` with

```text
-log ||u|| = n L = -n log ||q||.
```

Thus `w=u*q^(-n)` has logarithmic norm zero and hence norm one, while
`[w]=[u]` modulo `q^Z`.  This proves (B.9).  No discreteness assumption is
used.  The first isomorphism theorem therefore gives the honest group
equivalence

```text
(K^x/q^Z) / iota(U^1)  ~=  range(rho).                 (B.10)
```

Now assume the norm is discretely generated by a uniformizer `pi`.  For each
`u in K^x`, let `e_pi(u)` be the unique integer characterized by

```text
||u|| = ||pi||^(e_pi(u)).                              (B.11)
```

Existence is the generator property of `pi`; uniqueness follows from
`0<||pi||<1`.  Multiplicativity of the norm makes `e_pi` a homomorphism
`K^x -> Z`, and powers of `pi` show it is surjective.  Put

```text
r = orderZ_pi(q) > 0,
```

so `e_pi(q)=r`.  Reduction modulo `r` kills `q^Z` and descends to a
surjective homomorphism

```text
sigma_pi : K^x/q^Z -> Z/rZ.                            (B.12)
```

Its kernel is again `iota(U^1)`: if `e_pi(u)=rk`, then
`u*q^(-k)` has exponent zero, hence norm one, and represents `[u]`; the
reverse inclusion is immediate.  Applying the first isomorphism theorem to
(B.12) and comparing with (B.10) gives

```text
range(rho) ~= Z/rZ = ZMod r.                           (B.13)
```

Consequently the radial image of the **`K`-rational points** is a finite
cyclic group of exactly `r` elements.  It is not the full real circle: the
latter contains, for example, all real classes in a fundamental interval,
whereas (B.13) consists only of the `r` integral valuation classes.  This is
not a contradiction to the Berkovich skeleton.  Filling the real circle
requires non-classical analytic points with real radii; those points and the
Berkovich retraction are not present in the current repository API.

#### B.7 — Genuine Gauss points and the radial analytic orbit

**Status:** mathematical proof complete and target-compiled in the independent
module `IUTThreeClosures/PolynomialGaussPointOrbit.lean`.

Let `K` be a nonarchimedean normed field and let `r>0`.  For

```text
p(X)=sum_i a_i X^i
```

put

```text
|p|_r = max_i ||a_i|| r^i.                            (B.14)
```

The nonarchimedean Gauss lemma says that (B.14) is multiplicative; positivity
of `r` says that it vanishes exactly on the zero polynomial.  It therefore
defines a bundled multiplicative absolute value on `K[X]`.  Its restriction
to constants is the given norm on `K`, while

```text
|X|_r=r.                                               (B.15)
```

Consequently `r |-> |.|_r` is injective: evaluation at `X` recovers the
parameter.  These are genuine non-classical multiplicative seminorm points
of the Berkovich affine line (and, since (B.15) is nonzero, of its
multiplicative locus); they are not evaluation maps at `K`-rational points.

For `q!=0`, substitution

```text
sigma_q : K[X] -> K[X],       p(X) |-> p(qX)
```

is a `K`-algebra automorphism, with inverse `sigma_(q^-1)`.  Its `i`-th
coefficient is `a_i q^i`, so multiplicativity of the base norm gives

```text
|sigma_q(p)|_r
  = max_i ||a_i q^i|| r^i
  = max_i ||a_i|| (||q||r)^i
  = |p|_(||q||r).                                     (B.16)
```

Thus pullback by the variable-scaling automorphism sends the Gauss point of
radius `r` exactly to the Gauss point of radius `||q||r`.

Finally assume `0<||q||<1` and put `L=-log ||q||>0`.  On positive radii the
logarithm converts the action `r |-> ||q||r` into translation by `-L`.
Hence

```text
r |-> log(r) mod LZ                                  (B.17)
```

is invariant.  Its fibres are exactly the multiplicative orbits:

```text
log(r)=log(s) mod LZ  <->  exists n:Z, s=||q||^n r.  (B.18)
```

Surjectivity follows by representing a circle class by `x in R` and taking
the positive radius `exp(x)`.  Moreover `log:(0,infinity)->R` is a
homeomorphism and `R->AddCircle L` is the standard quotient map.  Their
composite is therefore a quotient map, so the quotient of the positive Gauss
ray by radius scaling, with its canonical quotient topology, is homeomorphic
to `AddCircle L`.

This closes only the radial **polynomial Gauss locus**.  It does not construct
the full Berkovich spectrum, a Laurent/Tate algebra, a rigid or adic quotient,
the angular directions, a deformation retraction, or a tempered fundamental
group comparison.  In particular (B.17) must not be advertised as the full
analytic Tate quotient. ∎

#### B.8 — Laurent extension of the Gauss point

**Status:** mathematical proof complete and target-compiled in the independent
module `IUTThreeClosures/LaurentGaussPointOrbit.lean`.

Write `L=K[T,T^(-1)]`.  Every Laurent polynomial `f` admits a shifted
polynomial presentation

```text
P_f(T) = f(T) T^N,             N>=0, P_f in K[T].      (B.19)
```

For `r>0` define

```text
|f|^Laur_r = |P_f|_r / r^N.                            (B.20)
```

This is independent of (B.19).  Indeed, if also `Q=fT^M`, then multiplication
by the opposite powers of `T` and injectivity of `K[T]->L` give

```text
P T^M = Q T^N  in K[T].                               (B.21)
```

The polynomial Gauss norm of `T^d` is `r^d`; applying multiplicativity to
(B.21) gives `|P|_r r^M=|Q|_r r^N`, and division by the positive number
`r^(N+M)` proves equality of the two values in (B.20).

For presentations `P=fT^N` and `Q=gT^M`, common-denominator presentations
are

```text
P T^M + Q T^N = (f+g)T^(N+M),
P Q             = (fg)T^(N+M).                        (B.22)
```

The polynomial Gauss triangle inequality and multiplicativity, followed by
division by `r^(N+M)>0`, therefore prove respectively the triangle inequality
and exact multiplicativity for (B.20).  Nonnegativity is immediate.  If
(B.20) vanishes, the polynomial numerator vanishes; (B.19) then says
`fT^N=0`, and cancellation by the unit `T^N` gives `f=0`.  Thus (B.20)
packages as an actual `AbsoluteValue L R`.

Taking `N=0` proves exact extension of the polynomial Gauss point.  Taking
the presentations `T=T` and `1=T^(-1)T` gives

```text
|T|^Laur_r=r,             |T^(-1)|^Laur_r=r^(-1),     (B.23)
```

and evaluation at `T` proves radius injectivity.

For `q!=0`, the localization universal property extends `T |-> qT` to a
`K`-algebra automorphism `Sigma_q` of `L`, with inverse `Sigma_(q^(-1))`.
If `P=fT^N`, applying `Sigma_q` and moving the scalar `q^N` to the numerator
gives a presentation

```text
q^(-N) P(qT) = Sigma_q(f) T^N.                        (B.24)
```

Polynomial covariance from B.7 and (B.20) now yield

```text
|Sigma_q(f)|^Laur_r = |f|^Laur_(||q||r).              (B.25)
```

This is still the algebraic Laurent ring of finite sums.  It is not the Tate
algebra or an annulus completion, does not construct the full Berkovich
multiplicative group, and does not by itself supply a rigid/adic Tate-curve
quotient or tempered comparison. ∎

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

### C.3 — The finite actual bad-place Haar packet

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/ActualBadPlaceQPilotPacket.lean`.  This is the finite-place
source packet and its arithmetic-degree identity.  It is not an Ind1--Ind3
procession, a component estimate, or an abc inequality.

Let `Q` enumerate the finite bad locus and, for each `w` in this finite set,
write

```text
K_w = F_w,   k_w = residue(K_w),   q_w = the actual Tate parameter,
n_w = ord_w(q_w) > 0,              Nw = #k_w.
```

Use the additive Haar measure normalized by `mu_w(O_{K_w})=1`, and let
`Delta_w` be its distributive Haar character.  Define the actual signed local
entry and the finite packet sum by

```text
lambda_w = log Delta_w(q_w),
V_Haar(Q) = sum_{w in Q.badFinset} lambda_w.           (C.12)
```

There is no numerical entry stored in this packet: `q_w`, its uniformizer,
and `n_w` are the existing source-derived objects at `w`, while `Delta_w` is
the genuine Haar modulus of the completed local field.

The missing comparison between local and global residue sizes is canonical.
Reduction gives a ring homomorphism

```text
O_F / w  -->  k_w.                                    (C.13)
```

It is surjective by density of `F` in `F_w`.  If a global integer `a` maps to
zero, then its image in `O_{K_w}` lies in the maximal ideal, equivalently its
native valuation is `<1`.  Compatibility of the completion valuation with
the original finite-place valuation says this is equivalent to `a in w`.
Thus (C.13) is also injective, hence

```text
#k_w = #(O_F/w) = absNorm(w).                          (C.14)
```

In particular (C.14) includes the residue-degree factor: if `p_w` is the
residue characteristic and `f_w=[O_F/w : F_{p_w}]`, the finite-field cardinal
formula gives `Nw=p_w^f_w`; it is not legitimate to replace `log Nw` by
`log p_w` without the factor `f_w`.

The residue-normalized local Haar theorem and (C.14) now give, with the sign
fixed by `q_w O_{K_w}` being smaller than `O_{K_w}`,

```text
lambda_w = -n_w log Nw = -n_w log absNorm(w).          (C.15)
```

Let the effective arithmetic q-divisor be

```text
D_q = sum_{w in Q.badFinset} n_w [w].                 (C.16)
```

By the definition of arithmetic-divisor degree, summing (C.15) over the
finite bad set gives the exact source identity

```text
-V_Haar(Q) = deg(D_q),
-V_Haar(Q)/[F:Q] = normalizedDegree(D_q)
                  = arithmeticLogQ(Q).                (C.17)
```

For the public `QPilotData.logQ`, whose `weight` field is arbitrary data, one
cannot prove unconditional equality.  The exact and necessary interface is
the already exposed compatibility

```text
weight(w) log(p_w) = log(absNorm(w)) / [F:Q].          (C.18)
```

Under (C.18), (C.17) is exactly `Q.logQ`; without (C.18), a one-place packet
with the weight replaced by twice its intended value is an immediate
counterexample.  Thus the source-derived arithmetic logarithm is
unconditional, while identification with the current public scalar is
correctly conditional and contains no hidden target formula.  ∎

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

### D.3 — Cross-label integer-effect obstruction

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/MultiradialIntegerEffectObstruction.lean`.

The last paragraph of Step (x) in the proof of IUT III, Corollary 3.12 says
that the tensor products identify multiplication by elements of `Z`, including
the log-volume effect of that multiplication, at different nonzero theta
labels.  This statement gives a sharper test than merely asking for a separate
product formula in each label copy.

Let `L != 0` be the q-pilot logarithmic degree and let `M != 0` be the
log-volume effect of multiplication by one fixed integer at one place.  For
two positive labels `j,k`, suppose coefficients `a_j,a_k` satisfy

```text
a_j (j^2 L) = L,              a_k (k^2 L) = L,       (D.4)
a_j M = a_k M.                                      (D.5)
```

If `j^2 != k^2`, these equations are inconsistent.  Indeed, cancellation of
the nonzero `M` in (D.5) gives `a_j=a_k`.  Substitution in (D.4) then gives a
single coefficient calibrating the two distinct exponents `j^2` and `k^2` to
the same nonzero `L`, contradicting D.0.  In particular, labels `1` and `2`
cannot simultaneously have calibrated q-degrees and a common nonzero integer
effect inside one scalar-rescaled fixed-place model.

There is also an exact rigidity statement for the apparent repair by label
weights.  Pointwise theta calibration forces

```text
a_j = 1/j^2.
```

If a further weight `w_j` is required to restore the original integer effect,

```text
w_j a_j M = M,
```

then cancellation gives `w_j=j^2`.  But the same combined coefficient applied
to the theta point gives

```text
w_j a_j (j^2 L) = j^2 L,
```

so the square exponent reappears exactly.  Thus scalar rescaling and scalar
reweighting cannot simultaneously remove the theta square and preserve the
cross-label integer response.  A successful AHS/untilt construction must
therefore use genuinely non-scalar comparison data; in particular it cannot
transport all ring-theoretic integer actions as ordinary fixed-place
log-isometries.  This is a diagnostic obstruction to that restricted model,
not a contradiction in IUT III and not a counterexample to abc.

### D.4 — Actual label-rescaled absolute-value copies

**Status:** proved on paper and target-compiled in
`IUTThreeClosures/MultiradialLabelAbsoluteValue.lean`; not added to the root
import graph in this stage.

Let `K` be a nonarchimedean normed field, write `v(x)=‖x‖`, and let `s>0`.
Define

```text
v_s(x) = v(x)^s.
```

Then `v_s` is an actual absolute value, not merely a scalar attached to a
copy of `K`, and it induces the same topology as `v`.

**Proof.**  Nonnegativity and positive definiteness follow from positivity of
real powers with positive exponent.  Multiplicativity follows from

```text
(v(x)v(y))^s = v(x)^s v(y)^s.
```

For the additive axiom one must use nonarchimedeanness.  The strong triangle
inequality and monotonicity of the positive power give

```text
v_s(x+y) <= max(v(x),v(y))^s
           = max(v_s(x),v_s(y))
           <= v_s(x)+v_s(y).
```

This also proves that `v_s` is nonarchimedean.  The restriction is genuine:
for an ordinary archimedean absolute value and `s>1`, raising the usual
triangle inequality to the power `s` need not preserve it.

Finally, `t |-> t^s` is strictly increasing on the nonnegative reals and has
inverse `t |-> t^(1/s)`.  Hence a sequence tends to zero for `v_s` exactly
when it tends to zero for `v`; by translation, the two absolute values induce
the same field topology.  Equivalently, the identity ring equivalence between
the two associated absolute-value copies is a homeomorphism.  ∎

For every positive label `j`, set

```text
s_j = 1/j^2,              v_j(x) = v(x)^(1/j^2).
```

If `q` is nonzero, then the actual label-`j` value of the square-power theta
point has the original logarithmic q-size:

```text
log v_j(q^(j^2))
  = (1/j^2) log(v(q)^(j^2))
  = (1/j^2) j^2 log v(q)
  = log v(q).                                           (D.6)
```

On the other hand, for every integer `a` whose image in `K` is nonzero,

```text
log v_j(a) = (1/j^2) log v(a).                         (D.7)
```

Thus the canonical identity ring equivalence from the label-`1` copy to the
label-`2` copy sends the integer cast of `a` to the same integer cast, but its
logarithmic norm changes from `log v(a)` to `(1/4) log v(a)`.  Whenever
`log v(a) != 0`, it is therefore not a logarithmic norm isometry.  This is the
actual-valued-field realization of the scalar obstruction in D.3.

The hypothesis that some embedded integer has nonzero logarithmic norm is
necessary for the last conclusion.  It holds at a p-adic place for `a=p`, but
it is false for, for example, a `t`-adic norm that is trivial on the prime
field.  Consequently no theorem about an arbitrary nonarchimedean normed
field may assert this integer witness without an additional assumption on
the restriction of its absolute value to `Z`.

The same integer argument rules out **every** logarithmic-norm-isometric ring
equivalence between the label-`1` and label-`2` copies whenever such an
integer exists, not only the canonical identity equivalence.  Every unital
ring equivalence fixes integer casts.  Evaluating a hypothetical log-norm
isometry at `a` would therefore identify `log v(a)` with
`(1/4) log v(a)`, contradicting `log v(a) != 0`.  In particular, for the
actual field `Q_p` one may take `a=p`, since `||p||_p=p^(-1)<1`.  Hence there
is no ring equivalence at all between these two rescaled `Q_p` copies that
preserves logarithmic norm.  This remains a fixed-place valued-ring
obstruction, not a construction or refutation of the source's AHS/untilt
comparisons.

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

### E.2 — Integrality of the affine Fermat curve

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/ConcreteFermatIrreducibility.lean`.

Let `K` be a characteristic-zero field and let `n>0`.  Regard the Fermat
polynomial as a polynomial in `Y` over `K[X]`:

```text
F_n(Y) = Y^n - (1-X^n) in K[X][Y].                 (E.3)
```

Then `F_n` is irreducible.  Put `P=(X-1)` in `K[X]`.  The ideal `P` is prime.
The polynomial (E.3) is monic in `Y`; every non-leading coefficient lies in
`P`, since the only nonzero such coefficient is `-(1-X^n)` and `X-1` divides
`1-X^n`.  Its constant coefficient is not in `P^2`: otherwise
`(X-1)^2` would divide `1-X^n`, hence `X-1` would divide its derivative
`-nX^(n-1)`.  Evaluation at `X=1` would give `-n=0` in `K`, contradicting
characteristic zero and `n>0`.  Eisenstein's criterion at `P` therefore proves
irreducibility.

Since `K[X][Y]` is a unique factorization domain, this irreducible element is
prime.  Consequently

```text
K[X,Y]/(Y^n-(1-X^n))
```

is an integral domain.  This is the affine chart of the Fermat curve, so the
divisor `Z=0` at infinity is already outside this chart.  Localizing further
away from `X=0` and `Y=0` preserves integrality and gives the open ring used
below.  The Lean target in this stage is the irreducibility and domain
statement; identifying this quotient/localization with the existing iterated
tripod Kummer algebra is the next explicit algebra-equivalence theorem.

### E.3 — The honest affine open Fermat ring

**Status:** proved on paper and target-compiled in
`IUTThreeClosures/ConcreteFermatOpenRing.lean`; not added to the root import
graph in this stage.

Let `K` be a characteristic-zero field, let `n>0`, and let

```text
A = K[X][Y] / (Y^n-(1-X^n)).
```

By E.2, `A` is a domain.  Write `x` for the image of the coefficient
variable `X` and `y` for the image of `Y`.  The defining relation is

```text
y^n = 1-x^n,                 x^n+y^n=1.              (E.4)
```

The coefficient map `K[X] -> A` is injective.  Indeed, the defining
polynomial is monic of positive degree in `Y`; if a constant-in-`Y`
polynomial belonged to its principal ideal, degree comparison would force it
to be zero.  Since both `X` and `1-X^n` are nonzero in `K[X]`, injectivity
gives

```text
x != 0,                      1-x^n != 0.
```

Consequently the honest boundary element

```text
d = x(1-x^n) = x y^n
```

is nonzero in the domain `A`.  Define the affine open Fermat ring by

```text
A_open = A[d^(-1)].                                  (E.5)
```

**Proof of the open-ring properties.**  Localization of a domain at powers
of a nonzero element is again a domain, hence is nontrivial.  By definition,
the image of `d=x(1-x^n)` in `A_open` is a unit.  In a commutative ring a
product is a unit exactly when both factors are units, so the images of `x`
and `1-x^n` are units.  Equation (E.4) survives under the localization map and
identifies the image of `y^n` with the unit `1-x^n`.  As `n>0`, an element is
a unit whenever its `n`-th power is a unit; therefore the image of `y` is a
unit as well.  Applying the localization homomorphism to (E.4) also gives

```text
x^n+y^n=1
```

inside `A_open`.  Thus (E.5) is a nontrivial integral-domain presentation of
the affine Fermat curve with the divisors `x=0` and `y=0` removed.  It is the
correct open source for comparison with the existing two-step tripod Kummer
algebra.  Nothing here constructs the points at infinity, a projective
compactification, a Belyi map, or the required ramification data.  ∎

The same Lean module begins, but does not finish, the comparison with
`ConcreteGenEllTripodCover.FermatAffineRing`.  It proves that the existing
iterated-Kummer coordinates are units, evaluates the coefficient variable at
the existing `fermatX`, uses the `AdjoinRoot` universal property to map the
affine presentation to the iterated Kummer ring, and then uses the
localization universal property to construct

```text
A_open -> ConcreteGenEllTripodCover.FermatAffineRing.
```

This homomorphism sends the new `openX` and `openY` to the existing
`fermatX` and `fermatY`.  The reverse homomorphism and the two inverse laws
remain to be constructed before this may be promoted to an algebra
equivalence.

#### E.3.1 — Exact comparison with the iterated tripod Kummer algebra

**Status:** the mathematical proof is recorded here; its explicit Lean
inverse and equivalence are completed in the separate E.6 target below.

Let `B` denote the existing two-step Kummer algebra over
`K[t,t^(-1),(1-t)^(-1)]`.  The preceding forward map `Phi : A_open -> B`
sends `x,y` to its distinguished Kummer generators.  It is an isomorphism.

**Construction of the inverse.**  Map the polynomial tripod coordinate by

```text
t |-> x^n  in A_open.
```

The inverted tripod element maps to

```text
t(1-t) |-> x^n(1-x^n) = x^n y^n = (xy)^n,
```

which is a unit because both `x` and `y` are units in `A_open`.  The
localization universal property therefore gives a map from the tripod ring to
`A_open`.  Under this map, `x` is a root of the first Kummer equation
`T^n-t`, so the first `StandardEtalePair` universal property extends the map
to the first Kummer ring.  The element `y` is then a root of the second
equation `T^n-(1-t)`, so the second universal property gives

```text
Psi : B -> A_open.
```

The maps are inverse.  For `Psi Phi`, localization extensionality reduces the
claim to the affine `AdjoinRoot`; its extensionality reduces further to the
coefficient polynomial variable and the adjoined root.  These are precisely
`x` and `y`, and both are fixed by construction.  For `Phi Psi`, apply
`StandardEtalePair.hom_ext` first to the second Kummer generator and then to
the first; on the base tripod ring, localization extensionality reduces the
claim to the polynomial coordinate `t`, which is fixed because
`Phi(x)^n=t`.  Thus `Phi` and `Psi` are mutually inverse ring maps.  In
particular it follows mathematically that `B` is an integral domain and that
the corresponding affine spectrum is connected.  The current Lean module has
not separately packaged this consequence as an `IsDomain` instance or a
scheme-topological connectedness theorem.  This comparison still says nothing
about geometric irreducibility after arbitrary base change, projective
compactification, boundary ramification, or Belyi heights.

### E.4 — Pointwise Jacobian nonsingularity of the projective Fermat curve

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/ConcreteProjectiveFermatSmoothness.lean`.

Let `K` be a characteristic-zero field, let `n>0`, and put

```text
G_n(X,Y,Z) = X^n + Y^n - Z^n.
```

At every nonzero triple `(x,y,z)` over `K`, at least one of the three formal
partial derivatives

```text
n*x^(n-1),       n*y^(n-1),       -n*z^(n-1)          (E.6)
```

is nonzero.  Indeed, choose a nonzero coordinate.  Characteristic zero and
`n>0` imply that the image of `n` in `K` is nonzero, and a power of a nonzero
field element is nonzero.  The corresponding expression in (E.6) is therefore
nonzero (with the harmless additional minus sign in the `z` case).  Hence no
nonzero solution of `G_n=0` is a Jacobian-singular projective point.

The proof is uniform in the characteristic-zero field, so it applies after
every characteristic-zero field extension.  The Lean theorem at this stage
formalizes the homogeneous equation, its three coordinate partial values, and
the pointwise no-singularity statement.  It does **not** yet construct `Proj`,
invoke a scheme-level Jacobian criterion, or package a smooth projective
curve; those remain part of the compactification step.

### E.5 — Affine Fermat smoothness from a global Jacobian certificate

**Status:** mathematical proof and Lean formalization complete in
`IUTThreeClosures/ConcreteAffineFermatJacobian.lean`.

Let `K` be a characteristic-zero field, let `n>0`, and write

```text
P = K[X,Y],                 f = X^n+Y^n-1,
A = P/(f).
```

The formal partial derivatives are

```text
f_X = n X^(n-1),            f_Y = n Y^(n-1).
```

They satisfy the following identity already in `P`:

```text
X f_X + Y f_Y - n f = n.                           (E.7)
```

Indeed, the first two terms on the left are
`n X^n+n Y^n`; subtracting `n(X^n+Y^n-1)` leaves `n`.
After applying the quotient map `P -> A`, the term `n f` vanishes, so

```text
n = x f_X + y f_Y  in A.                            (E.8)
```

Characteristic zero and `n>0` imply that `n` is a nonzero element of the
field `K`, hence its image in every `K`-algebra is a unit (with inverse the
image of `n^(-1)`).  Equation (E.8) therefore shows

```text
(f_X,f_Y)A = A.                                     (E.9)
```

This is stronger than pointwise nonvanishing: it is a single global Bezout
certificate in the coordinate ring.

For completeness, (E.9) also yields the affine smoothness statement without
mistaking the two-generator ideal for one globally invertible derivative.
The two basic opens `D(f_X)` and `D(f_Y)` cover `Spec A`.  On `D(f_i)`, use
the naive one-relation presentation of `A` and select the `i`-th variable as
its Jacobian column.  Its `1 x 1` Jacobian is `f_i`, which is a unit after
localization.  Composing this presentation with the standard presentation of
the localization gives a submersive presentation of dimension

```text
(2 variables - 1 relation) +
(1 localization variable - 1 localization relation) = 1.
```

Thus both basic opens are standard smooth of relative dimension one over
`K`.  Since their defining elements generate the unit ideal, smoothness is
local on the target and `A` is a smooth `K`-algebra.  Equivalently, the affine
morphism `Spec A -> Spec K` is smooth.  This argument still does not construct
the projective compactification, prove its boundary ramification indices, or
produce a Belyi map; those remain the next GenEll steps.  ∎

### E.6 — Equivalence with the iterated tripod Kummer algebra

**Status:** mathematical proof and Lean formalization complete in
`IUTThreeClosures/ConcreteFermatTripodEquiv.lean`.

Let

```text
T = K[t,t^(-1),(1-t)^(-1)],
B_1 = T[u]/(u^n-t),
B_2 = B_1[v]/(v^n-(1-t)),
```

where the displayed quotients denote the standard étale Kummer
presentations used in E.0, and let

```text
A_open = (K[X,Y]/(X^n+Y^n-1))[X^(-1),Y^(-1)]
```

be the honest open Fermat ring from E.3.  There are explicit homomorphisms

```text
Phi : A_open -> B_2,       X |-> u,       Y |-> v,
Psi : B_2 -> A_open,       t |-> X^n,     u |-> X,     v |-> Y.   (E.10)
```

The map `Phi` exists because `u^n+v^n=t+(1-t)=1`, and because `u` and `v`
are units in the two Kummer algebras, so the open boundary denominator maps
to a unit.  The map `Psi` exists in three universal-property steps.  First,
`t |-> X^n` extends from `K[t]` to `T`, since `X^n(1-X^n)=X^nY^n` is a unit
in `A_open`.  Second, `u |-> X` respects `u^n=t`; third, `v |-> Y` respects
`v^n=1-t`.

We prove the inverse laws only from these generator formulas.  For
`Psi ∘ Phi`, both `X` and `Y` are fixed.  The `AdjoinRoot` universal property
therefore identifies the composite with the identity before localization,
and the localization extensionality theorem identifies them on `A_open`.

For `Phi ∘ Psi`, first restrict to `T`.  The distinguished coordinate is
sent as

```text
t |-> X^n |-> u^n = t.
```

The maps also agree on `K`, so polynomial extensionality followed by
localization extensionality makes the restriction the identity on `T`.
Next, the two maps on `B_1` agree on `T` and both fix the standard Kummer
generator `u`; the `StandardEtalePair.hom_ext` theorem makes them equal on
`B_1`.  Finally, the two maps on `B_2` agree on `B_1` and both fix `v`, so a
second application of the same extensionality theorem makes the composite
the identity on `B_2`.

Thus `Phi` and `Psi` define an explicit ring equivalence

```text
A_open ≃ₐ[K] B_2.                                             (E.11)
```

Every construction in (E.10) uses the original coefficient maps from `K`,
so (E.11) is naturally a `K`-algebra equivalence as well.  There is a further
base-compatibility statement which is needed to transport the covering
properties themselves.  Give `A_open` its `T`-algebra structure through

```text
alpha : T -> A_open,             t |-> X^n,
```

and give `B_2` the composite `T`-algebra structure from its two Kummer
extensions.  Then `Phi ∘ alpha` is the canonical map `T -> B_2`.  Indeed,
`T` is the localization of `K[t]` away from `t(1-t)`, so localization
extensionality reduces the assertion to `K[t]`.  The two maps agree on
coefficients, and on the polynomial generator one has

```text
Phi(alpha(t)) = Phi(X^n) = u^n = t.
```

Polynomial extensionality and then localization extensionality prove the
claim on all of `T`; no compatibility equation is added as a data field.
Consequently (E.11) bundles more strongly as an equivalence of `T`-algebras

```text
A_open ≃ₐ[T] B_2.                                      (E.11a)
```

The two-stage Kummer construction already proves that `B_2/T` is finite
étale of rank `n^2`.  Étaleness is invariant under algebra equivalence,
finite generation transports along the underlying `T`-linear equivalence,
and `finrank` is preserved by that same linear equivalence.  Hence, for the
honest base map `t |-> X^n`, the open Fermat ring itself is a finite étale
`T`-algebra of exact rank `n^2`.

This identifies the integral open Fermat model with the previously
constructed two-stage tripod Kummer cover over the correct covering base.
It still does not add the missing points at infinity, construct the normal
projective compactification, calculate boundary ramification, or produce a
Belyi map.  ∎

### E.7 — Fermat power map away from the three branch values

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/ConcreteFermatBelyiRamification.lean`.

On the homogeneous Fermat curve

```text
X^n + Y^n = Z^n
```

consider the coordinate pair `β=[X^n:Z^n]`.  It is defined at every nonzero
Fermat triple: if both displayed coordinates vanished, positivity of `n`
would give `X=Z=0`, and the Fermat equation would then give `Y=0`.

The three distinguished fibres have exact coordinate descriptions.  Over
`0` one has `X=0` and `Y^n=Z^n`; over `1` one has `Y=0` and `X^n=Z^n`; over
`∞` one has `Z=0` and `X^n+Y^n=0`.  Consequently their complement is exactly
the locus `XYZ≠0`.  On the chart `Z≠0`, with `x=X/Z`, `y=Y/Z`, and
`t=β=x^n`, the defining equation gives

```text
t = x^n,                 1-t = y^n.                   (E.12)
```

On the `X≠0` chart at infinity it likewise gives

```text
1/t = (Z/X)^n.                                      (E.13)
```

Over the punctured target `Spec K[t,t⁻¹,(1-t)⁻¹]`, both right-hand sides in
(E.12) are units.  In characteristic zero, `n` is a unit, and hence the two
Kummer derivatives `n x^(n-1)` and `n y^(n-1)` are units as well.  The two
explicit standard-étale Kummer presentations from E.0 therefore compose to
a finite étale algebra of exact rank `n²`.  E.6 separately identifies this
iterated Kummer ring with the honest open Fermat ring over the actual
`TripodRing` base and matches the two coordinates.  The bundled
base-compatible equivalence transports finite étaleness and exact rank
`n²` to the honest open presentation itself.

Equations (E.12)–(E.13) are the local-coordinate source of ramification
exponent `n` at the boundary.  The current Lean theorem deliberately stops
there: it does not yet construct the projective scheme or its DVR local
rings, and therefore does not promote these power identities to a theorem
that the ramification index is `n`, nor to a scheme-level Belyi covering. ∎

### E.8 — Equivalence of the two affine Fermat presentations

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/ConcreteFermatPresentationEquiv.lean`.

Let `Q=K[X,Y]/(X^n+Y^n-1)` be the bivariate Jacobian presentation from E.5
and let `A=K[X][Y]/(Y^n-(1-X^n))` be the `AdjoinRoot` presentation from E.2.
Evaluation of the two bivariate variables at the coefficient image `x` and
the adjoined root `y` in `A` kills the Fermat relation, so it factors through
a `K`-algebra map `Q→A`.  Conversely, evaluate the coefficient polynomial
variable at the image of `X` in `Q`; the quotient relation says that the
image of `Y` is a root of the resulting univariate Fermat polynomial, so the
`AdjoinRoot` universal property gives `A→Q`.

The first composite fixes the coefficient variable and the adjoined root;
the second fixes both bivariate generators.  `AdjoinRoot` and quotient
extensionality therefore prove that the maps are inverse, giving an explicit

```text
Q ≃ₐ[K] A.                                             (E.14)
```

The standard-smooth proof of E.5 transports across (E.14), so the actual
`AdjoinRoot` Fermat ring is smooth over `K`.  Smoothness is preserved by the
Away localization at `x(1-x^n)`, hence the honest open Fermat ring of E.3 is
smooth as well.  These are affine algebra theorems; no projective or
ramification claim is being inferred from them. ∎

### E.9 — A local power law determines the ramification index

**Status:** mathematical proof complete and target-compiled in the independent
module `IUTThreeClosures/LocalPowerRamificationIndex.lean`.

Let `R -> S` be a local homomorphism of discrete valuation rings, with
maximal ideals `m_R` and `m_S`.  Let `t` be a uniformizer of `R`, let `x` be
a uniformizer of `S`, and suppose that for a unit `u` of `S` and a positive
integer `n` one has

```text
phi(t) = u x^n.                                      (E.15)
```

In the DVR convention used by Mathlib, a uniformizer is an irreducible
element.  Therefore `m_R=(t)` and `m_S=(x)`.  Extending the first equality to
`S` and applying (E.15) gives

```text
m_R S = (phi(t)) = (u x^n) = (x^n) = m_S^n.          (E.16)
```

The third equality uses only that `u` is a unit, and the last is the standard
identity `(x^n)=(x)^n`.  In particular, if `v_S` denotes the normalized
additive DVR valuation, then

```text
v_S(phi(t)) = v_S(u) + v_S(x^n) = 0 + n = n.         (E.17)
```

The powers of the maximal ideal of a DVR are strictly decreasing: otherwise
`m_S^n=m_S^(n+1)`, while their colengths are respectively `n` and `n+1`.
Thus (E.16) says that the largest exponent `e` for which
`m_R S <= m_S^e` is exactly `n`.  This is the classical ideal-factorization
definition of the ramification index.  Since a DVR is a Dedekind domain and
the homomorphism is local, `m_S` lies over `m_R`; the standard comparison
with the localized length definition therefore yields

```text
ramificationIdx(m_S / R) = n.                        (E.18)
```

This proposition closes the *generic local algebra implication* suggested
by the power identities (E.12)--(E.13).  It does not yet construct the
projective Fermat curve's local DVRs, prove that their chart coordinates are
uniformizers, or instantiate (E.15) at all points over `0`, `1`, and
`infinity`.  Consequently it is not yet a boundary-ramification theorem for
the Fermat/Belyi map. ∎

### E.10 — The projective Fermat scheme and its coordinate charts

**Status:** mathematical proof complete and target-compiled in the independent
module `IUTThreeClosures/ConcreteProjectiveFermatScheme.lean`.

Let `P=K[X_0,X_1,X_2]` with its total-degree grading, let
`F_n=X_0^n+X_1^n-X_2^n`, and put `A_n=P/(F_n)`.  The relation is homogeneous
of degree `n`, hence its principal ideal is homogeneous.  Give `A_n` the
degree pieces

```text
(A_n)_d = q(P_d),
```

where `q:P→A_n` is the quotient map.  Products have the expected degree, and
the pieces span: decompose any polynomial representative into its finitely
many homogeneous components and apply `q`.

The sum is direct.  If homogeneous `p_d∈P_d` satisfy
`Σ_d q(p_d)=0`, then `Σ_d p_d` lies in `(F_n)`.  Homogeneity of this ideal
implies that every homogeneous component lies in it; the degree-`i`
component is precisely `p_i`.  Thus every `q(p_i)=0`.  This constructs a
genuine quotient grading and therefore the actual scheme

```text
C_n = Proj(A_n).
```

If `x_i=q(X_i)`, then each `x_i` has degree one, and the three elements
generate `A_n` over `(A_n)_0` by polynomial induction.  The Proj covering
theorem gives

```text
D_+(x_0) ∪ D_+(x_1) ∪ D_+(x_2) = C_n.               (E.19)
```

For every `i`, homogeneous localization gives the canonical affine-chart
isomorphism and open immersion

```text
C_n|D_+(x_i) ≅ Spec((A_n)_(x_i)),                    (E.20)
Spec((A_n)_(x_i)) → C_n,
```

whose image is exactly `D_+(x_i)`.  On the chart `x_2≠0`, the degree-zero
ratios `u=x_0/x_2` and `v=x_1/x_2` satisfy

```text
u^n + v^n = 1,                                       (E.21)
```

because `x_0^n+x_1^n=x_2^n` in `A_n` and the two fractions have common
denominator `x_2^n`.

This is a genuine scheme and genuine affine-open cover.  It does not yet
prove that the induced map from `K[u,v]/(u^n+v^n-1)` to the chart ring is an
isomorphism, transport E.5 to a scheme-level `Smooth` morphism, identify the
boundary local rings as DVRs, or finish Belyi ramification.  Pointwise
Jacobian nonsingularity is not used as a substitute for any of those steps.
∎

### E.11 — The `X_2 \ne 0` chart is the affine Fermat hypersurface

**Status:** mathematical proof complete and target-compiled in
`IUTThreeClosures/ConcreteProjectiveFermatChartEquiv.lean`.

Keep the notation of E.10, put `z=x_2`, and write

```text
Q_n = K[u,v]/(u^n+v^n-1),       B_n = (A_n)_(z).
```

Here `B_n` is the degree-zero subring of the ordinary localization of `A_n`
at the powers of `z`.  Equation (E.21) gives a `K`-algebra map

```text
α : Q_n → B_n,              u ↦ x_0/z,   v ↦ x_1/z.       (E.22)
```

For the reverse map, evaluate the three homogeneous coordinates at
`(u,v,1)`.  The relation `F_n` maps to `u^n+v^n-1=0`, so evaluation factors
through `A_n`.  Since `z` maps to `1`, the universal property of ordinary
localization extends this map to `A_n[z⁻¹]`; restricting it to its
degree-zero subring gives

```text
β : B_n → Q_n.                                                    (E.23)
```

The composite `βα` fixes `u` and `v`, hence is the identity on the
two-variable quotient.  Conversely, the degree-zero homogeneous
localization is generated as a `K`-algebra by `x_0/z` and `x_1/z`.  Indeed,
the homogeneous coordinate ring is generated in degree one by
`x_0,x_1,x_2`; the homogeneous-Away generation theorem expresses every
degree-zero fraction as a polynomial in the ratios `x_i/z`, and `x_2/z=1`.
The composite `αβ` fixes the first two ratios, so it is the identity on
`B_n`.  Therefore

```text
Q_n ≃ₐ[K] B_n.                                                     (E.24)
```

For `char(K)=0` and `n>0`, E.5 proves that `Q_n` is smooth over `K`.
Smoothness is invariant under a `K`-algebra equivalence, hence (E.24)
transports this certificate to the actual homogeneous chart ring `B_n`.
This result is strictly affine-coordinate-ring level.  It neither infers
normality or properness nor identifies boundary local rings as DVRs.  A
scheme-level smoothness claim additionally requires the relevant affine
scheme morphism/locality interface and is not obtained merely from the
pointwise Jacobian calculation. ∎
