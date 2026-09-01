# Arithmetic limits of two concrete exceptional-set amplifiers

Author: ChatGPT. Date: 2026-08-30.

This continuation studies actual descendants of a primitive positive seed
`a+b=c`. It does not prove or disprove abc. The two constructions below are
different: the first inherits prescribed prime powers through linear
congruences; the second forces additional squares by parametrizing a rational
conic. Their elementary radical certificates admit too few distinct outputs
to contradict the current exceptional-set estimates. Outputs whose new
factors have additional arithmetic structure remain outside these exclusions.

The mathematical proofs were completed before creating the companion Lean
module. The full conic lattice count below is a paper proof; the precise Lean
coverage is recorded at the end. No claim of priority over the existing
literature is made for these elementary counting arguments.

## 1. Current counting target and what was already known in this repository

For `0<mu<1`, let `N_mu(T)` count ordered positive primitive triples
`A+B=C<=T` with `rad(ABC)<C^mu`. Bernert, Browning, Lichtman and Teräväinen,
arXiv:2410.12234v2, Proposition 1.1 and Theorems 1.2--1.3, give

\[
 N_\mu(T)\ll_{\mu,\delta}T^{F(\mu)+\delta},\qquad
 F(\mu)=\min\left\{\frac{2\mu}{3},
                    \frac{23\mu+3}{40},\frac35\right\},\quad\delta>0.
 \tag{1.1}
\]

The v2 arXiv header is dated 9 May 2026; the rendered document also displays
24 August 2026 as its internal date. These must not be mistaken for two
different theorem versions. The counting variable is the height of the
**output** triple, and all the inequalities are upper bounds, not pointwise
estimates or lower bounds for an amplification fibre.

A seed of height `c` would yield a contradiction from this method if it
forced at least `c^alpha` distinct `mu`-exceptions of height at most `c^K`,
with fixed positive constants `K,alpha` and `alpha>K F(mu)`. The implied
constants must be independent of the seed. For a contradiction from a
single seed no overlap bound between different source seeds is needed;
distinctness inside that one seed's fibre is still essential.

The following existing repository results were read and are not repeated
as new progress:

* `research/POWER_DIFFERENCE_LIFTS.md`: the power-difference lift is an
  injective quality transfer for each fixed degree, but only boundedly many
  degrees fit below one fixed polynomial height of a given seed.
* `research/BELYI_AMPLIFICATION_RIEMANN_HURWITZ_BARRIER.md`: a degree `d`
  rational map has at least `d+2` geometric preimages of the three boundary
  points; no degree greater than one preserves just the original tripod.
* `Lean/GLOBAL_ABC_PT_ALMOST_ALL_AMPLIFICATION_AUDIT.md`: the existing
  Pythagorean transfer does not beat the exceptional-set counting exponent.
* `research/ANALYTIC_ROUTE_SESSION_2026_08_30.md`: the low-omega moment
  counterargument does not rule out a sufficiently sparse unbounded set.

The new work here gives seed-dependent counts for **all inherited CRT
templates**, and for **all square-completion descendants on a conic**.

## 2. First construction: CRT thickening of inherited prime powers

Fix pairwise coprime positive integers `U,V,W`, and write

\[
 M=UVW,\qquad R_M=\operatorname{rad}(M).
\]

The proposed output family consists of positive primitive triples satisfying

\[
 U\mid A,\quad V\mid B,\quad W\mid C,\qquad A+B=C\le T.
 \tag{2.1}
\]

Writing `A=Uu`, `B=Vv`, `C=Ww` gives the valid radical upper bound

\[
 \operatorname{rad}(ABC)
 \le R_Muvw=\frac{R_MABC}{M}.
 \tag{2.2}
\]

This is a concrete way to preserve large valuations from the source and
vary the remaining coordinates by CRT. Its limitation concerns outputs
certified solely by (2.2):

\[
 \frac{R_MABC}{M}\le C^\mu,\qquad 0<\mu\le1.
 \tag{2.3}
\]

Using a strict certificate only makes the following set smaller.

### Theorem 2.1. At most one certified primitive output per dyadic strip

Assume `M>=2`. Among outputs satisfying (2.1)--(2.3), at most one has

\[
 L\le A<2L
 \tag{2.4}
\]

for any fixed positive real `L`.

#### Proof

