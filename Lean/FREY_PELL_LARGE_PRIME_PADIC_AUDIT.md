# A shifted Stewart--Yu bound for the large-prime Pell audit

## Abstract

Put

\[
 \lambda=97+56\sqrt3,
 \qquad
 \gamma_b=5+2\sqrt6,
 \qquad
 \gamma_c=3+2\sqrt2,
\]

and let

\[
 X_n=(s_n^2-3)(s_n^2-2).
\]

Every odd prime in the support of \(X_n\) splits completely in
\(L=\mathbf Q(\sqrt2,\sqrt3)\).  At a suitable prime
\(\mathfrak p\mid p\), its valuation is one of the four shifted forms

\[
 v_p(X_n)=v_{\mathfrak p}(\lambda^n\gamma^{-1}-1),
 \qquad
 \gamma\in\{\gamma_b^{\pm1},\gamma_c^{\pm1}\}.
 \tag{0.1}
\]

The principal result of this audit is unconditional.  The auxiliary-small-
prime argument in Bilu--Hong--Gun's explicit version of Stewart's theorem
extends to every shifted form in (0.1), without changing the number of
logarithms used in their proof.  For

\[
 p\ge p_0:=\exp\!\bigl(80000\cdot4(\log4)^2\bigr)
\]

one obtains

\[
 \boxed{
 v_p(X_n)\le
 p\exp\!\left(-0.0005{\log p\over\log\log p}\right)
 h(\lambda)\log^*n.}
 \tag{0.2}
\]

Consequently, for every fixed

\[
 0<\kappa<{1\over8000},
 \qquad
 Y_n=\sqrt n\exp\!\left(\kappa{\log n\over\log\log n}\right),
\]

the powerful excess below \(Y_n\) is \(o(n)\), pointwise in \(n\).  This is
strictly stronger than the direct fixed-unit consequence of Yu's 2013
subgroup-index refinement, which reaches essentially
\(\sqrt n\log n\).

This advance does **not** prove the required full excess estimate.  The
remaining primes above \(Y_n\) may still contain two isolated first-hit
cubes, one in each of the coprime factors \(b_n\) and \(c_n\), or analogous
higher powers.  Giving each cube its own factor's logarithmic mass produces
combined excess \(4/3\) of one source-height unit.  This balanced scalar
profile is compatible with every local upper bound audited here.  It is an
abstract obstruction to an implication from the available estimates, not a
counterexample to the actual Pell sequence.

## 1. Exact Pell budget and the shifted forms

The four-target identities are

\[
 \begin{aligned}
 4\lambda^n(s_n^2-3)
   &=(\lambda^n-\gamma_b)(\lambda^n-\gamma_b^{-1}),\\
 4\lambda^n(s_n^2-2)
   &=(\lambda^n-\gamma_c)(\lambda^n-\gamma_c^{-1}).
 \end{aligned}
 \tag{1.1}
\]

Here is the local meaning of (0.1).  For a rational support prime \(p\),
complete splitting gives \(e_{\mathfrak p}=f_{\mathfrak p}=1\) at every
\(\mathfrak p\mid p\), so the valuation of the rational integer \(X_n\)
equals its \(\mathfrak p\)-adic valuation.  The two factors belonging to one
quadratic target in (1.1) are distinct modulo \(\mathfrak p\), because their
differences have discriminant certificates \(96\) and \(32\); the cross
resultant is supported at \(2\).  Since \(s_n^2-3\) and \(s_n^2-2\) are
coprime, exactly one of the four factors is nonunit at \(\mathfrak p\).
Dividing that factor by the units \(\lambda^n\) and \(\gamma\) proves the
valuation equality (0.1), not merely an inequality.

Define

\[
 E_n=\sum_{p\mid X_n}(v_p(X_n)-1)\log p.
 \tag{1.2}
\]

Since \(\log X_n=2n\log\lambda+O(1)\), the Pell radical route needs

\[
 E_n\le(1+\eta)n\log\lambda+O_\eta(1).
 \tag{1.3}
\]

The pair \(\lambda,\gamma\) is multiplicatively independent for each of the
four targets.  For example, the automorphism of \(L\) which changes the sign
of \(\sqrt2\) fixes \(\lambda\) and sends both \(\gamma_b\) and \(\gamma_c\)
to their inverses.  Applying it to
\(\lambda^a\gamma^b=1\) and dividing by the original equality gives
\(\gamma^{2b}=1\), hence \(b=0\), and then \(a=0\).  This also proves that
every expression in (0.1) is nonzero.

