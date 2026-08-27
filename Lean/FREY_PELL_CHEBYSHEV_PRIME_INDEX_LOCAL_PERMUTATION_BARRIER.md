# The prime-index Chebyshev residual: the active \(4/31\) threshold and a local permutation barrier

## 0. Outcome and trust boundary

This note studies the remaining prime-index case in the four-consecutive
Pell family.  Its input is the complete residual package

\[
\begin{aligned}
 b&=Au^2,& b+1&=Bv^2,& b+2&=3r^2,& b+3&=s^2,\\
 D&=3AB,& Z&=b^2+3b+1,\\
 T-1&=Ax_0^2,& T+1&=3By_0^2,\\
 \varepsilon&=T+x_0y_0\sqrt D,&
 \varepsilon^p&=Z+uvrs\sqrt D,
 \end{aligned}                                      \tag{0.1}
\]

where \(A,B\) are positive, coprime and squarefree, \(3\nmid AB\),
\(T\equiv23\pmod {24}\), \(\varepsilon\) is the positive fundamental
norm-one unit of \(\mathbf Q(\sqrt D)\), and \(p\ge31\) is prime.  The lower
bound reflects the separately certified closures of all prime indices through
29 in the current repository state.  Equivalently,

\[
  Z=T_p(T),\qquad y^2=4T_p(T)+5,qquad y=2b+3.       \tag{0.2}
\]

The notation for \(T_j,U_j\) is normalized by

\[
 T_j\!\left({\lambda+\lambda^{-1}\over2}\right)
 ={\lambda^j+\lambda^{-j}\over2},\qquad
 U_j\!\left({\lambda+\lambda^{-1}\over2}\right)
 ={\lambda^{j+1}-\lambda^{-j-1}\over\lambda-\lambda^{-1}}.
                                                               \tag{0.3}
\]

There is no unconditional uniform exclusion of \(p\ge31\) below.  There are,
however, two new rigorous conclusions.

1. Every genuine residual point satisfies the sharp elementary necessary
   inequality

   \[
       (3AB+1)^{31}\le Z^2.                              \tag{0.4}
   \]

   Thus the residual would be closed by the pointwise parity-core estimate

   \[
       (3AB+1)^{31}> (b^2+3b+1)^2.                       \tag{0.5}
   \]

   On an asymptotic scale, any uniform lower bound
   \(AB\gg b^{4/31+\delta}\), \(\delta>0\), would suffice after a finite
   computation.  This is substantially weaker than a coefficient-one
   radical estimate, but it is not supplied by an accepted theorem.

2. Every fixed finite prime-power congruence covering is transparent to the
   *complete* polynomial residual for all sufficiently large \(p\).  At each
   fixed odd prime \(q\ge5\), a nondegenerate four-consecutive local block is
   obtained from the fact that \(T_p\) is a permutation of \(\mathbf F_q\).
   The point is simple and hence lifts to every \(q\)-power.  Separate exact
   branches at \(2\) and \(3\), followed by the Chinese remainder theorem,
   give the asserted fixed-modulus obstruction.

The positivity and fundamental-unit assertions in (0.1) are genuinely
global.  They are not polynomial congruence conditions and are not claimed
to follow from the local constructions.  This distinction is precisely why
the local theorem is a no-go for congruence coverings, not a counterexample
to the original integer statement.

The companion Lean file checks only the scalar algebra and the exact
integer-power implication leading to (0.4).  It does not formalize Dickson's
permutation theorem, Hensel's lemma, Dirichlet's theorem, quadratic fields,
fundamental units, squarefreeness, or the external finite computation in
Section 8.  No conjectural input, including `abc` or Szpiro, is used.

## 1. Half-angle factorization of the complete residual

Write \(p=2m+1\).  The standard Chebyshev identities are

\[
\begin{aligned}
 T_p(X)-1&=(X-1)
   \bigl(U_m(X)+U_{m-1}(X)\bigr)^2,\\
 T_p(X)+1&=(X+1)
   \bigl(U_m(X)-U_{m-1}(X)\bigr)^2.
\end{aligned}                                      \tag{1.1}
\]

