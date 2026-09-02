# Actual totient catalogue mass and monotone overlap in the affine common-kernel route

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional finite catalogue identities and conditional energy lower bounds; a uniform asymptotic specialization for canonical exceptional kernels; repeated-label novelty and the signed line-energy upper bound remain open

## 1. Purpose and exact scope

The preceding affine checkpoint isolated four tasks after the exact
collinear-period theorem:

1. signed nonconstant directions;
2. aggregation over supporting rays;
3. the total weight of the **actual** divisor catalogue; and
4. a lower bound for the overlap energy created by exceptional points.

This note resolves the deterministic part of the last two tasks.  The
catalogue is not treated as an arbitrary family.  At an exceptional point it
is the downward divisor catalogue of the canonical repeated-kernel triple,
and its weight is the same Euler-totient weight that occurs in the exact
third-gcd energy identity.  Its total weight is exactly the product of the
three kernels.  Apart from a quantitatively negligible small-product tail,
that weight already lies above the box-square determinant threshold.

The second result handles catalogue overlap inside the energy sum without a disjointness
assumption.  Canonical kernel classes partition the exceptional set.  If one
divisor label is supported by several classes, its occupancy is the sum of
their class sizes, and the cube of this sum dominates the sum of their cubes.
Thus overlap can only increase the third-gcd energy.  This gives a direct
energy lower bound with the actual catalogue weights.  It does not assert
that two different kernel classes share a label: in the completely novel
case every occupancy can still equal one.

No exceptional-point lower bound is assumed, and no abc conclusion is
claimed.  The remaining signed and arm-level line-energy upper bounds are
not discarded: no full-premise counterexample to those corrected targets is
known.

## 2. The actual divisor catalogue

Let

\[
        d=(d_U,d_V,d_W),\qquad D(d)=d_Ud_Vd_W,
\]

where the three components are positive.  Its downward divisor catalogue is

\[
 \mathcal D(d)=
 \{e=(e_U,e_V,e_W):e_U\mid d_U, e_V\mid d_V, e_W\mid d_W\}.
                                                               \tag{2.1}
\]

Give a label the weight

\[
               w(e)=\varphi(e_U)\varphi(e_V)\varphi(e_W).      \tag{2.2}
\]

For a threshold `T`, put

\[
 \mathcal D_{>T}(d)=\{e\in\mathcal D(d):e_Ue_Ve_W>T\},
 \qquad
 L_T(d)=\sum_{e\in\mathcal D_{>T}(d)}w(e).                    \tag{2.3}
\]

Write `tau(n)` for the number of positive divisors of `n`.

### Theorem 2.1 (exact actual-catalogue weight)

For every positive triple `d`,

\[
                   \sum_{e\in\mathcal D(d)}w(e)=D(d).         \tag{2.4}
\]

#### Proof

The three sums separate, and Euler's divisor identity gives

\[
\begin{aligned}
 \sum_{e\in\mathcal D(d)}w(e)
 &=\left(\sum_{e_U\mid d_U}\varphi(e_U)\right)
   \left(\sum_{e_V\mid d_V}\varphi(e_V)\right)
   \left(\sum_{e_W\mid d_W}\varphi(e_W)\right)\\
 &=d_Ud_Vd_W.
\end{aligned}
\]

No coprimality is required for this identity. ∎

### Theorem 2.2 (finite large-label tail)

For every `T>=0`,

\[
 D(d)\le L_T(d)+
 T\,\tau(d_U)\tau(d_V)\tau(d_W).                             \tag{2.5}
\]

Equivalently, whenever nonnegative `Q` satisfies

\[
 T\,\tau(d_U)\tau(d_V)\tau(d_W)+Q\le D(d),                  \tag{2.6}
\]

one has `Q<=L_T(d)`.

#### Proof

Split (2.4) into labels with product at most `T` and labels with product
greater than `T`.  Euler's elementary bound `phi(m)<=m` gives, on the first
part,

\[
 w(e)\le e_Ue_Ve_W\le T.
\]

There are at most
`tau(d_U)tau(d_V)tau(d_W)` such triples.  Hence their total weight is at most
the second term of (2.5).  Adding the large part proves (2.5), and (2.6)
gives the stated rearrangement without any truncated subtraction. ∎

This estimate is deliberately stated with the actual divisor counts.  A
bound that simply subtracts `T` is false; Section 6 records a complete
counterexample.

There is also an unconditional baseline that the coarse margin in (2.5)
does not show.  If `T<D(d)`, the top label `e=d` itself belongs to the large
catalogue, so

\[
       \varphi(d_U)\varphi(d_V)\varphi(d_W)\le L_T(d).       \tag{2.7}
\]

