# The affine density attack: a squarefree bulk theorem and the coupled long-arm gate

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Scope:** the minimal-step affine shear with `Q = rad(abc)`  
**Status:** the eventual matching lower bound is neither proved nor refuted. The affine route remains active.

## 0. Verdict

Let

\[
 a+b=c,\qquad \gcd(a,b)=1,\qquad R=\operatorname{rad}(abc),
\]

and put

\[
 U=1+Rh,\qquad V=1+R(h+ck),\qquad W=1+R(h+bk).       \tag{0.1}
\]

The previous audit proved that `gcd(U,k)=1` makes `(aU,bV,cW)` a
primitive abc point and that all pair projections are injective.  It also
isolated the still-open lower target

\[
 \#\mathcal E_R(c^8)\ \gg\ R^{-2/3}c^{4+\eta}             \tag{0.2}
\]

uniformly on every sufficiently large seed with `R<c^lambda`, for fixed
`lambda<1` and `eta>0`.

This note proves three new unconditional statements.

1.  The cofactor gaps recover the seed exactly.  In particular
    \[
      \gcd(V-U,W-U)=Rk,                                    \tag{0.3}
    \]
    and the normalized consecutive gaps are `(a,b,c)`.  Conversely, the
    positive-parameter minimal shear is exactly the class of increasing
    cofactor triples with `U>1` whose normalized-gap radical divides their
    common gap and whose first member is `1 mod R`.  This gives a reverse,
    support-closed formulation of the route.

2.  Every three-quarter exception in the upper-half canonical box has large
    repeated-prime excess in **both** long arms:
    \[
      8192E(V)>Rc,\qquad 8192E(W)>Rc,                       \tag{0.4}
    \]
    where `E(n)=n/rad(n)`.  Thus a successful lower argument must solve a
    simultaneous two-arm high-excess problem, not merely force a square in one
    of the three forms.

3.  Despite (0.4), a fixed positive proportion of the same upper-half box is
    uniformly generic.  For every fixed `theta<5/2`, and hence for every
    subcritical `lambda<1`, all sufficiently large seeds with `R<c^theta`
    have at least
    \[
        \kappa N^2,\qquad
        \kappa={1\over2}\left(5-{\pi^2\over2}\right)>0,    \tag{0.5}
    \]
    parameter pairs which are admissible and for which `U,V,W` are all
    squarefree.  Here `N` is the side length of the upper-half parameter box.
    Every one of these outputs has radical at least its height and is therefore
    nonexceptional for every exponent below one.

Statement (0.5) supplies the previously missing large-square-tail control for
**generic squarefreeness** after the step is reduced from `abc` to `R`.  It
points in the opposite direction from (0.2).  A positive-density
nonexceptional bulk is fully compatible with a much smaller exceptional set
of order (0.2), so it cannot be inverted into the desired lower bound.

No unbounded subcritical seed family is produced here.  Consequently no
full-quantifier counterexample to the eventual lower bound, and no proof or
disproof of standard abc, is claimed.

## 1. Exact setup and notation

The seed coordinates are pairwise coprime.  Indeed, from `a+b=c` and
`gcd(a,b)=1`, one obtains

\[
 \gcd(a,c)=\gcd(a,a+b)=1,
 \qquad
 \gcd(b,c)=\gcd(b,a+b)=1.                                 \tag{1.1}
\]

The product `abc` is even.  If one of `a,b` is even this is immediate; if both
are odd, then `c` is even.  Hence

\[
                         2\mid R.                           \tag{1.2}
\]

Every prime divisor of `R` is absent from each cofactor in (0.1), since those
cofactors are `1 mod R`.

Let

\[
 M=\left\lfloor {c^6\over4R}\right\rfloor,
 \qquad
 I_M=\{\lfloor M/2\rfloor+1,\ldots,M\},
 \qquad
 N=|I_M|=M-\lfloor M/2\rfloor.                             \tag{1.3}
\]

Thus `N>=M/2`.  We call `I_M^2` the upper-half canonical box.  If
`h,k in I_M`, the previous height calculation gives

\[
                         H=cW<c^8                           \tag{1.4}
\]

for all sufficiently large `c`.

For a positive integer `n`, define

\[
 E(n)={n\over\operatorname{rad}(n)},\qquad
 S(n)=\prod_p p^{\lfloor v_p(n)/2\rfloor}.                 \tag{1.5}
\]

Prime by prime,

\[
 E(n)\le S(n)^2\le n.                                      \tag{1.6}
\]

## 2. The support-closed gap invariant

