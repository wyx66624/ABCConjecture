# Analytic abc routes: a finite-support counterexample to the proposed smooth-number moments

**Author:** ChatGPT  
**Date and literature cut-off:** 30 August 2026  
**Status:** rigorous partial results and literature audit; neither a proof nor a disproof of abc.

## 1. What is new in this increment

The repository previously identified an invalid error estimate in Carella,
arXiv:2608.16764v2, equations (4.7)--(4.8). Here we establish a stronger
conclusion: the first-moment assertion in Lemma 4.2 is false in the very
parameter range used in the proposed abc construction. An elementary finite
encoding, combined with Younis's unconditional short-interval theorem, proves
that almost every smooth integer in those intervals has far more than
`2 log log x` distinct prime factors.

This is a counterexample to a proposed analytic lemma, **not** a
counterexample to abc. It does not exclude an unbounded very sparse sequence
of smooth low-radical neighbours.

## 2. Finite-support counting, with a complete elementary proof

Write `omega(n)` for the number of distinct prime divisors of a positive
integer. For integers `N >= 1`, `Y >= 1`, and `w >= 0`, put

\[
 A(N,Y,w)=\{1\le n\le N: p\mid n\Longrightarrow p\le Y,
                  \quad \omega(n)\le w\},
 \qquad L=\lfloor\log_2 N\rfloor.
\]

**Theorem 2.1 (finite prime-power encoding).**

\[
                  |A(N,Y,w)|\le (1+YL)^w.                 \tag{2.1}
\]

**Proof.** Let

\[
 Q=\{1\}\cup\{q^e:1\le q\le Y,\ 1\le e\le L\}.
\]

Then `|Q| <= 1+YL`. Every `n` in `A(N,Y,w)` has its unique prime
factorization `n=prod_{j=1}^r p_j^{e_j}`, with `r<=w`. Each exponent satisfies
`2^{e_j} <= p_j^{e_j} <= n <= N`, hence `e_j<=L`. Thus every prime-power
factor belongs to `Q`. Order the factors by increasing prime and append
`w-r` copies of `1`. This gives a word in `Q^w` whose product is `n`.
Different integers cannot have the same word, because the product recovers
the integer. There are `|Q|^w` words. The argument also covers `n=1`, `w=0`,
and `N=1`, with the empty product equal to `1`. This proves (2.1). No prime
number theorem, smooth-number asymptotic, or abc hypothesis is used. ∎

The bases `q` in `Q` need not be prime. This deliberate overcount makes the
bound elementary and its exact Lean counterpart straightforward.

**Corollary 2.2 (subpolynomial support).** Suppose `y=y(x)>=2`,
`log log x=o(log y)`, and `log y=o(log x)`. Set `u=log x/log y`.
For every fixed `kappa>0`,

\[
 \#\{n\le2x:P^+(n)\le y,\ \omega(n)\le\kappa u\}
                         \le x^{\kappa+o(1)}.             \tag{2.2}
\]

**Proof.** Apply (2.1) with `N=floor(2x)`, `Y=floor(y)`, and
`w=floor(kappa u)`. Since `L=O(log x)`,

\[
 \log(1+YL)\le \log y+O(\log\log x).
\]

Consequently the logarithm of the upper bound in (2.1) is at most

\[
 \kappa\frac{\log x}{\log y}
       (\log y+O(\log\log x))
             =\kappa\log x+o(\log x).
\]

The floor operations only reduce the count and the exponent. ∎

More generally, if `w(x) log y=o(log x)` and
`w(x) log log x=o(log x)`, the same proof gives a bound `x^{o(1)}`.

**Corollary 2.3 (finite-packet moments).** Let `S` be any finite set of
positive `Y`-smooth integers at most `N`, and put `B=(1+Y floor(log_2 N))^w`.
Then

\[
 \#\{n\in S:\omega(n)>w\}\ge \max(0,|S|-B),\qquad
 \sum_{n\in S}\omega(n)\ge (w+1)\max(0,|S|-B).            \tag{2.3}
\]

**Proof.** The complement of the high-omega part has cardinality at most
`B` by (2.1). Each integer in the high-omega part contributes at least
`w+1` to the nonnegative sum. ∎

