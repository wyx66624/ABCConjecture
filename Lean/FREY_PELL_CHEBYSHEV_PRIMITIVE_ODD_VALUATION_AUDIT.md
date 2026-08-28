# Primitive and odd-valuation audit for the prime-index Chebyshev quotient

## 1. Scope and status

This note audits the primitive-divisor route for

$$
y^2=4T_p(X)+5,
\qquad
p=2m+1\ge 31\text{ prime},
\qquad
X>1,
\qquad
X\equiv23\pmod {24}.
\tag{1}
$$

Write

$$
T_p(X)=XH_p(X),
\qquad H_p(X)\in\mathbf Z[X^2].
\tag{2}
$$

The notation $H_m$ used in some recurrence ledgers denotes the same
polynomial when $p=2m+1$. This note uses $H_p$ in order to keep the prime
index visible.

The conclusions are deliberately limited:

1. the Bilu--Hanrot--Voutier theorem applies and supplies a primitive prime
   $q\mid H_p(X)$;
2. the reciprocal Chebyshev structure strengthens the usual rank congruence
   to $4p\mid q-\chi_q$;
3. equation (1) forces $q\equiv\pm1\pmod5$;
4. BHV alone does not control $v_q(H_p(X))$, but Bennett--Walsh/Cohn exclude
   both exceptional square classes in Granville Corollary 5 and therefore
   supply a (possibly different) primitive $q$ of odd exact valuation;
5. even an odd valuation is compatible with the split norm in
   $\mathbf Q(\sqrt5)$ and therefore does not close (1).

Thus the earlier valuation gap is now closed, but the global
shifted-square gap is not.  This remains an obstruction and trust-boundary
audit, not a uniform exclusion of (1).

## 2. Lucas normalization

Put

$$
D=X^2-1,
\qquad
\lambda=X+\sqrt D,
\qquad
\lambda^{-1}=X-\sqrt D.
\tag{3}
$$

Define the Lucas sequence

$$
L_0=0,
\qquad L_1=1,
\qquad L_{n+2}=2XL_{n+1}-L_n.
\tag{4}
$$

Then

$$
L_n=\frac{\lambda^n-\lambda^{-n}}{\lambda-\lambda^{-1}}
    =U_{n-1}(X),
\tag{5}
$$

where the expression on the right uses the Chebyshev polynomial of the
second kind. Its companion sequence is

$$
V_n=\lambda^n+\lambda^{-n}=2T_n(X).
\tag{6}
$$

In particular,

$$
L_{2p}=L_pV_p=2T_p(X)L_p,
\qquad
L_2=2X.
\tag{7}
$$

## 3. The two exact cyclotomic identities

### 3.1 The Lucas cyclotomic block has index $2p$

For the sequence (4), define its cyclotomic block by

$$
\Phi_n^{L}:=\prod_{d\mid n}L_d^{\mu(n/d)}.
\tag{8}
$$

These products are integers. For an odd prime $p$, the four divisors of
$2p$ and their Moebius exponents give

$$
\Phi_{2p}^{L}
=\frac{L_{2p}L_1}{L_2L_p}.
\tag{9}
$$

Using (7),

$$
\boxed{\Phi_{2p}^{L}=\frac{T_p(X)}X=H_p(X).}
\tag{10}
$$

The Lucas-cyclotomic index is therefore $2p$, not $p$.

### 3.2 The classical cyclotomic index in $\lambda$ is $4p$

For an odd prime $p$,

$$
\Phi_{2p}(Z)=\frac{Z^p+1}{Z+1}.
\tag{11}
$$

Consequently,

$$
\begin{aligned}
H_p(X)
&=\frac{\lambda^p+\lambda^{-p}}{\lambda+\lambda^{-1}}\\
&=\lambda^{-(p-1)}\frac{\lambda^{2p}+1}{\lambda^2+1}\\
&=\lambda^{-(p-1)}\Phi_{2p}(\lambda^2).
\end{aligned}
\tag{12}
$$

Since $p$ is odd,

$$
\Phi_{2p}(Z^2)=\Phi_{4p}(Z),
$$

and hence

$$
\boxed{H_p(X)=\lambda^{-(p-1)}\Phi_{4p}(\lambda).}
\tag{13}
$$

