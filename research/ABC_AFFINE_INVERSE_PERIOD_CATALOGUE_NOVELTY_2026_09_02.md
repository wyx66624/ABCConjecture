# Incidence cancellation and inverse-period pair catalogues in the affine route

**Author:** ChatGPT  
**Date:** 2026-09-02  
**Status:** unconditional finite theorems and a full-premise obstruction; the final affine comparison remains open

## 1. Scope

This note continues the selected canonical affine-catalogue route.  It does
not prove the abc conjecture.  Its purpose is to remove two avoidable losses
from the current affine gate and to state the remaining arithmetic problem in
a form that retains the inverse period.

The first loss was the deduplicated singleton baseline

\[
 W=\sum_{\lambda}w_\lambda
\]

in the estimate $E\le W+7E_{\rm sh}$.  The relevant baseline is instead
the exact point-label incidence.  This changes the optimal coefficient from
seven to six and cancels every kernel class of multiplicity one exactly.

The second issue is the non-arm sum

\[
 S_{\rm non}=\sum_{\lambda\ {\rm repeated,nonarm}}
              \frac{w_\lambda}{T_\lambda^2}.            \tag{1.1}
\]

A universal lower bound $T_\lambda\ge2$ is false even in an actual
canonical box.  The valid replacement developed below assigns the terms of
(1.1) to pairs of supporting points.  For each pair the complete
inverse-period divisor sum has an Euler product, and the large-label
restriction gives a second, independent tail bound.  Taking the minimum of
these two bounds produces an unconditional pair-catalogue majorant for
$S_{\rm non}$.

Only the selected powerful-kernel catalogues are used.  No statement below
applies to the union of all divisors of all three affine arms.

## 2. Selected large tails and exact incidence

Let $X$ be a finite set of selected canonical points.  Points having the
same powerful-kernel triple are grouped into a finite class set
$\mathcal K$.  Write

\[
 \kappa=(k_U,k_V,k_W),\qquad m_\kappa=\#\{x\in X:\kappa(x)=\kappa\}.
\]

For the ambient side length $N>0$, define the large downward tail of
$\kappa$ by

\[
 \mathcal L_N(\kappa)=
 \{d=(d_U,d_V,d_W):d_Z\mid k_Z\ (Z=U,V,W),\ d_Ud_Vd_W>N^2\},              \tag{2.1}
\]

and its totient mass by

\[
 L_\kappa=\sum_{d\in\mathcal L_N(\kappa)}
     w_d,\qquad
 w_d=\varphi(d_U)\varphi(d_V)\varphi(d_W).                \tag{2.2}
\]

Let $\mathcal L=\bigcup_\kappa\mathcal L_N(\kappa)$ be the deduplicated
union.  The occupancy $n_d$ is the number of selected points whose kernel
contains $d$.  Put

\[
 I=\sum_{d\in\mathcal L}w_dn_d,\qquad
 E=\sum_{d\in\mathcal L}w_dn_d^3,\qquad
 E_{\rm sh}=\sum_{d\in\mathcal L}w_d(n_d-1)^3.            \tag{2.3}
\]

Natural subtraction is intended in (2.3); every label in the union occurs,
so in fact $n_d\ge1$.

### Proposition 2.1 (exact class-incidence identity)

One has

\[
             \boxed{I=\sum_{\kappa\in\mathcal K}m_\kappa L_\kappa.}       \tag{2.4}
\]

#### Proof

For $d\in\mathcal L$, the selected points supporting $d$ are precisely
the points in those classes $\kappa$ for which
$d\in\mathcal L_N(\kappa)$.  Hence

\[
 n_d=\sum_{\substack{\kappa\in\mathcal K\\
                     d\in\mathcal L_N(\kappa)}}m_\kappa.                 \tag{2.5}
\]

Insert (2.5) into $I$, interchange the two finite sums, and use (2.2):

\[
 \begin{aligned}
 I
 &=\sum_{d\in\mathcal L}w_d
       \sum_{\kappa:d\in\mathcal L_N(\kappa)}m_\kappa\\
 &=\sum_{\kappa\in\mathcal K}m_\kappa
       \sum_{d\in\mathcal L_N(\kappa)}w_d
 =\sum_{\kappa\in\mathcal K}m_\kappa L_\kappa.
 \end{aligned}
\]

No disjointness of the tails is used: an overlapping label is counted once
for each incident selected point on both sides. ∎

The monotone-overlap theorem from the preceding catalogue report gives

\[
       \sum_{\kappa\in\mathcal K}m_\kappa^3L_\kappa\le E.                \tag{2.6}
\]

## 3. The optimal incidence-plus-shift bridge

### Lemma 3.1 (optimal coefficient six)

For every $n\in\mathbb N$,

\[
                  \boxed{n^3\le n+6(n-1)^3.}                            \tag{3.1}
\]

The coefficient six cannot be replaced by a smaller nonnegative constant.

#### Proof

The cases $n=0,1$ are equalities.  If $n\ge2$, put $a=n-1\ge1$.
Then

\[
 n+6a^3-n^3
 =(a+1)+6a^3-(a+1)^3
 =a(a-1)(5a+2)\ge0.                                      \tag{3.2}
\]

At $n=2$, (3.1) is the equality $8=2+6$.  Therefore any uniform
coefficient in place of six must be at least six. ∎

Multiplying (3.1) by $w_d$ and summing gives

\[
                         E\le I+6E_{\rm sh}.              \tag{3.3}
\]

This is stronger than the former $E\le W+7E_{\rm sh}$ whenever the exact
incidence (I) is used in the subsequent lower comparison.

There is also an occupancy-sensitive refinement.  Put

\[
 E_{{\rm sh},2}=\sum_{n_d=2}w_d(n_d-1)^3,
 \qquad
 E_{{\rm sh},\ge3}=\sum_{n_d\ge3}w_d(n_d-1)^3.            \tag{3.4}
\]

For $n\ge3$, write $a=n-1\ge2$.  Then

\[
 n+3a^3-n^3=a(a-2)(2a+1)\ge0.
\]

The coefficient three is optimal at $n=3$.  Hence

\[
              E\le I+6E_{{\rm sh},2}+3E_{{\rm sh},\ge3}. \tag{3.5}
\]

### Theorem 3.2 (exact cancellation of singleton classes)

With the definitions in Section 2,

