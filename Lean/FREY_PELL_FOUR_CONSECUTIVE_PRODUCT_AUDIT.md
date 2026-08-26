# The four-consecutive product Pell unit: exact structure and the radical barrier

## Abstract

Let

\[
 s_n^2-3r_n^2=1,\qquad
 b_n=s_n^2-3,\qquad c_n=b_n+1=s_n^2-2
\]

be the fixed Pell family, and put

\[
 H_n=\log b_n+O(1)=\log c_n+O(1).
\]

The elementary identity

\[
 b(b+1)(b+2)(b+3)+1=(b^2+3b+1)^2
\]

does produce a genuine norm-one equation.  If

\[
 b_n=A_nu_n^2,\qquad c_n=B_nv_n^2
\]

with positive squarefree \(A_n,B_n\), then, with

\[
 Z_n=b_n^2+3b_n+1,\qquad D_n=3A_nB_n,
\]

one has

\[
 Z_n^2-D_n(u_nv_nr_ns_n)^2=1.                 \tag{0.1}
\]

There is more exact structure:

\[
 Z_n-1=A_n(u_ns_n)^2,\qquad
 Z_n+1=3B_n(v_nr_n)^2.                          \tag{0.2}
\]

This audit finds no unconditional coefficient-one radical estimate in this
construction.  The obstruction is precise.

* The identity is valid for every integer \(b\); by itself it adds no
  Diophantine restriction.
* The unit in (0.1) is not known to be fundamental.  Its index in the unit
  group is necessarily odd, but odd powers preserve both squarefree kernels
  in (0.2), so those two neighbor identities alone do not bound the index.
  The additional square condition (4Z+5=(2b+3)^2) is genuinely stronger;
  its exact residual Chebyshev problem is isolated in Section 2.
* Even if one grants that (0.1) is the fundamental unit, continued fractions
  or the class-number formula give only

  \[
  A_nB_n\gg {H_n^2\over(\log H_n)^2},
  \]

  hence \(\log(A_nB_n)\gg\log H_n=o(H_n)\).
* Bennett--Walsh, simultaneous Pell, fixed-support Thue--Mahler, and known
  consecutive-almost-square theorems have the right finiteness quantifiers
  only after the moving coefficients or prime support have been fixed.  They
  do not give a height bound with the required weighted-radical coefficient.

The smallest missing statement is a moving-coefficient Pell--Mahler estimate
for the distinct primes inside the square bases \(u_n,v_n\), stated exactly in
Section 8.  It is equivalent to the remaining radical estimate on this
subfamily and is not supplied by any theorem cited here.  No use is made of
`abc`, Szpiro, BSD, GRH, or another open conjecture.

## 1. Exact algebra and the two-factor radical ledger

For the rest of the note suppress the index \(n\) and write

\[
 b=Au^2,\qquad b+1=Bv^2,                         \tag{1.1}
\]

where \(A,B>0\) are squarefree.  Since \(b\) and \(b+1\) are coprime,
\(A\) and \(B\) are coprime.  Also

\[
 b\equiv1\pmod3,\qquad b+1\equiv2\pmod3,
\]

so \(3\nmid AB\).  Therefore

\[
 D=3AB                                                   \tag{1.2}
\]

is squarefree.

The last two members of the four-consecutive block are

\[
 b+2=3r^2,\qquad b+3=s^2.                         \tag{1.3}
\]

Writing \(Z=b^2+3b+1\), direct factorization gives

\[
\begin{aligned}
 Z-1&=b(b+3)=A(us)^2,\\
 Z+1&=(b+1)(b+2)=3B(vr)^2,\\
 Z^2-1&=3AB(uvrs)^2.
\end{aligned}                                      \tag{1.4}
\]

The last line is (0.1).  Its unit

\[
 \eta=Z+uvrs\sqrt D                                  \tag{1.5}
\]

has

\[
 \log\eta=2H+O(1),\qquad H=\log b+O(1).             \tag{1.6}
\]

The radical must not be confused with the parity kernels.  From (1.1),

\[
 \operatorname{rad}(b(b+1))=\operatorname{rad}(AuBv). \tag{1.7}
\]

In logarithmic form, put

\[
 K=\log(AB),\quad
 U=\log\operatorname{rad}(uv),\quad
 O=\log\gcd\bigl(AB,\operatorname{rad}(uv)\bigr).
\]

Then the exact two-factor ledger is

\[
 R:=\log\operatorname{rad}(b(b+1))=K+U-O.            \tag{1.8}
\]

