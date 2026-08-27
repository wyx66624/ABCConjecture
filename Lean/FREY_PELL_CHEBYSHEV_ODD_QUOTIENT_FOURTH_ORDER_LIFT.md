# Fourth-order odd-quotient depth and ramified-five digits

## 1. Exact outcome

Let

$$
p=2m+1,\qquad
c_m=(-1)^m p,\qquad
H_m(X)=\frac{T_p(X)}{X}.
$$

The coefficient of $X^2$ in $H_m$ is

$$
\boxed{
d_m=(-1)^{m+1}\binom{2m+2}{3}
     =(-1)^{m-1}\frac{p(p^2-1)}6
}
\tag{1}
$$

for $m\geq1$; at $m=0$ both sides are zero after multiplication by the
vanishing factor $p^2-1$.  Thus the sign in the proposed formula was correct.
The exact fourth-order congruence is

$$
\boxed{
H_m(X)\equiv c_m+d_mX^2\pmod{X^4}.
}
\tag{2}
$$

Now put $X=5A$ and suppose

$$
y^2=4XH_m(X)+5.
\tag{3}
$$

Define

$$
E_m(A)=4Ac_m+1+100d_mA^3.
\tag{4}
$$

The complete five-adic consequence of (2) obtainable at this depth is

$$
\boxed{
\begin{aligned}
Ac_m&\equiv1\pmod{25},\\
\text{or}\qquad Ac_m&\equiv11\pmod{25},\\
\text{or}\qquad Ac_m&\equiv6\pmod{25}
 \quad\text{and}\quad
 E_m(A)\equiv0,125,\text{ or }500\pmod{625}.
\end{aligned}}
\tag{5}
$$

The singular third line first forces $E_m(A)\equiv0\pmod{125}$, which is a
new condition on $A$ modulo $125$, hence on $X$ modulo $625$.  The stronger
three-square-class condition modulo $625$ then restricts $A$ modulo $625$,
hence $X$ modulo $3125$.

These are genuine new necessary conditions, but they are not a uniform
exclusion.

## 2. Independent coefficient calculation

The exact odd quotient satisfies

$$
H_{m+2}(X)=(4X^2-2)H_{m+1}(X)-H_m(X).
\tag{6}
$$

Write

$$
H_m(X)=c_m+d_mX^2+O(X^4).
$$

Comparison of coefficients in (6) gives

$$
\begin{aligned}
c_{m+2}&=-2c_{m+1}-c_m,\\
d_{m+2}&=4c_{m+1}-2d_{m+1}-d_m,
\end{aligned}
\tag{7}
$$

with

$$
c_0=1,\quad c_1=-3,\qquad d_0=0,\quad d_1=4.
$$

The sequence

$$
\widetilde d_m=(-1)^{m+1}\binom{2m+2}{3}
$$

has the same initial values and satisfies the second recurrence in (7).
Equivalently,

$$
6\widetilde d_m
=(-1)^{m+1}(2m+1)\bigl((2m+1)^2-1\bigr).
\tag{8}
$$

This proves (1) without assuming the desired formula.  In Lean,
pellOddChebyshevQuadraticCoefficient is defined by (7), while
pellOddChebyshevQuadraticCoefficient_closed proves (8) by two-step
induction.  The theorem pellOddChebyshevQuotient_mod_fourth then proves (2)
directly from (6); it does not import an explicit polynomial formula.

The two active values are kernel-checked as

$$
d_{15}=4960\quad(p=31),\qquad
d_{20}=-11480\quad(p=41).
\tag{9}
$$

Both are divisible by five.

## 3. Ramified derivation

From (2), write

$$
H=c+d(5A)^2+(5A)^4K
  =c+25dA^2+625A^4K.
\tag{10}
$$

Equation (3) implies $5\mid y$; put $y=5z$.  Dividing (3) by five and using
(10) gives

$$
4Ac+1
=5\bigl(z^2-20dA^3-500A^5K\bigr).
\tag{11}
$$

Set

$$
q=z^2-20dA^3-500A^5K.
$$

Then $q\equiv z^2\pmod5$.  The three square residues modulo five give the
old second digit:

$$
\begin{array}{c|c}
z^2\bmod5&Ac\bmod25\\ \hline
1&1\\
4&11\\
0&6.
\end{array}
\tag{12}
$$

Only the last row is singular.  There $5\mid z$; write $z=5w$.  Adding
$100dA^3$ to (11) gives the exact identity

$$
E(A)=125w^2-2500A^5K.
\tag{13}
$$

Consequently,

$$
E(A)\equiv125w^2\pmod{625}.
\tag{14}
$$

Since $w^2\bmod5$ is $0$, $1$, or $4$, equation (14) is exactly the third
line of (5).  This derivation is formalized by
ramifiedFive_fourthDigit_of_modFourth.

Reducing (14) modulo $125$ gives the weaker third-digit theorem
ramifiedFive_thirdDigit_of_modFourth:

$$
E(A)\equiv0\pmod{125}.
\tag{15}
$$

If $5\mid d$, the term $100dA^3$ vanishes modulo $125$, so (15) becomes

$$
4Ac+1\equiv0\pmod{125},
\qquad\text{hence}\qquad
\boxed{Ac\equiv31\pmod{125}}.
\tag{16}
$$

The cancellation in (16) is formalized by
ramifiedFive_thirdDigit_of_five_dvd_coefficient.