\[
 \boxed{
 \sum_{\kappa\in\mathcal K}m_\kappa^3L_\kappa
 \le
 \sum_{\kappa\in\mathcal K}m_\kappa L_\kappa+6E_{\rm sh}.}             \tag{3.6}
\]

Equivalently,

\[
 \boxed{
 \Delta_{\rm mult}:=
 \sum_{\kappa\in\mathcal K}(m_\kappa^3-m_\kappa)L_\kappa
 \le6E_{\rm sh}.}                                                       \tag{3.7}
\]

#### Proof

Combine (2.6), (3.3), and the exact identity (2.4).  Since
$m^3\ge m$ for $m\in\mathbb N$, subtracting the finite nonnegative
quantity $\sum_\kappa m_\kappa L_\kappa$ yields (3.7).  Using (3.5)
instead of (3.3) also gives

\[
 \Delta_{\rm mult}\le
 6E_{{\rm sh},2}+3E_{{\rm sh},\ge3}.                     \tag{3.8}
\]

∎

Every class with $m_\kappa=1$ contributes zero to (3.7).  Thus the
deduplicated singleton catalogue is not an additional additive error in the
exact comparison.  Classes of multiplicity one may still be a structural
obstacle to obtaining a positive left side, but their tail mass is no longer
paid with a mismatched coefficient.

### Proposition 3.3 (exclusive singleton mass and a second optimal bridge)

For a class $\kappa$ of multiplicity one, let $X_\kappa$ be the weight of
the labels in its large tail which lie in no other class tail.  If
$W_1=\sum_{n_d=1}w_d$ is the actual singleton-label mass, then

\[
 W_1=\sum_{m_\kappa=1}X_\kappa
 \le\sum_{m_\kappa=1}L_\kappa.                          \tag{3.9}
\]

Moreover

\[
 E\le W_1+8E_{\rm sh}                                   \tag{3.10}
\]

and the coefficient eight is optimal.

#### Proof

A label has occupancy one exactly when its support-class set consists of a
single class and that class has multiplicity one.  This proves the equality
in (3.9); the inequality follows from
$X_\kappa\le L_\kappa$.  A label of occupancy one contributes its weight to
$E$.  If $n\ge2$ and $a=n-1\ge1$, then

\[
                         n^3=(a+1)^3\le8a^3,
\]

because $(1+1/a)^3\le8$.  This proves (3.10).  Equality holds at $n=2$.
∎

Combining (2.6), (3.9), and (3.10) gives the independent multiplicity
pressure inequality

\[
                 \sum_{m_\kappa\ge2}m_\kappa^3L_\kappa
                 \le8E_{\rm sh}.                         \tag{3.11}
\]

The two bridges (3.7) and (3.11) should both be retained.  Neither dominates
the other in every overlap pattern.

### Proposition 3.4 (multiplicity plus novelty is exactly shifted incidence)

For a label $d$, let

\[
 r_d=\#\{\kappa\in\mathcal K:d\in\mathcal L_N(\kappa)\}
\]

be its number of supporting kernel classes, and define

\[
 \begin{aligned}
 A_0&=\sum_\kappa L_\kappa,\\
 A_1&=\sum_\kappa(m_\kappa-1)L_\kappa,\\
 \Omega&=A_0-W
        =\sum_{d\in\mathcal L}w_d(r_d-1),\\
 J&=\sum_{d\in\mathcal L}w_d(n_d-1).
 \end{aligned}                                           \tag{3.12}
\]

Then

\[
                    I=A_0+A_1,\qquad J=A_1+\Omega.        \tag{3.13}
\]

Consequently weighted Hölder gives the normalized lower bound

\[
             (A_1+\Omega)^3\le(A_0-\Omega)^2E_{\rm sh}.  \tag{3.14}
\]

If $W=A_0-\Omega>0$, this is equivalently

\[
 E_{\rm sh}\ge
 \frac{(A_1+\Omega)^3}{(A_0-\Omega)^2}.                  \tag{3.15}
\]

#### Proof

Double counting class-label supports gives
$A_0=\sum_dw_dr_d$.  Subtracting the union weight, which counts each label
once, proves the formula for $\Omega$.  Also

\[
 \sum_\kappa m_\kappa L_\kappa
 =\sum_\kappa L_\kappa+
   \sum_\kappa(m_\kappa-1)L_\kappa=A_0+A_1.
\]

Now use $J=I-W$, Proposition 2.1, and $W=A_0-\Omega$ to obtain
$J=A_1+\Omega$.  The shifted weighted Hölder inequality
$J^3\le W^2E_{\rm sh}$ proves (3.14). ∎

Thus there are two exact sources of repeated incidence: multiplicity inside
a class, measured by $A_1$, and novelty failure between distinct class
catalogues, measured by $\Omega$.  Neither source may be deleted.

There is a direct arithmetic expression for the second source.  Order the
class set arbitrarily and put

