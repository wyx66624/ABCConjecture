# No fixed algebraic-curve family can beat the perfect-power gap threshold

## 1. Function-field formulation

Let `k` be an algebraically closed field of characteristic zero and let
`C/k` be a smooth projective curve of genus `g`.  Write `K=k(C)`.  Let

\[
 X,Y,A\in K^\times
\]

satisfy

\[
 X^m+A=Y^n,
 \qquad m,n\ge2,
\tag{1.1}
\]

and assume that the zero and pole divisors of the three terms have no common
component after the usual normalization.  Let `h(f)` denote the degree of the
map `f:C->P^1`, equivalently the degree of its pole divisor, and put

\[
 D=\max\{m h(X),n h(Y),h(A)\}.
\]

## 2. Function-field abc estimate

The function-field abc theorem gives

\[
 D
 \le
 \deg\operatorname{rad}(XAY)+2g-2.
\tag{2.1}
\]

The reduced divisor of `XAY` has degree at most

\[
 h(X)+h(Y)+h(A)
\]

in the normalized three-term formulation.  Hence

\[
 h(A)
 \ge
 D-h(X)-h(Y)-(2g-2).
\]

Using

\[
 h(X)\le D/m,
 \qquad
 h(Y)\le D/n,
\]

we obtain the fixed-curve gap bound

\[
 \boxed{
 h(A)
 \ge
 D\left(1-\frac1m-\frac1n\right)-(2g-2).}
\tag{2.2}
\]

The harmless convention at `g=0` may be written with an absolute error
`O_C(1)`; the asymptotic coefficient is the displayed one.

## 3. No-go theorem

### Theorem 3.1

Let a sequence of identities (1.1) live over one fixed curve `C` and satisfy
`D_j->infinity`.  Then

\[
 \liminf_{j\to\infty}
 \frac{h(A_j)}{D_j}
 \ge
 1-\frac1m-\frac1n.
\tag{3.1}
\]

Consequently no family parametrized by one fixed algebraic curve can satisfy
one fixed strict gap budget

\[
 \frac{h(A_j)}{D_j}
 \le\theta
 <1-\frac1m-\frac1n.
\]

For square--cube gaps, the barrier is again `1/6`.

## 4. Scope

This excludes:

- polynomial parametrizations;
- rational-function parametrizations after accounting for their poles;
- families on any fixed finite cover of the parameter line;
- fixed-genus algebraic correspondences which reduce to one three-term
  function-field identity.

It does not exclude:

- isolated integer points not lying in one fixed algebraic family;
- a sequence of curves whose genus grows with the point;
- analytic or recurrence constructions not induced by a function-field
  identity;
- higher-dimensional families where specialization and gcd phenomena are not
  controlled by one curve-level radical divisor.

Thus the perfect-power disproof route survives only in genuinely arithmetic or
varying-complexity forms.  A fixed algebraic parametrization is ruled out by
the characteristic-zero function-field abc theorem itself.