Equations (10) and (13) are compatible: the ratio in the Lucas sequence is
$\lambda/\lambda^{-1}=\lambda^2$, so Lucas index $2p$ corresponds to
classical order $4p$ for $\lambda$.

## 4. The equivalent Lehmer term

Set

$$
\alpha=\lambda,
\qquad
\beta=-\lambda^{-1}.
\tag{14}
$$

Then

$$
(\alpha+\beta)^2=4(X^2-1)=:A,
\qquad
\alpha\beta=-1=:B.
\tag{15}
$$

The Lehmer parameters satisfy

$$
A>0,
\qquad A-4B=4X^2>0,
\qquad \gcd(A,B)=1,
\qquad (A,B)\equiv(0,3)\pmod4.
\tag{16}
$$

For odd $p$, the $p$-th Lehmer term is

$$
P_p(\alpha,\beta)
=\frac{\alpha^p-\beta^p}{\alpha-\beta}
=\frac{\lambda^p+\lambda^{-p}}{\lambda+\lambda^{-1}}
=H_p(X).
\tag{17}
$$

This gives a direct application of the Lehmer form of the primitive-divisor
theorem at index $p$.

## 5. The accepted BHV interface

The theorem of Bilu, Hanrot, and Voutier states that every Lucas or Lehmer
number of index greater than $30$ has a primitive divisor. The pair (14)
satisfies the Lehmer-pair hypotheses: the two parameters in (15) are
coprime nonzero rational integers, and $\alpha/\beta=-\lambda^2$ is not a
root of unity because $X>1$.

Since $p\ge31$, there is a rational prime $q$ which divides $H_p(X)$ but
does not divide

$$
(\alpha^2-\beta^2)^2P_1P_2\cdots P_{p-1}.
\tag{18}
$$

Here

$$
(\alpha^2-\beta^2)^2
=(\lambda^2-\lambda^{-2})^2
=16X^2(X^2-1).
\tag{19}
$$

Therefore

$$
q\mid H_p(X),
\qquad
q\nmid 2X(X^2-1).
\tag{20}
$$

This use of BHV is an accepted external theorem. It is not a consequence of
the elementary recurrence ledger and is not presently formalized in Lean.

## 6. Exact order and the strengthened congruence

Reduce in $\mathbf F_{q^2}$. Because of (19), the reduction is separable and
$\lambda$ is a unit. Primitivity at the prime Lehmer index $p$ says that

$$
\frac\alpha\beta=-\lambda^2
$$

has exact order $p$. Equivalently,

$$
\lambda^{2p}=-1.
\tag{21}
$$

Because $-\lambda^2$ has odd order $p$ while $-1$ has order $2$, the order
of $\lambda^2$ is exactly $2p$. It follows that the order of $\lambda$ is
exactly $4p$.

Let

$$
\chi_q=\left(\frac{D}{q}\right)
       =\left(\frac{X^2-1}{q}\right)\in\{1,-1\}.
\tag{22}
$$

If $\chi_q=1$, then $\lambda\in\mathbf F_q^\times$, whose order is
$q-1$. If $\chi_q=-1$, Frobenius interchanges the two roots of
$Z^2-2XZ+1$, so

$$
\lambda^q=\lambda^{-1}
$$

and $\lambda$ belongs to the norm-one torus of order $q+1$. Thus

$$
\boxed{4p\mid q-\chi_q.}
\tag{23}
$$

In particular,

$$
q=4kp+1\quad\text{or}\quad q=4kp-1
\qquad(k\ge1),
\tag{24}
$$

and $q\ge4p-1$. The tempting boundary values $q=2p-1$ and $q=2p+1$
are impossible: neither adjacent torus has order divisible by $4p$ at those
values. The same order argument excludes $q=p$; equation (19) and
primitivity exclude $q=2$.

## 7. The five-split condition on the primitive prime

Assume now that $(X,y)$ satisfies (1). Since $q\mid H_p(X)$, reduction of
(1) modulo $q$ gives

$$
y^2\equiv5\pmod q.
\tag{25}
$$

The lower bound $q\ge4p-1$ gives $q\ne5$. Hence

