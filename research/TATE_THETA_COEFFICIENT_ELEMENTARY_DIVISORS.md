# Exact elementary divisors of the Tate theta coefficient basis

## 1. Purpose

The finite transverse frame acts on theta coefficients indexed by

\[
 z\in\mathbb F_\ell^2/\{\pm1\}.
\]

The centered-weight theorem computes the expected tropical orders of these
coordinates.  This note proves that these are not merely asymptotic leading
terms: over a complete nonarchimedean field they are the **exact elementary
divisors** of the residue-class theta basis.  Each normalized coefficient is a
unit.

This closes the multiplicative local diagonal part of the integral theta-frame
comparison.  The remaining local factors are the finite phase-minor determinant,
the passage to the pure integral theta lattice, and the level-prime corrections.

## 2. Unique centered minimizer

Let

\[
 \ell=2m+1
\]

be odd.  For a residue class `j mod ell`, let

\[
 r(j)\in\{-m,\ldots,m\}
\]

be its centered representative.

### Lemma 2.1

For every integer `k`,

\[
 |r(j)+\ell k|\ge |r(j)|,
\]

with equality if and only if `k=0`.

#### Proof

If `k!=0`, then

\[
 |r(j)+\ell k|
 \ge\ell|k|-|r(j)|
 \ge\ell-m=m+1>|r(j)|.
\]

Thus the centered representative is the unique minimum of the absolute value
in its residue class.

### Corollary 2.2

For `z=(j_1,j_2)` and `k=(k_1,k_2) in Z^2`,

\[
 |r(z)+\ell k|^2\ge |r(z)|^2,
\]

with equality if and only if `k=(0,0)`.

## 3. Local residue-class theta series

Let `K` be complete nonarchimedean, let `s in K` satisfy

\[
 0<|s|<1,
 \qquad q=s^\ell,
\]

and assume the required theta series converge.  For `z in F_ell^2`, define

\[
 A_z(s)=
 \sum_{k\in\mathbb Z^2}
 s^{|r(z)+\ell k|^2}.
\tag{3.1}
\]

This is the residue-class coefficient obtained by grouping the rank-two theta
series by the class of its lattice index modulo `ell`.

### Theorem 3.1 (unit-normalized coefficient)

\[
 \boxed{
 A_z(s)=s^{|r(z)|^2}U_z(s),
 \qquad |U_z(s)|=1.}
\tag{3.2}
\]

Moreover,

\[
 U_z(s)\equiv1\pmod{\mathfrak m_K}.
\tag{3.3}
\]

#### Proof

Factor the unique minimal term:

\[
 U_z(s)=1+
 \sum_{k\ne0}
 s^{|r(z)+\ell k|^2-|r(z)|^2}.
\]

Corollary 2.2 makes every exponent in the tail a positive integer.  Therefore
every tail term has norm strictly less than one.  The convergent tail has norm
strictly less than one by the ultrametric inequality, so `U_z(s)` is congruent
to one and has norm one.

### Corollary 3.2 (exact q-order)

With `L=-log|q|`,

\[
 \boxed{
 -\log|A_z(s)|
 =\frac{|r(z)|^2}{\ell}L.}
\tag{3.4}
\]

## 4. Even sign classes

The coefficient satisfies

\[
 A_{-z}(s)=A_z(s),
\]

by the change of variable `k -> -k`.  Thus it descends to the even coordinate
set `F_ell^2/{±1}` without changing its valuation.  If an evaluation convention
uses the symmetrized coefficient `A_z+A_{-z}=2A_z`, the extra factor is a unit
at every place of residue characteristic different from two; at the fixed
prime two it contributes only a controlled constant.

## 5. Determinant elementary divisors

Let `J` be a square full-rank minor of the transverse phase matrix and let

\[
 D(s)=\operatorname{diag}
  (A_{[z]}(s))_{[z]\in F_\ell^2/\{\pm1\}}.
\]

The corresponding local frame matrix is

\[
 \Phi_JD(s).
\]

### Theorem 5.1

\[
 \boxed{
 -\log|\det(\Phi_JD(s))|
 =\frac{\ell(\ell^2-1)}{12}L
  -\log|\det\Phi_J|.}
\tag{5.1}
\]

#### Proof

The determinant is

\[
 \det\Phi_J\prod_{[z]}A_{[z]}(s).
\]

Apply Corollary 3.2 and the centered even-coordinate weight theorem.

At finite places not dividing the algebraic integer `det Phi_J`, the second
term is zero.  Globally its normalized contribution is level-sized; the
integral convolution determinant and the Cauchy--Binet frame determinant both
give explicit `O(log ell)` candidates.

## 6. Consequence for the pure-theta frame target

The multiplicative local diagonal profile is now explicit and contains no
unknown unit or cancellation:

\[
 \left\{
  \frac{|r(z)|^2}{\ell}L
 \right\}_{[z]}.
\]

The total is

\[
 \frac{M_\ell}{6}L.
\]

Therefore the remaining local arithmetic theorem is narrowed to:

1. identify the residue-class analytic theta basis with an integral basis of
   the pure theta lattice;
2. compute the finite phase-minor elementary divisors at the level prime and
   under descent;
3. compute the other-cusp/pure-boundary divisor required by the packet-
   normalization barrier.

The first item is a comparison of two explicit theta structures, not a search
for the q-exponents.  The second depends only on `ell`; the third is the true
global divisor calculation.

## 7. Formalization plan

The Lean development can proceed through:

1. the unique centered representative inequality in `Z`;
2. uniqueness of the two-dimensional minimum;
3. factorization of the existing convergent Laurent/theta series;
4. ultrametric unitness of `1 +` a strictly small summable tail;
5. the determinant valuation sum using `CenteredThetaWeight.lean`.

The upstream Tate-theta library already contains ultrametric sum and
Strassmann/max-term tools suitable for step 4.  No global height theorem is
assumed in these local layers.