The overlap term is essential.  If a prime occurs to exponent three in
\(b\), it occurs once in \(A\) and once in the support of \(u\), but only once
in the radical.

The required Pell-subfamily conclusion is

\[
 R\ge(1-\epsilon)H-O_\epsilon(1).                    \tag{1.9}
\]

Thus a lower bound for \(AB\) alone is merely a sufficient strengthening,
not an equivalent reformulation.

## 2. The unit index: even powers are excluded, odd powers remain

Let

\[
 \varepsilon=T+U_0\sqrt D>1
\]

be the fundamental positive solution of \(X^2-DY^2=1\), and write

\[
 \varepsilon^j=T_j+U_j\sqrt D.
\]

There is an integer \(k\ge1\) such that \(\eta=\varepsilon^k\), hence
\(Z=T_k\).

If \(k=2m\), the elementary Pell identity

\[
 T_{2m}+1=2T_m^2                                      \tag{2.1}
\]

says that the squarefree part of \(Z+1\) is \(2\).  But (1.4) says that it
is \(3B\), with \(3B\) squarefree.  This is impossible.  Therefore

\[
 k\ \hbox{is odd}.                                    \tag{2.2}
\]

This does not make \(k\) small.  If \(k=2m+1\), the addition formula for
Pell coordinates gives

\[
\begin{aligned}
 (T_k-1)(T-1)&=(T_{m+1}-T_m)^2,\\
 (T_k+1)(T+1)&=(T_{m+1}+T_m)^2.
\end{aligned}                                         \tag{2.3}
\]

Consequently the squarefree parts of \(T_k-1\) and \(T_k+1\) are exactly
those of \(T-1\) and \(T+1\).  Equations (1.4) therefore imply

\[
 T-1=Ax^2,\qquad T+1=3By^2                         \tag{2.4}
\]

for some integers \(x,y\).  In other words, every possible odd unit index
recycles the same two parity kernels.  No estimate for \(k\) follows from
their size.

The remaining special condition is

\[
 4T_k+5=(2b+3)^2.                                    \tag{2.5}
\]

This condition is not redundant.  To make its exact content independent of
notation, let \(\mathcal T_j(X)\) denote the first-kind Chebyshev polynomial,
so \(T_j=\mathcal T_j(T)\).  The residual equation is

\[
 y^2=4\mathcal T_k(T)+5,\qquad T>1,\quad k\ {\rm odd}. \tag{2.6}
\]

One unconditional restriction is immediate.

* If \(T\) is even, then \(\mathcal T_k(T)\) is even and the right side of
  (2.6) is \(5\pmod 8\), impossible for a square.  Hence \(T\) is odd.

There is also a conditional modulo-five restriction, but its extra premise is
not known in this system.  Suppose a prime \(p\ne5\) divides \(k\), put
\(X=\mathcal T_{k/p}(T)\), and write

\[
 y^2=4\mathcal T_p(X)+5=4XW_p(X)+5,
 \qquad W_p(X)={\mathcal T_p(X)\over X}.
\]

If one additionally knows \(5\mid X\), the congruence in Bennett--Walsh
Lemma 3.4(i) gives

\[
 W_p(X)\equiv(-1)^{(p-1)/2}p\pmod {4X},
\]

and hence the same congruence modulo \(5\).  Since \(p\ne5\), this also shows
\(5\nmid W_p(X)\).  The square equation modulo the odd integer \(W_p(X)\),
together with quadratic reciprocity, then gives

\[
 1=\left({5\over W_p(X)}\right)
  =\left({W_p(X)\over5}\right)
  =\left({(-1)^{(p-1)/2}p\over5}\right)
  =\left({5\over p}\right).                         \tag{2.7}
\]

Thus \(5\mid X\) would imply \(p\equiv\pm1\pmod5\).  Nothing above proves
\(5\mid X=\mathcal T_{k/p}(T)\), so (2.7) supplies no unconditional
restriction on the prime divisors of \(k\).

The printed Bennett--Walsh Lemma 3.4(ii) cannot be read here as an identity
with arbitrary odd denominator.  A direct Pell diagnostic is

\[
 d=5,\qquad T=9,\qquad U=4,
 \qquad 9^2-5\cdot4^2=1,\qquad p=3,
 \qquad W_3(9)=4\cdot9^2-3=321,
\]

for which

\[
 \left({321\over5}\right)=1
 \ne-1=\left({5\over3}\right).
\]