$$
\left(\frac5q\right)=1.
$$

Quadratic reciprocity is sign-free for $5$, and therefore

$$
\boxed{q\equiv1\text{ or }-1\pmod5.}
\tag{26}
$$

In the separate branch where the elementary five-adic ledger proves
$p\equiv\pm1\pmod5$, the four possibilities $q=4p\pm1$ are incompatible
with (26). In that branch one may strengthen $q\ge4p-1$ to
$q\ge8p-1$. This size refinement remains only a necessary condition.

## 8. BHV does not control the valuation

BHV asserts existence of a primitive prime divisor. It does not assert

$$
v_q(H_p(X))=1
$$

or even that this valuation is odd. The order calculation in Section 6 is
entirely modulo $q$ and likewise cannot determine the lift modulo $q^2$.

The following construction shows that this is a genuine local obstruction,
not merely a gap in the preceding calculation.

### 8.1 A primitive simple root modulo $q$

Fix an odd prime $p\ge31$. By Dirichlet's theorem, choose a prime

$$
q\equiv1\pmod{20p}.
\tag{27}
$$

Choose $\lambda_0\in\mathbf F_q^\times$ of exact order $4p$, and set

$$
x_0=\frac{\lambda_0+\lambda_0^{-1}}2.
\tag{28}
$$

The order condition gives $x_0\ne0$ and $x_0^2\ne1$. Moreover,

$$
2T_p(x_0)=\lambda_0^p+\lambda_0^{-p}=0,
$$

so

$$
H_p(x_0)=0.
\tag{29}
$$

Indeed $-1=\lambda_0^{2p}$, so

$$
-\lambda_0^2=\lambda_0^{2p+2},
\qquad
\operatorname{ord}(-\lambda_0^2)
=\frac{4p}{\gcd(4p,2p+2)}=p.
$$

Thus $q$ is primitive at the $p$-th Lehmer term, equivalently at the
$2p$-th Lucas cyclotomic block.

The root (29) is simple. Indeed,

$$
T_p'(Z)=pU_{p-1}(Z),
\tag{30}
$$

and the Chebyshev identity

$$
T_p(Z)^2-(Z^2-1)U_{p-1}(Z)^2=1
\tag{31}
$$

shows that $U_{p-1}(x_0)\ne0$ modulo $q$. Since $q\ne p$ and
$x_0\ne0$,

$$
H_p'(x_0)=\frac{T_p'(x_0)}{x_0}\ne0\pmod q.
\tag{32}
$$

### 8.2 Every positive valuation occurs

Let $e\ge1$. Hensel's lemma lifts $x_0$ to a root $r$ modulo
$q^{e+1}$:

$$
H_p(r)\equiv0\pmod {q^{e+1}},
\qquad
H_p'(r)\not\equiv0\pmod q.
$$

Choose an integer $X_e$ satisfying

$$
X_e\equiv r+q^e\pmod {q^{e+1}}.
\tag{33}
$$

Taylor expansion modulo $q^{e+1}$ gives

$$
H_p(X_e)\equiv q^eH_p'(r)\pmod {q^{e+1}},
$$

and hence

$$
\boxed{v_q(H_p(X_e))=e.}
\tag{34}
$$

Because $q$ is coprime to $24$, CRT can impose simultaneously

$$
X_e\equiv23\pmod {24}.
\tag{35}
$$

There are infinitely many positive integer representatives of the resulting
class. The reduction modulo $q$ remains $x_0$, so $q$ remains primitive.

Finally, (27) gives $(5/q)=1$. Since

$$
5+4X_eH_p(X_e)\equiv5\pmod q,
$$

the equation

$$
Y^2=5+4X_eH_p(X_e)
$$

has a solution in $\mathbf Z_q$. Thus the primitive order, the five-split
condition, the target base congruence, local solvability of (1), and either
parity of $v_q(H_p(X_e))$ are mutually compatible.

This construction does not produce a global integer solution of (1). It
proves that no argument using only these local data can force odd
valuation.

## 9. Granville's odd-valuation theorem and conjectural boundary

Granville writes a Lucas sequence as

$$
x_{n+2}=b x_{n+1}+c x_n,
\qquad x_0=0,
\qquad x_1=1.
\tag{36}
$$

