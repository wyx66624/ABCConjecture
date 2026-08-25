# Generalized-Fermat exponent layers and the modular-method barrier

## 1. Scope and exact status

This note audits, offline and independently of IUT, the proposal to rewrite a
primitive positive solution

\[
  a+b=c,\qquad (a,b)=(b,c)=(c,a)=1,
\]

as one or several generalized-Fermat equations, attach Frey
representations, and use modularity and level lowering to obtain the uniform
abc slope.  Every unconditional claim below is elementary.  The companion
Lean module proves the finite exponent-profile identities, coefficient
budgets, permanent support, finite-modulus double counting, a strict
finite-coefficient obstruction, and an arbitrarily deep finite-modulus blind
spot.

The audit finds no proof of abc.  It does isolate the precise information
which ordinary residual level lowering retains and loses.  In particular:

* increasing the generalized-Fermat exponent does not dilute the Frey
  discriminant height;
* exponent-one primes survive every residual modulus;
* finitely many residual moduli can miss arbitrarily large exponents;
* the power-free coefficients are not drawn from a uniform finite list;
* a mixed signature `(n,n,r)` enlarges, rather than shrinks, the elementary
  coefficient budget;
* qualitative modularity and fixed-coefficient generalized-Fermat finiteness
  do not supply the missing uniform height estimate.

These are barriers to particular proof schemes, not counterexamples to abc or
to modularity.

## 2. Canonical exponent decomposition

Let

\[
  x=\prod_{p\mid x}p^{e_p},\qquad n\ge2.
\]

Define

\[
 \kappa_n(x)=\prod_{p\mid x}p^{e_p\bmod n},\qquad
 X_n(x)=\prod_{p\mid x}p^{\lfloor e_p/n\rfloor}.
\]

Then

\[
 x=\kappa_n(x)X_n(x)^n.                         \tag{2.1}
\]

Indeed, for every prime coordinate,

\[
 e_p=(e_p\bmod n)+n\lfloor e_p/n\rfloor,
\]

and multiplication gives (2.1).  The coefficient is canonically
`n`-power-free: every exponent in it is less than `n`.  Moreover

\[
 \kappa_n(x)\le \operatorname{rad}(x)^{n-1}.    \tag{2.2}
\]

This is sharp at the level of an individual integer: for a prime `p`, the
integer `p^(n-1)` has residue coefficient `p^(n-1)`.

For the abc triple, pairwise coprimality makes the prime supports of the three
terms disjoint.  With

\[
 a=A_nx^n,\quad b=B_ny^n,\quad c=C_nz^n,
\]

we obtain

\[
 A_nx^n+B_ny^n=C_nz^n,                           \tag{2.3}
\]

and, writing `R=rad(abc)`,

\[
 A_nB_nC_n\le R^{n-1}.                            \tag{2.4}
\]

Equation (2.3) is a genuine generalized-Fermat equation, but its three
coefficients vary with the original abc point.

More generally, a mixed decomposition of signature `(n,n,r)` gives

\[
 A_nx^n+B_ny^n=C_rz^r                           \tag{2.5}
\]

and the exact elementary logarithmic budget

\[
 \log(A_nB_nC_r)
 \le (n-1)\log\operatorname{rad}(ab)
       +(r-1)\log\operatorname{rad}(c).           \tag{2.6}
\]

Thus choosing large exponents does not make the variable coefficients cheap;
their worst allowed exponents grow linearly with the chosen signature.

## 3. Exact height accounting: no exponent dilution

Let `e_p=v_p(abc)` and give the coordinate `p` weight `log p`.  Put

\[
 T=\sum_{p\mid abc}e_p\log p=\log(abc),
\]

\[
 K_n=\sum_{p\mid abc}(e_p\bmod n)\log p,
 \qquad
 Q_n=\sum_{p\mid abc}\lfloor e_p/n\rfloor\log p.
\]

The division algorithm gives the exact equality

\[
 T=K_n+nQ_n.                                      \tag{3.1}
\]

For the standard Frey equation

\[
 E_{a,b}: y^2=x(x-a)(x+b),
\]

the displayed discriminant is

\[
 \Delta=16(abc)^2.
\]

Consequently

\[
 \log|\Delta|=\log16+2K_n+2nQ_n
              =\log16+2T.                        \tag{3.2}
\]

The apparent `1/n` in the extracted roots is cancelled exactly by the factor
`n` in (3.2).  This is an identity, so no choice of a larger `n` can improve
the Frey height before some genuinely new arithmetic estimate is introduced.

