# Quadratic Veronese peeling in the Steinberg contact complex

**Author:** ChatGPT
**Date:** 2026-09-02
**Status:** exact quadratic peeling, primitive specialization, and
valuation-layer flag proved; uniform layer cutoff and three fixed one-move
cost policies refuted on all premises; the unrestricted multi-move
contact-complex route remains open

## 1. Scope and retirement rule

This note isolates one specialization of the five-term relation for the
divisor contact surface

\[
  \Omega(z)=d(z)\wedge d(1-z),\qquad
  d:\mathbf Q^\times\longrightarrow
     \bigoplus_p\mathbf Z[p].
\]

The specialization is `y=x^2`.  It gives a genuine algebraic peeling of a
quadratic Veronese cell.  We first prove the identity, including every domain
condition and orientation sign, and then test it on a full-premise infinite
family of primitive positive abc triples.

The policy in this repository is literal: a route is not abandoned because
it is difficult.  Only a precisely quantified statement is retired when a
counterexample satisfies all of its premises.  The counterexamples below
therefore retire three **fixed one-move policies**.  They do not refute the
five-term contact complex, a different sequence of five-term moves, the abc
conjecture, or any theorem in the cited literature.

## 2. The exact five-term specialization

For nonzero rational `z` with `z != 1`, put

\[
  \Omega(z)=d(z)\wedge d(1-z).
\]

The five-term surface identity is

\[
 \Omega(x)-\Omega(y)+\Omega(y/x)
 -\Omega\!\left(\frac{y(1-x)}{x(1-y)}\right)
 +\Omega\!\left(\frac{1-x}{1-y}\right)=0.       \tag{2.1}
\]

### Theorem 2.1 (quadratic Veronese peeling)

Let `x` be rational.  The specialization `y=x^2` is admissible in (2.1) if
and only if

\[
  x\ne0,\qquad x\ne1,\qquad x\ne-1.              \tag{2.2}
\]

Under these exact conditions,

\[
 \boxed{\ \Omega(x^2)=2\Omega(x)
       -2\Omega\!\left(\frac{x}{1+x}\right).\ }  \tag{2.3}
\]

**Proof.**  The usual five-term domain requires `x,y` to be nonzero,
different from one, and different from each other.  With `y=x^2`, these
conditions say precisely that `x` is not `0`, `1`, or `-1`: indeed
`x^2=1` is equivalent over `Q` to `(x-1)(x+1)=0`, and `x^2=x` is equivalent
to `x(x-1)=0`.

Under (2.2), every displayed denominator below is nonzero, and direct field
algebra gives

\[
 \frac yx=x,\qquad
 \frac{y(1-x)}{x(1-y)}=\frac{x}{1+x},\qquad
 \frac{1-x}{1-y}=\frac1{1+x}.                    \tag{2.4}
\]

Both last arguments avoid `0` and `1`.  They are complementary:

\[
  1-\frac{x}{1+x}=\frac1{1+x}.
\]

For every admissible `z`, alternation of the exterior product gives the
orientation rule

\[
  \Omega(1-z)=d(1-z)\wedge d(z)=-\Omega(z).       \tag{2.5}
\]

Substitution of (2.4) and (2.5) in (2.1) yields

\[
  2\Omega(x)-\Omega(x^2)
    -2\Omega\!\left(\frac{x}{1+x}\right)=0,
\]

which is (2.3).  No positivity assumption on `x` was used.  If an argument
is negative, finite-prime divisors are unchanged by its sign because
`d(-1)=0`.  QED.

There is also a coefficientwise proof that exposes the exact cancellation.
Write

\[
 X=d(x),\quad U=d(1-x),\quad W=d(1+x).
\]

Then

\[
 d(x^2)=2X,\quad d(1-x^2)=U+W,
\]

and

\[
 d\!\left(\frac{x}{1+x}\right)=X-W,\qquad
 d\!\left(\frac1{1+x}\right)=-W.
\]

Consequently (2.3) is the bilinear identity

\[
 (2X)\wedge(U+W)
 =2X\wedge U-2(X-W)\wedge(-W).                    \tag{2.6}
\]

## 3. Translation to primitive integer triples

Let `(a,b,c)` be a positive pairwise-coprime abc triple, so `a+b=c`, and
take `x=a/c`.  Formula (2.3) becomes a relation among three actual positive
integer triples.

### Proposition 3.1 (quadratic transform preserves every abc premise)