\[
 P_2=\sum_{\kappa<\kappa'}
 L_N\!\left(\gcd_{\rm coord}(\kappa,\kappa')\right),
                                                               \tag{3.16}
\]

where the tail on the right is taken above the same threshold $N^2$.  Then

\[
 P_2=\sum_dw_d\binom{r_d}{2}.                              \tag{3.17}
\]

If $\mathcal L\ne\varnothing$, put
$r_{\max}=\max_{d\in\mathcal L}r_d$.  The elementary inequalities
$r-1\le\binom r2\le r_{\max}(r-1)/2$ give

\[
             \frac{2P_2}{r_{\max}}\le\Omega\le P_2        \tag{3.18}
\]

when the left quotient is read over the nonnegative rationals.  If
$\mathcal L=\varnothing$, then $P_2=\Omega=0$ instead.  In particular, every
single pair tail is a lower bound for $\Omega$.

## 4. Large-tail owner moments and the revised affine gate

The owner argument can also retain the exact large tail $L_\kappa$ instead
of enlarging it to the full catalogue mass $D_\kappa=k_Uk_Vk_W$.

### Proposition 4.1 (large-tail owner bound)

Choose for every distinct $d\in\mathcal L$ one owner
$o(d)\in\mathcal K$ satisfying
$d\in\mathcal L_N(o(d))$.  For $Z=U,V,W$,

\[
 \sum_{d\in\mathcal L}w_dd_Z^3
 \le\sum_{\kappa\in\mathcal K}L_\kappa k_Z(\kappa)^3,                   \tag{4.1}
\]

and

\[
                   \sum_{d\in\mathcal L}w_d\le\sum_\kappa L_\kappa.    \tag{4.2}
\]

#### Proof

The labels assigned to $\kappa$ form a subset of
$\mathcal L_N(\kappa)$, so their total weight is at most $L_\kappa$.
Moreover $d_Z\mid k_Z(\kappa)$, hence
$d_Z^3\le k_Z(\kappa)^3$.  The contribution owned by $\kappa$ is
therefore at most $L_\kappa k_Z(\kappa)^3$.  Summing over owners proves
(4.1); omitting the coordinate cube proves (4.2). ∎

For a repeated non-arm label let $T_d$ be its exact primitive-line period.
The signed ray theorem gives

\[
 (n_d-1)^3T_d^2<KN,\qquad K=(B+1)(C+1).                  \tag{4.3}
\]

The three exact canonical arm caps and (4.1) give

\[
 E_U+E_V+E_W\le\frac1{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right).               \tag{4.4}
\]

Consequently (1.1), (3.7), (4.3), and (4.4) imply the following exact
replacement for the earlier affine gate.

### Theorem 4.2 (singleton-free affine multiplicity gate)

In the proved selected canonical setup,

\[
 \boxed{
 \begin{aligned}
 \Delta_{\rm mult}\le{}&6KN S_{\rm non}\\
 &+\frac6{N^3}\sum_{\kappa\in\mathcal K}L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right).
 \end{aligned}}                                                            \tag{4.5}
\]

#### Proof

Partition $E_{\rm sh}$ into its repeated non-arm part and its three arm
parts.  Multiply (4.3) by $w_d/T_d^2$ and sum to obtain
$E_{\rm non}\le KN S_{\rm non}$.  Apply (4.4) to the arm parts and insert
the result into (3.7). ∎

Thus a sufficient arithmetic contradiction would be the strict reverse
inequality

\[
 6KN S_{\rm non}
 +\frac6{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right)
 <\Delta_{\rm mult}.                                      \tag{4.6}
\]

No such reverse inequality is asserted here.

If $S_{{\rm non},2}$ and $S_{{\rm non},\ge3}$ denote the parts of
$S_{\rm non}$ with occupancy two and at least three, respectively, (3.8)
also gives the sharper non-arm coefficient split

\[
 \Delta_{\rm mult}\le
 6KN S_{{\rm non},2}+3KN S_{{\rm non},\ge3}
 +\frac6{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right).               \tag{4.7}
\]

Likewise the exclusive-singleton bridge (3.11) yields

\[
 \sum_{m_\kappa\ge2}m_\kappa^3L_\kappa
 \le8KN S_{\rm non}
 +\frac8{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right).               \tag{4.8}
\]

The constants six, three, and eight in these purely occupancy-driven
conversions are exact.

The shifted-incidence identity gives a complementary normalized gate which
still sees cross-class overlap.  Combining (3.14) with the unmultiplied ray
upper bound

\[
 E_{\rm sh}\le KN S_{\rm non}
 +\frac1{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right)
\]

gives

\[
 \boxed{
 \begin{aligned}
 (A_1+\Omega)^3\le(A_0-\Omega)^2\Bigg[
 &KN S_{\rm non}\\
 &+\frac1{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right)
 \Bigg].
 \end{aligned}}                                           \tag{4.9}
\]

Unlike $\Delta_{\rm mult}$, the left side of (4.9) remains positive when a
repeated label is created solely by overlap of distinct multiplicity-one
classes.

## 5. Pairwise gcd kernels retain the inverse period

Let $x\ne y$ be selected points in the $N$-box.  Write their difference
in primitive form

\[
                         y-x=q(s,t),\qquad q\ge1,\quad\gcd(|s|,|t|)=1,   \tag{5.1}
\]

put $L=\max(|s|,|t|)$, and use the canonical signed coefficients

\[
 A_U=s,\qquad A_V=s+Ct,\qquad A_W=s+Bt.                  \tag{5.2}
\]

This section concerns non-arm pairs, so all three coefficients are nonzero.
The box gives $qL\le N$.  Let

\[
 g_Z=\gcd(k_Z(x),k_Z(y)),\quad G=g_Ug_Vg_W,\quad
 c_Z=\gcd(g_Z,|A_Z|),\quad C_g=c_Uc_Vc_W.                \tag{5.3}
\]

The $g_Z$ are pairwise coprime.  Since every canonical arm is $1\pmod R$,
each $g_Z$ is coprime to $R$.  Subtracting the two arm values shows

\[
                         g_Z\mid RqA_Z.
\]

Cancelling $R$ therefore gives $g_Z\mid qA_Z$, and hence

\[
                         \frac{g_Z}{c_Z}\mid q.           \tag{5.4}
\]

Because the three quotients in (5.4) are pairwise coprime, their product

\[
                         T_g=\prod_Z\frac{g_Z}{c_Z}
\]

also divides $q$.  In particular

\[
                         G=T_gC_g\le qC_g.                \tag{5.5}
\]

Finally, with

\[
 P=|A_UA_VA_W|,
\]

one has $C_g\le P$ and the sharp signed-direction estimate

\[
                         P\le K L^3.                     \tag{5.6}
\]

### 5.1 The exact local Euler factor

For $k\ge1$ and $a\ge0$, define

\[
 F(k,a)=\sum_{d\mid k}\varphi(d)
             \frac{\gcd(d,a)^2}{d^2}.                   \tag{5.7}
\]

Let

\[
 \Psi(k)=\prod_{p\mid k}\left(1+\frac1p\right),\qquad\Psi(1)=1.         \tag{5.8}
\]

### Lemma 5.1 (prime-power evaluation)

Let $p$ be prime, $e\ge1$, and
$r=\min(e,v_p(a))$, with $r=e$ when $a=0$.  Then

\[
 F(p^e,a)=
 \begin{cases}
 p^e, & r=e,\\[2mm]
 p^r+p^{r-1}\bigl(1-p^{-(e-r)}\bigr), & 0\le r<e.
 \end{cases}                                             \tag{5.9}
\]

In the second line the expression is rational; at $r=0$ it equals
$1+p^{-1}-p^{-(e+1)}$.  Consequently

\[
                         F(p^e,a)\le p^r\left(1+\frac1p\right).          \tag{5.10}
\]

#### Proof

For $0\le j\le r$, the summand for $d=p^j$ is
$\varphi(p^j)$.  These terms sum to $p^r$.  If $r<e$, the remaining
terms sum to

\[
 \begin{aligned}
 \sum_{j=r+1}^{e}\varphi(p^j)\frac{p^{2r}}{p^{2j}}
 &=(1-p^{-1})p^{2r}\sum_{j=r+1}^{e}p^{-j}\\
 &=p^{r-1}\bigl(1-p^{-(e-r)}\bigr).
 \end{aligned}
\]

This proves (5.9), and dropping the final negative term proves (5.10). ∎

The summand in (5.7) is multiplicative as a function of $d$.  Therefore
(5.9) gives the Euler product and the uniform bound

\[
F(k,a)=\prod_{p^e\parallel k}F(p^e,a),\qquad
F(k,a)\le\gcd(k,a)\Psi(k).                              \tag{5.11}
\]

The exact product is sharper than the final inequality.  If
$b_p=\min(v_p(k),v_p(a))$ and $r_p=v_p(k)-b_p$, with the convention
$v_p(0)=+\infty$, then

\[
 F(k,a)=\gcd(k,a)
 \prod_{\substack{p^{r_p}\parallel k/\gcd(k,a)\\r_p>0}}
 \left(1+\frac1p-\frac1{p^{r_p+1}}\right).               \tag{5.11a}
\]

For the triple $g=(g_U,g_V,g_W)$ and coefficient vector
$A=(A_U,A_V,A_W)$, define
$F(g,A)=\prod_ZF(g_Z,|A_Z|)$.  Formula (5.11a) becomes

\[
 \prod_ZF(g_Z,|A_Z|)
 =C_g\prod_{p^r\parallel T_g}
   \left(1+\frac1p-\frac1{p^{r+1}}\right).               \tag{5.11b}
\]

Let $u^{(R)}$ denote the largest divisor of $u$ coprime to $R$, and put
$q_0=q^{(R)}$ and
$P_0=\prod_Z |A_Z|^{(R)}$.  Since $T_g$ and $C_g$ are coprime to $R$,
(5.4) gives

\[
 T_g\mid q_0,\qquad C_g\mid P_0,\qquad G\mid q_0P_0.     \tag{5.11c}
\]

Consequently

\[
 \prod_ZF(g_Z,|A_Z|)
 \le C_g\prod_{p\mid T_g}\left(1+\frac1p\right)
 \le P_0\prod_{p\mid q_0}\left(1+\frac1p\right)
 \le P_0\frac{q_0}{\varphi(q_0)}.                        \tag{5.11d}
\]

The last step uses
$1+p^{-1}\le(1-p^{-1})^{-1}$ prime by prime.

For the second tail estimate define

\[
 H(k)=\sum_{d\mid k}\frac{\varphi(d)}d
 =\prod_{p^e\parallel k}\left(1+e\left(1-\frac1p\right)\right).         \tag{5.11e}
\]

Both the divisor sum and the product in (5.11e) follow directly from
$\varphi(p^j)/p^j=1-1/p$ for $j\ge1$.

### 5.2 A hybrid bound for one pair catalogue

For the pair $x,y$, let $Q(x,y)$ be the inverse-period mass of all common
large labels:

\[
 Q(x,y)=
 \sum_{\substack{d_Z\mid g_Z\ (Z=U,V,W)\\d_Ud_Vd_W>N^2}}
 w_d\left(\prod_Z\frac{d_Z}{\gcd(d_Z,|A_Z|)}\right)^{-2}.               \tag{5.12}
\]

### Theorem 5.2 (pair-catalogue Euler/tail bound)

For every non-arm pair,

\[
 \boxed{
Q(x,y)\le
\min\left\{
   \prod_ZF(g_Z,|A_Z|),
   \frac{C_g^2G}{N^4},
   \frac{C_g^2H(G)}{N^2}
 \right\}.}                                               \tag{5.13}
\]

Moreover

\[
 \prod_ZF(g_Z,|A_Z|)
 =C_g\prod_{p^r\parallel T_g}
   \left(1+\frac1p-\frac1{p^{r+1}}\right)
 \le P_0\frac{q_0}{\varphi(q_0)},                         \tag{5.14}
\]

and, using (5.6) and (5.11c),

\[
 Q(x,y)\le
 \min\left\{
   P_0\frac{q_0}{\varphi(q_0)},
   \frac{q_0P_0^3}{N^4},
   \frac{P_0^2H(q_0P_0)}{N^2}
 \right\},
 \qquad qL\le N,\quad P\le KL^3.                         \tag{5.15}
\]

#### Proof

Dropping the large-product restriction in (5.12) makes the three divisor
sums independent.  The resulting product is exactly

\[
 \prod_Z\sum_{d_Z\mid g_Z}\varphi(d_Z)
       \frac{\gcd(d_Z,|A_Z|)^2}{d_Z^2}
 =\prod_ZF(g_Z,|A_Z|),
\]

which proves the first bound in (5.13).

For a large label $d$, write

\[
 D_d=d_Ud_Vd_W,\qquad
 C_d=\prod_Z\gcd(d_Z,|A_Z|),\qquad T_d=D_d/C_d.
\]

Since $d_Z\mid g_Z$, one has $C_d\le C_g$.  The strict threshold gives

\[
                         T_d=\frac{D_d}{C_d}>\frac{N^2}{C_g}.
\]

Thus $T_d^{-2}<C_g^2/N^4$.  Summing and using the exact totient divisor
identity

\[
 \sum_{d_U\mid g_U}\sum_{d_V\mid g_V}\sum_{d_W\mid g_W}w_d=G
\]

proves the second bound in (5.13), with a weak inequality also covering an
empty tail.

There is a different use of the strict threshold:

\[
 \frac{w_d}{T_d^2}
 =\frac{w_d}{D_d}\frac{C_d^2}{D_d}
 <\frac{C_g^2}{N^2}\frac{w_d}{D_d}.
\]

Summing over the large tail, enlarging to all divisors of $g$, and applying
(5.11e) proves the third term in (5.13).  Formula (5.14) is (5.11b)--(5.11d).
Finally use $C_g\le P_0$, $G\le q_0P_0$, and the exponentwise
monotonicity of $H$ under $G\mid q_0P_0$ to obtain (5.15). ∎

Every $g_Z$ is powerful, hence so is $G$.  The elementary local inequalities

\[
 1+\frac e2\le2^{e/2}\quad(e\ge2),\qquad
 1+e\left(1-\frac1p\right)\le e+1\le3^{e/2}
 \quad(p\ge3,e\ge2)
\]

show, prime by prime, that

\[
                         H(G)\le\sqrt G.                 \tag{5.15a}
\]

For the first inequality use the bases $e=2,3$ and induction
$e\mapsto e+2$; the second has the same two-base induction.  Thus the third
term of (5.13) also gives

\[
                         Q(x,y)<\frac{C_g^2\sqrt G}{N^2}. \tag{5.15b}
\]

The first term in (5.13) is strongest when most common kernel factors are
captured by the direction.  The second uses the strict large-label threshold
and can be stronger near the smallest permitted direction scale.  Neither
term discards the actual pair arithmetic.

### 5.3 A necessary powerful-excess filter on the direction

For a positive integer $u$, put

\[
                         \mathfrak E(u)=\frac{u}{\operatorname{rad}(u)}.
\]

### Proposition 5.3 (owner-independent direction filter)

If a repeated selected non-arm label is supported by the pair $x,y$, then

\[
                         T_g\mathfrak E(P_0)>N
 \quad\hbox{and hence}\quad \mathfrak E(P_0)>L.           \tag{5.16}
\]

In the canonical case $C=B+1$, the three $R$-free coefficients are pairwise
coprime, so

\[
 \prod_{Z=U,V,W}\mathfrak E(|A_Z|^{(R)})>L.              \tag{5.17}
\]

In particular at least one factor on the left of (5.17) is greater than
$L^{1/3}$.

#### Proof

The repeated label divides the common powerful triple $g$, so $G>N^2$.
Because $G$ is powerful,

\[
 \mathfrak E(G)=G/\operatorname{rad}(G)\ge\sqrt G>N.
\]

Now $G=C_gT_g$, and
$\operatorname{rad}(C_gT_g)\ge\operatorname{rad}(C_g)$.  Therefore

\[
 \mathfrak E(G)\le T_g\mathfrak E(C_g).
\]

Since $C_g\mid P_0$, prime valuations give
$\mathfrak E(C_g)\mid\mathfrak E(P_0)$.  It follows that
$T_g\mathfrak E(P_0)>N$.  Finally
$T_g\mid q_0\mid q$ and $qL\le N$, so

\[
 \mathfrak E(P_0)>N/T_g\ge N/q_0\ge N/q\ge L.
\]

It remains to check coprimality.  One has
$\gcd(s,s+Ct)\mid C$ and $\gcd(s,s+Bt)\mid B$, so removing the primes of
$R=\operatorname{rad}(BC)$ makes these pairs coprime.  Also

\[
 \gcd(s+Ct,s+Bt)=\gcd(s+Bt,t)=1
\]

because $C-B=1$ and $\gcd(s,t)=1$.  Hence $\mathfrak E$ is multiplicative
across the three $R$-free coefficients, proving (5.17). ∎

This filter is stronger than a mere size condition: it requires repeated
prime powers in the $R$-free direction coefficients.

### Corollary 5.4 (excess-filtered direction count)

The number of primitive non-arm directions of scale at most $N$ which can
support a repeated selected label is

\[
             O\!\left(\min\{N^2,CN^{11/6}\}\right),      \tag{5.17a}
\]

with an absolute implied constant.  Their total signed coefficient product
satisfies

\[
                         \sum_{\rm eligible}P(s,t)
 =O\!\left(K\min\{N^5,CN^{29/6}\}\right).               \tag{5.17b}
\]

#### Proof

First note the elementary counting lemma

\[
 \#\{n\le X:\mathfrak E(n)>Y\}
 \le X\sum_{m>\sqrt Y}\frac1{m^2}
 =O(X/\sqrt Y).                                          \tag{5.17c}
\]

Indeed, if $n=\prod p^e$, put $m=\prod p^{\lfloor e/2\rfloor}$.
Then $m^2\mid n$ and $m^2\ge\mathfrak E(n)>Y$; the union bound over
multiples of $m^2$ proves (5.17c).

On the shell $\max(|s|,|t|)=L$, Proposition 5.3 says that one of the three
$R$-free coefficients has excess greater than $L^{1/3}$.  Since
$|A_Z|^{(R)}\mid |A_Z|$, prime valuations give
$\mathfrak E(|A_Z|^{(R)})\le\mathfrak E(|A_Z|)$; it is therefore enough to
count the original coefficient values.  Along every side of the square,
$s+Ct$ and $s+Bt$ are injective before taking absolute values, at most
two-to-one afterwards, and have magnitude $O(CL)$.  Applying (5.17c) with
$Y=L^{1/3}$ counts
$O(CL^{5/6})$ possibilities.  The coefficient $s$ is likewise injective
on the horizontal sides.  On the vertical sides it creates an
$O(L)$ spike only when $\mathfrak E(L)>L^{1/3}$.

For a dyadic block $X<L\le2X$, the same square-divisor union bound shows

\[
 \sum_{\substack{X<L\le2X\\\mathfrak E(L)>L^{1/3}}}L
 =O(X^{11/6}).
\]

Summing dyadic blocks gives the $O(CN^{11/6})$ term in (5.17a); intersecting
it with the trivial $O(N^2)$ count proves the stated minimum.  Finally
$P(s,t)\le KL^3$ on each shell; inserting this weight in the same argument
and also retaining the trivial $O(KN^5)$ bound gives (5.17b). ∎

For fixed $C$, this is a saving in the exponent of $N$ over the raw
$O(N^2)$ direction count.  With $C$ varying it need not be smaller; in the
canonical scale $N\asymp C^6/R$ the second term can be of order
$R^{1/6}N^2$.  The excess filter is still arithmetic information, but the
count does not control the powerful intersection tops lying on one eligible
direction and does not by itself close $S_{\rm non}$.

### 5.5 Global pair cover

Let $\mathcal P_{\rm non}$ be the set of unordered pairs of selected points
whose primitive direction is non-arm.  Every repeated non-arm label occurs
on one line, so its period is the same for every supporting pair.

### Theorem 5.5 (all-point-pair cover)

One has the exact double count

\[
 \sum_{\{x,y\}\in\mathcal P_{\rm non}}Q(x,y)
 =\sum_{\lambda\ {\rm repeated,nonarm}}
       \binom{n_\lambda}{2}\frac{w_\lambda}{T_\lambda^2}.               \tag{5.18}
\]

Consequently

\[
 \boxed{
 S_{\rm non}\le
 \sum_{\{x,y\}\in\mathcal P_{\rm non}}
 \min\left\{
   \prod_ZF(g_Z(x,y),|A_Z(x,y)|),
   \frac{C_g(x,y)^2G(x,y)}{N^4},
   \frac{C_g(x,y)^2H(G(x,y))}{N^2}
 \right\}.}                                               \tag{5.19}
\]

#### Proof

A label belongs to the pair catalogue in (5.12) exactly when both endpoints
support it.  Hence a label of occupancy $n_\lambda$ is counted once for
each of its $\binom{n_\lambda}{2}$ supporting pairs.  The large-label
collinearity theorem makes the primitive direction, and therefore the exact
period, independent of the chosen supporting pair.  This proves (5.18).
For a repeated label $\binom{n_\lambda}{2}\ge1$; apply (5.13) pair by pair
to obtain (5.19). ∎

The all-point-pair cover can be compressed to the kernel-class level.
Construct a support skeleton $\mathcal E$ as follows.

- For every class $\kappa$ with $m_\kappa\ge2$ and
  $k_Uk_Vk_W>N^2$, choose two of its points and add one loop edge.  Its top
  common kernel is $\gamma_e=\kappa$.
- For every unordered pair of distinct classes
  $\kappa,\kappa'$ with $m_\kappa=m_{\kappa'}=1$ and
  $\prod_Z\gcd(k_Z,k'_Z)>N^2$, add their unique point pair.  Its top is
  $\gamma_e=(\gcd(k_U,k'_U),\gcd(k_V,k'_V),\gcd(k_W,k'_W))$.
- Retain only edges whose primitive direction is non-arm.

For an edge $e$, define $Q_e$ by (5.12) with top $\gamma_e$ and its actual
primitive direction.

### Theorem 5.6 (class-support skeleton cover)

\[
                         \boxed{S_{\rm non}\le\sum_{e\in\mathcal E}Q_e.} \tag{5.20}
\]

Therefore every edge may be bounded by the exact Euler product or either
tail term in (5.13).  Define
$W_{\rm repeated}=\sum_{d:n_d\ge2}w_d$.  If all loop and singleton-pair
directions are restored before the inverse-period weights are forgotten, the
same support argument gives

\[
 W_{\rm repeated}\le
 \sum_{m_\kappa\ge2}L_\kappa+
 \sum_{\substack{\kappa<\kappa'\\m_\kappa=m_{\kappa'}=1}}
 L_N(\gcd_{\rm coord}(\kappa,\kappa')).                  \tag{5.21}
\]

#### Proof

Let $\lambda$ be a repeated non-arm label.  If one of its supporting classes
has multiplicity at least two, the chosen loop for that class contains
$\lambda$.  All points of the class support $\lambda$, and large-label
collinearity makes the loop direction the unique fibre direction.

Otherwise every supporting class has multiplicity one.  Since
$n_\lambda\ge2$, at least two such classes support $\lambda$; their
coordinatewise gcd top contains $\lambda$ and has product greater than
$N^2$.  The corresponding singleton-pair edge therefore contains
$\lambda$.  In both cases the edge direction is non-arm and the term
$w_\lambda/T_\lambda^2$ occurs in $Q_e$.  Assigning $\lambda$ to one such
edge and summing proves (5.20).  For (5.21), restore the edges of every
direction and replace each term $w_\lambda/T_\lambda^2$ by its unweighted
label weight $w_\lambda$; the identical two-case support assignment proves
the claim. ∎

Both branches in $\mathcal E$ are necessary: Section 6 gives equality in
the loop branch, while Section 7 gives equality in the singleton-pair
branch.  The remaining problem is to count or aggregate these powerful
intersection tops without replacing them by a raw number of point
pairs.


## 6. A full-premise canonical period-one obstruction

The following example is inside the actual canonical affine construction,
not merely an abstract period ledger.

Take

\[
 B=5,\quad C=6,\quad R=\operatorname{rad}(BC)=30,\quad
 M=388,\quad N=M-1=387.                                  \tag{6.1}
\]

Consider the two parameter points

\[
                         x=(12,283),\qquad y=(373,363).    \tag{6.2}
\]

Their canonical arms are

\[
\begin{array}{c|ccc}
 &U&V&W\\ \hline
x&361=19^2&51301=29^2\cdot61&42811=31\cdot1381,\\
y&11191=19^2\cdot31&76531=7\cdot13\cdot29^2&65641=41\cdot1601.
\end{array}                                               \tag{6.3}
\]

Both points satisfy the canonical admissibility condition
$\gcd(U,k)=1$, and the three arms on each row are pairwise coprime.  Their
powerful-kernel triples coincide:

\[
                         \kappa=(361,841,1).               \tag{6.4}
\]

The only divisor triple of $\kappa$ whose product exceeds $N^2$ is

\[
 \lambda=(361,841,1),\qquad
 D_\lambda=303601>149769=N^2.                             \tag{6.5}
\]

Indeed, dividing $D_\lambda$ by its smallest prime factor (19) already
gives $15979<N^2$.  Its weight is

\[
 w_\lambda=\varphi(19^2)\varphi(29^2)
            =342\cdot812=277704.                          \tag{6.6}
\]

The point difference is the primitive vector

\[
 (s,t)=(361,80),\qquad L=361,\qquad L\le N,               \tag{6.7}
\]

and the signed coefficients are

\[
 (A_U,A_V,A_W)=(361,841,761).                             \tag{6.8}
\]

Thus the direction is non-arm and

\[
 C_\lambda=\gcd(361,361)\gcd(841,841)\gcd(1,761)
            =303601=D_\lambda,\qquad T_\lambda=1.          \tag{6.9}
\]

The complete selected fibre in this box consists of the two points (6.2).
For the selected subset formed by these two points,

\[
 m_\kappa=n_\lambda=2,\quad L_\kappa=w_\lambda,\quad
 I=2w_\lambda,\quad E=8w_\lambda,\quad
 E_{\rm sh}=S_{\rm non}=w_\lambda.                       \tag{6.10}
\]

All hypotheses used in Sections 2--5 are present: strict largeness,
canonical admissibility, pairwise arm and label coprimality, a primitive
non-arm direction, exact period/capture factorization, and two actual
supporting selected points.  Moreover

\[
 \Delta_{\rm mult}=(2^3-2)L_\kappa=6w_\lambda=6E_{\rm sh},               \tag{6.11}
\]

so both Lemma 3.1 and Theorem 3.2 are sharp in the actual affine geometry.

### Exact retirement boundary

This example refutes each of the following universal strengthenings:

1. every repeated non-arm label has $T_\lambda\ge2$;
2. $S_{\rm non}\le\theta\sum_\kappa L_\kappa$ for any fixed
   $\theta<1$, because here equality
   $S_{\rm non}=L_\kappa$ holds;
3. the sample scale bounds
   $S_{\rm non}\le(\sum_\kappa D_\kappa)/N$ and
   $S_{\rm non}\le(\sum_\kappa D_\kappa)/\sqrt N$.

It does not refute the affine route, Theorem 4.2, or the class-skeleton bound
(5.20).  It shows that a proof must use multiplicity, pair-kernel arithmetic,
or additional global structure; inverse-period decay alone cannot supply a
uniform saving.

## 7. Three further full-premise boundaries

### 7.1 Repetition can come only from singleton-class overlap

Take

\[
 B=3,\quad C=4,\quad R=6,\quad M=170,\quad N=169,
\]

and the two admissible points

\[
 x=(37,75),\qquad y=(138,122).
\]

Their arm rows are

\[
 \begin{array}{c|ccc}
 &U&V&W\\ \hline
 x&223&2023=7\cdot17^2&1573=11^2\cdot13,\\
 y&829&3757=13\cdot17^2&3025=5^2\cdot11^2.
 \end{array}
\]

Thus the two powerful-kernel classes are

\[
 \kappa_1=(1,289,121),\qquad \kappa_2=(1,289,3025).
\]

Every point in either exact kernel class supports the common label below.
Since the complete common-label fibre consists of these two points and their
kernels differ, both classes have multiplicity one even in the complete
admissible canonical box.

Their exact large-tail masses are

\[
 L_{\kappa_1}=29920,\qquad L_{\kappa_2}=837600.
\]

The second tail has the five labels

\[
 (1,17,3025),\ (1,289,121),\ (1,289,275),\
 (1,289,605),\ (1,289,3025);
\]

the first tail consists only of their common label

\[
 \lambda=(1,289,121),\qquad
 D_\lambda=34969>28561=N^2,\qquad w_\lambda=29920.
\]

The difference is the primitive direction $(101,47)$, whose coefficients
are $(101,289,242)$.  Hence $C_\lambda=D_\lambda$ and
$T_\lambda=1$.  Exhaustion of the complete canonical box confirms that the
$\lambda$-fibre is exactly $\{x,y\}$.  For the two-point selected subset,

\[
 \begin{aligned}
 W&=837600,& W_1&=807680,&W_{\rm repeated}&=29920,\\
 I&=867520,&J&=29920,&E&=1047040,\\
 E_{\rm sh}&=29920,&S_{\rm non}&=29920,&
 \Delta_{\rm mult}&=0.
 \end{aligned}                                           \tag{7.1}
\]

This is a full-premise counterexample to any proposed bound which charges
$S_{\rm non}$, $J$, or all repeated labels only to classes with
$m_\kappa\ge2$.  It does not contradict Proposition 3.4: here
$A_1=0$ and $\Omega=29920$, so the exact identity
$J=A_1+\Omega$ retains the entire overlap.  It also makes the
singleton-pair branch of (5.21) an equality.

### 7.2 The reduced-period Euler factor and the step $q_0$ cannot be deleted

Take $B=10,C=11,R=110,M=30,N=29$ and

\[
 x=(14,8),\qquad y=(29,20).
\]

The arm rows factor as

\[
 \begin{array}{c|ccc}
 x&23\cdot67&7^2\cdot229&3^3\cdot383,\\
 y&3191&7^2\cdot13\cdot43&3^4\cdot311.
 \end{array}
\]

They are admissible with pairwise-coprime arms.  Their common powerful top
is

\[
 g=(1,49,27),\qquad G=1323>N^2.
\]

Since $y-x=3(5,4)$, one has $q_0=q=3$ and
$A=(5,49,45)$.  Removing the primes of $R$ gives $P_0=49\cdot9=441$,
while

\[
 C_g=441,\qquad T_g=3,\qquad G=q_0P_0.
\]

The exact full Euler mass is

\[
 F(g,A)=441\left(1+\frac13-\frac19\right)=539>C_g.       \tag{7.2}
\]

Thus the claims $F(g,A)\le C_g$ and $G\mid P_0$ are false with all actual
affine, powerful, large, and non-arm premises present.  The proved statements
$F(g,A)\le P_0\prod_{p\mid q_0}(1+1/p)$ and
$G\mid q_0P_0$ survive.

### 7.3 The period-one cross-singleton obstruction persists when \(R<C\)

The preceding cross-singleton example has $R>C$.  The obstruction also
occurs in the subcritical canonical branch used by the affine reduction.
Take

\[
 B=8,\quad C=9,\quad R=\operatorname{rad}(72)=6<C,\quad
 M=\left\lfloor\frac{C^6}{4R}\right\rfloor=22143,\quad N=22142.
                                                               \tag{7.3}
\]

Let

\[
 \lambda=(18769,29929,1)=(137^2,173^2,1),
\]

so

\[
 D_\lambda=561737401>490268164=N^2.
\]

The congruence $137^2\mid U=1+6h$ gives

\[
 h\equiv3128\pmod {18769}.
\]

There are exactly two such values in $1\le h\le M$, namely $3128$ and
$21897$.  For each, the congruence
$173^2\mid V=1+6(h+9k)$ has at most one solution in
$1\le k\le M$, because $M<29929$; direct substitution gives

\[
 x=(3128,10183),\qquad y=(21897,11423).
\]

Thus these are the only possible points in the complete $\lambda$-fibre.
Their arms factor as

\[
 \begin{array}{c|ccc}
 x&18769=137^2&568651=19\cdot173^2&507553=47\cdot10799,\\
 y&131383=7\cdot137^2&748225=5^2\cdot173^2&
   679687=19\cdot83\cdot431.
 \end{array}
\]

Both rows satisfy $\gcd(U,k)=1$ and are pairwise coprime, so both points are
admissible.  Their powerful-kernel classes are distinct:

\[
 \kappa_x=(18769,29929,1),\qquad
 \kappa_y=(18769,748225,1).
\]

Every point in either exact kernel class supports $\lambda$.  The complete
$\lambda$-fibre has only the two displayed points and their kernels differ,
so both classes have multiplicity one in the complete admissible canonical
box.  The point difference is the primitive direction

\[
 (s,t)=(18769,1240),\qquad
 (A_U,A_V,A_W)=(18769,29929,28689),\qquad L=18769.
\]

Hence

\[
 C_\lambda=D_\lambda,\qquad T_\lambda=1,\qquad
 NL=415583198<D_\lambda,
\]

and

\[
 w_\lambda=\varphi(137^2)\varphi(173^2)
 =554413792,\qquad
 \frac{w_\lambda}{D_\lambda}
 =\frac{23392}{23701}\approx0.986963.                     \tag{7.4}
\]

Here $A_W=28689=3\cdot73\cdot131$.  Removing the primes of $R=6$ gives

\[
 P_0=137^2\cdot173^2\cdot73\cdot131,
 \qquad \mathfrak E(P_0)=137\cdot173=23701>N>L,
\]

so the example also satisfies, rather than evades, the necessary excess
filter (5.16).

The common powerful top is $\lambda$ itself.  Its only large downward label
is the top label, since division by $137$ already puts the product below
$N^2$.  Taking $X=\{x,y\}$, the singleton-pair support-skeleton contribution
satisfies

\[
                         Q_{\{x,y\}}=S_{\rm non}=w_\lambda.
                                                               \tag{7.5}
\]

This example has every finite affine and canonical premise used in
Sections 2--5 for this two-point selected set; it makes no claim about an
additional abc-exception or excess hypothesis outside those sections.
It refutes any universal non-arm saving deduced only from $R<C$, only from
the fact that the supporting classes are singletons, or only from the basic
period lower bound $T\ge1$.  In particular it refutes every strict
fractional saving against the exact common-tail skeleton mass, because
(7.5) is equality.  It does not refute a bound using additional cross-class
geometry or catalogue sparsity.

These examples retire only the named strengthenings.  They do not retire the
class-support skeleton, the exact Euler formula, or the affine mother route.

## 8. Further exact identities and non-implications

Let

\[
 W=\sum_{d\in\mathcal L}w_d,\qquad
 J=\sum_{d\in\mathcal L}w_d(n_d-1).
\]

Then $I=W+J$, and since $T_d\ge1$,

\[
 S_{\rm non}\le
 \sum_{d\ {\rm repeated}}w_d
 \le J.                                                   \tag{8.1}
\]

The first inequality in (8.1) can be equality, as (6.10) shows.  Therefore
(8.1) is useful as an exact incidence localization, but it has no universal
constant saving.

There is also the elementary identity

\[
 n^3-n=6\binom n2+6\binom n3.                            \tag{8.2}
\]

After weighting and summing, (8.2) expresses $E-I$ exactly through
pairwise and triple catalogue intersections.  It explains why replacing
$I$ by the union weight $W$ loses the class-incidence cancellation.
However, (8.2) alone does not control the inverse periods and therefore does
not close (4.6).

## 9. Exact remaining affine target

The results above leave two exact, complementary contradiction targets.
The diagonal target is the strict reverse of (4.5).  The normalized
multiplicity-plus-novelty target is, by (4.9) and (5.20),

\[
 (A_1+\Omega)^3>(A_0-\Omega)^2\left[
 KN\sum_{e\in\mathcal E}Q_e+
 \frac1{N^3}\sum_\kappa L_\kappa
 \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right)
 \right].                                                \tag{9.1}
\]

Each $Q_e$ in (9.1) is bounded by the three-term minimum in (5.13), and
every contributing direction satisfies the powerful-excess filter (5.16).
The period-one examples prove that neither a uniform positive lower bound
for $T-1$, a fixed fractional saving against total large-tail mass, nor a
charge supported only on classes of multiplicity at least two can establish
(9.1).

The remaining precise arithmetic task is to construct and aggregate a
divisibility-maximal subcatalogue of the powerful intersection tops on the
class-support skeleton, with an ownership rule that preserves the cover.
Structure still available for that task includes:

- $T_g\mid q_0\mid q$ and $qL\le N$;
- the exact prime-power factors (5.9), rather than a divisor-count bound;
- the strict tail alternatives involving $G$ and $H(G)$ in (5.13);
- pairwise coprimality of the three common kernel coordinates;
- $\mathfrak E(P_0)>L$ for every surviving direction;
- both exact overlap sources $A_1$ and $\Omega$ on the left of (9.1).

No finite no-hit result is used to abandon this target.


## 10. Formal and computational verification map

The companion Lean module contains 26 theorem declarations:

`Lean/IUTThreeClosures/AffineInversePeriodCatalogueNovelty20260902.lean`

formalizes the optimal incidence bridge, weighted aggregation, exact finite
class-incidence exchange, the singleton-free multiplicity comparison,
large-tail owner bounds, generic pair-catalogue double counting, and the
rational inverse-period/capture algebra used before the Euler expansion.

The independent computation directory

`research/computation/2026_09_02_affine_inverse_period_catalogue/`

replays the exact prime-power formula, finite Euler products, the hybrid
pair bounds, class-incidence identities, and every premise of the canonical
period-one witness.  These finite computations audit the symbolic proof;
they are not substituted for it.

The strict formal and computational replay commands are

```text
cd Lean
lake env lean -DwarningAsError=true IUTThreeClosures/AffineInversePeriodCatalogueNovelty20260902.lean
lake build IUTThreeClosures.AffineInversePeriodCatalogueNovelty20260902

cd research/computation/2026_09_02_affine_inverse_period_catalogue
python verify_inverse_period_catalogue.py
python verify_cross_singleton.py
python verify_subcritical_full_catalogues.py
python verify_euler_and_subcritical.py
python independent_replay.py
python run_canonical_catalogue_scan.py
```
