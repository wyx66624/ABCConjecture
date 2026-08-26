# The squarefree part of the Pell companion as a fundamental unit

## Abstract

Let

\[
 s_n^2-3r_n^2=1,
 \qquad c_n=s_n^2-2=3r_n^2-1,
 \qquad n\geq 1,
\]

be the fixed Pell orbit used in the radical reduction, and write

\[
 c_n=A_ny_n^2
\]

with \(A_n>0\) squarefree.  There is an exact norm-one identity

\[
 (c_n+1)^2-A_n(y_ns_n)^2=1,                       \tag{0.1}
\]

or, equivalently,

\[
 9r_n^4-A_n(y_ns_n)^2=1.                          \tag{0.2}
\]

The theorem of Bennett and Walsh on
\(b^2X^4-dY^2=1\), with \(b=3\) and \(d=A_n\), really does imply
that the unit in (0.1) is the fundamental positive Pell solution.  A short
Chebyshev calculation modulo \(3\) is the last step.  In fact
\(A_n\equiv23\pmod {24}\), so the quadratic order is already maximal and a
negative-norm unit is locally impossible.  Thus

\[
 \varepsilon_{A_n}
  =(c_n+1)+y_ns_n\sqrt{A_n}                        \tag{0.3}
\]

is the fundamental unit of \(\mathbf Q(\sqrt{A_n})\), not merely the
fundamental solution inside a nonmaximal order.  It also follows that the
parameters \(A_n\) are pairwise distinct.

This is a genuine structural theorem, but it does not supply the radical
coefficient required by the abc reduction.  If \(h_n\) is the ordinary class
number of \(\mathbf Q(\sqrt{A_n})\), \(\Delta_n=4A_n\), and
\(\chi_n=(\Delta_n/\cdot)\), then

\[
 h_n\log\varepsilon_{A_n}
   =\sqrt{A_n}\,L(1,\chi_n),                       \tag{0.4}
\]

and the special local data \(\chi_n(2)=0\), \(\chi_n(3)=-1\) allow the
explicit unconditional bound

\[
 L(1,\chi_n)\le {\log(4A_n)+6\over8}.              \tag{0.5}
\]

Genus theory gives

\[
 2^{\omega(A_n)-1}\mid h_n.                        \tag{0.6}
\]

Consequently

\[
 \log\varepsilon_{A_n}
 \le {\sqrt{A_n}\bigl(\log(4A_n)+6\bigr)
          \over 2^{\omega(A_n)+2}}.                \tag{0.7}
\]

There is a distinction between a fully explicit all-conductor constant and
the best asymptotic constant supplied by the cited character-sum method.
Granville--Soundararajan's quadratic-character bound, with its small-prime
factor retained, gives

\[
 L(1,\chi_n)\le
 \left({c_2\over16}+o(1)\right)\log(4A_n),
 \qquad c_2=2-{2\over\sqrt e}.                     \tag{0.8}
\]

Dropping the class-number factor and inverting this estimate gives, with
\(R_n=\log\varepsilon_{A_n}\),

\[
 A_n\ge
 \left({64\over c_2^2}-o(1)\right)
 {R_n^2\over(\log R_n)^2},
 \qquad {64\over c_2^2}=103.347\ldots .           \tag{0.9}
\]

Here \(R_n=H_n+O(1)\), where \(H_n=n\log(97+56\sqrt3)\).  Hence this route
proves only

\[
 \log\operatorname{rad}(c_n)
 \ge 2\log H_n-2\log\log H_n
       +\log(64/c_2^2)+o(1)=o(H_n),                \tag{0.10}
\]

far below the desired coefficient one.  The congruence and genus information
improve the explicit constant and give useful rigidity, but do not change this
scale.  No abc, GRH, or unproved distribution assertion is used below.

## 1. The exact quartic Pell identity

The two neighboring identities are

\[
 c_n+1=s_n^2-1=3r_n^2,
 \qquad c_n+2=s_n^2.                               \tag{1.1}
\]

Since \(c_n=A_ny_n^2\), direct expansion gives

\[
\begin{aligned}
 (c_n+1)^2-A_n(y_ns_n)^2
  &=(c_n+1)^2-c_ns_n^2\\
  &=(c_n+1)^2-c_n(c_n+2)\\
  &=1.
\end{aligned}                                      \tag{1.2}
\]

Substituting the first identity in (1.1) yields (0.2).  Notice the placement
of the fourth power: in the notation of Bennett--Walsh it is

\[
 b=3,\qquad X=r_n,\qquad d=A_n,\qquad Y=y_ns_n.
                                                               \tag{1.3}
\]

