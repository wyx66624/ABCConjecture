# Two successive norm compressions: a quartic unit, local lifting, and a content bound

Author: ChatGPT. Date: 2026-09-07.

**Status.** These are new ordinary proofs and exact computations for the next
research round. They do not assert the existence of an unbounded family
satisfying NT4. In particular, arbitrary depth at one prime is kept separate
from compression of the whole second norm. The already published paper and
Lean files are unchanged.

## 1. The second norm as an actual quartic object

Let `a,b` be coprime positive integers, `c=a+b`, `U=ab`, and

\[
M_0=a^2+ab+b^2=c^2-U.
\]

The first mixed transform is `(U,M_0,c^2)`. Its actual Eisenstein element and
norm are

\[
z_1=U+\zeta M_0,\qquad
M_1=U^2+UM_0+M_0^2
 =c^4-Uc^2+U^2
 =F(a,b),
\tag{1}
\]

where

\[
F(X,Y)=X^4+3X^3Y+5X^2Y^2+3XY^3+Y^4.
\tag{2}
\]

Here `zeta^2-zeta+1=0`, `bar zeta=1-zeta`, and `K=Q(zeta)`. In particular

\[
M_0^2<M_1\le\frac{13}{9}M_0^2,
\qquad \gcd(M_1,abcM_0)=1.
\tag{3}
\]

Indeed `0<U/M_0<=1/3`, by `M_0-3U=(a-b)^2>=0`; substitute in (1).
The gcd assertion is the primitive norm-boundary gcd theorem applied to the
first mixed transform, together with its exact inherited prime support.

There is also a useful elementary restriction:

\[
\boxed{M_1\equiv1\pmod3.}
\tag{4}
\]

Modulo three, (2) is `(a^2+b^2)^2`. Since `a,b` are not both zero modulo
three, their squared sum is one or two, and its square is one. Thus the
second norm has no ramified factor three.

### A fixed quartic field and an actual unit target

Let `alpha` be a root of

\[
P(X)=X^2+(2-\zeta)X+1,
\qquad L=K(\alpha).
\tag{5}
\]

Its discriminant is `d=-1-3 zeta`, of norm thirteen. It is not a square in
`K`: the norm of a square in `K` would be a rational square, whereas thirteen
is not. Therefore `[L:Q]=4`. Since

\[
\zeta=\frac{(\alpha+1)^2}{\alpha},
\]

one has `Q(alpha)=L`. Multiplying `P` by its coefficient conjugate gives
the minimal polynomial

\[
X^4+3X^3+5X^2+3X+1.
\tag{6}
\]

Its polynomial discriminant is `117`: the product of the two quadratic
discriminants is thirteen, while the squared resultant of the quadratics
is nine. The latter follows because their middle coefficients differ by
`zeta-bar zeta`, whose square is minus three, and both constant terms are
one. Only the polynomial discriminant is asserted here; no unproved maximal
order identification is needed below.

The direct factorization and norm identity are

\[
z_1=\zeta\big(a^2+(2-\zeta)ab+b^2\big),\qquad
\boxed{M_1=N_{L/\mathbb Q}(a-\alpha b).}
\tag{7}
\]

Moreover `alpha` is an algebraic unit, since `P` has constant term one, and

\[
(\alpha+\zeta)(\alpha+\bar\zeta)=-\bar\zeta\alpha.
\tag{8}
\]

Both factors on the left are algebraic integers; their product is a unit,
so each is a unit. Consequently

\[
\kappa=\frac{\alpha+\zeta}{\alpha+\bar\zeta}
\tag{9}
\]

is one fixed algebraic unit in the fixed quartic field. It is outside `K`:
if it belonged to `K`, it could not be one and
`alpha=(zeta-kappa bar zeta)/(kappa-1)` would belong to `K`, a contradiction.

For additional explicitness, putting `nu=kappa/zeta`, the quadratic relation
(5) gives

