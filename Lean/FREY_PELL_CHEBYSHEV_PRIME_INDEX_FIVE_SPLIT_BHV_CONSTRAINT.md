# Prime-index Chebyshev residual: five-split, norm-composition, and BHV constraint

## 1. Scope and outcome

Consider

$$
y^2=4T_p(X)+5,\qquad
p\ge 31\text{ prime},\quad X>1,\quad X\equiv23\pmod {24},
\tag{1}
$$

where $T_n$ is the first-kind Chebyshev polynomial, normalized by
$T_0=1$, $T_1=X$, and $T_{n+2}=2XT_{n+1}-T_n$. Put

$$
p=2m+1,\qquad H_p(X)=\frac{T_p(X)}X\in\mathbf Z[X^2].
$$

This note proves a new **necessary-condition package**, not a uniform
exclusion. Every solution of (1) satisfies:

1. Every prime $q\ne5$ in the support of $T_p(X)$ is
   $q\equiv\pm1\pmod5$. If $5\mid T_p(X)$, then
   $v_5(T_p(X))=1$ and $T_p(X)/5\equiv1\pmod5$.
2. The base lies in exactly the following refined classes:

   $$
   \begin{array}{c|c}
   \text{branch}&\text{necessary class}\\
   \hline
   5\nmid X&X\equiv71\text{ or }119\pmod{120},\\
   5\mid X,\ p\equiv1,19\pmod{20}&X\equiv455\pmod{600},\\
   5\mid X,\ p\equiv9,11\pmod{20}&X\equiv95\pmod{600}.
   \end{array}
   \tag{2}
   $$

   In the last two rows $v_5(X)=1$, and that branch forces
   $p\equiv\pm1\pmod5$.
3. The half-angle factors satisfy the complete gcd ledger in Section 4.
4. Equation (1) is equivalent to an explicit three-equation integral
   norm-composition residual in the fixed field $\mathbf Q(\sqrt5)$.
5. The scalar residual has additional coprimality consequences recorded in
   Section 6, and $X+1$ is not a square.
6. A Bilu--Hanrot--Voutier primitive divisor gives a prime $q\mid H_p(X)$
   such that

   $$
   q\equiv\pm1\pmod5,\qquad
   4p\mid q-1\ \text{or}\ 4p\mid q+1.
   \tag{3}
   $$

   Hence $q\ge4p-1$. In the branch $5\mid X$, the first possibilities
   $q=4p\pm1$ are incompatible with $q\equiv\pm1\pmod5$, so
   $q\ge8p-1$.

The fixed-field ideal factorization and the BHV theorem are accepted
mathematical interfaces. They are not represented as Lean axioms or kernel
theorems. The companion file
<code>IUTThreeClosures/FreyPellChebyshevPrimeIndexFiveSplitBhvConstraint.lean</code>
checks only the scalar algebra, square gap, and CRT ledgers.

## 2. Parity and the source of the five-split condition

### 2.1 Why the prime $2$ is not an exception here

The target congruence makes $X$ odd. Reducing the Chebyshev recurrence modulo
$2$ gives $T_{n+2}(X)\equiv T_n(X)\pmod2$, and both $T_0(X)$ and $T_1(X)$
are odd. Thus every $T_n(X)$, in particular $T_p(X)$, is odd.

This point is required. From a bare congruence $y^2\equiv5\pmod q$, the
conclusion $q\equiv\pm1\pmod5$ is false for $q=2$. It is true for every prime
in the present support because $2\nmid T_p(X)$.

### 2.2 Primes $q\ne5$

Let $q\ne5$ be a rational prime dividing $T_p(X)$. Equation (1) gives

$$
y^2\equiv5\pmod q.
$$

The prime $q$ is odd by Section 2.1. Also $y\not\equiv0\pmod q$, because
$q\ne5$. Therefore $(5/q)=1$. Since $5\equiv1\pmod4$, quadratic reciprocity
gives

$$
\left(\frac5q\right)=\left(\frac q5\right)=1.
$$

The nonzero squares modulo $5$ are $1$ and $4$, so

$$
q\equiv1\text{ or }4\pmod5.
\tag{4}
$$

The only exceptional rational prime in this deduction is $q=5$, treated
next. The Lean theorem
<code>pellPrimeFiveSplit_factor_sees_five_as_square</code> formalizes the raw
congruence; quadratic reciprocity remains an accepted library theorem in this
note's trust ledger.

