# The Riemann--Hurwitz barrier to algebraic abc amplification

## 1. Motivation

The exceptional-set amplification programme asks whether one exceptional
rational point can be mapped to many further exceptional points by iterating a
rational or Belyi map.  The strongest conceivable version would preserve the
three boundary divisors `0,1,infinity`, so that no new arithmetic support is
introduced.

This note proves that no nontrivial map has this property.  More generally, a
degree-`d` rational map creates at least `d+2` distinct geometric boundary
components above the three marked points.  Thus one-variable algebraic
amplification is constrained by the same geometry as the function-field abc
theorem.

## 2. Boundary-preimage count

Let `k` be an algebraically closed field of characteristic zero, and let

\[
 f:\mathbb P^1_k\longrightarrow\mathbb P^1_k
\]

be a nonconstant morphism of degree `d`.  Put

\[
 D=\{0,1,\infty\}
\]

and let

\[
 r=\#f^{-1}(D)
\]

count distinct geometric points.

### Theorem 2.1 (boundary count)

\[
 \boxed{r\ge d+2.}
\tag{2.1}
\]

Equality holds if and only if every ramification point of `f` lies above
`D`, i.e. if and only if `f` is a Belyi map with respect to this marking.

#### Proof

For each of the three values in `D`, the sum of ramification indices over its
fibre is `d`.  Hence the ramification contribution over `D` is

\[
 \sum_{x\in f^{-1}(D)}(e_x-1)
 =3d-r.
\tag{2.2}
\]

Riemann--Hurwitz on `P^1` gives

\[
 \sum_{x\in\mathbb P^1}(e_x-1)=2d-2.
\tag{2.3}
\]

The contribution (2.2) is at most the total (2.3), so

\[
 3d-r\le2d-2,
\]

which is equivalent to `r>=d+2`.  Equality is equivalent to the absence of
ramification outside `f^{-1}(D)`.

## 3. No support-preserving self-amplification

### Corollary 3.1

If

\[
 f^{-1}(D)\subseteq D,
\]

then

\[
 \boxed{d=1.}
\]

#### Proof

The inclusion gives `r<=3`.  Theorem 2.1 gives `d+2<=r`, hence `d<=1`.
Nonconstancy gives `d>=1`.

Thus there is no degree-greater-than-one rational self-map of the
thrice-punctured line which introduces no new boundary divisors.

## 4. Consequence for radical amplification

Let the distinct points of `f^{-1}(D)` be cut out, after passing to a splitting
field, by linear factors

\[
 L_1,\ldots,L_r.
\]

When a rational input is specialized, primes in the output radical may arise
from the values of all `L_i`, not merely from the original three boundary
coordinates.  Theorem 2.1 says that a degree-`d` map necessarily carries at
least `d+2` such geometric sources of support.

For a Belyi map this count is exactly `d+2`, which is the equality case of the
function-field abc/Mason--Stothers inequality.  Therefore a one-variable
Belyi transformation does not create a geometric height-to-boundary advantage:
its output degree is `d`, while its reduced boundary divisor has degree
`d+2`.

This does not by itself prove that every number-field specialization has large
radical; distinct polynomial values can share primes, and exceptional
arithmetic cancellation remains possible.  It does prove that no
**support-preserving** algebraic amplification exists and that any successful
arithmetic amplifier must exploit special common factors or correlations not
visible in the geometric map alone.

## 5. Routes eliminated and retained

The theorem eliminates:

1. iteration of a degree-greater-than-one rational map satisfying
   `f^{-1}({0,1,infinity}) subset {0,1,infinity}`;
2. any claim that an ordinary Belyi map amplifies abc quality merely because
   all of its ramification lies over the three marked values;
3. polynomial-identity amplification which relies only on geometric
   ramification multiplicities and not on additional arithmetic common
   factors.

The following remain active:

- several-variable correspondences with controlled projection degrees;
- Hecke or isogeny correspondences rather than one-valued self-maps;
- arithmetic norm constructions whose many geometric factors share a small
  set of rational prime divisors;
- dynamically selected maps depending on the input triple;
- amplification through rational points on higher-dimensional moduli spaces.

## 6. Lean formalization plan

The Riemann--Hurwitz theorem itself requires algebraic-geometry APIs.  The
source-independent arithmetic core is elementary: from

`3*d-r <= 2*d-2`

one derives `d+2<=r`, and adding `r<=3` and `1<=d` gives `d=1`.  This scalar
core is formalized first without postulating Riemann--Hurwitz as an axiom.
