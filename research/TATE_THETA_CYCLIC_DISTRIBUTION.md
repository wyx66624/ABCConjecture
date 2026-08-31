# Exact cyclic distribution identities for the Tate theta product

## 1. Normalization

Let `K` be a complete nonarchimedean field, let `q in K` satisfy

\[
  0<|q|<1,
\]

and use the product normalization already present in the
`tate-curves-theta` library:

\[
 \Theta_q(u)
 =C(q)
   \prod_{n\ge1}(1+q^n u)
   \prod_{n\ge0}(1+q^n u^{-1}),
\]

where

\[
  C(q)=\prod_{n\ge1}(1-q^n).
\]

The zeros are the orbit `u=-q^m`, and `C(q)` is a nonzero unit.  Let `ell` be
an odd positive integer.

These identities concern the product form directly.  They do not require the
currently documented series-equals-product seam.

## 2. The canonical cyclic subgroup

Assume `K` contains all `ell`-th roots of unity.  For every `x`, the elementary
factor identity is

\[
  \prod_{\zeta^\ell=1}(1+\zeta x)=1+x^\ell,
\]

because `ell` is odd.

### Theorem 2.1 (canonical distribution)

For every `u in K^x`,

\[
 \boxed{
 \prod_{\zeta^\ell=1}\Theta_q(\zeta u)
 =\frac{C(q)^\ell}{C(q^\ell)}
   \Theta_{q^\ell}(u^\ell).}
 \tag{2.1}
\]

#### Proof

The constant factor contributes `C(q)^ell`.  At each positive index `n`,

\[
 \prod_{\zeta^\ell=1}(1+q^n\zeta u)
 =1+q^{n\ell}u^\ell.
\]

Likewise,

\[
 \prod_{\zeta^\ell=1}(1+q^n\zeta^{-1}u^{-1})
 =1+q^{n\ell}u^{-\ell}.
\]

Multiplying over the two convergent factor families gives precisely the
variable part of `Theta_(q^ell)(u^ell)`.  Its constant factor is
`C(q^ell)`, which gives the displayed ratio.

Since every factor `1-q^n` has norm one,

\[
 \left|\frac{C(q)^\ell}{C(q^\ell)}\right|=1.
 \tag{2.2}
\]

Thus the canonical distribution introduces no nonarchimedean metric defect.

## 3. A noncanonical cyclic subgroup

Let `s in K^x` satisfy

\[
  s^\ell=q.
\]

The images of

\[
  1,s,s^2,\ldots,s^{\ell-1}
\]

in `K^x/q^Z` form a noncanonical cyclic subgroup of order `ell`.

### Theorem 3.1 (root-period distribution)

For every `u in K^x`,

\[
 \boxed{
 \prod_{j=0}^{\ell-1}\Theta_q(s^j u)
 =\frac{C(q)^\ell}{C(s)}
  s^{-\ell(\ell-1)/2}u^{-(\ell-1)}
  \Theta_s(u).}
 \tag{3.1}
\]

Since `ell` is odd and `s^ell=q`, this may also be written

\[
 \prod_{j=0}^{\ell-1}\Theta_q(s^j u)
 =\frac{C(q)^\ell}{C(s)}
  q^{-(\ell-1)/2}u^{-(\ell-1)}
  \Theta_s(u).
 \tag{3.2}
\]

#### Proof

Write

\[
 A_q(u)=\prod_{n\ge1}(1+q^n u),
 \qquad
 B_q(u)=\prod_{n\ge0}(1+q^n u^{-1}).
\]

For the forward factors,

\[
 \prod_{j=0}^{\ell-1}A_q(s^j u)
 =\prod_{n\ge1}\prod_{j=0}^{\ell-1}
   (1+s^{n\ell+j}u).
\]

The exponents `n ell+j` occurring here are exactly all integers at least
`ell`.

For the inverse factors,

\[
 \prod_{j=0}^{\ell-1}B_q(s^j u)
 =\prod_{n\ge0}\prod_{j=0}^{\ell-1}
   (1+s^{n\ell-j}u^{-1}).
\]

The nonnegative exponents occurring in this product are exactly
`0,1,2,...`.  The remaining factors are those with exponents
`-1,...,-(ell-1)`.  For `1<=j<=ell-1`,

\[
 1+s^{-j}u^{-1}
 =s^{-j}u^{-1}(1+s^j u).
\]

Their scalar product is

\[
 \prod_{j=1}^{\ell-1}s^{-j}u^{-1}
 =s^{-\ell(\ell-1)/2}u^{-(\ell-1)}.
\]

