# Signed ray capture, exact canonical arm caps, and the global shifted-energy ceiling

**Author:** ChatGPT  
**Date:** 2 September 2026  
**Status:** unconditional signed direction, capture-squeeze, canonical arm,
and global energy theorems; the non-arm inverse-period catalogue and the
remaining singleton novelty comparison remain open

## 1. Purpose and scope

The previous affine checkpoints proved that every actual divisor label

\[
 \lambda=(d_U,d_V,d_W),\qquad D_\lambda=d_Ud_Vd_W>N^2,
\]

has a collinear fibre in the canonical parameter box, and they found the
exact period of a label on a nonnegative ray.  Two losses remained:

1. a line in the box can have a signed primitive direction, so the three
   coefficients must be treated as
   \(s,s+Ct,s+Bt\), with arbitrary signs;
2. the earlier vertical estimate discarded both the period and the strict
   large-label inequality, producing only a square-root cap.

This note removes both losses.  Its central observation is the strict
**capture squeeze**

\[
             (n_\lambda-1)NL<C_\lambda,                    \tag{1.1}
\]

where \(L=\max(|s|,|t|)\) and \(C_\lambda\) is the direction
capture.  On the three canonical arm-level directions the capture is
exactly the constant label component.  Consequently

\[
 (n_\lambda-1)N<d_U,\qquad
 (n_\lambda-1)NC<d_V,\qquad
 (n_\lambda-1)NB<d_W,                                  \tag{1.2}
\]

respectively.  These linear caps are strictly stronger than the previous
square-root estimates.

The note then connects shifted occupancy to the complete large-label cubic
energy of the deduplicated union of the selected canonical kernel
catalogues.  The three arm-level contributions are bounded by explicit
third moments of those actual catalogues.  No number-of-lines factor occurs.
The only collinear term left outside an explicit canonical moment is a
non-arm inverse-square-period sum supported on large primitive directions.

No exceptional-point lower bound is assumed and no abc conclusion is
claimed.  No route is retired except for the exact strengthened assertions
refuted by the full-premise examples in Section 9.

## 2. Signed primitive support and exact period

Use the affine arms

\[
 U(h,k)=1+Rh,\qquad
 V(h,k)=1+R(h+Ck),\qquad
 W(h,k)=1+R(h+Bk),                                    \tag{2.1}
\]

where \(0<B<C\).  Let a collinear fibre containing at least two lattice
points have primitive oriented direction

\[
                         (s,t)\in\mathbb Z^2,\qquad
 \gcd(|s|,|t|)=1.                                      \tag{2.2}
\]

After translating the line parameter, its points have the form

\[
                    (h_0+js,k_0+jt),\qquad 0\le j\le H, \tag{2.3}
\]

for an integer set of indices.  Put

\[
 A_U=s,\qquad A_V=s+Ct,\qquad A_W=s+Bt,\qquad
 L=\max(|s|,|t|).                                      \tag{2.4}
\]

Because the points lie in a square of side difference \(N\),

                              HL\le N.                  \tag{2.5}

For a positive pairwise-coprime label define

\[
 r_Z=\frac{d_Z}{\gcd(d_Z,|A_Z|)},\qquad
 T_\lambda=r_Ur_Vr_W,                                  \tag{2.6}
\]

and

\[
 C_\lambda=\prod_Z\gcd(d_Z,|A_Z|).                    \tag{2.7}
\]

### Theorem 2.1 (signed direction period)

Let \(\lambda\) be an actual divisor label on the line, so every \(d_Z\)
is coprime to \(R\).  If the label occurs at two indices \(i,j\), then

\[
                       T_\lambda\mid |i-j|,             \tag{2.8}
\]

and

                       T_\lambda C_\lambda=D_\lambda.  \tag{2.9}

#### Proof

Subtract the two divisibilities in each arm.  The displayed coprimality with
\(R\) also follows directly from actual occurrence: \(d_Z\) divides an arm
integer congruent to one modulo \(R\).  Cancellation of \(R\) gives

\[
 d_U\mid(i-j)s,\qquad d_V\mid(i-j)(s+Ct),\qquad
 d_W\mid(i-j)(s+Bt).                                   \tag{2.10}
\]