\[
\nu+\nu^{-1}=1-3\zeta,
\qquad \nu^4+\nu^3+9\nu^2+\nu+1=0.
\tag{10}
\]

For example, the relative norm and trace of `kappa` are `zeta^2` and
`3-2 zeta`. Dividing by `zeta` proves the first equality in (10); taking
its coefficient-conjugate product proves the second. The right side of the
first equality is nonreal under a complex embedding. Therefore `nu`, and
hence `kappa`, is not a root of unity: a unit-modulus complex number has
real `nu+nu^{-1}`.

For `z=a+b zeta`, solve for `a,b` using `z,bar z`. This gives the exact identity

\[
a-\alpha b
=\frac{(\alpha+\zeta)\bar z-(\alpha+\bar\zeta)z}
       {\zeta-\bar\zeta}.
\tag{11}
\]

Thus the second norm has become the norm of an explicit difference of two
terms with unit coefficients in one fixed extension; it is not an unspecified
new arithmetic object.

## 2. A positive small-prime theorem for the second norm

Suppose the first element is a genuine pure-power profile

\[
z=u(1+\zeta)^{e_0}w^g,
\quad e_0\in\{0,1\},\quad g\ge1,\quad Q=N(w)\ge7,
\tag{12}
\]

with the usual oriented split-prime factorization and primitive positive
coordinates. The root `w` and its norm primes are allowed to vary. Set
`eta=w/bar w`, and

\[
\kappa_{u,e_0}=\kappa u^{-2}\zeta^{-e_0}.
\]

The units `u` range over six roots of unity, so these are finitely many twists
of the same fixed quartic unit and have the same Weil height. Equation (11)
shows, at every place above `p|M_1`, that

\[
v_{\mathfrak p}(a-\alpha b)
=v_{\mathfrak p}(\eta^g\kappa_{u,e_0}^{-1}-1).
\tag{13}
\]

Here all omitted multiplicative factors are units at that place: `p` divides
neither `3` by (4) nor `Q` by (3), the two coefficient factors in (8) are
global units, and `zeta-bar zeta` is supported only over three. This includes
the prime thirteen; no good-reduction shortcut at that prime is needed.

**Theorem TC1.** There is an effective absolute constant `D>0` such that all
profiles (12) satisfy

\[
v_p(M_1)\le Dp^4\log Q\log(3+g)\quad(p\mid M_1),
\tag{14}
\]

and consequently, for real `Y>=2`,

\[
\log\prod_{\substack{p\mid M_1\\p\le Y}}p^{v_p(M_1)}
\le D\log Q\log(3+g)Y^5\log Y.
\tag{15}
\]

In particular, for `g>=1024` and `Y=g^(1/10)`, the full small-prime mass
divided by `log M_1` is at most

\[
\frac D{20}\frac{\log(3+g)\log g}{\sqrt g},
\tag{16}
\]

which tends to zero uniformly in the size and number of the norm primes of
`w`.

**Proof.** Use the first inequality in Theorem 1.3 of Bugeaud,
*B prime*, arXiv:2209.00275v1, already checked as a primary source in the
shared-generator checkpoint:
<https://arxiv.org/html/2209.00275v1>.
Apply it to `eta,kappa_{u,e_0}` with coefficients `g,-1` in the fixed field
of degree at most four. The product is not one: `eta^g` belongs to `K`
while `kappa_{u,e_0}` does not. The height inequalities give
`h*(eta)<=log Q`, and `h*(kappa_{u,e_0})` is an absolute constant.
The source estimate, with valuations normalized by `v_p(p)=1`, therefore
bounds each valuation in (13) by a constant times
`p^4 log Q log(3+g)`.

Pass carefully to the rational norm. If `ord_P` is the integral ideal
valuation, then

\[
v_p(M_1)=\sum_{P\mid p}f_P\operatorname{ord}_P(a-\alpha b)
        =\sum_{P\mid p}e_Pf_Pv_P(a-\alpha b).
\]

