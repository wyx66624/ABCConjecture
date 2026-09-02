# Direction periods and a cubic collinear-energy ceiling in the affine common-kernel route

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional line-period, fibre-capacity, and weighted-energy theorems; the global catalogue-weight transfer remains open

## 1. Purpose and scope

The preceding common-kernel checkpoint reduced one affine route to the
following problem.  A large actual arm-divisor label

\[
        \lambda=(d_U,d_V,d_W),\qquad D(\lambda)=d_Ud_Vd_W>N^2,
\]

has a fibre contained in one line, but the line-cap argument alone only gives
`M` points.  The third-gcd energy

\[
 \sum_{e_U,e_V,e_W}
   \varphi(e_U)\varphi(e_V)\varphi(e_W)n(e)^3
\]

therefore still appeared to have an uncontrolled collinear part.

This note extracts the exact arithmetic period of a common label along a
line.  On a nonconstant nonnegative ray it improves the linear fibre cap to
a cube-root cap and converts it into a weighted cubic-energy ceiling.  On a
vertical arm-level ray it proves a square-root cap once the constant arm
component is bounded.  The results are deterministic: no equidistribution,
prime-density, or unproved abc input is used.

The note also tests every tempting strengthening used in the argument.  The
canonical seed `(1,8,9)` gives a full-premise counterexample to treating the
whole label product as a line period.  A second exact model shows that
pairwise coprimality is indispensable.  These counterexamples remove only
the named stronger assertions; they do not remove the affine common-kernel
route.

## 2. The exact direction period

Use the affine arms

\[
 U(h,k)=1+Rh,\qquad
 V(h,k)=1+R(h+Ck),\qquad
 W(h,k)=1+R(h+Bk).
\]

Fix a nonnegative ray

\[
             x(n)=(h_0+ns,k_0+nt),\qquad n\in\mathbb N,
\]

and put

\[
 A_U=s,\qquad A_V=s+Ct,\qquad A_W=s+Bt.                 \tag{2.1}
\]

For a positive label define its reduced direction periods

\[
 r_Z(\lambda)=\frac{d_Z}{\gcd(d_Z,A_Z)},\qquad
 T_\lambda=r_U(\lambda)r_V(\lambda)r_W(\lambda),        \tag{2.2}
\]

and its direction capture

\[
 C_\lambda=gcd(d_U,A_U)\gcd(d_V,A_V)\gcd(d_W,A_W).     \tag{2.3}
\]

### Theorem 2.1 (actual affine direction period)

Assume that the components of `lambda` are positive and pairwise coprime.
If the same label divides the corresponding three arms at `x(n)` and
`x(m)`, then

\[
                         T_\lambda\mid |n-m|.            \tag{2.4}
\]

Moreover,

\[
                         T_\lambda C_\lambda=D(\lambda). \tag{2.5}
\]

### Proof

Since `d_U` divides an integer congruent to one modulo `R`, it is coprime to
`R`; the same holds for `d_V,d_W`.  Subtract the two arm values and cancel
`R`.  This gives

\[
 d_U\mid |n-m|A_U,\qquad
 d_V\mid |n-m|A_V,\qquad
 d_W\mid |n-m|A_W.                                     \tag{2.6}
\]

For integers (d>0) and (A,q\ge0), the elementary cancellation identity

\[
 d\mid qA\quad\Longrightarrow\quad
 \frac d{\gcd(d,A)}\mid q                              \tag{2.7}
\]

follows after dividing `d` and `A` by their gcd.  Applying (2.7) to (2.6)
shows that each `r_Z` divides `|n-m|`.  Each `r_Z` divides `d_Z`, so the
three reduced periods remain pairwise coprime.  Their product consequently
divides `|n-m|`, proving (2.4).

Finally,

\[
 \frac{d_Z}{\gcd(d_Z,A_Z)}\gcd(d_Z,A_Z)=d_Z
\]

for each arm.  Multiplication gives (2.5). ∎

Pairwise coprimality in this proof cannot be deleted.  Take

\[
 (d_U,d_V,d_W)=(2,2,1),\quad (A_U,A_V,A_W)=(1,1,1),
 \quad |n-m|=2.
\]

Every component divisibility in (2.6) holds, but the three reduced periods
have product `4`, which does not divide `2`.  This refutes exactly the
period-product assertion with the pairwise-coprimality premise removed.

## 3. Exact one-line capacity

Let `S` be a finite set of ray indices contained in `[0,H]`, and suppose the
same actual label occurs at every index in `S`.

### Corollary 3.1 (period capacity)

Under the hypotheses of Theorem 2.1,

\[
                 |S|\le \left\lfloor\frac H{T_\lambda}\right\rfloor+1.
                                                               \tag{3.1}
\]

### Proof

Equation (2.4) puts all elements of `S` in one residue class modulo
`T_lambda`.  Consecutive elements of that residue class are separated by at
least `T_lambda`, so an interval of length `H` contains at most the number
in (3.1). ∎

This capacity is exact.  It is also the correct replacement for the false
idea that `D(lambda)` itself is a period.

