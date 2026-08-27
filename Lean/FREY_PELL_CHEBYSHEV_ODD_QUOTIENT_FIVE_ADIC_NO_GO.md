# Odd Chebyshev quotient: the pure five-adic no-go theorem

## 1. Statement and scope

Let

\[
p=2m+1,\qquad c_m=(-1)^m p,
\]

and let the **actual** odd Chebyshev quotient be the integer polynomial
\(H_m(T)\) defined by

\[
H_0=1,\qquad H_1=4T^2-3,\qquad
H_{m+2}=(4T^2-2)H_{m+1}-H_m.
\]

In the ramified branch write \(X=5A\) and \(y=5z\).  The exact shifted
square equation is then

\[
F_m(A,z):=5z^2-4A H_m(5A)-1=0.                 \tag{1}
\]

Assume \(5\nmid p\).  The local no-go theorem is:

> For every \(z\in\mathbf Z_5\), there is exactly one
> \(A=A_m(z)\in\mathbf Z_5\) satisfying (1).  Its first digit is the
> unique class \(A c_m\equiv1\pmod5\).  Equivalently, the solution set of
> (1) over \(\mathbf Z_5^2\) is the graph of a function
> \(A_m:\mathbf Z_5\to\mathbf Z_5\).

The standard simple-root Hensel lemma proves the full-depth assertion.  The
companion Lean module kernel-checks all finite congruence inputs to that
application, including the exact lift-digit formula.

This is a local solvability theorem, not a global integral-solvability
theorem.  Section 6 records the distinction precisely.

## 2. The first digit and the unit Jacobian

The constant term of \(H_m\) is \(c_m\).  This follows either directly from
the recurrence or from the exact congruence

\[
H_m(T)\equiv c_m\pmod T.
\]

Consequently,

\[
H_m(5A)\equiv c_m\pmod5
\]

and (1) reduces to

\[
F_m(A,z)\equiv -4Ac_m-1\equiv Ac_m-1\pmod5.    \tag{2}
\]

The coordinate \(z\) disappears.  Since \(5\nmid c_m\), (2) has exactly
one root,

\[
\bar A=c_m^{-1}\in\mathbf F_5.                 \tag{3}
\]

Differentiating the actual polynomial (1) with respect to \(A\) gives

