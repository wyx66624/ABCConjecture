# Post-\(p=31\) Pell--Chebyshev literature audit

**Status:** read-only literature audit, not a proof of the target statement
**Scope:** odd primes \(p\ge 31\), with the prospective uniform range
\(p\ge 37\)
**Main equation:**

\[
  y^2=4T_p(X)+5=4XH_p(X)+5,
  \qquad H_p(X):=\frac{T_p(X)}{X}.
  \tag{0.1}
\]

Here \(T_p\) and \(U_{p-1}\) are the Chebyshev polynomials of the first and
second kind.  Since \(p\) is odd, \(X\mid T_p(X)\), so \(H_p\in\mathbf Z[X]\).
The nondegenerate Pell/Lucas range is \(X\in\mathbf Z\), \(|X|>1\).

The expression \(y^2=4H_p(X)+5\), which appeared in an earlier task
description, is **not** the equation audited here.  In particular, none of the
two-points-at-infinity or Runge properties of that different even-degree model
are transferred to (0.1).

## 1. Executive conclusion

No unconditional, accepted theorem was found which either

1. directly excludes all integral solutions of (0.1), or
2. supplies a uniform exclusion for every prime \(p\ge 37\).

The strongest verified consequences of the literature are instead:

* for each **fixed** \(p\), Bilu--Tichy gives finiteness of the integral
  solutions of (0.1);
* for each **fixed** \(p\), Bérczes--Evertse--Győry gives an effective but
  enormous height bound;
* Bilu--Hanrot--Voutier supplies a primitive divisor at Lehmer index
  \(p>30\), while Granville Corollary 5, combined with the already-used
  Bennett--Walsh/Cohn square exclusions, supplies a characteristic/primitive
  divisor occurring to an odd exact power;
* the shift \(+5\) forces every relevant odd prime divisor to split in
  \(\mathbf Q(\sqrt5)\), but split prime ideals may occur to arbitrary odd
  exponent, and the equation is locally soluble at such a prime with arbitrary
  prescribed positive exact valuation;
* the verified Runge, simultaneous-Pell, Pell--Mahler, and consecutive
  power-free-part results all have fixed-polynomial, fixed-coefficient, or
  fixed-prime-support quantifiers that do not survive when \(p,X\), or the
  square-free kernels vary.

The most direct missing input would be a primitive-divisor theorem with a
**prescribed Frobenius class** in \(\mathbf Q(\sqrt5)\).  No such
per-index, uniform-in-\(X\), unconditional result was found in the checked
primary literature.  Section 8 states precisely what would be sufficient and
why ordinary Chebotarev-density statements do not supply it.

No conclusion below uses abc, GRH, BSD, finiteness of a Tate--Shafarevich
group, or the conjectural general odd-valuation primitive-divisor statement.

## 2. The primitive prime \(q\) and the \(+5\) shift

This section records the exact arithmetic information that the current
Chebyshev/Lucas reduction and the accepted primitive-divisor theorems can
provide.  Let \(q\) be a primitive divisor of the cyclotomic/Lehmer block
corresponding to \(H_p(X)\), away from the exceptional primes.  In the current
normalization one obtains

\[
 q\nmid 2\cdot5\cdot p\cdot X(X^2-1),
 \qquad v_q(H_p(X))=e,
 \tag{2.1}
\]

where the Granville--Bennett--Walsh/Cohn route can make \(e\) odd.  If

\[
 \lambda=X+\sqrt{X^2-1},
\]

then primitivity at the relevant index gives order \(4p\) in the appropriate
norm-one torus over \(\mathbf F_q\).  Consequently

\[
 4p\mid q-\left(\frac{X^2-1}{q}\right),
 \qquad q\equiv\pm1\pmod{4p},
 \qquad q\ge 4p-1.
 \tag{2.2}
\]

If (0.1) has a solution, reduction modulo \(q\) gives

\[
 y^2\equiv5\pmod q.
\]

Since \(q\ne5\), this is equivalent to

\[
 \left(\frac5q\right)=1,
 \qquad q\equiv\pm1\pmod5.
 \tag{2.3}
\]

Thus the shift does yield genuine new information: the selected primitive
prime must split in \(\mathbf Q(\sqrt5)\).  It does **not**, however, convert
the odd valuation into a contradiction.

Indeed, in \(\mathcal O_{\mathbf Q(\sqrt5)}\),