### Theorem 2.1 (exact gap gcd and seed recovery)

For every positive `h,k`, the cofactors (0.1) satisfy

\[
 \begin{aligned}
   V-W&=Rak,\\
   W-U&=Rbk,\\
   V-U&=Rck,                                                 \tag{2.1}
 \end{aligned}
\]

and

\[
 \gcd(V-U,W-U)=\gcd(V-W,W-U)=Rk.                            \tag{2.2}
\]

Consequently

\[
 a={V-W\over Rk},\qquad
 b={W-U\over Rk},\qquad
 c={V-U\over Rk}.                                          \tag{2.3}
\]

#### Proof

The three identities in (2.1) follow by subtraction from (0.1).  By (1.1),
`gcd(b,c)=1`; hence

\[
 \gcd(Rck,Rbk)=Rk\gcd(c,b)=Rk.
\]

The elementary identity `gcd(x+y,y)=gcd(x,y)`, applied to
`V-U=(V-W)+(W-U)`, gives the second equality in (2.2).  Division in (2.1)
is legitimate because `Rk>0` and proves (2.3). ∎

### Theorem 2.2 (reverse characterization of the minimal shear)

Let `1<U<W<V` be integers and put

\[
 g=\gcd(V-U,W-U),\quad
 a={V-W\over g},\quad b={W-U\over g},\quad c={V-U\over g}. \tag{2.4}
\]

Then `a,b,c` are positive, `a+b=c`, and `gcd(a,b)=1`.  Put
`R=rad(abc)`.  Assume

\[
                         R\mid g,\qquad R\mid U-1.          \tag{2.5}
\]

Define

\[
                         k=g/R,qquad h=(U-1)/R.             \tag{2.6}
\]

Then

\[
 U=1+Rh,qquad V=1+R(h+ck),qquad W=1+R(h+bk).              \tag{2.7}
\]

Moreover, this parameter is admissible exactly when `gcd(U,g/R)=1`.

#### Proof

The common divisor `g` divides `V-W=(V-U)-(W-U)`, so all quotients in
(2.4) are integral.  Positivity follows from `U<W<V`, and subtraction gives
`a+b=c`.  The identity

\[
 \gcd(V-W,W-U)=\gcd(V-U,W-U)=g
\]

shows, after cancelling `g`, that `gcd(a,b)=1`.

Under (2.5), (2.6) consists of integers and gives `g=Rk` and `U=1+Rh`.
Here `R>0`, while `U>1` and `W-U>0` imply `h>0` and `g>0`; hence also
`k>0`.
The definitions in (2.4) give

\[
 W-U=gb=Rkb,\qquad V-U=gc=Rkc,
\]

which are (2.7).  Finally the affine admissibility condition is, by
definition, `gcd(U,k)=1`, and `k=g/R`. ∎

Theorem 2.2 turns the constructive problem into a self-consistent gap problem:
find many low-radical triples `U<W<V` for which the radical of the normalized
gaps already divides their common gap.  This condition is absent from a
generic three-linear-form model and prevents one from freely choosing three
powerful values and only afterwards assigning a seed.

The strict hypothesis `U>1` is necessary for the positive-parameter version.
Indeed, `U=1,W=3,V=5` gives `g=2`, `(a,b,c)=(1,1,2)`, and `R=2`.
Both divisibilities in (2.5) and `gcd(U,g/R)=1` hold, but (2.6) gives
`h=0`.  Thus this row belongs only to the nonnegative-parameter closure of the
shear and is a full counterexample to the weaker statement with `1<=U`.

## 3. Every exception has two long high-excess arms

The earlier upper-half calculation proves that a three-quarter exception
satisfies

\[
                    E(U)E(V)E(W)>{Rc^{14}\over8192}.        \tag{3.1}
\]

The canonical size bounds can be taken in the convenient form

\[
                         U\le c^6,\qquad V,W\le c^7         \tag{3.2}
\]

for all sufficiently large `c`.  Since `E(n)<=n`, (3.1) has the following
pointwise consequence.

### Theorem 3.1 (two-long-arm excess necessity)

Every exception satisfying (3.1)--(3.2) obeys

\[
                         Rc<8192E(V),\qquad Rc<8192E(W).     \tag{3.3}
\]

Consequently

\[
 S(V)^2>{Rc\over8192},\qquad S(W)^2>{Rc\over8192}.          \tag{3.4}
\]

In particular, for `Rc>=8192`, both `V` and `W` are nonsquarefree.

#### Proof

