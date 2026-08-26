# Prime-index Chebyshev curves: a uniform rank-two lower bound and the exact 2-descent obstruction

## Scope and conclusion

For an odd prime \(p\), put

\[
 F_p(X)=4T_p(X)+5,
 \qquad C_p:\ y^2=F_p(X),
 \qquad g={p-1\over2},
\]

where \(T_p\) is the first-kind Chebyshev polynomial.  This note records four
facts which are useful for the residual prime-index problem.

1. The root algebra is the pure field
   \(K_p=\mathbf Q(2^{1/p})\), and both the polynomial discriminant and the
   Wieferich-sensitive field discriminant can be written exactly.
2. There are two rational half-divisors on every \(C_p\).  Their odd-degree
   2-descent classes are exactly

   \[
   [a-1],\qquad [3(a+1)]\quad\hbox{in }K_p^*/K_p^{*2},
   \qquad a^p=2.
   \]

   A 2-adic filtration argument and a 3-adic valuation argument prove that
   these classes are independent for every odd prime \(p\ne3\).  Consequently

   \[
   \boxed{\operatorname {rank}J_p(\mathbf Q)\ge2}
   \]

   uniformly and unconditionally.
3. Exact Magma calculations give \(\operatorname {rank}J_p(\mathbf Q)=2\)
   for \(p=11,13\).  For \(p=17\), PARI certifies the pure-field class and
   unit data unconditionally, but the Selmer calculation is still incomplete:
   one implementation requires a wild 3-adic representative, while another
   stalls in the eight-dimensional 2-adic local image.  No sample is promoted
   to a uniform theorem.
4. After the odd local conditions, the missing uniform upper bound is one
   explicit 2-adic transversality statement.  The 5-adic local one-zero
   argument used at indices 7 and 13 extends formally to every \(p\ne5\), but
   it leaves a moving modulo-5 Coleman-logarithm condition.

This note does not prove the prime-index residual.  It uses standard accepted
algebraic number theory, Poonen--Schaefer/Stoll descent, exact Magma, and
certified PARI data; it assumes neither GRH, BSD, finiteness of \(\Sha\), nor
an `abc`-type statement.

## 1. Root field and irreducibility

Let \(a\) be the positive real root of \(a^p=2\), and set

\[
 \theta=-{a+a^{-1}\over2}.
\]

The elementary identity

\[
 T_p\!\left({z+z^{-1}\over2}\right)
 ={z^p+z^{-p}\over2}
\]

with \(z=-a\) gives

\[
 T_p(\theta)=-{2+1/2\over2}=-{5\over4}.
\]

Hence \(F_p(\theta)=0\) and \(\mathbf Q(\theta)\subseteq\mathbf Q(a)\).
The polynomial \(Z^p-2\) is Eisenstein at 2, so
\([\mathbf Q(a):\mathbf Q]=p\).  If \(\theta\) were rational, then \(a\)
would satisfy

\[
 a^2+2\theta a+1=0,
\]

contradicting \(\deg_{\mathbf Q}(a)=p\ge3\).  The prime-degree tower law
therefore gives

\[
 \boxed{\mathbf Q(\theta)=\mathbf Q(a)}.
\]

Since \(F_p\) has degree \(p\), it follows at once that \(F_p\) is
irreducible.

It is often computationally better to use

\[
 q_p(X)=F_p(-X/2)=5-4T_p(X/2).
\]

This has integral coefficients and leading coefficient \(-2\).  Its generic
root is \(a+a^{-1}\), so its root field is the same \(K_p\).

## 2. Polynomial and field discriminants

The leading coefficient of \(F_p\) is \(A=2^{p+1}\), and

\[
 F_p'(X)=4pU_{p-1}(X),
 \qquad T_p(X)^2-1=(X^2-1)U_{p-1}(X)^2.
\]

If \(r_1,\ldots,r_p\) are the roots of \(F_p\), then
\(T_p(r_i)=-5/4\), whence