Since `C>=1` and `mu<=1`, (2.3) implies `R_M AB<=M`. Also `R_M>=2`, so

\[
 AB\le M/R_M\le M/2.
 \tag{2.5}
\]

For two outputs, put `Delta=AB'-A'B`. The integer `UV` divides `Delta`.
Moreover

\[
 \Delta=A C'-A'C,
\]

so `W` divides it. Pairwise coprimality gives `M|Delta`.

Under (2.4),

\[
 AB'<2L\frac{M}{R_M L}=\frac{2M}{R_M}\le M,
 \qquad
 A'B<\frac{2M}{R_M}\le M.
\]

Both products are positive, and therefore `|Delta|<M`. The strict right
endpoint in (2.4) deals with `R_M=2` as well. Consequently `Delta=0`.

Finally two positive primitive pairs with `AB'=A'B` are identical: Euclid's
lemma gives `A|A'` and `A'|A`, using respectively `gcd(A,B)=1` and
`gcd(A',B')=1`; hence `A=A'`, then `B=B'` and `C=C'`. This proves
uniqueness. No lower bound on the number of CRT points was substituted for
a lower bound on distinct primitive outputs. QED.

### Corollary 2.2. Logarithmic fibre bound, including boundary cases

For `T>=1`, the number of outputs certified by (2.3) is at most

\[
 1+\lfloor\log_2 T\rfloor.
 \tag{2.6}
\]

Indeed every positive integer `A<=T` belongs to exactly one of the strips
`2^j<=A<2^(j+1)` for `0<=j<=floor(log_2 T)`. If `T<1`, there are no
positive outputs at all. If `M=1`, the certificate says `ABC<=C^mu<=C`,
so `AB<=1`; the only possible positive primitive output is `(1,1,2)`.
For `mu<1` even that output fails the certificate. Thus (2.6) holds for
`M=1` as well whenever `T>=1`.

### Corollary 2.3. All inherited templates still give only subpower growth

Fix a positive primitive seed `a+b=c`, and allow **every** choice

\[
 U\mid a,\quad V\mid b,\quad W\mid c.
\]

The union of all distinct certified outputs of height at most `T>=1`
has size at most

\[
 \tau(abc)\bigl(1+\lfloor\log_2 T\rfloor\bigr).
 \tag{2.7}
\]

#### Proof

The number of templates is exactly `tau(a)tau(b)tau(c)=tau(abc)`, since
the source coordinates are pairwise coprime. Apply (2.6) and the union
bound; repeated outputs among templates reduce the union's size.

For completeness, the elementary divisor bound `tau(n)<<_eta n^eta`
follows as follows. For primes `p>=2^(1/eta)`, `e+1<=2^e<=p^(eta e)`.
There are only finitely many smaller primes, and each has a finite maximum
of `(e+1)/p^(eta e)` over `e>=0`. Multiplying those finitely many maxima
proves the bound uniformly in `n`.

Since `abc<=c^3`, for every fixed `K>0` and every fixed `epsilon>0`, (2.7)
with `T<=c^K` is `O_(epsilon,K)(c^epsilon)`. This statement does not claim
uniformity when `K` grows with the seed. Permuting the allocation of source
coordinates to output coordinates changes the bound by at most six. QED.

This rules out a polynomial amplifier using inherited divisibility and
the remaining factors' sizes alone. It does **not** show that the actual
radical of every other CRT output is large: additional arithmetic in the
cofactors can beat (2.2). The following strengthening also treats arbitrary
increases of the inherited exponents.

### Corollary 2.4. Arbitrary powers from the old support do not evade the bound

Let `S` be the prime support of `abc`. Allow every pairwise coprime template
`U,V,W` supported on `S`, without requiring `U|a,V|b,W|c`, and retain the
certificate (2.3). For every fixed `K>0`, all such distinct outputs of
height `T<=c^K` still number `c^{o(1)}`. The `o(1)` is uniform over the
primitive seeds of height `c`.

#### Proof

For a finite set `S` of `r` distinct primes define
`Psi_S(Z)=#{1<=n<=Z : every prime divisor of n belongs to S}`. Fix
`0<delta<1` and `Z>=1`. We may assume `T>=1`, since smaller heights give
an empty output set. A finite Euler product of convergent geometric
series gives