Taking absolute values changes none of these divisibilities.  The elementary
cancellation identity

\[
 d\mid qA\quad\Longrightarrow\quad
        \frac d{\gcd(d,|A|)}\mid q                       \tag{2.11}
\]

shows that every \(r_Z\) divides \(|i-j|\).  Since \(r_Z\mid d_Z\), the
three reduced periods remain pairwise coprime.  Their product therefore
divides \(|i-j|\).  Multiplying
\(r_Z\gcd(d_Z,|A_Z|)=d_Z\) proves (2.9). ∎

### Corollary 2.2 (exact residue-class capacity)

If the label occurs \(n_\lambda\) times on the segment, then, with
\(a_\lambda=n_\lambda-1\),

\[
                         a_\lambda T_\lambda\le H,
 \qquad a_\lambda T_\lambda L\le N.                    \tag{2.12}
\]

#### Proof

All occurrence indices lie in one residue class modulo \(T_\lambda\).
Thus an interval of index length \(H\) contains at most
\(\lfloor H/T_\lambda\rfloor+1\) occurrences.  The first inequality
follows, and multiplication by \(L\), followed by (2.5), gives the second. ∎

Every large-label fibre is eligible for this result.  Indeed, if three of
its points were noncollinear, the already proved determinant theorem would
give \(D_\lambda\le N^2\).  Thus a fibre with at least two points has one
primitive supporting direction; a singleton has shifted occupancy zero and
needs no chosen line.

## 3. The strict capture squeeze

The large-label inequality and the exact period factorization make the
capacity substantially stronger than the earlier square-root estimate.

### Theorem 3.1 (linear capture squeeze)

Assume \(N>0\), \(L>0\), (2.9), (2.12), and

\[
                              N^2<D_\lambda.             \tag{3.1}
\]

Then

\[
 \boxed{\quad a_\lambda NL<C_\lambda.\quad}             \tag{3.2}
\]

Moreover,

\[
 a_\lambda^2T_\lambda L^2<C_\lambda,\qquad
 a_\lambda^3T_\lambda^2L^3<C_\lambda N,                \tag{3.3}
\]

and hence

\[
                 (a_\lambda T_\lambda L)^3
                    <D_\lambda N.                        \tag{3.4}
\]

#### Proof

From (2.12),

\[
 a_\lambda T_\lambda L N\le N^2
       <T_\lambda C_\lambda.                             \tag{3.5}
\]

The positive factor \(T_\lambda\) cancels, giving (3.2).

Squaring the second inequality of (2.12) instead gives

\[
 a_\lambda^2T_\lambda^2L^2\le N^2
       <T_\lambda C_\lambda,
\]

which yields the first inequality in (3.3).  If \(a_\lambda=0\), the second
inequality is immediate from \(C_\lambda,N>0\).  If \(a_\lambda>0\), then
\(a_\lambda T_\lambda L>0\); multiply the first inequality by this positive
factor and use \(a_\lambda T_\lambda L\le N\) to obtain the second.  Finally
multiply the latter by the positive factor \(T_\lambda\) and use (2.9). ∎

A useful immediate consequence is a singleton test:

\[
                       C_\lambda\le NL
 \quad\Longrightarrow\quad n_\lambda=1.                \tag{3.6}
\]

This is not an asymptotic estimate; it is an exact finite implication.

## 4. Signed non-arm directions

Suppose none of \(A_U,A_V,A_W\) vanishes.  Put

\[
 P(s,t)=|s|\,|s+Ct|\,|s+Bt|,\qquad
 K=(B+1)(C+1).                                           \tag{4.1}
\]

Then

\[
 C_\lambda\le P(s,t)\le K L^3.                         \tag{4.2}
\]

The first inequality follows from
\(\gcd(d_Z,|A_Z|)\le|A_Z|\); the second follows from

\[
 |s+Ct|\le(C+1)L,\qquad |s+Bt|\le(B+1)L.                \tag{4.3}
\]

The constant \(K\) is sharp for this uniform statement: \(s=t=1\) gives
equality.

### Corollary 4.1 (strict signed non-arm capacities)

For every large actual label on a signed non-arm primitive line,

\[
 a_\lambda NL<P(s,t)\le KL^3,                            \tag{4.4}
\]