Put

\[
 F=U_m(T)+U_{m-1}(T),\qquad
 G=U_m(T)-U_{m-1}(T).                              \tag{1.2}
\]

Then

\[
 U_{p-1}(T)=FG.                                     \tag{1.3}
\]

Comparing (1.1) with the four-consecutive factorization

\[
 Z-1=b(b+3)=A(us)^2,\qquad
 Z+1=(b+1)(b+2)=3B(vr)^2                         \tag{1.4}
\]

gives, with compatible positive signs,

\[
 us=x_0F,\qquad vr=y_0G.                             \tag{1.5}
\]

Consequently

\[
 x_0y_0U_{p-1}(T)=uvrs,                              \tag{1.6}
\]

and the usual power formula in the quadratic algebra recovers the entire
unit identity

\[
 (T+x_0y_0\sqrt D)^p
 =T_p(T)+x_0y_0U_{p-1}(T)\sqrt D
 =Z+uvrs\sqrt D.                                    \tag{1.7}
\]

Thus the local constructions below retain the four consecutive numbers,
both moving parity kernels, both half-angle factors, the norm equation, and
both coefficients of the unit power.  They do not test only the shifted
square in (0.2).

## 2. The exact active \(4/31\) threshold

The norm equation in (0.1) is

\[
 T^2-1=D(x_0y_0)^2.                                  \tag{2.1}
\]

All quantities are positive and \(x_0y_0\ge1\), so

\[
 D+1\le T^2.                                         \tag{2.2}
\]

For \(T\ge1\), write

\[
 T={a+a^{-1}\over2},\qquad a=T+\sqrt{T^2-1}\ge1.
\]

Convexity gives

\[
 (a+a^{-1})^p\le 2^{p-1}(a^p+a^{-p}),
\]

and hence

\[
 T^p\le T_p(T)=Z.                                    \tag{2.3}
\]

Raising (2.2) to the \(p\)-th power and using (2.3) yields

\[
 (D+1)^p\le T^{2p}\le Z^2.                           \tag{2.4}
\]

In general, (2.4) gives \((D+1)^k\le Z^2\) for every \(k\le p\).
Because the currently active residual has \(p\ge31\), retain the full fixed
exponent 31:

\[
 (3AB+1)^{31}=(D+1)^{31}\le(D+1)^p\le Z^2.           \tag{2.5}
\]

Equivalently,

\[
 3AB+1\le Z^{2/p}\le Z^{2/31}.                       \tag{2.6}
\]

Since \(Z=b^2+3b+1<(b+2)^2\), a slightly looser elementary version is

\[
 AB<{(b+2)^{4/31}\over3}.                             \tag{2.7}
\]

The direction is important: (2.5)--(2.7) are *necessary upper bounds* on
the moving parity kernel of a hypothetical prime-index residual.  They do
not prove that \(AB\) is large.

There are also the separate necessary bounds

\[
 A\le T-1<Z^{1/p},\qquad
 3B\le T+1\le Z^{1/p}+1.                              \tag{2.8}
\]

The exact missing sufficient statement is therefore (0.5).  In particular,
one does not need the much stronger coefficient-one parity estimate arising
in the full radical route.  But one does need a pointwise power-scale
estimate, not an average result and not merely the existence of a prime of
odd valuation.

## 3. A nondegenerate local point at every fixed \(q\ge5\)

Let \(q\ge5\) be a fixed rational prime, and let \(p>q+1\) be prime.  Then

\[
 \gcd(p,q^2-1)=1.                                     \tag{3.1}
\]

Indeed, if \(p\mid(q-1)(q+1)\), primality of \(p\) would force
\(p\mid q-1\) or \(p\mid q+1\), contrary to \(p>q+1\).

The Dickson permutation criterion says that \(D_p(X,1)\) permutes
\(\mathbf F_q\) exactly when \(\gcd(p,q^2-1)=1\).  Since

\[
 D_p(2X,1)=2T_p(X)                                    \tag{3.2}
\]

