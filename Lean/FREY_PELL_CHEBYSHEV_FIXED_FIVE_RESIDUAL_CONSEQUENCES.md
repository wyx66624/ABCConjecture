# Fixed-five norm residual: exact elimination, gcd, and pointwise floor kernels

## 1. Scope

This note records the consequences of the integral scalar system

$$
\begin{aligned}
r^2-5s^2&=4X,\\
u^2-5v^2&=4H,\\
rv+su&=2.
\end{aligned}
\tag{1}
$$

In the prime-index Chebyshev application one has $H=H_p(X)=T_p(X)/X$.
The derivation of (1) from an ideal factorization in
$\mathbf Q(\sqrt5)$ is an accepted mathematical interface elsewhere; it is
not an assumption hidden in the Lean module accompanying this note.  Every
result below is a theorem of elementary integer arithmetic conditional only
on the equations and explicitly displayed parity or reduction hypotheses.

The outcome is a stronger exact residual, not an exclusion of all remaining
prime indices and not a proof of the abc conjecture.

## 2. Exact elimination

Multiplying the first norm equation by $v^2$ and the second by $s^2$ gives

$$
\begin{aligned}
4(Xv^2-Hs^2)
&=(r^2-5s^2)v^2-(u^2-5v^2)s^2\\
&=r^2v^2-s^2u^2\\
&=(rv-su)(rv+su).
\end{aligned}
\tag{2}
$$

Substitution of $rv+su=2$ and elimination of either $rv$ or $su$ yields

$$
\boxed{
Xv^2=Hs^2-su+1=Hs^2+rv-1.}
\tag{3}
$$

The Lean theorems
`pellFixedFiveResidual_scaledElimination` and
`pellFixedFiveResidual_mixedCoordinateIdentities` prove (2) and (3).  The
two named projection theorems expose each equality separately for later
rewriting.

## 3. Congruences and explicit Bezout certificates

Reducing the two forms of (3) modulo the cross coordinates gives

$$
Xv^2\equiv1\pmod s,
\qquad
Hs^2\equiv1\pmod v.
\tag{4}
$$

More strongly, (3) rearranges to the explicit Bezout identities

$$
\begin{aligned}
(u-Hs)s+v^2X&=1,\\
(r-Xv)v+s^2H&=1.
\end{aligned}
\tag{5}
$$

Consequently

$$
\gcd(s,X)=1,
\qquad
\gcd(v,H)=1.
\tag{6}
$$

No nonzero, positivity, or parity hypothesis is needed for (4)--(6).  In
Lean, (6) is stated as `IsCoprime s X` and `IsCoprime v H`, so the Bezout
content is part of the kernel theorem rather than an informal divisibility
argument.

## 4. The remaining gcd ledger

Integral coordinates of elements of
$\mathbf Z[(1+\sqrt5)/2]$ satisfy

$$
r\equiv s\pmod2,
\qquad
u\equiv v\pmod2.
\tag{7}
$$

The cross equation alone implies

$$
\gcd(r,s)\mid2,
\qquad
\gcd(u,v)\mid2,
\tag{8}
$$

and hence both positive gcds are at most two.  For example,
$\gcd(r,s)$ divides both $rv$ and $su$, and therefore divides their sum.

The parity data sharpen the cross-coordinate pairs to

$$
\boxed{
\gcd(s,v)=1,
\qquad
\gcd(r,u)=1.}
\tag{9}
$$

Here is the exact argument formalized in Lean.  In the reusable abstraction
$ac+bd=2$, assume $a\equiv d\pmod2$ and $b\equiv c\pmod2$.  The positive
gcd $g=\gcd(a,b)$ divides $2$, so $g=1$ or $g=2$.  If $g=2$, then $a,b$
are even; the parity relations make $c,d$ even as well, forcing
$ac+bd$ to be divisible by $4$, contrary to its value $2$.  Thus $g=1$.
The two substitutions

$$
(a,b,c,d)=(s,v,u,r),
\qquad
(a,b,c,d)=(r,u,v,s)
$$