\[
\frac{\partial F_m}{\partial A}
=-4\bigl(H_m(5A)+5A H_m'(5A)\bigr)
\equiv-4c_m\pmod5.                             \tag{4}
\]

This is nonzero because both \(4\) and \(c_m\) are units modulo five.
Thus the unique root (3) is simple for every value of the parameter \(z\).

The Lean theorem
`pellOddChebyshevFiveAdicEquation_mod_five` proves (2), while
`pellOddChebyshevFiveAdicSlope_not_dvd_five` proves the unit assertion in
(4) without appealing to a symbolic-derivative interface.

## 3. Constructive lift at every digit

There is an exact finite-difference version of (4).  For every \(n\ge0\)
and all integers \(A,z,t\),

\[
F_m(A+5^n t,z)-F_m(A,z)
\equiv -4\,5^n t\,c_m\pmod {5^{n+1}}.           \tag{5}
\]

To verify (5), put \(B=A+5^n t\).  Congruence preservation by the quotient
recurrence gives

\[
H_m(5B)\equiv H_m(5A)\pmod {5^{n+1}},
\]

and the constant-term congruence gives

\[
H_m(5B)\equiv c_m\pmod5.
\]

Expanding \(B H_m(5B)-A H_m(5A)\) now proves (5).  This is kernel-checked as
`pellOddChebyshevFiveAdicEquation_lift_digit`; no truncated formula for
\(H_m\) is used.

Suppose \(F_m(A_n,z)\equiv0\pmod {5^n}\), and write

\[
F_m(A_n,z)=5^n q_n.
\]

Every lift of \(A_n\) modulo \(5^{n+1}\) has the form
\(A_n+5^n t\), with \(t\in\mathbf F_5\).  By (5), it is a root at the next
level exactly when

\[
q_n-4t c_m\equiv0\pmod5.                       \tag{6}
\]

Because \(4c_m\) is a unit, (6) has exactly one solution \(t\).  Starting
from (3), induction therefore gives a unique compatible root

\[
A_n\pmod {5^n}
\]

for every \(n\ge1\).

If instead one starts with a compatible parameter system
\(z_n\pmod {5^n}\), the same argument applies at each level.  The equation
modulo \(5^n\) depends only on the reduction of \(z\) modulo \(5^n\), and
uniqueness forces the resulting \(A_n\)'s to be compatible.  Completeness of
\(\mathbf Z_5\), or equivalently the standard simple-root Hensel lemma,
produces the unique limit \(A_m(z)\).

The usual five-adic implicit-function theorem further says that
\(z\mapsto A_m(z)\) is analytic.  Analyticity is not needed for the no-go
conclusion.  A useful stronger continuity observation is

\[
z\equiv z'\pmod {5^n}
\quad\Longrightarrow\quad
A_m(z)\equiv A_m(z')\pmod {5^{n+1}},            \tag{7}
\]

because the change in the constant term is
\(5(z^2-z'^2)\), divisible by \(5^{n+1}\), and the root in the simple
residue ball is unique.

## 4. Compatibility with the ramified CRT branch

The repository's ramified branch has

\[
X=5A\equiv23\pmod {24}.
\]

Since \(5^{-1}\equiv5\pmod {24}\), this is equivalent to

\[
A\equiv19\pmod {24}.                            \tag{8}
\]

For every finite five-adic root class \(A_n\pmod {5^n}\), the moduli
\(5^n\) and \(24\) are coprime.  The Chinese remainder theorem therefore
gives a unique class

\[
a_n\pmod {24\cdot5^n}
\]

satisfying

\[
a_n\equiv A_n\pmod {5^n},\qquad
a_n\equiv19\pmod {24}.                          \tag{9}
\]

The class at level \(n+1\) reduces to the class at level \(n\), again by
CRT uniqueness.  Thus the prime-to-five condition (8) never obstructs a
finite lift and is compatible with the full inverse system.

The existence statement in (9) is kernel-checked by
`exists_ramifiedCRT_lift_of_five_power`.  The equivalence between (8) and
the class of \(X\) is kernel-checked by `five_mul_ramifiedClass_iff`.

There is a second, distinct compatibility check if one also wants the full
equation modulo \(24\), rather than only the class of \(X\).  Given any
five-adic truncation of \(z\), impose

\[
z\equiv1\pmod {24}.                             \tag{10}
\]

This is compatible at every finite depth by the same CRT argument.  For odd
index \(p\), the endpoint value is

\[
T_p(-1)=-1.
\]

Thus \(X\equiv23\equiv-1\pmod {24}\) gives

\[
4T_p(X)+5\equiv1\pmod {24},
\]

while \(y=5z\) and (10) give \(y^2\equiv25\equiv1\pmod {24}\).  Equivalently,
using \(H_m(-1)=1\), one obtains directly

\[
F_m(19,1)\equiv5-4\cdot19-1=-72\equiv0\pmod {24}. \tag{11}
\]

The quotient endpoint and (11) are kernel-checked by
`pellOddChebyshevQuotient_neg_one` and
`pellOddChebyshevFiveAdicEquation_mod_twentyfour`.  Compatibility of an
arbitrary finite \(z\)-truncation with (10) is kernel-checked by
`exists_mod_twentyfour_one_lift_of_five_power`.

## 5. Exact no-go consequence

The earlier mod \(25\), mod \(125\), and mod \(625\) restrictions are real:
they compute initial digits of the unique graph \(A=A_m(z)\).  They can
discard proposed residue classes for \(A\) when those classes have been
fixed independently.  They cannot, however, make the local solution set
empty while \(z\) remains a free five-adic coordinate.

Indeed, for every \(z\in\mathbf Z_5\), the exact equation using the actual
Chebyshev quotient has the point

\[
(A_m(z),z)\in\mathbf Z_5^2,
\]

and (9)--(11) make both of its finite coordinate truncations compatible with
the ramified class and the full equation modulo \(24\).  Therefore:

> No finite-depth five-adic sieve, and not even complete analysis of (1)
> over \(\mathbf Z_5\), can uniformly exclude the ramified branch from the
> exact Chebyshev quotient equation together with \(X\equiv23\pmod {24}\).

This statement is intentionally scoped to consequences of the exact local
equation and the stated prime-to-five CRT condition.  A contradiction may
still use archimedean bounds, positivity, floor normalization, another
prime, global gcd information, or a theorem forcing the five-adic point to
come from an ordinary integer point.

## 6. Local points are not global integer points

For each \(n\), CRT supplies ordinary integer representatives \(a_n,w_n\)
of (9) and (10).  The compatible system of residue pairs defines a point of

\[
(\mathbf Z/24\mathbf Z)^2\times\mathbf Z_5^2.
\]

It need not be the image of one fixed ordinary integer pair.  Likewise, the
Hensel limit \(A_m(z)\) and the freely chosen \(z\) need not lie in
\(\mathbf Z\subset\mathbf Z_5\).  Hence the local theorem proves neither

- an integral solution of (1),
- a positive integral solution,
- the Pell/floor normalization required elsewhere, nor
- an abc counterexample or a closure of the abc argument.

Conversely, every global integral solution would give one of these local
points.  The implication is global-to-local only; using it in reverse would
be invalid.

## 7. Trust boundary

The companion Lean module is
`IUTThreeClosures/FreyPellChebyshevOddQuotientFiveAdicNoGo.lean`.  It
kernel-checks:

- congruence preservation by the exact quotient recurrence;
- the reduction (2);
- nondivisibility of the slope \(-4c_m\) by five;
- the all-depth finite-difference formula (5);
- finite CRT compatibility for both coordinates;
- the equivalence of the two ramified mod-24 classes; and
- the actual quotient endpoint and full-equation check (11).

The passage from the unique compatible finite roots to a root in
\(\mathbf Z_5\), and the optional analyticity assertion, use the accepted
simple-root Hensel lemma / five-adic implicit-function theorem.  They are not
exported as Lean declarations in this module.  No external computational
certificate is used.

All printed Lean axiom sets are subsets of

    propext, Classical.choice, Quot.sound

and contain no `sorryAx` or custom axiom.
