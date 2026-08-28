# No nontrivial rational self-map preserves the three-point support

## 1. The prospective amplification mechanism

A particularly attractive exceptional-set amplifier would be a fixed rational
map

\[
  f:\mathbb P^1\longrightarrow\mathbb P^1
\]

of degree greater than one such that

\[
  f^{-1}(\{0,1,\infty\})
  \subseteq\{0,1,\infty\}.
\]

Then both `f(x)` and `1-f(x)` would be units in the coordinate ring

\[
  \mathbb C[x,x^{-1},(1-x)^{-1}],
\]

and specializing an S-unit solution could preserve its prime support without
introducing new zero or pole divisors.

The following theorem proves that this exact mechanism does not exist.

## 2. Three-fiber Riemann--Hurwitz theorem

### Theorem 2.1

Let `f:P^1_C -> P^1_C` be a nonconstant rational map. If

\[
  f^{-1}(\{0,1,\infty\})
  \subseteq\{0,1,\infty\},
\]

then `deg f=1`.

#### Proof

Put `d=deg f`. For `y in {0,1,infinity}`, let `r_y` be the number of distinct
points in the fiber `f^{-1}(y)`. Since every point in these three disjoint
fibers belongs to the three-point set `{0,1,infinity}`, we have

\[
  r_0+r_1+r_\infty\leq3.
\]

The sum of ramification defects in the fiber over `y` is

\[
  \sum_{x\in f^{-1}(y)}(e_x-1)=d-r_y,
\]

because the ramification indices in one fiber sum to `d`. Therefore the three
specified fibers alone contribute

\[
  3d-(r_0+r_1+r_\infty)
\]

to the total ramification.

Riemann--Hurwitz for a self-map of `P^1` says that the total ramification is

\[
  2d-2.
\]

Consequently

\[
  3d-(r_0+r_1+r_\infty)\leq2d-2,
\]

and hence

\[
  d\leq r_0+r_1+r_\infty-2\leq1.
\]

Since `f` is nonconstant, `d>=1`, so `d=1`.

### Corollary 2.2

Every rational map satisfying the support condition is a Mobius
transformation permuting the set `{0,1,infinity}`. Thus the only such maps are
the six standard `S_3` transformations

\[
 x,\quad1-x,\quad1/x,\quad1/(1-x),
 \quad x/(x-1),\quad(x-1)/x.
\]

They merely permute an abc triple and cannot provide polynomially many new
exceptions.

## 3. Algebraic S-unit formulation

Equivalently, if nonconstant rational functions `u,v` satisfy

\[
  u+v=1
\]

and the divisors of both `u` and `v` are supported on `{0,1,infinity}`, then
`u` is one of the six degree-one solutions above.  There is no degree-greater-
than-one self-amplifier inside the same three-point S-unit ring.

## 4. Route decision

This theorem eliminates the **fixed rational self-map preserving the exact
three-point support** as an exceptional-set amplification mechanism.  It does
not eliminate:

1. correspondences whose source has more punctures;
2. maps introducing a controlled finite set of new primes;
3. maps defined over varying number fields followed by a norm operation;
4. modular or Hurwitz correspondences with many rational branches;
5. parameterized identities whose maps depend on the input triple.

Those refinements remain active, but each must quantify the new radical,
height growth, multiplicity, and overlap in the exceptional-set amplification
criterion.