## 4. A cube-root cap away from arm-level directions

Assume now that `s>0` and (N>0), put

\[
 L=\max(s,t),\qquad K=(B+1)(C+1),                       \tag{4.1}
\]

and suppose the ray segment has coordinate span bounded by

\[
                              HL\le N.                  \tag{4.2}
\]

All three direction coefficients in (2.1) are then positive.  Hence

\[
\begin{aligned}
 C_\lambda
 &\le A_UA_VA_W\\
 &=s(s+Ct)(s+Bt)\\
 &\le (B+1)(C+1)L^3=KL^3.                              \tag{4.3}
\end{aligned}
\]

### Theorem 4.1 (nonconstant-ray cube-root cap)

Let `n_lambda` be the number of indices in `[0,H]` at which one positive,
pairwise-coprime actual label `lambda` occurs.  If (4.2) holds and

\[
                              N^2<D(\lambda),            \tag{4.4}
\]

then

\[
                    (n_\lambda-1)^3<KN.                 \tag{4.5}
\]

### Proof

Set `a=n_lambda-1` and `T=T_lambda`.  Corollary 3.1 gives `aT<=H`, hence

\[
                              aTL\le N.                  \tag{4.6}
\]

By (2.5), (4.3), and (4.4),

\[
                         N^2<TC_\lambda\le TKL^3.        \tag{4.7}
\]

Squaring (4.6) and comparing with (4.7) gives

\[
 a^2T^2L^2\le N^2<TKL^3,
 \qquad\text{so}\qquad a^2T<KL.                         \tag{4.8}
\]

Because `T>=1`, (4.8) gives `a^2<KL`; (4.6) also gives `aL<=N`.
If `a=0`, (4.5) is immediate.  Otherwise multiplication yields

\[
                         a^3<K(aL)\le KN,
\]

which is (4.5). ∎

The premise (N>0) cannot be deleted.  In the pure period ledger take

\[
 (n,H,T,C,D,N,K,L)=(1,0,1,1,1,0,1,1).
\]

Then the period, interval, factorization, capture, and strict large-label
premises all hold, but the claimed conclusion is (0<0).  This full-premise
counterexample retires exactly the version with ambient positivity omitted.

Thus, for fixed `B,C`, a large common label on such a ray has
`O(N^(1/3))` occupancy.  This is a genuine improvement over the previous
box-wide cap `M`; it does not assume that labels are fixed from point to
point outside the fibre being counted.

The premise `s>0` is doing real work.  If `s=0`, then
`gcd(d_U,A_U)=d_U`, so the constant `U` arm can contribute its whole label
without increasing the period.  Section 7 gives an actual canonical
instance.

## 5. The cubic collinear-energy ceiling

The shifted cube in (4.5) converts to the unshifted cubic moment with an
optimal universal integer constant.

### Lemma 5.1 (optimal shifted-cube conversion)

For a positive integer `X`,

\[
                  (n-1)^3<X\quad\Longrightarrow\quad n^3\le4X. \tag{5.1}
\]

The factor `4` cannot be replaced by `3`.

### Proof

The cases `n=0,1` are immediate.  Otherwise write `a=n-1>=1`.  Since the
quantities are integral, `a^3+1<=X`, and

\[
 4(a^3+1)-(a+1)^3=3(a-1)^2(a+1)\ge0.                  \tag{5.2}
\]

Thus `n^3=(a+1)^3<=4(a^3+1)<=4X`.  Sharpness against the next smaller
integer constant is witnessed by `n=X=2`:

\[
 (2-1)^3<2,\qquad 2^3=8=4\cdot2>3\cdot2.              \tag{5.3}
\]

∎

### Theorem 5.2 (weighted nonconstant-ray cubic-energy ceiling)

Under all the hypotheses of Theorem 4.1, let `mathcal L` be any finite
catalogue of positive, pairwise-coprime actual labels on the same ray
segment.  Assume every label satisfies (4.4), and
let `w_lambda` be arbitrary nonnegative integer weights.  Then

\[
 \sum_{\lambda\in\mathcal L}w_\lambda n_\lambda^3
 \le
 4(B+1)(C+1)N\sum_{\lambda\in\mathcal L}w_\lambda.     \tag{5.4}
\]

### Proof

Apply Theorem 4.1 and Lemma 5.1 with `X=KN` to every label, multiply by
`w_lambda`, and sum. ∎

For the third-gcd identity one may take

\[
 w_\lambda=\varphi(d_U)\varphi(d_V)\varphi(d_W).       \tag{5.5}
\]

Consequently the nonconstant-ray part of the cubic occupancy moment is no
longer controlled by the line length.  Its remaining cost is precisely the
**total totient weight of the large-label catalogue**.  Bounding that
weight from the actual repeated-prime-power construction is a sharper and
more arithmetic target than bounding arbitrary point-line incidences.

## 6. The vertical exceptional direction with an arm cap

The constant-arm direction is not hopeless, but it needs the information
that disappeared from (4.3).  Take `s=0`, `t>0`, and assume `B,C>0` and

\[
                              d_U\le X_U.                \tag{6.1}
\]