His Theorem 3 assumes

$$
\gcd(b,c)=1,
\qquad
c\equiv2\pmod4,
\qquad
b^2+4c>0.
\tag{37}
$$

Under those hypotheses, every term except the explicitly listed small
indices $1,2,3,6$ has a primitive prime divisor occurring to an odd power.

For (4),

$$
b=2X,
\qquad c=-1\equiv3\pmod4,
\qquad b^2+4c=4(X^2-1)>0.
\tag{38}
$$

Thus the decisive congruence in (37) fails. Granville's Corollary 6.4 treats
the class $b$ even, $c$ odd; for an even cyclotomic index $n>2$ which is not
a power of two, its Jacobi-symbol conclusion has the non-obstructive sign
$+1$. Our index $n=2p$ is exactly in this boundary case.

Section 7 of that paper conjectures that, for every non-periodic Lucas
sequence, there is a sequence-dependent threshold $n_x$ beyond which every
term has a primitive divisor of odd valuation. Only the special class (37)
is proved there with a uniform small threshold. The general statement is
conjectural, and even its stated threshold is allowed to depend on $X$.
Therefore it cannot be invoked for the moving family (4).

This failure concerns the direct application of Granville Theorem 3.  It
does not prevent using the general Corollary 5 after independently excluding
its two exceptional square shapes; that is the Bennett--Walsh/Cohn repair in
the next section.

## 10. What the general cyclotomic ledger still gives

Granville's Corollaries 3--5 contain a useful conditional classification
which does not require (37). Suppose that $H_p=\Phi_{2p}^{L}$ has no
primitive prime factor of odd valuation.

At index $2p$, a characteristic prime cannot be a discriminant prime:

* $2$ already occurs at $L_2=2X$;
* for an odd prime $r\mid4(X^2-1)$, the first Lucas rank is $r$, not the
  composite index $2p$.

Consequently every characteristic prime at index $2p$ is primitive, and the
hypothesis of Granville's Corollary 5 applies. Since $2p\ne6,12$, it says
that

$$
\Phi_{2p}^{L}=z^2
$$

or

$$
\Phi_{2p}^{L}=r z^2,
\tag{39}
$$

where $r^a\mid2p$ and $(2p)/r^a\le r+1$. The candidate $r=2$ would require
$p\le3$, so for $p\ge31$ only $r=p$ survives. Hence

$$
\boxed{
\text{no odd-valuation primitive divisor}
\Longrightarrow
H_p(X)=z^2\text{ or }H_p(X)=pz^2.}
\tag{40}
$$

The companion audit
`FREY_PELL_CHEBYSHEV_BENNETT_WALSH_ODD_VALUATION.md` now excludes both
alternatives in (40).  Its Pell-coordinate argument writes
$X=B u^2$ and $X=R_k$ in the trace sequence of the fundamental unit of the
squarefree kernel of $X^2-1$.  Bennett--Walsh Theorem 1.2 and Cohn's
coefficient-one theorem exclude the square shape.  For the $p$-times-square
shape, the proof splits into $p\mid B$ and $p\nmid B$; the odd-multiple
occurrence law and Bennett--Walsh Lemma 5.1 handle the latter without any
parity assumption on $k$.  Consequently contraposition of (40) gives

$$
\boxed{H_p(X)\text{ has a primitive prime divisor of odd exact valuation}.}
\tag{40a}
$$

This conclusion holds for every prime $p\ge31$ and $X>1$; it does not use
equation (1).

Equation (1), including its fixed-$\mathbf Q(\sqrt5)$ reconstruction, must
not itself be used to infer either square shape in (40).  The two shapes are
excluded independently; they are not consequences of the shifted equation.
For example, the norm ledger has the form

$$
4H_p(X)=u^2-5v^2,
$$

which is not a square or $p$-times-square assertion.

## 11. Square and near-square theorem applicability ledger

The following comparisons record why the initially reviewed termwise
theorems did not settle the alternatives in (40).  They are now superseded
for this purpose by the combined argument below; none of them turns (1)
itself into a square-shape assertion.

### 11.0 Bennett--Walsh and Cohn