give (9).  This proof explains why the parity hypotheses appear explicitly
in the signatures of `pellFixedFiveResidual_isCoprime_s_v` and
`pellFixedFiveResidual_isCoprime_r_u`, while they are absent from (6).

## 5. Pointwise floor-reduction kernel

The unit action in $\mathbf Q(\sqrt5)$ permits a pointwise reduced
representative.  After the sign normalization relevant to the residual, put
$a=s$ and $b=-v$.  Then the cross equation is $au-rb=2$, and we retain only
the following natural-number data:

$$
1\le a,
\qquad
a^2<X,
\qquad
r^2=4X+5a^2,
\qquad
a^2H=Xb^2+rb+1.
\tag{10}
$$

These hypotheses first force $X\ge2$ and

$$
r<2X.
\tag{11}
$$

Indeed, $a^2\le X-1$ gives

$$
r^2\le9X-5<4X^2=(2X)^2
$$

for every $X\ge2$.  The last strict inequality is checked separately at
$X=2$ and follows from $X^2\ge3X$ for $X\ge3$.

The last equation in (10) and nonnegativity immediately give the lower
bound in

$$
\boxed{
Xb^2<a^2H<X(b+1)^2.}
\tag{12}
$$

For the upper bound, the exact difference is

$$
X(b+1)^2-a^2H
=b(2X-r)+(X-1)>0,
\tag{13}
$$

using (11) and $X\ge2$.  Thus (12) is the strict integer-square sandwich
underlying the pointwise formula
$b=\lfloor a\sqrt{H/X}\rfloor$.  The Lean theorem
`pellFixedFiveResidual_pointwiseFloorSandwich` proves (12) directly over
$\mathbf N`; it deliberately stops before importing analytic square-root
and floor machinery.  It is pointwise: it does not bound $a$, $b$, $X$, or
$p$ uniformly.

The condition $1\le a$ is essential.  A statement using only a lower bound
on $X$ would incorrectly admit degenerate reduced representatives such as
$X=25$ with first factor $5$ and $a=0$.

## 6. Lean theorem inventory

The module
`IUTThreeClosures/FreyPellChebyshevFixedFiveResidualConsequences.lean`
contains:

1. `pellFixedFiveResidual_scaledElimination`;
2. `pellFixedFiveResidual_mixedCoordinateIdentities` and its two projections;
3. `pellFixedFiveResidual_X_mul_v_sq_mod_s` and
   `pellFixedFiveResidual_H_mul_s_sq_mod_v`;
4. `pellFixedFiveResidual_isCoprime_s_X` and
   `pellFixedFiveResidual_isCoprime_v_H`;
5. the reusable parity lemma
   `pellFixedFiveResidual_isCoprime_of_cross_and_parity` and its two residual
   specializations;
6. `pellFixedFiveResidual_sameFactorGcds_dvd_two` and its numerical-bound
   corollary; and
7. `pellFixedFiveResidual_pointwise_r_lt_two_mul_X` and
   `pellFixedFiveResidual_pointwiseFloorSandwich`.

Every theorem is followed by `#print axioms` in the source file.

## 7. Trust boundary and remaining gap

The Lean layer uses only Mathlib's integer/natural-number algebra,
divisibility, gcd, congruence, and arithmetic tactics.  Its axiom audit may
show the standard Lean foundations `propext`, `Quot.sound`, and
`Classical.choice`; it contains no `sorryAx`, custom axiom, BHV theorem,
class-group computation, abc statement, or theorem equivalent to the desired
uniform exclusion.

The following inputs remain outside this module:

* deriving (1), parity, positivity, and the chosen reduced representative
  from the accepted ideal factorization in the fixed quadratic field;
* identifying $H$ with the prime-index Chebyshev quotient $H_p(X)$;
* the Bilu--Hanrot--Voutier primitive-divisor input; and
* any argument turning the exact gcd/floor residual into a contradiction
  uniformly for all primes $p\ge31$.

Accordingly, the formalized results shrink and rigidify the active residual
but do not close it.
