# Squarefull and primitive-divisor bounds in the Pell radical pair

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad b_n=s_n^2-3,
 \qquad c_n=s_n^2-2,
 \qquad X_n=b_nc_n,
\]

and put \(\lambda=97+56\sqrt3\).  The Pell route to abc needs, for every
\(\eta>0\),

\[
 E_n:=\sum_{p\mid X_n}(v_p(X_n)-1)\log p
 \le (1+\eta)n\log\lambda+O_\eta(1).             \tag{0.1}
\]

The full logarithmic size is \(2n\log\lambda+O(1)\), so (0.1) permits one
full source-height unit of repeated prime mass.  It does not require
\(E_n=o(n)\).

This note audits the recurrence, square-free-factor, primitive-divisor,
cyclotomic, perfect-power, fixed-\(S\), and Subspace-Theorem inputs.  The two
Pell values combine exactly into a simple nondegenerate order-five recurrence
with a unique dominant root.  Stewart's pointwise theorem therefore applies
directly to their joint radical, but gives only

\[
 \log\operatorname {rad}(X_n)
 \gg {\log n\,\log_2n\over\log_3n}=o(n),          \tag{0.2}
\]

with no positive source-height coefficient.

There is one useful homogeneous carrier.  For \(n=m+k\),

\[
 b_n-b_m=c_n-c_m=3r_k r_{2m+k}.                   \tag{0.3}
\]

Thus support repeated on the same shifted orbit is carried by ordinary
Pell--Lucas terms at the difference and sum indices.  Bilu--Hanrot--Voutier
can be used on those homogeneous carrier terms.  It cannot be used on
\(b_n\), \(c_n\), or their four shifted toric factors, and (0.3) controls only
shared depth.  It is silent about an isolated first-hit square, cube, or higher
power.

An actual recurrence

\[
 M_n=2(2^n-1)^3                                      \tag{0.4}
\]

shows that the package “nondegenerate dominant root + eventual primitive
support + no perfect powers at positive indices + negligible fixed support”
does not imply the
coefficient in (0.1): \(M_n\) has all those properties, while its powerful
excess is at least two thirds of its full logarithmic height.  No proof of abc
is obtained.

## 1. Exact joint recurrence

The toric formulas are

\[
 b_n={\lambda^n+\lambda^{-n}-10\over4},
 \qquad
 c_n={\lambda^n+\lambda^{-n}-6\over4}.             \tag{1.1}
\]

Writing \(x=\lambda^n\) and multiplying gives

\[
 16X_n=x^2+x^{-2}-16(x+x^{-1})+62.                \tag{1.2}
\]

The five roots

\[
 \lambda^2,\quad\lambda,\quad1,\quad
 \lambda^{-1},\quad\lambda^{-2}                  \tag{1.3}
\]

are distinct, and no quotient of two of them is a root of unity.  All five
coefficients in (1.2) are nonzero.  Hence this is the minimal simple
nondegenerate recurrence, with characteristic polynomial

\[
\begin{aligned}
 &(T-1)(T^2-194T+1)(T^2-37634T+1)\\
 &\quad=T^5-37829T^4+7338826T^3-7338826T^2
             +37829T-1.                            \tag{1.4}
\end{aligned}
\]

Consequently

\[
\begin{aligned}
 X_{n+5}={}&37829X_{n+4}-7338826X_{n+3}
             +7338826X_{n+2}\\
           &-37829X_{n+1}+X_n.                    \tag{1.5}
\end{aligned}
\]

The unique dominant root is \(\lambda^2\), and

\[
 \log X_n=2n\log\lambda+O(1).                     \tag{1.6}
\]

Since \(c_n=b_n+1\),

\[
 \gcd(b_n,c_n)=1,
 \qquad
 \operatorname {rad}(X_n)
   =\operatorname {rad}(b_n)\operatorname {rad}(c_n). \tag{1.7}
\]

Combining the pair into \(X_n\) therefore loses no radical mass.

## 2. The coefficient that is actually needed

Unique factorization gives

\[
 \log X_n=\log\operatorname {rad}(X_n)+E_n.        \tag{2.1}
\]

Thus (0.1) is equivalent to

\[
 \log\operatorname {rad}(X_n)
 \ge(1-\eta)n\log\lambda-O_\eta(1).               \tag{2.2}
\]

The right side is one half of the leading logarithmic size of \(X_n\).  A
result of the form \(E_n=o(n)\) would retain almost all two source-height
units and is much stronger than necessary.  On the other hand, any radical
lower bound whose logarithm is \(o(n)\) has coefficient zero and is still far
too weak.