Bennett--Walsh Corollary 1.5 directly gives
$H_p(X)\ne z^2$ for prime $p$ and $X>1$.  Independently, their Theorem 1.2,
the squarefree-coefficient occurrence fact in the proof of Lemma 3.3,
Lemma 5.1, and Cohn's 1997 coefficient-one theorem give both this exclusion
and $H_p(X)\ne pz^2$.  The complete endpoint and squarefree-kernel ledger is
in the companion audit cited after (40).  This is uniform in the moving
Pell discriminant and prime index, so it repairs the limitation recorded in
the earlier subsections.

### 11.1 Rotkiewicz

Rotkiewicz's theorem R1 excludes

$$
P_p=pz^2
$$

in the parameter class

$$
(A,B)\equiv(0,3)\pmod4
$$

only under the additional Jacobi--Kronecker condition

$$
\left(\frac BA\right)=1.
\tag{41}
$$

Our parameters (15) have the required residue class, but (41) is not forced
by $X\equiv23\pmod {24}$. With $B=-1$, for example,

$$
\begin{array}{c|c|c}
X&A=4(X^2-1)&(-1/A)\\ \hline
23&2^6\cdot33&+1\\
71&2^6\cdot315&-1
\end{array}
$$

under the convention used in the cited Lehmer literature. Both bases are
$23$ modulo $24$. R1 therefore gives only a subcase exclusion of the second
alternative in (40).

Rotkiewicz's R2 square exclusion for even first parameter instead requires

$$
(A,B)\equiv(0,1)\pmod4,
$$

which is not our class.

### 11.2 Luca--Walsh and Yuan--Li

The Luca--Walsh square and $p$-times-square results used in this context
assume

$$
(A,B)\equiv(2,1)\pmod4
$$

together with their stated Jacobi-symbol condition. This does not match
$(0,3)$.

Yuan--Li prove analogous exclusions for

$$
(A,B)\equiv(2,3)\pmod4
$$

and the stated symbol condition. Again, $A=4(X^2-1)$ is $0$ modulo $4$, so
their Theorems 1.1 and 1.2 do not apply. Their quotation of Rotkiewicz is
also a convenient source for the exact hypotheses in Section 11.1.

### 11.3 McDaniel and Ribenboim--McDaniel

McDaniel's *Square Lehmer Numbers* assumes in its main square-term analysis
that both Lehmer parameters $R$ and $Q$ are odd. Our first parameter
$4(X^2-1)$ is even.

Ribenboim--McDaniel do treat Lucas sequences with an even first parameter,
and the standard sequence (4) has parameters $(2X,1)$. Their object,
however, is a Lucas term $L_n(2X,1)$ itself. The target here is the quotient

$$
H_p=\Phi_{2p}^{L}=\frac{V_p}{2X},
$$

not a term $L_n$. Their square-term classification cannot be transferred to
this quotient.

### 11.4 Other fixed-sequence perfect-power results

Taken one fixed recurrence at a time, the classical Pell/quartic results do
not by themselves address a moving cyclotomic quotient.  The earlier audit
stopped at that observation.  Section 11.0 explains the missing uniform
reparameterization: Bennett--Walsh Theorem 1.2 is applied separately to the
squarefree coefficient of $X$, while Cohn supplies its coefficient-one
endpoint.

Likewise, the Bugeaud--Mignotte--Siksek perfect-power theorems determine
perfect powers in the Fibonacci/Lucas sequences or in another specified
fixed recurrence. They are not uniform theorems for all parameters
$2X$, and their target is not $H_p$.

The Bremner--Tzanakis work on square or almost-square Lucas terms fixes a
small index, or fixes an index and square class before studying the
resulting curve. It does not supply a moving-index theorem for
$p\ge31$.

### 11.5 Squarefree values of polynomials

Average or positive-density theorems about squarefree values of a fixed
polynomial have the wrong quantifiers. They do not say that every $X$
selected by (1) gives a squarefree value, or even that one prime divisor of
that selected value has odd exponent. Here the degree and polynomial also
move with $p$. General squarefree-value statements in unrestricted high
degree commonly require an abc-type hypothesis; no such conjectural input
is admitted in this audit.

