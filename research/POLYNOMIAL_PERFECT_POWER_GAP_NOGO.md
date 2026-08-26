# Polynomial parametrizations cannot beat the generalized perfect-power gap threshold

## 1. The disproof budget

A surviving route to disprove the abc conjecture seeks infinitely many coprime
positive integers `x,y` for fixed integers `m,n>=2` such that

\[
 0<y^n-x^m\le (y^n)^\theta
\]

with

\[
 \theta+\frac1m+\frac1n<1.
\tag{1.1}
\]

The associated primitive triple

\[
 a=y^n-x^m,
 \qquad b=x^m,
 \qquad c=y^n
\]

would then violate abc for one fixed positive epsilon.

This note proves that no nonconstant polynomial identity can supply such a
family.

## 2. Polynomial set-up

Let `k` be a field of characteristic zero.  Let

\[
 X,Y,A\in k[T]
\]

be nonzero polynomials such that

\[
 X^m+A=Y^n,
\tag{2.1}
\]

and assume that the three terms `X^m`, `A`, and `Y^n` are pairwise coprime.
Put

\[
 D=\max\{m\deg X,n\deg Y\}.
\]

If the two leading terms in (2.1) do not cancel, then `D` is the height degree
of the parametrized triple.  If they do cancel, replace `D` below by
`max{deg X^m,deg A,deg Y^n}`; the same Mason--Stothers argument applies and is
only stronger for the intended gap estimate.

## 3. Mason--Stothers lower bound for the gap degree

### Theorem 3.1

Under the hypotheses above,

\[
 \boxed{
 \deg A
 \ge
 D-\deg X-\deg Y+1.}
\tag{3.1}
\]

Consequently,

\[
 \boxed{
 \deg A
 \ge
 D\left(1-\frac1m-\frac1n\right)+1.}
\tag{3.2}
\]

#### Proof

Apply the polynomial abc theorem to

\[
 X^m+A=Y^n.
\]

Because the three terms are pairwise coprime and not all constant,
Mason--Stothers gives

\[
 D
 \le
 \deg\operatorname{rad}(X^m A Y^n)-1.
\]

Taking radicals removes all powers, so

\[
 \deg\operatorname{rad}(X^m A Y^n)
 =\deg\operatorname{rad}(XAY)
 \le\deg X+\deg A+\deg Y.
\]

This proves (3.1).  Since

\[
 \deg X\le D/m,
 \qquad
 \deg Y\le D/n,
\]

inequality (3.2) follows.

## 4. No-go theorem

### Theorem 4.1 (polynomial perfect-power gap barrier)

Suppose a polynomial parametrization satisfies

\[
 \deg A\le\theta D
\]

for arbitrarily large specializations, with one fixed real `theta`.  Then

\[
 \boxed{
 \theta\ge1-\frac1m-\frac1n.}
\tag{4.1}
\]

In particular, it is impossible to satisfy the strict abc-disproof budget
(1.1).

#### Proof

Divide (3.2) by `D` and let the parameter degree, or any iterated composition
degree used to produce the family, tend to infinity.  The additive term `1/D`
vanishes and gives (4.1).

For one fixed polynomial identity the same conclusion follows directly by
comparing the exact degrees: a strict inequality

\[
 \theta<1-1/m-1/n
\]

contradicts (3.2).

## 5. Square--cube specialization

For `(m,n)=(3,2)`, or equivalently after interchanging the two powers,

\[
 1-\frac13-\frac12=\frac16.
\]

Thus every polynomial family of square--cube gaps satisfies

\[
 \deg(y^2-x^3)\ge\frac16D+1.
\]

The fixed saving below the Hall exponent `1/6` required to disprove abc cannot
come from a polynomial parametrization.

## 6. Scope of the exclusion

The theorem eliminates:

- one-parameter polynomial identities;
- iterates or compositions whose coprimality remains within the
  Mason--Stothers hypotheses;
- polynomial norm identities which, after removing a common factor, give a
  pairwise-coprime three-term relation.

It does **not** eliminate:

- isolated or extremely sparse integer points on a fixed high-genus curve;
- recurrence sequences not arising from a polynomial identity;
- rational functions with specialization-dependent cancellations and bad
  denominators, until those contributions are analyzed;
- analytic constructions of close unequal perfect powers;
- families in positive characteristic where Frobenius invalidates the
  characteristic-zero Mason theorem.

The generalized perfect-power disproof route therefore remains active, but its
polynomial-identity subroute is now rigorously excluded rather than abandoned
for lack of examples.

## 7. Lean formalization plan

The source-independent degree arithmetic is formalized first.  Given a
Mason--Stothers inequality

\[
 D\le x+y+z,
\]

and the power bounds `x<=D/m`, `y<=D/n`, Lean proves

\[
 z\ge D(1-1/m-1/n).
\]

A later polynomial layer will instantiate `x=deg X`, `y=deg Y`,
`z=deg A`, using the polynomial abc theorem when its API is available.  No
Mason theorem is inserted as an axiom.