Here \(5\nmid T\).  This explicitly rules out the former unconditional use
of Lemma 3.4(ii) with denominator \(5\); only the preceding conditional
argument from Lemma 3.4(i) is retained.

The exact sufficient statement which would finish the unit-index question is

> **Chebyshev-square index proposition.**  If \(T>1\) and \(k\ge1\) is odd,
> then \(4\mathcal T_k(T)+5\) is a square only when \(k=1\).

No proof of this proposition was found in the cited Cohn, Ljunggren,
Bennett--Walsh, or Lucas-sequence literature.  In particular,
Bennett--Walsh Corollary 1.5 completely solves the different curve

\[
 y^2={\mathcal T_{2m+1}(x)\over x},
\]

but the affine-shift curve (2.6) is not a specialization of that result.
Bremner--Tzanakis fix a base index and a finite set of prime divisors in
their effective moving-parameter problem, and their Table 1 records broader
fully moving parameter/index/power problems as unresolved.  Their theorems
do not state the affine-shift proposition above.
For each fixed \(k>1\), (2.6) is an integral-point problem on a curve of
positive genus, but applying Siegel or effective hyperelliptic methods one
curve at a time is not a theorem uniform in the moving \(k\).

There is substantial but strictly finite computational evidence.  Exact
integer recurrence and integer-square-root checks gave no solution with
\(k>1\) in either of the following boxes:

\[
\begin{array}{c|c|c}
\text{input box}&\text{odd indices}&\text{number of tested pairs}\\ \hline
2\le T\le200000&1\le k\le101&10{,}199{,}949\\
2\le D\le10000,\ D\text{ squarefree},\ T=T(D)
  &1\le k\le101&310{,}182.
\end{array}                                          \tag{2.8}
\]

Here \(T(D)\) was computed by the continued-fraction algorithm for the
fundamental solution of \(X^2-DY^2=1\).  The second box contained 36 hits,
all at \(k=1\); the first contained 445 hits, again all at \(k=1\).  This is
not used as an unbounded certificate or as a proof of the proposition.

Thus (2.5) may ultimately force \(k=1\), and it must not be omitted from the
route.  At present the only unconditional conclusion here is oddness; (2.7)
applies only after the additional divisibility \(5\mid\mathcal T_{k/p}(T)\)
has been proved and gives no uniform index bound.  Even a proof of the
displayed proposition would lead only to the subcritical estimate of Section
3 and would not establish (1.9).

There is also a strict generic counterexample to using only the existence of
the unit and the two neighbor kernels: in any fixed real quadratic field,
the odd powers \(\varepsilon^{2m+1}\) have unbounded height while the
discriminant stays fixed, and (2.3) shows that the two squarefree neighbor
kernels stay fixed as well.  These generic powers need not satisfy (2.5), so
they are not counterexamples to the full four-consecutive system.  They prove
only that a discriminant lower bound cannot follow from (0.1) and (0.2)
without using the fourth condition or another bounded-index theorem.

## 3. Even a fundamental-unit theorem is subcritical

Suppose, more strongly than is presently known, that \(k=1\).  The standard
continued-fraction bound for a real quadratic fundamental unit is

\[
 \log\varepsilon_D\ll\sqrt D\log D.                 \tag{3.1}
\]

The real quadratic class-number formula gives the same square-root scale,
with sharper constants when local character information is retained.  Since
\(\log\eta=2H+O(1)\), monotone inversion of (3.1) yields only

\[
 D\gg {H^2\over(\log H)^2}.                         \tag{3.2}
\]

Using \(D=3AB\), this becomes

\[
 \log(AB)\ge2\log H-2\log\log H-O(1)=o(H).          \tag{3.3}
\]

Genus theory can multiply the class number by a power of two depending on
\(\omega(D)\), but \(2^{\omega(D)}=D^{o(1)}\).  It does not change the
square-root scale in (3.1).  Therefore proving that (1.5) is fundamental
would be genuine rigidity, but it would not prove the radical coefficient.

## 4. What Bennett--Walsh actually gives here

There is a second exact Pell equation.  From

\[
 (b+1)^2-b(b+2)=1
\]

and (1.1)--(1.3),

\[
 B^2v^4-3A(ur)^2=1.                                 \tag{4.1}
\]

Bennett and Walsh, Theorem 1.2, state that for fixed squarefree integers
\(q,d>1\), there is at most one index \(j\) for which the first Pell
coordinate \(T_j\) equals \(qx^2\); if it exists, the index is the
divisibility index \(\alpha(q)\).  Applied to (4.1), this gives uniqueness for
the fixed pair