For each fixed $p$, generic finiteness theorems for the hyperelliptic curves
attached to $H_p(X)=z^2$ remain non-uniform and generally ineffective.  They
are no longer needed for the square exclusion, which follows uniformly from
Bennett--Walsh Corollary 1.5.

## 12. Why an odd valuation still does not close the norm equation

Let $q\mid H_p(X)$ be the odd-valuation primitive prime now supplied by
(40a).  Under equation (1), (26) says that $q$ splits in
$K=\mathbf Q(\sqrt5)$:

$$
(q)=\mathfrak q\,\overline{\mathfrak q}.
$$

Equation (1) is the norm identity

$$
(y+\sqrt5)(y-\sqrt5)=4XH_p(X).
\tag{42}
$$

Primitivity gives $q\ne2,5$ and $q\nmid X$: primes dividing $2X$ already
occur at $L_2$, a discriminant prime cannot first occur at the composite
index $2p$, and the rank of $5$ is at most six rather than $2p\ge62$.
Thus the same prime ideal above $q$ cannot divide both conjugate
factors on the left of (42): their difference is $2\sqrt5$.  If
$q^e\mathbin\Vert H_p(X)$, then, after labeling the two primes, the ideal
allocation must put
$\mathfrak q^e$ in one factor and
$\overline{\mathfrak q}^{e}$ in the other.  The conjugate prime ideals occur
symmetrically, but neither one occurs in both factors.  A principal element
in a split quadratic field may have an arbitrary exponent at either prime
ideal.

Consequently neither principality nor the class-number-one property of
$\mathbf Q(\sqrt5)$ imposes evenness of this exponent. The same observation
applies to the refined norm equation

$$
u^2-5v^2=4H_p(X).
$$

The odd-valuation primitive divisor strengthens the squareclass ledger, but
it does not contradict the split norm and does not prove that (1) has no
integer solutions.

## 13. Strongest justified proposition and non-conclusion

The unconditional external-plus-elementary conclusion may be stated as
follows.

> **Odd-valuation primitive-prime constraint.** Let $p\ge31$ be an odd
> prime, let $X>1$, and suppose that $y^2=4T_p(X)+5$. Then there are a
> prime $q$ and an odd positive integer $e$ such that
> $$
> q^e\mid H_p(X),\qquad q^{e+1}\nmid H_p(X),
> $$
> and
> $$
> q\nmid2pX(X^2-1),
> \qquad
> 4p\mid q-\left(\frac{X^2-1}{q}\right),
> \qquad
> q\equiv\pm1\pmod5.
> $$

BHV alone still makes no assertion about the parity of its chosen witness.
The Bennett--Walsh/Cohn--Granville combination supplies an odd-valuation
primitive witness, while the split norm accepts that odd valuation.

A genuinely closing nonlocal lemma would therefore have to connect the
Frobenius or ideal allocation of a new prime to some additional global
condition beyond split norm representability. Section 8 shows that a purely
local version of such a lemma cannot hold.

## 14. Trust boundary

The argument has three distinct layers.

### 14.1 Elementary and suitable for kernel formalization

The following are polynomial, recurrence, finite-field, or congruence
statements:

* the identities (7), (10), (12), and (13);
* the Lehmer reconstruction (14)--(17);
* conditional on a primitive $q$, the order-$4p$ argument and (23);
* conditional on equation (1), the five-split conclusion (26);
* the derivative and simple-root calculation (30)--(32);
* the Taylor step giving exact valuation in (34), once a Hensel lift is
  supplied.

These statements do not need class groups, abc, or a search certificate.

### 14.2 Accepted mathematical interfaces

The following results are cited rather than re-proved:

* Bilu--Hanrot--Voutier primitive divisors;
* Granville's characteristic/primitive-factor classification and his
  special odd-valuation theorem;
* Bennett--Walsh Theorem 1.2, the occurrence fact in the proof of Lemma
  3.3, Lemma 5.1, and Corollary 1.5;
* Cohn's 1997 theorem on $x^4-Dy^2=1$;
* Rotkiewicz, Luca--Walsh, Yuan--Li, McDaniel, and
  Ribenboim--McDaniel square-term results;
* Dirichlet's theorem and Hensel's lemma in the local obstruction
  construction.