and

\[
                   a_\lambda^3T_\lambda^2<KN.            \tag{4.5}
\]

In particular,

\[
                 KL^2\le N\quad\Longrightarrow\quad
                 n_\lambda=1.                            \tag{4.6}
\]

#### Proof

Equation (4.4) is Theorem 3.1 followed by (4.2).  The second inequality in
(3.3) and (4.2) give

\[
 a_\lambda^3T_\lambda^2L^3<C_\lambda N
       \le K L^3N.
\]

Cancel the positive factor \(L^3\) to obtain (4.5).  If (4.6)'s left
condition holds and \(a_\lambda\ge1\), then (4.4) gives
\(N\le a_\lambda N<KL^2\le N\), a contradiction. ∎

Thus repeated non-arm labels are supported only on primitive directions
with

\[
                               KL^2>N.                    \tag{4.7}
\]

This direction localization was absent from the previous cube-root cap.
The two bounds are complementary: (4.4) controls small \(L\), while the
box span \(a_\lambda L\le N\) controls large \(L\).  Balancing them recovers
the cube-root scale, whereas (4.5) retains the useful inverse-square period.

## 5. Exact capture on all three canonical arm levels

Now specialize to the seed \((a,b,c)=(1,B,C)\).  Thus the earlier lowercase
height parameter \(c\) is the present coefficient \(C\), and the canonical
relation is

\[
                              C=B+1.                       \tag{5.1}
\]

An actual divisor label is coprime to the seed coefficients.  More
precisely, each component divides an arm congruent to one modulo
\(R=\operatorname{rad}(BC)\), so it is coprime to \(R\), hence to both
\(B\) and \(C\).  The remaining coefficient \(C-B\) equals one.

There are exactly three zero-coefficient primitive directions, up to sign.

### Theorem 5.1 (three exact arm captures)

For the primitive absolute coefficient triples

\[
 \begin{array}{c|c|c|c}
 \text{constant arm}&(|A_U|,|A_V|,|A_W|)&L&C_\lambda\\ \hline
 U&(0,C,B)&1&d_U\\
 V&(C,0,1)&C&d_V\\
 W&(B,1,0)&B&d_W,
 \end{array}                                             \tag{5.2}
\]

the displayed capture identities hold exactly.

#### Proof

For the \(U\)-level direction,

\[
 C_\lambda=\gcd(d_U,0)\gcd(d_V,C)\gcd(d_W,B)
             =d_U\cdot1\cdot1=d_U.                       \tag{5.3}
\]

For the \(V\)-level direction, the coefficients are
\((C,0,C-B)=(C,0,1)\), and therefore

\[
 C_\lambda=\gcd(d_U,C)d_V\gcd(d_W,1)=d_V.               \tag{5.4}
\]

The \(W\)-level calculation is identical:

\[
 C_\lambda=\gcd(d_U,B)\gcd(d_V,1)d_W=d_W.               \tag{5.5}
\]

Primitivity gives the stated values of \(L\). ∎

### Corollary 5.2 (linear canonical arm capacities)

Assume \(N>0\), and let \(a=n_\lambda-1\) for an occurring large label.  On
the three branches respectively,

\[
 \boxed{
 aN<d_U,\qquad aNC<d_V,\qquad aNB<d_W.
 }                                                       \tag{5.6}
\]

Equivalently,

\[
 n_\lambda\le
 1+\left\lfloor\frac{d_U-1}{N}\right\rfloor,            \tag{5.7U}
\]

\[
 n_\lambda\le
 1+\left\lfloor\frac{d_V-1}{NC}\right\rfloor,           \tag{5.7V}
\]

and

\[
 n_\lambda\le
 1+\left\lfloor\frac{d_W-1}{NB}\right\rfloor.           \tag{5.7W}
\]

#### Proof

Substitute the three rows of (5.2) into Theorem 3.1.  Since all quantities
are integers, \(aX<d\) is equivalent to
\(aX\le d-1\), which gives (5.7U)--(5.7W). ∎

At a canonical point the already proved factor-three arm bounds are

\[
 3d_U\le C^6,\qquad 3d_V\le C^7,\qquad 3d_W\le C^7.      \tag{5.8}
\]

