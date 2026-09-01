# A global auxiliary Mordell construction and its pure cubic field

Author: ChatGPT. Date: 2026-08-30.

Status: mathematical proofs written first; the elementary companion passed
Lean 4.32.0 on 2026-08-30 with no errors or warnings. The results below concern **every** positive primitive triple
`a+b=c`, not only the earlier Pell--Chebyshev packet. They do not prove abc.
The external analytic input is Pasten's 2026-08-24 preprint, not a new axiom.

## 1. Notation and the primary input

Throughout, `a,b,c` are positive integers, `a+b=c`, and `gcd(a,b)=1`.
Thus all three pairs are coprime and `c>=2`. Put `H=log c`.
Write the unique cube decompositions

\[
a=A u^3,\qquad b=B v^3,\qquad c=C w^3,
\]

where `A,B,C` are positive cube-free integers. These coefficients, as well
as the three original endpoints, are pairwise coprime. Define

\[
R_0=\prod_{p\mid abc,\;3\nmid v_p(abc)}p=\operatorname{rad}(ABC),\qquad
R_3=\prod_{p\mid abc,\;3\mid v_p(abc)}p.
\]

Pasten defines `underline(k)=prod_(p|k) p^min(2,v_p(k))`. For every nonzero
integer `k` and every integral solution of `y^2=x^3+k`, his Theorem 1.3 gives

\[
\log\max\{|x|,|y|\}\le C_P\sqrt{\underline{k}}
 [\log(2\underline{k})]^2\log(2|k|)
 \log\!\bigl(\underline{k}\log(3|k|)\bigr),                 \tag{1.1}
\]

