# Three-point rational-map amplification: a Riemann--Hurwitz no-go theorem

## 1. Motivation

A natural exceptional-set amplification idea is to start from

\[
  \lambda=\frac{a}{c},\qquad 1-\lambda=\frac{b}{c},
\]

and apply a rational self-map `f` of the thrice-punctured line.  If both
`f(lambda)` and `1-f(lambda)` factor only through the old boundary divisors
`lambda`, `1-lambda`, and infinity, then specialization would introduce no new
prime support except a fixed coefficient set.  Iterating such a map could then
appear to generate many further high-quality abc triples.

The theorem below proves that no nontrivial rational map has this property.

## 2. Boundary-complexity theorem

Let `k` be an algebraically closed field of characteristic zero and let

\[
  f:\mathbb P^1_k\longrightarrow\mathbb P^1_k
\]

be a nonconstant rational map of degree `d`.  Set

\[
  T_f=f^{-1}(\{0,1,\infty\}).
\]

### Theorem 2.1

\[
  |T_f|\ge d+2.
\]

### Proof

For `y in {0,1,infinity}`, let `r_y` be the number of distinct points in the
fiber `f^{-1}(y)`.  Since the sum of ramification indices in one fiber is `d`,

\[
  \sum_{x\in f^{-1}(y)}(e_x-1)=d-r_y.
\]

The three fibers are disjoint, so their total ramification contribution is

\[
  3d-(r_0+r_1+r_\infty)=3d-|T_f|.
\]

Riemann--Hurwitz for a separable map from `P^1` to `P^1` gives total
ramification

\[
  \sum_{x\in\mathbb P^1}(e_x-1)=2d-2.
\]

The ramification over `0,1,infinity` is only part of the total ramification;
therefore

\[
  3d-|T_f|\le2d-2,
\]

which is equivalent to `|T_f|>=d+2`.

### Corollary 2.2 (three-point rigidity)

If

\[
  f^{-1}(\{0,1,\infty\})
  \subseteq\{0,1,\infty\},
\]

then `d=1`.  Hence `f` is one of the six anharmonic transformations

\[
 t,\quad 1-t,\quad \frac1t,\quad \frac1{1-t},\quad
 \frac{t-1}{t},\quad \frac{t}{t-1}.
\]

Indeed, Theorem 2.1 gives `d+2<=3`; thus `d=1`, and a degree-one map with the
stated inverse-image property permutes the three marked points.

## 3. Quantitative new-boundary lower bound

### Corollary 3.1

Every degree-`d>1` rational map introduces at least `d-1` points outside the
original three-point boundary:

\[
  |T_f\setminus\{0,1,\infty\}|\ge d-1.
\]

More precisely, the left side is at least `|T_f|-3`, and Theorem 2.1 gives
`|T_f|-3>=d-1`.

### Corollary 3.2 (iteration)

If `deg f=d>1`, then

\[
  |(f^n)^{-1}(\{0,1,\infty\})|\ge d^n+2.
\]

Thus the boundary complexity of the iterates grows at least exponentially.

## 4. Consequence for abc amplification

A fixed rational transformation that introduces no new divisor beyond
`0,1,infinity` cannot amplify an abc triple: it is only one of the six
permutations of `(a,b,c)`.

A degree-`d` transformation necessarily introduces at least `d-1` additional
boundary divisors.  After specialization these give additional algebraic
factors, such as norms of `a-alpha c`, whose prime support must be controlled.
The Riemann--Hurwitz theorem does not by itself prove that every specialization
has a large radical, but it proves that exact support preservation and bounded
boundary complexity are impossible for a high-degree amplification map.

Consequently the polynomial/Belyi subroute of exceptional-set amplification
must do one of the following:

1. prove strong smooth-value estimates for a growing collection of new
   boundary factors;
2. exploit cancellations among their norms while controlling all Jacobians;
3. use a family of maps with a separate incidence argument, rather than
   iterating one fixed support-preserving map.

The exact radical-preserving rational-map variant is eliminated by Corollary
2.2.  The broader exceptional-set amplification route remains active.