Both \(3\) and \(A_n\) are squarefree and greater than one.  The latter also
follows from the congruence calculation in the next section.

The size of the unit is equally exact.  Put

\[
 \eta_n=(c_n+1)+y_ns_n\sqrt{A_n}
       =(c_n+1)+\sqrt{c_n(c_n+2)}.                 \tag{1.4}
\]

For \(c_n>0\),

\[
 c_n<\sqrt{c_n(c_n+2)}<c_n+1,
\]

and therefore

\[
 2c_n+1<\eta_n<2c_n+2,
 \qquad \log\eta_n=\log c_n+\log2+O(c_n^{-1}).   \tag{1.5}
\]

The established Pell height formula

\[
 \log c_n=H_n+O(1),
 \qquad H_n=n\log(97+56\sqrt3),                   \tag{1.6}
\]

then gives \(\log\eta_n=H_n+O(1)\).

## 2. Congruences of the squarefree parameter

The doubled Pell coordinate \(s_n\) is odd and is not divisible by \(3\).
Thus \(s_n^2\equiv1\pmod {24}\), and

\[
 c_n=s_n^2-2\equiv23\pmod {24}.                   \tag{2.1}
\]

The equality \(c_n=A_ny_n^2\) shows that \(y_n\) is coprime to \(6\).
Every square coprime to \(6\) is \(1\) modulo \(24\), whence

\[
 A_n\equiv23\pmod {24}.                           \tag{2.2}
\]

In particular, \(A_n>1\), \(A_n\equiv3\pmod4\), and the field
discriminant is

\[
 \Delta_n=4A_n.                                   \tag{2.3}
\]

There is also a prime-by-prime restriction.  If an odd prime \(p\mid c_n\),
then \(p\ne3\) and

\[
 s_n^2\equiv2\pmod p,
 \qquad 3r_n^2\equiv1\pmod p.                    \tag{2.4}
\]

The second congruence also writes \(3\equiv(3r_n)^2\pmod p\).  Hence

\[
 \left({2\over p}\right)=
 \left({3\over p}\right)=1.                      \tag{2.5}
\]

The standard supplementary laws for the Legendre symbol now give

\[
 p\equiv1\ \hbox{or}\ 23\pmod {24}.              \tag{2.6}
\]

This holds for every prime divisor of \(c_n\), not just for the primes which
occur to odd exponent in \(A_n\).

Because the product in (2.2) is \(-1\) modulo \(24\), at least one prime
\(q\mid A_n\) satisfies \(q\equiv23\pmod {24}\), hence \(q\equiv3\pmod4\).
The equation

\[
 x^2-A_nz^2=-1                                    \tag{2.7}
\]

would reduce to \(x^2\equiv-1\pmod q\), which is impossible.  Therefore
\(\mathbf Q(\sqrt{A_n})\) has no unit of norm \(-1\).

## 3. Bennett--Walsh and the fundamental solution

Let

\[
 \varepsilon=T+U\sqrt{A_n}>1                     \tag{3.1}
\]

be the fundamental positive solution of
\(X^2-A_nY^2=1\), and define

\[
 T_j+U_j\sqrt{A_n}=\varepsilon^j,
 \qquad j\ge1.                                    \tag{3.2}
\]

There is some \(k\ge1\) for which \(\eta_n=\varepsilon^k\), so

\[
 T_k=c_n+1=3r_n^2.                                \tag{3.3}
\]

Bennett and Walsh, Theorem 1.2, state the following with exact quantifiers.
If \(b,d>1\) are squarefree, then there is at most one index \(j\) for which
\(T_j=bx^2\); if such an index exists, it equals the divisibility index

\[
 \alpha(b)=\min\{j\ge1:b\mid T_j\}.               \tag{3.4}
\]

Apply this with (1.3).  It gives

\[
 k=\alpha(3).                                     \tag{3.5}
\]

It remains to compute this divisibility index.  The first coordinates in
(3.2) satisfy

\[
 T_j=\mathcal T_j(T),                              \tag{3.6}
\]

where \(\mathcal T_j\) is the first Chebyshev polynomial.  If
\(T\equiv1\pmod3\), then \(T_j\equiv1\pmod3\) for every \(j\).  If
\(T\equiv-1\pmod3\), then
\(T_j\equiv(-1)^j\pmod3\).  Since (3.3) is divisible by \(3\), neither
case is possible.  Thus

\[
 3\mid T,
 \qquad \alpha(3)=1,
 \qquad k=1.                                      \tag{3.7}
\]

This also follows directly from Bennett--Walsh, Corollary 1.3, whose list has
no exception for \(b=3\).  The argument above records why the main theorem
already suffices.