Consequently

\[
 3aN<C^6,\qquad 3aNC<C^7,\qquad 3aNB<C^7.               \tag{5.9}
\]

The earlier vertical theorem only gave a bound of square-root size in
\(d_UBC\).  Formula (5.6) uses the strict large-label premise and canonical
coefficient coprimality, and is much smaller in the canonical range
\(N\asymp C^6/R\).

## 6. The optimal shifted-to-unshifted bridge

For every natural occupancy \(n\), put \(a=n-1\), with natural truncated
subtraction.  Then

\[
                         n^3\le1+7a^3.                    \tag{6.1}
\]

### Lemma 6.1 (optimal singleton-plus-shifted conversion)

Inequality (6.1) holds for all \(n\in\mathbb N\), and the coefficient seven
cannot be reduced.

#### Proof

For \(n=0\) or \(1\) the assertion is immediate.  For \(n\ge2\), write
\(n=a+1\), where \(a\ge1\).  Then

\[
 1+7a^3-(a+1)^3
   =6a^3-3a^2-3a
   =3a(a-1)(2a+1)\ge0.                                  \tag{6.2}
\]

At \(n=2\), equality holds in (6.1), while coefficient six would give the
false inequality \(8\le7\). ∎

Fix the finite set \(\mathcal K\) of realized selected canonical kernel
triples \(\kappa=(k_U,k_V,k_W)\), put
\(D_\kappa=k_Uk_Vk_W\), and define

\[
 \mathcal L=
 \bigcup_{\kappa\in\mathcal K}
 \{(d_U,d_V,d_W):d_Z\mid k_Z\text{ for every }Z,
                     \ d_Ud_Vd_W>N^2\}.
\]

Thus \(\mathcal L\) is the deduplicated large-label union of these selected
downward kernel catalogues.  This membership condition is essential; the
global owner bounds below are not assertions about the union of all divisors
of all three affine arms.  Give \(\lambda\in\mathcal L\) its actual totient
weight

\[
 w_\lambda=\varphi(d_U)\varphi(d_V)\varphi(d_W),
\]

and let \(n_\lambda\) be the number of selected canonical points whose
kernel catalogue contains \(\lambda\).  Put

\[
 W=\sum_{\lambda\in\mathcal L}w_\lambda,\qquad
 E=\sum_{\lambda\in\mathcal L}w_\lambda n_\lambda^3,
 \qquad
 E_{\rm sh}=\sum_{\lambda\in\mathcal L}
             w_\lambda(n_\lambda-1)^3.                   \tag{6.3}
\]

Summing (6.1) gives the exact global bridge

\[
 \boxed{\qquad E\le W+7E_{\rm sh}.\qquad}                \tag{6.4}
\]

Unlike a line-by-line unshifted bound, (6.4) charges every singleton label
only its unavoidable baseline weight and introduces no number-of-rays
factor.

## 7. A global canonical arm-energy theorem

Partition the repeated labels according to their unique primitive support
direction into the non-arm part and the three arm-level parts.  Write their
shifted energies as

\[
 E_{\rm sh}=E_{\rm non}+E_U+E_V+E_W.                     \tag{7.1}
\]

Cubing (5.6) yields

\[
 N^3(n_\lambda-1)^3<d_U^3,                              \tag{7.2U}
\]

\[
 N^3C^3(n_\lambda-1)^3<d_V^3,                           \tag{7.2V}
\]

and

\[
 N^3B^3(n_\lambda-1)^3<d_W^3.                           \tag{7.2W}
\]

### Lemma 7.1 (owner-catalogue third-moment bound)

For each coordinate \(Z\),

\[
 \sum_{\lambda\in\mathcal L}w_\lambda d_Z(\lambda)^3
       \le\sum_{\kappa\in\mathcal K}D_\kappa k_Z(\kappa)^3. \tag{7.3}
\]

#### Proof