The weights satisfy `sum e_P f_P=4`, so enlarging one absolute constant
proves (14), including ramified places. Summing and using
`sum_{p<=Y}p^4 log p<=Y^5 log Y` proves (15).
Finally `M_1>M_0^2` and `M_0=3^{e_0}Q^g` give
`log M_1>=2g log Q`; substitution of `Y=g^(1/10)` proves (16).

This is a proved distribution estimate for the **second** norm. It does not
bound its radical from above, and it does not give the whole-norm compression
required by NT4. It says that any such second compression must account for
depth primarily at moving large primes.

## 3. A uniform second-content bound on every fixed-root orbit

Let `C>2` be the absolute constant in the already established one-block
Eisenstein two-place theorem. Its exact relevant inequalities are

\[
v_p(ABC)\le p^2\mathcal B,
\qquad
\mathcal B=C^2\log(3+h)\log Q_1
\le2C^2\log C_{\rm ht}\frac{\log(3+h)}h,
\tag{17}
\]

when the triple's Eisenstein element is a unit times a pure `h`th power of
norm `Q_1`. The symbol `C_ht` denotes the largest triple entry in this
display, to distinguish it from the absolute analytic constant.

**Theorem TC2 (fixed-root second-content bound).** In (12), fix `w` and let
`g` vary. Let `h` be the gcd of all the positive prime exponents in `M_1`.
For any prime `p|Q`, with `e=v_p(Q)>0`, one has