There is an even simpler eventual obstruction.  If

\[
 n>\max_{p\mid abc} e_p,
\]

then every quotient exponent is zero, hence

\[
 \kappa_n(abc)=abc,\qquad X_n(abc)=1.             \tag{3.3}
\]

Increasing `n` past the exponent range returns all arithmetic to the
coefficient and extracts no power at all.

## 4. What ordinary level lowering can see

At an odd prime `p|abc`, the integral Frey invariants satisfy

\[
 v_p(c_4)=0,\qquad v_p(\Delta)=2e_p.
\]

The first equality follows from the elementary coprimality of
`a^2+ab+b^2` with `abc`; thus the reduction is multiplicative and the
displayed model is minimal at `p`.  For an odd residual prime `ell`, distinct
from `p`, the exponent-divisibility part of the standard level-lowering
criterion removes `p` precisely when

\[
 \ell\mid v_p(\Delta)
 \quad\Longleftrightarrow\quad \ell\mid e_p.      \tag{4.1}
\]

Irreducibility, the place `2`, the place `ell`, and the hypotheses of a
particular level-lowering theorem must still be checked separately.  The
variable odd support predicted by (4.1), with the exceptional places `2` and
`ell` omitted, is

\[
 R_\ell=\prod_{\substack{p\mid abc,\ p\text{ odd},\ p\ne\ell\\
                          \ell\nmid e_p}}p.
                                                               \tag{4.2}
\]

This formula exposes both the power and the limitation of the method.  It can
discard primes whose exponents are multiples of `ell`, but it remembers only
one divisibility bit.  It does not remember the quotient `e_p/ell` or the
weighted local height `e_p log p`.

For the exact combinatorial audit below, it is convenient to put the
exceptional places back and use the abstract proxy

\[
 \widetilde R_n=\prod_{\substack{p\mid abc\\n\nmid e_p}}p.
                                                               \tag{4.2a}
\]

The Lean definitions and the double-counting identity refer to this abstract
proxy.  Formula (4.2) is its actual odd variable part for a residual prime.

### 4.1 The permanent exponent-one layer

Define

\[
 L_1=\prod_{e_p=1}p.                              \tag{4.3}
\]

For the abstract exponent-divisibility support proxy, before separating the
exceptional local factors, every modulus `n>=2` satisfies `n` not dividing
`1`, hence

\[
 L_1\mid \widetilde R_n.                           \tag{4.4}
\]

Thus no collection of ordinary exponent-divisibility level lowerings can
remove an exponent-one prime.  In the actual odd variable support (4.2), the
product over exponent-one primes with `p` odd and `p!=ell` divides `R_ell`;
the places `2` and `ell` remain among the separately treated exceptional
factors.  Thus `L_1` is a universal common sub-support.  If one allows the
abstract family of every integer modulus `n>=2`, it is the exact intersection:
an exponent `e>1` is removed by taking `n=e`.  Restricting to odd residual
primes may leave a strictly larger permanent layer; in particular every
power-of-two exponent survives all odd moduli.

### 4.2 Exact finite-family double counting

Let `S` be a finite set of candidate moduli and put

\[
 D_S(e)=\#\{\ell\in S:\ell\mid e\}.
\]

Then, exactly,

\[
 \sum_{\ell\in S}\log \widetilde R_\ell
 =\sum_{p\mid abc}\bigl(|S|-D_S(e_p)\bigr)\log p. \tag{4.5}
\]

Averaging therefore yields a useful level only to the extent that the chosen
moduli actually divide many weighted exponents.  There is no unconditional
pigeonhole saving: when `e_p=1`, its contribution to (4.5) is
`|S| log p`.

There is a stronger finite-modulus blind spot.  Let

\[
 M=\prod_{\ell\in S}\ell,
 \qquad e=1+tM.
\]

If every member of `S` is at least two, then

\[
 \ell\nmid e\quad\hbox{for every }\ell\in S.      \tag{4.6}
\]

The exponent `e` is arbitrarily large as `t` grows, while every selected
residual support still contains its prime coordinate.  Formula (4.6) is a
strict counterexample to any *factorization-only* lemma claiming that a fixed
finite list of residual characteristics must detect high exponents.  An
arbitrary exponent profile need not be realized by an abc equation, so this
does not rule out a theorem which uses the additive relation in an essential
way.  It does show exactly where such a theorem would have to enter.

## 5. Strict obstruction to a finite coefficient list

Fix `n>=2` and a bound `B`.  Choose a prime `p>B` and take the primitive abc
point