### 2.3 The exact $5$-adic branch

Assume $5\mid T_p(X)$. Equation (1) first gives $5\mid y$. Write $y=5z$ and
$T_p(X)=5w$. Dividing (1) by $5$ gives

$$
5z^2=4w+1.
$$

Modulo $5$, this forces $w\equiv1\pmod5$. In particular $5\nmid w$, and
therefore

$$
v_5(T_p(X))=1,\qquad \frac{T_p(X)}5\equiv1\pmod5.
\tag{5}
$$

This is exact integer arithmetic, not a finite-precision $5$-adic claim.

## 3. The complete base residue classification

### 3.1 The identity map $T_p:\mathbf F_5\to\mathbf F_5$

For every prime $p\ge31$,

$$
T_p(x)=x\quad\text{for every }x\in\mathbf F_5.
\tag{6}
$$

This is a five-element verification with a uniform proof.

* At $x=0$, oddness of $T_p$ gives $T_p(0)=0$.
* At $x=1,-1$, one has $T_p(1)=1$ and $T_p(-1)=-1$ because $p$ is odd.
* At $x=2$, the recurrence modulo $5$ is
  $1,2,2,1,2,2,\ldots$, with period $3$. Since the prime $p\ge31$ is not
  $3$, one has $p\equiv1$ or $2\pmod3$, and in either case $T_p(2)=2$.
* At $x=-2$, oddness gives $T_p(-2)=-T_p(2)=-2$.

Consequently, $5\mid T_p(X)$ if and only if $5\mid X$.

For $p=2m+1$, the constant term of $H_p$ is

$$
H_p(0)=T_p'(0)=(-1)^m p.
\tag{7}
$$

This follows from $T_p'=pU_{p-1}$ and $U_{2m}(0)=(-1)^m$, or directly from
the coefficient of $X$ in the Chebyshev recurrence.

### 3.2 The branch $5\nmid X$

Every prime factor of $X$ is a prime factor of
$T_p(X)=XH_p(X)$. It is not $5$, so (4), with multiplicity, implies

$$
X\equiv\pm1\pmod5.
$$

Combining this with $X\equiv23\pmod{24}$ gives

$$
X\equiv71\text{ or }119\pmod{120}.
$$

The Lean theorem <code>pellPrimeFiveSplit_crt_nonFive</code> checks this CRT
calculation.

### 3.3 The branch $5\mid X$

By (6) and (7),

$$
H_p(X)\equiv H_p(0)=(-1)^m p\not\equiv0\pmod5.
$$

Thus $v_5(H_p(X))=0$. Together with (5) and
$T_p(X)=XH_p(X)$, this proves $v_5(X)=1$. Write

$$
A=X/5,\qquad B=H_p(X).
$$

Every prime factor of $A$ and every prime factor of $B$ comes from the
support of $T_p(X)$, and none is $5$. This support statement is essential:
it permits (4) to be multiplied with multiplicity. Hence

$$
A\equiv\pm1\pmod5,\qquad B\equiv\pm1\pmod5.
\tag{8}
$$

By (5), $AB=T_p(X)/5\equiv1\pmod5$, so the two signs in (8) agree.
Using (7),

$$
A\equiv B\equiv(-1)^m p\pmod5.
\tag{9}
$$

In particular $p\equiv\pm1\pmod5$. Combining the parity of
$m=(p-1)/2$ with $p\pmod5$ gives

$$
\begin{array}{c|c|c|c}
p\pmod{20}&(-1)^m&p\pmod5&A\pmod5\\
\hline
1&+1&1&1\\
19&-1&4&1\\
9&+1&4&4\\
11&-1&1&4.
\end{array}
$$

Thus $X=5A\equiv5\pmod{25}$ in the first two rows and
$X\equiv20\pmod{25}$ in the last two. CRT with
$X\equiv23\pmod{24}$ yields

$$
\begin{aligned}
p\equiv1,19\pmod{20}
&\Longrightarrow X\equiv455\pmod{600},\\
p\equiv9,11\pmod{20}
&\Longrightarrow X\equiv95\pmod{600}.
\end{aligned}
$$

The Lean companion checks the same-sign truth table, both CRT calculations,
and the final four-class lookup. It does not hide the support argument or (7)
inside an axiom.

## 4. Half-angle identities and the gcd ledger

Let $U_n$ denote the second-kind Chebyshev polynomial,
$U_0=1$, $U_1=2X$, and $U_{n+2}=2XU_{n+1}-U_n$. Put

