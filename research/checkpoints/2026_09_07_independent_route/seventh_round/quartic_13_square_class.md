# Q13. Complete classification of the actual residual square class 13

Status: complete ordinary proof, independently reviewed in full by
critical_bottleneck and adversarial_audit and reviewed by the parent.
The curve and local descent exclusions were independently derived by
independent_route and critical_bottleneck. PARI rank-zero output was
only discovery guidance; the proof below supplies the descent, torsion
bound and actual rational map. It does not assert a general uniform
power theorem or a proof of ABC.

## The actual integer theorem

Let

\[
 F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4.
\]

**Theorem Q13.** If `a,b` are coprime positive integers and `s` is an
integer satisfying `F(a,b)=13s^2`, then

\[
 a=b=1,\qquad s\in\{-1,1\}.                              \tag{Q13.1}
\]

Both signs give the indicated solution. Thus this entire actual
residual square class has no non-diagonal primitive positive seed.
In particular there is no such seed with `F=13Q^g`, `Q>1`, and a
positive even exponent `g`.

## 1. The required elliptic group over the rationals

Consider

\[
 E:\quad Y^2=X^3-13X^2-507X,\qquad
 E':\quad Y^2=X^3+26X^2+2197X.                            \tag{Q13.2}
\]

We will prove, without relying on a rank database,

\[
 E(\mathbb Q)=\{O,(0,0)\}.                               \tag{Q13.3}
\]

We use the standard rational 2-isogeny descent already established
with its exceptional-point cases in the third-round QG proof. To fix
all conventions, for
`C: y^2=x^3+A x^2+B x`, with integer coefficients,
`B(A^2-4B)` nonzero, its dual curve is
`C': y^2=x^3-2A x^2+(A^2-4B)x`. The descent map is

\[
 \alpha(O)=1,\quad\alpha((0,0))=B,
 \quad\alpha((x,y))=x
 \quad\text{in }\mathbb Q^*/\mathbb Q^{*2}.              \tag{Q13.4}
\]

It is a homomorphism. Its image consists of square classes represented
by signed square-free divisors `d` of `B` that have a rational lift;
for any non-exceptional lift there are coprime integers `U,V`, `V`
nonzero, and an integer `N` with

\[
 N^2=dU^4+A U^2V^2+(B/d)V^4.                             \tag{Q13.5}
\]

This follows by writing `x=d(U/V)^2` in lowest square-class form and
substituting in the curve equation. The fact that `d` divides `B`
follows at a prime not dividing `B`: a positive odd valuation of `x`
would make the cubic's valuation odd, while a negative valuation is
even from the lowest-denominator equation. Conversely the cover
substitution gives a rational point when its coordinates are nonzero.
The exceptional points are handled separately by (Q13.4).

For completeness the image/kernel input is the usual explicit
2-isogeny: away from the kernel the map `phi:C->C'` has coordinates
`x'=y^2/x^2`, `y'=y(B-x^2)/x^2`, up to an immaterial sign on the
second coordinate. The dual isogeny, followed by the scaling to `C`,
has image equal to `ker(alpha)`. Solving the resulting quadratic for
the preimage shows precisely that its target `x` is a square; at the
point `(0,0)` a preimage exists exactly when `B` is a square. The
homomorphism formula follows from the cubic intersection with a line,
with the vertical line and lines through `(0,0)` giving respectively
`alpha(P)alpha(-P)=1` and `x(P+(0,0))=B/x(P)`. These are the same
ordinary descent statements used and independently reviewed in QG3.

For (Q13.2), `A=-13`, `B=-507=-3*13^2` and `A^2-4B=2197=13^3`.
The possible classes in `alpha(E)` are

\[
 1,-1,3,-3,13,-13,39,-39.
\]

The classes 1 and -3 occur at `O` and `(0,0)`. Since `alpha(E)` is
a subgroup, multiplication by -3 groups the other six classes into
the three pairs represented by `-1`, `13`, and `-13`. We exclude
these three representatives.

### The representative -1

The cover would be

\[
 N^2=-U^4-13U^2V^2+507V^4.                               \tag{Q13.6}
\]

Coprimality makes at least one of `U,V` odd. Reduction modulo 16
gives the following exhaustive possibilities for its right side:

| Parity | Right side modulo 16 |
| --- | --- |
| U odd, V even | 15 or 11 |
| U even, V odd | 11 or 7 |
| U odd, V odd | 13 or 5 |

None is in the square-residue set `{0,1,4,9}`. Thus -1 is excluded.

### The representatives 13 and -13

For `d=13`, (Q13.5) gives

\[
 N^2=13(U^4-U^2V^2-3V^4).
\]

Thus `13|N`; dividing by 13 and then reducing modulo 13 gives
`U^4-U^2V^2-3V^4=0`. If `13|V`, it also divides `U`, a contradiction.
Otherwise `z=(U/V)^2` modulo 13 must satisfy

\[
 z^2-z-3=(z-7)^2=0\pmod{13}.
\]

This is impossible, since 7 is not a square modulo 13. For `d=-13`
the same argument gives `U^4+U^2V^2-3V^4=0`, hence

\[
 z^2+z-3=(z-6)^2=0\pmod{13},
\]

but 6 is not a square modulo 13. The square residues used here are
`{0,1,3,4,9,10,12}`. This proves

\[
 \alpha(E)=\{1,-3\}.                                    \tag{Q13.7}
\]

For the dual curve, its quadratic factor
`X^2+26X+2197=(X+13)^2+2028` is strictly positive over the reals.
Every affine point with `X` nonzero consequently has positive `X`. The signed
square-free-divisor test for `2197=13^3` leaves only classes 1 and 13,
both realized by `O` and `(0,0)`. Hence