and \(q\) is odd, \(T_p\) is therefore a permutation of \(\mathbf F_q\).
Let \(t\in\mathbf F_q\) be the unique element satisfying

\[
 T_p(t)=5.                                             \tag{3.3}
\]

Use the complete local four-consecutive block

\[
 b=1,\quad A=1,\quad B=2,\quad u=v=r=1,\quad s=2,
 \quad D=6,\quad Z=5.                                  \tag{3.4}
\]

With \(m=(p-1)/2\), define \(F,G\) as in (1.2), now evaluated at \(t\).
Equations (1.1) and (3.3) give

\[
 (t-1)F^2=4,\qquad (t+1)G^2=6.                         \tag{3.5}
\]

Both right sides are nonzero in \(\mathbf F_q\), so \(F,G\ne0\).  Set

\[
 x_0={2\over F},\qquad y_0={1\over G}.                \tag{3.6}
\]

Then

\[
 t-1=x_0^2,\qquad t+1=6y_0^2,\qquad
 t^2-6(x_0y_0)^2=1,                                   \tag{3.7}
\]

and, by (1.3),

\[
 x_0y_0U_{p-1}(t)=2=uvrs.                              \tag{3.8}
\]

In the quadratic \(\mathbf F_q\)-algebra with \(\rho^2=6\), equations
(3.3), (3.7), and (3.8) give

\[
 (t+x_0y_0\rho)^p=5+2\rho.                            \tag{3.9}
\]

The \(\beta\)-square and its subfield norms are present as well.  In the
biquadratic algebra, choose \(a^2=2,\ c^2=3\), and \(\rho=ac\).  The
specialization of the audited coordinate is

\[
 \beta=vs\,a+ur\,c=2a+c,
\]

so

\[
 \beta^2=11+4\rho=1+2(5+2\rho)=1+2\varepsilon^p.      \tag{3.10}
\]

Its two conjugation products, the scalar reductions of the two relative
subfield norms, are

\[
 (2a+c)(2a-c)=5,\qquad
 (2a+c)(-2a+c)=-5.                                    \tag{3.11}
\]

The four displayed norm formulae for \(\beta\pm1\) in the uniform-genus
audit then specialize identically.  Thus neither the \(\beta\)-square nor
the quadratic-subfield norm ledger removes this local point.

The factors \(F,G\) and the coordinates \(x_0,y_0,u,v,r,s\) are nonzero
(the trace \(t\) itself is allowed to vanish, as it does at \(q=5\)).
The point also has coprime local kernels \(A=1,B=2\), and \(3\nmid AB\).

The derivative identity

\[
 T_p'(X)=pU_{p-1}(X)                                   \tag{3.12}
\]

shows that the root in (3.3) is simple:

\[
 T_p'(t)=pFG\ne0\quad\hbox{in }\mathbf F_q.           \tag{3.13}
\]

Hensel's lemma therefore lifts \(t\), and hence (3.4)--(3.9), to every
\(q^e\).

## 4. Why every fixed finite congruence covering is transparent

The primes \(2\) and \(3\) have an exact common polynomial branch.  Over
either \(\mathbf Z_2\) or \(\mathbf Z_3\), take

\[
\begin{gathered}
 t=-1,\quad b=-2,\quad A=-2,\quad B=-1,\\
 u=v=x_0=s=1,\quad r=y_0=0,\quad D=6,\quad Z=-1.
\end{gathered}                                             \tag{4.1}
\]

Then all four block equations, both kernel equations, and the norm and
coefficient equations hold exactly.  For every odd \(p\),

\[
 T_p(-1)=-1,\qquad (-1+0\sqrt6)^p=-1.                  \tag{4.2}
\]

Moreover \(t=-1\equiv7\pmod8\) and \(t=-1\equiv2\pmod3\), exactly the
two components of \(T\equiv23\pmod{24}\).  The residues in (4.1) also
respect the local squarefree/coprime pattern: \(v_2(A)=1\), \(B\) is a
2-adic unit, and \(A,B\) are both 3-adic units.