We have proved

\[
 \eta_n=\varepsilon.                              \tag{3.8}
\]

There is no order-versus-field ambiguity here.  By (2.2),
\(A_n\equiv3\pmod4\), so

\[
 \mathcal O_{\mathbf Q(\sqrt{A_n})}
   =\mathbf Z[\sqrt{A_n}].                         \tag{3.9}
\]

Section 2 excluded norm \(-1\).  Therefore (3.8) is the generator of the
full field unit group modulo sign.  If “fundamental Pell solution” means the
least norm-one integer solution, Bennett--Walsh gives it directly; if
“fundamental unit” means the Dirichlet generator of the maximal order, the
congruence argument upgrades the conclusion to that stronger statement.

## 4. Injectivity of \(A_n\)

Suppose \(A_m=A_n=A\).  Equations (0.2) at indices \(m\) and \(n\) give two
positive solutions of

\[
 9X^4-AY^2=1.                                     \tag{4.1}
\]

Bennett--Walsh, Theorem 1.2, says that (4.1) has at most one positive
integer solution.  Hence \(r_m=r_n\).  The positive Pell coordinates \(r_n\)
are strictly increasing for \(n\ge1\), so \(m=n\).  Thus

\[
 m\ne n\quad\Longrightarrow\quad A_m\ne A_n.      \tag{4.2}
\]

Equivalently, (3.8) says that a repeated \(A\) would give the same
fundamental unit and hence the same first coordinate \(c+1\).

One consequence, useful only at a counting level, is

\[
 \#\{n\ge1:A_n\le X\}\le {X\over24}+O(1),         \tag{4.3}
\]

because all \(A_n\) are distinct and lie in the class \(23\pmod {24}\).
This is not a pointwise lower bound for \(A_n\): an injective sequence need
not list its values in increasing numerical order.
It does imply \(A_n\to\infty\), so all conductor asymptotics below apply along
the full sequence, not merely along a subsequence.

## 5. Regulator and class number

Let \(K_n=\mathbf Q(\sqrt{A_n})\), let \(h_n\) be its ordinary class number,
and put

\[
 R_n=\log\varepsilon_{A_n}.                        \tag{5.1}
\]

The real quadratic analytic class-number formula is

\[
 h_nR_n={\sqrt{\Delta_n}\over2}L(1,\chi_n),       \tag{5.2}
\]

where \(\chi_n=(\Delta_n/\cdot)\).  Since \(\Delta_n=4A_n\), this becomes
the exact identity

\[
 h_nR_n=\sqrt{A_n}\,L(1,\chi_n).                  \tag{5.3}
\]

The character \(\chi_n\) is primitive and even.  Moreover,

\[
 \chi_n(2)=0,
 \qquad
 \chi_n(3)=\left({4A_n\over3}\right)=-1,          \tag{5.4}
\]

because \(A_n\equiv2\pmod3\).  Louboutin's unconditional explicit bound
for precisely this local pattern is

\[
 |L(1,\chi)|\le {\log f_\chi+6\over8}              \tag{5.5}
\]

for every primitive even character of even conductor satisfying
\(\chi(3)=-1\).  There is no GRH hypothesis and no lower threshold on the
conductor in this statement.  Applying (5.5) to (5.3) gives

\[
 R_n\le {\sqrt{A_n}\bigl(\log(4A_n)+6\bigr)
              \over8h_n}.                         \tag{5.6}
\]

This improves the generic \(\tfrac12\log\Delta\) coefficient for
\(L(1,\chi)\) by a factor four, using exactly the primes \(2\) and \(3\).
It does not change the square-root dependence on \(A_n\).

## 6. What genus theory adds

Let \(\omega(A_n)\) be the number of prime factors of \(A_n\).  The positive
fundamental discriminant \(4A_n\) has

\[
 t=\omega(A_n)+1                                  \tag{6.1}
\]

prime-discriminant factors: one factor \(-4\), a factor \(p\) for every
\(p\equiv1\pmod {24}\), and a factor \(-q\) for every
\(q\equiv23\pmod {24}\).  Classical genus theory gives

\[
 \dim_{\mathbf F_2}
   \bigl(\mathrm {Cl}^+(K_n)/\mathrm {Cl}^+(K_n)^2\bigr)
   =t-1=\omega(A_n).                               \tag{6.2}
\]

There is no negative-norm unit, so the narrow class number is
\(h_n^+=2h_n\).  It follows that

\[
 2^{\omega(A_n)}\mid h_n^+=2h_n,
 \qquad
 2^{\omega(A_n)-1}\mid h_n.                       \tag{6.3}
\]