\[
 (y+\sqrt5)(y-\sqrt5)=4XH_p(X).
 \tag{2.4}
\]

The two factors are coprime at every prime above \(q\), because \(q\ne2,5\).
Writing

\[
 q\mathcal O_{\mathbf Q(\sqrt5)}=\mathfrak q\bar{\mathfrak q},
\]

one may label the two primes so that

\[
 v_{\mathfrak q}(y-\sqrt5)=e,
 \qquad
 v_{\bar{\mathfrak q}}(y+\sqrt5)=e,
 \tag{2.5}
\]

and the cross-valuations are zero.  The fact that
\(\mathbf Q(\sqrt5)\) has class number one does not restrict the parity of
these exponents: a principal ideal can contain a split prime ideal to any
nonnegative exponent.

### 2.1 Local compatibility with every positive exact valuation

The absence of a valuation-parity obstruction is stronger than (2.5).  The
standard identities

\[
 T'_p(X)=pU_{p-1}(X),
 \qquad
 T_p(X)^2-1=(X^2-1)U_{p-1}(X)^2
 \tag{2.6}
\]

show that a primitive root of \(T_p\) modulo a prime satisfying (2.1) is
simple.  If \(q\mid T_p(X)\) and \(q\nmid pX(X^2-1)\), then
\(U_{p-1}(X)\not\equiv0\pmod q\), hence

\[
 T'_p(X)\not\equiv0\pmod q,
 \qquad H'_p(X)\not\equiv0\pmod q.
\]

Hensel lifting at a simple root allows \(q\)-adic integral arguments with
\(v_q(H_p(X))\) equal to any prescribed positive integer.  Because (2.3)
gives a nonzero square root of \(5\) modulo \(q\), the derivative \(2y\) is a
unit and the full equation (0.1) lifts locally as well.  This is a local
statement, not a construction of global integral solutions, but it proves
that order, Legendre-symbol, and valuation parity data alone cannot close the
argument.

## 3. Primitive-divisor theorems: exact reach

### 3.1 Bilu--Hanrot--Voutier

