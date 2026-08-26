# Residual orders and the cubeful tail in the Pell radical pair

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad b_n=s_n^2-3,
 \qquad c_n=s_n^2-2=b_n+1,
 \qquad X_n=b_nc_n,
\]

and put \(\lambda=97+56\sqrt3\) and
\(H_n=n\log\lambda\).  Thus

\[
 \log b_n=H_n+O(1),\qquad
 \log c_n=H_n+O(1),\qquad
 \log X_n=2H_n+O(1).                              \tag{0.1}
\]

This note gives two unconditional reductions of the large-prime problem.

First, the critical coefficient is governed not by squares, but by the
third and subsequent copies of support primes.  For any positive integer
\(N=\prod p^{e_p}\), define

\[
 \begin{aligned}
 E(N)&=\sum_p(e_p-1)\log p,\\
 C_3(N)&=\sum_{e_p\ge3}(e_p-2)\log p,\\
 S_1(N)&=\sum_{e_p=1}\log p.
 \end{aligned}
\]

Then exactly

\[
 2E(N)-\log N=C_3(N)-S_1(N).                       \tag{0.2}
\]

Consequently the Pell estimate

\[
 E(X_n)\le(1+\eta)H_n+O_\eta(1)                   \tag{0.3}
\]

is equivalent, up to the bounded error in (0.1), to

\[
 C_3(X_n)\le S_1(X_n)+2\eta H_n+O_\eta(1).         \tag{0.4}
\]

Prime squares are therefore exactly neutral at the critical coefficient.
The remaining theorem is a balance between the total super-square mass of
both consecutive factors and their exponent-one mass.

Second, Yu's residual-subgroup estimate can be combined with a homogeneous
norm carrier without summing norm sizes up to order \(2n\).  Let

\[
 Y_n=\sqrt n\exp\!\left(\kappa{
             \log n\over\log\log n}\right),
 \qquad 0<\kappa<{1\over8000},
 \qquad T_n={n^{1/3}\over\log n}.
\]

For an odd support prime put

\[
 t_p=\operatorname {ord}_{\mathbf F_p^\times}(\bar\lambda).
\]

Then, pointwise for every sufficiently large \(n\),

\[
 \boxed{
 \sum_{\substack{p\mid X_n\\p>Y_n\\t_p\le T_n}}
       (v_p(X_n)-1)\log p=o(n).}                   \tag{0.5}
\]

Together with the shifted Bilu--Hong--Gun cutoff below \(Y_n\), this moves
the unresolved tail to primes satisfying simultaneously

\[
 p>Y_n,\qquad t_p>{n^{1/3}\over\log n}.            \tag{0.6}
\]

The range (0.6) still contains both repeated hits
\(T_n<t_p\le2n\) and isolated first hits \(t_p>2n\).  Existing Hensel,
norm, gcd, Subspace-Theorem, and consecutive-almost-power results do not
prove the super-square balance (0.4).  No proof of abc is obtained.

## 1. Exact component ledger

For one prime exponent \(e\ge1\), the elementary identity

\[
 2(e-1)=e+\max(e-2,0)-\mathbf 1_{e=1}              \tag{1.1}
\]

has three different meanings.

* If \(e=1\), the exponent-one copy gives a negative contribution to the
  deviation from the square-root radical threshold.
* If \(e=2\), the deviation is exactly zero.
* If \(e\ge3\), precisely the copies after the second contribute positively.

Multiplying (1.1) by \(\log p\) and summing proves (0.2).  Equivalently,

\[
 {N\over\operatorname {rad}(N)^2}
 ={displaystyle\prod_{e_p\ge3}p^{e_p-2}
   \over\displaystyle\prod_{e_p=1}p}.             \tag{1.2}
\]

Since \(b_n,c_n\) are coprime, their ledgers add without overlap:

\[
 \begin{aligned}
 2(E(b_n)+E(c_n))-(\log b_n+\log c_n)
  ={}&C_3(b_n)+C_3(c_n)\\
    &-S_1(b_n)-S_1(c_n).                           \tag{1.3}
 \end{aligned}
\]