Now fix any finite set \(S\) of prime powers.  Enlarge it by the required
2- and 3-powers encoding \(T\equiv23\pmod{24}\).  If

\[
 p>\max_{q\in S,\ q\ge5}(q+1),                         \tag{4.3}
\]

use Section 3 at every \(q\ge5\), and (4.1) at \(q=2,3\).  The Chinese
remainder theorem combines the componentwise values of every residual
variable into a simultaneous solution modulo the product modulus.

Thus:

> **Fixed-modulus local permutation barrier.**  No finite collection of
> fixed prime-power congruence tests on the complete polynomial residual can
> exclude all sufficiently large prime indices \(p\).

This statement does not apply to a modulus whose prime divisors grow with
\(p\), nor does it encode that \(\varepsilon\) is the *fundamental positive*
unit of one global real quadratic field.  Any successful local or modular
argument must use one of those genuinely non-fixed features.

## 5. Even an order-\(2p\) moving prime can have all required splitting

Allowing the auxiliary prime to grow with \(p\) is necessary, but an order
condition plus quadratic splitting is still insufficient by itself.

Fix an odd prime \(p\).  Dirichlet's theorem gives infinitely many primes

\[
 q\equiv1\pmod{24p}.                                   \tag{5.1}
\]

Choose \(\lambda\in\mathbf F_q^\times\) of exact order \(2p\), and put

\[
 t={\lambda+\lambda^{-1}\over2}.                       \tag{5.2}
\]

Then \(T_p(t)=-1\).  Since \(q\equiv1\pmod{24p}\), the elements
\(-1,2,3,\lambda\) are squares in \(\mathbf F_q\).  Also

\[
 t-1={ (\lambda-1)^2\over2\lambda},\qquad
 t+1={ (\lambda+1)^2\over2\lambda}.                   \tag{5.3}
\]

Choose the local block

\[
 b=-1,\quad A=B=1,\quad v=0,\quad D=3,\quad Z=-1,      \tag{5.4}
\]

and choose nonzero \(u,r,s,x_0,y_0\) with

\[
 u^2=-1,\quad r^2={1\over3},\quad s^2=2,\quad
 x_0^2=t-1,\quad 3y_0^2=t+1.                           \tag{5.5}
\]

The signs may be selected so that, for a chosen \(\rho^2=3\),

\[
 x_0y_0\rho={\lambda-\lambda^{-1}\over2}.             \tag{5.6}
\]

Hence \(\varepsilon=t+x_0y_0\rho=\lambda\) and

\[
 \varepsilon^p=-1=Z+uvrs\rho.                          \tag{5.7}
\]

Here the full \(\beta\)-equation also survives: with
\(\beta=ur\rho\), equations (5.5) give
\(\beta^2=-1=1+2\varepsilon^p\).  Its relative norm identities are the
same specializations of the audited algebraic formulae.

This is the natural reduction branch \(q\mid b+1\): the coordinate \(v\)
and the corresponding half-angle factor vanish modulo \(q\), as they must,
while every square-root coordinate listed in (5.5) remains nonzero.  At the
same time \(q\) splits in both
\(\mathbf Q(\sqrt2)\) and \(\mathbf Q(\sqrt3)\), and the eigenvalue has the
exact order expected from a primitive divisor of the \(T_p+1\) side.

Therefore a contradiction cannot be extracted from only

* an order-\(2p\) Frobenius condition;
* splitting in the quadratic subfields forced by the four-consecutive
  squareclasses; and
* the polynomial residual equations.

One would have to use deeper information that the moving prime is a
primitive divisor of the *same global integer point*, or else use the
global fundamental-unit minimality.  Section 5 is a no-go for a bare
order/splitting diagnostic, not for every possible moving-prime argument.

## 6. Residual characteristic \(p\) is a built-in Frobenius solution

In characteristic \(p\), the normalized Chebyshev polynomial satisfies

\[
 T_p(X)\equiv X^p\pmod p.                               \tag{6.1}
\]