Define

\[
  T_2(a,b,c)=\bigl(a^2,\ b(a+c),\ c^2\bigr).       \tag{3.1}
\]

Then

\[
  a^2+b(a+c)=c^2,                                  \tag{3.2}
\]

and the three entries in (3.1) are positive and pairwise coprime.

**Proof.**  Since `b=c-a`,

\[
 a^2+b(a+c)=a^2+(c-a)(a+c)=c^2.
\]

Any prime common to `a^2` and `b(a+c)` would divide `a` and either `b` or
`a+c`; both are impossible because `gcd(a,b)=gcd(a,c)=1`.  The same argument
with `c` proves `gcd(b(a+c),c^2)=1`, and
`gcd(a^2,c^2)=1`.  Positivity is immediate.  QED.

Let

\[
 \Omega(A,B,C)=(d(A)-d(C))\wedge(d(B)-d(C)).
\]

The auxiliary triple `(a,c,a+c)` is also positive and primitive.  Applying
(2.3) gives the exact integer relation

\[
 \boxed{
 \Omega\bigl(a^2,b(a+c),c^2\bigr)
   =2\Omega(a,b,c)-2\Omega(a,c,a+c).}              \tag{3.3}
\]

This is a relation in the oriented divisor lattice.  Taking coefficient
absolute values before or after the subtraction is not interchangeable.

## 4. The consecutive Pythagorean-square cell

For `t>=1`, put

\[
 X=2t+1,\qquad Y=2t(t+1),\qquad
 Z=2t^2+2t+1.                                      \tag{4.1}
\]

Besides the standard identity `X^2+Y^2=Z^2`, this parametrization has the
two special relations

\[
  Z-Y=1,\qquad Y+Z=X^2.                             \tag{4.2}
\]

The numbers `X,Y,Z` are pairwise coprime.  In particular,

\[
 (Y,1,Z),\qquad (Y,Z,X^2),\qquad (Y^2,X^2,Z^2)     \tag{4.3}
\]

are all positive primitive abc triples.  Choosing the rational coordinate
`x=Y/Z` in (2.3) makes (3.1) exactly the last triple in (4.3), and gives

\[
 \boxed{
 \Omega(Y^2,X^2,Z^2)
   =2\Omega(Y,1,Z)-2\Omega(Y,Z,X^2).}               \tag{4.4}
\]

Thus two of the three visibly squared legs have been removed from the
auxiliary cells.  The remaining square `X^2=Y+Z` occurs on only one leg of
the second cell.  This is the strongest elementary reason to try the
specialization.

## 5. Exact positive-cost ledger

Put

\[
 u=\log X,\qquad v=\log Y,\qquad w=\log Z,
\]

and write

\[
 \beta=\log\operatorname{rad}(X),\quad
 \alpha=\log\operatorname{rad}(Y),\quad
 \gamma=\log\operatorname{rad}(Z),
\]

with base radical defects

\[
 \delta_X=u-\beta,\quad
 \delta_Y=v-\alpha,\quad
 \delta_Z=w-\gamma.                                \tag{5.1}
\]

For a positive cell with leg heights `h_i`, let

\[
 \Phi=\sum_{i<j}h_ih_j,
\]

and let `M` be the one-sided radical polarization.  Relative to a declared
perfect-power decomposition, write

\[
 2\Phi-M=V+R,                                       \tag{5.2}
\]

where `V` is coherent Veronese loss and `R` is residual base loss.  The
following ledger uses the **outer-square decomposition**: a leg `N^2` has
coherent defect `log N` and residual defect
`log N-log rad(N)`.  It does not assert that this is the maximal common
exponent decomposition of `N` itself.

For the left side of (4.4),

\[
\begin{aligned}
 \Phi_{\rm sq}&=4(uv+uw+vw),\\
 V_{\rm sq}&=\Phi_{\rm sq},\\
 R_{\rm sq}&=2\{\delta_Y(u+w)+\delta_X(v+w)
                       +\delta_Z(u+v)\}.             \tag{5.3}
\end{aligned}
\]

Give each right-hand cell its coefficient absolute value `2`.  The total
positive costs of the peeled chain are

\[
\begin{aligned}
 \Phi_{\rm peel}&=2vw+2\{vw+2u(v+w)\},\\
 V_{\rm peel}&=2u(v+w),\\
 R_{\rm peel}&=4\delta_Y(u+w)+2\delta_X(v+w)
                         +4\delta_Z(u+v).             \tag{5.4}
\end{aligned}
\]