Equations (0.1) and (1.3) prove the equivalence between (0.3) and
(0.4).  In particular, if every prime in \(X_n\) has exponent at most two,
then the critical estimate holds automatically, with only the bounded error
from (0.1).

This also corrects an overly coarse scalar picture.  A single prime cannot
carry all \(2H_n\) of \(X_n\): it divides at most one of the coprime factors,
each of logarithmic size \(H_n+O(1)\).  An isolated cube filling one factor
has

\[
 3L=H_n,\qquad (3-1)L={2\over3}H_n,                \tag{1.4}
\]

which by itself does not exceed the total allowance \(H_n\).  Two disjoint
cube profiles, one in each factor, have combined excess

\[
 {4\over3}H_n>H_n.                                 \tag{1.5}
\]

Thus a valid marginal no-go model must respect the two component heights.
It still need not respect the much stronger equation \(c_n-b_n=1\); that
distinction is maintained below.

## 2. Local input with residual order

Put

\[
 \gamma_b=5+2\sqrt6,
 \qquad \gamma_c=3+2\sqrt2,
 \qquad L=\mathbf Q(\sqrt2,\sqrt3).
\]

Every odd prime in \(X_n\) splits completely in \(L\), and at a suitable
prime above it

\[
 v_p(X_n)=v_{\mathfrak p}(\lambda^n\gamma^{-1}-1),
 \qquad
 \gamma\in\{\gamma_b^{\pm1},\gamma_c^{\pm1}\}.   \tag{2.1}
\]

The residual-subgroup specialization of Yu's 2013 Main theorem (1.18), using
its (i=1) branch, with the fixed
saturated rank-two group kept explicit, gives effective constants
\(A,n_0\), depending only on the three fixed units, such that

\[
 v_p(X_n)\le A\left({t_p\over(\log p)^3}+1\right)
       \max\{\log n,\log p\}                       \tag{2.2}
\]

for \(n\ge n_0\) and all sufficiently large odd support primes.  The reason
the subgroup size is \(O(t_p)\), rather than merely \(O(p)\), is that a
target hit puts \(\bar\gamma\) in \(\langle\bar\lambda\rangle\), while
saturation enlarges the reduction subgroup by at most a fixed global index.
The moving \(\log p\) height floors in Yu's theorem are already included in
(2.2); they must not be discarded.

The direct Bilu--Hong--Gun bound is stronger in the worst case
\(t_p\asymp p\).  Estimate (2.2) is useful here only because the primes are
first grouped by \(t_p\).

## 3. A norm budget at one residual order

For \(t\ge1\), define the nonzero rational integer

\[
 A_t=
 N_{L/\mathbf Q}(\gamma_b^t-1)
 N_{L/\mathbf Q}(\gamma_c^t-1).                    \tag{3.1}
\]

If \(p\mid X_n\) and \(t_p=t\), then the selected target satisfies
\(\bar\gamma^t=1\).  Inversion changes \(\gamma^t-1\) only by a unit, so

\[
 p\mid A_t.                                       \tag{3.2}
\]

Neither norm in (3.1) vanishes, since the targets are not roots of unity.
Their conjugates are \(\gamma^{\pm t}-1\), each repeated twice in \(L\).
It follows that for an effective fixed \(B>0\),

\[
 \log|A_t|\le Bt.                                  \tag{3.3}
\]

Let \(\mathcal P_t\) be any set of rational support primes of residual order
\(t\).  From (3.2)--(3.3),

\[
 \sum_{p\in\mathcal P_t}\log p\le Bt,
 \qquad
 \max_{p\in\mathcal P_t}\log p\le Bt.            \tag{3.4}
\]