In particular the large catalogue is nonempty.  The issue is quantitative
mass and reuse across different points, not existence of one top label.

## 3. Uniform specialization to canonical exceptional kernels

At a canonical admissible affine point, let

\[
 d=(K(U),K(V),K(W)),\qquad D=K(U)K(V)K(W),                   \tag{3.1}
\]

where `K(n)` is the product of the exact prime powers in `n` whose exponent
is at least two.  The three components are pairwise coprime.  In the
subcritical route,

\[
 M=\left\lfloor\frac{c^6}{4R}\right\rfloor,
 \qquad N=M-1,
 \qquad T=N^2.                                               \tag{3.2}
\]

The already proved canonical arm bounds and the exceptional excess
inequality give

\[
       27D\le c^{20},
 \qquad
       D>\frac{Rc^{14}}{8192},
 \qquad
       T<\frac{c^{12}}{16R^2}.                               \tag{3.3}
\]

The middle inequality follows because
`D=rad(d) E(U)E(V)E(W)` and `rad(d)>=1`.

We use the following elementary divisor estimate.

### Lemma 3.1 (fixed-power divisor bound)

For every real `epsilon>0` there is a constant `C_epsilon` such that

\[
                         \tau(n)\le C_\epsilon n^\epsilon   \tag{3.4}
\]

for every positive integer `n`.

#### Proof

Choose `P` so large that `p^epsilon>=2` for every prime `p>P`.  For `a>=1`,
`a+1<=2^a`; hence

\[
                    a+1\le p^{\epsilon a}\qquad(p>P).       \tag{3.5}
\]

For each of the finitely many primes `p<=P`, the sequence
`(a+1)/p^(epsilon a)` is bounded.  Let `C_p` be a bound and put
`C_epsilon=prod_(p<=P) C_p`.  If `n=prod p^(a_p)`, multiplication of these
factorwise bounds gives

\[
 \tau(n)=\prod_p(a_p+1)
 \le C_\epsilon\prod_p p^{\epsilon a_p}
 =C_\epsilon n^\epsilon.
\]

∎

### Corollary 3.2 (almost all actual weight is determinant-large)

There is an absolute constant `C>0` such that every canonical exceptional
kernel in this route satisfies

\[
 \frac{D-L_{N^2}(d)}{D}
 \le \frac{64C^3}{27c^{3/2}}.                               \tag{3.6}
\]

In particular,

\[
                 L_{N^2}(d)=(1-O(c^{-3/2}))D               \tag{3.7}
\]

uniformly over all points and all subcritical seeds in the canonical range.

#### Proof

Use Lemma 3.1 with `epsilon=1/40` separately on the three components.  Then

\[
 \tau(d_U)\tau(d_V)\tau(d_W)
 \le C^3D^{1/40}
 \le C^3c^{1/2},                                            \tag{3.8}
\]

where the last inequality uses `D<=c^20/27<c^20`.  From (3.3),

\[
 \frac{T}{D}<\frac{512}{R^3c^2}.                            \tag{3.9}
\]

Theorem 2.2, (3.8), and (3.9) therefore give

\[
 \frac{D-L_T(d)}D
 \le\frac{512C^3}{R^3c^{3/2}}
 \le\frac{64C^3}{27c^{3/2}},                               \tag{3.10}
\]

because the actual primitive subcritical range has `R>=6`. ∎

This closes the earlier ambiguity about arbitrary catalogue weights: the
actual downward catalogue has total weight `D`, and asymptotically all of it
is already on labels whose product exceeds the sharp box-square threshold.
The result does not say that one such label occurs at many different points.
The next section isolates exactly what energy aggregation supplies and what
additional control genuine cross-point reuse still requires.

## 4. Overlap can only increase the cubic energy

Let `mathcal K` be a finite set of realized canonical kernel triples.  The
exceptional set is partitioned into their classes, and `m_kappa` denotes the
size of the class indexed by `kappa`.  Let `mathcal L` be the union of their
large downward catalogues.  For `e in mathcal L`, set

\[
 n(e)=\sum_{\substack{\kappa\in\mathcal K\\e\mid\kappa}}m_\kappa,
 \qquad
 \mathcal E_{>T}=\sum_{e\in\mathcal L}w(e)n(e)^3.           \tag{4.1}
\]

Here `e|kappa` means componentwise divisibility.  Formula (4.1) is precisely
the large-label part of the third-gcd incidence expansion.

### Lemma 4.1 (cube superadditivity)

For any finite family of nonnegative integers `a_i`,

\[
                         \sum_i a_i^3\le\left(\sum_i a_i\right)^3. \tag{4.2}
\]