## 2. The precise logarithmic-form input

Theorem 3.1 of Bilu--Hong--Gun is the following simplified form of Yu's 2013
theorem.  Let \(K\) have degree \(d\), let \(\mathfrak p\mid p\) with
\(p\ge 5\), and let
\(\alpha_1,\ldots,\alpha_k\) be multiplicatively independent
\(\mathfrak p\)-adic units.  For integers \(b_i\), not all zero, put
\(B=\max_i|b_i|\).  Their theorem states

\[
 \begin{aligned}
 v_{\mathfrak p}(\alpha_1^{b_1}\cdots\alpha_k^{b_k}-1)
 &\le 10^5d^{k+2}(\log^*d)^3\cdot30^k k^{5/2}(\log^*k)\\
 &\quad\cdot h(\alpha_1)\cdots h(\alpha_k)
 \Omega\log^*B,
 \end{aligned}
 \tag{2.1}
\]

where

\[
 \Omega=\max\left\{
 {N\mathfrak p\over\delta}
 \left({k\over\log N\mathfrak p}\right)^k,
 e^k\log N\mathfrak p\right\}.
 \tag{2.2}
\]

The parameter \(\delta\) may exploit a residue subgroup when a square-Kummer
condition holds.  Crucially, \(\delta=1\) is always admissible.  The shifted
argument below therefore uses no unproved saturation or Kummer assertion.

## 3. Why the shifted extension is valid

Fix one target \(\gamma\) and a split prime \(p\).  Write

\[
 d=[L:\mathbf Q]=4,
 \qquad P=N\mathfrak p=p,
 \qquad x={\log P\over400d},
 \qquad m=\pi(x).
 \tag{3.1}
\]

Choose any \(m-2\) distinct rational primes
\(\ell_3,\ldots,\ell_m\le x\), and set

\[
 \alpha_1={\lambda\over\ell_3\cdots\ell_m},
 \qquad
 \alpha_2=\gamma^{-1},
 \qquad
 \alpha_i=\ell_i\quad(3\le i\le m),
 \tag{3.2}
\]

with coefficient vector

\[
 (b_1,b_2,b_3,\ldots,b_m)=(n,1,n,\ldots,n).
 \tag{3.3}
\]

Then

\[
 \alpha_1^n\alpha_2\prod_{i=3}^m\alpha_i^n
 =\lambda^n\gamma^{-1}.
 \tag{3.4}
\]

There are four points to check.

1. **The dimension stays \(m\).**  Two auxiliary rational primes are simply
   replaced by the fixed pair information.  There are still exactly \(m\)
   logarithms in (2.1), not \(m+1\) or \(m+2\).

2. **Multiplicative independence holds.**  The set
   \(\{\lambda,\gamma^{-1},\ell_3,\ldots,\ell_m\}\) is independent:
   valuations at the distinct rational primes first kill all exponents of
   the \(\ell_i\), and Section 1 kills the remaining two exponents.  The
   triangular replacement of \(\lambda\) by
   \(\lambda/(\ell_3\cdots\ell_m)\) preserves independence.

3. **All entries are \(\mathfrak p\)-adic units.**  The three algebraic
   numbers \(\lambda,\gamma_b,\gamma_c\) are global units.  Moreover
   \(p>x\), so none of the auxiliary rational primes equals \(p\).

4. **The height product does not increase.**  As in Bilu--Hong--Gun,
   \[
   h(\alpha_1)
    \le h(\lambda)+(m-2)\log x
    \le4d(\log^*d)^3h(\lambda)m\log x.
   \tag{3.5}
   \]
   At their explicit threshold, \(x\ge200(\log4)^2\), while
   \(h(\gamma_b)=\tfrac12\log\gamma_b<\log x\) and
   \(h(\gamma_c)=\tfrac12\log\gamma_c<\log x\).  Thus the product of the
   other \(m-1\) heights is at most \((\log x)^{m-1}\), exactly the upper
   bound in their one-base proof.

