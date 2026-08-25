# Scalar norm rigidity over the thrice-punctured line

## 1. Set-up

Let `k` be a field, put

\[
  U=\mathbb P^1_k\setminus\{0,1,\infty\},
  \qquad K=k(t),
\]

and let `L/K` be a finite separable extension arising from a finite cover of
`U`.  Let `u in L^x` be a rational function whose divisor on the normalization
of `P^1` is supported above the three-point boundary.

Such a function is a natural output of level structures, torsion functions,
theta units, or a Belyi cover.  A proposed amplification mechanism may try to
take its field norm to obtain a rational function on the original abc line.

## 2. Norm divisor

### Theorem 2.1

The divisor of the norm

\[
  N_{L/K}(u)\in K^\times
\]

is supported on `0,1,infinity`.

### Proof

For every closed point `x` of `P^1`, the valuation of a field norm is

\[
  v_x(N_{L/K}(u))
  =\sum_{y\mid x}f(y/x)v_y(u).
\]

If `x` is outside the boundary, every point `y` above `x` lies outside the
support of `div(u)`, so every summand is zero.

## 3. Classification of three-point units

### Lemma 3.1

Every rational function in `k(t)^x` whose divisor is supported on
`0,1,infinity` has the form

\[
  c\,t^m(1-t)^n,
  \qquad
  c\in k^\times,\quad m,n\in\mathbb Z.
\]

### Proof

The orders at zero and one determine integers `m,n`.  Dividing by
the displayed monomial leaves a rational function with trivial divisor on
`P^1`, hence a constant.

### Corollary 3.2 (norm rigidity)

There exist `c in k^x` and integers `m,n` such that

\[
  N_{L/K}(u)=c\,t^m(1-t)^n.
  \tag{1}
\]

## 4. Arithmetic specialization

At a primitive abc specialization

\[
  t=\frac ac,
  \qquad
  1-t=\frac bc,
\]

(1) becomes

\[
  N_{L/K}(u)(a/c)
  =c_0\,a^m b^n c^{-m-n}.
\]

Thus the scalar norm introduces no new independent arithmetic quantity: it is
only a monomial in the original three boundary values, up to a fixed constant.

## 5. No-go consequence

A Galois-orbit or level-structure amplification that descends all data to one
scalar **only by taking field norms of boundary-supported units** cannot create
a new abc relation.  It recovers a monomial consequence of the original
`a+b=c` data.

This eliminates the scalar norm-only subroute.  It does not eliminate:

1. vector-valued packets retained before taking a norm;
2. projective oscillation or maximal-slope invariants;
3. traces or determinants involving sums of units, whose divisors need not be
   boundary supported;
4. discriminants/resultants of conjugate packets;
5. norm constructions in which controlled new interior divisors are essential.

Any surviving norm/descent amplifier must therefore retain genuinely
non-scalar information or prove quantitative control of new interior factors.