\[
\boxed{
\frac{h}{\log(3+h)}
\le\frac{2C^2p^2}{e}(\log Q+\log4).
}
\tag{18}

Thus `h` has an effective bound depending only on `w`, uniformly in `g`
and in the unit rotation used to put the primitive coordinates in the positive
sector.

**Proof.** By (4), `M_1` has no ramified factor three. Its oriented
Eisenstein factorization therefore gives an actual one-block representation
`z_1=u_1 W^h`; no algebraic root outside the ring has been introduced.
The boundary of the first transformed triple is `U M_0 c^2`, whose
`p`-valuation is at least `g e`. Apply (17) to that triple, with height
`t_1=log(c^2)`:

\[
ge\le2C^2p^2t_1\frac{\log(3+h)}h.
\]

The norm-height comparison `M_0>=3c^2/4` gives

\[
t_1\le\log M_0+\log(4/3)
\le g\log Q+\log4.
\]

Divide by `g`, use `g>=1`, and rearrange to obtain (18).
Since `h/log(3+h)` tends to infinity, the bound is effective.

This rules out unbounded pure second exponent content on one fixed primitive
root orbit. It does not rule out the second step's quotient-remainder
representations, and it does not cover roots with unbounded norm `Q` by a
constant independent of that norm.

### The earlier rho estimate and its subsequent refinement

**Updated status.** The rho estimate below alone leaves a remainder window.
The subsequent independently reviewed `lambda_refinement.md`, LR4, closes
the asymptotic `lambda_1->0` window for fixed first w and bounded lambda_0.
Its finite comparison with the NT4 threshold is still unproved. Moving roots
remain subject to the new support-escape necessary conditions, rather than
being excluded. The earlier derivation is retained to identify the precise
strength of the rho estimate itself.

More generally suppose the first profile is
`z=u(1+zeta)^e0 v_0 w^{g_0}`, still with fixed `w`, and write
`lambda_0=max(1,log N(v_0))/g_0`. If the first transform has any shared
quotient-remainder representation with parameter `rho_1`, the established
bound `v_p(T_1)<=A p^2 rho_1 t_1` gives the exact lower bound

\[
\rho_1\ge
\frac{e}{A p^2(\log Q+\lambda_0+(\log4)/g_0)}.
\tag{19}

Indeed `v_p(T_1)>=g_0 e` and
`t_1<=g_0 log Q+log N(v_0)+log4`.
If `rho_0->0`, then `lambda_0->0` and `g_0->infinity`; consequently

\[
\liminf\rho_1\ge\frac{e}{A p^2\log Q}>0.
\tag{20}

For a second extraction exponent `g_1` this forces its residual height to
obey `h_{v,1} >= const_w g_1/log(4+g_1)` eventually. Nevertheless its
ratio `lambda_1=h_{v,1}/g_1` is not prevented by (19)--(20) alone from tending
to zero at logarithmic speed. LR4 of the subsequent lambda refinement does
exclude that asymptotic behavior when w is fixed and lambda_0 is bounded.
Neither (19)--(20) nor the refined lower floor has been shown to exclude
NT4's specific finite lambda threshold.

## 4. A complete local obstruction at thirteen

**Theorem TC3.** For every primitive integer pair `(a,b)`,

\[
13\mid F(a,b)\quad\Longleftrightarrow\quad a\equiv b\pmod{13},
\]

and whenever these equivalent conditions hold,

\[
\boxed{v_{13}(F(a,b))=1.}
\tag{21}

**Proof.** Modulo thirteen,

\[
F(a,b)=(a-b)^2(a^2+5ab+b^2).
\]

The second quadratic has discriminant eight, which is not a square modulo
thirteen: the square residues are `0,1,3,4,9,10,12`. If `b=0` modulo
thirteen, primitivity makes `a` nonzero and `F(a,b)=a^4` nonzero. Otherwise
divide by `b^4` and use the displayed factorization to obtain the equivalence.

Write `a=b+13k`, with `13` not dividing `b`. The exact expansion is

\[
F(b+d,b)=d^4+7bd^3+20b^2d^2+26b^3d+13b^4.
\]

At `d=13k`, this is `13b^4` modulo `169`, hence has exact valuation one.

### An actual infinite high-first-content / content-one successor family

Take `w=2+zeta`, of norm seven. Exact ring arithmetic gives

\[
w^{12}\equiv1\pmod{13},\qquad
w^{10}\equiv6+6\zeta\pmod{13}.
\tag{22}
\]

For every exponent `g=10+12n`, the raw coordinates of `w^g` are therefore
equal and nonzero modulo thirteen. Infinitely many of those exponents give
both coordinates positive. To see this, let `theta=arg(w)`. The number
`theta/pi` is irrational: otherwise a power of `w/bar w` would be one,
contradicting the distinct oriented prime ideal factorizations at seven.
The irrational rotation by `12 theta` on the circle has a dense positive
orbit, so `10 theta+12n theta` visits the open sector `(0,pi/3)` infinitely
often. The density assertion is elementary: the closure of an infinite
cyclic subgroup of the circle has arbitrarily small nonzero angles and hence
approximates every angle; the positive orbit has the same closure, and every
tail has that closure too.

For those exponents the actual pair is positive and primitive: a common
rational prime divisor of its two coordinates would force both conjugate
prime factors above seven into `w^g`. Its first norm is exactly `7^g`,
so its first pure content tends to infinity and its first rho tends to zero.
But (21) forces the second norm's content to be exactly one.

This is a complete infinite counterfamily to automatic transport of high
first content to high pure second content. A one-prime remainder at thirteen
can still be admitted in a shared representation; no bound on that corrected
representation is inferred just from (21).

## 5. Positive arbitrary-depth lifting at sixty-seven

The second norm is not universally squarefree. More strongly, one of its
prime depths can be made arbitrarily large on the same fixed-root orbit.

Continue with `w=2+zeta` and put `p=67`. Here `F(w^g)` means `F` applied
to the two integer coordinates of `w^g`. Exact calculations give

\[
F(2,1)=67,\qquad
w^{66}\equiv3954+1541\zeta
=1+67(59+23\zeta)\pmod{67^2}.
\tag{23}
\]

Let `Delta=(w^{66}-1)/67`, which is an actual Eisenstein integer. Its
coordinates modulo 67 are `(59,23)`. Multiplication by `w` gives
`w Delta=(28,61)` modulo 67. Since

\[
\partial_aF(2,1)=91,\qquad \partial_bF(2,1)=86,
\]

the exponent-direction derivative is

\[
91\cdot28+86\cdot61\equiv22\pmod{67},
\tag{24}
\]

a unit.

**Theorem TC4 (an infinite compatible local tower).** For every `k>=1`,
there is exactly one residue class

\[
g\equiv g_k\pmod{66\cdot67^{k-1}}
\tag{25}
\]

within the initial exponent class `g=1 mod66` on which
`67^k | F(w^g)`. The classes lift compatibly. The first values are

\[
g_1=1,\quad g_2=199,\quad g_3=9043,\quad g_4=7415893.
\tag{26}
\]

For each fixed depth `k`, infinitely many positive primitive triples with
first norm exactly `7^g` have second norm divisible by `67^k`.

**Proof.** By the binomial theorem in the commutative Eisenstein ring,

\[
(w^{66})^{67^{k-1}}
\equiv1+67^k\Delta\pmod{67^{k+1}}.
\tag{27}
\]

One can prove (27) inductively: raising `1+67^j Delta` to the 67th power
leaves the first-order term modulo `67^{j+2}`; all later binomial terms have
at least that valuation, since `67` is odd and `j>=1`.

Suppose `67^k | F(w^g)` and `g=1 mod66`. Changing the exponent to
`g+66*67^{k-1}j` multiplies its coordinates by
`1+j67^k Delta` modulo `67^{k+1}`. A polynomial Taylor expansion, whose
terms of degree at least two vanish at this modulus, gives

\[
F(w^{g+66\cdot67^{k-1}j})
\equiv F(w^g)+22j67^k\pmod{67^{k+1}}.
\tag{28}
\]

Here `w^g=w` modulo 67, so (24) gives the same derivative at every stage.
There is exactly one `j mod67` which kills the next digit. The base class
works by `F(w)=67` and `w^{66}=1 mod67`. Induction proves the compatible
unique classes (25). The first correction is `j=3`, since
`1+22*3=67`; hence `g_2=1+66*3=199`.

For a fixed class (25), the same irrational-rotation argument used after
(22) supplies infinitely many positive raw pairs, with unbounded exponents.
They are primitive and have norm `7^g` by the oriented factorization. This
proves the last assertion.

The exact local example at `g=199` already has both raw coordinates negative,
so multiplication by minus one makes them positive without changing the
quartic. Its coordinates are recorded in the replay JSON; the second norm
has 337 decimal digits and **exact** 67-adic valuation two. Its complete
factorization was not attempted. This example is used only to refute universal
squarefreeness and to check the lifting calculation, never to claim small rho
or whole-norm compression.

TC4 and TC2 are compatible. TC4 controls one local exponent, while TC2
controls the gcd of all the second norm's exponents. High local depth is
possible even when other primes keep the global content small.

### Two distinct primes can be lifted simultaneously

The preceding tower is not limited to isolated one-prime examples. Select a
different root class at 67 and a compatible class at 967. Exact arithmetic gives

\[
\begin{array}{c|c|c|c|c|c}
p&d&g_1& (w^d-1)/p\pmod p&w^{g_1}\pmod p&D_p\\\hline
67&66&21&(59,23)&(33,66)&7\\
967&966&651&(759,279)&(53,172)&39
\end{array}
\tag{29}
\]

Here `w^d=1 mod p`, the coordinate quartic vanishes at `w^{g_1}` modulo
`p`, and `D_p` is the polynomial derivative along the exponent direction,
computed exactly as in (24). Both derivatives are nonzero. The first lifts
are respectively `1275 mod (66*67)` and `77931 mod (966*967)`.

**Theorem TC5 (simultaneous two-prime local compatibility).** For every pair
`k,ell>=1`, there is an exponent class containing infinitely many actual
positive primitive pairs with first norm `7^g` and

\[
67^k\,967^{\ell}\mid M_1.
\tag{30}
\]

**Proof.** Apply the proof of TC4 separately using the two rows of (29).
It gives a class modulo `66*67^{k-1}` and a class modulo
`966*967^{ell-1}`. Both remain congruent to three modulo six, since their
initial representatives are 21 and 651 and each lifting period is a multiple
of six. Since

\[
66=2\cdot3\cdot11,\qquad966=2\cdot3\cdot7\cdot23,
\]

and neither of the distinct primes 67 and 967 divides the other base period,
the two moduli have gcd exactly six at every pair of depths. The generalized
Chinese remainder theorem therefore supplies a common class. For depth one
at both primes it is `g=7413 mod10626`. The same irrational-rotation argument
then gives infinitely many positive raw pairs in each common class.
Their primitivity and first norm follow from the oriented factorization.

This is simultaneous compatibility at two distinct primes, with arbitrary
independently selected depths. It still does not control the rest of `M_1`.
Indeed TC1 implies that for any fixed finite set of primes its entire
valuation mass is `o(log M_1)` as `g` tends to infinity. Thus (30) is a
positive local construction, not whole-norm compression or NT4's premise.

## 6. Certified finite reconnaissance

The script
`computation/two_step_compatibility.py` has no external dependencies and
replays the following checks using integer arithmetic:

- The first twelve positive rotations of `(2+zeta)^g` have complete second
  norm factorizations, each verified by multiplication and trial-division
  primality proofs. All twelve second norms are squarefree, hence any nonempty
  second quotient-remainder extraction has exponent `g_1=1` and
  `lambda_1>=1`; none passes NT4's threshold.
- The thirteen-adic root and exact-depth identities are checked over their
  complete relevant residue sets.
- Eight sixty-seven-adic lifting levels are verified modulo their exact
  prime powers, including the derivative 22 and `g_2=199`.
- Thirty-six simultaneous depth pairs, with both depths from one to six,
  are verified for the compatible 67/967 classes in TC5.
- The `g=199` positive pair has exact local depth two at 67.

The result is `computation/two_step_compatibility_output.json` and the replay
exited successfully. The finite squarefree observations are not extrapolated:
the explicit `g=199` example already prevents that extrapolation.

## 7. Remaining positive compatibility program

The actual new object is the fixed quartic unit `kappa`, and the actual
second divisor is `N_{L/Q}(a-alpha b)`. At primes on that divisor, its depth
is governed by the shifted equation `eta^g=kappa_{u,e_0}` in the residue
field and its lifts. TC4 proves that this local target can be hit to every
depth at one specific prime. TC1 proves that small rational primes cannot
carry a positive proportion of the second norm as the first pure exponent
grows, uniformly even when the first root varies.

What remains is global correlation: arrange high depth at enough of the
second norm's **entire** support while retaining a small enough remainder.
Fixed roots forbid an unbounded pure second content by TC2, but their
growing-remainder window remains live; moving roots with unbounded norm also
remain live. Neither the local lifting theorem nor the quartic factorization
asserts that NT4's two lambda bounds can be simultaneously achieved.

The next precise positive actions are to study the simultaneous shifted
targets attached to several second-norm primes in this fixed quartic field,
retain the exact residual norm in any reconstruction, and measure whether
the required residual height lies above or below the NT4 threshold. A finite
search with no hit does not close that gate.

## 8. Review scope

The fixed-root obstruction and the quartic-unit transfer were developed in
discussion with the other research agents. The parent agent and the independent
`adversarial_audit` agent reviewed TC1--TC4, including valuation normalization,
ramified places, unit rotations and the full local lifting induction, and found
the arguments correct. The `critical_bottleneck` agent independently reviewed
TC1 and its fixed-field units and constants. The `adversarial_audit` agent
independently replayed both new local derivatives and lifts in TC5, all 36
depth-pair gcd and residue compatibilities, and confirmed its proof by lifting,
CRT and positive-sector density. These are research-agent reviews, not external journal
peer review. The exact finite replay is complete and separate from the ordinary
proof review. No theorem in this note is yet claimed to be Lean-verified.