$$
F=U_m(X)+U_{m-1}(X),\qquad
G=U_m(X)-U_{m-1}(X).
$$

The standard half-angle identities are

$$
T_p(X)-1=(X-1)F^2,\qquad
T_p(X)+1=(X+1)G^2.
\tag{10}
$$

Since $X$ is odd, consecutive $U$-values have opposite parity, so $F$ and
$G$ are odd. If an integer divides both $F$ and $G$, its oddness lets us
divide the relations $F+G=2U_m$ and $F-G=2U_{m-1}$ by $2$. The Euclidean
recurrence for $U_n$, ending at $U_0=1$, shows consecutive $U$-values are
coprime. Hence

$$
\gcd(F,G)=1.
\tag{11}
$$

The evaluations $U_n(1)=n+1$ and
$U_n(-1)=(-1)^n(n+1)$ give

$$
\begin{array}{c|cc}
&F&G\\
\hline
X=1&p&1\\
X=-1&(-1)^m&(-1)^m p.
\end{array}
$$

Polynomial remainder at $X=\pm1$ yields

$$
\begin{aligned}
\gcd(X-1,F)&=\gcd(X-1,p),&
\gcd(X-1,G)&=1,\\
\gcd(X+1,F)&=1,&
\gcd(X+1,G)&=\gcd(X+1,p).
\end{aligned}
\tag{12}
$$

Here gcd means the positive gcd of absolute values, so endpoint signs cause
no ambiguity. Formula (7) similarly gives

$$
\gcd(X,H_p(X))=\gcd(X,p).
\tag{13}
$$

The polynomial $T_p(X)-X$ vanishes at $0,1,-1$, so it is divisible by
$X(X^2-1)$. Cancelling $X$ in $T_p(X)=XH_p(X)$ gives

$$
H_p(X)\equiv1\pmod{X^2-1}.
\tag{14}
$$

Since $X$ is odd, $8\mid X^2-1$, and therefore

$$
H_p(X)\equiv1\pmod8.
\tag{15}
$$

All statements in this section are elementary polynomial and gcd results,
suitable for a later Lean layer. The current companion prioritizes the norm,
square-gap, and CRT kernels.

## 5. Exact fixed-field norm-composition residual

Choose $y>0$, losing no generality. The right side of (1) is odd, so $y$ is
odd. In

$$
K=\mathbf Q(\sqrt5),\qquad
\mathcal O_K=\mathbf Z[(1+\sqrt5)/2],
$$

define

$$
\alpha=\frac{y+\sqrt5}{2}.
$$

The element $\alpha$ is integral and totally positive, and

$$
N_{K/\mathbf Q}(\alpha)
=\frac{y^2-5}{4}
=T_p(X)
=XH_p(X).
\tag{16}
$$

### 5.1 Accepted ideal-factorization step

The field $K$ has discriminant $5$ and class number one. For completeness,
Minkowski's degree-two bound is $\sqrt5/2<2$, so every ideal class contains
an integral ideal of norm one.

The ideals $(\alpha)$ and $(\bar\alpha)$ are coprime away from the unique
prime above $5$: a common prime would divide
$\alpha-\bar\alpha=\sqrt5$. Every rational prime $q\ne5$ in the norm splits
by (4). At such a $q$, exactly one prime above $q$ occurs in $(\alpha)$.
Select from it the exponent $v_q(X)$. If $5\mid X$, allocate the single
ramified prime supplied by $v_5(X)=1$ to the same selected ideal. The
resulting ideal has norm $X$, and its complementary factor has norm
$H_p(X)$.

Class number one principalizes the selected ideal. A unit of norm $-1$ is
available in $K$, so its generator can be chosen to have norm $+X$; changing
the common sign makes it totally positive. Dividing $\alpha$ by this
generator makes the complementary generator integral and totally positive.
Thus there exist

$$
\beta=\frac{r+s\sqrt5}{2},\qquad
\gamma=\frac{u+v\sqrt5}{2}
$$

with $\alpha=\beta\gamma$, $N(\beta)=X$, and
$N(\gamma)=H_p(X)$. Their coordinates satisfy

$$
r\equiv s\pmod2,\qquad u\equiv v\pmod2
$$

and the exact scalar system

$$
\boxed{
\begin{aligned}
r^2-5s^2&=4X,\\
u^2-5v^2&=4H_p(X),\\
rv+su&=2.
\end{aligned}}
\tag{17}
$$