\[
 \Psi_S(Z)\le Z^\delta\sum_{n\text{ supported on }S}n^{-\delta}
 =Z^\delta\prod_{p\in S}(1-p^{-\delta})^{-1}.
 \tag{2.8}
\]

Order the primes as `p_1<...<p_r`; then `p_j>=j+1`. The elementary
inequality `-log(1-t)<=t/(1-t)` and a decreasing-function integral bound
give

\[
 \log\prod_{p\in S}(1-p^{-\delta})^{-1}
 \le\frac{1}{1-2^{-\delta}}\sum_{j=1}^r(j+1)^{-\delta}
 \le C_\delta(r+1)^{1-\delta},\qquad
 C_\delta=\frac{1}{(1-\delta)(1-2^{-\delta})}.
 \tag{2.9}
\]

For the seed support, `r log 2<=log rad(abc)<=3 log c`. Every nonempty
template has `U,V,W<=T`, because each divides a positive output coordinate
at most `T`. Thus, even ignoring coprimality and allowing every allocation
of prime powers, there are at most `Psi_S(T)^3` templates. Corollary 2.2
bounds the union of their outputs by

\[
 (1+\lfloor\log_2 T\rfloor)
 T^{3\delta}\exp\left(3C_\delta(r+1)^{1-\delta}\right).
 \tag{2.10}
\]

For fixed `K,delta` and `T<=c^K`, the logarithm of (2.10) is at most
`3K delta log c+O_delta((log c)^(1-delta))+O_K(log log c)`. Given any
fixed `epsilon>0`, choose a fixed `delta<min(1,epsilon/(6K))`, and then
let `c` grow. This proves an `O_(epsilon,K)(c^epsilon)` bound with
constants independent of the seed. No exponent or Euler-product
parameter is allowed to vary silently inside its implied constants.

The same proof applies to any prime pool fixed for each seed whose
cardinality is `O(log c)` with a uniform implied constant, even if the
pool contains primes not in the original seed. It does not cover an
unrestricted choice among many different prime pools. QED.

The existing `Lean/SUNIT_ANCHORED_DESCENT_BARRIER.md`, Section 7, and
`Lean/GLOBAL_ABC_PELL_TRIPOD_FINITE_ORBIT_AUDIT.md`, Section 8.2, already
record stronger established S-unit bounds when the **entire output** is
supported in `S`. No new S-unit theorem is claimed here. Corollary 2.4
instead restricts only the primes in the **certificate moduli**: the
remaining factors of `A,B,C` may introduce arbitrary new primes. That
larger candidate class is controlled by combining (2.8) with the CRT
determinant argument, not by assuming the output is an S-unit triple.

## 3. Second construction: new squares from a rational conic

This construction forces extra powers instead of treating every cofactor
as an arbitrary integer. Put `P=abc` and `R=rad(P)`. Positive integer points
on

\[
 a x^2+b y^2=c z^2
 \tag{3.1}
\]

produce the candidate triples

\[
 (A,B,C)=(a x^2,b y^2,c z^2).
 \tag{3.2}
\]

Only outputs with `gcd(A,B)=1` are retained. This guarantees pairwise
coprimality of the output, and implies `gcd(x,y,z)=1`. Taking positive
square roots makes (3.2) injective as a map from positive `(x,y,z)`.
There is no assumption that an arbitrary parameter automatically gives a
primitive output.

The retained outputs satisfy the genuine square-based bound

\[
 \operatorname{rad}(ABC)\le Rxyz.
 \tag{3.3}
\]

This is stronger than the first construction's cofactor-size certificate,
which would use `R x^2 y^2 z^2`. We try to exploit the two rational
parameters of (3.1) before identifying their common projective scaling.

### Lemma 3.1. Exact parametrization and denominator control

For coprime integers `m,n`, not both zero, put

\[
 Q=a n^2+b m^2>0,\quad L=an+bm,\quad
 X=Q-2nL,\quad Y=Q-2mL,
\]

and

\[
 G=\gcd(X,Y,Q),\qquad
 D=\gcd(a,m)\gcd(b,n)\gcd(c,m-n).
\]

Gcds are positive gcds and signs in their arguments do not matter. Then

\[
 aX^2+bY^2=cQ^2,\qquad
 G=\gcd(Q,2L),\qquad
 \gcd(Q,L)=D,\qquad D\mid G\mid2D.
 \tag{3.4}
\]