Thus, on integer residues, \(T_p(T)\equiv T\pmod p\).  But the complete
four-consecutive equations already give

\[
\begin{aligned}
 T-1&\equiv Z-1=b(b+3)=A(us)^2\pmod p,\\
 T+1&\equiv Z+1=(b+1)(b+2)=3B(vr)^2\pmod p.
\end{aligned}                                             \tag{6.2}
\]

These are exactly the two moving kernel conditions again.  The derivative
also degenerates because \(T_p'=pU_{p-1}\).  Consequently a Frey or
Galois-representation construction that uses only the residual
characteristic-\(p\) squareclasses sees a tautological Frobenius point.  Any
extra leverage at \(p\) would have to be higher \(p\)-adic information, for
example a genuine Wieferich-depth restriction, rather than the first
residue layer.

There is a related structural obstruction to applying an ordinary
\((p,p,2)\) Frey curve directly to

\[
 \beta^2-1=2\varepsilon^p.                              \tag{6.3}
\]

The ideal-square identities for \(\beta\pm1\) do not make their unit parts
\(p\)-th powers.  In a moving biquadratic field, those unit classes range
over a quotient whose size itself grows with the unit rank modulo \(p\).
Fixing a Frey equation therefore requires controlling a moving unit class,
not merely observing that the two principal ideals are squares.  Existing
fixed-number-field asymptotic Fermat theorems do not provide that uniform
control.

## 7. Accepted squarefree-part results do not cross \(4/31\)

The relevant unconditional results have the wrong scale or the wrong
quantifier.

1. Mukhopadhyay--Shorey's main quantitative theorem assumes a block length
   \(k\ge10\).  For a starting point \(b>k^2\), their quoted \(k\ge4\)
   result gives at least two block
   positions carrying a prime \(>k\) to odd valuation, apart from three
   explicit small exceptions.  In the present four-term block the last two
   terms are \(3r^2,s^2\), so this forces odd-valuation support into \(b\)
   and \(b+1\).  It gives only a fixed number of support primes, not a
   lower bound of power size for \(AB\).

2. De Weger--van de Woestijne quote Turk's unconditional estimate, for a
   fixed block of at least three integers, that the maximum squarefree part
   is eventually larger than \((\log b)^{0.04}\).  Their paper explicitly
   notes that no absolute lower bound polynomial in \(b\) was obtained; its
   power-scale statement is conditional on `abc`.

3. General greatest-squarefree-factor or recurrence theorems supply support
   on an index-subexponential scale.  On the Pell orbit, whose height is
   exponential in the index, this is \(b^{o(1)}\).  Moreover a radical
   counts every support prime, while \(AB\) records valuation parity.  It
   cannot be substituted into (0.5).

4. Fixed-coefficient simultaneous-Pell, Thue, elliptic, or modular results
   may give finiteness or uniqueness after \(A,B\) have been fixed.  Here
   \(A,B\), the discriminant \(D=3AB\), the field, and the level all move.
   Their constants do not yield the pointwise polynomial dependence in
   (0.5).

Accordingly, the following is the smallest clean unconditional input found
that would finish the prime-index residual:

> **Four-consecutive parity-core \(4/31\) proposition.**  For every
> sufficiently large member of the actual orbit
> \(b=Au^2,\ b+1=Bv^2,\ b+2=3r^2,\ b+3=s^2\), one has
> \[
>    (3AB+1)^{31}>(b^2+3b+1)^2.
> \]

No accepted theorem located in the cited block, recurrence, Pell, or
modular literature proves this proposition.  It remains an honest new
pointwise parity-kernel problem.

## 8. Exact finite diagnostic on the actual Pell orbit

The four-consecutive Pell orbit selected in the preceding audits is

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,\qquad
 b_n=s_n^2-3=3r_n^2-2.                                  \tag{8.1}
\]

For each \(n\), form \(A_n,B_n,D_n,Z_n\) as in (0.1), and let \(e_n\) be
the exponent of the target unit relative to the positive fundamental
norm-one unit of \(\mathbf Q(\sqrt{D_n})\).  Here \(D_n\equiv6\pmod8\),
and \(Z_n\equiv7\pmod8\), so \(e_n\) is odd.  If \(e_n>1\), some odd prime
\(\ell\mid e_n\) gives an integer \(t\ge2\) with

