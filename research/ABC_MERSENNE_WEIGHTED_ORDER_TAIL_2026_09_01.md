# The weighted small-order tail in the Mersenne order-block route

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** rigorous reduction and no-go audit; this is not an unconditional
proof or disproof of the abc conjecture.

## 1. Scope and conclusion

This note continues the Mersenne/cyclotomic route developed in
`ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`.  It attacks the third arm of
the near-quadratic tail reduction: the logarithmic mass of base-two
Wieferich primes whose exact multiplicative order is exceptionally small
relative to the prime.

The main conclusions are as follows.

1. The known almost-all order theorem does imply a global weighted
   zero-density estimate, but its scale is the prime-size variable.  Even
   after Brun--Titchmarsh, exact-order congruence, and the cyclotomic square
   budget are added, it does not imply the required uniform fibre estimate.
2. A strict abstract countermodel satisfies all of those coarse consequences
   (including genuine primality and the congruence `p = 1 mod d`) while
   retaining linear logarithmic mass in one labelled fibre.  The labels in
   the model are not asserted to be actual orders or cyclotomic valuations,
   so this closes only the proposed coarse inference, not the arithmetic
   route.
3. A failed weighted tail can be localized to a single logarithmic shell
   with respect to any prescribed summable profile.  This identifies a
   precise family of local overload estimates that would close the tail.
4. The pointwise target `log E_d = o(phi(d))` is stronger than the actual
   Mersenne endpoint needs.  The endpoint is equivalent to an `o(m)` bound
   for the divisor-averaged block mass.  Consequently, the smallest current
   extra input is a divisor-average bound for the uncontrolled remainder,
   not a pointwise estimate at every highly composite order.

No full-premise counterexample to the arithmetic weighted-tail statement was
found.  The Mersenne route therefore remains open.

## 2. Exact arithmetic ledger

For an odd prime `p`, put

\[
 f(p)=\operatorname{ord}_p(2),\qquad
 \alpha_p=v_p(2^{f(p)}-1).
\]

For `d>1`, define

\[
 \mathcal W_d=\{p:f(p)=d,\ \alpha_p\ge2\},
 \qquad
 T_d=\prod_{p\in\mathcal W_d}p,
\]

and

\[
 D_d=\prod_{\substack{f(p)=d\\\alpha_p\ge3}}
           p^{\alpha_p-2}.
\]

Murty--S\'eguin, Proposition 2.5, identifies
`v_p(Phi_{f(p)}(2))` with `alpha_p`.  The cyclotomic classification in
Murty--Wong and Pomerance removes the possible intrinsic divisor after
division by the radical.  Hence

\[
 \log E_d
 =\sum_{f(p)=d}(\alpha_p-1)\log p
 =\log T_d+\log D_d.                              \tag{2.1}
\]

Moreover,

\[
 T_d^2\mid\Phi_d(2),\qquad
 2^{\varphi(d)-1}\le\Phi_d(2)<2^{\varphi(d)+1}.   \tag{2.2}
\]

Thus

\[
 0\le\log T_d\le\frac12\log\Phi_d(2)
 <\frac{\varphi(d)+1}{2}\log2,                    \tag{2.3}
\]

and, because every exact-order prime is at least `d+1`,

\[
 |\mathcal W_d|
 \le \frac{(\varphi(d)+1)\log2}{2\log(d+1)}.      \tag{2.4}
\]

Both estimates are on the natural `O(phi(d))` logarithmic scale; neither is
a little-oh estimate.

## 3. What global small-order counting really gives

### Proposition 3.1 (global order-index budget)

For `Y>=2`,

\[
 \sum_{\substack{p\text{ odd prime}\\f(p)\le Y}}
       \alpha_p\log p
 \le \sum_{d\le Y}\log\Phi_d(2)
 \le (\log2)\sum_{d\le Y}(\varphi(d)+1)
 =O(Y^2).                                         \tag{3.1}
\]

In particular,

\[
 \#\{p\text{ odd prime}:f(p)\le Y\}
 =O\!\left(\frac{Y^2}{\log Y}\right).            \tag{3.2}
\]