There is no hidden prime-ideal multiplicity in (3.4).  For each rational
\(p\in\mathcal P_t\), choose one prime ideal giving (2.1).  Whether other
prime ideals above the same \(p\) select conjugate targets is irrelevant:
the rational prime \(p\) is entered only once, and it divides the single
rational integer \(A_t\).  Hence the product of the distinct rational primes
in \(\mathcal P_t\) divides \(A_t\), which proves (3.4) without a degree
factor.  If the selected target is \(\gamma^{-1}\), multiplication by the
global unit \(-\gamma^{-t}\) identifies
\(\gamma^{-t}-1\) with \(\gamma^t-1\) ideal-theoretically.

Only one copy of each prime is used in (3.4).  No assertion that
\(p^{v_p(X_n)}\mid A_t\) is made; that stronger statement is generally
false and would erase the shifted-Hensel obstruction.

Here is the exact reason that a full-power replacement of (3.2) is
unavailable.  At the selected prime ideal write

\[
 a=\lambda^t,\qquad u=\lambda^n\gamma^{-1},
 \qquad \gamma^t=a^n u^{-t}.                      \tag{3.5}
\]

Thus \(a\equiv u\equiv1\pmod {\mathfrak p}\), but a large value of
\(v_{\mathfrak p}(u-1)\) need not be inherited by
\(\gamma^t-1\).  For instance, when \(p\nmid nt\), a local configuration

\[
 v_{\mathfrak p}(a-1)=1,\qquad
 v_{\mathfrak p}(u-1)=3                           \tag{3.6}
\]

has \(v_{\mathfrak p}(\gamma^t-1)=1\) exactly: the two summands obtained by
expanding \(a^nu^{-t}-1\) have distinct valuations one and three, by the
ordinary lifting formula.  The two extra copies in the shifted hit are
cancellation depth, not norm depth.  Homogeneous or fixed-gap carriers see
the first depth (or the minimum of two shifted depths); they do not see the
extra two.  This is a local method obstruction, not an assertion that the
fixed Pell units realize (3.6) at infinitely many primes.

## 4. Proof of the small-order large-prime estimate

Write \(Y=Y_n\), \(T=T_n\), and \(L_Y=\log Y\).  For each
\(1\le t\le T\), split the primes in (0.5) into

\[
 \mathcal P_t^- =\{p:Y<p\le n\},
 \qquad
 \mathcal P_t^+ =\{p:p>n\}.                       \tag{4.1}
\]

For the first set, the maximum in (2.2) is \(\log n\).  Since
\(\log p\ge L_Y\), equation (3.4) gives

\[
 \sum_{p\in\mathcal P_t^-}{1\over(\log p)^2}
 \le {1\over L_Y^3}
       \sum_{p\in\mathcal P_t^-}\log p
 \ll {t\over L_Y^3}.                              \tag{4.2}
\]

Thus

\[
 \sum_{p\in\mathcal P_t^-}v_p(X_n)\log p
 \ll \log n\left(t+{t^2\over L_Y^3}\right).       \tag{4.3}
\]

For \(p>n\), the maximum in (2.2) is \(\log p\).  Again using (3.4),

\[
 \begin{aligned}
 \sum_{p\in\mathcal P_t^+}{1\over\log p}
 &\le {1\over(\log n)^2}
       \sum_{p\in\mathcal P_t^+}\log p
 \ll {t\over(\log n)^2},\\
 \sum_{p\in\mathcal P_t^+}(\log p)^2
 &\le\left(\max_{p\in\mathcal P_t^+}\log p\right)
       \sum_{p\in\mathcal P_t^+}\log p
 \ll t^2.                                         \tag{4.4}
 \end{aligned}
\]

Consequently

\[
 \sum_{p\in\mathcal P_t^+}v_p(X_n)\log p\ll t^2. \tag{4.5}
\]

Summing (4.3) and (4.5) over \(t\le T\), and bounding
\(v_p-1\le v_p\), yields

\[
 \begin{aligned}
 \sum_{\substack{p\mid X_n\\p>Y\\t_p\le T}}
 (v_p(X_n)-1)\log p
 \ll{}& (\log n)T^2+T^3
       +{(\log n)T^3\over(\log Y)^3}.              \tag{4.6}
\end{aligned}
\]