Take \(\delta=1\).  The value of \(B\) is \(n\), and (2.2) is the same
quantity as in the proof of their Theorem 1.4.  Every inequality in that
proof now carries over unchanged.  In particular, their equations
corresponding to (4.8)--(4.9) give

\[
 v_{\mathfrak p}(\lambda^n\gamma^{-1}-1)
 \le P\left({160dx\over\log P}\right)^m
 h(\lambda)\log^*n
 =P\,0.4^m h(\lambda)\log^*n.
 \tag{3.6}
\]

Their explicit prime-counting estimate yields

\[
 m\ge{x\over\log x}
 \ge {1\over400d}{\log P\over\log\log P},
 \tag{3.7}
\]

and their check that the first term in (2.2) dominates the second also
depends only on \(m,x,P\), so it is unchanged.  Rounding the exponent exactly
as in their paper proves

\[
 v_{\mathfrak p}(\lambda^n\gamma^{-1}-1)
 \le P\exp\!\left(-{0.002\over d}
 {\log P\over\log\log P}\right)h(\lambda)\log^*n.
 \tag{3.8}
\]

Since \(d=4\) and \(P=p\), this is (0.2).  Root separation selects one of
only four targets, all with the same height comparison, so the estimate is
uniform in the target.

The finitely many support primes below \(p_0\) cause no asymptotic problem.
For each fixed prime, the direct two-logarithm estimate of Yu gives
\(O_p(\log^*n)\).  Summing over this finite set contributes only
\(O(\log^*n)=o(n)\).  The affine Hensel formula alone is not used for this
growth assertion: by itself it identifies the lifting class but does not
bound the quality with which moving integers approximate its fixed p-adic
centre.

## 4. The new cutoff

Let

\[
 a=0.0005={1\over2000},
 \qquad
 F(t)=\exp\!\left(-a{\log t\over\log\log t}\right).
\]

The contribution of the nonexceptional primes up to \(Y\) is at most a fixed
multiple of

\[
 \log^*n\sum_{p\le Y}pF(p)\log p.
 \tag{4.1}
\]

Here is a direct pointwise estimate, avoiding any density assumption on the
actual support.  Fix \(0<\theta<1\).  Split the ambient prime sum at
\(Y^\theta\).  Chebyshev's bound gives

\[
 \sum_{p\le Y}pF(p)\log p
 \ll Y^{2\theta}
 +Y^2\exp\!\left(-(a\theta+o(1))
 {\log Y\over\log\log Y}\right).
 \tag{4.2}
\]

Indeed, the first range is bounded trivially.  On the second range,
\(\log p/\log\log p\ge(\theta+o(1))\log Y/\log\log Y\), while
\(\sum_{p\le Y}p\log p\ll Y^2\).

Now fix \(0<\kappa<a/4=1/8000\) and choose
\(\theta\) with \(4\kappa/a<\theta<1\).  For

\[
 Y=Y_n=\sqrt n\exp\!\left(\kappa{\log n\over\log\log n}\right),
\]

the first term of (4.2), even after multiplication by \(\log n\), is
\(o(n)\).  The logarithm of the second term relative to \(n\) is

\[
 \left(2\kappa-{a\theta\over2}+o(1)\right)
 {\log n\over\log\log n},
\]

which tends to \(-\infty\) on this scale.  Therefore

\[
 \boxed{E_n(\le Y_n)=o(n)
 \quad\text{for every fixed }0<\kappa<1/8000.}
 \tag{4.3}
\]

All quantifiers in (4.3) are pointwise in the Pell index \(n\).

## 5. Comparison with the direct fixed-unit bounds

### 5.1 Yu 1994, 1998, 1999 and 2007

The direct two-logarithm application in the older estimates retains the
moving residue-field factor.  At a split prime its useful scale is

\[
 v_{\mathfrak p}(\lambda^n\gamma^{-1}-1)
 \ll {p\over\log p}\log^*n.
 \tag{5.1}
\]

The 1998 group-variety theorem reorganized the Baker--Wuestholz method.  In
the comparison recorded by Yu, the 1999 sequel replaced the earlier
\(n^{n-1}\)-type dependence by a fixed-base exponential dependence, and the
2007 paper removed the classical \(n!/2^{n-1}\) Kummer-descent cost.  Those
changes matter when the number of logarithms varies, but a direct fixed
two-logarithm specialization still has the moving \(p^f\) factor.  This is
also the historical comparison made in the introduction and Section 9 of
Yu's 2013 paper.  Thus none of these direct applications produces the
subexponential saving in (0.2); that saving comes from letting the number of
auxiliary logarithms grow.

