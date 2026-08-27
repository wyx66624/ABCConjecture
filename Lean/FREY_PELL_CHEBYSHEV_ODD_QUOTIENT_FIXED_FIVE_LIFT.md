# Odd-quotient depth inside the fixed-five residual

## 1. Outcome

Let

$$
p=2m+1,\qquad c=(-1)^m p,\qquad
H=H_p(X)=\frac{T_p(X)}X.
$$

The exact odd-quotient congruence is

$$
H\equiv c\pmod{X^2}.
\tag{1}
$$

Combining (1) with the fixed-five residual produces two genuinely new
necessary conditions.

1. In the ramified branch $X=5A$,

   $$
   \boxed{Ac\equiv1,6,\text{ or }11\pmod{25}.}
   \tag{2}
   $$

   Thus only three of the five lifts of the old modulo-five class survive.
2. In the mixed-coordinate normalization, if

   $$
   a^2H=Xb^2+rb+1,
   \qquad
   b=\left\lfloor a\sqrt{H/X}\right\rfloor,
   \tag{3}
   $$

   then

   $$
   Xb^2+rb+1\equiv ca^2\pmod{X^2}.
   \tag{4}
   $$

   Away from $5\mid X$, equation (4) determines $b$ in at most one residue
   class modulo $X^2$.

Condition (2) is strictly stronger than the five-split and CRT conditions
previously recorded.  Neither (2) nor (4) is presently a uniform exclusion.

## 2. The ramified-five second digit

Assume $X=5A$ and

$$
y^2=4XH+5.
\tag{5}
$$

Equation (1) supplies an integer $K$ with

$$
H=c+X^2K=c+25A^2K.
\tag{6}
$$

Equation (5) implies $5\mid y$; write $y=5z$.  Dividing (5) by $5$ gives

$$
5z^2=4AH+1.
$$

Substitution of (6) yields

$$
4Ac+1=5\bigl(z^2-20A^3K\bigr).
\tag{7}
$$

Put $q=z^2-20A^3K$.  Then

$$
q\equiv z^2\pmod5,
$$

so $q$ is $0$, $1$, or $4$ modulo $5$.  Reducing
$4Ac+1=5q$ modulo $25$ gives respectively

$$
Ac\equiv6,\quad1,\quad11\pmod{25},
$$

which is exactly (2).  Notice that (2) itself implies
$Ac\equiv1\pmod5$ and excludes $5\mid A$; it therefore recovers the first
ramified digit and $v_5(X)=1$ before sharpening them.

The Lean theorem `ramifiedFive_secondDigit_of_modSq` proves this scalar
argument.  The theorem
`pellOddChebyshevQuotient_ramifiedFive_secondDigit` substitutes the actual
odd quotient and its kernel-checked congruence (1).

### 2.1 Concrete active-prime classes

For $p=31$, one has $m=15$ and $c=-31\equiv19\pmod{25}$, whose inverse
modulo $25$ is $4$.  Hence

$$
A\equiv4,19,24\pmod{25},
\qquad
X\equiv20,95,120\pmod{125}.
\tag{8}
$$

The old condition was only $X\equiv20\pmod{25}$, whose five lifts modulo
$125$ are $20,45,70,95,120$.  Thus (8) newly excludes $45$ and $70$.

For $p=41$, $c=41\equiv16\pmod{25}$ and $16^{-1}\equiv11\pmod{25}$.
Therefore

$$
A\equiv11,16,21\pmod{25},
\qquad
X\equiv55,80,105\pmod{125},
\tag{9}
$$

excluding the old lifts $X\equiv5,30\pmod{125}$.

## 3. Why the second digit is not a restatement

Take

$$
p=c=41,\qquad A=451,\qquad X=2255,\qquad H=1,\qquad y=95.
$$

Then

$$
y^2=9025=4\cdot2255\cdot1+5,
$$

and

$$
X\equiv455\pmod{600},
\qquad
H\equiv c\pmod5.
$$

Thus this tuple satisfies the old shifted-square equation, the old
$p\equiv1\pmod{20}$ ramified CRT class, and the first quotient digit.
However,

$$
Ac\equiv451\cdot41\equiv16\pmod{25},
$$

which is not in $\{1,6,11\}$.  What fails is precisely the deeper input
$H\equiv c\pmod{X^2}$.  This exact witness proves that (2) is not obtainable
from the old square equation and first residue class alone.  It is checked by
`ramifiedFive_secondDigit_not_shiftSquare_restatement`.

## 4. Mixed-coordinate depth and uniqueness

Define

$$
F_{X,r}(B)=XB^2+rB+1.
$$

The normalized mixed identity is $a^2H=F_{X,r}(b)$.  Multiplying (1) by
$a^2$ immediately gives (4):

$$
F_{X,r}(b)\equiv ca^2\pmod{X^2}.
$$

The point is not merely the displayed rewrite.  Suppose $b_1,b_2$ both
satisfy the same right-hand side modulo $X^2$.  Their difference factors as

$$
F_{X,r}(b_2)-F_{X,r}(b_1)
=(b_2-b_1)\bigl(X(b_2+b_1)+r\bigr).
\tag{10}
$$

If $\gcd(r,X)=1$, then the second factor in (10) is a unit modulo $X^2$.
Consequently

$$
b_1\equiv b_2\pmod{X^2}.
\tag{11}
$$