\[
 q=B,\qquad d=3A,                                    \tag{4.2}
\]

Here \(B>1\): otherwise \(s^2-v^2=2\), which has no integral solution;
also \(3A>1\) and \(3A\) is squarefree.  Thus the hypotheses really are
satisfied on the positive Pell family.  The theorem identifies the index as
\(\alpha(B)\), but it does not bound
\(\alpha(B)\), \(A\), \(B\), or the radical of \(uv\) when \(A,B\) move.

Their Proposition 2.1 is equally instructive: for fixed positive
\((a_1,a_2,a_3)\), at most one integer \(N\) can satisfy

\[
 (N-1,N,N+1)=(a_1x^2,a_2y^2,a_3z^2).               \tag{4.3}
\]

Taking the consecutive triple \((b,b+1,b+2)\) gives uniqueness after
\((A,B,3)\) is fixed.  This is a count, not a height estimate.  An injective
map from Pell indices to moving pairs \((A,B)\) does not imply a pointwise
lower bound for \(A_nB_n\), because the pairs need not occur in numerical
order.

The neighboring companion \(c=Bv^2\) has the stronger identity

\[
 (c+1)^2-B(vs)^2=1,
\]

where \(c+1=3r^2\).  Bennett--Walsh with the fixed coefficient \(3\), plus
the elementary modulo-three argument recorded in the separate fundamental-unit
audit, does identify that unit as fundamental.  Section 3 explains why even
this stronger result remains subcritical.

## 5. Simultaneous Pell and consecutive almost squares

The full adjacent system is

\[
\begin{aligned}
 Bv^2-Au^2&=1,\\
 3r^2-Bv^2&=1,\\
 s^2-3r^2&=1.
\end{aligned}                                       \tag{5.1}
\]

This is the only genuinely special input beyond the universal product
identity.  The quantifiers in the accepted simultaneous-Pell theorems do not
match the desired conclusion:

* Bennett--Cipu--Mignotte--Okazaki prove an absolute bound of two positive
  solutions for the standard pair of simultaneous Pell equations when the
  two nonsquare coefficients are fixed and distinct.
* Earlier work of Masser--Rickert and Bennett gives solution-count and gap
  principles for fixed coefficients; Bennett also constructs infinite moving
  families having two solutions.
* A bound on the number of solutions for each fixed \((A,B)\) does not bound
  the size of its unique solution in terms of the weighted radical of
  \(AuBv\).

The consecutive-almost-square literature makes the scale mismatch explicit.
Let \(\operatorname{sfp}(m)\) be the squarefree part of \(m\), and let

\[
 \lambda_{N,k}(m)=\max_{0\le i<N}\omega_k(m-i)
\]

in the notation of de Weger--van de Woestijne.

1. Their Theorem 1.1(iii) gives infinitely many consecutive pairs with
   \(\lambda_{2,2}\le2\), using \(x^2-2y^2=1\).  Thus no lower bound for
   two moving squarefree kernels follows from consecutiveness alone.
2. For \(N\ge3\) and \(k=2\), the unconditional theorem they quote from
   Turk gives only

   \[
   \lambda_{N,2}(m)>(\log m)^{0.04}
   \]

   for sufficiently large \(m\).
3. Their quantitative Thue theorem, Theorem 1.3, assumes \(k\ge3\).  The
   paper explicitly notes that the Thue estimate used in its proof does not
   cover \(k=2\).
4. Rouse--Yang prove that for each fixed triple \((A,B,C)\) the associated
   integral problem can be reduced to integral points on
   \(Y^2=X^3-(ABC)^2X\), and they classify bounded triples computationally.
   They also construct infinitely many triples of consecutive integers whose
   three squarefree parts are all below the one-third power.  Their family
   does not satisfy the fixed final branches in (1.3), so it is not a
   counterexample to this Pell orbit; it is a strict warning that moving
   almost-square coefficients do not themselves yield a coefficient-one
   theorem.

## 6. Fixed-support Thue--Mahler does not survive moving support

For a fixed finite set of primes \(S\), an \(S\)-unit or Thue--Mahler theorem
does give finiteness.  Bugeaud--Levesque--Waldschmidt, Theorems 2.1 and 2.2,
fix the two quadratic forms and the prime set

\[
 S=\{p_1,\ldots,p_s\}
\]