Every positive primitive solution of (3.1) occurs as
`(X/G,Y/G,Q/G)` for some such pair, with the signs chosen so that
`X,Y>0`. Allowing absolute values only overcounts outputs. Simultaneously
changing `(m,n)` to `(-m,-n)` has no effect; choose one representative on
each such pair of rays. With signed coordinates the parameter direction
is unique. If absolute values are used, each positive output has at most
four parameter directions, one for each of the possible signs of `X,Y`.
The counting proof only needs surjectivity and remains valid without
dividing by this possible multiplicity.

#### Proof

Expand the first identity, using `a+b=c`. Since `gcd(m,n)=1`, the common
divisors of `Q,2nL,2mL` are exactly those of `Q,2L`. This proves the
formula for `G`.

Here is a complete local verification of the gcd identity in (3.4). Adopt
the harmless convention `v_p(0)=infinity` during this verification.
If a prime `p` divides `Q` and `L`, the identities

\[
 aQ=L^2-2bmL+bc m^2,\qquad
 bQ=L^2-2anL+ac n^2
 \tag{3.5}
\]

show that `p|abc`: otherwise both `m` and `n` would be divisible by `p`.

If `p|a`, write `e=v_p(a)` and `r=v_p(m)`. When `r=0`, `Q` is a unit
modulo `p`. When `r>0`, `n,b` are units. If `r<e`, then `v_p(L)=r` and
`v_p(Q)>=r`; if `r>e`, both valuations have minimum `e`; if `r=e`,
`v_p(Q)=e` and `v_p(L)>=e`. Thus the valuation of `gcd(Q,L)` is
`min(e,r)`. The case `p|b` gives `min(v_p(b),v_p(n))` in the same way.

If `p|c`, write `e=v_p(c)` and `r=v_p(n-m)`. For `r=0`, either one
coordinate is divisible by `p` and `Q` is a unit, or both are units and
`L=a(n-m)+cm` is a unit. For `r>0`, both coordinates are units. If
`r<e`, `v_p(L)=r` and `v_p(Q)>=r`. If `r>e`, the valuation of `Q` is
`e`, as is that of `L`. For `r=e`, use

\[
 Q=2mL-cm^2+a(n-m)^2.
 \tag{3.6}
\]

If `v_p(L)=e`, the common valuation is `e`; if `v_p(L)>e`, the middle
term of (3.6) has exact valuation `e` and the other terms have larger
valuation, again giving common valuation `e`. This proof also applies to
`p=2`; no division by two was used. The three cases establish
`gcd(Q,L)=D`. The elementary inclusion
`gcd(Q,L)|gcd(Q,2L)|2 gcd(Q,L)` completes (3.4).

For surjectivity, intersect (3.1) in projective space with a line through
the known point `(1,1,1)`. In the affine chart `z=1`, write that line as
`(1,1)+t(n,m)`. Its two intersection parameters solve
`t(2L+tQ)=0`; the second intersection is precisely `(X/Q,Y/Q)`.
Every rational point other than `(1,1)` determines a rational direction,
which can be represented by coprime integers `(m,n)`. The known point
itself is represented by the tangent direction `(m,n)=(-a,b)`:
`L=0`, `Q=abc`, and `X=Y=Q`. Reducing the three homogeneous coordinates
by their gcd gives every primitive integer point. QED.

### Lemma 3.2. Primitive lattice directions in an ellipse

Let `Lambda` be a rank-two sublattice of `Z^2` of index `D`, and let `E`
be a centred ellipse of area `V`. Choose at most one sign representative
of each primitive integer vector in `Lambda intersect E`. Their number
is at most

\[
 1+2V/D.
 \tag{3.7}
\]

#### Proof

The lattice and ellipse are centrally symmetric, so representatives may
be reselected in the common half-plane `m>0` together with its boundary
ray `m=0,n>0`, without changing their number. If all lie on one line,
there is at most one representative. Otherwise order them by angle; all
successive angular gaps are strictly less than pi. A positive ray
contains only one primitive integer vector.
For consecutive vectors, the determinant is a nonzero multiple of `D`,
so their triangle with the origin has area at least `D/2`. The triangles
have disjoint interiors and lie in `E`, which is convex. If there are `q`
vectors, this gives `(q-1)D/2<=V`. The cases `q=0,1` already satisfy the
bound. QED.