for an effective absolute constant `C_P`. There is no assumption that `x`
is positive, that `y` is nonzero, or that the point or the model is primitive.
Theorem 1.7, its case of no finite places, and the reduction and covariant
argument in Section 4 will also be used, with all changing parameters
identified below. [Pasten, v1](https://arxiv.org/abs/2608.23559v1).

Local original PDF:
`research/sources/arithmetic_geometry_2026_08_30/Pasten_2026_08_24_2608_23559v1.pdf`.
No claim of prior-publication novelty is made for the consequences below.

## 2. Three actual integral points, with no loss of abc height

Set

\[
\begin{array}{c|c|c|c|c|c}
\text{omitted endpoint }n_i& d_i&r_i&x_i&y_i&k_i\\ \hline
a&vw&BC&4d_i r_i&4r_i(a+2b)&16(a r_i)^2\\
b&uw&AC&4d_i r_i&4r_i(2a+b)&16(b r_i)^2\\
c&uv&AB&-4d_i r_i&4r_i(a-b)&16(c r_i)^2
\end{array}                                                   \tag{2.1}
\]

**Proposition 2.1.** Each row is an integral solution of
`y_i^2=x_i^3+k_i`, with `k_i>0`, and

\[
 |x_i|^3\ge32c,\qquad H\le3\log|x_i|.                         \tag{2.2}
\]

**Proof.** In the three rows respectively,
`bc=d_i^3 r_i`, `ac=d_i^3 r_i`, and `ab=d_i^3 r_i`. The identities

\[
(a+2b)^2=a^2+4bc,\quad (2a+b)^2=b^2+4ac,\quad
(a-b)^2=c^2-4ab
\]

prove the Mordell equations after multiplication by `16r_i^2`. The minus
sign in `x_c` is essential. All entries are integers and `n_i r_i>=1`.
Moreover, `|x_i|^3` equals `64r_i^2` times the selected pair product.
The products `ac,bc` are at least `c`. Finally,

\[
ab\ge a+b-1=c-1\ge c/2
\]

by `(a-1)(b-1)>=0` and `c>=2`. Taking logarithms proves (2.2).
The only possible zero `y_i` is harmless; for example `(a,b,c)=(1,1,2)`
in the last row gives `x_c=-4,y_c=0,k_c=64`. QED.

The same proof works for any positive extraction `pair=d^3 r`; maximal
cube extraction is needed only for the precise support statements below.

## 3. Exact prime costs and a saving that is not a fixed constant

Let

\[
s_i=n_i r_i,\qquad \rho_i=\operatorname{rad}(2s_i).
\]

**Proposition 3.1.** For the three integral points in (2.1),

\[
\underline{k_i}=\rho_i^2,\qquad
\rho_a\rho_b\rho_c
=4^{\mathbf 1_{3\mid v_2(abc)}}R_0^3R_3.                    \tag{3.1}
\]

Consequently,

\[
\min_i\rho_i\le 2^{2/3}R_0R_3^{1/3}.                       \tag{3.2}
\]

If `2` is omitted from the definitions of both `R_0` and `R_3`, the exact
product is instead `8 R_(0,odd)^3 R_(3,odd)`, so the corresponding minimum
bound has constant `2`. There is no forced prime `3` in `k_i=16s_i^2`;
the factor `3` enters only in the later binary cubic discriminant.

An equivalent exact factored form, used by the Lean companion, is
`rho_a rho_b rho_c = rad(2ABC)^2 rad(2abc)`. Since `abc` is even,
`rad(2abc)=rad(abc)`; the first factor contains the forced-prime correction
already displayed in (3.1).

**Proof.** Each prime divisor of `16s_i^2` has valuation at least two, and
its support is exactly the support of `2s_i`. This proves the first identity.
Fix an odd prime dividing `abc`, and write its unique endpoint valuation
as `e`; uniqueness follows from primitivity. If `3` does not divide `e`,
the prime occurs both in that endpoint and in its cube-free coefficient,
so it occurs in all three `rho_i`. If `3` divides `e`, its cube-free
coefficient has valuation zero, so it occurs only in the cost whose omitted
endpoint is its own endpoint. This proves the odd-prime ledger.
The integer `abc` is even. Each `rho_i` contains `2`, whereas `R_0^3R_3`
contains `2^3` or `2` according as `3` does not or does divide `v_2(abc)`.
This gives the exact correction in (3.1). The least of three positive
numbers does not exceed their geometric mean. QED.

Applying (1.1) and (2.2) now gives, for **each** row,

\[
H\le3C_P\rho_i[\log(2\rho_i^2)]^2
 \log(32s_i^2)\log\!\bigl(\rho_i^2\log(48s_i^2)\bigr).       \tag{3.3}
\]

**Proposition 3.2.** The saving in the prime cost, relative to
`rad(abc)`, is unbounded over actual primitive abc triples.

**Proof.** Let `q` be an odd prime and set `a=q^3,b=1,c=q^3+1`.
Use the valid, possibly nonmaximal extraction `ac=q^3 c`, that is `d=q,r=c`,
in the omit-`b` row. Its cost is `rad(2c)=rad(c)`, since `c` is even.
But `q` does not divide `c`, so `rad(abc)=q rad(c)`. Maximal cube extraction
can only reduce this new cost further. The factor `q` is unbounded. QED.

This does not contradict the earlier weighted-primitivity theorem for a
different Mordell point. The operation here first passes to a different
auxiliary curve and then divides its coordinates by a square and a cube.

## 4. Relation to the actual Frey invariants: an auxiliary 3-isogeny only

Put `m=abc`, `Q=a^2+ab+b^2`, and `T=(a-b)(2a+b)(a+2b)`.
On the auxiliary curve `E_k: y^2=x^3+k`, `k=16m^2`, the unscaled omit-`b`
point is

\[
(x_0,y_0)=(4ac,\,4ac(2a+b)).
\]

The rational map

\[
\phi_k(x,y)=
\left(\frac{x^3+4k}{x^2},\frac{y(x^3-8k)}{x^3}\right)       \tag{4.1}
\]

sends it to `(4Q,4T)` on `E_(-27k)`. Indeed, substitution in each coordinate
gives these expressions. The identity

\[
(z+k)(z-8k)^2-(z+4k)^3=-27kz^2
\]

also proves the target equation whenever `y^2=x^3+k` and `x!=0`.
For `k!=0`, both smooth projective curves are elliptic. The nonconstant
map extends across the omitted points, sends infinity to infinity, and has
degree three: its map on the degree-two `x` coordinates is the rational
function `(x^3+4k)/x^2` of degree three. Thus (4.1) is the usual 3-isogeny
between these two **auxiliary `j=0` curves**.

For the integral Frey curve `y^2=x(x-a)(x+b)`,
`c_4=16Q,c_6=32T`. The target point therefore equals `(c_4/4,c_6/8)`.
This is an identity involving its invariants; the original Frey curve
does **not** thereby become 3-isogenous to an auxiliary `j=0` curve.
After an extraction `ac=d^3r`, the source becomes the integral point in
(2.1), whereas its target becomes the generally rational point
`(4Q/d^2,4T/d^3)`. This explains why primitivity of the earlier integral
target does not prevent the present saving.

## 5. The actual root fields, including the negative-x branch

For each row form the monic cubic

\[
G_i(Z)=Z^3-3x_iZ+2y_i,\qquad
\operatorname{disc}(G_i)=-108k_i=-1728s_i^2.                 \tag{5.1}
\]

Consider first the omit-`b` row. Take the positive real algebraic numbers

\[
\alpha=\sqrt[3]{A^2C},\qquad
\beta=\sqrt[3]{AC^2}=\alpha^2/A.
\]

They satisfy `alpha^2=A beta`, `beta^2=C alpha`, and `alpha beta=AC`.
Expanding a cube shows that

\[
\tau_b=-2(u\alpha+w\beta)
\]

is a root of

\[
G_b(Z)=Z^3-12uwACZ+8AC(Au^3+Cw^3).                         \tag{5.2}
\]

If `AC>1`, the integer `A^2C` is not a cube: at a prime of `A` its
valuation is two or four, and at a prime of `C` it is one or two. Thus
`Z^3-A^2C` is irreducible over `Q`; `1,alpha,alpha^2` are independent.
In particular `tau_b` is not rational. A nonrational element of this
degree-three field generates it, and its displayed cubic is irreducible.
Consequently

\[
K_b=\mathbb Q(\tau_b)=\mathbb Q(\sqrt[3]{A^2C}).             \tag{5.3}
\]

The omit-`a` row has the identical plus-sign calculation with `(B,C,v,w)`.
The omit-`c` row is different in sign. With
`alpha=cuberoot(A^2B)` and `beta=cuberoot(AB^2)`, its root is

\[
\tau_c=-2(u\alpha-v\beta),
\]

and direct expansion gives

\[
G_c(Z)=Z^3+12uvABZ+8AB(Au^3-Bv^3).                         \tag{5.4}
\]

If `AB>1`, independence of `1,alpha,alpha^2` still rules out a rational
root, including zero. Hence `K_c=Q(cuberoot(A^2B))`. No sign or positivity
of `a-b` is needed. All these irreducible fields have signature `(1,1)`.
In each row, reducibility occurs exactly when the selected product `r_i`
is `1`. That exceptional case is handled directly in Section 8 below.

## 6. An explicit order and the omitted endpoint as its exact index

In an irreducible row write its two cube-free coefficients as `E,F`,
its cube bases as `h,j`, and put `r=EF`. Set
`alpha=cuberoot(E^2F)`, `beta=cuberoot(EF^2)`.
The rank-three lattice

\[
\mathcal O=\mathbb Z\{1,\alpha,\beta\}
\]

is an order: its elements are integral, and its multiplication is closed
by `alpha^2=E beta`, `beta^2=F alpha`, `alpha beta=r`.
The trace matrix of this basis is

\[
\begin{pmatrix}3&0&0\\0&0&3r\\0&3r&0\end{pmatrix},
\quad\text{so}\quad \operatorname{disc}(\mathcal O)=-27r^2. \tag{6.1}
\]

In a plus-sign row, `tau=-2(h alpha+j beta)`. The coordinates of
`1,tau,tau^2` in that order basis are the columns of

\[
M_+=\begin{pmatrix}
1&0&8hjr\\0&-2h&4Fj^2\\0&-2j&4Eh^2
\end{pmatrix},\qquad
\det M_+=8(Fj^3-Eh^3).                                    \tag{6.2}
\]

This difference is the omitted endpoint `a` or `b`. In the minus-sign
row, `tau=-2(h alpha-j beta)`, the corresponding matrix is

\[
M_-=\begin{pmatrix}
1&0&-8hjr\\0&-2h&4Fj^2\\0&2j&4Eh^2
\end{pmatrix},\qquad
\det M_-=-8(Eh^3+Fj^3)=-8c.                               \tag{6.3}
\]

Since `tau` satisfies its monic cubic, `Z[tau]` has basis `1,tau,tau^2`.
Thus the integer lattice index is **exactly**

\[
[\mathcal O:\mathbb Z[\tau_i]]=8n_i.                       \tag{6.4}
\]

This gives the discriminant in (5.1) by an independent computation.

There is a useful larger order. Write `E=E_1 E_2^2`, `F=F_1 F_2^2`, with
the four factors pairwise coprime and squarefree. Put

\[
s=E_2F_1,\quad t=E_1F_2,\quad
\theta=\sqrt[3]{st^2},\quad \eta=\theta^2/t.
\]

Here `s,t` are coprime squarefree integers and
`st=S_i=rad(r_i)`. The lattice `O'=Z{1,theta,eta}` is an integral order:
`theta^2=t eta`, `theta eta=st`, `eta^2=s theta`. Its discriminant is

\[
\operatorname{disc}(\mathcal O')=-27S_i^2.                  \tag{6.5}
\]

Indeed its trace matrix is (6.1) with `r` replaced by `st`.
Moreover `alpha=E_2 theta`, `beta=F_2 eta`, so

\[
[\mathcal O':\mathcal O]=E_2F_2=r_i/S_i,
\quad
[\mathcal O_K:\mathbb Z[\tau_i]]
=8n_i(r_i/S_i)[\mathcal O_K:\mathcal O'].                   \tag{6.6}
\]

In particular the **field**, rather than just the displayed polynomial,
has discriminant satisfying

\[
|\Delta_{K_i}|\mid 27S_i^2,\qquad |\Delta_{K_i}|\le27S_i^2. \tag{6.7}
\]

Equation (6.6) identifies a real source of the remaining height cost:
the monogenic order index contains `8n_i`. A fixed field discriminant or
a fixed regulator does not bound this varying order index or the point.

There is also an exact denominator interpretation. Put `N=ABC` and
`t_a=u,t_b=v,t_c=w`. Then `s_i=N t_i^3`, so the rational points

\[
(X_i,Y_i)=(x_i/t_i^2,\,y_i/t_i^3)
\]

all lie on the **same** curve

\[
E_*:\quad Y^2=X^3+16N^2.                                  \tag{6.8}
\]

Primitivity gives `gcd(t_i,d_i r_i)=1`, since `t_i` divides the omitted
endpoint while `d_i r_i` is supported on the other two endpoints. Thus
the reduced positive denominator of `X_i` is exactly

\[
\operatorname{den}(X_i)
=\frac{t_i^2}{\gcd(t_i^2,4d_i r_i)}
=\frac{t_i^2}{\gcd(t_i^2,4)}
=\left(\frac{t_i}{\gcd(t_i,2)}\right)^2.                    \tag{6.9}
\]

The sign of `x_i` does not affect this calculation. This uses only coprime
denominator reduction and `gcd(t_i^2,2^2)=gcd(t_i,2)^2`. In particular,
removing the cube bases from `k_i` loses integrality as soon as
`t_i/gcd(t_i,2)>1`. An integral-point theorem for the fixed parameter in
(6.8) does not bound these rational points of growing denominator.

## 7. Retaining the pure cubic regulator in Pasten's proof

Define for every row

\[
S_i=\operatorname{rad}(r_i),\qquad L_i=\log(2n_i r_i).
\]

**Theorem 7.1 (full-family relative height bound).** There is an effective
absolute constant `C>0` such that, for every positive primitive abc triple
and each of the three endpoint choices,

\[
H\le C S_i[\log(2S_i)]^2 L_i\log(3S_iL_i).                 \tag{7.1}
\]

The constant does not depend on the endpoints, cube-free coefficients,
root field, unit group, or cube bases.

**Proof in the irreducible case.** Let `G_i(U,V)` be the homogenization of
(5.1) and `D=1728(n_i r_i)^2`. Section 4 of Pasten, with its stated
Baker--Stark reduction, supplies `gamma in GL_2(Z)` and `F=G_i o gamma`
with coefficient height `H_F<=sqrt(D)`. Set `(u_0,v_0)=gamma^(-1)(1,0)`.
Then `F(u_0,v_0)=1` and `gcd(u_0,v_0)=1`. This step is necessary:
applying a Thue estimate just to `G_i(1,0)=1` would not control the
coefficients or the original point.

The root fields of `F(U,1)` and `G_i(U,1)` agree by the inverse fractional
linear change of root. Its denominators cannot vanish at these degree-three
roots. Apply Pasten's Theorem 1.7 with empty prime list, `m=w=1`, and only
the archimedean places. Its place set therefore has size `2`, its
`P_+=2`, and its `S`-regulator is the ordinary `R=R_(K_i)`. In particular
no varying splitting-field prime, rank, or prime list enters a constant.
For `X=max(3,|u_0|,|v_0|)` that theorem gives an effective absolute `C_1`
with

\[
\log X\le C_1\{\log(2D)+
 R\log(2D)\log(2+2R\log(2D))\}.                            \tag{7.2}
\]

The Hessian and Jacobian recovery in the same Section 4 gives a further
effective absolute `C_2` such that

\[
\log\max(2,|x_i|,|y_i|)\le C_2(\log|k_i|+\log X).          \tag{7.3}
\]

These covariants have fixed degrees; (7.3) is not a bound for the height of
the auxiliary curve in place of the height of its point.

Put `R*=max(1,R)`. Since `L_i>=log 2`,
`log(2D)<=12L_i` and `log|k_i|<=4L_i`. Equations (2.2), (7.2), and (7.3)
give an effective absolute `C_0` with

\[
H\le C_0 R^*L_i\log(3R^*L_i).                             \tag{7.4}
\]

For clarity, this absorption uses only a fixed argument change in a
logarithm, not removal of an unknown point-height factor. For `z>=log 2`
one has `log(2+24z)<=8log(3z)`; indeed `z>=1/2` implies
`2+24z<=28z<=(3z)^8`. Thus a constant depending only on `C_1,C_2` suffices.

Let `C_L` be a valid effective degree-three constant in Landau's regulator
bound, as recorded in Pasten's Lemma 2.2. The class number is at least one,
so (6.7) yields

\[
R\le C_L\sqrt{|\Delta_K|}(\log|\Delta_K|)^2
\le25\sqrt{27}C_L S_i[\log(2S_i)]^2.                       \tag{7.5}
\]

Here `log(27S_i^2)<=5log(2S_i)`. One may therefore take

\[
C_R=\max\{1,(\log2)^{-2},25\sqrt{27}C_L\}
\]

so that `R*<=C_R S_i[log(2S_i)]^2`. To check explicitly that substituting
this inequality causes no extra logarithmic power, put
`B=log(2S_i)` and `z=S_iL_i>=log2`. The elementary estimates
`B<=2S_i` and `L_i>=1/2` give

\[
3C_R S_i B^2L_i\le48C_R z^3
=\frac{16C_R}{9}(3z)^3.
\]

Consequently

\[
\log(3C_R S_iB^2L_i)\le
C_{\log}\log(3S_iL_i),\quad
C_{\log}=3+\frac{\log(16C_R/9)}{\log(3\log2)}.              \tag{7.6}
\]

All displayed denominators are positive. Equations (7.4)--(7.6) prove
(7.1) with `C=C_0 C_R C_log` in the irreducible case.

## 8. Reducible rows and precise limits of logarithmic absorption

If `r_i=1`, the selected endpoints are both cubes. In the omit-`a` or
omit-`b` row write the larger as `w^3` and the smaller as `h^3`, with
`w>=h+1`. Their difference is the omitted endpoint `n_i`, and

\[
n_i=w^3-h^3\ge w^3-(w-1)^3\ge w^2.
\]

Thus `H=3log w<=3log(n_i)/2<=3L_i/2`. In the omit-`c` row one simply has
`H=log n_i<=L_i`. Since `S_i=1`, (7.1) follows uniformly after also requiring

\[
C\ge\frac{3}{2(\log2)^2\log(3\log2)}.
\]

This completes the proof of Theorem 7.1, including all reducible cases.

Some consequences and boundaries can now be stated without hiding a
self-dependent height term. First, cube-freeness gives `r_i<=S_i^2`, so
(7.1) remains valid if `L_i` is replaced by

\[
M_i=\log(2n_i)+2\log S_i.
\]

The replacement is monotone for `L_i>=log2`. Also

\[
S_aS_bS_c=R_0^2,\qquad \min_i S_i\le R_0^{2/3}.             \tag{8.1}
\]

Choosing the omitted endpoint to be `m=min(a,b)` instead gives the useful
gap estimate

\[
H\le C R_0[\log(2R_0)]^2
 [\log(2m)+2\log R_0]
 \log\!\bigl(3R_0[\log(2m)+2\log R_0]\bigr).               \tag{8.2}
\]

For any fixed bound `R_0<=R_*`, (8.2) forces
`log m >>_(R_*) H/log H` as `H` tends to infinity: `m<c` gives the
bracket at most `H+log2+2log R_*`, so the last logarithm is at most
`log H+O_(R_*)(1)`. Rearrange (8.2), then absorb the fixed additive constants
once `H` is sufficiently large. This is a necessary structure of an
unbounded family, not a finiteness assertion for fixed `R_0`.

On the other hand, (8.1) alone does not control the endpoint `n_i` selected
by its small support. In general `L_i` can be comparable to `H`. Cancelling
`H` from a bound of shape `H<=C_R H log H` leaves no upper bound for it.
Nor may `D=1728(n_i r_i)^2` in (7.2) be replaced by the field discriminant:
the exact index (6.6) displays the missing factor. These are identified
uncontrolled quantities, not counterexamples to abc or reasons to abandon
the entire route. The root agent is independently checking a fixed-`R_0`
infinite family; no such unverified construction is used in this proof.

## 9. Formalization boundary and next arithmetic target

The substantive new full-family objects are the three actual integral
points, their prime-cost ledger, their identified pure cubic fields and
small-discriminant orders, and the exact omitted-endpoint order index.
The unconditional analytic consequence (7.1) uses stated unconditional
inputs, including Pasten's 2026 preprint,
with every parameter fixed as above. It is not an assumed height inequality.

The independent Lean companion is restricted to direct integer/ring and
finite-matrix consequences of these proofs. It must not introduce Pasten,
Landau, a height bound, or abc as an axiom. Any part of number-field order
theory or analytic input not actually formalized must remain visibly in
this mathematical report. In particular, formal coordinate identities for
(4.1) alone do not construct an isogeny in Lean.

The remaining global task is to control the growing index/point-height
factor using the **actual arithmetic** of the omitted endpoint and its
cube-divisible prime factors. Neither the isogeny identity, (3.2), nor
the smaller root-field discriminant currently supplies that control.

## 10. The three rational points form one rational 3-torsion orbit

Use the common curve (6.8) and write its three rational points as
`Q_a,Q_b,Q_c`. They are affine points, since all cube bases are positive.
The point `T_0=(0,4N)` lies on `E_*` and has order three. In fact its
tangent is horizontal, so the chord-and-tangent rule gives
`2T_0=(0,-4N)=-T_0`; it is not the point at infinity because `N>0`.

**Proposition 10.1.** With the signs of (2.1),

\[
Q_b+T_0=Q_c,\qquad Q_b-T_0=-Q_a.                           \tag{10.1}
\]

**Proof.** The slope from `T_0` to `Q_b` is

\[
\frac{4AC(2a+b)/v^3-4ABC}{4uwAC/v^2}
=\frac{2Au^2}{vw}.
\]

Subtracting `X(Q_b)` from its square gives
`-4ABuv/w^2=X(Q_c)`, since `Au^3-Cw^3=-Bv^3`. The new ordinate, computed
from the point `T_0`, is

\[
-\frac{2Au^2}{vw}\left(-\frac{4ABuv}{w^2}\right)-4ABC
=\frac{4AB(a-b)}{w^3}=Y(Q_c).
\]

Likewise the slope from `-T_0` to `Q_b` is `2Cw^2/(uv)`. Its square minus
`X(Q_b)` is `4BCvw/u^2=X(Q_a)`, and the new ordinate is

\[
-\frac{2Cw^2}{uv}\frac{4BCvw}{u^2}+4ABC
=-\frac{4BC(a+2b)}{u^3}=-Y(Q_a).
\]

All denominators used here are nonzero. QED.

Thus the three denominator formulas (6.9) describe three translates of
one rational point, not unrelated points on varying curves. If
`V=uvw`, the isogeny (4.1) on `E_*` maps these three distinct points
`Q_b,Q_c,-Q_a` to the single point

\[
(4Q/V^2,4T/V^3)\quad\hbox{on}\quad Y^2=X^3-432N^2.
\]

The opposite sign for the image of `Q_a` is required. This remains an
isogeny of the two auxiliary `j=0` curves, not of the original Frey curve.

## 11. Fixed residual support forces asymptotic equality of endpoint logs

For the next result, the needed form of Siegel is the **local approximation
theorem**, not merely finiteness of integral points. On any fixed elliptic
curve `E/Q`, with its even Weierstrass function `x`, it implies

\[
\frac{\log\max\{1,|x(P)|\}}{h_x(P)}\longrightarrow0
\quad\text{as }P\in E(\mathbb Q),\ h_x(P)\longrightarrow\infty. \tag{11.1}
\]

Here `h_x(P)=log max(|A_x|,B_x)` when `x(P)=A_x/B_x` is reduced and
`B_x>0`. This is the specialization `Q=O,f=x,v=infinity` of Silverman's
Theorem IX.3.1; Example IX.3.3 explicitly makes that specialization.
If `E(Q)` is finite the corresponding eventual assertion is vacuous.
No assertion about a curve varying with `P` is contained in (11.1).
[Silverman, *The Arithmetic of Elliptic Curves*, second edition, 2009,
pp. 276, 278--279](https://doi.org/10.1007/978-0-387-09494-6).

**Theorem 11.1.** Fix an integer `R_*>=1`. For every `epsilon>0`, all
sufficiently large positive primitive abc triples with `R_0<=R_*` satisfy

\[
\min(a,b)\ge c^{1-\epsilon}.                               \tag{11.2}
\]

Equivalently, along any sequence of such triples with `c` tending to
infinity,

\[
\frac{\log\min(a,b)}{\log c}\longrightarrow1.              \tag{11.3}
\]

The threshold is allowed to depend on `R_*` and `epsilon`. This proof
does not make the threshold effective.

**Proof.** The cube-free product `N=ABC` satisfies `N<=R_0^2<=R_*^2`.
Thus (6.8) ranges over a finite list of nonsingular elliptic curves: its
constant coefficient `16N^2` is nonzero. Consequently (11.1) is uniform
over this finite list. This finite-list step is the only uniformity in
`N` asserted here.

By symmetry suppose `m=a<=b`, so `c/2<=b<c`. Use `Q_a` on `E_*`, and set
`g=gcd(u,2)`, which is either `1` or `2`. Formula (6.9) gives its reduced
fraction explicitly:

\[
X(Q_a)=\frac{A_x}{B_x},\quad
A_x=\frac{4vwBC}{g^2},\quad B_x=\frac{u^2}{g^2}.             \tag{11.4}
\]

These are positive integers. Further,

\[
X(Q_a)^3=64N^2\frac{bc}{a^2}\ge64,
\]

so `X(Q_a)>=4` and `h_x(Q_a)=log A_x`. Directly from (11.4),

\[
\begin{split}
\log A_x&=\tfrac13(\log b+\log c)+\tfrac23\log(BC)
             +\log4-2\log g,\\
\log B_x&=\tfrac23\log a-\tfrac23\log A-2\log g.
\end{split}                                                \tag{11.5}
\]

In particular, with `H=log c`,

\[
\tfrac23H-\tfrac13\log2\le h_x(Q_a)
\le\tfrac23H+\log4+\tfrac23\log N,\qquad
\log B_x\le\tfrac23\log a.                                \tag{11.6}
\]

Thus `H` tending to infinity forces `h_x(Q_a)` to infinity, and the two
heights are comparable with constants uniform for `N<=R_*^2`. Subtracting
the bounds in (11.6) gives

\[
0\le H-\log a
\le\tfrac32\log X(Q_a)+\tfrac12\log2.                     \tag{11.7}
\]

Equation (11.1), the finite list of curves, and (11.6) make the right-hand
side `o(H)`. Dividing by `H` proves (11.3), and then (11.2). When `b<a`,
use `Q_b` with the same computation. This also shows that a hypothetical
infinite countersequence to (11.2) would give a countersequence to the
fixed-curve theorem, so the statement is uniform over all triples with
the specified bounded residual support. QED.

The result improves the fixed-support consequence following (8.2) from
`log m >> H/log H` to `log m/H -> 1`, at the price of an ineffective
threshold in this proof. It is fully compatible with an infinite fixed-
`R_0` family of unbounded height. For a moving residual support, its
threshold cannot be substituted into a uniform abc estimate. Even with
balanced logarithmic endpoint sizes, the multiplicity and radical of the
growing denominator primes remain to be controlled.

Original text inspected locally at PDF indices 289 and 291--292 (printed
pp. 276 and 278--279):
`research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf`.
The file has 3,658,085 bytes and SHA-256
`72ee67bfa1e3fdf582ac7e4b032d7ca0b35a168ed6443ac39c121fbb788cab25`.
Academic mirror: `https://www.pdmi.ras.ru/~lowdimma/BSD/Silverman-Arithmetic_of_EC.pdf`.
The book is retained only as a local research source, not as a paper
attachment for redistribution. No Siegel or Roth theorem is introduced
as a Lean axiom by the elementary companion.

## 12. Completed elementary formalization

The new module is
`Lean/IUTThreeClosures/GeometryGlobalUniformGate20260830.lean`, with namespace
`IUTThreeClosures.GeometryGlobalUniformGate`. Its direct check was

```
lake env lean IUTThreeClosures/GeometryGlobalUniformGate20260830.lean
```

The final run exited with code 0 and no warnings. The module uses the
actual `Nat.floorRoot 3 n` and `n/(Nat.floorRoot 3 n)^3` rather than a
supplied cube-decomposition record. Its checked content is:

* `cube_decomposition`, `cubeCoefficient_factorization`, and
  `cubeCoefficient_mul`: canonical extraction, exact exponent remainders,
  and multiplicativity for coprime inputs.
* `mordell_omit_a`, `mordell_omit_b`, `mordell_omit_c`, and
  `all_three_points_retain_height`: all three actual integral equations
  for every `ABCPoint`, including the negative coordinate, and the exact
  integer inequality `32c<=|x_i|^3`.
* `actual_three_cost_product`, `truncatedTwo_factorization`, and
  `truncated_mordell_parameter`: the actual radical-product ledger and
  the identity between exponent-two truncation of `16s^2` and
  `rad(2s)^2`. The truncation is represented as `gcd(n,rad(n)^2)` and its
  prime exponents are proved to be `min(2,v_p(n))`.
* `cubic_plus_root`, `cubic_minus_root`, the two square-coordinate
  identities, and the trace/plus/minus matrix determinant theorems:
  the displayed ring calculations behind the pure cubic orders.
* `common_curve_omit_a`, `common_curve_omit_b`, `common_curve_omit_c`,
  `prime_dvd_residualSupport_iff`, and
  `coefficientProduct_le_residualSupport_sq`: actual rational points on
  the same parameter `16(ABC)^2`, the exact residual prime support, and
  the bound `ABC<=R_0^2` used for the finite list of curves.
* `auxiliary_isogeny_equation`: the rational formula (4.1) preserves the
  indicated Mordell equations whenever its abscissa is nonzero.

Twelve representative `#print axioms` commands return only subsets of
`propext`, `Classical.choice`, and `Quot.sound`. There is no `sorry`,
`admit`, new axiom, or opaque assertion.

The companion does **not** yet construct number fields or their integral
orders, prove irreducibility or the order-index interpretation, calculate
the reduced `Rat.den` in (6.9), construct an elliptic-curve isogeny/group
law or its torsion orbit, or formalize Pasten/Landau/Siegel and the resulting
analytic estimates. Those are mathematical proofs above with explicitly
identified external inputs, not hidden Lean premises. In particular, the
constant `C` in (7.1), the threshold in (11.2), and `ABCConjecture` are not
assumed or claimed to be Lean closed terms here.