## 3. Stewart's theorem: exact hypotheses and exact scale

Stewart's 2008 Theorem 1 concerns an integer \(u(n)\) satisfying

\[
 0<|u(n)-f(n)\alpha^n|<|\alpha|^{\delta n}
 \quad(0<\delta<1),                                \tag{3.1}
\]

where \(\alpha>1\) is a real algebraic number and \(f\) is a nonzero
algebraic-coefficient polynomial.  Its conclusion is pointwise and effective:
there are effective \(C_1,C_2,C_3>0\) such that, for \(n>C_3\),

\[
 P(u(n))>C_1{\log n\,\log_2n\over\log_3n},
 \qquad
 \operatorname {rad}(u(n))
   >n^{C_2\log_2n/\log_3n}.                        \tag{3.2}
\]

For (1.2), take \(\alpha=\lambda^2\) and \(f=1/16\).  The error from the
dominant term is \(O(\lambda^n)=O(\alpha^{n/2})\), so (3.1) holds, for example,
with \(\delta=3/4\) for every sufficiently large \(n\).  The difference is
nonzero.  Stewart's theorem therefore applies directly to the joint integer
sequence \(X_n\), for every sufficiently large index, and yields (0.2).

The logarithm in (0.2) is \(o(n)\).  Applying the theorem separately to
\(b_n\) and \(c_n\) does not manufacture a linear coefficient.  The 2025 work
of Bérczes--Hajdu--Ostafe--Shparlinski uses this same Stewart estimate as its
square-free-factor input.  A 2026 preprint on specialized parametric
recurrences gives the same \(\exp(C\log n\log_2n/\log_3n)\) scale under its own
hypotheses; it is only corroborating evidence here and is not used.

## 4. Primitive divisors and the homogeneous carrier

### 4.1 Why BHV does not apply to the shifted values

Bilu--Hanrot--Voutier prove that every Lucas or Lehmer number of index greater
than \(30\) has a primitive divisor.  The relevant terms are homogeneous
differences of powers of a Lucas or Lehmer pair, and their proof isolates a
homogeneous cyclotomic component indexed by the divisors of \(n\).

The sequences \(b_n\) and \(c_n\) instead have the three minimal roots
\(\lambda,1,\lambda^{-1}\), all with nonzero coefficients.  They are not
binary Lucas or Lehmer sequences and are not divisibility sequences.  The
smallest explicit witnesses are

\[
 b_1=46\nmid9406=b_2,
 \qquad
 c_1=47\nmid9407=c_2.                              \tag{4.1}
\]

At the toric level their factors are

\[
 \lambda^n-\gamma_b^{\pm1},
 \qquad
 \lambda^n-\gamma_c^{\pm1},                       \tag{4.2}
\]

where

\[
 \gamma_b=5+2\sqrt6,
 \qquad
 \gamma_c=3+2\sqrt2.                              \tag{4.3}
\]

The target in (4.2) is fixed; it is not the \(n\)-th power of a second fixed
base.  Consequently

\[
 \prod_{d\mid n}\Phi_d(\alpha,\beta)
   =\alpha^n-\beta^n                               \tag{4.4}
\]

has no shifted analogue obtained by merely replacing \(\beta^n\) by
\(\gamma\).  BHV cannot be quoted for (4.2).

### 4.2 A genuine carrier for support repeated on one orbit

Pell addition gives

\[
\begin{aligned}
 s_{m+k}&=s_ms_k+3r_mr_k,\\
 r_{m+k}&=s_mr_k+r_ms_k.                           \tag{4.5}
\end{aligned}
\]

Using \(s_j^2-3r_j^2=1\) in (4.5) gives the exact identity

\[
 s_{m+k}^2-s_m^2=3r_k r_{2m+k}.                   \tag{4.6}
\]

Both constants in \(b_j\) and \(c_j\) cancel, proving (0.3).  In particular,

\[
\begin{aligned}
 \gcd(b_m,b_n)&\mid 3r_{n-m}r_{n+m},\\
 \gcd(c_m,c_n)&\mid 3r_{n-m}r_{n+m}
 \qquad(0\le m<n).                                \tag{4.7}
\end{aligned}
\]

This is a positive reduction: after removing its fixed factor, \(r_j/4\) is
the normalized homogeneous Pell--Lucas sequence, so rank-of-apparition and BHV
technology is legitimate on the carrier.  Equivalently, away from the fixed
bad primes, if the same shifted sequence vanishes at indices \(m<n\), then
the order of \(\lambda=(7+4\sqrt3)^2\) modulo a chosen prime above \(p\)
divides \(n-m\) or \(n+m\).