#### Proof

If `f(p)=d`, then `p` is an exact-order divisor of `Phi_d(2)` and its
valuation there is `alpha_p`.  Exact order is unique, so the prime-power
contributions for different `d` do not overlap.  This proves the first
inequality.  The second follows from Pomerance's upper bound in (2.2).

For (3.2), split at `p=Y^2`.  There are at most `pi(Y^2)` primes below the
split.  Every prime above it contributes at least `2 log Y` to the left side
of (3.1), so there are `O(Y^2/log Y)` such primes as well.  This proves the
claim.  ∎

This bound is indexed by all orders at most `Y` and has quadratic total
mass.  The desired mass in one fibre is `o(phi(d))`, which is essentially
near-linear in `d`.  Thus (3.1) cannot be restricted to a single fibre with
the needed saving.

### Proposition 3.2 (the precise Erdős--Murty consequence)

Fix `delta>0` and let

\[
 \mathcal B_\delta=
 \{p:f(p)\le p^{1/(2+\delta)}\}.
\]

Then

\[
 A_\delta(x):=\#\{p\le x:p\in\mathcal B_\delta\}=o(x/\log x)
\]

and

\[
 \Theta_\delta(x):=
 \sum_{\substack{p\le x\\p\in\mathcal B_\delta}}\log p=o(x). \tag{3.3}
\]

#### Proof

Erdős--Murty prove that for every positive function `eta(p)->0`, all but a
zero-density set of primes satisfy

\[
 f(p)>p^{1/(2+\eta(p))}.
\]

Choose `eta(p)<delta` eventually.  This places `B_delta`, up to finitely many
primes, inside their exceptional set and proves the assertion for
`A_delta`.  Abel summation gives

\[
 \Theta_\delta(x)
 =A_\delta(x)\log x-
   \int_2^x\frac{A_\delta(t)}{t}\,dt=o(x).
\]

For the integral, fix `epsilon>0`, use
`A_delta(t)<=epsilon t/log t` beyond a fixed point, and then let `epsilon`
tend to zero.  ∎

The extreme arm in order `d` begins at `x=d^{2+delta}`.  At that point
`o(x)` need not be `o(phi(d))`; it may be much larger.  At the upper
cyclotomic scale `x<2^{phi(d)+1}`, (3.3) is still further from the desired
linear bound.

### Proposition 3.3 (the exact Brun--Titchmarsh range)

Murty--S\'eguin, Theorem 2.4, states that for fixed `theta<1`, uniformly when
`d<x^theta` and `x` is sufficiently large,

\[
 \sum_{\substack{p\le x\\p\equiv1\pmod d}}\log p
 \le \frac{2x\log x}{\varphi(d)\log(x/d)}.         \tag{3.4}
\]

Consequently, exact-order repeated support below `x` is `o(phi(d))` whenever

\[
 x=o(\varphi(d)^2),\qquad d<x^\theta,\qquad
 \frac{\log x}{\log(x/d)}=O(1).                   \tag{3.5}
\]

The choice

\[
 Y_d=\frac{\varphi(d)^2}{\log\log(3d)}
\]

satisfies (3.5), giving the existing small-arm theorem.  At
`x` comparable with `phi(d)^2`, (3.4) gives only `O(phi(d))`; at
`x=d^{2+delta}` it gives no useful tail saving.

## 4. Why dyadic summation of the known estimates fails

In a dyadic shell `(X,2X]` of the extreme arm, the three available estimates
give only

\[
 \sum_{\substack{p\in\mathcal W_d\\X<p\le2X}}\log p
 \le
 \min\left\{
   o(X),\;
   O\!\left(\frac{X\log X}{\varphi(d)\log(X/d)}\right),\;
   O(\varphi(d))
 \right\}.                                        \tag{4.1}
\]