Here \(\log Y=(1/2+o(1))\log n\).  With
\(T=n^{1/3}/\log n\), the three terms in (4.6) are respectively

\[
 O\!\left({n^{2/3}\over\log n}\right),
 \qquad O\!\left({n\over(\log n)^3}\right),
 \qquad O\!\left({n\over(\log n)^5}\right).       \tag{4.7}
\]

All are \(o(n)\), proving (0.5).  The proof is pointwise in \(n\); no
density assertion about Pell indices is used.

## 5. The surviving order ranges

Combining (0.5) with the shifted Bilu--Hong--Gun cutoff gives two remaining
regions.

### 5.1 Medium residual order

If

\[
 T_n<t_p\le2n,                                     \tag{5.1}
\]

the current occurrence is not the first positive hit of its target.  A
previous hit exists, and same-target gcd carriers place their shared depth
in homogeneous Pell--Lucas terms.  The current valuation can nevertheless
be strictly deeper than the earlier one.  The affine Hensel formula has one
exceptional lift class at each additional level, and a gcd sees only the
minimum of the two depths.  Summing the raw norm budgets (3.3) through all
orders in (5.1) costs at least the previously identified quadratic scale.

### 5.2 Large residual order and first hits

If

\[
 t_p>2n,                                             \tag{5.2}
\]

then \(n\) is the first positive hit of the selected inverse pair.  There is
no earlier term for a gcd or homogeneous carrier to compare with.  A cube or
higher power in this range is a genuinely shifted first-hit Wieferich event.
The norm \(N(\gamma^{t_p}-1)\) has logarithmic size \(O(t_p)\), which can be
much larger than the source height \(H_n\); it supplies no critical
coefficient.

Thus order stratification is now useful up to (0.5), but it does not close
either (5.1) or (5.2).

## 6. Cross-target synchronization

The two Pell factors are not arbitrary.  Besides \(c_n=b_n+1\), one has the
four-consecutive-integer block

\[
 b_n=3r_n^2-2,
 \quad b_n+1=3r_n^2-1,
 \quad b_n+2=3r_n^2,
 \quad b_n+3=s_n^2.                                \tag{6.1}
\]

This is precisely the kind of extra global compatibility absent from a
prime-by-prime Hensel model.  Current results on almost powers in consecutive
integers do not give (0.4).

For example, write two consecutive integers as

\[
 b=a u^3,\qquad b+1=d v^3,                          \tag{6.2}
\]

with \(a,d\) cube-free.  De Weger and van de Woestijne prove
unconditionally, by Thue-equation estimates, only

\[
 \max\{a,d\}\gg(\log b)^{1/5}                     \tag{6.3}
\]

for sufficiently large \(b\).  Their abc-conditional threshold for an
infinite family is the polynomial scale

\[
 \max\{a,d\}\ge b^{1/4-o(1)}.                     \tag{6.4}
\]

The exponent \(1/4\) is the exact two-integer, cube-free threshold in their
Theorem 1.4.  Thus replacing (6.3) by the scale needed to control two
simultaneous cube-rich factors is itself abc-level input in the ambient
consecutive-integer problem.

Blomer and Schoebel give nontrivial ambient upper bounds for the number of
pairs of consecutive \(k\)-full integers.  For \(k=3\) their exponent is
\(0.2665\).  This does not specialize pointwise to the Pell orbit: below a
height bound \(Z\) there are only \(O(\log Z)\) Pell values, so an exceptional
set of size \(Z^{0.2665}\) can contain the whole orbit.  Moreover violation
of (0.4) need not make either entire factor cubefull.

Pasten's unconditional truncated-counting inequality is also too weak at
the required coefficient.  This is a direct specialization, not an analogy.
Set

\[
 R_n=\operatorname {rad}(b_nc_n),\qquad L_n=\log R_n.
\]