### Proposition 5.1 (conservation and redistribution)

The one-step peeling satisfies

\[
\begin{aligned}
 \Phi_{\rm peel}&=\Phi_{\rm sq},                    \tag{5.5}\\
 V_{\rm peel}&<\tfrac12V_{\rm sq},                  \tag{5.6}\\
 R_{\rm peel}-R_{\rm sq}
  &=2\delta_Y(u+w)+2\delta_Z(u+v)\ge0.              \tag{5.7}
\end{aligned}
\]

**Proof.**  Expanding (5.4) gives
`4vw+4u(v+w)=4(uv+uw+vw)`, proving (5.5).  Since `v,w>0`,

\[
 \tfrac12V_{\rm sq}-V_{\rm peel}=2vw>0,
\]

which proves (5.6).  Subtraction of (5.3) from (5.4) gives (5.7), and every
factor in its right side is nonnegative.  QED.

As `t` tends to infinity,

\[
  u\sim\log t,\qquad v\sim2\log t,qquad w\sim2\log t,
\]

so

\[
 \frac{V_{\rm peel}}{V_{\rm sq}}\longrightarrow\frac14.  \tag{5.8}
\]

This is a real gain in coherent-square cost.  Equations (5.5) and (5.7)
show its price: total positive area does not contract, and the declared
residual cost increases unless the `Y` and `Z` bases are squarefree.

If `Q=M+V=2\Phi-R` is the calibrated cost, then

\[
 Q_{\rm peel}-Q_{\rm sq}
 =-2\delta_Y(u+w)-2\delta_Z(u+v)\le0.               \tag{5.9}
\]

Thus the reduction in calibrated cost is exactly the increase in residual
cost.  Nothing has disappeared from the total `Q+R=2Phi` ledger.

## 5A. Primewise valuation layers: the surviving higher-dimensional flag

The global exponent gcd of a whole integer is too coarse for this problem.
For example, if `s` is odd then `2s^2` has exponent gcd one because the
2-adic exponent is one, even though every prime coming from `s^2` has large
repeated mass.  A primewise filtration retains that information.

For `k>=1`, define

\[
 R_k(n)=\prod_{p:\,v_p(n)\ge k}p,
 \qquad \lambda_k(n)=\log R_k(n).                    \tag{5A.1}
\]

Only finitely many layers are nontrivial, and counting each prime once in
every layer up to its valuation gives the exact layer-cake identities

\[
 n=\prod_{k\ge1}R_k(n),\qquad
 \log n=\sum_{k\ge1}\lambda_k(n),\qquad
 \log\operatorname{rad}(n)=\lambda_1(n),             \tag{5A.2}
\]

and hence

\[
 \log n-\log\operatorname{rad}(n)
   =\sum_{k\ge2}\lambda_k(n).                        \tag{5A.3}
\]

For three legs `a,b,c`, bilinearity expands the positive contact area into
all layer pairs:

\[
 \Phi(a,b,c)=\sum_{k,l\ge1}
 \bigl(\lambda_k(a)\lambda_l(b)
      +\lambda_k(b)\lambda_l(c)
      +\lambda_k(c)\lambda_l(a)\bigr).               \tag{5A.4}
\]

The radical skeleton is exactly the `(k,l)=(1,1)` slice.  Every other
summand records repeated valuation depth with no cancellation.  This is a
genuine flag of primewise boundary contacts and does not lose the
`2s^2` example.

Squaring has an especially rigid action on the flag.  For every `j>=1`,

\[
 R_{2j-1}(n^2)=R_{2j}(n^2)=R_j(n),                   \tag{5A.5}
\]

because both inequalities `2j-1<=2v_p(n)` and
`2j<=2v_p(n)` are equivalent to `j<=v_p(n)`.  Thus every base layer is
duplicated, and every layer-pair area is replicated four times.  In (4.4),
the cell `(Y,1,Z)` has no layers on its unit leg, while `(Y,Z,X^2)` retains
the doubled `X` flag.  Summing the layer-pair areas reproduces the exact
positive-area conservation (5.5); the flag explains rather than evades the
no-go.

A first naive layer statement is also refuted under all abc premises.  No
constant layer cutoff works for the square family.  Indeed, for `t=2^m`,

\[
 v_2(Y^2)=2m+2,
\]