The first term is global Erdős--Murty mass, the second is
Brun--Titchmarsh, and the third is the square budget.  At the first extreme
scale `X=d^{2+delta}`, neither of the first two terms is `o(phi(d))` with the
available uniformity.  The last term has exactly the scale that must be
improved.  Across larger `X`, the available theorems provide no uniform
saving of size `o(phi(d))`.  Consequently the currently known shell
estimates do not create the missing little-oh when summed.

This failure is independent of the super-Wieferich depth.  All order-counting
estimates above concern `log T_d`; they do not control `log D_d`.

## 5. A strict no-go model for the coarse inference

The following model shows that zero density, exact-order congruence, extreme
size, and the numerical square budget cannot by themselves imply a weighted
fibre estimate.

### Proposition 5.1 (sparse congruent fibres with linear mass)

Fix `0<c<log(2)/2`, for example `c=log(2)/8`, and put

\[
 d_j=2^j,\qquad \phi_j=\varphi(d_j)=2^{j-1},
 \qquad X_j=e^{c\phi_j}.
\]

For all sufficiently large `j`, one may choose a prime

\[
 p_j\in[X_j,2X_j],\qquad p_j\equiv1\pmod {d_j}.   \tag{5.1}
\]

The set `S={p_j}` satisfies

\[
 \#(S\cap[1,x])=O(\log\log x)=o(\pi(x)),          \tag{5.2}
\]

and, for every fixed `delta>0`, eventually

\[
 d_j<p_j^{1/(2+\delta)},
 \qquad
 \log p_j=c\phi_j+O(1)\not=o(\phi_j),             \tag{5.3}
\]

while

\[
 2\log p_j<(\phi_j+1)\log2.                       \tag{5.4}
\]

#### Proof

Since `d_j` is a constant multiple of `log X_j`, the Siegel--Walfisz theorem
applies uniformly to the progression `1 mod d_j` and supplies (5.1).
The logarithms `log p_j` grow geometrically, so the number of selected primes
up to `x` is `O(log log x)`, proving (5.2).  The same estimate and
`log p_j=O(log x)` for `p_j<=x` give the stronger weighted sparsity

\[
 \sum_{p_j\le x}\log p_j=O(\log x\log\log x)=o(x).
\]

Exponential growth in `phi_j`
beats every fixed power of `d_j`, and (5.1) gives the middle assertion in
(5.3).  Finally, the choice `c<log(2)/2`, with room to absorb the additive
`log 2`, proves (5.4).  Since
`\Phi_{2^j}(2)=2^{\phi_j}+1`, eventually

\[
 2\log p_j<\phi_j\log2<\log\Phi_{d_j}(2),
\]

so the model satisfies the actual numerical square budget as well.  ∎

Give `p_j` the **abstract** incidence labels

\[
 \widetilde f(p_j)=d_j,\qquad \widetilde\alpha_{p_j}=2.
\]

Then each labelled fibre has one point, is globally zero-density, satisfies
the actual congruence `p_j=1 mod d_j`, lies on the exceptional small-order
scale, and respects the complete numerical square budget, yet has normalized
mass tending to `c`.

The labels are not claimed to satisfy
`ord_{p_j}(2)=d_j` or `p_j^2 | Phi_{d_j}(2)`.  Therefore Proposition 5.1 is
not a counterexample to the arithmetic tail or to abc.  It is a complete
counterexample only to the proposed implication from the four coarse pieces
of information.  Any successful proof must use the missing arithmetic
correlation encoded by the actual order and square divisibility.

## 6. A summable-profile localization theorem

Equal-width pigeonholing loses a factor equal to the number of logarithmic
shells.  A summable profile gives a sharper and more flexible statement.

### Proposition 6.1 (profile overload)

Let a finite nonnegative mass be decomposed as

\[
 M\le\sum_{k\in I}M_k,
\]

and let `a_k>=0` satisfy `sum_{k in I} a_k<=1`.  If `M>=H>0`, then there is
some `k in I` for which

\[
                         M_k\ge H a_k.             \tag{6.1}
\]

#### Proof

If every `M_k<Ha_k`, summing gives
`M< H sum a_k <=H`, contradicting `M>=H`.  ∎

Apply this with logarithmic shells