The rational coefficient is

$$
ru+5sv=2y.
\tag{18}
$$

Total positivity gives $r>\sqrt5|s|$ and $u>\sqrt5|v|$. In the target range
one may also take $sv<0$. Indeed, $s=0$ would make $X$ a square, impossible
for $X\equiv23\pmod{24}$. If $v=0$, then $su=2$ contradicts
$H_p(X)>1$. For nonzero $s,v$, equal negative signs make $rv+su<0$, while
equal positive signs and total positivity make it greater than $2$.

### 5.2 Scalar converse and exactness

The identity

$$
(ru+5sv)^2-5(rv+su)^2
=(r^2-5s^2)(u^2-5v^2)
\tag{19}
$$

is a polynomial identity over $\mathbf Z$. Substitution of (17) gives

$$
(ru+5sv)^2=16XH_p(X)+20.
$$

The parity conditions make $ru+5sv$ even. Setting
$y=(ru+5sv)/2$, or taking the opposite sign, recovers (1). Conversely, the
ideal selection supplies (17)--(18) from every solution. Thus (17), with
$H=H_p(X)$, parity and positivity, is an **equivalent integral residual**,
not a relaxation.

The Lean theorems
<code>pellPrimeFiveSplit_normComposition</code>,
<code>pellPrimeFiveSplit_normComposition_of_norms</code>,
<code>pellPrimeFiveSplit_reconstruct_shiftSquare</code>, and
<code>pellPrimeFiveSplit_shiftSquare_iff_productCoefficient</code>
check (19) and both scalar reconstruction directions. They make no claim
about ideals or class groups.

## 6. Further scalar consequences and the square gap

### 6.1 Two exact mixed-coordinate identities

The two norm equations and $rv+su=2$ imply

$$
\boxed{
Xv^2
=H_p(X)s^2-su+1
=H_p(X)s^2+rv-1.}
\tag{20}
$$

For the first equality, multiply
$r^2-5s^2=4X$ by $v^2$, multiply
$u^2-5v^2=4H_p(X)$ by $s^2$, and use

$$
(su)^2-(rv)^2
=(su-rv)(su+rv)
=2(su-rv)
=4su-4.
$$

The second equality is just $rv+su=2$.

### 6.2 Coprimality ledger inside the norm residual

The same scalar system and the two parity conditions give

$$
\gcd(s,v)=\gcd(r,u)=1,
\qquad
\gcd(r,s)\le2,\quad \gcd(u,v)\le2,
\tag{21}
$$

and

$$
\gcd(s,X)=1,\qquad \gcd(v,H_p(X))=1.
\tag{22}
$$

Here is the complete proof.

* A common divisor of $s,v$ divides $rv+su=2$. If it were even, then parity
  would make all four of $r,s,u,v$ even, making $rv+su$ divisible by $4$.
  Thus every common divisor is an odd divisor of $2$, proving
  $\gcd(s,v)=1$. The argument for $\gcd(r,u)$ is identical.
* A common divisor of $r,s$ divides both summands in $rv+su=2$, so its
  positive gcd is at most $2$. Likewise $\gcd(u,v)\le2$.
* If $d\mid s$ and $d\mid X$, reduce the first equality in (20) modulo $d$:
  both sides except the constant $1$ vanish, so $d\mid1$.
  Thus $\gcd(s,X)=1$.
* If $d\mid v$ and $d\mid H_p(X)$, rearrange the second equality in (20) as
  $H_p(X)s^2-Xv^2+rv=1$ and reduce modulo $d$. This gives
  $\gcd(v,H_p(X))=1$.

These conclusions are elementary consequences of (17); they add no
number-field or BHV dependency.

### 6.3 The adjacent-square exclusion

From (1) and the second identity in (10),

$$
y^2
=4(T_p(X)+1)+1
=4(X+1)G^2+1.
\tag{23}
$$

If $X+1=a^2$, then

$$
y^2=(2aG)^2+1.
$$

Here $a\ne0$ because $X>1$, and $G>0$ for $X>1$. No two positive integer
squares differ by one: for $b>0$,
$b^2<b^2+1<(b+1)^2$. Hence

$$
X+1\ne a^2.
\tag{24}
$$

In particular, all target bases $X=(12n)^2-1$ are excluded. The Lean
theorems <code>pellPrimeFiveSplit_natSquare_add_one_ne_square</code> and
<code>pellPrimeFiveSplit_neighborSquare_excludes</code> formalize the sharp
natural-number kernel. Their nonzero assumptions are necessary because
$0^2+1=1^2$.