so the prime `2` remains in `R_k(Y^2)` at arbitrarily high `k`.  This retires
only a uniform bounded-depth cutoff.  It does not refute weighted decay,
primewise matching across cells, or a multi-move filling estimate involving
the full flag.  Those versions remain open and are better aligned with the
actual obstruction than the whole-leg exponent gcd.

## 6. Full-premise attacks on three tempting one-move bounds

### 6.1 Positive-area contraction is refuted

Suppose one proposed constants `eta>0` and `K` with

\[
 \Phi_{\rm peel}\le(1-\eta)\Phi_{\rm sq}+K(2w)      \tag{6.1}
\]

for every primitive cell (4.3).  Equation (5.5) would imply
`eta Phi_sq <= 2Kw`.  But `Z=Y+1<=2Y`, while `Y>=4`; hence
`w<=v+log 2<=3v/2`.  Therefore

\[
 \frac{\Phi_{\rm sq}}{2w}
 \ge\frac{4uv}{2w}\ge\frac43u\longrightarrow\infty.
\]

No fixed `K` can satisfy (6.1).  All positivity, sum, and coprimality
premises hold by (4.3).  The exact one-move **positive-area contraction
policy is REFUTED**.

### 6.2 The Gate-VF calibrated-boundary coefficient is missed

The peeled calibrated cost has the useful radical-mass form

\[
\begin{aligned}
 Q_{\rm peel}={}&2u(v+w)+4\alpha(u+w)+4\gamma(u+v)
                         +2\beta(v+w).               \tag{6.2}
\end{aligned}
\]

For the squared abc cell, its height and conductor are

\[
 H=2w,\qquad \rho=\alpha+\beta+\gamma.
\]

Subtracting the target main term `2H rho` gives

\[
\begin{aligned}
 Q_{\rm peel}-2H\rho
  ={}&2u(v+w)+4\alpha u+4\gamma(u+v-w)
       +2\beta(v-w).                                  \tag{6.3}
\end{aligned}
\]

Now `Y<Z`, `Z<=XY`, `0<=beta<=u`, and `alpha,gamma>=0`.  Because
`v-w<=0`, multiplication reverses the comparison `beta<=u`, so

\[
 2\beta(v-w)\ge2u(v-w).
\]

Every other correction in (6.3) is nonnegative, and consequently

\[
 \boxed{\ Q_{\rm peel}-2H\rho\ge4uv.\ }              \tag{6.4}
\]

Using `w<=3v/2` again,

\[
 \frac{Q_{\rm peel}-2H\rho}{H}
 \ge\frac{4uv}{2w}\ge\frac43u\longrightarrow\infty. \tag{6.5}
\]

Hence there is no constant `L` such that this fixed quadratic chain obeys

\[
  Q_{\rm peel}\le2H\rho+LH                           \tag{6.6}
\]

on all members of (4.3).  This is a full-premise counterexample to the
**one-step quadratic filling policy**, including the exact leading
coefficient proposed in Gate VF.  It is not a counterexample to Gate VF,
which allows arbitrary further five-term moves.  Replacing the declared
outer-square split by the maximal common-exponent split can only add
coherent cost to `Q`; therefore it cannot repair (6.6).

### 6.3 A declared one-layer residual subcriticality is refuted

One might separately hope that the outer-square residual in (5.4) satisfies

\[
 R_{\rm peel}\le\varepsilon Q_{\rm peel}+K_\varepsilon H
                                                               \tag{6.7}
\]

for every `epsilon>0`.  This exact statement is also false.  Take
`t=2^k`, `k>=2`, and put `L=k log 2=log t`.  Since

\[
 Y=2^{k+1}(2^k+1),\qquad
 \operatorname{rad}(Y)\le2(2^k+1),
\]

we have `delta_Y>=L`.  The elementary size bounds

\[
 L\le u\le2L,qquad 2L\le v\le3L,qquad
 2L\le w\le4L                                      \tag{6.8}
\]

give

\[
 R_{\rm peel}\ge4\delta_Y(u+w)\ge12L^2,
 \qquad \Phi_{\rm sq}\le104L^2.                    \tag{6.9}
\]

Because `Q_peel=2 Phi_sq-R_peel<=2 Phi_sq`, at `epsilon=1/100`,

\[
 R_{\rm peel}-\frac1{100}Q_{\rm peel}
 \ge\left(12-\frac{208}{100}\right)L^2
 =\frac{248}{25}L^2.                                \tag{6.10}
\]