\[
 Z_n=T_\ell(t).                                         \tag{8.2}
\]

Conversely, (8.2) implies

\[
 Z_n^2-1=(t^2-1)U_{\ell-1}(t)^2,                        \tag{8.3}
\]

so it detects an \(\ell\)-fold unit decomposition in the same squarefree
quadratic field.  There is an exact candidate formula:

\[
 Z=T_\ell(t),\ t\ge2
 \quad\Longrightarrow\quad
 \left\lfloor(2Z)^{1/\ell}\right\rfloor=2t-1.          \tag{8.4}
\]

Indeed \(2T_\ell(t)< (2t)^\ell\), while
\(2T_\ell(t)>(2t-1)^\ell\).  Thus an integer `sqrtnint`, followed by one
exact Chebyshev evaluation, tests each possible prime \(\ell\) without
factoring \(D_n\), using floating point, or assuming GRH.

An external PARI/GP scan applying (8.4) to every odd prime
\(3\le\ell\le\log_3(2Z_n)\) found

\[
 e_n=1\qquad(1\le n\le800).                             \tag{8.5}
\]

The final \(Z_{800}\) has 3660 decimal digits.  The scan is finite evidence,
not a uniform proof.  It also found square-divisor events such as
\(23^2\mid b_{34}\) and \(47^2\mid b_{319}\), while the corresponding unit
index remained one.  Thus the tempting implication "a repeated prime in a
neighbor forces the target unit to be a proper power" is false even in the
first explicit examples.

## 9. Conclusion

The prime-index residual is not closed unconditionally.  The present work
does isolate what a successful next step must see.

* A pointwise bound just beyond the \(4/31\) parity-core exponent would
  finish every currently active \(p\ge31\).
* No fixed finite congruence covering can supply it: complete nondegenerate
  local points exist and Hensel-lift at every fixed \(q\ge5\).
* Letting \(q\) grow with \(p\) does not help if one retains only order and
  quadratic splitting.
* Reduction in characteristic \(p\) repeats the two kernel identities by
  Frobenius and is singular at the first derivative layer.
* The remaining genuinely global datum is that the same
  \(\varepsilon=T+x_0y_0\sqrt D\) is the positive fundamental unit while
  \(A,B\) are the parity kernels of the same four consecutive integers.

This is a strict no-go for fixed-modulus and bare Frobenius/order methods,
and an exact quantitative reduction of the global problem.  It is not an
`abc` proof and it does not promote finite computation to a theorem.

## References

* L. E. Dickson's permutation criterion, in the normalization used here,
  is recalled and related explicitly to Chebyshev polynomials in
  A. W. Bluher, *Permutation properties of Dickson and Chebyshev
  polynomials with connections to number theory*, Finite Fields and Their
  Applications **76** (2021), 101899,
  [doi](https://doi.org/10.1016/j.ffa.2021.101899),
  [arXiv](https://arxiv.org/abs/1707.06877).
* A. Mukhopadhyay and T. N. Shorey, *Square free part of products of
  consecutive integers*, Publ. Math. Debrecen **64** (2004), 79--99,
  [journal PDF](https://publi.math.unideb.hu/paper/924/download/10_5486_PMD_2004_2881.pdf).
* B. M. M. de Weger and C. E. van de Woestijne, *On the power-free parts
  of consecutive integers*, Acta Arith. **90** (1999), 387--395,
  [journal PDF](https://matwbn.icm.edu.pl/ksiazki/aa/aa90/aa9046.pdf).
* T. N. Shorey and R. Tijdeman, *Arithmetic properties of blocks of
  consecutive integers*, Integers **17** (2017), A46,
  [arXiv](https://arxiv.org/abs/1612.05438).
* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proc. Amer. Math. Soc. **127** (1999), 3481--3491,
  [author PDF](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf).