By the defining union for \(\mathcal L\), choose for every distinct label
one owner \(o(\lambda)\in\mathcal K\) such that
\(d_Z(\lambda)\mid k_Z(o(\lambda))\) for all three coordinates.  This
assigns each label once and never duplicates it.  For a fixed owner
\(\kappa\), every assigned \(d_Z\) divides \(k_Z\), so
\(d_Z^3\le k_Z^3\).  The total totient weight of any subset of its downward
catalogue is at most the total weight of the full catalogue, which is exactly
\(D_\kappa\).  Thus the labels owned by \(\kappa\) contribute at most
\(D_\kappa k_Z^3\).  Sum over the owners. ∎

### Theorem 7.2 (global canonical arm-energy ceiling)

Assume \(N>0\) (along with \(0<B<C=B+1\) from the canonical setup), and
regard the finite weighted sums as nonnegative real numbers.  With totient
weights,

\[
 \boxed{
 E_U+E_V+E_W
 \le\frac1{N^3}\sum_{\kappa\in\mathcal K}D_\kappa
   \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right).
 }                                                       \tag{7.4}
\]

Consequently the factor-three canonical arm bounds imply

\[
 E_U+E_V+E_W
 \le\left(
   \frac{C^{18}}{27N^3}
  +\frac{C^{21}}{27C^3N^3}
  +\frac{C^{21}}{27B^3N^3}
  \right)\sum_{\kappa\in\mathcal K}D_\kappa.             \tag{7.5}
\]

#### Proof

Multiply (7.2U)--(7.2W) by the positive totient weights and sum over the
corresponding arm labels.  Enlarge each partial label set to all labels and
apply Lemma 7.1 coordinatewise.  This proves (7.4).  From
\(3k_U\le C^6\) and \(3k_V,3k_W\le C^7\), one has
\(k_U^3\le C^{18}/27\) and
\(k_V^3,k_W^3\le C^{21}/27\).  Substitution proves (7.5). ∎

This closes the previously untreated arm-level contribution with actual
catalogue weights.  The estimate counts coincident divisor labels only once;
using owner catalogues is an upper bound and therefore needs no catalogue
disjointness assumption.

## 8. The resulting global affine upper bound

For every repeated non-arm label, (4.5) gives over the reals

\[
 (n_\lambda-1)^3
   <\frac{KN}{T_\lambda^2}.                              \tag{8.1}
\]

Hence, with

\[
 \mathcal S_{\rm non}
   =\sum_{\substack{\lambda\text{ repeated}\\
                     \lambda\text{ non-arm}}}
      \frac{w_\lambda}{T_\lambda^2},                    \tag{8.2}
\]

one has (with equality allowed when the indexed part is empty)

\[
                         E_{\rm non}\le KN\mathcal S_{\rm non}. \tag{8.3}
\]

The catalogue baseline also satisfies

\[
                         W\le\sum_{\kappa\in\mathcal K}D_\kappa, \tag{8.4}
\]

by the same owner argument without the coordinate cube.

Combining (6.4), (7.4), (8.3), and (8.4) gives the following unconditional
large-label ceiling for the selected canonical-catalogue union within the
proved affine setup:

\[
\boxed{
\begin{aligned}
 E\le{}&\sum_{\kappa\in\mathcal K}D_\kappa
       +7KN\mathcal S_{\rm non}\\
 &+\frac7{N^3}\sum_{\kappa\in\mathcal K}D_\kappa
   \left(k_U^3+\frac{k_V^3}{C^3}+\frac{k_W^3}{B^3}\right).
\end{aligned}}                                           \tag{8.5}
\]

Only repeated non-arm labels enter \(\mathcal S_{\rm non}\), and (4.7)
shows that every term in it has \(KL^2>N\).  Thus (8.5) replaces the former
unspecified signed line-energy upper bound by:

1. the unavoidable deduplicated singleton baseline;
2. one inverse-square-period sum restricted to large primitive directions;
3. an explicit canonical arm moment already bounded in (7.5).

There is no raw number of supporting rays.  Combining (8.5) with the
previous monotone-overlap lower bound reduces the remaining affine task to
controlling \(\mathcal S_{\rm non}\) and comparing the diagonal baseline
against class multiplicities.  Neither task is declared false or abandoned.

The earlier shifted incidence identity remains compatible with this upper
bound.  If

\[
 J=\sum_\lambda w_\lambda(n_\lambda-1),
\]

then weighted Hölder gives

\[
 J^3\le W^2E_{\rm sh},\qquad I=W+J.                      \tag{8.6}
\]