In his Theorem 1.1 take \(v=\infty\), \(\alpha=1\), and
\(x=b_n/c_n\).  Coprimality is available, while
\(-\log|1-x|=\log c_n=H_n+O(1)\) and
\(h(x)=\log c_n=H_n+O(1)\).  For each fixed positive epsilon, the theorem
therefore gives, pointwise for all sufficiently large \(n\),

\[
 \log n\ll
 L_n{\log\log L_n\over\log L_n}.                 \tag{6.5}
\]

First (6.5) implies \(L_n\gg\log n\); substituting this coarse lower bound
back into the eventually increasing function
\(\log L/\log\log L\) gives

\[
 \log\operatorname {rad}(b_nc_n)
 \gg {\log n\,\log_2 n\over\log_3 n}.              \tag{6.6}
\]

The constants may depend on the fixed epsilon, which is harmless here.
This is the same \(o(n)\) logarithmic scale as the general Stewart theorem,
not one source-height unit.  Pasten's Theorem 1.9 obtains a Vojta-strength
version under the Lang--Waldschmidt conjecture.

A large sieve does not change these pointwise quantifiers.  It can bound an
average over primes or indices after one has specified a family of residue
classes.  At a single fixed index, however, every prime under discussion is
already selected by the congruence defining \(X_n\), and the additional
Hensel class at depth \(j\) is one admissible class modulo \(p^j\).  An
average theorem may show that such classes are rare for most indices; the
Pell reduction requires the critical estimate at every sufficiently large
index.  No audited large-sieve theorem removes the exceptional indices with
the coefficient required in (0.4).

The same quantifier issue explains the Subspace-Theorem boundary.  A
fixed-\(S\) equation has only finitely many exceptional solutions, but here
the support \(S=S_n\) moves with \(n\).  The BCZ gcd mechanism needs two
independent functions to vanish at the same prime.  Coprimality of
\(b_n,c_n\) gives the opposite situation: a support prime chooses exactly
one of the four targets.  Consequently neither a marginal large sieve, a
fixed-\(S\) Subspace theorem, nor a two-function gcd theorem supplies the
cross-target balance in (0.4).

These quantifiers leave open the possibility that the special four-term
orbit (6.1) is more rigid.  They do not prove that rigidity.

## 7. A quantifier-correct marginal no-go model

Fix a large index parameter \(N\), and let \(H=N\log\lambda\).  Put
\(Z=\exp(H/3)\).  The prime number theorem in the fixed progression
\(1\pmod {24}\) gives, for all sufficiently large \(N\), distinct split
primes \(q_b,q_c\) with

\[
 Z<q_b<2Z,
 \qquad 2Z<q_c<4Z.                                 \tag{7.1}
\]

At each prime take a cyclic orbit of order \(q_i-1>2N\), put the selected
target at index \(N\), and lift that target so that the first hit has depth
exactly three.  Concretely, choose a generator
\(\bar\lambda_i\in\mathbf F_{q_i}^{\times}\), lift it to
\(\lambda_i\in\mathbf Z_{q_i}^{\times}\), and take

\[
 \gamma_i=\lambda_i^N(1+q_i^3).
\]

Then \(\bar\gamma_i=\bar\lambda_i^N\), the inverse hit occurs only after
index \(N\), and
\(v_{q_i}(\lambda_i^N\gamma_i^{-1}-1)=3\).  The two local supports are
disjoint and the selected linear roots are simple.
For the two model factor sizes \(U_i=q_i^3\),

\[
 \log U_i=H+O(1),
 \qquad
 E(U_b)+E(U_c)={4\over3}H+O(1).                    \tag{7.2}
\]

This model respects:

1. the separate height \(H\) of each factor;
2. disjoint target support;
3. residual order greater than \(2N\);
4. first occurrence, simple roots, and unique Hensel lifting; and
5. the numerical inequalities extracted from every marginal local upper
   bound used above.

It deliberately does **not** satisfy \(U_c-U_b=1\), the fixed global units,
or the Pell recurrence.  It is therefore not a Pell counterexample and not
an abc counterexample.  Its precise logical conclusion is only this:

The local units \(\lambda_i,\gamma_i\) vary with \(N\) and \(q_i\).  In
particular this construction is not an instance of Yu's or
Bilu--Hong--Gun's theorem with one fixed global unit tuple.  It satisfies
only the numerical inequalities left after that fixed-unit provenance has
been forgotten.  Thus it is a countermodel to that package of marginal
inequalities, not to any theorem whose argument makes new global use of the
fixed Pell units.

> Separate local estimates for the two target families, even after enforcing
> their correct individual heights, do not imply the critical coefficient.
> A successful proof must use cross-target global compatibility such as
> (6.1), or an equivalent one-orbit truncated-counting theorem.

Unlike a single cube carrying \(2H\), the two-carrier model (7.2) respects
the component-height ledger.  It is the correct scalar boundary for methods
that treat the two coprime factors only marginally.

## 8. The smallest remaining proposition

The shifted Bilu--Hong--Gun theorem, (0.5), and (0.2) reduce the route to the
following form.  For every \(\eta>0\), prove

\[
 \sum_{\substack{p\mid X_n\\p>Y_n\\t_p>T_n}}
       (v_p(X_n)-2)_+\log p
 \le
 \sum_{\substack{p\mid X_n\\v_p(X_n)=1}}
       \log p
       +2\eta H_n+O_\eta(1).                       \tag{8.1}
\]

The small-prime super-square contribution is \(o(n)\), because it is bounded
by the already controlled small-prime powerful excess.  Hence (8.1), with a
harmless change of \(\eta\), implies (0.4) and the Pell radical estimate.

Equation (8.1) is weaker and more accurate than requiring all powerful
excess to be \(o(n)\).  It permits prime squares freely and permits
super-square mass to the extent that exponent-one support compensates it.
No primary theorem audited here proves (8.1) pointwise.

## 9. Formalization boundary

The companion Lean module
`IUTThreeClosures/FreyPellOrderCubefulTailAudit.lean` proves only:

* the per-exponent and finite-profile identities behind (0.2);
* the equivalence between the critical excess budget and the super-square
  balance when the total size is exactly \(2H\);
* the exact \(4H/3\) two-component cube ledger; and
* the scalar absorption of the three terms in (4.6), once their analytic
  bounds are supplied as hypotheses.

Lean does not formalize or assume Yu's theorem, prime splitting, residual
orders, norm divisibility, the prime number theorem in progressions, the estimates of de Weger--
van de Woestijne or Blomer--Schoebel, Pasten's theorem, or (8.1).  No missing
number-theoretic statement is introduced as an axiom.

## References

* K. Yu, *p-adic logarithmic forms and a problem of Erdos*, Acta Math. 211
  (2013), 315--382,
  [author PDF](https://archive.ymsc.tsinghua.edu.cn/pacm_download/117/6782-11511_2013_Article_106.pdf).
* Y. Bilu, H. Hong and S. Gun, *Uniform explicit Stewart's theorem on prime
  factors of linear recurrences*, Acta Arith. 206 (2022), 223--243,
  [author manuscript](https://arxiv.org/abs/2108.09857).
* B. M. M. de Weger and C. E. van de Woestijne, *On the power-free parts of
  consecutive integers*, Acta Arith. 90 (1999), 387--395,
  [author PDF](https://deweger.net/papers/%5B31%5DvdWdW-PowFree-ActaArith%5B1999%5D.pdf).
* V. Blomer and A. Schoebel, *Twins of powerful numbers*, Funct. Approx.
  Comment. Math. 49 (2013), 349--356,
  [journal DOI](https://doi.org/10.7169/facm/2013.49.2.12).
* H. Pasten, *On the arithmetic case of Vojta's conjecture with truncated
  counting functions*, [arXiv:2205.07841](https://arxiv.org/abs/2205.07841).
* P. Vojta, *A more general abc conjecture* (1998),
  [primary text](https://arxiv.org/abs/math/9806171).