#### Proof

Put `A=sum_i a_i`.  Since `a_i<=A`, one has
`a_i^3<=a_i A^2`.  Summing gives
`sum_i a_i^3<=A^2 sum_i a_i=A^3`. ∎

### Theorem 4.2 (monotone canonical-overlap lower bound)

With the notation above,

\[
 \boxed{
 \quad
 \sum_{\kappa\in\mathcal K}m_\kappa^3L_T(\kappa)
 \le \mathcal E_{>T}.
 \quad}                                                     \tag{4.3}
\]

No disjointness between the divisor catalogues is assumed.

#### Proof

For a fixed label `e`, Lemma 4.1 gives

\[
 \sum_{\kappa:e\mid\kappa}m_\kappa^3
 \le
 \left(\sum_{\kappa:e\mid\kappa}m_\kappa\right)^3
 =n(e)^3.                                                   \tag{4.4}
\]

Multiply by the nonnegative weight `w(e)` and sum over the large labels.
Interchanging the two finite sums on the left gives

\[
\begin{aligned}
 \sum_e w(e)\sum_{\kappa:e\mid\kappa}m_\kappa^3
 &=\sum_\kappa m_\kappa^3
   \sum_{\substack{e\mid\kappa\\e_Ue_Ve_W>T}}w(e)\\
 &=\sum_\kappa m_\kappa^3L_T(\kappa).
\end{aligned}
\]

The right side of the summed version of (4.4) is `mathcal E_>T`, proving
(4.3). ∎

Combining Theorem 4.2 with Corollary 3.2 gives the actual asymptotic
catalogue-energy lower bound

\[
 \mathcal E_{>N^2}
 \ge
 \left(1-O(c^{-3/2})\right)
 \sum_{\kappa\in\mathcal K}D(\kappa)m_\kappa^3.             \tag{4.5}
\]

This is stronger than a generic weighted Hölder lower bound because it uses
the canonical partition before combining coincident sublabels.  If several
kernel classes support the same label, the cross terms in the occupancy cube
are positive and only strengthen (4.5).

If no large label is reused, however, every relevant `n(e)` may equal one;
then (4.5) contains only diagonal energy.  A genuine shared-label conclusion
still needs an upper bound for the weight of the deduplicated catalogue, or
equivalently a bound for the novelty contributed by singleton labels.

## 5. An abstract weighted-Hölder fallback

For completeness, let `w_i,n_i>=0` and put

\[
 W=\sum_iw_i,\qquad I=\sum_iw_in_i,\qquad
 E=\sum_iw_in_i^3.
\]

### Proposition 5.1 (weighted cubic incidence inequality)

\[
                              I^3\le W^2E.                  \tag{5.1}
\]

#### Proof

Cauchy--Schwarz applied to
`r_i=w_i n_i`, `f_i=w_i`, `g_i=w_i n_i^2` gives

\[
                              I^2\le WQ,
 \qquad Q=\sum_iw_in_i^2.                                  \tag{5.2}
\]

A second application to
`r_i=w_i n_i^2`, `f_i=w_i n_i`, `g_i=w_i n_i^3` gives

\[
                              Q^2\le IE.                    \tag{5.3}
\]

If `I=0`, (5.1) is immediate.  Otherwise square (5.2), use (5.3), and cancel
the positive factor `I`:

\[
 I^4\le W^2Q^2\le W^2IE
 \quad\Longrightarrow\quad I^3\le W^2E.
\]

∎

Theorem 4.2 is the preferred affine statement.  Proposition 5.1 remains
useful when only total weighted incidence and total catalogue weight are
available.

### Proposition 5.2 (shifted weighted incidence and ray caps)

Suppose every occurring label has occupancy `n_i>=1` and define

\[
 J=\sum_iw_i(n_i-1),\qquad
 E_{\rm sh}=\sum_iw_i(n_i-1)^3.                            \tag{5.4}
\]

Then

\[
                         J^3\le W^2E_{\rm sh}.              \tag{5.5}
\]

More generally, if each label has an individual shifted cap

\[
                         (n_i-1)^3\le X_i,                  \tag{5.6}
\]

then

\[
                         J^3\le W^2\sum_iw_iX_i.            \tag{5.7}
\]

Since `n_i>=1`, one also has the exact incidence decomposition

\[
 I=\sum_iw_in_i
   =W+\sum_iw_i(n_i-1)=W+J.                                \tag{5.8}
\]

Consequently the shifted energy is an explicit overlap lower bound in
polynomial form:

\[
                    (I-W)^3\le W^2E_{\rm sh}.               \tag{5.9}
\]

