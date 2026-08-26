# Mason--Stothers obstruction to polynomial perfect-power counterexamples

## 1. The surviving disproof criterion

Fix integers `m,n>=2`.  An infinite sequence of coprime positive pairs with

\[
 0<y^n-x^m\le (y^n)^\theta,
 \qquad
 \theta+\frac1m+\frac1n<1,
\]

would disprove the abc conjecture.  This criterion remains active for genuinely
arithmetic, nonparametric sequences.

A natural subroute is to seek polynomial identities

\[
 Y(T)^n-X(T)^m=Z(T)
\]

whose degree gap already satisfies the strict budget.  This note proves that
this degree-based polynomial route is impossible in characteristic zero.

## 2. The degree theorem

Let `K` be a field of characteristic zero.  Let `X,Y,Z in K[T]` be nonzero,
pairwise coprime polynomials satisfying

\[
  Y^n-X^m=Z.
\tag{2.1}
\]

Assume

\[
 d=\deg Z< D:=\max\{m\deg X,n\deg Y\}.
\]

The leading terms in (2.1) must cancel, hence

\[
  D=m\deg X=n\deg Y.
\tag{2.2}
\]

### Theorem 2.1

Under these hypotheses,

\[
 \boxed{
 \frac dD+\frac1m+\frac1n
 \ge 1+\frac1D>1.}
\tag{2.3}
\]

In particular no such identity can satisfy the strict abc-disproof budget

\[
 \frac dD+\frac1m+\frac1n<1.
\]

### Proof

Apply the Mason--Stothers polynomial abc theorem to the pairwise coprime
identity

\[
 X^m+Z=Y^n.
\]

It gives

\[
 D\le \deg\operatorname{rad}(XYZ)-1.
\]

For every polynomial `F`,

\[
 \deg\operatorname{rad}(F)\le\deg F.
\]

Consequently

\[
 \begin{aligned}
 D
 &\le \deg X+\deg Y+\deg Z-1\\
 &=\frac Dm+\frac Dn+d-1.
 \end{aligned}
\]

After division by `D>0`,

\[
 1+\frac1D
 \le \frac1m+\frac1n+\frac dD,
\]

which proves (2.3).

## 3. The square--cube horizon

For `(m,n)=(2,3)`, Theorem 2.1 becomes

\[
 \boxed{\frac dD\ge\frac16+\frac1D.}
\tag{3.1}
\]

Thus a polynomial identity cannot even attain the Hall horizon `1/6`; it lies
strictly above it by the finite-degree correction `1/D`.

## 4. What is and is not excluded

The theorem strictly excludes the following mechanism:

1. choose fixed polynomials `X,Y,Z` satisfying (2.1);
2. specialize `T` to infinitely many integers;
3. use only their polynomial degrees and the trivial radical estimate
   `rad(F(t))<=|F(t)|` to obtain an abc counterexample.

It does **not** exclude:

- nonparametric close perfect powers;
- a polynomial identity whose special values have radically smaller support
  than their generic size;
- recurrence sequences with exceptional smooth values;
- rational functions with specialization-dependent cancellation;
- sparse sequences selected by an independent arithmetic theorem.

Those surviving routes remain in the registry.

## 5. Lean boundary

The accompanying Lean module formalizes the exact scalar consequence of the
Mason degree inequality.  Formalizing Mason--Stothers itself and the polynomial
coprimality/radical layer is a separate algebraic development; no placeholder
axiom is introduced.
