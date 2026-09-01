# The adjacent-factor descent for the Pell squarefull route

Author: ChatGPT. Date: 2026-08-31.

## 0. Status

This note continues the counterexample search without abandoning the Pell
route merely because its squarefull-value premise is difficult.  It proves a
new deterministic descent from the same Pell premise to a sharper family of
abc points.  It does **not** prove that squarefull Pell roots occur at
unbounded indices, and therefore it does not claim a counterexample to abc.

The starting orbit is the positive solution sequence of

\[
                         x^2-8y^2=1.                         \tag{0.1}
\]

The preceding report used the triples `(1,8y^2,x^2)` and obtained the
conditional radical slope `3/4`.  Factoring the two sides adjacent to the
odd number `x` gives a different primitive triple and improves the
deterministic slope to `1/2`.

## 1. Exact half-factorization

### Theorem 1.1 (Pell half-factorization)

Let `x,y` be positive integers satisfying (0.1).  There are unique positive
integers `r,s` such that

\[
 x=2r+1,\qquad s=r+1,qquad rs=2y^2.                         \tag{1.1}
\]

Explicitly,

\[
                         r=\frac{x-1}{2},\qquad
                         s=\frac{x+1}{2}.                    \tag{1.2}
\]

Moreover `gcd(r,s)=1` and `y<s`.

**Proof.**  Equation (0.1) makes `x^2` odd, hence `x` is odd and admits the
unique expression `x=2r+1`.  Put `s=r+1`.  Substitution into (0.1) gives

\[
 1+8y^2=(2r+1)^2=4r(r+1)+1,
\]

and cancellation of four gives `rs=2y^2`.  Since `y>0`, equation (0.1)
gives `x^2>4y^2`; positivity gives `x>2y`, hence
`s=(x+1)/2>y`.  In particular `r>0`.  Consecutive integers are coprime, so
`gcd(r,s)=gcd(r,r+1)=1`.  The displayed expressions also prove uniqueness.
\(\square\)

The associated point

\[
                              P_{x,y}=(r,1,s)                 \tag{1.3}
\]

is therefore a positive primitive abc point: `r+1=s`, and all three
coordinates are pairwise coprime.

## 2. A one-half radical slope

Recall that a positive integer is squarefull when every prime in its support
has valuation at least two.

### Theorem 2.1 (adjacent radical compression)

Under Theorem 1.1, assume in addition that `y` is squarefull.  Then

\[
 \operatorname{rad}(r s)
   =\operatorname{rad}(2y^2)
   =\operatorname{rad}(2y)
   \le 2\operatorname{rad}(y),                               \tag{2.1}
\]

and consequently

\[
       \operatorname{rad}(rs)^2\le4y<4s.                    \tag{2.2}
\]

Writing

\[
 H(P_{x,y})=\log s,
 \qquad
 R(P_{x,y})=\log\operatorname{rad}(rs),
\]

one obtains the uniform affine slope

\[
                 \boxed{R(P_{x,y})
                    \le \frac12H(P_{x,y})+\log2.}            \tag{2.3}
\]

**Proof.**  The first equality in (2.1) is (1.1).  A radical is unchanged
when a positive exponent is attached to an existing factor, which gives the
second equality.  Radical submultiplicativity and `rad(2)=2` give the last
inequality.  Squarefullness gives

\[
                         \operatorname{rad}(y)^2\le y.
\]

Squaring (2.1) and using `y<s` proves (2.2).  All quantities are positive,
so applying the increasing logarithm to (2.2) gives

\[
 2R(P_{x,y})\le \log4+\log s
              =2\log2+H(P_{x,y}),
\]

which is (2.3).  \(\square\)

This is sharper than the previous `3/4` slope for `(1,8y^2,x^2)` and uses
exactly the same unresolved squarefull premise.  The improvement comes from
factoring `x^2-1`, not from assuming an additional distribution theorem.

### Corollary 2.2 (conditional disproof with the unchanged target)

Suppose there is a height-unbounded family of positive solutions of (0.1)
whose roots `y` are squarefull.  Then the standard logarithmic abc conjecture
is false.

**Proof.**  Apply Theorems 1.1 and 2.1 to obtain the primitive family (1.3).
Its heights are unbounded because `s>y`.  Choose, for example,
`epsilon=1/2`.  Combining the standard abc inequality with (2.3) would give

\[
 H\le\frac32R+C
   \le\frac34H+\frac32\log2+C,
\]

and hence a uniform upper bound for `H`, contradicting unboundedness.
This invokes the unchanged standard conjecture, not a restricted substitute.
\(\square\)

## 3. Even roots give consecutive fourth-full endpoints

There is a further structural refinement on the even-index part of the
orbit.

### Proposition 3.1 (fourth-full split for an even squarefull root)

Under Theorem 1.1, suppose that `y` is both even and squarefull.  Then each
of `r` and `s` is 4-full.

**Proof.**  Let `p` be a prime dividing `r`.  Since `r` and `s` are coprime,
`p` does not divide `s`.  From `rs=2y^2`, either `p=2` or `p` divides `y`.
In the first case the evenness of `y` again gives `p|y`.  Thus in all cases
`p|y`.  Squarefullness yields `p^2|y`, hence `p^4|y^2` and therefore
`p^4|rs`.  Coprimality with `s` forces `p^4|r`.  The same argument with
`r` and `s` interchanged proves that every prime divisor of `s` occurs to
exponent at least four.  \(\square\)