#### Proof

Apply Proposition 5.1 with `n_i-1` in place of `n_i`, and then use (5.6)
term by term.  For (5.8), the identity
`n_i=1+(n_i-1)` holds termwise because `n_i>=1`; summing it gives
`I=W+J`.  Substitution into (5.5) proves (5.9). ∎

This is the exact form needed for supporting rays.  The period theorem gives
a bound directly on `(n_i-1)^3`, so (5.7) avoids the factor four introduced
when converting to `n_i^3`.  Different labels may use different supporting
rays and different caps `X_i`; the sum is labelwise and introduces no raw
number-of-rays factor.  What remains is to prove the signed ray cap for every
non-arm-level line and the three individual arm-level caps.

## 6. Full-premise pressure tests

### 6.1 The subtraction-one shortcut is false

Take

\[
                  (d_U,d_V,d_W)=(9,25,1),\qquad T=5.        \tag{6.1}
\]

The components are positive, pairwise coprime, and powerful; their product is
`D=225>T`.  The small labels have total weight

\[
  w(1,1,1)+w(3,1,1)+w(1,5,1)=1+2+4=7.                     \tag{6.2}
\]

Thus

\[
                         L_5(d)=225-7=218<220=225-5.        \tag{6.3}
\]

This is a full-premise counterexample to the tempting strengthening

\[
                              L_T(d)\ge D(d)-T.             \tag{6.4}
\]

It does not contradict Theorem 2.2, whose discarded-weight term retains the
number of small divisor labels.

### 6.2 Large pointwise mass does not force a repeated label

Take two singleton kernel classes with triples `(121,1,1)` and `(169,1,1)`
and threshold `T=1`.  Every class has positive large-label totient mass, but
their large divisor labels are respectively supported on powers of `11` and
powers of `13`; no large label occurs in both classes.  This refutes the
claim that positive pointwise large-catalogue mass alone forces occupancy at
least two.

It does not contradict Theorem 4.2.  In this example the relevant
occupancies are one, and (4.3) is sharp.  A proof of abc must still combine
the lower bound with a sufficiently strong upper bound or with a separate
mechanism forcing repeated support.

## 7. Consequences and remaining gates

The previous four affine tasks now separate as follows.

1. **Actual catalogue weights:** the total weight is exactly the canonical
   kernel product, and the portion above the determinant threshold is
   `1-O(c^(-3/2))` of it uniformly.  This part is no longer an arbitrary
   catalogue-size problem.
2. **Energy aggregation:** Theorem 4.2 gives an unconditional lower bound
   with the exact class multiplicities.  Catalogue overlap is favorable and
   needs no disjointification loss.  It does not force reuse; controlling the
   deduplicated catalogue or singleton novelty remains an active gate.
3. **Signed nonconstant directions:** the existing period proof must be
   extended to oriented integer directions.  Its three coefficients are
   `s`, `s+Ct`, and `s+Bt`; their absolute values give the same cubic capture
   bound when none vanishes.
4. **Supporting-line aggregation and arm-level directions:** Proposition 5.2
   already performs the labelwise aggregation once individual caps are
   available, and it removes the earlier factor four.  After the signed
   extension, every large label has one supporting line and no raw
   number-of-lines factor should be introduced.  The three zero-coefficient
   directions still require their individual canonical arm caps.

The new lower bound (4.5) does not by itself exceed the signed collinear
upper bound.  It therefore does not prove abc.  Nor does either pressure
test refute the corrected route.  Difficulty in proving the remaining upper
comparison leaves the route active.

## 8. Formalization boundary

The companion module
`AffineCatalogueWeightOverlap20260901.lean` kernel-checks:

- the exact three-coordinate totient-catalogue identity;
- the finite small-product and large-tail inequalities;
- the top-label lower baseline (2.7);
- cube superadditivity for finite nonnegative families;
- the abstract monotone-overlap theorem, including the finite sum
  interchange that models coincident divisor catalogues;
- the weighted cubic incidence inequality `I^3<=W^2E`;
- its shifted, label-specific-cap consequence (5.5)--(5.7), together with
  the exact overlap form (5.8)--(5.9); and
- the exact `(9,25,1), T=5` counterexample to the false subtraction-one
  strengthening.

Corollary 3.2 uses the self-contained asymptotic divisor estimate of Lemma
3.1 together with already formalized canonical arm and excess inequalities.
The new Lean module records its exact finite arithmetic interface (2.5)--
(2.6); it does not insert the asymptotic divisor bound as an axiom.  The
signed direction and final line-energy comparison remain outside the module
because they are the next mathematical tasks, not because either has been
refuted.
