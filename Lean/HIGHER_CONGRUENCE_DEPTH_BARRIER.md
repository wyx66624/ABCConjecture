# Higher congruence depth, monodromy, and integral congruence ideals

## 1. Scope and conclusion

This note continues the generalized-Fermat modular audit at the only point
which survived the ordinary residual analysis: replace mod-`ell` level
lowering by congruences modulo `ell^k`, and try to recover the full
multiplicative exponents of a Frey curve.

There is a genuine positive local theorem.  Away from `ell`, the inertia of a
Tate curve on `ell^k`-torsion detects the minimal-discriminant exponent modulo
`ell^k`.  Thus higher torsion recovers the `ell`-adic depth which mod-`ell`
level lowering forgets.

The global coefficient audit is nevertheless negative:

* simultaneous removal at several support primes records the minimum local
  depth, not the sum;
* several congruent branches at the same residual prime do not make their
  congruence ideals multiply without an independence theorem;
* rational Tamagawa numbers can be constant while the Frey discriminant
  exponent is unbounded;
* geometric monodromy and integral congruence ideals naturally measure the
  integer `e_p`, hence logarithmically they contribute `log e_p`, whereas the
  discriminant height contains `e_p log p`;
* higher-depth Sturm rigidity bounds the congruence depth, but with a
  coefficient-field/Sturm threshold far too large for the abc slope;
* the higher level-raising coefficient at a removed prime gives at best a
  polynomial bound in `p`, not a bound independent of `p`.

Accordingly no proof of abc or Szpiro is obtained.  The companion Lean module
formalizes all elementary divisibility, aggregation, explicit-family, and
coefficient-threshold statements.  The Tate-curve, Kodaira, Tamagawa,
modularity, congruence-module, modular-degree, and Sturm inputs are separated
as paper mathematics and are not inserted as structure fields.

## 2. Exact local Tate-curve depth

Let `K` be a finite extension of `Q_p`, let `p != ell`, and let `E/K` have
split multiplicative reduction.  It is a Tate curve with parameter `q_E`,

\[
 E(\overline K)=\overline K^\times/q_E^{\mathbf Z},
 \qquad n=v_K(q_E)=v_K(\Delta_{\min})>0.          \tag{2.1}
\]

Choose an `ell^k`-th root of `q_E` and an `ell^k`-th root of unity.  In the
resulting basis of `E[ell^k]`, inertia acts as

\[
 \rho_{E,\ell^k}(\sigma)=
 \begin{pmatrix}
  1 & n\,t_{\ell^k}(\sigma)\\
  0 & 1
 \end{pmatrix},                                  \tag{2.2}
\]

where `t_{ell^k}` is the tame Kummer character.  To see the coefficient `n`,
write `q_E=pi^n u`.  The prime-to-`p` power map is an automorphism on the
principal-unit part, and roots of the residue-field unit occur over an
unramified extension.  The ramified Kummer class is therefore precisely `n`
times the class of the uniformizer.

Since the tame character is surjective, (2.2) gives the exact criterion

\[
 E[\ell^k]\text{ is unramified at }p
 \quad\Longleftrightarrow\quad
 \ell^k\mid v_p(\Delta_{\min}).                   \tag{2.3}
\]

Nonsplit multiplicative reduction is an unramified quadratic twist of the
split curve, so its inertia criterion is the same.  The restrictions
`p != ell` and multiplicative reduction are essential; no corresponding
claim is made at the residual characteristic.

## 3. Frey specialization

For the primitive Frey curve

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

and an odd prime `p|abc`, the integral model is minimal and multiplicative:

\[
 v_p(c_4)=0,
 \qquad v_p(\Delta_{\min})=2v_p(abc)=2e_p.        \tag{3.1}
\]

For an odd residual prime `ell` with `ell != p`, (2.3) becomes

\[
 E[\ell^k]\text{ unramified at }p
 \quad\Longleftrightarrow\quad
 \ell^k\mid e_p.                                  \tag{3.2}
\]

This is the genuine gain over ordinary mod-`ell` lowering: all of
`v_ell(e_p)`, rather than a single divisibility bit, is locally visible.

If the congruence is written modulo a prime-power `lambda^j` in a coefficient
field, with ramification index `e(lambda/ell)`, the rational integer `e_p`
has

\[
 v_\lambda(e_p)=e(\lambda/\ell)v_\ell(e_p).       \tag{3.3}
\]

Thus one must not identify `lambda`-adic depth and rational `ell`-power depth
without the ramification factor.

## 4. Several removed primes: minimum, not sum

Suppose a single congruence modulo `ell^k` lowers the level at every prime in
a finite nonempty set `S`.  Applying (2.3) at each place gives

\[
 k\le \min_{p\in S}v_\ell(2e_p).                 \tag{4.1}
\]

It does not give the sum of these valuations.  For example, take
`e_p=ell^k`, hence `2e_p=2ell^k`, at every one of arbitrarily many formal
local places.  All places
disappear modulo `ell^k`, while none disappears modulo `ell^(k+1)`.  Repeating
the place condition `r` times does not turn the modulus `ell^k` into
`ell^(kr)`.