\[
 (a,b,c)=(1,p,p+1).                               \tag{5.1}
\]

Suppose

\[
 p=u x^n.                                         \tag{5.2}
\]

Then `x^n|p`.  Since `p` is prime, either `x^n=1` or `x^n=p`.  The second
case is impossible: a nontrivial power of exponent at least two is not prime.
Therefore `x=1` and `u=p`.  In particular, the canonical `n`-power-free
coefficient of `b` is the unbounded prime `p`.

Hence the assertion

> high-power decomposition automatically reduces primitive abc points to a
> fixed finite list of coefficient triples

is false for every fixed `n`.  The endpoint points (5.1) are usually not
high-quality abc points; therefore this result does not exclude a separate
lemma which first uses a quantitative high-quality hypothesis.  It does
exclude the unconditional finite-list step often inserted before that
analysis.

## 6. Audit of concrete modular schemes

### 6.1 Fixed generalized-Fermat signature plus finiteness

For a fixed hyperbolic signature, theorems of generalized-Fermat type may give
finiteness when the coefficients are fixed.  Here the coefficients
`(A_n,B_n,C_r)` vary with the point and are unbounded by Section 5.  A union of
finite solution sets over infinitely many coefficient triples need not be
finite, and qualitative finiteness gives no uniform dependence capable of
producing the abc slope.  This scheme is therefore retired unless a new
uniform coefficient-height theorem is supplied.

### 6.2 Increasing the exponent to dilute the conductor

The lowered support (4.2) depends on divisibility, not on the size of `ell`.
Once `ell` exceeds all exponents, no coordinate is removed.  Simultaneously,
(3.2) shows that the discriminant height is unchanged.  Thus monotone growth
of the exponent is not a conductor- or height-dilution mechanism.  This
specific scheme is strictly retired.

### 6.3 Selecting a large prime divisor of an exponent

A high weighted average of the `e_p` does not imply a large prime divisor of
one of them.  Exponents can be arbitrarily large and supported only on small
primes.  Ordinary mod-`ell` lowering detects `ell|e_p` but not the depth
`v_ell(e_p)`.  The finite-modulus construction (4.6) gives the complementary
blind residue class.  Hence a bare exponent pigeonhole does not provide the
required admissible large residual prime.

The additive equation could forbid some exponent profiles--Fermat's theorem
is the extreme case where every exponent is a common multiple--but no
quantitative theorem strong enough for abc has been obtained here.

### 6.4 Intersecting several lowered levels

For different residual primes `ell`, level lowering produces representations
in different characteristics and generally different newforms.  There is no
valid operation which replaces their separate levels by the gcd or
intersection of their supports.  The set-theoretic intersection is useful
bookkeeping, but it is not the conductor of a common characteristic-zero
representation.  Any multi-Frey proof must establish a genuine compatibility
or congruence theorem before using such an intersection.

Moreover, even the formal intersection retains `L_1`, by (4.4), and a finite
family has the blind profiles (4.6).

### 6.5 Mixed signature `(n,n,r)`

The hyperbolicity of a signature can help prove finiteness for fixed
coefficients, but it does not improve the coefficient accounting.  Formula
(2.6) is the exact worst-case budget.  Taking `n` or `r` larger merely raises
the allowed power of the corresponding radical.  No uniform abc coefficient
emerges from this bookkeeping.

### 6.6 What qualitative modularity actually yields

Under the usual hypotheses, an irreducible residual representation may be
matched to a newform of level supported on (4.2), with bounded exceptional
factors at `2` and `ell`.  This is qualitative existence.  To turn a trace
congruence at an auxiliary prime `q` into a numerical restriction, one takes
an algebraic norm.  Weil bounds then control the norm by a quantity whose
exponent is the coefficient-field degree, and that degree is controlled only
at the scale of the dimension of the newform space, roughly the level rather
than its logarithm.  Such an argument can bound the residual characteristic
in terms of the varying level; it does not bound the original height `c` or
the full weighted multiplicities `e_p log p`.

This is exactly the information lost when the conductor replaces the
discriminant.

### 6.7 Same-newform pigeonhole, product moduli, and Sturm rigidity

There is a more elaborate proposal.  For many residual primes `ell`, first
level-lower to forms `f_ell`; next pigeonhole until one characteristic-zero
newform orbit occurs for several `ell`; then multiply the congruence moduli.
If that product exceeds all possible coefficient differences through a Sturm
range, the residual congruences would force characteristic-zero equality.