Using `E(U)<=U<=c^6` and `E(W)<=W<=c^7` in (3.1),

\[
 {Rc^{14}\over8192}<c^{13}E(V).
\]

Cancel the positive factor `c^13` to obtain the first inequality in (3.3).
The second follows symmetrically.  Inequalities (3.4) follow from (1.6).  If a
positive integer is squarefree, its `S`-value is one, so (3.4) gives the final
claim. ∎

The threshold in (3.3) is much smaller than the full product threshold in
(3.1), but it is forced in each of two distinct, pairwise-coprime affine
forms.  A viable positive proof must therefore create simultaneous large
excess in `V` and `W` and then still supply the remaining product mass through
`U` or deeper powers in the long arms.

## 4. A uniform squarefree bulk in the minimal-step box

The step reduction to `R` changes the large-square boundary.  The parameter
side is `M asymp c^6/R`, whereas every cofactor is at most `c^7`.  On
`R<c^theta` with `theta<5/2`, this gives

\[
                         \sqrt{\max(U,V,W)}=o(M).            \tag{4.1}
\]

That inequality is strong enough for an elementary union bound over **all**
possible prime-square divisors, rather than only a fixed prime set.

### Lemma 4.1 (one-residue interval bound)

In an interval of `N` consecutive integers, one fixed residue class modulo
`d` occurs at most `N/d+1` times.

#### Proof

Successive representatives differ by `d`.  If there are `t` representatives,
the distance from the first to the last is `(t-1)d<N`; hence
`t<N/d+1`, which implies the stated weak bound. ∎

### Lemma 4.2 (bad-pair bounds at one prime)

Let `p` be a prime not dividing `R`.

1.  The number of `(h,k) in I_M^2` satisfying `p|U` and `p|k` is at most
    \[
                         (N/p+1)^2.                         \tag{4.2}
    \]
2.  For each `F in {U,V,W}`, the number satisfying `p^2|F` is at most
    \[
                         N^2/p^2+N.                         \tag{4.3}
    \]

If `p|R`, all four events are empty.

#### Proof

When `p` does not divide `R`, the coefficient of `h` is a unit modulo `p` and
modulo `p^2`.  The two conditions in (4.2) therefore prescribe one residue
class for each coordinate; Lemma 4.1 gives (4.2).

For (4.3), fix `k`.  Each of the three forms has coefficient `R` in `h`, so
`p^2|F` prescribes exactly one residue class of `h mod p^2`.  Lemma 4.1 gives
at most `N/p^2+1` choices of `h`, and summing over the `N` values of `k` gives
(4.3).  If `p|R`, every form is `1 mod p`. ∎

### Theorem 4.3 (uniform squarefree-admissible bulk)

Fix a real `theta<5/2`.  There exists `c_0(theta)` such that, for every
primitive seed with

\[
                         c\ge c_0(\theta),\qquad R<c^\theta, \tag{4.4}
\]

at least

\[
 \kappa N^2,\qquad
 \kappa={1\over2}\left(5-{\pi^2\over2}\right)>0            \tag{4.5}
\]

pairs `(h,k) in I_M^2` satisfy

\[
 \gcd(U,k)=1,qquad U,V,W\text{ are all squarefree}.        \tag{4.6}
\]

Every output supplied by (4.6) has

\[
                 \operatorname{rad}(aUbVcW)\ge H=cW,       \tag{4.7}
\]

and hence is nonexceptional for every fixed exponent `0<mu<1`.

#### Proof

If admissibility fails, some prime `p` divides both `U` and `k`.  Such a prime
cannot divide `R`, and it is at most `M`.  Summing (4.2) gives at most

\[
 N^2\sum_{\substack{p\ge3\\p\nmid R}}{1\over p^2}
 +2N\sum_{p\le M}{1\over p}+\pi(M)                         \tag{4.8}
\]

inadmissible pairs.  We used (1.2) to exclude `p=2`.

If one of `U,V,W` is not squarefree, a prime square divides that form.  The
forms are positive and at most

\[
 1+RM(1+c)\le1+{c^6(1+c)\over4}\le c^7                    \tag{4.9}
\]

for `c>=2`.  Hence the relevant prime is at most `c^(7/2)`.  Summing (4.3)
over the three forms gives at most

\[
 3N^2\sum_{\substack{p\ge3\\p\nmid R}}{1\over p^2}
                  +3Nc^{7/2}                               \tag{4.10}
\]

pairs with a nonsquarefree cofactor.

The prime sums are bounded by the sum over all odd integers at least three:

\[
 \sum_{\substack{p\ge3\\p\nmid R}}{1\over p^2}
 \le\sum_{j\ge1}{1\over(2j+1)^2}
 ={\pi^2\over8}-1.                                         \tag{4.11}
\]

Also `sum_(p<=M)1/p <= 1+log M` and `pi(M)<=M`.  By the union bound, the
number of good pairs is therefore at least

\[
 \left(5-{\pi^2\over2}\right)N^2
       -2N(1+\log M)-M-3Nc^{7/2}.                           \tag{4.12}
\]

The leading constant is positive because `pi^2<10`.  Under (4.4), for all
large `c`, the floor in (1.3) gives

\[
 M\ge {c^6\over8R}>{c^{6-\theta}\over8},qquad
 N\ge {c^{6-\theta}\over16}.                               \tag{4.13}
\]

Using also `M<=c^6/4`, and since `theta<5/2`, both

\[
 {1+\log M\over N}\longrightarrow0,qquad
 {c^{7/2}\over N}\ll c^{\theta-5/2}\longrightarrow0.      \tag{4.14}
\]

Thus the three error terms in (4.12) are at most half of its positive leading
term after increasing `c_0(theta)`.  This proves (4.5)--(4.6).

For a good pair, seed-prime avoidance and pairwise coprimality give

\[
 \operatorname{rad}(aUbVcW)
       =R\operatorname{rad}(U)\operatorname{rad}(V)
                            \operatorname{rad}(W)=RUVW.     \tag{4.15}
\]

Moreover, the first bound in (4.13) and `h>M/2` give
`U>RM/2>=c^6/16>=c` for large `c`.  Hence
`RUV>=c`, and (4.15) yields `RUVW>=cW=H`.  Since `H^mu<=H` for
`0<mu<1`, the output is nonexceptional. ∎

### Corollary 4.4 (the entire abc-subcritical range)

For every fixed `lambda<1`, Theorem 4.3 applies uniformly to every sufficiently
large seed with `R<c^lambda`.

#### Proof

Take `theta=lambda`, noting that `lambda<1<5/2`. ∎

The proof is deliberately elementary.  It does not invoke an asymptotic
squarefree-values theorem, and every coefficient dependence is visible in
(4.9), (4.13), and (4.14).

## 5. Why the bulk theorem does not prove or refute the matching lower

The raw upper-half box has

\[
                         N^2\asymp {c^{12}\over R^2}.       \tag{5.1}
\]

The desired exceptional lower count (0.2) occupies only the proportion

\[
 {R^{-2/3}c^{4+\eta}\over c^{12}R^{-2}}
                  =R^{4/3}c^{-8+\eta}.                     \tag{5.2}
\]

This tends to zero throughout the intended range for small fixed `eta`.
Therefore a fixed positive squarefree, nonexceptional bulk and a lower bound
of size (0.2) can coexist.  Theorem 4.3 cannot be complemented and inverted
into a positive exceptional count.

Nor does Theorem 4.3 refute the eventual statement (0.2).  Under the inherited
exceptional upper bound, the previous quantifier audit proved that (0.2) is
equivalent to boundedness of the same subcritical seed locus.  A
full-quantifier counterexample to (0.2) would supply an unbounded subcritical
seed sequence and would already disprove abc.  The finite search in Section 7
does not do this.

What Theorems 3.1 and 4.3 do prove is a sharper division of labor:

- small-prime squarefree sieve controls a uniform generic bulk;
- every desired point lies in simultaneous high-excess tails of `V` and `W`;
- a lower proof must exploit correlated large square/power divisors or the
  support-closed gap reconstruction of Theorem 2.2;
- a first moment, average radical, or density-one squarefree theorem cannot be
  reversed into the needed lower bound.

## 6. Literature audit

Only primary papers are used for the technical comparison.