### 5.2 Yu 2013 and the residue subgroup

Yu's 2013 index \(\delta(\mathbf a)\) replaces \(p^f\) by
\(p^f/\delta(\mathbf a)\).  Theorem 1, specialized to two independent fixed
units at a split prime, gives

\[
 v_{\mathfrak p}(\lambda^n\gamma^{-1}-1)
 \ll
 \left({g_p\over(\log p)^3}+1\right)
 \max\{\log^*n,\log p\},
 \tag{5.2}
\]

where \(g_p\) is the size of the subgroup generated by the reductions of a
fixed saturated basis and \(-1\).  At a target hit,
\(\bar\gamma\in\langle\bar\lambda\rangle\).  Saturation changes the
reduction subgroup by at most a fixed index depending only on the two global
units.  Hence

\[
 g_p\ll t_p:=\operatorname {ord}_p(\bar\lambda)\le p-1.
 \tag{5.3}
\]

Equations (5.2)--(5.3), summed with the ambient Chebyshev bound, imply

\[
 E_n(\le Y)\ll {Y^2\over(\log n)^2}+Y\log n
 \quad(Y=n^{1/2+o(1)}),
 \tag{5.4}
\]

and therefore \(o(n)\) for
\(Y=\sqrt n\log n/\Omega(n)\), whenever
\(\Omega(n)\to\infty\) sufficiently slowly.  This is a genuine improvement
over (5.1), but (4.3) is stronger.

### 5.3 Bugeaud--Laurent and Chim

The factor \(g\) in Bugeaud--Laurent's two-logarithm theorem is useful, but
their admissible parameters obey

\[
 \log A_i\ge\max\{h(\alpha_i),(\log p)/D\}.
\]

Thus the apparent \((\log p)^{-4}\) is partly cancelled by two moving height
parameters.  After specializing the fixed Pell units, the scale is roughly

\[
 {g_p\over(\log p)^2}
 \max\{\log^*n,\log p\}^2.
\]

For the worst-case ambient summation, where no extra order information rules
out \(g_p\asymp p\), this is weaker than (5.2).  It is not a pointwise
comparison: when \(g_p\) is very small the Bugeaud--Laurent estimate can be
locally sharper.  That small-order possibility alone does not improve the
uniform cutoff obtained by summing over all moving support primes.

Chim's 2025 Theorem 2.1 improves the coefficient dependence from a square to
an essentially linear \(H\) in the interpolation-determinant method and has
useful numerical constants.  It still requires
\(\log A_i\ge(\log p)/D\), while its \(H\) contains explicit moving
\(\log p\) floors (including the displayed quadratic floor in (2.6) of that
paper).  It is consequently not competitive with Yu 2013, and a fortiori not
with (0.2), for summing over moving large primes.  Neither two-logarithm
result removes the order/subgroup parameter.

## 6. Why the remaining tail is still open

Estimate (4.3) moves the unresolved boundary to

\[
 p>\sqrt n\exp\!\left(\kappa{\log n\over\log\log n}\right),
 \qquad \kappa<1/8000,
 \tag{6.1}
\]

but does not control the excess there with coefficient one.  The obstruction
can be stated without claiming that it occurs in the Pell sequence.

Let \(H=n\log\lambda>0\).  Respect the separate asymptotics
\(\log b_n=H+O(1)\) and \(\log c_n=H+O(1)\) by taking two distinct abstract
prime-log variables \(L_b,L_c\), one for each factor, satisfying

\[
 3L_b=H,\qquad 3L_c=H.
 \tag{6.2}
\]

The two cubes have total logarithmic mass \(H+H=2H\), exactly the Pell scale,
and disjoint support, whereas their combined powerful excess is

\[
 (3-1)L_b+(3-1)L_c={4\over3}H>H.
 \tag{6.3}
\]