Combining (5.6) and (6.3) proves (0.7).

This is the full uniform gain supplied by elementary genus theory.  There is
no lower bound forcing \(\omega(A_n)\) to grow with \(n\).  More generally,
even the maximal order of \(\omega(A)\) for a squarefree integer of size
\(A\) is only \(O(\log A/\log\log A)\).  Hence
\(2^{\omega(A)}=A^{o(1)}\), and the genus factor cannot change the leading
square-root scale in (0.7).  Restricting every prime to
\(p\equiv\pm1\pmod {24}\) changes densities and constants, not this
conclusion.

## 7. The strongest pointwise consequence of these tools

First discard the factor \(h_n\ge1\) in (5.6).  Then

\[
 8R_n\le\sqrt{A_n}\bigl(\log(4A_n)+6\bigr).       \tag{7.1}
\]

As \(R_n\to\infty\), elementary monotone inversion of (7.1) gives the
fully explicit-bound consequence

\[
 A_n\ge(16-o(1)){R_n^2\over(\log R_n)^2}.         \tag{7.2}
\]

The leading constant \(16\) is the one obtained from the sharp local
coefficient \(1/8\) in (5.5): if
\(A=C R^2/(\log R)^2\), then the right side of (7.1) is
\((2\sqrt C+o(1))R\), forcing \(C\ge16\).

For the strongest asymptotic constant available from the cited
character-sum method, retain the local factors in Granville and
Soundararajan's proof.  Their Corollary for primitive quadratic characters of
cube-free conductor is

\[
 |L(1,\chi)|\le
 \left({c_2\over4}+o(1)\right)\log f_\chi,
 \qquad c_2=2-{2\over\sqrt e}.                    \tag{7.3}
\]

The conductor \(4A_n\) is cube-free.  Lemma 2 in that paper separates the
Euler factors at small primes through

\[
 \Theta(\chi,y)=
 \prod_{p\le y}{1-1/p\over1-\chi(p)/p}.           \tag{7.4}
\]

For this family, the factor at \(2\) is \(1/2\) and the factor at \(3\) is
also \(1/2\); every other factor has absolute value at most one for a real
character.  Thus \(|\Theta(\chi_n,y)|\le1/4\), and the proof of (7.3)
specializes to

\[
 L(1,\chi_n)\le
 \left({c_2\over16}+o(1)\right)\log(4A_n).        \tag{7.5}
\]

Estimate (7.5) is a specialization of the proof, not a separately printed
corollary in that paper: Lemma 2 supplies the factor \(1/4\), while the
cube-free Burgess truncation supplies the outer factor \(1/4\).

Combining (7.5) with the exact class-number formula and \(h_n\ge1\), then
inverting as above, yields

\[
 A_n\ge
 \left({64\over c_2^2}-o(1)\right)
 {R_n^2\over(\log R_n)^2}.                        \tag{7.6}
\]

The number \(64/c_2^2=103.347\ldots\) replaces \(16\) when an asymptotic
rather than an all-conductor explicit leading constant is desired.  Both
estimates have exactly the same order.

Since \(A_n\) is a product of a subset of the prime divisors of \(c_n\),

\[
 A_n\mid\operatorname{rad}(c_n),                  \tag{7.7}
\]

and (1.5)--(1.6) turn (7.6) into (0.10).  Retaining genus theory gives the
implicit refinement

\[
 \frac12\log A_n+\log\bigl(\log(4A_n)+6\bigr)
 \ge \log R_n+(\omega(A_n)+2)\log2.               \tag{7.8}
\]

Without an independent lower bound for \(\omega(A_n)\) or \(h_n\), (7.8)
does not improve the uniform asymptotic order of (0.10).

The classical continued-fraction construction of the fundamental solution,
together with its general worst-case size bound, gives no better scale:

\[
 \log\varepsilon_A\ll\sqrt A\log A               \tag{7.9}
\]

for every nonsquare \(A>1\).  Formula (5.6) is a sharper version adapted to
the local data of this family.  Neither method yields a polynomial upper
bound for \(\varepsilon_A\) in terms of \(A\), and such a bound is false for
general real quadratic fields.

The already-audited general recurrence results give a somewhat stronger
sublinear lower bound for the radical than (0.10).  Thus the value of the
present route is the exact fundamental-unit identification, injectivity, and
local class-number ledger, not a new best numerical radical estimate.

## 8. The precise remaining proposition

The desired one-factor conclusion would be

\[
 \log\operatorname{rad}(c_n)\ge(1-o(1))H_n.       \tag{8.1}
\]

The squarefree-parameter route would prove the stronger sufficient statement

