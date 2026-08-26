# Adaptive pair-square selectors on the Frey curve

**Author: ChatGPT**

## Abstract

Let

\[
E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

where \(a,b,c\) are positive and pairwise coprime. An arbitrary bounded
integral abscissa gives a quadratic point whose field discriminant is at
most \(O(c^2)\). This note gives a different, genuinely adaptive
construction. For an integer \(k\), use one of

\[
ka,\qquad -kb,\qquad a+(k-1)c.
\]

In each case two of the three factors in the cubic contain the square of
one of \(a,b,c\). After a weighted CRT selection of \(k\), uniform
boundedness of degree-two torsion gives a non-torsion quadratic point for
which

\[
|D|\ll_\delta c,\qquad
|\operatorname {Disc}\mathbf Q(\sqrt D)|\ll_\delta c.
\]

Here \(D\) is the signed squarefree part of the cubic value. The price is
an unavoidable component loss: the construction retains all but a
\((1/3+\delta)\)-fraction of the total odd multiplicative-depth mass. Its
normalized odd local-height contribution is consequently at least

\[
\frac{1-3\delta}{12}
\sum_{p\mid abc,\ p\ne2}v_p(abc)\log p.
\]

This improves the discriminant exponent of the bounded-abscissa selector
from two to one, but it still does not prove abc. A simultaneous CRT
family shows that every fixed finite coefficient universe for these three
pair-square families incurs a positive source-height conductor and
discriminant cost. Letting \(k\) grow survives this counterexample, but
then one must force a large square divisor of a varying cubic value. We
explain precisely why ordinary squarefree sieves, average twist-rank
theorems, and \(S\)-unit technology do not supply that transposed
quantifier, and where an appeal to abc or Hall--Lang would be circular.

## 1. Local geometry and notation

Put

\[
f_{a,b}(X)=X(X-a)(X+b).
\]

For every odd \(p\mid abc\), primitivity says that \(p\) divides exactly
one of \(a,b,c\). The unique singular abscissa of the reduced cubic is

\[
\nu_p=
\begin{cases}
0,&p\mid a,\\
0,&p\mid b,\\
a\equiv-b,&p\mid c.
\end{cases}
\tag{1.1}
\]

An integral abscissa different from \(\nu_p\) gives a smooth section, hence
a point in the identity component of the Néron model. This remains true
after every finite extension of \(\mathbf Q_p\).

Write

\[
W_a=\sum_{\substack{p\mid a\\p\ne2}}v_p(a)\log p,
\quad
W_b=\sum_{\substack{p\mid b\\p\ne2}}v_p(b)\log p,
\quad
W_c=\sum_{\substack{p\mid c\\p\ne2}}v_p(c)\log p,
\tag{1.2}
\]

and \(W=W_a+W_b+W_c\). Thus \(W\) is the complete odd
multiplicative-depth mass, including both exponent excess and one copy of
the radical.

## 2. The three pair-square identities

For \(k\ge2\), define

\[
\begin{aligned}
j_a(k)&=ka,\\
j_b(k)&=-kb,\\
j_c(k)&=a+(k-1)c.
\end{aligned}
\tag{2.1}
\]

Direct multiplication gives

\[
\begin{aligned}
f_{a,b}(j_a(k))
 &=a^2k(k-1)(ka+b),\\
f_{a,b}(j_b(k))
 &=-b^2k(k-1)(a+kb),\\
f_{a,b}(j_c(k))
 &=c^2k(k-1)\bigl(a+(k-1)c\bigr).
\end{aligned}
\tag{2.2}
\]

Consequently their signed squareclasses are represented by

\[
\begin{aligned}
G_a(k)&=k(k-1)(ka+b),\\
G_b(k)&=-k(k-1)(a+kb),\\
G_c(k)&=k(k-1)\bigl(a+(k-1)c\bigr).
\end{aligned}
\tag{2.3}
\]

These are not accidental specializations. If \(j=ua+vb\) is a linear
form and two factors among \(j,j-a,j+b\) are universally divisible by the
same one of \(a,b,c\), then, up to reparametrizing the coefficient, one is
in exactly one of the following cases:

* \(v=0\), so \(j=ua\);
* \(u=0\), so \(j=vb\);
* \(u=v+1\), so \(j=a+v(a+b)\).

This elementary classification explains the three rows of (2.1).

The local collision table is equally rigid:

| family | always singular | first remaining collision | second remaining collision |
|---|---:|---:|---:|
| \(j_a(k)\) | \(p\mid a\) | \(p\mid b,\ k\equiv0\) | \(p\mid c,\ k\equiv1\) |
| \(j_b(k)\) | \(p\mid b\) | \(p\mid a,\ k\equiv0\) | \(p\mid c,\ k\equiv1\) |
| \(j_c(k)\) | \(p\mid c\) | \(p\mid a,\ k\equiv1\) | \(p\mid b,\ k\equiv0\) |

All congruences in the table are modulo \(p\). For example, if \(p\mid
c\), then \(j_a(k)\equiv ka\), whereas the singular residue is \(a\);
since \(a\) is a unit, collision is equivalent to \(k\equiv1\).

## 3. Weighted CRT selection after sacrificing one component

We use the following elementary selector. It is the owner-counting
principle for bounded abscissas, now applied to the coefficient \(k\).

### Lemma 3.1

Let \(S\) be a finite set of primes, give \(p\in S\) a residue
\(\rho_p\in\mathbf F_p\) and a weight \(w_p\ge0\), and let \(L\ge2\).
There are \(L\) distinct positive integers

\[
k_t=r+M(t+1),\qquad 0\le t<L,
\tag{3.1}
\]

with \(M=\prod_{q\le L}q\) and \(0\le r<M\), such that

\[
\sum_{t=0}^{L-1}
\sum_{\substack{p\in S\\k_t\equiv\rho_p\ (p)}}w_p
\le\sum_{p\in S}w_p.
\tag{3.2}
\]

#### Proof

For each \(q\le L\) that belongs to \(S\), prescribe \(r\) modulo \(q\)
to be different from \(\rho_q\); prescribe any residue for the other small
primes. The CRT supplies \(r\). If \(p>L\), then \(p\nmid M\), and two
collisions would give \(p\mid M(t-u)\). Since \(|t-u|<L<p\), they must be
the same row. Thus every label has at most one owner, and summing first by
labels proves (3.2). The shift by \(M\) makes every \(k_t\ge2\).
\(\square\)

Let \(B_{\le2}\) be a uniform bound for the order of torsion points over
number fields of degree at most two, and put

\[
T_2=\sum_{n=1}^{B_{\le2}}n^2.
\tag{3.3}
\]

For a fixed elliptic curve, all degree-at-most-two torsion points belong to
\(\bigcup_{n\le B_{\le2}}E[n]\). Hence at most \(T_2\) distinct rational
abscissas can produce such torsion points. Merel's theorem supplies the
required uniform bound; the precise numerical value is irrelevant here.

### Theorem 3.2 (adaptive linear-discriminant selector)

For every \(\delta>0\) there is \(H_\delta\) such that every primitive
positive triple \(a+b=c\) admits an integer \(k\), one of the three
abscissas \(j=j_a(k),j_b(k),j_c(k)\), a field \(K\) of degree at most two,
and a non-torsion point

\[
P=(j,\sqrt{f_{a,b}(j)})\in E_{a,b}(K)
\tag{3.4}
\]

with

\[
2\le k\le H_\delta,\qquad |j|\le H_\delta c.
\tag{3.5}
\]

If \(B\) denotes the sum of \(v_p(abc)\log p\) over odd bad primes at
which the selected point is not certified to lie in the identity
component, then

\[
B\le\left(\frac13+\delta\right)W.
\tag{3.6}
\]

If \(D\) is the signed squarefree part of \(f_{a,b}(j)\), then

\[
|D|\le H_\delta^3c,\qquad
|\operatorname {Disc}\mathbf Q(\sqrt D)|\le4H_\delta^3c.
\tag{3.7}
\]

#### Proof

Choose \(m\in\{a,b,c\}\) with \(W_m\le W/3\), and use the corresponding
row of (2.1). Remove the primes dividing \(m\); their full weight is the
unavoidable loss \(W_m\). Every remaining bad prime has exactly one bad
coefficient residue, either zero or one, by the collision table.

Choose \(L>T_2\) with \(1/(L-T_2)\le\delta\), and apply Lemma 3.1 to these
remaining primes with weight \(v_p(abc)\log p\). The abscissas within the
chosen family are distinct. At most \(T_2\) rows can be torsion, so at
least \(L-T_2\) rows survive. Restricting (3.2) to the surviving rows,
one has residual collision mass at most

\[
\frac{W}{L-T_2}\le\delta W.
\]

Together with \(W_m\le W/3\), this proves (3.6). Smooth reduction gives
the identity-component assertion at every other odd bad prime.

The CRT construction bounds \(k\) solely in terms of \(L\), hence solely
in terms of \(\delta\). Equations (2.1) give (3.5). For every row of
(2.3), positivity of \(a,b,c\) and \(k\ge2\) gives

\[
|G_m(k)|\le k^2(k-1)c<k^3c.
\]

The squarefree representative divides \(G_m(k)\), proving (3.7).
\(\square\)

The use of the union of all degree-two torsion points is important. A
separate torsion count in each of the varying quadratic fields would not
justify removing only \(T_2\) rows.

## 4. Local height and conductor ledger

At an odd bad prime, the Frey curve has type \(I_{2v_p(abc)}\). With local
heights normalized over \(K\), an identity-component point contributes

\[
\frac{v_p(abc)}6\log p,
\]

while the Bernoulli term on an arbitrary component is bounded below by
\(-v_p(abc)\log p/12\). Hence Theorem 3.2 gives

\[
\begin{aligned}
\sum_{\substack{p\mid abc\\p\ne2}}\Lambda_p(P)
&\ge \frac{W-B}{6}-\frac{B}{12}\\
&=\frac{2W-3B}{12}\\
&\ge\frac{1-3\delta}{12}W.
\end{aligned}
\tag{4.1}
\]

The coefficient remains unchanged after ramified base change because the
sum of ramification-degree times residue-degree over \(p\) is
\([K:\mathbf Q]\).

The associated rational twist point is

\[
Q=(Dj,D^2s)\in E^D(\mathbf Q),
\qquad
E^D:Y^2=X(X-Da)(X+Db),
\tag{4.2}
\]

where \(f_{a,b}(j)=Ds^2\). At odd primes at least five, Tate's algorithm
gives

\[
N_{\ge5}(E^D)=
\frac{\operatorname {rad}_{\ge5}(abc)}
{\gcd(\operatorname {rad}_{\ge5}(abc),|D|)}
\operatorname {rad}_{\ge5}(D)^2.
\tag{4.3}
\]

The exponents at two and three are absolutely bounded. Thus

\[
\log N(E^D)
\le\log\operatorname {rad}(abc)+2\log c+O_\delta(1).
\tag{4.4}
\]

Compared with a generic bounded abscissa, (3.7) saves one full copy of
\(\log c\) in the quadratic discriminant and two copies in the coarse
twist-conductor estimate. Nevertheless, (4.4), the archimedean local
height, and the height of the twist point all still have source-height
scale. Equation (4.1) alone therefore does not imply abc.

## 5. A fixed coefficient universe still has source-height cost

The linear bound (3.7) is sharp in the only sense accessible by a uniform
finite construction: one cannot replace it by \(c^{o(1)}\) for a fixed
finite list of coefficients.

### Theorem 5.1

Let \(\mathcal K\subset\mathbf Z_{\ge2}\) be finite and nonempty. There are
infinitely many primitive triples

\[
(a,b,c)=(1,b,b+1)
\]

such that, for every \(k\in\mathcal K\) and every one of the three
pair-square families, the squarefree carrier contains an odd prime
\(q_{m,k}\) satisfying all of the following:

1. \(q_{m,k}\nmid b(b+1)\), so it is a good prime for \(E_{1,b}\);
2. \(v_{q_{m,k}}(G_m(k))=1\), hence \(q_{m,k}\mid D_{m,k}\);
3. the twist has conductor exponent two at \(q_{m,k}\);
4. if \(M_0=3\#\mathcal K\), then

\[
2\log q_{m,k}\ge
\frac{1}{2M_0}\log c-O_{\mathcal K}(1);
\tag{5.1}
\]

5. the exponent-excess mass of \(b\) is at least

\[
\frac12\log c-O_{\mathcal K}(1).
\tag{5.2}
\]

#### Proof

For a large \(Q\), choose \(M_0\) distinct primes \(q_{m,k}\ge Q\), all
larger than every prime dividing
\(\prod_{k\in\mathcal K}k(k-1)\), and all at most \(2^{M_0}Q\). Repeated
Bertrand intervals suffice. Assign one prime to each ordered pair
\((m,k)\), and impose the following congruences modulo its square:

\[
\begin{array}{rcll}
b&\equiv&q_{a,k}-k&\pmod {q_{a,k}^2},\\
1+kb&\equiv&q_{b,k}&\pmod {q_{b,k}^2},\\
k+(k-1)b&\equiv&q_{c,k}&\pmod {q_{c,k}^2}.
\end{array}
\tag{5.3}
\]

The last two linear congruences are solvable because the assigned prime
divides neither \(k\) nor \(k-1\). Let

\[
M=\prod_{m,k}q_{m,k}^2
\]

and choose \(n\) with \(M\le3^n<3M\). Add the congruence
\(b\equiv0\pmod {3^n}\). All moduli are coprime, so the CRT gives a
positive representative

\[
0<b<3^nM<3M^2.
\tag{5.4}
\]

The three displayed linear factors are congruent to \(q_{m,k}\) modulo
\(q_{m,k}^2\), so their valuations are exactly one. Modulo the assigned
prime, the three corresponding values of \(b\) are respectively

\[
-k,\qquad -k^{-1},\qquad -k(k-1)^{-1}.
\]

Neither these residues nor the residues obtained after adding one are
zero. Thus every \(q_{m,k}\) is a good prime, and it does not divide the
prefactor \(k(k-1)\). This proves assertions 1--3.

Since \(M_0\) is fixed,

\[
M\le(2^{M_0}Q)^{2M_0},
\qquad
c<3M^2+1.
\]

Therefore \(\log Q\ge(4M_0)^{-1}\log c-O_{\mathcal K}(1)\), which proves
(5.1). Finally \(v_3(b)\ge n\), and (5.4) gives

\[
(n-1)\log3\ge\log M-O(1)
\ge\frac12\log c-O_{\mathcal K}(1),
\]

proving (5.2). Letting \(Q\) grow yields infinitely many distinct
triples. \(\square\)

Theorem 5.1 is a counterexample to a fixed-coefficient sublinear
discriminant or conductor refinement. Its exponent deteriorates with
\(\#\mathcal K\), so it does not rule out a genuinely unbounded adaptive
coefficient.

## 6. Audit of explicit algebraic choices

Several useful identities occupy different points of a rigid tradeoff.

### 6.1 Full local avoidance with a cubic-size carrier

The abscissa \(j=a-b\) satisfies

\[
f_{a,b}(a-b)=-ab(a-b).
\tag{6.1}
\]

It avoids the singular residue at every odd bad prime: on the \(a\)- and
\(b\)-supports it reduces to the other simple root, while on the
\(c\)-support it reduces to \(2a\ne a\). However its squarefree carrier
can be as large as \(O(c^3)\), and a single point is not uniformly
non-torsion.

### 6.2 Linear-size carrier with one sacrificed component

Equations (2.2) are the favorable unconditional compromise. They reduce
the carrier to \(O_\delta(c)\) and make non-torsion selectable, but the
chosen root difference is singular at every prime on one of the three
supports. Averaging shows that \(1/3\) is the structural loss for these
three families.

### 6.3 Rational conic parametrization

Making \(x(x-a)\) a rational square gives

\[
x=\frac{a}{1-t^2}.
\tag{6.2}
\]

Writing \(t=(a-u)/(a+u)\) yields

\[
x=\frac{(a+u)^2}{4u},\qquad
x-a=\frac{(a-u)^2}{4u}.
\tag{6.3}
\]

If \(u=s^2\), both factors are rational squares and the remaining
squareclass is represented by

\[
(a+s^2)^2+4bs^2.
\tag{6.4}
\]

This can avoid the entire \(a\)-support when \(s\) is a unit there, but
the carrier is generically \(O(c^2)\). Forcing (6.4) to have a much
larger square factor is again an integral-point problem, not a free
parametrization.

### 6.4 Forcing the last linear factor to be a square

For the \(a\)-family, asking \(ka+b=d z^2\) is a quadratic congruence and
divisibility problem. Even when it is solvable, the remaining factor
\(k(k-1)d\) need not be small. Requiring simultaneous cancellation in
both \(k(k-1)\) and \(ka+b\) is precisely a rational/integral point problem
on a quadratic twist of the original cubic. The algebra has returned to
the problem it was meant to solve.

## 7. Why the ordinary squarefree sieve points the wrong way

Fix \(a,b\). Classical cubic squarefree-value theorems study coefficients
\(k\) for which

\[
k(k-1)(ka+b)
\]

has no repeated prime factor. On those values the squarefree part is the
entire carrier. For large positive \(k\) it has size comparable to
\(ak^3\), so such a theorem maximizes rather than minimizes the quadratic
discriminant.

More quantitatively, write a positive carrier as

\[
G_m(k)=D_m(k)s_m(k)^2,
\tag{7.1}
\]

with \(D_m(k)\) squarefree. Each of the three positive absolute carriers
is at least \(k(k-1)c\). Therefore a target

\[
D_m(k)\le c^{1-\varepsilon}
\]

forces

\[
s_m(k)^2\ge k(k-1)c^\varepsilon.
\tag{7.2}
\]

Thus the needed input is a **large-square-divisor sieve**, uniformly for a
cubic whose coefficients and discriminant vary with the abc triple.
Hooley-type or Greaves-type squarefree sieves prove the complementary
event. Their fixed-polynomial constants also do not supply uniformity
when the modulus used for local avoidance contains the moving bad-prime
support.

Stewart--Top specialization results similarly produce many distinct
squarefree twist parameters with positive rank. In the present setting
positive rank is already automatic for all but uniformly many candidate
abscissas. The missing conclusion is a least small squareclass with the
prescribed local behavior, and distinct-value lower bounds do not imply
it.

## 8. Quadratic twists, integral points, and averages

Equation (7.1) is equivalent to the explicit integral twist point (4.2).
For fixed \(D\), finding such \(j\) is an integral-point problem on an
elliptic curve. Conversely, a general rational point on \(E^D\) need not
have \(X\in D\mathbf Z\) and \(Y\in D^2\mathbf Z\), so even positive rank
does not give an integral selector of the required form.

This separates three quantifiers that are often conflated:

1. for a fixed curve, many twists have positive rank;
2. for a fixed curve, some small twist has an integral point;
3. uniformly for the moving Frey curve, a twist of size \(c^{1-\varepsilon}\)
   has a specially divisible integral point satisfying many local
   conditions.

Only the first is addressed by rank averages and twist specialization.
Even counting twists that possess arbitrary integral points is delicate;
recent scarcity results use Hall--Lang in the partial-rational-\(2\)-torsion
case. No known average theorem supplies the third, moving-curve
quantifier.

The rank-zero Frey curve attached to \((1,8,9)\) already disproves the
naive fixed choice \(D=1\). The values \(k=0,1\) in (2.2) are a still more
elementary warning: the attractive cancellations then give only rational
\(2\)-torsion.

## 9. The exact \(S\)-unit reduction and the circularity boundary

Let \(S\) contain the primes dividing \(abcD\). In the \(a\)-family, the
three factors

\[
k,\qquad k-1,\qquad ka+b
\tag{9.1}
\]

have pairwise gcds dividing respectively \(1,b,c\). Hence outside \(S\)
they are pairwise coprime. If their product is a square outside \(S\),
then each factor is separately a square outside \(S\). Equivalently,

\[
k=u_0r_0^2,\qquad
k-1=u_1r_1^2,\qquad
ka+b=u_2r_2^2,
\tag{9.2}
\]

where each \(u_i\) is an \(S\)-unit squareclass. In particular

\[
u_0r_0^2-u_1r_1^2=1.
\tag{9.3}
\]

The other two orientations give the same system after permuting
\(a,b,c\). This is an exact reduction, not an analogy: a selector whose
new squarefree support is controlled is a solution of a family of
\(S\)-unit-weighted Pell/Thue equations, together with the third linear
constraint in (9.2).

Classical \(S\)-unit theorems give finiteness for fixed \(S\), and effective
bounds depend on the full set \(S\), its primes, and the coefficients.
They do not assert existence of a solution with a small enlargement of a
moving \(S=\operatorname {supp}(abc)\). Treating “solve the \(S\)-unit
equation” as a black-box existence lemma would therefore merely rename the
missing theorem.

There is also a clean circularity test. Granville's twist-point bounds use
abc, and Hall--Lang is itself a conjectural uniform height bound for
integral points. Either may be useful for predicting the distribution of
(7.1), but importing it into an abc proof cannot be counted as an
unconditional advance. We do **not** claim that the adaptive selector is
known equivalent to abc or to Hall--Lang. What is proved is narrower:
the relevant Diophantine system is exactly an integral-twist/\(S\)-unit
system, and the strongest general uniform bounds currently invoked for
such systems are conditional on conjectures at least as deep as the target.

## 10. Surviving route

The unconditional frontier is now precise.

* The existence and local-component problem is solved with arbitrarily
  small loss if one accepts \(O(c^2)\) field discriminant.
* Pair-square adaptation improves the field discriminant to \(O(c)\), with
  a structural \(1/3\) local loss.
* Every fixed finite coefficient universe has a source-height lower
  obstruction at a new good prime.
* An unbounded coefficient remains logically open, but must create the
  large square divisor (7.2) while satisfying weighted residue avoidance.

A genuine next theorem would therefore have to prove, uniformly in
primitive \(a+b=c\), that one of the three carriers in (2.3) has unusually
large square part and controlled new prime support for some moderately
sized \(k\). Ordinary squarefree sieves, twist-rank averages, fixed-\(S\)
unit equations, and conjectural integral-height bounds do not establish
this statement.

## 11. Lean boundary

The companion module
IUTThreeClosures/AdaptiveLinearPairSquareSelector.lean formalizes:

1. all three pair-square polynomial identities;
2. the one-of-three \(1/3\) averaging lemma;
3. the survivor-average scalar ledger;
4. the exact retained local-height coefficient \((1-3\delta)/12\);
5. linear carrier bounds for bounded coefficients.

It does not formalize elliptic curves, Néron models, Merel's theorem, the
CRT construction, squarefree kernels, Tate's algorithm, or the infinite
CRT obstruction of Theorem 5.1. Those conclusions are proved in the
paper and are not stored as hypothesis fields in Lean.

## References

1. L. Merel, *Bornes pour la torsion des courbes elliptiques sur les corps
   de nombres*, Invent. Math. 124 (1996), 437--449.
2. C. Hooley, *On the square-free values of cubic polynomials*, J. Reine
   Angew. Math. 229 (1968), 147--154.
3. G. Greaves, *Power-free values of binary forms*, Quart. J. Math. Oxford
   43 (1992), 45--65.
4. C. L. Stewart and J. Top, *On ranks of twists of elliptic curves and
   power-free values of binary forms*, J. Amer. Math. Soc. 8 (1995),
   943--973, DOI 10.1090/S0894-0347-1995-1290234-5.
5. A. Granville, *Rational and integral points on quadratic twists of a
   given hyperelliptic curve*, Int. Math. Res. Not. 2007, rnm027,
   DOI 10.1093/imrn/rnm027.
6. T. Browning and S. Chan, *Almost all quadratic twists of an elliptic
   curve have no integral points*, J. Eur. Math. Soc. (2025),
   DOI 10.4171/JEMS/1704.
7. J. H. Evertse, *On equations in S-units and the Thue--Mahler equation*,
   Invent. Math. 75 (1984), 561--584.
8. J. Tate, *Algorithm for determining the type of a singular fiber in an
   elliptic pencil*, Lecture Notes in Math. 476 (1975), 33--52.