The reduction stops short of (0.1) for two separate reasons.

1. Equation (4.7) bounds shared depth only.  Locally it controls at most
   \(\min\{v_p(b_m),v_p(b_n)\}\), or the analogous minimum for \(c\); it does
   not bound the valuation at \(n\) above the earlier depth.
2. A first-hit prime at index \(n\) has no earlier \(m\) and is completely
   absent from (4.7).  A first-hit congruence may already hold modulo \(p^3\)
   or a higher power.  Primitive-divisor existence records the first copy of
   \(p\), not the additional copies measured by \(E_n\).

Moreover the sum-index carrier \(r_{n+m}\) can itself have exponential size.
Multiplying (4.7) over a window therefore gives no coefficient-one estimate
without a new valuation or truncated-counting theorem.

## 5. Combining all four targets

The four factors do combine into one square-free target polynomial

\[
 F(T)=(T^2-10T+1)(T^2-6T+1),                      \tag{5.1}
\]

with

\[
 16X_n=\lambda^{-2n}F(\lambda^n).                 \tag{5.2}
\]

For odd support primes the two quadratic target sets are disjoint, because
their difference is \(-4T\) and every target is a unit.  Away from the fixed
discriminant primes, all four roots are simple.  Hence, at each chosen good
prime ideal above \(p\), a prime power dividing \(X_n\) selects exactly one
of the four congruences in (4.2).  Different prime ideals above the same
rational prime may select Galois-conjugate targets.

This is the correct four-target sieve object, but simplicity of \(F\) does not
make \(F(\lambda^n)\) square-free.  A simple root modulo \(p\) has a unique
Hensel lift modulo every \(p^e\); uniqueness does not prevent the particular
orbit point \(\lambda^n\) from hitting that lift.  Also, because the four roots
are mutually exclusive at a support prime, their product supplies no second
independent vanishing condition.

This last point blocks a direct use of the Bugeaud--Corvaja--Zannier gcd
theorem.  Their theorem says that, for fixed multiplicatively independent
integers \(a,b>1\),

\[
 \log\gcd(a^n-1,b^n-1)\le\varepsilon n+O_\varepsilon(1). \tag{5.3}
\]

It gains strength from two simultaneous independent vanishings.  A prime of
\(X_n\) satisfies only one congruence in (4.2).  Applying gcd estimates across
two indices controls old common support, as in (4.7), but leaves an isolated
high first hit untouched.

For a fixed positive window shift \(j\), the polynomials \(F(T)\) and
\(F(\lambda^jT)\) have nonzero resultant: a common root would give a global
multiplicative relation between \(\lambda\) and two fixed targets.  This
recovers a fixed-gap gcd bound.  Letting the window grow with \(n\) makes the
resultants and all constants move; a fixed-polynomial Subspace-Theorem result
cannot be used uniformly in that way.  Arithmetic-dynamics primitive-divisor
theorems for degree-at-least-two iteration likewise do not apply to the
degree-one translation orbit \(T\mapsto\lambda T\).

## 6. Perfect powers, fixed support, and largest primes

### 6.1 Perfect powers

Bugeaud--Kaneko prove finiteness of perfect powers under an irreducible
characteristic-polynomial hypothesis together with a dominant root.  The
minimal characteristic polynomials of \(b_n,c_n\), and \(X_n\) are all
reducible, so their theorem does not apply.  The hypothesis is substantive:
their paper points to squares of Fibonacci numbers as a reducible order-three
obstruction.

Even an effective proof that no sufficiently large \(b_n,c_n\), or \(X_n\)
is a perfect power would not control (0.1).  An integer \(p^e q\), with
\(e\gg1\) and \(q\) occurring once, is not a perfect power although almost all
of its logarithmic size may be repeated-prime mass.  Exact-power finiteness
tests a common divisor of the entire exponent vector; \(E_n\) is a weighted
\(L^1\) statistic of that vector.

### 6.2 Fixed \(S\)-parts

Bugeaud--Evertse prove, under their nondegeneracy conditions, that after a
finite prime set \(S\) is fixed, its \(S\)-part is at most \(|u_n|^\varepsilon\)
for every sufficiently large \(n\); the strongest version is ineffective, and
the threshold depends on \(S\).  This excludes a linear contribution carried
forever by one fixed finite set.  It is invalid to substitute the moving set