## 7. The accepted BHV primitive-divisor interface

### 7.1 Exact theorem used

Set $D=X^2-1$ and

$$
\lambda=X+\sqrt D,\qquad
\lambda^{-1}=X-\sqrt D.
$$

The pair $(\lambda,\lambda^{-1})$ is a Lucas pair: its sum is $2X$, its
product is $1$, these are coprime nonzero rational integers, and
$\lambda/\lambda^{-1}=\lambda^2$ is not a root of unity because $X>1$.
Its Lucas sequence is

$$
L_n
=\frac{\lambda^n-\lambda^{-n}}{\lambda-\lambda^{-1}}
=U_{n-1}(X).
$$

We use the Bilu--Hanrot--Voutier theorem in its Lucas form: for every Lucas
pair and every $n>30$, $L_n$ has a primitive prime divisor. Here primitive
means a rational prime $q\mid L_n$ which does not divide

$$
(\lambda-\lambda^{-1})^2L_1L_2\cdots L_{n-1}.
$$

The primary reference is Y. Bilu, G. Hanrot, and P. M. Voutier,
“Existence of primitive divisors of Lucas and Lehmer numbers,”
*J. reine angew. Math.* **539** (2001), 75--122,
[DOI 10.1515/crll.2001.080](https://doi.org/10.1515/crll.2001.080).

This deep theorem is an **accepted interface**. It is not re-proved, added as
an axiom, or disguised as a theorem in the Lean companion.

### 7.2 Applying BHV at $n=2p$

Since $2p>30$, choose a primitive prime divisor $q$ of $L_{2p}$. The
doubling identity is

$$
L_{2p}=2T_p(X)L_p.
\tag{25}
$$

Primitivity excludes every earlier term, in particular
$q\nmid L_p$ and $q\nmid L_2=2X$. Hence $q\ne2$, $q\nmid X$, and (25)
gives

$$
q\mid T_p(X),\qquad q\mid H_p(X).
\tag{26}
$$

Primitivity also excludes the discriminant
$(\lambda-\lambda^{-1})^2=4D$, so reduction in the split or nonsplit
quadratic torus is nondegenerate.

Let $\rho=\lambda/\lambda^{-1}=\lambda^2$. The definition of primitive
divisor says that $\rho$ has exact order $2p$: it vanishes at $L_{2p}$ and
at no earlier $L_j$. Moreover, $q\mid T_p(X)$ gives

$$
\lambda^p+\lambda^{-p}=0,\qquad \lambda^{2p}=-1.
$$

Consequently **$\lambda$, not merely $\lambda^2$, has exact order $4p$**.
This extra factor two is essential.

* If $D$ is a square modulo $q$, then
  $\lambda\in\mathbf F_q^\times$, so $4p\mid q-1$.
* If $D$ is a nonsquare modulo $q$, Frobenius interchanges the roots,
  $\lambda^q=\lambda^{-1}$, so $\lambda$ lies in the norm-one torus and
  $4p\mid q+1$.

This proves the order part of (3). It also excludes $q=5$ automatically,
since $4p>q+1$. Equation (26) and Section 2 then give
$q\equiv\pm1\pmod5$.

### 7.3 Size and all small boundary cases

There is an integer $k\ge1$ such that

$$
q=4kp+1\quad\text{or}\quad q=4kp-1.
\tag{27}
$$

Thus $q\ge4p-1$.

The weaker-looking values $q=2p\pm1$ do **not** survive. They would be
compatible only with the order $2p$ of $\lambda^2$; neither neighboring
torus has room for the proven order $4p$. Explicitly, for $p\ge3$, none of
$q-1,q+1$ at $q=2p-1$ or $q=2p+1$ is a positive multiple of $4p$.
The case $q=p$ is excluded for the same order reason, while $q=2$ was
already excluded by primitivity through $L_2=2X$.

In the branch $5\mid X$, Section 3 proves $p\equiv\pm1\pmod5$. If $k=1$ in
(27), then $q=4p\pm1$. The four reductions modulo $5$ are $0,2,$ or $3$,
never $1$ or $4$. Therefore $k\ge2$ and

$$
q\ge8p-1.
\tag{28}
$$

The Lean theorem
<code>pellPrimeFiveSplit_firstFourPBoundaries_incompatible</code> checks
exactly the final modulo-$5$ truth table, conditional on the BHV output. It
does not assert existence or primitivity of $q$.

## 8. Boundary tests and deliberate attempts to break the constraints

These tests separate necessary conditions from a proof of exclusion.

### 8.1 The residue filter is not sufficient

At the first active prime, $p=31\equiv11\pmod{20}$, the base $X=95$
satisfies $X\equiv95\pmod{600}$. Nevertheless,

$$
4T_{31}(95)+5\equiv6\pmod{13},
$$

and $6$ is not a square modulo $13$. Thus (2) is a necessary filter, not a
sufficiency statement.

### 8.2 The three scalar norm equations alone have infinite solutions

For every $n\ge1$, take

$$
\begin{aligned}
X&=71,& H&=71n^2-17n+1,& y&=142n-17,\\
(r,s,u,v)&=(17,-1,17n-2,n).
\end{aligned}
$$

Then

$$
r^2-5s^2=4X,\qquad
u^2-5v^2=4H,\qquad
rv+su=2,
$$

and scalar reconstruction gives $y^2=4XH+5$. Thus the exact condition
$H=H_p(X)$ cannot be discarded. Fixed-field norm composition alone does not
close the prime-index family.

### 8.3 The BHV congruences are locally compatible for every $p$

Dirichlet's theorem supplies primes $q\equiv1\pmod{20p}$. Choose
$\lambda\in\mathbf F_q^\times$ of order $4p$, and set
$x=(\lambda+\lambda^{-1})/2$. Then $T_p(x)=0$, the order condition holds,
and $5$ is a square modulo $q$. CRT can combine this local base with
$X\equiv23\pmod{24}$. This does not construct an integer solution of (1);
it proves that order and five-split congruences alone cannot give a uniform
contradiction.

### 8.4 Exponent and search boundaries

The prime-index and $p\ge31$ hypotheses matter. At $p=1$, for example,
$X=551,y=47$ satisfies $y^2=4T_1(X)+5$.

As a discovery-only check, exact recurrence evaluation for
$p=31,37,41,43,47,53,59,61$ and target bases $X<5000$ found no square.
This finite scan is not used in any proof and is not a uniform certificate.

## 9. Lean coverage and trust ledger

The Lean companion contains no axiom declaration, no sorry, and no external
certificate type. It formalizes:

1. the polynomial norm-composition identity (19);
2. substitution of the two norms and forward reconstruction;
3. reverse reconstruction up to $y\mapsto-y$;
4. the sharp natural-number adjacent-square gap;
5. the raw congruence $q\mid T\Rightarrow y^2\equiv5\pmod q$;
6. the modulo-$5$ same-sign truth table;
7. all CRT outputs in (2); and
8. incompatibility of $q=4p\pm1$ with simultaneous
   $p,q\equiv\pm1\pmod5$.

The following remain accepted interfaces or future formalization work, and
are not kernel conclusions of the companion:

* quadratic reciprocity and the Legendre-symbol deduction in Section 2;
* the mod-$5$ Chebyshev identity (6) and coefficient formula (7);
* the half-angle identities and gcd ledger (10)--(15);
* algebraic integers, prime-ideal splitting, Minkowski's bound, class number
  one, unit adjustment, and ideal selection in Section 5;
* the two new mixed identities and gcd ledger (20)--(22), until added to a
  later Lean scalar layer;
* the BHV theorem, primitive-divisor rank, and torus argument in Section 7;
  and
* Dirichlet's theorem in the local-compatibility boundary test.

Every theorem in the Lean companion is followed by <code>#print axioms</code>.
These prints are a dependency audit, not a claim that BHV or class-group
arithmetic has been formalized.

## 10. Exact residual after this note

The strongest uniform conclusion proved here is the intersection of:

* the residue classes (2);
* the gcd ledgers (11)--(15) and (21)--(22);
* the exact fixed-field system (17), with $H=H_p(X)$, parity and positivity;
* the mixed identity (20);
* the square-gap exclusion (24); and
* a prime $q\mid H_p(X)$ satisfying (3), strengthened to (28) in the
  ramified-$5$ branch.

This is a smaller and more structured residual, but it is nonempty at the
level of every individual local or scalar projection tested above. No
accepted theorem cited here currently turns the package into an exclusion
for all primes $p\ge31$. Accordingly, this note makes no claim to finish the
rational-point theorem or the abc proof.