Thus the even squarefull subroute produces consecutive fourth-full numbers,
a substantially more rigid target than the original consecutive-powerful
Pell family.  Failure to prove that such roots occur is not a counterexample
to this route, so the route remains active.

### Proposition 3.2 (square-root Pell descent)

For `n>=1`, define positive integers `A_n,B_n` by

\[
                    (1+\sqrt2)^n=A_n+B_n\sqrt2.              \tag{3.1}
\]

If

\[
                    (3+\sqrt8)^n=x_n+y_n\sqrt8,              \tag{3.2}
\]

then

\[
 x_n=A_n^2+2B_n^2,\qquad y_n=A_nB_n,
 \qquad A_n^2-2B_n^2=(-1)^n,                                \tag{3.3}
\]

and `gcd(A_n,B_n)=1`.  Moreover the adjacent pair from Theorem 1.1 is

\[
 (r_n,s_n)=
 \begin{cases}
   (2B_n^2,A_n^2),&n\ \text{even},\\
   (A_n^2,2B_n^2),&n\ \text{odd}.
 \end{cases}                                                 \tag{3.4}
\]

Consequently

\[
 y_n\text{ is squarefull}
 \quad\Longleftrightarrow\quad
 A_n\text{ and }B_n\text{ are both squarefull}.             \tag{3.5}
\]

**Proof.**  Since `(1+sqrt(2))^2=3+2sqrt(2)=3+sqrt(8)`,
squaring (3.1) and comparing the rational and `sqrt(8)` coefficients with
(3.2) gives the first two identities in (3.3).  Taking norms in (3.1) gives
the third.  Any common divisor of `A_n` and `B_n` divides
`A_n^2-2B_n^2=+-1`; hence the coordinates are coprime.

If `n` is even, the norm identity reads `A_n^2=2B_n^2+1`, so

\[
 x_n=4B_n^2+1,
 \qquad (x_n-1)/2=2B_n^2,
 \qquad (x_n+1)/2=A_n^2.
\]

For odd `n`, it reads `A_n^2=2B_n^2-1`, giving the second row of (3.4).
Finally, `y_n=A_nB_n` is a product of coprime positive integers.  If it is
squarefull and a prime `p` divides `A_n`, then `p^2` divides `A_nB_n` and is
coprime to `B_n`, so `p^2` divides `A_n`; the same argument applies to
`B_n`.  Conversely, if both factors are squarefull, every prime divisor of
their product occurs to exponent at least two.  This proves (3.5).
\(\square\)

Proposition 3.2 changes the arithmetic search target.  The missing premise
can now be attacked as simultaneous squarefullness of two coprime companion
Lucas coordinates.  Primitive divisors of only one coordinate, without an
exponent-one conclusion, still do not refute it.  The route therefore remains
active while valuation-one, Lucas--Wieferich, and simultaneous-powerful-value
methods are investigated.

## 4. Relation to the original literature

Walker, *Consecutive Integer Pairs of Powerful Numbers and Related
Diophantine Equations*, Fibonacci Quarterly 14 (1976), 111--116, classifies
the Pell constructions that produce consecutive powerful pairs.  The local
primary-source copy is
`research/sources/campana_counterexample_2026_08_31/Walker_1976_Consecutive_Powerful_Pairs.pdf`.
The half-factorization above uses the same classical Pell orbit but adds the
squarefull-root hypothesis explicitly and tracks the resulting radical.

Ribenboim--Walsh and Yabuta prove conditionally on abc that a nondegenerate
Lucas sequence has only finitely many powerful terms in the relevant
discriminant ranges.  This is consistent with Corollary 2.2: an unbounded
squarefull subsequence here would be a disproof mechanism, not a consequence
of known unconditional Lucas theory.

The Bilu--Hanrot--Voutier primitive-divisor theorem remains applicable, but
it does not guarantee valuation one.  It therefore does not refute the
squarefull premise used in this note.

Gozeri, *On Pell, Pell-Lucas, and balancing numbers*, Journal of Inequalities
and Applications 2018:3, records the standard Binet formulas and the identity
expressing a balancing number as a product of Pell and Pell-Lucas coordinates.
Those formulas corroborate the sequence dictionary behind Proposition 3.2;
the proposition itself is proved above and independently checked in Lean.

## 5. Formalization boundary and next decision

The Lean companion should formalize, in this order:

1. the existence and uniqueness of the half-factorization;
2. the primitive point `(r,1,s)`;
3. radical compression (2.1)--(2.3);
4. the conditional implication to `not ABCConjecture`; and
5. the fourth-full transfer under the additional evenness hypothesis; and
6. the square-root orbit, norm identities, coprimality, square shapes, and
   squarefull-product equivalence of Proposition 3.2.

These items are implemented in
`Lean/IUTThreeClosures/PellAdjacentFactorCounterexample20260831.lean` and
`Lean/IUTThreeClosures/PellSquareRootDescent20260831.lean`.

It must not assert the existence of an unbounded squarefull Pell family.
The decisive arithmetic question remains whether the Lucas sequence
`y_(n+2)=6y_(n+1)-y_n` has squarefull values at unbounded indices, or whether
one can prove an eventual exponent-one divisor.  Difficulty does not remove
either direction from the registry; only a proof or a genuine counterexample
to a particular proposed implication can do that.