### Theorem 3.3. Uniform count of the actual square-completion fibre

For every `T>0`, the number of distinct positive primitive outputs (3.2)
with `C<=T` is at most

\[
 \boxed{\tau(P)\left(1+4\pi\sqrt{T/P}\right).}
 \tag{3.8}
\]

#### Proof

Every output has a parametrization from Lemma 3.1. Fix the three divisors

\[
 d_a=\gcd(a,m),\quad d_b=\gcd(b,n),\quad d_c=\gcd(c,m-n),
 \qquad D=d_a d_b d_c.
\]

The parameter vector belongs to the lattice

\[
 d_a\mid m,\quad d_b\mid n,\quad d_c\mid m-n.
 \tag{3.9}
\]

This lattice has index `D`. Indeed the first two conditions have index
`d_a d_b`, and the third residue map onto `Z/d_c Z` is surjective on that
lattice because `d_a,d_b,d_c` are pairwise coprime.

The output height gives

\[
 c(Q/G)^2\le T,\qquad
 a n^2+b m^2=Q\le2D\sqrt{T/c}.
 \tag{3.10}
\]

The latter ellipse has area

\[
 V=\frac{2\pi D\sqrt{T/c}}{\sqrt{ab}}
   =2\pi D\sqrt{T/P}.
\]

Lemma 3.2 bounds its primitive parameter directions by
`1+4 pi sqrt(T/P)`. There are `tau(a)tau(b)tau(c)=tau(P)` possible
divisor triples. Every output is covered; parameter collisions and
outputs failing primitivity can only reduce the count. This proves
(3.8), with an absolute constant independent of the seed and of `T`.
If `T<c`, the output set is empty, and the stated bound remains valid.
QED.

### Theorem 3.4. Square-certified exceptional descendants are too sparse

Fix `0<mu<1`. Retain only outputs satisfying the stronger explicit
certificate

\[
 Rxyz\le C^\mu,\qquad C=c z^2\le T.
 \tag{3.11}
\]

Then the number of such distinct primitive outputs is at most

\[
 \boxed{\tau(P)\left(1+\frac{4\pi}{\sqrt c}\,T^{\mu/2}\right).}
 \tag{3.12}
\]

#### Proof

Equation (3.1) says that `z^2` is a positive weighted average of `x^2`
and `y^2`. Hence `max(x,y)>=z`. Since the other coordinate is at least
one, `xyz>=z^2`. Therefore (3.11) implies

\[
 RC/c=Rz^2\le Rxyz\le C^\mu,
 \qquad C^{1-\mu}\le c/R.
 \tag{3.13}
\]

Let `T_0=(c/R)^(1/(1-mu))`. If the certified family is nonempty, then
`T_0>=c>=2`; otherwise there is nothing to prove. Apply (3.8) with
`U=min(T,T_0)`, so `U^(1-mu)<=c/R`. This gives

\[
 \sqrt{U/P}
 =U^{\mu/2}\sqrt{U^{1-\mu}/P}
 \le U^{\mu/2}\sqrt{c/(RP)}
 \le\frac{T^{\mu/2}}{\sqrt c}.
 \tag{3.14}
\]

For the last inequality, positive integers `a+b=c` satisfy
`ab>=c-1>=c/2`, and `R>=2`, so `RP>=c^2`. Substitute (3.14) into
(3.8). QED.

For fixed `K>0` and `T=c^K`, (3.12) is

\[
 O_\epsilon\left(c^\epsilon+
 c^{K\mu/2-1/2+\epsilon}\right)
 =c^{\max\{0,K\mu/2-1/2\}+o(1)}.
 \tag{3.15}
\]

Every entry in the minimum defining `F(mu)` is strictly greater than
`mu/2` for `0<mu<1`. Thus

\[
 \max\{0,K\mu/2-1/2\}<K F(\mu).
 \tag{3.16}
\]

Even the entire size of this square-certified family is below the exponent
needed to contradict (1.1). This compares **upper bounds on the candidate
fibre** with the required amplification size; it is not an assertion that
BBLT gives a lower bound for the full exceptional set.

### Exact limitation of this second exclusion

The bound (3.12) concerns the certificate `Rxyz`, not every actual
exception on the conic. For example the seed `(1,8,9)` has `R=6`, and
the positive point `(x,y,z)=(7,2,3)` gives