## 3. The precise external short-interval input

Younis, [arXiv:2409.05761v1](https://arxiv.org/pdf/2409.05761v1),
Theorem 1.1, **p. 2**, states that for each fixed `17/30<theta<=1` there
is a constant `C_Y(theta)>0` for which

\[
 \frac{\Psi(x+h,y)-\Psi(x,y)}h
 =\frac{\Psi(x,y)}x
   \left(1+O_\theta\!\left(\frac{\log(u+1)}{\log y}\right)\right)
                                                               \tag{3.1}
\]

uniformly when

\[
 x^\theta\le h\le x,\qquad
 \exp(C_Y(\theta)(\log x)^{2/3}(\log\log x)^{4/3})\le y\le2x.
                                                               \tag{3.2}
\]

Fix henceforth

\[
 \frac{17}{30}<\theta<1,\quad C\ge C_Y(\theta),\quad
 h=x^\theta,\quad y=\exp(C(\log x)^{2/3}(\log\log x)^{4/3}),
 \quad u=\frac{\log x}{\log y}.                            \tag{3.3}
\]

The lower bound on `C` is essential to applying this source: we do not claim
the theorem for every positive `C`. Let

\[
 S_x=\{n\in(x,x+h]:P^+(n)\le y\},\qquad M_x=|S_x|.
\]

We have `y=x^{o(1)}`, `y=o(h)`, `u` tends to infinity, and
`log(u+1)/log y` tends to zero. Equation (3.1), together with the
long-interval smooth-number estimate recalled in Younis's equation (1.7),
**p. 5**, gives

\[
 M_x=x^{\theta-o(1)}.                                    \tag{3.4}
\]

Indeed, `u log u=o(log x)`. The familiar Dickman form in this range is
`M_x=h rho(u)(1+o(1))`. For a precise source, see Hildebrand--Tenenbaum,
[Integers without large prime factors](https://numdam.org/item/JTNB_1993__5_2_411_0.pdf),
**printed p. 415 (PDF p. 6), equations (1.8)--(1.9)**. The latter equations
give `Psi(x,y)=x rho(u)(1+O(log(u+1)/log y))` when
`1<=u<=(log y)^(3/5-epsilon)`. Taking the fixed `epsilon=1/20` makes that
range contain (3.3) for every sufficiently large `x`: its right-hand side
has a power `(log x)^(11/30)`, while `u` has power `(log x)^(1/3)`.
This source gives complete proofs of the smooth-number estimates in its
later sections and points to Hildebrand's original 1986 article
[DOI 10.1016/0022-314X(86)90013-2](https://doi.org/10.1016/0022-314X(86)90013-2).
The local lower-tail conclusions below require only (3.4), not a
differentiated Dickman estimate or a saddle-point moment formula.

## 4. A local lower-tail theorem

**Theorem 4.1.** For the parameters (3.3) and every fixed
`0<kappa<theta`,

\[
 \frac{\#\{n\in S_x:\omega(n)\le\kappa u\}}{M_x}
                  \le x^{\kappa-\theta+o(1)}\longrightarrow0. \tag{4.1}
\]

In particular,

\[
 \liminf_{x\to\infty}
       \frac{1}{uM_x}\sum_{n\in S_x}\omega(n)\ge\theta.  \tag{4.2}
\]

**Proof.** Since `theta<1`, every element of `S_x` is at most `2x`.
Corollary 2.2 bounds the numerator of (4.1) by `x^{kappa+o(1)}`;
(3.4) gives its denominator. Let `B_x` denote the numerator. Nonnegativity
of `omega` implies

\[
 \sum_{n\in S_x}\omega(n)\ge \kappa u(M_x-B_x).
\]

Divide by `uM_x` and take a lower limit. It is at least every fixed
`kappa<theta`, so it is at least `theta`. This last argument does not assume
uniformity for a threshold `kappa` varying with `x`. ∎

**Corollary 4.2 (the actual low-omega population).** With (3.3),

\[
 \#\{n\in S_x:\omega(n)\le2\log\log x\}\le x^{o(1)},
                                                               \tag{4.3}
\]

and its proportion in `S_x` is at most `x^{-theta+o(1)}`. Hence

\[
 \frac{\#\{n\in S_x:\omega(n)>2\log\log x\}}{M_x}
                              \longrightarrow1.         \tag{4.4}
\]

**Proof.** For `w=floor(2 log log x)`,

\[
 w\log y=O((\log x)^{2/3}(\log\log x)^{7/3})=o(\log x),
\]

and `w log log x=o(log x)`. Apply the final observation after
Corollary 2.2 and then (3.4). ∎

The same conclusion holds with `2 log log x` replaced by any fixed power
of `log log x`. Powers of `log log x` are still `o(u)` in (3.3).

## 5. Explicit refutation of the proposed moment assertions

The current arXiv record for Carella remains
[arXiv:2608.16764v2](https://arxiv.org/pdf/2608.16764v2), revised
24 August 2026. We inspected the original PDF rather than accepting its
abstract.

Take `theta=3/5` and `C>=C_Y(3/5)` in (3.3). These parameters satisfy
the literal requirements `h=x^theta>x^{7/12}`, `y<h<x`, and `y=o(h)`
of **Lemma 4.2, p. 8, equation (4.5)**. That lemma would imply

\[
 \sum_{n\in S_x}\omega(n)
       =h\rho(u)(\log\log y)(1+o(1))+O(h\rho(u)).        \tag{5.1}
\]

The distinction between `[x,x+h]` in the paper and `(x,x+h]` here costs
at most one integer with `omega(n)<=log_2(2x)`; this is negligible relative
to `M_x=x^{3/5-o(1)}`.

Because `M_x=h rho(u)(1+o(1))`, (5.1) would give

\[
 \frac1{uM_x}\sum_{n\in S_x}\omega(n)\longrightarrow0,
\]

as

\[
 \frac{u}{\log\log y}
 \asymp\frac{(\log x)^{1/3}}{(\log\log x)^{7/3}}
 \longrightarrow\infty.
\]

This contradicts the positive lower bound `3/5` in (4.2). Thus the
statement of Lemma 4.2 itself is false in its intended regime.

Likewise, **Lemma 4.4, p. 9, equation (4.13)** would bound the mean of
`omega^2` by `O((log log y)^2)`. Theorem 4.1 gives, for any fixed
`0<kappa<3/5`, a lower bound `kappa^2 u^2(1-o(1))`, so this statement
is false too. The relative exceptional estimate **(4.24), p. 11** also
fails: its high-omega threshold is a fixed power of `log log x`, and
Corollary 4.2 shows that the corresponding proportion actually tends to
one. The weaker assertion that the high-omega set is `o(h)` is compatible
with this conclusion because all of `S_x` is already `o(h)`.

This independently confirms, and strengthens, the earlier repository
diagnosis that (4.8) replaces an `O(h/u^6)` error by `O(h rho(u))`
without justification. The new argument refutes the resulting assertions
without estimating that error at all.

## 6. What this does and does not eliminate

The current published version of the shorter-interval existence input is
Sarvagya Jain, [Existence of Smooth Numbers in Short Intervals](https://doi.org/10.1093/qmath/haag010),
*The Quarterly Journal of Mathematics* **77** (2026), no. 2, 397--422,
published online 13 May 2026. Its Theorem 1.2 retains the square-root-scale
all-interval existence conclusion recorded in the earlier repository audit.
Theorem 1.1 instead asserts almost-all existence at a shorter scale. Neither
theorem bounds the selected integer's radical or number of distinct prime
factors. Thus the journal version does not repair the false moment step.

The density-based route claiming that most smooth numbers in each such
interval have `omega<=2 log log x` is now rejected by a mathematical
counterexample to its general lemma, in accordance with the user's route
policy. A statement that one exceptionally sparse integer has this property
is much weaker and is not refuted by (4.3).

For completeness, fix an integer `k>=4`, let `theta=3/5`, and consider
prime-power centres `X<p^k<=2X`. The intervals
`(p^k,p^k+(p^k)^theta]` are pairwise disjoint for sufficiently large `X`:
adjacent distinct bases have power gap at least `X^{1-1/k}`, whereas their
interval lengths are at most `(2X)^theta=o(X^{1-1/k})`.
Applying (2.1) uniformly with the largest smoothness and omega thresholds
on this dyadic range shows that at most `X^{o(1)}` of these centres can
have a smooth candidate with `omega<=2 log log(p^k)`. The prime number
theorem counts `X^{1/k+o(1)}` centres, so their relative proportion is at
most `X^{-1/k+o(1)}`. This excludes the all-primes or positive-proportion
version, while permitting an unbounded zero-density subsequence.

## 7. A separate proof route: quantitative amplification against current bounds

We also tested whether current exceptional-set estimates can upgrade
unbounded abc exceptions to a contradiction. Bernert's
[arXiv:2506.13364v1](https://arxiv.org/pdf/2506.13364v1), Theorem 1,
is incorporated in the four-author
[Bernert--Browning--Lichtman--Teravainen arXiv:2410.12234v2](https://arxiv.org/pdf/2410.12234v2).
The latter's Proposition 1.1 and Theorems 1.2--1.3, p. 2, give

\[
 N_\mu(T)\ll_{\mu,\delta}T^{F(\mu)+\delta}\quad(0<\mu<1),
 \qquad
 F(\mu)=\min\left(\frac{2\mu}{3},\frac{23\mu+3}{40},\frac35\right).
                                                               \tag{7.1}
\]

In particular,

\[
 F(\mu)=
 \begin{cases}
 2\mu/3,&0<\mu\le9/11,\\
 (23\mu+3)/40,&9/11\le\mu\le21/23,\\
 3/5,&21/23\le\mu<1.
 \end{cases}                                                   \tag{7.2}
\]

Here `N_mu(T)` counts primitive positive additive triples of height `c<=T`
and radical `<c^mu`. These are counting bounds with positive exponents;
none is a finiteness theorem.

**Proposition 7.1 (a sufficient amplification condition).** Fix
`lambda,mu in (0,1)`, `beta>0`, and `alpha>beta F(mu)`. Suppose every
sufficiently large lambda-exception of height `H` constructs at least
`c_1 H^alpha` **distinct** mu-exceptions of height at most `c_2 H^beta`,
where `c_1,c_2>0` are independent of the seed. Then there are only finitely
many lambda-exceptions.

**Proof.** Choose a fixed `delta>0` with
`beta(F(mu)+delta)<alpha`. At every seed height `H`, (7.1) bounds the
constructed outputs by

\[
 N_\mu(c_2H^\beta)\ll H^{\beta(F(\mu)+\delta)},
\]

which is eventually smaller than `c_1H^alpha`. Thus seed heights are
bounded. There are only finitely many positive additive triples of bounded
height. ∎

This makes explicit the missing theorem; it does not assume it is available.
The already audited squared Pythagorean map has target height of order
`H^4`, radical exponent `mu>(lambda+3)/4`, and an entire target locus of
size `O(T^{1/2})`. For these `mu`, (7.2) has `F(mu)>1/2`, so even the
whole target locus is smaller than the current permissible exceptional
count. This candidate cannot meet Proposition 7.1. No conclusion is drawn
against other amplification maps with larger fibres or smaller height cost.

## 8. Formalization boundary

The mathematical proofs above were completed before Lean implementation
and cross-reviewed by separate route agents. The companion module
`IUTThreeClosures/SmoothLowOmegaCounting.lean` formalizes
the actual natural-number encoding bound (2.1), its finite-packet
consequences, and the factorization-to-exponent bound used in the encoding.

The command `lake env lean IUTThreeClosures/SmoothLowOmegaCounting.lean`
completed with exit code zero. Its printed axiom audits contain only
`propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx` or
custom analytic axiom.

The external theorem of Younis, the prime number theorem, and the
exceptional-set bounds are cited in the paper proof. They are not added as
Lean axioms, and this module is not a formalization of those analytic
theorems. The module does not assert `ABCConjecture` or its negation.

Original PDFs, exact version links, DOI links, relevant pages, and SHA-256
checksums are stored in
`research/sources/analytic_2026_08_30/SOURCE_MANIFEST.md`.