1. **Bernert--Browning--Lichtman--Teravainen, 2026.**  The pinned paper
   *Bounds on the exceptional set in the abc conjecture*,
   [arXiv:2410.12234v2](https://arxiv.org/pdf/2410.12234v2), proves the radical
   tail used by the inherited pair-projection upper bound and, in Theorem 1.3,
   the global estimate `N_lambda(X) << X^(0.6+epsilon)` for fixed
   `lambda in (0,1)`.  At `X=c^8` the latter is `c^(4.8+epsilon)`, weaker than
   the affine-specific `R^(-2/3)c^(4+epsilon)`.  It therefore does not lower
   the gate (0.2).  The repository copy is
   `research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`.

2. **Nunes, 2018 version.**  *Square-free numbers in arithmetic progressions*,
   [arXiv:1402.0684v2](https://arxiv.org/pdf/1402.0684v2), proves variance and
   correlation estimates for squarefree integers in arithmetic progressions.
   Those results concern one-dimensional residue-class distributions and do
   not state the seed-uniform, three-correlated-form exceptional lower bound
   needed here.  Theorem 4.3 instead uses a direct union bound made possible by
   `sqrt(max F)=o(M)`.

3. **Li, 2025.**  *On the exceptional set in the abc conjecture*,
   [arXiv:2507.02885v1](https://arxiv.org/pdf/2507.02885v1), gave the earlier
   global exponent `56/85`.  It is superseded for the present comparison by
   the `0.6` exponent in the four-author 2026 paper and supplies no stronger
   affine-fibre statement.

Pinned copies of the latter two papers and their checksums are stored in
`research/sources/affine_density_attack_2026_09_01/`.

## 7. Targeted counterexample search

The all-square subroute is the conic

\[
                         ax^2+by^2=cz^2.                    \tag{7.1}
\]

The rational point `(1,1,1)` supplies a standard rational parameter chart.
For a reduced rational `t=p/q`, one convenient integral representative in
that chart is

\[
 \begin{aligned}
 X&=bp^2-2bpq-aq^2,\\
 Y&=aq^2-2apq-bp^2,\\
 Z&=aq^2+bp^2,                                               \tag{7.2}
 \end{aligned}
\]

followed by independent sign changes (the equation is diagonal in the three
squares) and division by the common gcd.  Rows with `0<X<Z<Y`,

\[
 X^2\equiv Y^2\equiv Z^2\equiv1\pmod R,                    \tag{7.3}
\]

and `gcd(X^2,(Y^2-Z^2)/(aR))=1` give genuine admissible minimal-step
parameters with `(U,V,W)=(X^2,Y^2,Z^2)`.

The companion exact replay scans a fixed, printed list of twenty subcritical
seeds and all reduced `p/q` in its declared finite box.  It verifies the conic,
all congruences, positivity, admissibility, radicals, and the strict
three-quarter inequality with arbitrary-precision integers.  After
deduplication it finds 49,671 admissible all-square rows but no exceptional
row in that finite region.  This is a finite no-hit only.  It refutes no
asymptotic or eventual statement and closes no route.

The already certified seed `(1,8,9)` with its complete canonical box and zero
exceptions remains a full counterexample only to threshold-free/nonempty
versions of the matching lower.  It does not satisfy the negation of the
eventual quantifiers.

## 8. Retained positive and negative gates

The affine route remains active in both directions.

A positive proof may now target either of the following exact tasks.

1. **Coupled long-arm construction.**  Produce uniformly more than
   `R^(-2/3)c^(4+eta)` admissible pairs satisfying (3.1), while explicitly
   meeting the two simultaneous necessities (3.3).
2. **Support-closed gap construction.**  Use Theorem 2.2 to construct many
   low-radical triples `U<W<V` whose normalized-gap radical divides the common
   gap.  This permits algebraic or Pell-type boundary points that a periodic
   main term cannot see.
3. **Source-level elimination.**  Prove the subcritical seed locus bounded by
   the contact, modular, Frey, IUT, or another route; in that case the eventual
   affine lower is true vacuously, exactly as the earlier quantifier theorem
   states.

A negative result against the eventual lower must exhibit an unbounded
subcritical seed sequence with normalized exceptional count tending to zero.
No such sequence is known here.  A finite no-hit, a generic squarefree bulk,
or failure of a sieve error term does not meet those quantifiers and is not a
reason to abandon the route.

## 9. Formalization boundary

The companion file
`Lean/IUTThreeClosures/AffineDensityAttack20260901.lean` is written after the
proofs above.  It formalizes:

- radical and powerful-part identities for squarefree naturals;
- the exact affine gap-gcd invariant and normalized recovery identities;
- the strict `U>1` positivity gate and the exact `(1,3,5)` counterexample to
  its weak `1<=U` replacement;
- an arbitrary-ring affine coordinate equivalence, which is the algebraic
  core of the one-residue local count;
- the two-long-arm excess cancellation theorem;
- squarefree cofactors having unit repeated-prime excess and therefore failing
  every threshold strictly above one.

The real asymptotic passage in Theorem 4.3, including the convergent odd-square
sum and the `o(M^2)` boundary estimate, is retained as the proved paper
argument rather than inserted into Lean as an axiom.  No analytic theorem,
matching lower bound, or abc statement is assumed in the module.