## 4. Explicit active-prime residues

### 4.1 The third base digit: modulus 625

For $p=31$, $c=-31$ and $d=4960$.  Combining the two nonsingular branches
with (16) gives

$$
A\bmod125\in
\{4,19,29,44,54,69,79,94,104,119,124\}.
$$

Equivalently,

$$
\boxed{
X\bmod625\in
\{20,95,145,220,270,345,395,470,520,595,620\}.
}
\tag{17}
$$

The old second digit had fifteen lifts at this depth; (17) removes four.

For $p=41$, $c=41$ and $d=-11480$, and the corresponding list is

$$
A\bmod125\in
\{11,16,21,36,46,61,71,86,96,111,121\},
$$

or

$$
\boxed{
X\bmod625\in
\{55,80,105,180,230,305,355,430,480,555,605\}.
}
\tag{18}
$$

Again four of the fifteen old lifts are removed.

### 4.2 The fourth base digit: modulus 3125

At the next digit the two nonsingular branches retain all of their Hensel
lifts.  In the singular branch, (14) leaves only three of the five lifts of
the third digit:

$$
\begin{array}{c|c|c}
p&A\bmod625&X\bmod3125\\ \hline
31&124,249,374&620,1245,1870\\
41&141,266,391&705,1330,1955.
\end{array}
\tag{19}
$$

Across all three old branches, there were $75$ classes for $A$ modulo $625$.
Condition (5) leaves $25+25+3=53$ classes.  The explicit lists (17)--(19)
are finite arithmetic consequences of the formal generic congruence.  They
are kernel-checked by the four theorems
`pellOddChebyshevQuotient_p31_base_mod625`,
`pellOddChebyshevQuotient_p41_base_mod625`,
`pellOddChebyshevQuotient_p31_singular_base_mod3125`, and
`pellOddChebyshevQuotient_p41_singular_base_mod3125`.

## 5. Strictness: neither new digit is a restatement

The Lean theorem ramifiedFive_thirdDigit_not_modSq_restatement checks the
exact tuple

$$
\begin{aligned}
A&=691,&X&=3455,&c&=41,&d&=-11480,\\
K&=227970758,&H&=2721292637514991,&y&=6132557725.
\end{aligned}
$$

It satisfies

$$
H=c+X^2K,\qquad y^2=4XH+5,\qquad X\equiv455\pmod{600},
$$

and $Ac\equiv6\pmod{25}$, but

$$
E(A)\equiv75\pmod{125}.
$$

Thus the old square equation, old quotient congruence modulo $X^2$, old CRT
class, and old second digit do not imply the new third digit.

The theorem ramifiedFive_fourthDigit_not_thirdDigit_restatement checks a
second tuple:

$$
\begin{aligned}
A&=1891,&X&=9455,&c&=41,&d&=-11480,\\
K&=161240510,&H&=14414421903482791,&y&=23348521075.
\end{aligned}
$$

Here all the preceding old data hold and

$$
E(A)\equiv0\pmod{125},
$$

so the new third digit is also satisfied.  Nevertheless,

$$
E(A)\equiv250\pmod{625},
$$

which is not one of $0,125,500$.  Hence the fourth digit is independently
stronger than the third.

These witnesses are logical independence witnesses for the successive
residual systems.  Their artificial values of $H$ are not claimed to equal
the full Chebyshev quotient; precisely that deeper equality supplies (2).

## 6. Exact no-gain boundary

If $q\equiv1$ or $4\pmod5$, a square root of $q$ modulo five is nonzero.
The derivative of $Z^2-q$ is therefore a unit modulo five, so the root lifts
uniquely through modulus $125$.  Equivalently, every residue modulo $125$
whose reduction modulo five is $1$ or $4$ is a square.  Thus (2) imposes no
additional local existence condition on the two nonsingular rows of (12).
Their higher digits are selected, but no base residue is excluded.

The singular row is different because the derivative vanishes.  Dividing
the forced factor of five exposes (13), producing both genuine gains above.

Equation (13) also shows the precise stopping point.  The unknown remainder
term is

$$
2500A^5K=4\cdot625A^5K.
$$

It vanishes modulo $625$ but not necessarily modulo $3125$.  Therefore no
fifth base digit follows from (2).  A further step requires the exact
coefficient of $X^4$ and a quotient congruence modulo $X^6$.

## 7. Trust boundary

The new Lean module is
IUTThreeClosures/FreyPellChebyshevOddQuotientFourthOrderLift.lean.  The target

    lake build IUTThreeClosures.FreyPellChebyshevOddQuotientFourthOrderLift

builds successfully.

The formal layer contains:

- the coefficient recurrence and closed formula (8);
- the exact quotient congruence (2);
- the scalar and actual-quotient versions of (5);
- the third-digit consequences (15) and (16);
- the exact values (9);
- both eleven-class lists modulo $625$ and both three-class singular lists
  modulo $3125$ in (17)--(19);
- both strictness witnesses.

Every printed axiom set is a subset of

    propext, Classical.choice, Quot.sound

and contains no sorryAx, custom axiom, or accepted external
number-theory interface.  The elementary Hensel no-gain explanation and the
stopping-point discussion remain paper-level audits of the formal generic
congruence; no downstream Lean declaration may cite those prose calculations
as a theorem.

Nothing here proves a uniform exclusion, bounds the floor coordinate, or
closes the abc argument.