\[
 \mathcal S_{d,k}=\left\{
 p\in\mathcal W_d:
 2^kL_d<\log p\le2^{k+1}L_d
 \right\},\qquad L_d=(2+\delta)\log d,            \tag{6.2}
\]

and, for example,

\[
 a_k=\frac{6}{\pi^2(k+1)^2}.
\]

If the extreme mass is at least `epsilon phi(d)/4`, then some shell satisfies

\[
 \sum_{p\in\mathcal S_{d,k}}\log p
 \ge \frac{3\epsilon}{2\pi^2(k+1)^2}\varphi(d),   \tag{6.3}
\]

and hence

\[
 |\mathcal S_{d,k}|
 \ge
 \frac{3\epsilon\varphi(d)}
 {2\pi^2(k+1)^2\,2^{k+1}(2+\delta)\log d}.      \tag{6.4}
\]

Conversely, a uniform family of shell bounds

\[
 \sum_{p\in\mathcal S_{d,k}}\log p
 \le \eta(d)a_k\varphi(d),\qquad \eta(d)\to0,    \tag{6.5}
\]

closes the extreme tail after summation.  Thus (6.5), or any summable-envelope
variant of it, is a precise local input sufficient for the weighted result.

### Proposition 6.2 (atomic-or-diffuse split)

Let an extreme mass `M` be split at a logarithmic height `h>0` into a light
part and a heavy part.  If `M>=H`, then either

\[
 M_{\rm heavy}\ge H/2,                             \tag{6.6}
\]

or the light part contains at least

\[
                         H/(2h)                    \tag{6.7}
\]

points.  If the total square budget is `B`, the number of heavy points is at
most `B/h`.

#### Proof

If (6.6) fails, the light mass is at least `H/2`; every light weight is at
most `h`, which gives (6.7).  Every heavy weight is at least `h`, so summing
them gives the last assertion.  ∎

This separates a prospective counterexample into a macroscopic-factor
mechanism of rank `O(phi(d)/h)` and a diffuse cluster of submacroscopic
factors.  When `h` is chosen comparable to `phi(d)`, the former has bounded
rank.  Neither branch is excluded by the current literature.

## 7. The exact endpoint is a divisor average

Let

\[
 B_m=\prod_{d\mid m}E_d,
 \qquad
 A(m)=\log B_m=\sum_{d\mid m}\log E_d.
\]

The exact lifting decomposition already proved in the repository is

\[
 W_m=L_mB_m,
 \qquad
 \log W_m=A(m)+\log L_m,
 \qquad 1\le L_m\le m.                            \tag{7.1}
\]

### Theorem 7.1 (endpoint equivalence)

One has

\[
                  \log W_m=o(m)
 \quad\Longleftrightarrow\quad
                  A(m)=o(m).                       \tag{7.2}
\]

#### Proof

The lifting bound gives `0<=log L_m<=log m=o(m)`.  If `log W_m=o(m)`,
subtracting this actual lifting term from
`log W_m=log B_m+log L_m` gives `A(m)=log B_m=o(m)`.  Conversely, if
`A(m)=o(m)`, adding the same lifting term gives `log W_m=o(m)`.  ∎

Here every little-oh is taken through the positive integers `m->infinity`:
for every `epsilon>0` there is `M` such that the absolute value of the
displayed function is at most `epsilon*m` for every `m>=M`.  Equation (7.1)
holds for every positive `m`.  Thus the `W_m -> B_m` implication subtracts
the actual LTE lifting remainder, while the `B_m -> W_m` implication adds
it.  Although the product identity also gives `B_m|W_m`, the proof of the
reverse asymptotic implication uses the equality `W_m=L_mB_m` together with
`log L_m=o(m)`, rather than any unproved comparison in the opposite
direction.

This equivalence reveals that the pointwise hypothesis

\[
                         \log E_d=o(\varphi(d))     \tag{7.3}
\]

is a convenient sufficient condition, not the exact endpoint.

Write

\[
 \log E_d=s_d+r_d,
\]

where `s_d` is the already controlled support below `Y_d` and `r_d` is