\[
 S_n=\{p:p\mid X_n\}.                              \tag{6.1}
\]

The missing mass is allowed to migrate through new primes.

### 6.3 Largest-prime and primitive-prime lower bounds

A lower bound for the largest prime factor contributes only one copy of one
prime to the radical.  The largest-prime conclusions in Stewart and in the
homogeneous Bilu--Hong--Gun theorem have logarithm \(o(n)\) at index \(n\).
BHV supplies at least one primitive support prime for a homogeneous
Lucas--Lehmer term, again with no linear logarithmic coefficient and no upper
bound on its valuation in a shifted term.  None of these statements estimates
the sum of all additional copies in (0.1).

Ribenboim--Walsh is useful as a boundary marker: small powerful parts of broad
binary recurrence families are proved there assuming abc.  Invoking that
conclusion here would be circular, and the present shifted order-three pair is
not their Lucas input in any event.

## 7. An actual recurrence proving logical insufficiency

Consider

\[
 M_n=2(2^n-1)^3
     =2\cdot8^n-6\cdot4^n+6\cdot2^n-2.             \tag{7.1}
\]

This is a simple nondegenerate integer recurrence with the distinct roots
\(8,4,2,1\), a unique dominant root, and characteristic polynomial

\[
 (T-8)(T-4)(T-2)(T-1)
 =T^4-15T^3+70T^2-120T+64.                         \tag{7.2}
\]

Thus

\[
 M_{n+4}=15M_{n+3}-70M_{n+2}+120M_{n+1}-64M_n.    \tag{7.3}
\]

For every \(n>6\), Zsigmondy's theorem supplies a prime divisor of
\(2^n-1\) which divides no earlier positive-index term \(2^m-1\).  It is
therefore a primitive
support prime of \(M_n\).  Nevertheless, for every \(n\ge1\), \(M_n\) is
not a perfect power of exponent at least two, because

\[
 v_2(M_n)=1 \qquad (n\ge1).                       \tag{7.4}
\]

Every fixed odd prime has valuation \(O(\log n)\) along \(2^n-1\) by the
ordinary lifting formula, so every fixed finite support set contributes
\(o(n)\).  Yet

\[
 \operatorname {rad}(M_n)
   =2\operatorname {rad}(2^n-1)
   \le2(2^n-1) \qquad (n\ge1),                    \tag{7.5}
\]

and hence

\[
\begin{aligned}
 \log M_n&=3n\log2+O(1),\\
 \log\operatorname {rad}(M_n)&\le n\log2+O(1),\\
 E(M_n)&\ge2n\log2-O(1).                          \tag{7.6}
\end{aligned}
\]

If one normalizes one source-height unit as
\(H_n=\tfrac12\log M_n\), then

\[
 \liminf_{n\to\infty}{E(M_n)\over H_n}\ge{4\over3}>1. \tag{7.7}
\]

This is an actual linear recurrence, not merely a freely assigned sequence of
integers.  It proves rigorously that dominant-root growth, nondegeneracy,
eventual primitive support, absence of perfect powers at every positive
index, and negligible fixed support do not logically force the
coefficient-one powerful-excess bound.
It is not a model of the Pell recurrence and is not an abc counterexample.

## 8. Cross-checked local input and the remaining tail

The independent large-prime audit proves the shifted Bilu--Hong--Gun local
estimate by keeping the original logarithm dimension \(m=\pi(x)\): one target
occupies one slot and only \(m-2\) auxiliary rational primes are used.  The
coefficient vector is \((n,1,n,\ldots,n)\); global multiplicative independence
is sufficient, \(\delta=1\) is admissible, and neither independence modulo
\(p\) nor nonzero coefficients in every slot is required.  Taking the maximum
over the four fixed targets makes the constants uniform.  In the degree-four
split field it gives

\[
 v_p(X_n)\le p\exp\!\left(-0.0005{\log p\over\log\log p}\right)
       h(\lambda)\log^*n                            \tag{8.1}
\]

above an effective threshold, and therefore

\[
 E_n(p\le Y_n)=o(n),\qquad
 Y_n=\sqrt n\exp\!\left(\kappa{\log n\over\log\log n}\right),
 \quad0<\kappa<{1\over8000}.                       \tag{8.2}
\]