This is not merely a weakness of an inequality: it is how a single global
representation restricts to a product of inertia groups.  Its common
coefficient ring has one maximal ideal `lambda`, and “unramified at every
place” is a conjunction.  Conjunction takes the minimum admissible depth.

One may instead lower one place at a time and obtain different forms or
different congruence branches.  Their lengths can be added only after proving
that the corresponding components of the congruence module are independent.

## 5. Why congruent branches need not accumulate

There is a simple exact algebra model.  Fix `L=ell^k`, take `m>=1`, and let

\[
 T_m=\{(x_0,\ldots,x_m)\in\mathbf Z_\ell^{m+1}:
             x_i\equiv x_0\pmod L\text{ for every }i\}.        \tag{5.1}
\]

This is a reduced finite `Z_ell`-algebra.  Its coordinate projections are
`m+1` characteristic-zero eigenpackets, and the zeroth packet is congruent to
every other packet modulo `L`.

Let `phi_0:T_m -> Z_ell` be the zeroth projection.  An element annihilates
`ker(phi_0)` precisely when all its nonzero-index coordinates vanish.  The
congruence conditions in (5.1) then force its zeroth coordinate to be
divisible by `L`.  Consequently

\[
 \phi_0(\operatorname{Ann}\ker\phi_0)=L\mathbf Z_\ell,          \tag{5.2}
\]

independently of `m`.  There are arbitrarily many congruent branches, but the
congruence ideal has depth exactly `k`, not `mk`.

Therefore an assertion that separate lower-level forms contribute additively
to a modular degree or congruence number requires an actual transversality,
Gorenstein-component, or intersection-multiplicity theorem.  Counting forms
does not provide it.

## 6. A Frey-specific Tamagawa counterexample

For `e>=1`, take

\[
 (a,b,c)=(3^e,2,3^e+2).                           \tag{6.1}
\]

This is a primitive positive abc point.  At `p=3`, both `b` and `c` are
units, and

\[
 v_3(\Delta_{\min})=2e,
 \qquad c_4\equiv16\cdot4\equiv1\pmod3.           \tag{6.2}
\]

Thus the reduction is multiplicative of Kodaira type `I_(2e)`.  Reducing the
equation modulo three at the node `(0,0)` gives

\[
 y^2=x^2(x+2),
\]

whose tangent cone is

\[
 y^2-2x^2.                                        \tag{6.3}
\]

The only nonzero square modulo three is one, so (6.3) does not split.  The
reduction is nonsplit multiplicative.  For nonsplit type `I_n`, the rational
Tamagawa number is one when `n` is odd and two when `n` is even.  Here
`n=2e`, hence

\[
 c_3(E)=2                                           \tag{6.4}
\]

for every `e`, while the discriminant exponent `2e` is unbounded.

This strictly rules out recovering Frey exponent depth from rational
Tamagawa numbers uniformly.  The geometric component-group/monodromy order
still has size `2e`; the failure is specifically the passage to rational
components in the nonsplit case.

## 7. Monodromy order and modular degree have the wrong coefficient

Suppose, optimistically, that all higher level-lowering congruences imply
that every prime-power divisor of `e_p` divides a congruence number or modular
degree `D_E`.  Then at best

\[
 e_p\mid D_E
 \quad\text{for each }p,                           \tag{7.1}
\]

or, without independence across support primes,

\[
 \operatorname{lcm}_{p\mid abc}e_p\mid D_E.       \tag{7.2}
\]

Taking logarithms controls `log e_p` or the logarithm of an lcm.  The local
discriminant contribution which must ultimately be compared with a conductor
is

\[
 e_p\log p.                                       \tag{7.3}
\]

These scales are fundamentally different.  Already in (6.1), perfect
recovery of the integer `e` supplies only `log e`, whereas (7.3) is
`e log 3`.  An integral congruence ideal is factored by residual primes
dividing `e`; it has no reason to contain the support prime `p` to exponent
`e`.

Known formulas relating congruence numbers, modular degrees, monodromy
pairings, component groups, and Manin constants can transport divisibility,
but they do not manufacture the missing `log p` weight.  An upper bound for
the modular degree strong enough to recover (7.3) would itself be a
quantitative modular-height input of Szpiro strength, not a consequence of
qualitative modularity.

## 8. Exact higher-depth Sturm threshold

Let `g` be the rational newform of the Frey curve and `f` a lower-level
newform with coefficient field `K` of degree `d`.  Let `lambda|ell` have
residue degree `f_lambda`.  If

\[
 a_n(g)\equiv a_n(f)\pmod{\lambda^k},             \tag{8.1}
\]

then

\[
 \ell^{f_\lambda k}
 \mid N_{K/\mathbf Q}(a_n(g)-a_n(f)).              \tag{8.2}
\]

At a good prime `q`, Deligne's bound gives

\[
 |N_{K/\mathbf Q}(a_q(g)-a_q(f))|
 \le (4\sqrt q)^d.                                \tag{8.3}
\]

Therefore

\[
 \ell^{f_\lambda k}>(4\sqrt q)^d                 \tag{8.4}
\]