Also `H=2w<=8L`; hence the left side of (6.10), divided by `H`, is at
least `(31/25)L`, which is unbounded.  Thus (6.7) is **REFUTED for the
declared outer-square residual**.

This last retirement is intentionally narrow.  Maximal Veronese extraction
may reclassify some hidden perfect-power thickness inside `X`, `Y`, or `Z`
from `R` to `V`.  The proof above does not refute that different residual,
and no claim about infinitely many maximal exponent signatures is made.

## 7. Computational adversarial audit

The deterministic companion computation performs the following checks.

1. It enumerates every `1<=t<=20000`, factors `X,Y,Z`, and verifies all
   three integer identities in (4.2)--(4.4) and all three pairwise gcds.
2. It checks (5.5), (5.7), and (5.9) numerically after computing actual
   radical logs, and checks the exact radical-mass formula (6.2).
3. It records the largest ratios `R_peel/Q_peel` for both the declared
   outer-square split and the maximal common-exponent split.
4. It separately scans the subsequence `t=2^k` in the feasible factoring
   range and verifies the certified radical and size inequalities used in
   (6.8)--(6.10).

The frozen run checked 20,000 consecutive parameters and powers of two
through `2^18`.  Its smallest numerical margin in (6.4), after subtracting
`4uv`, was `8.682050349868`.  The largest declared outer-square ratio
`R_peel/Q_peel` was about `0.5464642242` at `t=119`; the largest
maximal-exponent ratio in the same range was about `0.5140333010` at
`t=1028`.  These maxima are finite-search observations and are not promoted
to universal bounds.

Finite computation is evidence against algebra or quantifier mistakes; it
is not used in the infinite proofs.  The producer, verifier, frozen JSON,
and hashes are stored in
`research/computation/quadratic_veronese_peeling_2026_09_02/`.

## 8. What survives

The specialization `y=x^2` proves a nontrivial structural fact: one
five-term move reduces the visible coherent square cost by more than one
half, asymptotically by a factor of four on the consecutive Pythagorean
family.  The same full-premise family proves that this move alone cannot
contract total positive area, cannot meet the proposed calibrated boundary
coefficient, and cannot make the declared one-layer residual uniformly
subcritical.

The surviving route must therefore use at least one further source of
geometry.  Plausible targets include a multi-move policy in which the new
divisors `d(x-y)` introduce prime support not already present in
`XYZ`, a signed norm that preserves useful cancellation before taking
absolute values, or a filling functional whose complexity penalty records
the number and height of auxiliary cells.  None is proved here.  No
full-premise counterexample to all such fillings was found, so the broader
five-term contact-complex route remains **OPEN**.

The exact status is:

| Statement | Status |
|---|---|
| Quadratic identity (2.3), exact domain, orientation sign | **PROVED** |
| Primitive integer transform (3.1)--(3.3) | **PROVED** |
| Pythagorean specialization (4.4) | **PROVED** |
| Cost conservation and redistribution (5.5)--(5.9) | **PROVED** |
| Layer-cake, layer-pair, and square-duplication identities | **PROVED** |
| Uniform bounded valuation-layer depth | **REFUTED on all premises** |
| Fixed one-move positive-area contraction | **REFUTED on all premises** |
| Fixed one-move calibrated-boundary bound (6.6) | **REFUTED on all premises** |
| Outer-square residual bound (6.7) | **REFUTED on all premises** |
| Arbitrary multi-move Veronese-calibrated filling | **OPEN** |
| Unconditional abc or a counterexample to abc | **OPEN** |

## 9. Formalization boundary

The companion Lean module follows this proof order.  It formalizes the
rational-domain reductions, complement sign, coefficientwise peeling,
primitive integer transform, consecutive Pythagorean identities, exact
scalar conservation and redistribution, the layer-cake and layer-pair
expansions, duplication of valuation layers under squaring, and the
unbounded layer-cutoff counterexample.  It then proves all three quantified
fixed-policy no-go statements: positive-area contraction, declared
outer-square residual subcriticality at `epsilon=1/100`, and the
calibrated-boundary estimate.  The outer-square theorem is deliberately not
stated for the maximal common-exponent residual.

The axiom-audit file prints all 53 public theorem declarations in the
module.  The computation independently replays the larger finite search.
The module does not postulate an open filling inequality and does not claim
`ABCConjecture`.