\[
 \boxed{\ \log A_n\ge(1-o(1))H_n\ }.              \tag{8.2}
\]

Equivalently, using (1.5),

\[
 A_n\ge\varepsilon_{A_n}^{\,1-o(1)}.             \tag{8.3}
\]

No theorem quoted here approaches (8.2).  Bennett--Walsh proves uniqueness
and the fundamental-index assertion, not a lower bound of exponential size
for the squarefree parameter.  The class-number formula plus all available
local and genus information proves only (7.6).  To close this route one needs
a genuinely new theorem exploiting the simultaneous special conditions

\[
 \varepsilon_A=3r^2+ys\sqrt A,
 \qquad s^2-3r^2=1,                               \tag{8.4}
\]

not merely a generic regulator estimate.  Assuming (8.2), GRH, abc, or a
class-number distribution conjecture without proof would not be an
unconditional closure.

## 9. Formal companion

`IUTThreeClosures/FreyPellFundamentalUnitSquarefreeAudit.lean` verifies:

1. the three-consecutive-value identities (1.1);
2. the norm-one identity (1.2) and quartic equation (0.2);
3. their specialization to the fixed integral Pell orbit;
4. the Chebyshev modulo-three implication used in (3.7); and
5. an abstract injectivity ledger separating the Bennett--Walsh uniqueness
   input from the elementary conclusion.

It deliberately does not formalize Bennett--Walsh, quadratic reciprocity,
the analytic class-number formula, Louboutin's analytic estimate, genus
theory, or any radical asymptotic.

## References

* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proceedings of the American Mathematical Society 127
  (1999), 3481--3491, DOI 10.1090/S0002-9939-99-05041-8.  Theorem 1.2 is
  the uniqueness and divisibility-index theorem used in Section 3; Corollary
  1.3 independently specializes it to \(b=3\).
  Author-hosted paper:
  <https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf>.

* S. Louboutin, *Explicit upper bounds for \(|L(1,\chi)|\) for primitive
  even Dirichlet characters*, Acta Arithmetica 101 (2002), 1--18.
  Equation (11) is exactly (5.5) for \(\chi(2)=0,\chi(3)=-1\):
  <https://www.impan.pl/shop/publication/transaction/download/product/82711>.

* A. Granville and K. Soundararajan, *Upper bounds for
  \(|L(1,\chi)|\)*, Quarterly Journal of Mathematics 53 (2002), 265--284,
  DOI 10.1093/qjmath/53.3.265.  Their quadratic-character Corollary gives
  (7.3), while Lemma 2 gives the proof-specialization (7.5) after retaining
  the fixed Euler factors at \(2\) and \(3\):
  <https://arxiv.org/pdf/math/0106176>.

* D. M. Bradley, A. E. Özlük and C. Snyder, *On a class number formula
  for real quadratic number fields*, Bulletin of the Australian Mathematical
  Society 65 (2002), 259--270, DOI 10.1017/S000497270002030X.  Page 267
  recalls Dirichlet's exact identity
  \(2h(D)\log\varepsilon_D=\sqrt D\,L(1,\chi_D)\):
  <https://www.cambridge.org/core/services/aop-cambridge-core/content/view/0281428A50D346C43649541C8232ADC3/S000497270002030Xa.pdf/on_a_class_number_formula_for_real_quadratic_number_fields.pdf>.

* É. Fouvry and J. Klüners, *On the 4-rank of class groups of quadratic
  number fields*, Inventiones Mathematicae 167 (2007), 455--513,
  DOI 10.1007/s00222-006-0021-2.  At the start of Section 1 they record the
  genus-theory identity
  \(\operatorname{rk}_2\mathrm{Cl}^+(K)=\omega(\Delta)-1\):
  <https://math.uni-paderborn.de/fileadmin/mathematik/AG-Computeralgebra/Publications-klueners/ranks.pdf>.

* K. Akta\c{s} and M. R. Murty, *Fundamental units and consecutive
  squarefull numbers*, International Journal of Number Theory 13 (2017),
  243--252, DOI 10.1142/S1793042117500142.  This gives context for why
  fundamental-unit rigidity and consecutive powerful values do not by
  themselves replace abc:
  <https://mast.queensu.ca/~murty/fundamental-units.pdf>.

* The equivalent finite-abelian-group formulations
  \(\dim_{\mathbf F_2}\mathrm{Cl}^+(K)[2]=
  \dim_{\mathbf F_2}\mathrm{Cl}^+(K)/\mathrm{Cl}^+(K)^2=t-1\)
  are used only in their standard unconditional form.  Here \(t\) is the
  number of ramified rational primes, equivalently the number of prime
  discriminant factors in \(\Delta\).