Thus the same shifted energy is simultaneously the exact overlap carrier
and the quantity controlled by (7.4) and (8.3).

## 9. Full-premise pressure tests and exact retirement boundaries

### 9.1 Strictness of the large-label threshold

The capture squeeze fails if \(N^2<D\) is replaced by \(N^2\le D\).
Take

\[
 (n,H,T,C_\lambda,D,N,L)=(2,1,1,1,1,1,1).              \tag{9.1}
\]

The period capacity, span, factorization, positivity, and closed threshold
all hold, but (3.2) would read \(1<1\).  This retires exactly the closed
threshold version; actual large labels satisfy the required strict premise.

### 9.2 One more period factor is false at the uniform right side

The full pure-ledger tuple

\[
 (n,H,T,C_\lambda,D,N,K,L)=(2,3,3,6,18,3,6,1)          \tag{9.2}
\]

satisfies all premises of the period/capture argument.  The proved bound is

\[
 (n-1)^3T^2=9<18=KN,                                   \tag{9.3}
\]

whereas the tempting strengthening with \(T^3\) on the left says
\(27<18\).  Here \(K=6\) is an abstract capture constant compatible with the
smallest affine universal coefficient.  Under the supplementary quadratic
capture premise \(C_\lambda\le KL^2\), the first inequality in (3.3) gives
the valid normalized relation \((n-1)^2T<K\) after cancelling \(L^2>0\).
It holds here as \(3<6\), while adding another \(T\) fails as \(9<6\).
The quadratic premise is separate from the signed non-arm cubic capture
(4.2).  These examples do not affect the exact physical-period bound (3.4),
whose right side retains \(D\).

### 9.3 Primitivity is necessary for exact arm capture

Set \(B=2,C=3\) and scale the three primitive arm directions by five.
The following pairwise-coprime labels retain all relevant coefficient
coprimalities:

\[
\begin{array}{c|c|c|c}
\text{arm}&\lambda&(|A_U|,|A_V|,|A_W|)&C_\lambda\\ \hline
U&(1,5,1)&(0,15,10)&5\ne d_U,\\
V&(5,1,1)&(15,0,5)&5\ne d_V,\\
W&(5,1,1)&(10,5,0)&5\ne d_W.
\end{array}                                             \tag{9.4}
\]

Thus a nonprimitive parametrization can absorb an extra factor.  Every
lattice line has a primitive parametrization, so this refutes only deletion
of the primitive-support premise.

### 9.4 Coefficient coprimality is necessary on every arm

Still with \(B=2,C=3\), the following primitive examples delete each
independent coefficient-coprimality premise while retaining all the others:

\[
\begin{array}{c|c|c|c|c}
\text{arm}&\text{deleted premise}&\lambda
  &(|A_U|,|A_V|,|A_W|)&C_\lambda\\ \hline
U&\gcd(d_V,C)=1&(1,3,1)&(0,3,2)&3\ne d_U,\\
U&\gcd(d_W,B)=1&(1,1,2)&(0,3,2)&2\ne d_U,\\
V&\gcd(d_U,C)=1&(3,1,1)&(3,0,1)&3\ne d_V,\\
W&\gcd(d_U,B)=1&(2,1,1)&(2,1,0)&2\ne d_W.
\end{array}                                             \tag{9.5}
\]

Actual canonical labels satisfy all four coprimalities, so the canonical arm
theorem remains intact.

### 9.5 The kernel-catalogue membership premise is necessary

The owner bounds do not extend to the union of all arm-divisor labels.  In
the actual box

\[
 (B,C,M,N,R)=(1,2,10,9,2),                              \tag{9.6}
\]

there are 82 admissible points.  The deduplicated totient weight of all
arm-divisor labels above \(N^2\) is \(972{,}496\).  The same points realize
12 distinct powerful-kernel triples, whose owner mass is only
\(\sum_\kappa D_\kappa=1{,}072\).  Hence the false all-divisor version of
(8.4) would assert \(972{,}496\le1{,}072\).

This is a full-premise counterexample to deleting the defining membership
\(\mathcal L\subseteq\bigcup_\kappa\mathcal D(\kappa)\).  It does not touch
Lemma 7.1 or (8.5), both of which now state that premise explicitly.

