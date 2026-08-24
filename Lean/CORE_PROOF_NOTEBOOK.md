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

**Status:** proved on paper as an abstract group statement; Lean formalization
pending.

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

### B.4 — Exact remaining geometric statement

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
formula (A.1), product/log formula (A.2), and normalized p-preimage formulas
(A.3)--(A.4) remain paper proofs pending the corresponding Mathlib local-field
API.

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
storing it as `componentFormula`.  Its next concrete stages are:

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