\[
 U_{p-1}(r_i)^2={9\over16(r_i^2-1)}.
\]

Also \(F_p(1)=9\), \(F_p(-1)=1\), and therefore

\[
 \prod_i(r_i^2-1)={9\over A^2}.
\]

Substitution in the derivative formula for the discriminant yields

\[
 |\operatorname {disc}(F_p)|
 =A^{p-1}3^{p-1}p^p
 =2^{p^2-1}3^{p-1}p^p.
\]

There is no real root in \([-1,1]\), exactly one real root in
\(( -\infty,-1)\), and no real root in \((1,\infty)\).  Thus there are
\(g\) nonreal conjugate pairs, which fixes the sign:

\[
 \boxed{\operatorname {disc}(F_p)
 =(-1)^g2^{p^2-1}3^{p-1}p^p}.                 \tag{2.1}
\]

The linear change \(X\mapsto-X/2\) gives the much smaller certificate

\[
 \boxed{\operatorname {disc}(q_p)
 =(-1)^g2^{p-1}3^{p-1}p^p}.                  \tag{2.2}
\]

This is a polynomial discriminant.  The field discriminant of
\(K_p=\mathbf Q(a)\) must not be silently identified with it.  Applied with
\(n=p\), \(a=2\), Corollary 1.2 of Jakhar--Khanduja--Sangwan gives

\[
 d_{K_p}=(-1)^g2^{p-1}p^{\nu_p},
 \qquad
 \nu_p=
 \begin{cases}
 p,&p^2\nmid2^{p-1}-1,\\
 p-2,&p^2\mid2^{p-1}-1.
 \end{cases}                                      \tag{2.3}
\]