before asserting finitely many \(S\)-equivalence classes or finitely many
solutions; their displayed solution-count bound depends on the number of
prime divisors of the fixed coefficients together with \(p_1\cdots p_s\).

For the Pell sequence the set

\[
 S_n=\{p:p\mid b_n(b_n+1)\}
\]

moves with \(n\).  Moreover, the required budget is the weighted quantity

\[
 \sum_{p\in S_n}\log p,
\]

not merely \(|S_n|\).  Taking a union of fixed-\(S\) finiteness statements
loses both the constants and the required weight.  No fixed-support theorem
cited above gives (1.9) uniformly over these moving sets.

## 7. Frey and generalized-Fermat translation

The first three equations of the block have the standard congruent-number
curve attached to them.  Put

\[
 N=3AB,\qquad
 E_N:Y^2=X^3-N^2X.                                  \tag{7.1}
\]

Then (1.1)--(1.3) give the integral point

\[
 X=N(b+1),\qquad Y=N^2uvr.                           \tag{7.2}
\]

Indeed,

\[
 X^3-N^2X=N^3(b+1)b(b+2)=N^4(uvr)^2=Y^2.           \tag{7.3}
\]

For fixed \(N\), Siegel's theorem gives finitely many integral points, and
effective Baker methods can in principle bound them after the Mordell--Weil
data are controlled.  Here \(N=3AB\) moves.  The known bounds have constants
depending on \(N\) and do not give

\[
 h(X)\le(1+o(1))\log\operatorname{rad}(AuBv).        \tag{7.4}
\]

Modularity does not alter this quantifier.  Equations (5.1) have exponent
two; after high prime powers inside \(u,v\) are extracted, both the
coefficients and the levels move.  Fixed-signature generalized-Fermat
theorems therefore do not cover the mixed exponent profile.  A uniform
integral-point height/conductor inequality strong enough to imply (7.4)
would be a new radical-height theorem of the same critical strength as the
target.  Invoking Szpiro or `abc` at this step would be circular.

## 8. Strict method barriers and the smallest missing proposition

### 8.1 An actual squarefree-kernel barrier

The Pell family from de Weger--van de Woestijne's \(N=k=2\) case consists
of actual coprime consecutive factors, each of the same logarithmic height,
whose squarefree kernels are the fixed numbers \(1\) and \(2\).  The universal
four-product identity holds for every member.  This does not satisfy the
special last two branches (1.3), and it says nothing by itself about the
radicals of the square bases.  Its exact conclusion is narrower:

> The product identity, coprimality, two correct factor heights, and bounded
> squarefree kernels cannot by themselves yield the desired radical bound.

### 8.2 A component-correct conditional exponent profile

There is also a scalar obstruction to replacing the missing arithmetic by a
nonnegative exponent ledger.  Let each of the two factors have logarithmic
height \(H\), and put \(w=H/3\).  Give each factor one disjoint abstract cube
carrier of prime-log weight \(w\).  Then

\[
 \log b=\log(b+1)=3w=H,
\]

while the total radical and parity-kernel weights are both

\[
 R=K=2w={2H\over3}.                                  \tag{8.1}
\]

The product-unit size remains exactly consistent.  Half of the parity-kernel
weight contributes \(w\), the two square bases contribute \(2w\), and the
two auxiliary square branches contribute \(3w\); their sum is

\[
 w+2w+3w=6w=2H,                                      \tag{8.2}
\]

the height in (1.6).  Nevertheless (1.9) fails for every
\(\epsilon<1/3\).

This is not asserted to be an integral solution of (5.1), much less an actual
Pell index.  It proves exactly that factor heights, coprimality, parity kernels,
and the archimedean size of (0.1) leave a coefficient gap.  A successful proof
must use new same-index arithmetic of (5.1).

### 8.3 The smallest missing proposition

By the exact identity (1.8), the minimum new statement in this
squarefree/square-base language is the following.

> **Moving-coefficient Pell--Mahler base-radical proposition.**  For every
> \(\epsilon>0\), there is a constant \(C_\epsilon\) such that every member
> of the fixed Pell orbit, written as in (1.1), satisfies
>
> \[
> \boxed{
> \log\operatorname{rad}(u_nv_n)
> -\log\gcd\!\left(A_nB_n,
>                   \operatorname{rad}(u_nv_n)\right)
> \ge (1-\epsilon)H_n-\log(A_nB_n)-C_\epsilon.}
>                                                               \tag{8.3}
> \]