Even under optimistic local compatibility assumptions, the coefficient
count is too expensive.  All lowered levels divide a fixed level with
variable part comparable to `R`.  The number of candidate Galois orbits is at
most the sum of the dimensions of the weight-two spaces over its divisor
levels.  The elementary index/dimension bounds put this on the scale

\[
 R\,\operatorname{polylog}(R),                    \tag{6.1}
\]

not on the scale `log R`.  Therefore more than this many useful residual
primes may be needed before repetition is forced.

Suppose nevertheless that the same orbit `f` occurs for a set `T` of
distinct residual primes.  At a good auxiliary prime `q`, the product
`\prod_{\ell\in T}\ell` divides the algebraic norm of
`a_q(E)-a_q(f)`, unless this difference is zero.  Weil bounds give, very
coarsely,

\[
 \left|\operatorname{Norm}(a_q(E)-a_q(f))\right|
 \le (4\sqrt q)^{[K_f:\mathbf Q]}.                \tag{6.2}
\]

One would need (6.2) to vanish throughout a common-level Sturm or effective
multiplicity-one range, itself of size about the common level up to elementary
factors.  Residual representations also give good-prime trace congruences;
they do not automatically give the bad-prime `U_p` congruences required by a
naive application of Sturm.  That is an additional local gap.

Most importantly, a product of *distinct* residual primes can at best see

\[
 \operatorname{rad}\!\left(\prod_{p\mid abc} e_p\right). \tag{6.3}
\]

It does not see `v_ell(e_p)`.  Replacing `e_p=2` by `e_p=2^k` leaves the
available distinct residual characteristic equal to `2`, however large `k`
becomes.  Thus even a successful same-form/Sturm argument first controls only
the radical of the exponent data.  It cannot recover the weighted height
`sum e_p log p`, and so it does not repair the abc coefficient.  This closes
the ordinary product-of-distinct-moduli variant while leaving the higher
`ell^k` congruence-depth problem of Section 7 open.

## 7. The smallest surviving new direction

The audit leaves one genuinely different modular direction, but not a proof:
ordinary mod-`ell` representations should be replaced by **higher congruence
depth** at the multiplicative primes.

For a Tate curve at `p != ell`, the tame extension class on
`ell^k`-torsion is sensitive to the valuation of the Tate parameter modulo
`ell^k`.  Since the Frey valuation is `2e_p`, a higher-level analogue of
(4.1) should detect

\[
 \ell^k\mid 2e_p,                                  \tag{7.1}
\]

not merely `ell|e_p`.  The minimal global open problem is then:

> **Higher-depth Frey congruence problem.**  Construct, for the actual Frey
> family, compatible level-lowered systems modulo `ell^k`, and prove a
> quantitative upper bound for the total lower-level congruence depth which
> is weighted by the removed primes `log p`.

The words “weighted by `log p`” are essential.  A bound only on `k`, on
`ell^k`, or on the number of removed primes does not recover
`sum e_p log p`.  Likewise, separate forms modulo different powers cannot be
combined without a proved compatibility theorem.

This proposal survives the elementary counterexamples because it tries to
recover the quotient information discarded by ordinary residual lowering.
It remains a difficult new modular-height statement, plausibly expressible
through higher congruence ideals, deformation rings, or integral modular
degrees.  Nothing in this note proves it, and any formulation whose
conclusion directly contains the abc height inequality would merely rename
the target.

An alternative surviving input is a relation-specific theorem controlling
the permanent layer `L_1` together with all smooth exponent depths.  Pure
factorization cannot prove such a theorem; it must use `a+b=c` or geometry in
an essential way.

## 8. Formalization boundary

The companion module
`IUTThreeClosures/GeneralizedFermatExponentLayers.lean` proves:

1. the finite-profile product identity (2.1);
2. the exact real-weight identity (3.1) and doubled height accounting (3.2);
3. the coefficient budget (2.2) and mixed budget (2.6);
4. the exact odd-prime identity
   `v_p(Delta_Frey)=2 v_p(abc)` and the divisibility equivalence (4.1);
5. `L_1` support inclusion and divisibility (4.4);
6. the finite-family double-counting identity (4.5);
7. full-support stabilization once the modulus exceeds every exponent;
8. the arbitrarily large finite-modulus blind spot (4.6);
9. the prime endpoint coefficient rigidity (5.2) and its unbounded family.

It deliberately does not formalize modularity, a local Tate-curve conductor
theorem, Ribet level lowering, newform finiteness, higher congruence ideals, or
abc.  There is no target estimate stored as a structure field and no hidden
global hypothesis.