The proof and scalar cutoff ledger belong to
`FREY_PELL_LARGE_PRIME_PADIC_AUDIT.md` and
`IUTThreeClosures/FreyPellLargePrimePadicAudit.lean`; they are not duplicated
here.  The order-sensitive Yu--Bugeaud--Laurent estimate can be stronger when
the residual order \(t_p\) is unusually small, while (8.1) is asymptotically
stronger in the worst case \(t_p\asymp p\).  Taking their minimum still leaves
the same qualitative gap.

After (8.2), the unresolved statement is

\[
 \sum_{\substack{p\mid X_n\\p>Y_n}}
       (v_p(X_n)-1)\log p
 \le(1+\eta)n\log\lambda+O_\eta(1).               \tag{8.3}
\]

The homogeneous carrier (0.3) helps only after a prime has occurred on the
same shifted orbit.  The four-target polynomial (5.1) shows that a support
prime chooses one simple target, but does not prohibit a deep first hit.
Current primitive-divisor, cyclotomic, largest-prime, perfect-power, fixed-S,
gcd, and sieve theorems do not prove (8.3) pointwise and unconditionally.

## 9. Formalization boundary

`IUTThreeClosures/FreyPellSquarefullPrimitiveDivisorAudit.lean` proves only:

* the exact order-five characteristic polynomial and recurrence;
* the two nondivisibility witnesses in (4.1);
* Pell addition and the homogeneous difference carrier (0.3);
* the order-four recurrence and characteristic polynomial of the actual
  output model (7.1); and
* the exact scalar coefficient obstruction when certified radical mass is
  subcritical.

Lean does not formalize Stewart's theorem, BHV, Zsigmondy, prime splitting,
radicals, logarithmic asymptotics, or the missing tail estimate (8.3).  None is
introduced as an axiom.

## References

* C. L. Stewart, *On the greatest square-free factor of terms of a linear
  recurrence sequence*, in **Diophantine Equations**, Tata Institute Studies
  in Mathematics 20 (2008), 257--264,
  [author PDF](https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/greatest_square_free_factor_0.pdf).
* C. L. Stewart, *On divisors of terms of linear recurrence sequences*,
  J. Reine Angew. Math. 333 (1982), 12--31,
  [author PDF](https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/10.1515_crll.1982.333.12.pdf).
* Y. Bilu, G. Hanrot and P. M. Voutier, *Existence of primitive divisors of
  Lucas and Lehmer numbers*, J. Reine Angew. Math. 539 (2001), 75--122,
  [doi](https://doi.org/10.1515/crll.2001.080).
* Y. Bilu, H. Hong and S. Gun, *Uniform explicit Stewart theorem on prime
  factors of linear recurrences*, Acta Arith. 206 (2022), 223--243,
  [doi](https://doi.org/10.4064/aa211116-13-11),
  [full text](https://arxiv.org/abs/2108.09857).
* Y. Bugeaud, P. Corvaja and U. Zannier, *An upper bound for the G.C.D. of
  \(a^n-1\) and \(b^n-1\)*, Math. Z. 243 (2003), 79--84,
  [doi](https://doi.org/10.1007/s00209-002-0449-z).
* Y. Bugeaud and J.-H. Evertse, *S-parts of terms of integer linear recurrence
  sequences*, Mathematika 63 (2017), 840--851,
  [doi](https://doi.org/10.1112/S0025579317000298),
  [preprint](https://arxiv.org/abs/1611.00485).
* Y. Bugeaud and H. Kaneko, *On perfect powers in linear recurrence sequences
  of integers*, Kyushu J. Math. 73 (2019), 221--227,
  [primary PDF](https://www.jstage.jst.go.jp/article/kyushujm/73/2/73_221/_pdf/-char/en).
* P. Ribenboim and P. G. Walsh, *The ABC conjecture and the powerful part of
  terms in binary recurring sequences*, J. Number Theory 74 (1999), 134--147,
  [doi](https://doi.org/10.1006/jnth.1998.2315).
* A. Bérczes, L. Hajdu, A. Ostafe and I. E. Shparlinski, *Multiplicative
  dependence in linear recurrence sequences*, Canad. Math. Bull. 68 (2025),
  1278--1288, [doi](https://doi.org/10.4153/S0008439525000475).
* O. Järviniemi and J. Teräväinen, *Composite values of shifted exponentials*,
  Adv. Math. 429 (2023), 109187,
  [doi](https://doi.org/10.1016/j.aim.2023.109187),
  [preprint](https://arxiv.org/abs/2010.01789).
* N. Darsana and S. S. Rout, *Prime ideal divisors of parametric recurrence
  sequences*, [arXiv:2602.06667](https://arxiv.org/abs/2602.06667) (2026).