### 9.6 Optimal global conversion and non-arm constant

At occupancy two, \(2^3=1+7(2-1)^3\), while coefficient six gives only
seven.  Hence the seven in (6.4) is optimal.

For the non-arm coefficient, \(s=t=1\) gives

\[
 P(1,1)=(B+1)(C+1)=K,                                  \tag{9.7}
\]

so no smaller universal coefficient can replace \(K\) in (4.2).

These counterexamples retire only their exact strengthened statements.  No
full-premise counterexample to any theorem in Sections 2--8 was found; as
stated below, that finite no-hit is not used as a proof.

## 10. Independent finite audit

The script

`research/computation/2026_09_01_affine_signed_ray_caps/verify_signed_ray_caps.py`

performs independent exact-integer and rational checks.  It:

- exhausts 15,840 signed directions for \(1\le B<C\le9\), verifies all
  three zero-direction identities, and finds equality in the constant
  \(K=(B+1)(C+1)\);
- checks 1,776,807 complete cubic ledgers and 2,390,018 complete normalized
  quadratic ledgers, including the linear capture squeeze;
- verifies (6.1) for occupancies from zero through 1,000 and checks the
  factor-six counterexample;
- exhausts 43,403 primitive exact-capture cases using the exact premises of
  each arm separately: 12,133 on \(U\), 15,391 on \(V\), and 15,879 on
  \(W\);
- records full-premise counterexamples to nonprimitive capture,
  missing coefficient coprimality, the closed large threshold, the two
  extra-period-factor strengthenings, and deletion of selected-catalogue
  membership; and
- enumerates all arm-divisor labels in four actual \(M=10\) boxes, containing
  4,307 distinct labels above \(N^2\) and 259 repeated labels.  This broader
  layer checks collinearity, primitive support, exact periods,
  (3.2)--(4.6), all three exact arm captures, (6.4), and the mixed
  period/capture charges; and
- separately constructs the actual powerful-kernel catalogues.  The four
  \(M=10\) boxes contain 110 selected-catalogue large labels, 12 repeated;
  the audit verifies the owner baseline (8.4), all three moments (7.3), the
  arm ceiling (7.4), and (8.5) exactly over \(\mathbb Q\).  A fifth stress
  case \((B,C,M)=(4,5,30)\) has 113 large labels, nine repeated, including
  one repeated non-arm label, so both the arm and non-arm terms of (8.5) are
  exercised.

The broader all-divisor layer is not substituted for \(\mathcal L\) in the
owner theorem; indeed it records the counterexample in Section 9.5.  The
finite audit is a pressure test, not the proof.  Its absence of a
counterexample does not retire or establish any broader route; the proofs in
Sections 2--8 establish the stated results for all admissible inputs.

## 11. Formalization boundary

The companion Lean module
`AffineSignedRayCanonicalCaps20260901.lean` kernel-checks, after the proofs
above:

- the pure exact period/span capture squeeze (3.2)--(3.4);
- the actual two-occurrence affine cancellation for an arbitrary signed
  integer direction and the resulting exact-period divisibility;
- signed coefficient capture and the sharp universal non-arm bound;
- the non-arm singleton-direction criterion and period-weighted cubic cap;
- the exact \(U\)-, \(V\)-, and \(W\)-level capture identities;
- all three linear arm capacities and their factor-three canonical
  specializations;
- the optimal pointwise coefficient seven, its factor-six counterexample,
  and the global weighted bridge (6.4);
- abstract finite weighted versions of the non-arm and arm shifted-energy
  aggregation used in (7.4)--(8.5);
- the owner-coordinate divisibility wrapper and final finite assembly of an
  owner baseline plus separate non-arm and arm charges; and
- the closed-threshold and extra-period-factor countermodels.

The owner-catalogue step uses the previously formalized exact totient
catalogue mass theorem; the new module formalizes its finite weighted
aggregation interface rather than re-axiomatizing Euler's identity.  The
concrete construction of the selected catalogue union and the rational
normalization in (7.4)--(8.5) are replayed independently in Section 10, not
encoded as a new monolithic Lean definition.  The module introduces no abc
hypothesis and proves no unconditional abc statement.