Granville's Section 7 statement is recorded only as a conjecture. No
squarefree-value conjecture, abc consequence, or unproved uniformity is used.

### 14.3 What is not claimed

This audit does not claim:

* that an arbitrarily selected BHV witness has odd valuation (the combined
  theorem supplies at least one odd-valuation primitive witness);
* that equation (1) makes $H_p$ a square or $p$ times a square;
* that an odd valuation contradicts a $\mathbf Q(\sqrt5)$ norm;
* that the local construction gives an integer solution of (1);
* or that the prime-index family has been uniformly excluded.

## 15. Primary sources

* Y. Bilu, G. Hanrot, and P. M. Voutier, “Existence of primitive divisors
  of Lucas and Lehmer numbers,” *J. reine angew. Math.* **539** (2001),
  75--122, [DOI 10.1515/crll.2001.080](https://doi.org/10.1515/crll.2001.080).
* A. Granville, “Primitive prime factors in second-order linear recurrence
  sequences,” *Acta Arith.* **155** (2012), 431--452,
  [author PDF](https://dms.umontreal.ca/~andrew/PDF/PrimitivePrimeFactors.pdf),
  [DOI 10.4064/aa155-4-7](https://doi.org/10.4064/aa155-4-7).
* M. A. Bennett and G. Walsh, “The Diophantine equation
  $b^2X^4-dY^2=1$,” *Proc. Amer. Math. Soc.* **127** (1999), 3481--3491,
  [author PDF](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf),
  [DOI 10.1090/S0002-9939-99-05041-8](https://doi.org/10.1090/S0002-9939-99-05041-8).
* J. H. E. Cohn, “The Diophantine equation $x^4-Dy^2=1$, II,”
  *Acta Arith.* **78** (1997), 401--403,
  [DOI 10.4064/aa-78-4-401-403](https://doi.org/10.4064/aa-78-4-401-403).
* A. Rotkiewicz, “Applications of Jacobi's symbol to Lehmer's numbers,”
  *Acta Arith.* **42** (1983), 163--187,
  [publisher page and PDF](https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/42/22/103738/applications-of-jacobi-s-symbol-to-lehmer-s-numbers),
  [DOI 10.4064/aa-42-2-163-187](https://doi.org/10.4064/aa-42-2-163-187).
* F. Luca and P. G. Walsh, “Squares in Lehmer sequences and some
  Diophantine applications,” *Acta Arith.* **100** (2001), 47--62,
  [publisher PDF](https://www.impan.pl/shop/en/publication/transaction/download/product/83508),
  [DOI 10.4064/aa100-1-4](https://doi.org/10.4064/aa100-1-4).
* P. Yuan and Y. Li, “Squares in Lehmer sequences and the Diophantine
  equation $Ax^4-By^2=2$,” *Acta Arith.* **139** (2009), 275--302,
  [publisher PDF](https://www.impan.pl/shop/publication/transaction/download/product/83333),
  [DOI 10.4064/aa139-3-6](https://doi.org/10.4064/aa139-3-6).
* W. L. McDaniel, “Square Lehmer numbers,” *Colloq. Math.* **66** (1993),
  85--93, [journal PDF](https://matwbn.icm.edu.pl/ksiazki/cm/cm66/cm6619.pdf).
* P. Ribenboim and W. L. McDaniel, “Squares in Lucas sequences having an
  even first parameter,” *Colloq. Math.* **78** (1998), 29--34,
  [journal PDF](https://matwbn.icm.edu.pl/ksiazki/cm/cm78/cm7813.pdf).
* Y. Bugeaud, M. Mignotte, and S. Siksek, “Classical and modular approaches
  to exponential Diophantine equations I. Fibonacci and Lucas perfect
  powers,” *Ann. of Math.* **163** (2006), 969--1018,
  [journal page](https://annals.math.princeton.edu/2006/163-3/p05).
* A. Bremner and N. Tzanakis, “On squares in Lucas sequences,”
  [arXiv:math/0610732](https://arxiv.org/abs/math/0610732), and “Lucas
  sequences whose $n$th term is a square or an almost square,”
  [arXiv:math/0701252](https://arxiv.org/abs/math/0701252).