Two actual primes chosen in the corresponding exponential intervals have
\(\log q_b=(1/3+o(1))H\) and \(\log q_c=(1/3+o(1))H\).  They lie far above
(6.1) and give the same asymptotic coefficient.  The right side of (0.2) is
then exponentially larger than the exponent \(3\), so (0.2) does not exclude
this profile.  The finite local model from the earlier audit can assign the
two primes to different targets and make both isolated first hits with order
greater than \(2n\); there is no earlier-index or fixed-gap repetition for a
carrier theorem to detect.  This only demonstrates compatibility with the
audited local data: it does not realize the fixed global Pell units.

More generally, a balanced pair of abstract \(k\)-th-power carriers with
\(kL_b=kL_c=H\) has combined excess

\[
 2\left(1-{1\over k}\right)H,
 \tag{6.4}
\]

which approaches the full two-height mass.  Equations (6.2)--(6.4) prove
only that the audited estimates do not logically imply (1.3).  By contrast,
putting the whole \(2H\) mass into one cube would violate the separate
\(b_n\)/\(c_n\) height ledger and is not used here.  The global units are fixed
in the genuine Pell problem, while the two finite local carriers are allowed
to vary with \(n\); the balanced model is therefore not an actual Pell
counterexample.

Order stratification does not repair this loss with the presently available
inputs.  If \(t_p>2n\), the current occurrence may be its first target hit,
which is precisely the isolated case above.  If \(t_p\le2n\), grouping by
the order merely says that primes of order \(t\) divide fixed norms such as
\(N(\lambda^t-1)\); summing those norm budgets for all \(t\le2n\) costs
\(O(n^2)\).  The affine Hensel class has density \(p^{-j}\) at additional
depth \(j\) for a fixed prime, but gives no pointwise bound for the first
selected moving prime.  Hence a new global moving-prime depth theorem, or an
equivalent truncated-counting theorem with the critical coefficient, is
still required.

## 7. Formalization boundary

The companion Lean module proves only scalar consequences:

* the cutoff substitution behind (4.3), after the analytic prime-sum input is
  supplied as a hypothesis;
* the exact \(4/3\) combined excess of a balanced pair of isolated cube
  carriers, one in each factor;
* the general \(2(1-1/k)\) balanced-pair identity; and
* the critical comparison between one source-height unit and the two-cube
  excess.

It does not formalize or assume Bilu--Hong--Gun's theorem, Yu's theorem,
prime splitting, Chebyshev estimates, algebraic heights, local fields, or the
missing high-prime tail bound.

## References

* Y. Bilu, H. Hong and S. Gun, *Uniform explicit Stewart's theorem on prime
  factors of linear recurrences*, Acta Arith. 206 (2022), 223--243,
  [doi:10.4064/aa211116-13-11](https://doi.org/10.4064/aa211116-13-11),
  [author manuscript](https://arxiv.org/abs/2108.09857).
* K. Yu, *Linear forms in p-adic logarithms III*, Compositio Math. 91
  (1994), 241--276,
  [Numdam](https://www.numdam.org/article/CM_1994__91_3_241_0.pdf).
* K. Yu, *p-adic logarithmic forms and group varieties I*, J. Reine Angew.
  Math. 502 (1998), 29--92,
  [publisher record](https://doi.org/10.1515/crll.1998.084).
* K. Yu, *p-adic logarithmic forms and group varieties II*, Acta Arith. 89
  (1999), 337--378,
  [EuDML](https://eudml.org/doc/207305).
* K. Yu, *p-adic logarithmic forms and group varieties III*, Forum Math. 19
  (2007), 187--280,
  [publisher record](https://doi.org/10.1515/FORUM.2007.009).
* K. Yu, *p-adic logarithmic forms and a problem of Erdos*, Acta Math. 211
  (2013), 315--382,
  [author archive](https://archive.ymsc.tsinghua.edu.cn/pacm_download/117/6782-11511_2013_Article_106.pdf).
* Y. Bugeaud and M. Laurent, *Minoration effective de la distance p-adique
  entre puissances de nombres algebriques*, J. Number Theory 61 (1996),
  311--342,
  [author manuscript](https://irma.math.unistra.fr/~bugeaud/travaux/logpadicdef.ps).
* K. C. Chim, *Lower bounds for linear forms in two p-adic logarithms*,
  J. Number Theory 266
  (2025), 295--349,
  [author manuscript](https://tugraz.elsevierpure.com/ws/portalfiles/portal/92346766/1-s2.0-S0022314X24001793-main.pdf).