Adding \(\log(A_nB_n)\) to (8.3) gives (1.9) immediately and with no loss.
Conversely, (1.9) and (1.8) give (8.3), so this proposition is not a hidden
strengthening.  It is the exact missing base-radical mass.

The stronger squarefree-only statement

\[
 \log(A_nB_n)\ge(1-\epsilon)H_n-O_\epsilon(1)        \tag{8.4}
\]

would also suffice, but none of the audited regulator, Bennett--Walsh,
simultaneous Pell, Thue--Mahler, Frey, or almost-square results approaches
its linear scale.

## 9. Formal companion

`IUTThreeClosures/FreyPellFourConsecutiveProductAudit.lean` proves only:

1. the universal four-consecutive product identity;
2. the additional square identity \(4Z+5=(2b+3)^2\);
3. the norm-one equation (0.1);
4. the adjacent system (5.1) and neighbor identities (0.2);
5. the Bennett--Walsh-shaped quartic equation (4.1);
6. the exact scalar radical/base-overlap bridge; and
7. the two-factor, height-correct conditional cube profile (8.1)--(8.2).

It does not formalize or assume squarefree factorization, radicals, Pell-unit
index theorems, continued fractions, Bennett--Walsh, simultaneous Pell,
Thue--Mahler, elliptic curves, modularity, or (8.3).  No unproved arithmetic
statement is introduced as a Lean axiom.

## References

* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proc. Amer. Math. Soc. 127 (1999), 3481--3491.
  Theorem 1.2 and Proposition 2.1 are used with their fixed-coefficient
  quantifiers; Lemma 3.4(i) supplies only the conditional congruence used in
  (2.7), while the printed Lemma 3.4(ii) is not used and its failed arbitrary-
  denominator reading is diagnosed in Section 2.  Corollary 1.5 is explicitly
  distinguished from (2.6):
  <https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf>.

* A. Bremner and N. Tzanakis, *Lucas sequences whose nth term is a square
  or an almost square*, Acta Arith. 126 (2007), 261--280.  The fixed
  parameter/index/support quantifiers and the unresolved fully moving case
  are stated in the introduction and Table 1:
  <https://www.impan.pl/shop/publication/transaction/download/product/83425>.

* M. A. Bennett, M. Cipu, M. Mignotte and R. Okazaki, *On the number of
  solutions of simultaneous Pell equations, II*, Acta Arith. 122 (2006),
  407--417.  The theorem bounds the number of positive solutions for fixed
  distinct coefficients:
  <https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/122/44/82060/on-the-number-of-solutions-of-simultaneous-pell-equations-ii>.

* D. W. Masser and J. H. Rickert, *Simultaneous Pell equations*, J. Number
  Theory 61 (1996), 52--66, DOI 10.1006/jnth.1996.0137.

* B. M. M. de Weger and C. E. van de Woestijne, *On the power-free parts of
  consecutive integers*, Acta Arith. 90 (1999), 387--395.  Theorem 1.1(iii),
  Theorem 1.2, and the explicit exclusion of \(k=2\) from the Thue argument
  are the precise scope statements used above:
  <https://deweger.net/papers/%5B31%5DvdWdW-PowFree-ActaArith%5B1999%5D.pdf>.

* J. Turk, *Almost powers in short intervals*, Arch. Math. (Basel) 43
  (1984), 157--166.  The quoted \(k=2\) logarithmic lower bound is stated as
  Theorem 1.2 in the preceding de Weger--van de Woestijne paper.

* J. Rouse and Y. Yang, *Three consecutive almost squares*, Int. J. Number
  Theory 12 (2016), 969--978:
  <https://arxiv.org/abs/1502.00605>.

* Y. Bugeaud, C. Levesque and M. Waldschmidt, *Equations de
  Fermat--Pell--Mahler simultanees*, Publ. Math. Debrecen 79 (2011),
  357--366, DOI 10.5486/PMD.2011.5192.  Theorems 2.1 and 2.2 fix the forms
  and the prime set before asserting finiteness:
  <https://publi.math.unideb.hu/load_doc.php?p=1639&t=pap>.

* K. Aktas and M. R. Murty, *Fundamental units and consecutive squarefull
  numbers*, Int. J. Number Theory 13 (2017), 243--252.  This paper records
  both the Pell construction of consecutive powerful pairs and the need for
  `abc` in the stronger radical direction:
  <https://mast.queensu.ca/~murty/fundamental-units.pdf>.