Y. Bilu, G. Hanrot and P. M. Voutier, *Existence of primitive divisors of
Lucas and Lehmer numbers*, J. reine angew. Math. **539** (2001), 75--122,
[DOI and publication record](https://doi.org/10.1515/crll.2001.080).

**Theorem 1.4.** Every Lucas or Lehmer number of index \(n>30\) has a
primitive divisor; equivalently, every \(n>30\) is totally non-defective.

For

\[
 \alpha=X+\sqrt{X^2-1},
 \qquad \beta=-\alpha^{-1},
\]

one has \(\alpha\beta=-1\),
\((\alpha+\beta)^2=4(X^2-1)\), and \(\alpha/\beta\) is not a root of unity
when \(|X|>1\).  Thus this is a Lehmer pair in the normalization of the
paper, and at odd index

\[
 L_p(\alpha,\beta)
 =\frac{\alpha^p-\beta^p}{\alpha-\beta}
 =\frac{\lambda^p+\lambda^{-p}}{\lambda+\lambda^{-1}}
 =\frac{T_p(X)}{X}=H_p(X).
\]

Thus Theorem 1.4 applies for \(p\ge31\).  It guarantees a primitive divisor,
but neither odd exact valuation nor a prescribed value of \((5/q)\).

### 3.2 Granville

A. Granville, *Primitive prime factors in second-order linear recurrence
sequences*, Acta Arith. **155** (2012), 431--452,
[author PDF](https://dms.umontreal.ca/~andrew/PDF/PrimitivePrimeFactors.pdf).

There are two important scope distinctions.

* **Theorem 3** assumes a recurrence
  \(x_{n+2}=b x_{n+1}+c x_n\), \(x_0=0,x_1=1\), with
  \(\gcd(b,c)=1\), \(c\equiv2\pmod4\), and positive discriminant
  \(b^2+4c\).  The natural Chebyshev recurrence has
  \(b=2X,c=-1\equiv3\pmod4\).  Therefore Theorem 3 cannot be applied
  directly.
* **Corollary 5** says, for \(n\ne6,12\), that if \(x_n\) has no
  characteristic prime factor occurring to an odd power, then its
  cyclotomic block \(\phi_n\) is a square or \(r\) times a square, where
  \(r^a\mid n\) and \(n/r^a\le r+1\).

At \(n=2p\), Corollary 5 reduces the no-odd-characteristic-prime alternative
to the square or \(p\)-times-square cases relevant to \(H_p\).  The
independently established Bennett--Walsh/Cohn exclusions of those cases
therefore give, by contraposition, a characteristic/primitive prime divisor
with odd exact valuation.  This is the correct Granville input; it is not an
application of Theorem 3.

Granville's Corollary 6.4 gives a Jacobi-symbol restriction for even indices,
but the exceptional shape \(c=-1,n=2p\) is non-obstructive here.  Moreover,
Section 7 explicitly presents the general eventual existence of an
odd-multiplicity primitive prime factor as a conjecture, not a theorem.

Neither Corollary 5 nor Corollary 6.4 controls the Frobenius of the resulting
prime in \(\mathbf Q(\sqrt5)\).

## 4. Fixed-\(p\) finiteness: Bilu--Tichy

Y. Bilu and R. F. Tichy, *The Diophantine equation \(f(x)=g(y)\)*,
Acta Arith. **95** (2000), 261--288,
[publisher PDF](https://matwbn.icm.edu.pl/ksiazki/aa/aa95/aa9534.pdf).

**Theorem 1.1.** For nonconstant \(f,g\in\mathbf Q[X]\), the equation
\(f(x)=g(y)\) has infinitely many rational solutions with a bounded common
denominator if and only if, after linear changes of the two variables and a
common outer polynomial, the inner pair is a standard pair which itself has
infinitely many such solutions.

**Remark 1.2(ii).** When \(\gcd(\deg f,\deg g)=1\), the common outer
polynomial is linear and only standard pairs of the first or third kind can
occur.

Fix \(p\) and take

\[
 f_p(Z)=4T_p(Z)+5,
 \qquad g(W)=W^2.
\]

Their degrees \(p\) and \(2\) are coprime.  The polynomial \(f_p\) is
square-free: a common zero of \(f_p\) and
\(f'_p=4pU_{p-1}\) would have \(T_p=\pm1\) by (2.6), whereas
\(4T_p+5\in\{1,9\}\).

The two possible standard-pair types are excluded as follows.

1. For a first-kind pair
   \((Z^m,aZ^r h(Z)^m)\), one orientation has \(m=2,r=1\) and makes the
   degree-\(p\) side, after the forced zero output shift coming from
   \(g(W)=W^2\), have repeated roots.  The other orientation has \(m=p\)
   and makes \(f_p\) linearly equivalent to a \(p\)-th power; such a
   polynomial has only one finite critical point, whereas
   \(f'_p=4pU_{p-1}\) has \(p-1\) distinct roots.
2. For a third-kind Dickson pair of degrees \(p,2\), the unique critical
   value of the quadratic member is one of the two critical values of the
   degree-\(p\) member.  A common linear output map would therefore force
   one critical value of \(f_p\) to equal the sole critical value \(0\) of
   \(W^2\).  But the critical values of \(f_p\) are exactly \(1\) and
   \(9\).

Therefore (0.1) has only finitely many integer solutions for each fixed
\(p\).  The quantifier is

\[
 \boxed{\text{for every fixed }p,\ \#C_p(\mathbf Z)<\infty},
\]

not a bound uniform in \(p\), and Theorem 1.1 supplies no explicit height
bound or emptiness statement.

## 5. Fixed-\(p\) effective height: Bérczes--Evertse--Győry

A. Bérczes, J.-H. Evertse and K. Győry, *Effective results for hyper- and
superelliptic equations over number fields*, Publ. Math. Debrecen **82**
(2013), 727--756,
[publisher PDF](https://publi.math.unideb.hu/paper/1797/download/10_5486_PMD_2013_5748.pdf).

**Theorem 2.2.** Let \(K\) be a number field, \(S\) a finite set of places
containing the archimedean ones, \(f\in\mathcal O_S[X]\) have degree
\(n\ge3\) and no multiple roots, and \(b\in\mathcal O_S\setminus\{0\}\).
For solutions of \(f(x)=b y^2\), the theorem gives

\[
 h(x),h(y)
 \le
 (4ns)^{2^{12}n^4s}|D_K|^{8n^3}Q_S^{20n^3}
 \exp(50n^4d\widehat h),
 \tag{5.1}
\]

with the notation \(d=[K:\mathbf Q]\), \(s=|S|\), \(Q_S\) and
\(\widehat h\) defined in that paper.

Apply this with \(K=\mathbf Q\), \(S=\{\infty\}\), \(b=1\), and
\(f=f_p=4T_p+5\).  The square-free hypothesis was checked in Section 4.
A coarse Chebyshev coefficient estimate gives \(\widehat h=O(p)\), hence

\[
 h(X),h(y)\le \exp(O(p^5)),
 \qquad
 |X|,|y|\le \exp\!\bigl(\exp(O(p^5))\bigr).
 \tag{5.2}
\]

Thus the solution set is effectively computable in principle for a fixed
\(p\), but (5.2) grows with \(p\) and does not imply a uniform threshold.
Theorem 2.3 of the same paper bounds the power exponent \(m\) for a fixed
polynomial \(f\); it is irrelevant here because \(m=2\) is fixed while
\(f_p\) varies with \(p\).

## 6. Why the Runge hypotheses fail for the main equation

A. Levin, *Variations on a theme of Runge: effective determination of
integral points on certain varieties*, J. Théor. Nombres Bordeaux **20**
(2008), 385--417,
[publisher PDF](https://jtnb.centre-mersenne.org/item/10.5802/jtnb.634.pdf).

**Theorem 1.2** gives effective finiteness for \(S\)-integral values of a
rational function when the pole divisor has \(r\) Galois components and
\(r>|S|\).  The smooth projective model of

\[
 y^2=4T_p(X)+5
\]

has one point above infinity because the right side has odd degree.  The
function \(X\) therefore has one pole component.  Over \(\mathbf Q\), with
\(S=\{\infty\}\),

\[
 r=1=|S|,
\]

so the strict Runge inequality fails.  Equivalently, the leading form in the
plane model does not split into the required coprime branches of Theorem 1.1.

Levin's **Theorem 3.1** is a covering refinement.  In its notation, for an
auxiliary prime \(\ell\), its numerical hypothesis is

\[
 \log_{\ell}|S|+\operatorname{rk}_{\ell}\operatorname{Cl}(\mathcal O_{L,T})
 +\operatorname{rk}\mathcal O_{L,T}^{*}+1
 <
 \operatorname{rk}_{\ell}\operatorname{Jac}(C)(K)_{\mathrm{tors}}
 +\log_{\ell}n_{\infty}.
 \tag{6.1}
\]

For the natural \(\ell=2\) attempt, \(n_{\infty}=1\).  Under the established
irreducibility of \(4T_p+5\), the odd-degree hyperelliptic Jacobian has no
nonzero rational 2-torsion, so the right side of (6.1) is zero while the left
side is at least one.  Thus this natural cover does not restore Runge.  The
superelliptic splitting criterion in **Theorem 4.1** likewise needs more
irreducible factors than the present irreducible right side provides.

These are failures of the printed hypotheses, not claims that every possible
future covering argument must fail.

## 7. Pell, Mahler, and four-consecutive-number results

The moving-coefficient issue is visible in the present four-consecutive
normalization

\[
 b=Au^2,
 \qquad b+1=Bv^2,
 \qquad b+2=3r^2,
 \qquad b+3=s^2,
 \tag{7.1}
\]

where \(A,B\) are square-free kernels depending on the candidate solution.
Putting \(Z=b^2+3b+1\) gives

\[
 Z^2-3AB(uvrs)^2=1.
 \tag{7.2}
\]

The associated fundamental-unit index is forced to be odd in the current
reduction, but odd powers do not fix or bound the moving kernels \(A,B\).
The residual Chebyshev condition is still (0.1).  The papers below become
effective only after the coefficients or prime support have been fixed.

### 7.1 Bennett--Walsh

M. A. Bennett and P. G. Walsh, *The Diophantine equation
\(b^2X^4-dY^2=1\)*, Proc. Amer. Math. Soc. **127** (1999), 3481--3491,
[author PDF](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf).

* **Theorem 1.2:** for fixed square-free \(b,d>1\), there is at most one Pell
  index \(k\) for which the Pell trace has the form \(T_k=bx^2\).
* **Corollary 1.5:** for fixed \(n\), it determines the integral points on the
  unshifted curve \(y^2=T_{2n+1}(x)/x\).
* **Proposition 2.1:** for fixed positive \(a,b,c\), at most one \(N\) has
  \((N-1,N,N+1)=(ax^2,by^2,cz^2)\).
* **Theorem 1.4:** for fixed square-free \(b\), there is an effective
  constant \(C(b)\) such that the indicated Pell-square occurrence has only
  low index when the other discriminant parameter exceeds \(C(b)\).

These results are directly useful for excluding the **unshifted** alternatives
that \(H_p\) is a square or \(p\) times a square.  They do not treat
\(4T_p+5\), and their constants fix coefficients which vary in the
four-consecutive-number branch.

### 7.2 Simultaneous Pell equations

M. A. Bennett, M. Cipu, M. Mignotte and R. Okazaki, *On the number of
solutions of simultaneous Pell equations II*, Acta Arith. **122** (2006),
407--417,
[publisher PDF](https://www.impan.pl/shop/en/publication/transaction/download/product/82060).

**Theorem 1.2.** For each fixed pair of distinct positive integers \(a,b\),

\[
 x^2-az^2=1,
 \qquad y^2-bz^2=1
\]

has at most two positive solutions.  The theorem is

\[
 \forall(a,b)\ \#\mathrm{Sol}(a,b)\le2,
\]

not a uniform bound for the size of those solutions when \((a,b)\) varies.
In the current reduction the square-free kernels and discriminants move with
the candidate solution.  The paper also exhibits infinitely many coefficient
pairs attaining two solutions, so its counting result cannot be converted
into a uniform index or height bound.

### 7.3 Fixed-support Pell--Mahler equations

Y. Bugeaud, C. Levesque and M. Waldschmidt, *Équations de
Fermat--Pell--Mahler simultanées*, Publ. Math. Debrecen **79** (2011),
357--366,
[publisher PDF](https://publi.math.unideb.hu/load_doc.php?p=1639&t=pap).

**Theorem 2.1** fixes two quadratic forms and a finite set of primes \(S\),
then gives finitely many \(S\)-equivalence classes with an explicit count.
**Theorem 2.2** fixes the primes \(p_1,\ldots,p_s\) and gives an explicit
finite bound for the associated simultaneous Pell--Mahler solutions.

In the four-consecutive-number branch the relevant support contains the
prime divisors of quantities such as \(b_n(b_n+1)\), hence varies with the
solution.  Taking the union over all finite \(S\) destroys the fixed-support
constants; neither theorem gives a uniform bound in \(p\).

### 7.4 Power-free parts of consecutive integers

B. M. M. de Weger and C. E. van de Woestijne, *On the power-free parts of
consecutive integers*, Acta Arith. **90** (1999), 387--395,
[author PDF](https://deweger.net/papers/%5B31%5DvdWdW-PowFree-ActaArith%5B1999%5D.pdf).

* **Theorem 1.1(iii)** shows that for the square-free, two-consecutive-number
  case there are infinitely many pairs with simultaneously bounded
  square-free parts.
* **Theorem 1.2** gives only a logarithmic lower bound in the case
  \(n\ge3,k=2\).
* **Theorem 1.3** gives the stronger Thue-type estimate only for \(k\ge3\);
  the paper explicitly notes that it does not cover \(k=2\).
* **Theorem 1.4**, which has the desired polynomial-scale flavor, assumes
  abc and is therefore circular for this repository's objective.

Thus there is no unconditional coefficient-uniform radical or square-free
kernel estimate in this source that closes the four-consecutive branch.

For comparison, M. Aktaş and M. R. Murty, *Fundamental units and consecutive
squarefull numbers*, Int. J. Number Theory **13** (2017), 243--252,
[author PDF](https://mast.queensu.ca/~murty/fundamental-units.pdf), proves in
Theorem 1.3/Theorem 5.1 an unconditional global counting estimate
\(O(N^{2/5})\), not a pointwise height or index bound.  Its stronger
Theorem 1.2 assumes abc and is inadmissible here.

### 7.5 Bugeaud--Shorey type equations

Y. Bugeaud and T. N. Shorey, *On the number of solutions of the generalized
Ramanujan--Nagell equation*, J. reine angew. Math. **539** (2001), 55--74,
[DOI and publication record](https://doi.org/10.1515/crll.2001.079).

The paper fixes coprime positive integers \(D_1,D_2\) and a fixed odd integer
\(k\), coprime to \(D_1D_2\), and studies

\[
 D_1x^2+D_2=k^n.
\]

**Theorem 1** gives a necessary and sufficient condition under which the
number of solutions is at most \(2^{\omega(k)-1}\); in particular the bound is
one when the fixed base \(k\) is prime.  In (0.1), the quantity
\(4XH_p(X)\) is not a power of a fixed base.  Extracting one primitive prime
\(q\mid H_p(X)\) does not make the remaining cofactor disappear.  Hence the
theorem's fixed-base hypothesis is not satisfied.

The first author's
[publication-page correction notice](https://irma.math.unistra.fr/~bugeaud/publi.html)
records that the printed proof/exception list for **Theorem 2** omitted the equation
\(2x^2+1=3^n\), which has the three solutions \((1,1),(2,2),(11,5)\).
No use of Theorem 2 or of that exception list is made here; only the
fixed-base quantifier of Theorem 1 is relevant to this audit.

## 8. The prescribed-Frobenius primitive-divisor target

The following statement would immediately exclude (0.1) in the desired
range:

> For every integer \(|X|>1\) and every prime \(p\ge37\), the Lehmer block
> \(H_p(X)\) has a primitive prime divisor \(q\nmid10pX(X^2-1)\) such that
> \(\left(\frac5q\right)=-1\).

Indeed, such a divisor would give \(y^2\equiv5\pmod q\), contradicting the
specified Legendre symbol.  Equivalently, one seeks a primitive divisor with

\[
 q\equiv\pm2\pmod5
\]

rather than the split classes forced by a solution.

**Literature verdict:** no unconditional theorem with this quantifier and
this prescribed Frobenius conclusion was found in the checked primary
sources.  In particular:

* Bilu--Hanrot--Voutier Theorem 1.4 guarantees at least one primitive divisor
  at every index \(>30\), but does not prescribe its residue class in a
  second, unrelated quadratic extension;
* Granville Corollary 5 can force odd multiplicity after the separate square
  exclusions, but does not prescribe \((5/q)\);
* standard Chebotarev results for a **fixed** recurrence describe densities of
  primes with specified splitting/rank-of-apparition behavior as the prime
  varies.  They do not imply that each individual term of each recurrence has
  a primitive divisor in a chosen class, and here the recurrence itself varies
  with \(X\).

Consequently the displayed statement is a new sufficient target, not an
accepted theorem interface.  It may require a second primitive divisor, a
relative cyclotomic norm argument, or a genuinely new effective
Chebotarev/sieve input; its truth is not asserted by this audit.

## 9. Final dependency verdict

| Input | Exact usable conclusion | Why it does not close \(p\ge37\) |
|---|---|---|
| BHV, Theorem 1.4 | primitive divisor for each Lehmer index \(>30\) | no valuation parity or prescribed Frobenius |
| Granville, Corollary 5 + BW/Cohn | an odd-valuation characteristic/primitive divisor | split prime ideals admit arbitrary odd exponent |
| Bilu--Tichy, Theorem 1.1 + Remark 1.2(ii) | finitely many integral points for each fixed \(p\) | ineffective and not uniform in \(p\) |
| Bérczes--Evertse--Győry, Theorem 2.2 | explicit height bound for each fixed \(p\) | bound grows roughly as \(\exp(O(p^5))\) in logarithmic height |
| Levin, Theorems 1.2 and 3.1 | effective Runge under strict branch/cover inequalities | one point at infinity; the inequalities fail |
| Bennett--Walsh, Theorem 1.2/Corollary 1.5 | fixed-coefficient, unshifted Pell-square control | coefficients move and \(+5\) is absent |
| simultaneous Pell, Theorem 1.2 | at most two solutions for each fixed coefficient pair | no uniform solution height as the pair varies |
| Pell--Mahler, Theorems 2.1--2.2 | fixed-prime-support finiteness/count | the support varies with the solution |
| consecutive power-free-part results | weak unconditional bounds; stronger abc-conditional bound | no unconditional pointwise bound of the required strength |
| Bugeaud--Shorey, Theorem 1 | fixed-base generalized Ramanujan--Nagell control | \(4XH_p(X)\) is not a fixed-base power |

Accordingly, this literature audit supplies no accepted theorem interface
that would justify a uniform post-\(p=31\) closure.  Any such closure must add
new arithmetic beyond the present primitive-divisor existence, congruence,
and local-valuation data.  The sharpest identified missing statement is the
prescribed-Frobenius primitive-divisor target of Section 8.