forces equality of the `q`-th coefficients.  For general `n`, one may use
the coarser bound `2 d(n) sqrt(n)` in each embedding.

To turn this into equality of forms, (8.4) must hold for every coefficient
through a common-level Sturm bound

\[
 B_{\rm St}\asymp
 [\mathrm{SL}_2(\mathbf Z):\Gamma_0(M)]/6         \tag{8.5}
\]

in weight two.  The congruence must also include the bad-prime `U_p`
coefficients or be replaced by an effective multiplicity-one theorem;
residual trace congruences only at good primes do not by themselves satisfy
the naive Sturm hypotheses.

Even granting every compatibility, failure of characteristic-zero equality
only yields approximately

\[
 f_\lambda k\log\ell
 \le d\log\!\left(
       2\max_{n\le B_{\rm St}}d(n)\sqrt n\right). \tag{8.6}
\]

The right side carries the coefficient-field degree and a varying level.
It bounds a logarithm of exponent depth.  It does not bound
`e_p log p` with coefficient one.

Repeated congruences to the same form at the same `lambda^k` cannot be
multiplied in (8.2); Section 5 is a strict counterexample to that step.
Congruences at distinct rational primes can be multiplied, but after all
prime powers are included their product reconstructs `e_p`, so its logarithm
is still only `log e_p`.

## 9. The removed-prime level-raising coefficient

At a prime `p` removed from the level, the unramified Frobenius trace of the
multiplicative representation gives the stronger local congruence

\[
 a_p(f)\equiv \pm(p+1)\pmod{\lambda^k}.           \tag{9.1}
\]

Taking norms and using `|a_p(f)^sigma|<=2 sqrt(p)` gives

\[
 \ell^{f_\lambda k}
 \le (p+1+2\sqrt p)^d=(\sqrt p+1)^{2d},           \tag{9.2}
\]

unless the algebraic integer in (9.1) is zero.  This is sharper and contains
the support prime `p`, but only polynomially.  If a rational form and all
prime-power depths of `e_p` occur in one compatible sign, the optimistic
consequence is merely

\[
 e_p\le p+1+2\sqrt p<4p.                          \tag{9.3}
\]

That remains far from the constant-size exponent control needed to turn
`e_p log p` into `O(log p)`.

The numerical conditions themselves admit a strict linear counterexample
entirely away from the support characteristic.  For any sufficiently large
odd prime `p`, take the trace proxy `a_p=3` and `e_p=p-2`.  Then

\[
 e_p\mid p+1-a_p=p-2,
 \qquad |a_p|\le2\sqrt p.                          \tag{9.4}
\]

Moreover every prime `ell|e_p` is odd and differs from `p`, since `p-2` is
odd and strictly between zero and `p`.  Thus the example respects the
residual-characteristic restriction from Sections 2--3, while `e_p=p-2`
remains linear and unbounded.  This does not assert that every such proxy is
a newform coefficient; it proves that divisibility plus the Weil bound alone
cannot improve (9.3) to a sublinear or uniform exponent bound.  Any stronger
claim must use global compatibility of the same newform across many primes.

## 10. Exact surviving requirement

Higher torsion successfully restores the missing `ell`-adic depth, but an
ordinary integral congruence module has the wrong arithmetic degree.  A
genuinely surviving theorem would need an **Arakelov-weighted congruence or
intersection module** `C(E)` with both:

\[
 \widehat{\deg} C(E)
 \ge \sum_{p\mid abc}(e_p-1)\log p-O(\log R),      \tag{10.1}
\]

and a non-circular upper bound in terms of the radical-level geometry.

The lower bound (10.1) cannot be replaced by an unweighted length, a
Tamagawa product, an lcm of monodromy orders, or a product of residual
characteristics: the preceding examples strictly separate all of these from
the weighted discriminant mass.  The upper bound must not assume abc,
Szpiro, or a modular-height estimate of equivalent strength.

No such module or upper bound is constructed here.  Within the unweighted
congruence-ideal/Tamagawa strategy audited here, this is the minimal open
modular core; the argument does not rule out all higher-torsion or all modular
approaches.

## 11. Lean boundary

`IUTThreeClosures/HigherCongruenceDepthBarrier.lean` proves:

1. the exact odd-prime-power Frey exponent divisibility equivalence;
2. constant-depth simultaneous removal and failure at the next depth;
3. nonmultiplication of repeated same-prime depth;
4. fixed depth with an arbitrarily large support-prime label;
5. primitivity of (6.1), exact `3`-adic abc and Frey discriminant exponents,
   and their unboundedness;
6. the nonsquare certificate for the tangent parameter two modulo three;
7. the elementary “modulus above coefficient bound forces zero” lemma;
8. the away-from-`p` linear numerical obstruction to improving (9.3) from
   divisibility and a Weil-size condition alone, including the proof that
   every residual prime dividing `p-2` is odd and different from `p`.

It does not claim a formal Tate uniformization theorem, a Tamagawa
classification, modularity, higher level lowering, a congruence-module
formula, a modular-degree estimate, Sturm's theorem, Szpiro, or abc.