Then

\[
 C_\lambda
 =d_U\gcd(d_V,Ct)\gcd(d_W,Bt)
 \le X_UBC\,t^2.                                       \tag{6.2}
\]

### Theorem 6.1 (vertical square-root cap)

If `Ht<=N`, (4.4) holds, and the hypotheses above hold, then

\[
                     (n_\lambda-1)^2<X_UBC.             \tag{6.3}
\]

### Proof

Again put `a=n_lambda-1` and `T=T_lambda`.  Period capacity gives
`aTt<=N`.  By (2.5), (4.4), and (6.2),

\[
 a^2T^2t^2\le N^2<TC_\lambda\le T(X_UBC)t^2.
\]

Cancel the positive factor `Tt^2`.  This gives
`a^2T<X_UBC`, and `T>=1` yields (6.3). ∎

In an actual canonical application one may take `X_U` to be the maximum
possible `U` arm on the chosen vertical line or box.  Analogous estimates
for the two negative-slope arm-level directions require signed direction
coordinates and caps for `d_V` or `d_W`.

## 7. A canonical full-premise pressure test

Use the primitive seed

\[
 (a,b,c)=(1,8,9),\qquad R=6,\qquad M=22143,\qquad N=22142,
\]

the vertical ray based at `(21480,282)`, and the four indices

\[
                      S=\{0,5929,11858,17787\}.         \tag{7.1}
\]

At the corresponding four points use

\[
                  \lambda=(128881,49,121)=(359^2,7^2,11^2). \tag{7.2}
\]

All four points are in the canonical box, satisfy the actual admissibility
conditions, and have the displayed divisors in the corresponding arms.  In
particular, the three arms are pairwise coprime at each point.  Moreover,

\[
 D(\lambda)=764135449>490268164=N^2.                    \tag{7.3}
\]

For direction `(s,t)=(0,1)`,

\[
 T_\lambda=
 \frac{128881}{\gcd(128881,0)}
 \frac{49}{\gcd(49,9)}
 \frac{121}{\gcd(121,8)}
 =1\cdot49\cdot121=5929,                               \tag{7.4}
\]

and

\[
 C_\lambda=128881,\qquad T_\lambda C_\lambda=D(\lambda). \tag{7.5}
\]

Thus (3.1) is attained exactly:

\[
 |S|=4=\frac{17787}{5929}+1.                            \tag{7.6}
\]

By contrast,

\[
 \left\lfloor\frac{17787}{D(\lambda)}\right\rfloor+1=1. \tag{7.7}
\]

This is a full actual affine and admissibility counterexample to the exact
stronger implication “`D(lambda)` itself is a ray period, hence the fibre
has size at most `floor(H/D(lambda))+1`.”  It also refutes deletion of the
nonconstant-direction premise from the capture estimate (4.3), because the
right side based on `s(s+Ct)(s+Bt)` is zero while `C_lambda=128881`.

The example does **not** refute Theorems 2.1, 4.1, or 6.1.  It realizes
Theorem 2.1 sharply and belongs to the vertical case of Theorem 6.1.

## 8. Consequences for the remaining affine gate

The new information changes the collinear-energy task as follows.

1. On every nonconstant nonnegative ray, the cubic occupancy of each large
   label is uniformly bounded by Theorem 5.2.  A line of `M` lattice points
   can no longer by itself account for `M^3` units per label.
2. On a vertical arm-level ray, the uncontrolled constant component is now
   explicit.  An individual arm cap converts it into the square-root bound
   (6.3).
3. The remaining nonconstant-ray obstruction is the sum of totient weights
   in (5.5), together with the number of supporting rays.  Raw label count
   is not the correct invariant.
4. The two negative-slope arm-level directions, where `V` or `W` is
   constant, still require the signed analogue of Theorem 6.1 and the
   corresponding individual arm caps.
5. Finally, one must obtain enough large-label weighted energy from the
   actual exceptional-point certificates.  Pointwise large products alone
   still do not provide this overlap lower bound.

No full-premise counterexample to these remaining arithmetic transfer
requirements is known.  Difficulty or the absence of a finite-search hit
does not retire them.  The affine common-kernel route therefore remains
active.

## 9. Formalization boundary

The companion Lean module
`AffineCollinearPeriodEnergy20260901.lean` formalizes:

- reduced direction periods, direction capture, and the exact product
  factorization;
- actual affine cancellation along a nonnegative ray;
- the product-period divisibility and exact finite interval capacity;
- the nonconstant-ray shifted cube bound;
- the optimal factor-4 weighted cubic-energy conversion and its factor-3
  counterexample;
- the full-premise ambient-positivity boundary counterexample;
- the vertical direction-capture and shifted-square bounds;
- the pairwise-coprimality countermodel; and
- the canonical `(1,8,9)` full-premise counterexample to treating the whole
  label product as a period, including equality in the correct period cap.

The module introduces no abc hypothesis and proves no unconditional abc
statement.  Signed negative-slope aggregation and the global
totient-catalogue estimate remain outside the formalized closure because
they remain mathematically open, not because of a Lean limitation.