Thus the actual floor in (3) is forced into one Hensel class modulo $X^2$.
The Lean theorems `pellFixedFiveMixedPolynomial_mod_sq`,
`pellOddChebyshevQuotient_pointwiseFloor_mod_sq`, and
`pellFixedFiveMixedPolynomial_mod_sq_unique` formalize these statements.

### 4.1 Why the derivative hypothesis holds away from five

The norm equation and the already-proved Bezout certificate give

$$
r^2-5a^2=4X,
\qquad
\gcd(a,X)=1.
$$

If $d$ divides both $r$ and $X$, then the norm equation shows
$d\mid5a^2$.  Since $d\mid X$ and $a$ is coprime to $X$, one can cancel
$a^2$ and obtain

$$
\boxed{\gcd(r,X)\mid5.}
\tag{12}
$$

In particular, $5\nmid X$ implies $\gcd(r,X)=1$, exactly the hypothesis
used in (11).  The Lean theorems
`pellFixedFive_commonDivisor_r_X_dvd_five`,
`pellFixedFive_gcd_r_X_dvd_five`,
`pellFixedFive_isCoprime_r_X_of_five_not_dvd`, and
`pellFixedFiveMixedPolynomial_mod_sq_unique_of_five_not_dvd` check the full
bridge.

## 5. Local audit: where depth does and does not gain

Let $\ell^e\Vert X$.

* If $\ell\ne5$, equation (12) makes $r$ a unit at $\ell$.  The derivative
  of $F_{X,r}$ is $2XB+r\equiv r\pmod\ell$, also a unit.  Therefore a root
  modulo $\ell^e$ has a unique lift to every higher depth.  The congruence
  modulo $X^2$ selects a digit but creates no new local existence
  obstruction beyond the first residue condition.
* At $\ell=5$, the square equation is ramified and its derivative vanishes
  at the first forced root.  Dividing out the known factor $5$ exposes the
  genuine square-residue condition in Section 2.  This is why the new
  exclusion occurs only in the ramified branch.
* If the index prime $p$ divides $X$, then (1), with
  $c=\pm p$ and $p\ne5$, gives $v_p(H)=1$.  If moreover $p^2\mid X$, the
  mixed identity gives $v_p(rb+1)=1$.  These are exact valuation conditions,
  but no contradiction with the current residual is known.

## 6. Continued fractions: exact error, but no unconditional gain

Write

$$
\alpha=\sqrt{H/X},\qquad z=a\alpha.
$$

The pointwise floor theorem says $b<z<b+1$, while the mixed identity gives

$$
z^2-b^2=\frac{rb+1}{X}.
$$

Hence the approximation error is exactly

$$
\boxed{
\alpha-\frac ba
=\frac{rb+1}{aX(z+b)}.}
\tag{13}
$$

Legendre's sufficient convergent criterion would require

$$
\left|\alpha-\frac ba\right|<\frac1{2a^2},
$$

equivalently

$$
2a(rb+1)<X(z+b).
\tag{14}
$$

Condition (14) does not follow from the reduced residual.  The exact tuple

$$
a=2,\quad r=8,\quad X=11,\quad b=1,\quad H=5
$$

satisfies

$$
a^2<X,\qquad r^2=4X+5a^2,\qquad
a^2H=Xb^2+rb+1,
$$

but

$$
\sqrt{5/11}-\frac12>\frac18=\frac1{2a^2},
$$

because $5/11>25/64$.  Therefore the standard best-approximation theorem
cannot be invoked from the current hypotheses.  A continued-fraction route
needs a genuinely stronger reduction such as (14), not merely the floor
identity.

## 7. Trust boundary and next target

The Lean module contains only scalar integer/natural/real arithmetic,
congruences, gcd/Bezout cancellation, and the already kernel-checked odd
Chebyshev quotient recurrence.  The target

```text
lake build IUTThreeClosures.FreyPellChebyshevOddQuotientFixedFiveLift
```

builds successfully.  The `#print axioms` output for every theorem introduced
here is a subset of

```text
propext, Classical.choice, Quot.sound
```

and contains no `sorryAx`, custom axiom, accepted-number-theory interface, or
uniform exclusion.  The floor component imports the exact real square-root
and `Nat.floor` theorem from
`FreyPellChebyshevFixedFiveResidualConsequences`; the quotient component
imports the exact recurrence congruence from
`FreyPellChebyshevOddQuotientGcdLedger`.  Both dependencies are themselves
kernel-checked in the target build.

Sections 5 and 6 are a paper-level local/Archimedean audit, and the proposed
next coefficient below is a target rather than a theorem in this module.
They are deliberately outside the Lean trust ledger; no formal downstream
claim may cite them as proved declarations.

The strongest new output is the ramified second digit (2), supplemented by
the unique nonramified floor class (11).  Neither controls the size of the
floor coordinate, which is far larger than $X^2$ in the active high-index
range, so uniqueness of its residue class is not a height contradiction.

The smallest credible next target is the next exact coefficient of the odd
quotient:

$$
H\equiv c+dX^2\pmod{X^4},
\qquad
d=(-1)^{m-1}\frac{p(p^2-1)}6.
$$

In the ramified branch this would upgrade the divided equation from a square
condition modulo $5$ to one modulo $25$, potentially yielding a third base
digit modulo $625$.  That finite residue calculation is well posed and
strictly stronger; a continued-fraction claim is not justified without an
additional Archimedean inequality.
