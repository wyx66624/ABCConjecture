# Rational three-torsion Frey geometry and the coefficient-two target

## 1. Purpose

The remaining core is not another logical wrapper.  It is the actual
height--conductor inequality for a source-derived family.  The standard full
rational two-torsion Frey curve has canonical `j`-height

\[
 h(j(E_{a,b,c}))=6\log c+O(1),
\]

so a slope-six height--conductor estimate is exactly the abc conjecture.  The
coefficient-three symmetric-product output appearing in current arithmetic
Teichmuller/IUT estimates loses a factor at endpoint-shaped triples.

This note constructs a different, genuinely source-derived elliptic family
with rational three-torsion whose modular `j`-map has degree four rather than
six.  The construction supplies an actual geometric reason why a
base-index-two comparison would have the coefficient needed to close abc.
It does **not** assume that comparison and does not claim that the final
height--conductor theorem has already been proved.

## 2. The two oriented Tate normal forms

Let

\[
 a+b=c,\qquad a,b,c>0,
\qquad \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1.
\]

Define

\[
 E_a:\quad y^2+3axy+a^2cy=x^3,                 \tag{2.1}
\]

and interchange `a,b` to obtain

\[
 E_b:\quad y^2+3bxy+b^2cy=x^3.                 \tag{2.2}
\]

For a general Tate normal form

\[
 y^2+Axy+By=x^3,
\]

the tangent line at `(0,0)` is `y=0`.  Its substitution into the cubic gives
`x^3=0`, so `(0,0)` is a flex.  On a nonsingular cubic, the chord--tangent law
therefore gives

\[
 3(0,0)=O.
\]

Since `B\ne0`, this affine point is nonzero, hence has exact order three.

## 3. Exact invariants

For `a1=A`, `a3=B`, and `a2=a4=a6=0`,

\[
 b_2=A^2,\quad b_4=AB,\quad b_6=B^2,\quad b_8=0,
\]

and therefore

\[
 c_4=A(A^3-24B),\qquad
 \Delta=B^3(A^3-27B).                              \tag{3.1}
\]

Putting `A=3a`, `B=a^2c`, and using `a-c=-b` gives

\[
 \boxed{c_4(E_a)=9a^3(a-8b)},
\]

\[
 \boxed{\Delta(E_a)=-27a^8bc^3},                  \tag{3.2}
\]

and

\[
 \boxed{j(E_a)=-27\frac{a(a-8b)^3}{bc^3}}.        \tag{3.3}
\]

Similarly,

\[
 c_4(E_b)=9b^3(b-8a),
\quad
 \Delta(E_b)=-27b^8ac^3,
\]

\[
 j(E_b)=-27\frac{b(b-8a)^3}{ac^3}.                \tag{3.4}
\]

These identities are formalized in
`IUTThreeClosures/FreyRationalThreeTorsion.lean`.

## 4. Degree-four modular parameter

Set

\[
 t_a=\frac{27a}{c}.
\]

Then

\[
 t_a-27=-\frac{27b}{c},
\qquad
 t_a-24=\frac{3(a-8b)}{c}.
\]

Substitution into (3.3) yields the exact rational map

\[
 \boxed{j(E_a)=\frac{t_a(t_a-24)^3}{t_a-27}}.      \tag{4.1}
\]

It has degree four.  The same formula holds for `t_b=27b/c`.
This is the classical rational-three-torsion Tate-normal-form map, but here
it is attached pointwise to the actual abc source rather than to a fixed
auxiliary curve.

## 5. No new variable bad primes

Let

\[
 D_a=27a^8bc^3,\qquad D_b=27b^8ac^3.
\]

The exact divisibilities

\[
 abc\mid D_a,\qquad D_a\mid 27(abc)^8
\]

(and the swapped analogues) imply

\[
 \boxed{
 \operatorname{rad}(abc)
 \le \operatorname{rad}(D_a)
 \le 3\operatorname{rad}(abc)
 },                                                   \tag{5.1}
\]

and likewise for `D_b`.  Thus the construction retains the original variable
prime support exactly; the sole possible extra prime is the fixed prime `3`.
This is stronger support behavior than an arbitrary auxiliary elliptic
family.

## 6. The raw quartic height corridor

The raw denominators in (3.3)--(3.4) are

\[
 Q_a=bc^3,\qquad Q_b=ac^3.
\]

Since `max(a,b)\ge c/2`,

\[
 \boxed{c^4\le2\max(Q_a,Q_b)}.                    \tag{6.1}
\]

The possible cancellation is bounded independently of the source.  Indeed,

\[
 \gcd(a,bc^3)=1,
\]

and

\[
 \gcd(a-8b,b)=1.
\]

Moreover, if a prime divides both `a-8b` and `c`, then it divides

\[
 (a-8b)+8c=9a.
\]

It is coprime to `a`, hence divides `9`.  Therefore

\[
 \gcd(a-8b,c)\mid9.                                \tag{6.2}
\]

Consequently

\[
 \gcd\bigl(27a|a-8b|^3,bc^3\bigr)\mid3^9,          \tag{6.3}
\]

with the same bound after swapping `a,b`.  At least one reduced denominator
is thus at least

\[
 \frac{c^4}{2\cdot3^9}.
\]

On the other hand `|a-8b|\le8c`, so both raw numerator and denominator are
at most a fixed constant times `c^4`.  Hence the two actual rational Weil
heights satisfy the source-derived corridor

\[
 \boxed{
 4\log c-\log(2\cdot3^9)
 \le \max\{h(j(E_a)),h(j(E_b))\}
 \le 4\log c+\log 13824
 }.                                                   \tag{6.4}
\]

The two orientations are essential: at `a=8b` the first `j`-invariant is
zero, whereas the swapped one remains on the quartic scale.

## 7. Why this directly targets the missing coefficient

The standard Frey/Legendre `j`-map has degree six and produces

\[
 h(j)/6=\log c+O(1).
\]

The present rational-three-torsion pair has degree four and produces

\[
 \max h(j)/4=\log c+O(1).                           \tag{7.1}
\]

A source-derived comparison with coefficient four against the same reduced
bad-prime conductor would therefore close abc immediately.  Equivalently, in
a product/log-volume normalization, a genuine base index `2` would produce
the symmetric-product coefficient `2`, which is the exact sufficient
threshold already isolated in the repository.

This is not a relabeling of the target: equations (2.1)--(6.4) are new
arithmetic geometry constructed from every abc point, with exact invariants,
fixed cancellation, and no new variable bad primes.

## 8. Exact unresolved theorem

The remaining theorem is now concentrated as follows.

> **Rational-three-torsion height--conductor theorem.**  For every
> `epsilon>0`, there is one constant `C_epsilon`, independent of the source
> point, such that
> \[
> \max\{h(j(E_a)),h(j(E_b))\}
> \le (4+4\epsilon)\log\operatorname{rad}(abc)+C_\epsilon.
> \tag{8.1}
> \]

Together with (6.4), (8.1) implies the standard logarithmic abc conjecture.
The work still required is to prove (8.1), not to store it as a structure
field.  The most focused geometric subproblem is to construct a
source-faithful level-three theta/log-volume comparison whose normalization
has base index two and whose local packet can choose between the two
orientations without paying a second copy of the conductor.

## 9. Lean status

The first formal module proves:

- both Weierstrass models;
- all `b`-invariants, `c4`, discriminant, nonsingularity, and `j` formulas;
- the degree-four parameter identity;
- lower and upper radical support comparisons;
- the raw quartic denominator lower bound.

The companion formalization target is the fixed cancellation estimate
(6.2)--(6.3) and the actual rational Weil-height corridor (6.4).
