# An exact Hall squarefull gate for the abc conjecture

Author: ChatGPT. Date: 2026-08-31.

## 0. Status

This note proves a deterministic counterexample gate.  It does not assert
that an unbounded family satisfying its squarefull premise exists.  The
standard abc conjecture remains unchanged throughout.

## 1. Primitive Hall data

Let `X,Y,K` be positive integers such that

\[
                         X^3+K=Y^2,
 \qquad \gcd(X,Y)=1.                                      \tag{1.1}
\]

Then `(X^3,K,Y^2)` is a positive primitive abc point.  Indeed,
`gcd(X^3,Y^2)=1`.  A common divisor of `X^3` and `K` divides
`X^3+K=Y^2`, and is therefore one; the same argument proves
`gcd(K,Y^2)=1`.

## 2. Exact radical compression

### Theorem 2.1 (twelfth-power Hall bound)

Assume in addition that `K` is squarefull and

\[
                              K^2\le X.                    \tag{2.1}
\]

Put

\[
                         \mathcal R=\rad(X^3KY^2).
\]

Then

\[
                       \boxed{\mathcal R^{12}< (Y^2)^{11}}. \tag{2.2}
\]

Consequently, for the logarithmic conductor `R=log mathcal R` and height
`H=log(Y^2)`, one has

\[
                              R<\frac{11}{12}H.             \tag{2.3}
\]

**Proof.**  Radical submultiplicativity, invariance under positive powers,
and the elementary bounds `rad(X)<=X`, `rad(Y)<=Y` give

\[
 \mathcal R\le X\,\rad(K)\,Y.                              \tag{2.4}
\]

Squarefullness gives `rad(K)^2<=K`.  Raising this inequality to the sixth
power, and raising (2.1) to the third power, yields

\[
                    \rad(K)^{12}\le K^6\le X^3.             \tag{2.5}
\]

Raise (2.4) to the twelfth power and apply (2.5):

\[
                    \mathcal R^{12}\le X^{15}Y^{12}.        \tag{2.6}
\]

Because `K>0`, equation (1.1) gives `X^3<Y^2`.  Its fifth power is
`X^15<Y^10`; multiplying by the positive integer `Y^12` turns (2.6) into
(2.2).  Both sides are positive, so the increasing logarithm and
`log(t^m)=m log t` give `12R<11H`, proving (2.3).  \(\square\)

### Corollary 2.2 (conditional disproof)

If there is a height-unbounded sequence of data satisfying (1.1), (2.1),
and squarefullness of `K`, then the standard abc conjecture is false.

**Proof.**  Apply standard abc with `epsilon=1/12` to the primitive points
of Section 1.  Theorem 2.1 would give

\[
 H\le\frac{13}{12}R+C
   <\frac{143}{144}H+C,
\]

which bounds `H`, contrary to the hypothesis.  \(\square\)

## 3. Relation to Danilov's family

The independently audited Danilov normalization supplies an unbounded
primitive family `X^3+K=Y^2` with `K` of order `sqrt(X)`.  On a tail where
the explicit constant gives `K^2<=X`, Theorem 2.1 reduces a genuine abc
counterexample to squarefullness of the moving remainder `K` at unbounded
indices.  No such squarefull subsequence is proved here.  Exact fixed powers
of that remainder are a narrower specialization and do not decide the
squarefull problem with moving square and cube kernels.

The Lean companion must formalize Sections 1--2 only.  The Danilov
parametrization, its Pell congruence class, and the existence of a squarefull
subsequence are not to be inserted as axioms.