\[
 \alpha(E')=\{1,13\}.                                   \tag{Q13.8}
\]

We can now use the two descent maps directly, without invoking a
general rank formula. On `E'`, the kernel point `T'=(0,0)` has
descent class 13. Since (Q13.8) contains only 1 and 13, every rational
point `P'` satisfies either `P'` or `P'+T'` in `ker(alpha')=phi(E(Q))`.
Applying `psi` and using `psi(T')=O` and `psi phi=[2]` shows
`psi(E'(Q))=2E(Q)`. Consequently `ker(alpha)=2E(Q)`, and (Q13.7) gives

\[
 [E(\mathbb Q):2E(\mathbb Q)]
   =|\alpha(E)|=2.
\]

The curve `E` has just one nonzero rational point of order two, since
`X^2-13X-507` has discriminant `2197`, which is not a rational square.
The Mordell--Weil finite-generation theorem therefore makes this index
`2^{rank(E)+1}`. Thus `rank(E)=0`.

Finally 5 and 7 are good primes: the discriminant
`16*507^2*2197` has prime divisors only 2, 3, 13. A full elementary
count gives `#E(F_5)=6` and `#E(F_7)=4`. The numbers of affine
ordinates at each successive abscissa are respectively

\[
 (1,2,0,2,0),\qquad (1,0,0,0,0,2,0),
\]

and each count also includes one point at infinity. Good-reduction
injectivity on prime-to-residue-characteristic torsion bounds the
rational torsion order by 2: its 5-primary part is excluded at 7,
its 7-primary part at 5, and every other primary part divides both
6 and 4. The known point `(0,0)` attains this bound. Together with
rank zero this proves (Q13.3).

## 2. An explicit actual-point map, including the exceptional cases

Suppose that rational numbers `x,y` satisfy

\[
 13y^2=x^4+3x^3+5x^2+3x+1.                               \tag{Q13.9}
\]

If `x=1`, the equation gives `y=+/-1`. If `x` is different from 1,
put

\[
 t=x-1,\quad u=\frac{y-1-t}{t^2},\quad
 A=u^2-\frac1{13},\quad B=2u-\frac7{13}.
\]

Substitute `y=1+t+ut^2` and
`F(1+t,1)=t^4+7t^3+20t^2+26t+13` in (Q13.9).
After division by `13t^2`, the exact equation is

\[
 At^2+Bt+B=0.                                            \tag{Q13.10}
\]

Define the finite rational coordinates

\[
 X=91-338u,\qquad Y=2197(2At+B).                         \tag{Q13.11}
\]

Equation (Q13.10) gives `(2At+B)^2=B^2-4AB`, and direct expansion
gives the polynomial identity

\[
 (91-338u)^3-13(91-338u)^2-507(91-338u)
 =13^6(B^2-4AB).                                        \tag{Q13.12}
\]

Since `2197^2=13^6`, (Q13.11) is a point of the specific curve `E`
in (Q13.2). This establishes the required twist as an exact rational
map, rather than guessing a Jacobian from its `j`-invariant.

It cannot be the point at infinity, because its coordinates are finite.
If `X=0`, then `u=7/26`, `B=0` and `A=-3/676`; equation (Q13.10)
would force `t=0`, contrary to its definition. Thus it cannot be
`(0,0)` either. This contradicts (Q13.3). There is no need to divide
by `A` or `B`, so their vanishing introduces no omitted branch.
We have proved that the only affine rational points in (Q13.9) are
`(1,1)` and `(1,-1)`.

For the actual integer equation, set `x=a/b` and `y=s/b^2`;
`b>0` ensures both are defined and homogeneity gives (Q13.9).
Therefore `a/b=1`; coprimality and positivity give `a=b=1`, and
the original equation gives `s=+/-1`. This proves Theorem Q13.

## 3. An integral map and the homogeneous integer extension

The parent independently derived the following simpler integral map,
recorded with a complete proof in
`research/checkpoints/2026_09_07_boundary_descent/integral_thirteen_map.md`.
That proof has independent full reviews by this agent and both peers.
For arbitrary integers `a,b,s`, put

\[
 c=a-b,\quad y=a+b,\quad A=7a^2+12ab+7b^2,
 \qquad U=13(A-26s),\quad V=13Uy.
\]

Exact identities are

\[
 A^2+3c^4=52F(a,b),\qquad c^2+13y^2=2A,
\]
\[
 V^2-U^3+13U^2c^2+507Uc^4=8788U(F(a,b)-13s^2).
\]

The first two follow by expansion. Factoring the last left side by
`U`, its bracket is
`169Uy^2-U^2+13Uc^2+507c^4=26AU-U^2+507c^4`
`=169(A^2-676s^2+3c^4)=8788(F-13s^2)`.
If `F=13s^2` and `c` is nonzero, then `U` is nonzero: otherwise
`A=26s` and the first identity would imply `3c^4=0`.
Consequently `(U/c^2,V/c^3)` is a finite rational point of `E` with
nonzero first coordinate. This again contradicts (Q13.3). The only
division is by a power of `c`; no hypothesis on `b` or any sign is needed.

**Homogeneous integer corollary.** For all integers `a,b,s`,

\[
 F(a,b)=13s^2\quad\Longleftrightarrow\quad
 a=b\ \text{and}\ s\in\{-a^2,a^2\}.
\]

Indeed the preceding map forces `a=b`, and substitution gives
`s^2=a^4`, hence `(s-a^2)(s+a^2)=0`. The converse follows by
substitution and includes the zero solution. This strengthens the
integer domain of the same ordinary theorem; it does not extend it
to other residual square classes.

## Dependencies and verification scope

The map, the three local exclusions, and the finite point counts are
elementary exact algebra. The group conclusion also uses the established
rational 2-isogeny descent, Mordell--Weil finite generation, and the
prime-to-residue-characteristic good-reduction torsion injection. The
descent's exceptional branches were fully proved in the repository's
third-round `quartic_square_geometry.md`; Milne's author text
`https://www.jmilne.org/math/Books/EC2.pdf` supplies finite generation
and good-reduction injection (Chapter IV and Corollary II.4.2).

The diagnostic `quartic_13_probe.gp` was actually run in PARI/GP 2.15.4.
It returned `ellrank=[0,0,0,[]]` and rational torsion of order 2.
The official `ellrank` documentation was checked: its rank interval
is an unconditional algebraic 2-descent bound, unlike a BSD-based
analytic-rank guess. Nevertheless no rank output is required as a
premise of the ordinary proof above. No complete Lean proof of the
elliptic descent or rational-point classification is claimed here.

The parent module `Lean/ThirteenMapArithmetic.lean` formalizes seven
integer statements for the integral bridge, with a fresh build of its
65-module closure reported by the parent. This agent independently
read every signature and proof and its imported definition of `second`.
The final diagonal theorem has the homogenized integral-point obstruction
as an explicit hypothesis; it does not formalize or silently assume
the rational group classification. Its checked source SHA256 is
`4f07b9574be916ad673d4b748b9eddb1614e7e1473721855ee693477658284f4`.