\[
 r_d=
 \sum_{\substack{f(p)=d,\ \alpha_p\ge2\\p>Y_d}}\log p
 +\sum_{f(p)=d}(\alpha_p-2)_+\log p.               \tag{7.4}
\]

The first term is the uncontrolled transition plus extreme support; the
second is the deep lift.

### Corollary 7.2 (strictly weaker closure input)

The Mersenne endpoint follows if

\[
 s_d=o(\varphi(d))                                 \tag{7.5}
\]

and

\[
 \forall\epsilon>0\ \exists M\ \forall m\ge M,
 \qquad \sum_{d\mid m}r_d\le\epsilon m.           \tag{7.6}
\]

#### Proof

The totient identity `sum_{d|m} phi(d)=m` turns (7.5) into
`sum_{d|m}s_d=o(m)`, including the fixed finite prefix.  Hypothesis (7.6)
is exactly `sum_{d|m}r_d=o(m)`.  Add the two bounds and apply Theorem 7.1. ∎

Condition (7.6) is strictly weaker than `r_d=o(phi(d))`.  Taking `m=d`
forces only `r_d=o(d)` pointwise, leaving extra room at integers for which
`phi(d)/d` is small.  The strictness can be witnessed by an explicit
nonnegative abstract sequence.

### Proposition 7.3 (strictness of the divisor-average gate)

There is a nonnegative sequence `r_d` such that

\[
 \sum_{d\mid m}r_d=o(m),                            \tag{7.7}
\]

but `r_d` is not `o(phi(d))`.

#### Proof

Choose a divisibility chain of squarefree primorials

\[
 n_1\mid n_2\mid\cdots
\]

so rapidly increasing that

\[
 \sum_{i<k}n_i=o(n_k),
 \qquad
 \frac{\varphi(n_k)}{n_k}\longrightarrow0.        \tag{7.8}
\]

Such a subsequence exists because primorials form a divisibility chain, their
successive selected ratios can be made arbitrarily large, and Mertens'
product theorem gives the second limit.  Define

\[
 r_{n_k}=\varphi(n_k),\qquad r_d=0
 \quad(d\notin\{n_k:k\ge1\}).
\]

Along `d=n_k`, the ratio `r_d/phi(d)` equals one, so pointwise little-oh
fails.  If `n_k` is the largest member of the chain dividing `m`, then

\[
 \frac1m\sum_{d\mid m}r_d
 =\frac1m\sum_{i\le k}\varphi(n_i)
 \le\frac{\varphi(n_k)+\sum_{i<k}n_i}{n_k}
 \longrightarrow0.                                \tag{7.9}
\]

If the largest such `k` stays bounded while `m` tends to infinity, the
numerator is fixed and the same ratio again tends to zero.  Splitting these
two cases uniformly proves (7.7).  ∎

This divisor-average direction is therefore an active alternative to
attacking every exact-order fibre uniformly.  Proposition 7.3 is only a
logical strictness witness; it does not claim that actual Mersenne block
remainders have this form.

## 8. Exact pointwise residual gates

For any one fixed `delta>0`, set `U_d=d^{2+delta}`.  Because every term is
nonnegative, the pointwise statement `r_d=o(phi(d))` follows from, and is
essentially decomposed into, the following three inputs:

\[
 \sum_{f(p)=d}(\alpha_p-2)_+\log p=o(\varphi(d)),  \tag{8.1}
\]

\[
 \#\{p\in\mathcal W_d:Y_d<p\le U_d\}
      =o\!\left(\frac{\varphi(d)}{\log d}\right), \tag{8.2}
\]

and

\[
 \sum_{\substack{p\in\mathcal W_d\\p>U_d}}\log p
      =o(\varphi(d)).                              \tag{8.3}
\]

The upper and lower logarithmic weights in (8.2) are constant multiples of
`log d`, so its counting and weighted forms are equivalent.  Each little-oh
has the uniform quantifier order

\[
 \forall\epsilon>0\ \exists D\ \forall d\ge D.
\]