\[
 (49,32,81),\qquad \operatorname{rad}(49\cdot32\cdot81)=42,
 \qquad Rxyz=252.
\]

This is an actual exception at, for instance, `mu=9/10`: `42<81^(9/10)`.
One exact verification is `42^2=1764<2187=3^7`, which gives
`42<3^(7/2)<3^(18/5)=81^(9/10)`. The square certificate fails even
at exponent one. Factors `2` and `3` already occur in the seed's support,
and `Rxyz` overcounts them. This finite example refutes any attempt to
identify the certified family with all exceptional descendants. It is
not a counterexample to abc, which concerns finiteness at each fixed
exponent below one.

## 4. What remains active

The two explicit constructions do not provide a uniform abc step. Their
proved limitations identify the additional arithmetic a successful
amplifier would have to use:

* CRT outputs can have exceptionally small cofactor radicals, or introduce
  sufficiently many varying new prime choices. Merely upgrading exponents
  inside the inherited support, or another fixed pool of `O(log c)`
  primes, is already covered by Corollary 2.4 at fixed polynomial height.
* Square completions can reuse the original prime support or force new
  powers in `x,y,z`; Theorem 3.4 deliberately does not bound these by their
  actual radical. The example above shows this is a real distinction.
* Variable-degree maps, other power patterns, correspondences, and
  combinations of several independent seeds are not excluded here.
* A sparse unbounded family with one fixed radical exponent remains a
  possible disproof route. No such family has been constructed in this
  session, and no finite numerical example is asserted to be one.

There is no imported `ABCConjecture`, exceptional-density, conic-point
count, or analytic estimate serving as an axiom in the Lean work.

## 5. Primary source and formalization boundary

The current external counting input was checked in the original text:

C. Bernert, T. Browning, J. D. Lichtman, J. Teräväinen,
*Bounds on the exceptional set in the abc conjecture*,
[arXiv:2410.12234v2](https://arxiv.org/html/2410.12234v2),
Proposition 1.1 and Theorems 1.2--1.3. The local original PDF is
`research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`;
the earlier source manifest records its provenance.

The companion `Lean/IUTThreeClosures/AnalyticAmplificationContinuation20260830.lean`
contains the following completed finite arithmetic proofs:

* `inherited_radical_bound` and `inherited_cofactor_certificate_budget`:
  the actual natural-number radical bound and its connection to the CRT
  pair budget;
* `crt_cross_modEq`, `crt_certificate_unique_in_strip`, and
  `crt_certificate_eq_of_log_eq`: the three-modulus determinant argument,
  primitive uniqueness, and injective dyadic index, including modulus one;
* `crt_certificate_packet_card_le` and `crtCertifiedUpTo_card_le`: the
  exact logarithmic cardinal bound for arbitrary finite packets and for
  the concrete set of all positive certified output pairs;
* `inherited_template_union_card_le`: the full finite union over actual
  divisors of `a,b,c`, with bound equal to the product of the three divisor
  counts times the logarithmic factor;
* `square_completion_radical_bound` and
  `square_completion_parameter_identity`: the actual square-factor radical
  bound and the integral polynomial identity defining the conic map;
* `square_completion_sq_le_product`,
  `square_completion_certificate_height`, and
  `seed_radical_product_ge_sq`: the arithmetic inequalities underlying
  the cutoff (3.13) and the saving in (3.14);
* `half_lt_bblt_exponent`: the strict comparison with the three numerical
  BBLT exponents, without importing the BBLT theorem as an assumption.

Validation command, run from `Lean`:

```text
lake env lean IUTThreeClosures/AnalyticAmplificationContinuation20260830.lean
```

The completed module returned exit code zero. The twelve representative
`#print axioms` checks returned only `propext`, `Classical.choice`, and
`Quot.sound` (the polynomial identity only needs `propext,Quot.sound`).
There is no `sorry`, `admit`, custom axiom, or source-density axiom.

The complete geometric ellipse count, the parameter-gcd identity, the
Euler-product argument of Corollary 2.4, and the asymptotic divisor bound
remain paper proofs. In particular, Theorems 3.3--3.4 are **not** claimed
to have been formalized in full. The external theorem (1.1) is cited as
an external primary-source theorem, not inserted into Lean.