The accompanying factors `(1+s^j u)` supply exactly the forward exponents
`1,...,ell-1` missing from the first product.  The complete variable product
is therefore

\[
 s^{-\ell(\ell-1)/2}u^{-(\ell-1)}A_s(u)B_s(u).
\]

Restoring the constant factors proves (3.1).

Again `C(q)` and `C(s)` have norm one.  Hence the complete nonarchimedean
metric defect is the explicit automorphy monomial:

\[
 \log\left|
  \frac{C(q)^\ell}{C(s)}
  s^{-\ell(\ell-1)/2}u^{-(\ell-1)}
 \right|
 =-\frac{\ell(\ell-1)}2\log|s|
  -(\ell-1)\log|u|.
 \tag{3.3}
\]

## 4. Relation to the cyclic kernel section

Dividing (2.1) by the factor with `zeta=1` gives

\[
 \prod_{\substack{\zeta^\ell=1\\\zeta\ne1}}
  \Theta_q(\zeta u)
 =\frac{C(q)^\ell}{C(q^\ell)}
   \frac{\Theta_{q^\ell}(u^\ell)}{\Theta_q(u)}.
 \tag{4.1}
\]

Dividing (3.1) by the factor with `j=0` gives

\[
 \prod_{j=1}^{\ell-1}\Theta_q(s^j u)
 =\frac{C(q)^\ell}{C(s)}
  s^{-\ell(\ell-1)/2}u^{-(\ell-1)}
  \frac{\Theta_s(u)}{\Theta_q(u)}.
 \tag{4.2}
\]

The left sides are the theta realizations of the explicit cyclic kernel
section whose divisor is

\[
 \sum_{P\in C\setminus\{0\}}(P)-(\ell-1)(0).
\]

Thus the algebraic kernel polynomial and the analytic theta product are linked
by an exact distribution formula, not merely by equality of divisors up to an
unspecified constant.

## 5. Canonical metric and Bernoulli energy

Let

\[
 r_q(u)=\frac{\log|u|}{\log|q|}\pmod{\mathbb Z}
\]

and equip the theta section with the standard Tate/Neron metric, whose radial
correction is governed by

\[
 B_2(t)=t^2-t+\frac16.
\]

Applying the Bernoulli distribution identity

\[
 \sum_{j=0}^{\ell-1}B_2\left(\frac{j}{\ell}\right)
 =\frac1{6\ell}
\]

to (2.1)--(3.1) gives the familiar line-energy coefficients:

\[
 \sum_{P\in C_{\rm can}\setminus\{0\}}\lambda_q(P)
 =\frac{\ell-1}{12}(-\log|q|),
 \tag{5.1}
\]

and, for every noncanonical cyclic line,

\[
 \sum_{P\in C\setminus\{0\}}\lambda_q(P)
 =-\frac{\ell-1}{12\ell}(-\log|q|).
 \tag{5.2}
\]

The monomial in (3.1) is essential: it is exactly the automorphy correction
which, together with the Bernoulli metric, produces the negative
noncanonical coefficient.  Omitting it would give the wrong local slope.

## 6. Consequences for the active proof routes

1. **Determinant of cohomology.**  Equations (4.1)--(4.2) provide the explicit
   analytic trivialization of the cyclic kernel section.  The only remaining
   local ambiguity is the chosen normalization of the Hodge/determinant metric.
2. **Steinberg sup packet.**  The canonical and noncanonical coordinate norms
   are derived from one exact distribution identity, so the nonlinear sup or
   projective-oscillation packet has a concrete theta origin.
3. **Good places.**  The constants `C(q)` and `C(s)` are units.  Together with
   the integral kernel-polynomial theorem, this leaves only integral-basis and
   determinant-line Jacobians, not an uncontrolled theta constant.
4. **IUT/ATS audit.**  Any proposed Rosetta comparison must preserve the
   automorphy monomial in (3.1), the Bernoulli correction, and the normalized
   metric.  A set-theoretic identification of theta divisors is insufficient.

## 7. Formalization plan

The upstream library already defines `thetaProdFactor`, `thetaProd` and proves
multipliability of all factor families.  A Lean proof may proceed in the
following order:

1. finite root-of-unity factor identity
   `prod_zeta (1+zeta*x)=1+x^ell` for odd `ell`;
2. canonical distribution by interchanging a finite product and the existing
   convergent infinite products;
3. partition of the integer exponent set in Theorem 3.1;
4. root-period distribution and norm-one constant factors;
5. only afterwards, formalization of the Bernoulli/Neron metric corollaries.

No global slope estimate or abc conclusion is assumed in these identities.