Finiteness of super-Wieferich primes would eventually prove (8.1), but it
would leave (8.2) and (8.3) open.

A clean order-indexed global input would also suffice.  Namely, if

\[
 G(D)=\sum_{f(p)\le D}(\alpha_p-1)\log p
      =o\!\left(\frac{D}{\log\log(3D)}\right),     \tag{8.4}
\]

then `log E_d<=G(d)` and the standard lower bound
`phi(d) >> d/log log(3d)` imply (7.3).  The known unconditional estimate in
Proposition 3.1 is only `G(D)=O(D^2)`.  Formula (8.4) makes clear why a theorem
indexed by order, rather than prime-size density, would be relevant.

## 9. Counterexample search and finite evidence

The two classical known base-two Wieferich primes do not enter the extreme
tail:

\[
 \operatorname{ord}_{1093}(2)=364,\qquad
 \operatorname{ord}_{3511}(2)=1755.
\]

Direct modular arithmetic gives depth exactly two in both cases.  Moreover,

\[
 1093<Y_{364}\approx10659.51,
 \qquad
 3511<Y_{1755}\approx347509.38.
\]

Thus both lie inside the unconditionally controlled small arm.  This is
finite evidence only.  It neither proves an eventual statement nor supplies
a counterexample to any tail estimate.

The strict countermodel in Proposition 5.1 closes only the implication from
coarse density/congruence/budget data.  Because it does not satisfy the
actual order and square-divisibility incidence, it does not justify
abandoning the Mersenne route.

## 10. Literature boundary

The following primary sources were checked directly.

1. P. Erdős and M. Ram Murty, *On the order of a (mod p)*, CRM Proceedings
   and Lecture Notes 19 (1999), 87--97.  The archived scan is
   `research/sources/mersenne_prime_layer_radical_2026_09_01/Erdos_Murty_1999_order_mod_p.pdf`.
2. M. Ram Murty and François S\'eguin, *Prime divisors of sparse values of
   cyclotomic polynomials and Wieferich primes*, J. Number Theory 201 (2019),
   1--22.  Theorem 2.4 supplies (3.4), and Propositions 2.5--2.6 supply the
   exact valuation reindexing.
3. M. Ram Murty and Siman Wong, *The ABC conjecture and prime divisors of the
   Lucas and Lehmer sequences* (2002).  Its powerful-part arguments do not
   give an unconditional weighted estimate in one exact-order block.
4. Carl Pomerance, *Cyclotomic primes*, J. Number Theory 276 (2025), 198--208.
   The unconditional theorem gives many composite primitive parts; the
   stronger distinct-factor statement is explicitly abc-conditional.
5. Kevin Ford, Florian Luca, and Igor Shparlinski, *On the largest prime
   factor of the Mersenne numbers*, Bull. Aust. Math. Soc. 79 (2009),
   455--463.  Its largest-factor and convergent-series results do not control
   repeated exact-order logarithmic mass.
6. Nic Fellini and M. Ram Murty, *Wieferich primes in number fields and the
   conjectures of Ankeny--Artin--Chowla and Mordell*, J. Number Theory 285
   (2026), 209--229.  Their non-Wieferich lower bounds require abc or
   finiteness of super-Wieferich primes and are not weighted by exact-order
   fibre.

No cited theorem currently supplies (7.6), (8.3), or the summable shell
envelope (6.5).

## 11. Formalization boundary

The companion Lean module
`MersenneWeightedOrderTail20260901.lean` formalizes:

- profile-overload and profile-envelope finite mass theorems;
- the atomic-or-diffuse inequality and heavy-support budget;
- a finite singleton witness showing that a square budget alone admits
  saturation;
- the divisor-mass little-oh passage;
- the exact equivalence between Mersenne power-loss little-oh and
  divisor-averaged canonical block mass;
- the weaker small-block plus divisor-average remainder criterion.

The external analytic results (Siegel--Walfisz, Brun--Titchmarsh,
Erdős--Murty, and the cyclotomic size estimates) remain explicitly outside
the Lean kernel.  No unproved analytic assertion is hidden in the formal
statements.