Equivalently, \(\mathbf Z[a]\) is the maximal order precisely in the first
case; at a base-2 Wieferich prime its index is \(p\).  This is the exact
quantifier in the cited pure-field discriminant theorem, not a harmless
technicality.  See
[Jakhar--Khanduja--Sangwan, Theorem 1.1 and Corollaries 1.2--1.3](https://arxiv.org/html/2005.01300v1#S1.Thmtheorem1).

The primes 11, 13, and 17 are non-Wieferich to base 2, so their field
discriminants are the polynomial discriminants of \(Z^p-2\).

## 3. Two uniform half-divisors

Introduce the integral polynomials \(S_j\) by

\[
 S_0(X)=2,\quad S_1(X)=X,\quad
 S_{j+2}(X)=XS_{j+1}(X)-S_j(X).
\]

They satisfy \(S_j(z+z^{-1})=z^j+z^{-j}\).  Define the two monic degree
\(g\) polynomials

\[
 \begin{aligned}
 P_+(X)&=1+\sum_{j=1}^gS_j(X),\\
 P_-(X)&=(-1)^g+\sum_{j=1}^g(-1)^{g-j}S_j(X).
 \end{aligned}                                      \tag{3.1}
\]

Writing \(X=z+z^{-1}\), the geometric sums give

\[
 \begin{aligned}
 P_+(X)&=z^{-g}{z^p-1\over z-1},\\
 P_-(X)&=z^{-g}{z^p+1\over z+1}.
 \end{aligned}                                      \tag{3.2}
\]

Since \(q_p(X)=5-2(z^p+z^{-p})\), (3.2) proves the exact identities

\[
 \boxed{q_p(X)-1=-2(X-2)P_+(X)^2},
 \qquad
 \boxed{q_p(X)-9=-2(X+2)P_-(X)^2}.                  \tag{3.3}
\]

On \(C'_p:Y^2=q_p(X)\), let

\[
 H_+=(P_+,-1),\qquad H_-=(P_-,-3)
\]

in Mumford notation.  The divisors of \(Y+1\) and \(Y+3\), together with
(3.3), give

\[
 2H_+=[(2,1)-O],
 \qquad
 2H_-=[(-2,3)-O].                                  \tag{3.4}
\]

Thus these are rational half-divisors for every odd \(p\), not points found
by a height search.

## 4. Their descent classes are \([a-1]\) and \([3(a+1)]\)

Use the monic odd-degree model

\[
 C_{p,m}:\quad W^2=q_{p,m}(Z):=2^{p-1}q_p(-Z/2),
 \qquad Z=-2X,\quad W=2^gY.
\]

Put

\[
 U_\pm(Z)=(-2)^gP_\pm(-Z/2).
\]

These are monic.  A root of \(q_{p,m}\) is

\[
 \vartheta=-2(a+a^{-1}).
\]

For an odd-degree hyperelliptic curve, the standard descent map on a Mumford
divisor with monic first coordinate \(U\) is represented by
\([(-1)^{\deg U}U(\vartheta)]\).  Hence

\[
 \delta(H_\pm)=[2^gP_\pm(a+a^{-1})].                 \tag{4.1}
\]

Now \(2^ga^{-g}=a^{g(p-1)}=(a^{g^2})^2\), and \(a^p=2\).  Equations
(3.2) and (4.1) therefore reduce exactly to

\[
 \boxed{\delta(H_+)=[a-1]},
 \qquad
 \boxed{\delta(H_-)=[3(a+1)]}.                       \tag{4.2}
\]

The inverse in the first expression and the quotient in the second have
been removed only by multiplying by explicit squares.  No class-number
input occurs in (4.2).

### 4.1 The first class is nonsquare at 2

The polynomial \(Z^p-2\) is Eisenstein over \(\mathbf Q_2\).  Thus
\(L=\mathbf Q_2(a)\) is totally ramified of odd degree \(p\),
\(\mathcal O_L=\mathbf Z_2[a]\), and \(\pi=a\) is a uniformizer with
\(2=\pi^p\).

If a unit \(b\) is a square root of \(a-1\), then its residue is 1 and one
can write \(b=1+\pi c\).  Since \(p\ge3\),

\[
 b^2=1+2\pi c+\pi^2c^2\equiv1\pmod {\pi^2}.
\]

But

\[
 (a-1)-1=\pi-2\equiv\pi\not\equiv0\pmod {\pi^2}.
\]

Therefore \(a-1\) is not a square in \(K_p\).

### 4.2 The second class has an odd valuation above 3

One has

\[
 N_{K_p/\mathbf Q}(a-1)=1,
 \qquad N_{K_p/\mathbf Q}(a+1)=3.
\]

Thus \(a-1\) is a global unit and \((a+1)\) is a prime ideal of norm 3.
Moreover

\[
 3=a^p+1=(a+1)(a^{p-1}-a^{p-2}+\cdots-a+1).          \tag{4.3}
\]

For \(p\ne3\), the two factors in (4.3) are coprime at \((a+1)\), because
the second factor reduces there to \(p\not\equiv0\pmod3\).  The cofactor
ideal has norm \(3^{p-1}>1\).  Since 3 does not divide the field
discriminant (2.3), it is unramified in \(K_p\).  At any prime
\(\mathfrak q\) in the support of the cofactor,

\[
 \mathfrak q\ne(a+1),\qquad
 v_{\mathfrak q}(a+1)=0,\qquad v_{\mathfrak q}(3)=1,
\]

and hence

\[
 v_{\mathfrak q}(3(a+1))=1.
\]

Consequently \(3(a+1)\) is not a square.  Since \(a-1\) is a unit, the
product \((a-1)3(a+1)\) has the same odd valuation.  The two squareclasses
in (4.2) are therefore linearly independent over \(\mathbf F_2\).

### 4.3 Uniform Mordell--Weil consequence

Irreducibility of the odd-degree polynomial \(q_p\) implies
\(J_p(\mathbf Q)[2]=0\): a Galois-fixed even subset of one transitive orbit
of \(p\) roots is empty.  The odd-degree descent map injects
\(J_p(\mathbf Q)/2J_p(\mathbf Q)\) into \(K_p^*/K_p^{*2}\).  Hence
\(H_+,H_-\) are independent modulo 2.

If an integral relation between them existed, reduction modulo 2 would make
both coefficients even.  Dividing the relation by 2 is legitimate because
\(J_p(\mathbf Q)[2]=0\).  Infinite descent on the two coefficients forces
both to vanish.  We have proved:

> **Uniform rank-two theorem.**  For every odd prime \(p\ne3\), the classes
> \(H_+,H_-\) are \(\mathbf Z\)-independent in \(J_p(\mathbf Q)\).  In
> particular \(\operatorname {rank}J_p(\mathbf Q)\ge2\).

## 5. The exact global and local dimension ledger

Let \(S\) consist of the primes of \(K_p\) above \(2,3,p\), and define

\[
 K_p(S,2)=\{u\in K_p^*:v_{\mathfrak q}(u)\equiv0\pmod2
 \text{ for }\mathfrak q\notin S\}/K_p^{*2}.
\]

The obstruction from class groups occurs in the precise exact sequence

\[
 0\longrightarrow
 \mathcal O_{K_p,S}^*/\mathcal O_{K_p,S}^{*2}
 \longrightarrow K_p(S,2)
 \longrightarrow \operatorname {Cl}(\mathcal O_{K_p,S})[2]
 \longrightarrow0.                                      \tag{5.1}
\]

This is the place where a uniform 2-class theorem would enter.  It is not
legitimate to replace the last term by zero from computations at a finite
list of primes.

Let

\[
 r_3=\#\{\hbox{irreducible factors of }Z^p-2\text{ over }\mathbf F_3\}.
\]

Since

\[
 Z^p-2=Z^p+1=(Z+1)\Phi_{2p}(Z)\quad\hbox{over }\mathbf F_3,
\]

one has the exact formula

\[
 r_3=1+{p-1\over\operatorname {ord}_p(3)}.              \tag{5.2}
\]

Let \(s_p\) be the number of factors over \(\mathbf Q_p\).  It is 1 at a
non-Wieferich prime.  If \(p^2\mid2^{p-1}-1\), then 2 is a \(p\)-th power in
\(\mathbf Q_p\), and
\(Z^p-2\) has one linear and one degree-\(p-1\) cyclotomic factor, so
\(s_p=2\).  This is a second reason the Wieferich branch must be kept.

There is one prime above 2.  Since \(K_p\) has signature \((1,g)\), the
\(S\)-unit theorem and (5.1) give

\[
 \dim_{\mathbf F_2}K_p(S,2)
 =g+r_3+s_p+2+c_p,
 \quad
 c_p=\dim_{\mathbf F_2}\operatorname {Cl}(\mathcal O_{K_p,S})[2].
                                                               \tag{5.3}
\]

The norm map onto
\(\mathbf Q(\{2,3,p\},2)=\langle-1,2,3,p\rangle\) is surjective: on a
rational scalar it is the odd power \(x^p\), which has the same squareclass.
The norm-square candidate space consequently has exact dimension

\[
 \boxed{g+r_3+s_p-2+c_p}.                               \tag{5.4}
\]

At an odd local prime, multiplication by 2 is an automorphism on the open
pro-odd subgroup of the Jacobian, so the local Kummer quotient has the same
dimension as rational 2-torsion.  For an odd-degree hyperelliptic polynomial
with \(r\) local factors that dimension is \(r-1\).  Hence

\[
 \dim J_p(\mathbf Q_3)/2J_p(\mathbf Q_3)=r_3-1,
 \qquad
 \dim J_p(\mathbf Q_p)/2J_p(\mathbf Q_p)=s_p-1.          \tag{5.5}
\]

This explains the apparently different Magma outputs at 3:

\[
\begin{array}{c|c|c|c}
p&g&r_3&\dim J_p(\mathbf Q_3)/2\\ \hline
11&5&3&2\\
13&6&5&4\\
17&8&2&1
\end{array}
\]

At 2, the root polynomial remains Eisenstein and
\(J_p(\mathbf Q_2)[2]=0\).  The usual local multiplication-by-2 index
formula gives

\[
 \dim_{\mathbf F_2}J_p(\mathbf Q_2)/2J_p(\mathbf Q_2)=g. \tag{5.6}
\]

On the descent-algebra side,
\(K_{p,2}^*/K_{p,2}^{*2}\) has dimension \(p+2\).  Its norm map to the
three-dimensional squareclass group of \(\mathbf Q_2\) is surjective, again
because the extension degree is odd.  Thus the local norm kernel has
dimension \(p-1=2g\), and the local Kummer image is a \(g\)-dimensional
maximal isotropic subspace.

Let \(V_p^{\mathrm{odd}}\) denote the global norm candidates satisfying the
local conditions at infinity, 3, and \(p\), and let \(L_{2,p}\) be the
local Kummer image at 2.  The missing upper bound is now exactly

\[
 \ker\!\left(
 V_p^{\mathrm{odd}}\longrightarrow
 {\ker(N:K_{p,2}^*/K_{p,2}^{*2}\to\mathbf Q_2^*/\mathbf Q_2^{*2})
  \over L_{2,p}}
 \right)
 =\langle[a-1],[3(a+1)]\rangle.                         \tag{5.7}
\]

The right side is already known to lie in the kernel by Section 4.  What is
missing is the reverse inclusion.  This is a growing 2-adic localization
matrix, not a consequence of the dimensions alone.  A proof of (5.7) could
also kill the image of the class-group term in (5.1) directly, thereby
avoiding a uniform class-number-one theorem.

## 6. Exact computations for 11, 13, and 17

All Magma calculations below used the official calculator, Magma V2.29-9,
with its 60-second limit.

### 6.1 \(p=11\)

The reduced polynomial is

\[
 q_{11}=-2X^{11}+22X^9-88X^7+154X^5-110X^3+22X+5.
\]

An unconditional `PhiSelmerGroup(q11,2)` run completes in about 33 seconds
and returns

\[
 \operatorname {Sel}^{(2)}(J_{11}/\mathbf Q)
 \simeq(\mathbf Z/2)^2,
 \qquad J_{11}(\mathbf Q)[2]=0.
\]

The two half-divisor images are distinct and nonzero and generate the group
of order four.  Therefore

\[
 \operatorname {rank}J_{11}(\mathbf Q)=2.
\]

The computation invokes no GRH class-group option.  The pure field class
group is trivial and its unit-group invariants are
\([2,0,0,0,0,0]\).

### 6.2 \(p=13\)

The reduced polynomial is

\[
 q_{13}=-2X^{13}+26X^{11}-130X^9+312X^7-364X^5
        +182X^3-26X+5.
\]

With `SetSeed(2)`, an unconditional `PhiSelmerGroup(q13,2)` run completes in
54.880 seconds and again returns \((\mathbf Z/2)^2\).  The transformed
half-divisor polynomials are

\[
\begin{aligned}
U_1={}&X^6-2X^5-20X^4+32X^3+96X^2-96X-64,\\
U_9={}&X^6+2X^5-20X^4-32X^3+96X^2+96X-64.
\end{aligned}
\]

Their images are nonzero and distinct and span a subgroup of order four.
Thus

\[
 \operatorname {rank}J_{13}(\mathbf Q)=2.
\]

The separate prime-thirteen Coleman--Chabauty certificate proves the full
rational-point classification.

### 6.3 \(p=17\): what is and is not certified

Here

\[
\begin{aligned}
q_{17}={}&-2X^{17}+34X^{15}-238X^{13}+884X^{11}-1870X^9\\
&+2244X^7-1428X^5+408X^3-34X+5,
\end{aligned}
\]

and Magma verifies irreducibility and

\[
 \operatorname {disc}(q_{17})=2^{16}3^{16}17^{17}.
\]

The official Magma unconditional class-group proof exceeds its 60-second
web limit.  Independently, PARI/GP 2.15.4 gives

```gp
b = bnfinit(x^17 - 2, 1);
b.clgp
% = [1, [], []]
bnfcertify(b)
% = 1
```

The last line is decisive: the PARI manual states that output 1 certifies
the complete class and fundamental-unit data unconditionally, removing the
GRH assumption.  See the official
[PARI `bnfcertify` documentation](https://pari.math.u-bordeaux.fr/dochtml/html-stable/General_number_fields.html#bnfcertify).

This does not finish the Selmer calculation.  The new cyclic-cover
implementation expects a one-dimensional local image at 3 but finds no
generator after searching tame extensions through degree 9; it reports that
tamely ramified extensions are insufficient.  Equation (5.5) proves that
the expected dimension 1 is correct.  The failure is only the construction
of a representative of the unique local 2-torsion class, which evidently
requires a wild 3-adic extension in that implementation.

The old implementation bypasses that stage but stops at 2.  Its exact
diagnostic is

```text
A(2,S) = (Z/2)^13
bound after the norm criterion = 9
dimension of J(Q_2)/2J(Q_2) = 8
dimension generated by 2-torsion = 0
```

before the 60-second timeout.  These numbers agree with (5.3)--(5.6).  No
completed rank bound or Selmer dimension is claimed for \(p=17\).

## 7. Audit of possible uniform class-number input

No accepted theorem located in this audit proves

\[
 \operatorname {Cl}(\mathbf Q(2^{1/p}))[2]=0
 \quad\hbox{for every odd prime }p,
\]

let alone class number one.  Computations for small \(p\) are evidence only.

The superficially relevant theorem of Parry--Walter has a different
quantifier and a different primary part.  Its opening statement says that
it gives necessary and sufficient conditions for the prime \(p\) to divide
the class number of the **Galois closure** of a pure degree-\(p\) field.  It
does not prove triviality of the 2-class group of the non-Galois field
\(K_p\).  See
[Parry--Walter, *The class number of pure fields of prime degree*](https://colinandmargaret.co.uk/Research/CDW_PureFields_76.pdf),
especially the abstract and Theorem 8.

Likewise, the Poonen--Schaefer descent theorem is an algorithm for each
fixed etale algebra; it does not make the term in (5.1) vanish uniformly.
The Magma handbook explicitly lists both class-group computation and the
local image above the descent prime as the expensive steps.  See the official
[cyclic-cover descent documentation](https://magma.maths.usyd.edu.au/magma/handbook/text/1621)
and
[hyperelliptic 2-Selmer documentation](https://magma.maths.usyd.edu.au/magma/handbook/text/1618#1618-345).

Thus the honest alternatives are:

* prove the required \(S\)-class 2-torsion statement with its full
  quantifier; or
* prove directly that every class-group contribution maps outside one of
  the local Kummer images in (5.7).

## 8. The 5-adic Coleman argument: what is uniform

For \(p\ne5\), use the monic model

\[
 H_p:\quad v^2=h_p(X):={F_p(X)\over2^{p+1}},
 \qquad v={y\over2^{(p+1)/2}}.
\]

Equation (2.1) gives

\[
 \operatorname {disc}(h_p)
 =(-1)^g{3^{p-1}p^p\over2^{p^2-1}},
\]

a 5-adic unit.  Hence \(H_p\) has good reduction at 5.

For every prime \(p\ge7\), one has \(T_p(x)=x\) for every
\(x\in\mathbf F_5\).  This is immediate at \(0,\pm1\); at 2 the recurrence
has period 3 and \(p\ne3\), and oddness handles \(-2\).  The reduced curve
therefore has exactly six points: infinity, two points above each of
\(X=1,-1\), and the Weierstrass point above \(X=0\).

The five visible rational points are

\[
 O,\quad(-1,\pm2^{-(p+1)/2}),
 \quad(1,\pm3\,2^{-(p+1)/2}).
\]

Moreover

\[
 F_p'(0)=4pU_{p-1}(0)\not\equiv0\pmod5.
\]

Hensel's lemma gives a unique 5-adic Weierstrass point in the sixth disc.
Its divisor class relative to infinity is 2-torsion, so every Coleman
annihilator vanishes there.

Assume now that \(\operatorname {rank}J_p(\mathbf Q)=2\).  In the basis

\[
 \omega_i=X^i{dX\over2v},\qquad0\le i<g,
\]

let \(\overline L_p\subset\mathbf F_5^g\) be the saturated modulo-5
reduction of the Coleman-logarithm span of the two Mordell--Weil
generators.  Its dimension is at most two; no nonvanishing of a 5-adic
regulator is being assumed.  Put

\[
 e_r=(1,r,\ldots,r^{g-1})\quad(r=0,1,-1),
 \qquad e_\infty=(0,\ldots,0,1).
\]

There is an annihilating differential nonzero at each of the six reduced
points precisely when

\[
 e_0,e_1,e_{-1},e_\infty\notin\overline L_p.             \tag{8.1}
\]

Indeed the annihilator is \(\overline L_p^\perp\), and each forbidden zero
is one proper hyperplane in that space.  Four proper hyperplanes cannot
cover a vector space over \(\mathbf F_5\), so the pointwise conditions in
(8.1) produce one differential nonzero everywhere.

The elementary local expansion

\[
 a_0t+{a_1\over2}t^2+{a_2\over3}t^3+\cdots,
 \qquad a_0\in\mathbf Z_5^*,\quad t\in5\mathbf Z_5,
\]

then shows that its Coleman primitive has at most one zero in each residue
disc.  The six zeros already listed are therefore all the zeros.  Since
\(F_p\) is irreducible, the Hensel-lifted Weierstrass point is not rational.
On the original model this leaves exactly

\[
 C_p(\mathbf Q)=\{O,(-1,\pm1),(1,\pm3)\}.
\]

Thus the local one-zero argument is uniform for every \(p\ge7\).  The
nonuniform input is exactly (8.1), a moving finite-field condition on two
Coleman logarithms.  It has been checked at \(p=7\) and \(p=13\); no accepted
theorem found here forces it for every prime \(p\).

The index \(p=5\) itself is excluded from this formulation because 5 is a
bad-reduction prime; it is handled by the separate two-cover/elliptic-
Chabauty certificate.

## 9. Minimal remaining statements

The uniform rank lower bound is closed.  A uniform upper bound, and then the
rational-point classification, would follow from the following two explicit
statements.

1. **2-adic Selmer transversality.**  Prove (5.7), including the possible
   image of \(\operatorname {Cl}(\mathcal O_{K_p,S})[2]\) and the
   Wieferich local branch.
2. **Coleman nonvanishing.**  Once the rank is two, prove the four exclusions
   (8.1).

Neither statement is a dimension heuristic.  The first is a growing local
unit/Hilbert-symbol matrix over the totally ramified field
\(\mathbf Q_2(2^{1/p})\); the second is a moving modulo-5 logarithm matrix.
The calculations at 11 and 13 show what successful certificates look like,
but they do not prove either assertion uniformly.

## 10. Lean companion and trust boundary

`IUTThreeClosures/FreyPellChebyshevUniformTwoDescentAudit.lean` checks the
explicit reduced polynomials and both half-factor identities at
\(p=11,13,17\).  These scalar identities are the finite specializations of
(3.3).

Lean does not reimplement Chebyshev root fields, algebraic-number-field
discriminants, local squareclasses, Jacobians, Selmer groups, Magma, PARI,
or Coleman integration.  Those accepted inputs and the exact remaining
boundaries are stated explicitly above; no axiom asserting the desired
uniform rank upper bound or rational-point classification is introduced.
