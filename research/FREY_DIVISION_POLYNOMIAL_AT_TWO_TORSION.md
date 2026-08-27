# Odd division polynomials at the Frey two-torsion points

## 1. Purpose

The cyclic kernel polynomial

\[
  \psi_C(X)=\prod_{\{P,-P\}\subset C\setminus\{O\}}(X-x(P))
\]

is the explicit algebraic section underlying the determinant-of-cohomology and
Steinberg packet routes.  This note computes the product of these sections at
the three rational two-torsion points of the Frey--Legendre curve.

The result identifies, without an unspecified constant, the full common
algebraic factor whose metric normalization must remove.  Its normalized
coefficient is exactly `(ell-1)/2`, the same coefficient appearing in the
highest Hodge line of the active symmetric-power route.

## 2. Division-polynomial normalization

Let `K` be a field of characteristic zero and let

\[
  E: y^2=f(x),
  \qquad
  f(x)=x^3+a_2x^2+a_4x+a_6
\]

be nonsingular.  Let `Psi_n` denote the standard division polynomials,
normalized by

\[
  \Psi_1=1,
  \qquad
  \Psi_2=2y,
\]

and, for `m>=2`,

\[
 \Psi_{2m+1}
 =\Psi_{m+2}\Psi_m^3-
  \Psi_{m-1}\Psi_{m+1}^3.
 \tag{2.1}
\]

Every even division polynomial is divisible by `2y`; hence it vanishes at a
nonzero two-torsion point.

For odd `n`, put

\[
  h(n)=\frac{n^2-1}{4},
  \qquad
  s(n)=(-1)^{(n-1)/2}.
\]

## 3. The initial cubic identity

For the displayed generalized short Weierstrass equation,

\[
 \Psi_3(x)=
 3x^4+4a_2x^3+6a_4x^2+12a_6x+(4a_2a_6-a_4^2).
\]

### Lemma 3.1

\[
  \Psi_3(x)+f'(x)^2=4(3x+a_2)f(x).
  \tag{3.1}
\]

### Proof

Expand

\[
 f'(x)=3x^2+2a_2x+a_4.
\]

The sum of its square and `Psi_3` is

\[
 4\bigl(
 3x^4+4a_2x^3+(a_2^2+3a_4)x^2
 +(a_2a_4+3a_6)x+a_2a_6
 \bigr),
\]

which is `4(3x+a_2)f(x)`.

Thus, at every root `e` of `f`,

\[
  \Psi_3(e)=-f'(e)^2.
  \tag{3.2}
\]

## 4. Exact evaluation at arbitrary two-torsion

### Theorem 4.1

Let `e in K` satisfy `f(e)=0`.  For every positive odd integer `n`,

\[
 \boxed{
  \Psi_n(e)
  =(-1)^{(n-1)/2}
    f'(e)^{(n^2-1)/4}.}
 \tag{4.1}
\]

### Proof

We use strong induction on odd `n`.  The cases `n=1` and `n=3` follow from
`Psi_1=1` and (3.2).

Write `n=2m+1>=5`.

If `m` is odd, the indices `m-1` and `m+1` are even, so the second term of
(2.1) vanishes at `e`.  Hence

\[
  \Psi_n(e)=\Psi_{m+2}(e)\Psi_m(e)^3.
\]

The exponents satisfy

\[
 h(m+2)+3h(m)=m(m+1)=h(2m+1),
\]

while the sign exponent is

\[
 \frac{m+1}{2}+3\frac{m-1}{2}=2m-1,
\]

which has the same parity as `m=(n-1)/2` because `m` is odd.

If `m` is even, the first term of (2.1) vanishes and

\[
  \Psi_n(e)=-\Psi_{m-1}(e)\Psi_{m+1}(e)^3.
\]

Now

\[
 h(m-1)+3h(m+1)=m(m+1)=h(2m+1),
\]

and the total sign exponent is

\[
 1+\frac{m-2}{2}+3\frac m2=2m,
\]

which has the same parity as the even integer `m`.  This completes the
induction.

## 5. Product over all cyclic lines

Let `ell` be an odd prime.  The odd division polynomial has leading
coefficient `ell` and factors as

\[
 \Psi_\ell(X)
 =\ell
  \prod_{\{P,-P\}\subset E[\ell]\setminus\{O\}}
   (X-x(P)).
 \tag{5.1}
\]

Every nonzero `ell`-torsion point lies on a unique cyclic order-`ell` line, so
partitioning the factors in (5.1) gives

\[
 \prod_{C\in\mathbb P(E[\ell])}\psi_C(X)
 =\frac{\Psi_\ell(X)}{\ell}.
 \tag{5.2}
\]

Combining (4.1) and (5.2), for every nonzero two-torsion point `(e,0)`,

\[
 \boxed{
 \prod_C\psi_C(e)
 =\frac{(-1)^{(\ell-1)/2}}{\ell}
  f'(e)^{(\ell^2-1)/4}.}
 \tag{5.3}
\]

## 6. Specialization to the Frey--Legendre curve

Let

\[
 E_{a,b}:y^2=x(x-a)(x+b),
 \qquad a+b=c.
\]

The three roots and derivatives are

\[
 \begin{array}{c|c}
 e&f'(e)\\ \hline
 0&-ab\\
 a&ac\\
 -b&bc.
 \end{array}
\]

Thus, with

\[
 H_\ell=\frac{\ell^2-1}{4},
\]

we have

\[
 \prod_C\psi_C(0)
 =\frac{(-1)^{(\ell-1)/2}}{\ell}(-ab)^{H_\ell},
 \tag{6.1}
\]

\[
 \prod_C\psi_C(a)
 =\frac{(-1)^{(\ell-1)/2}}{\ell}(ac)^{H_\ell},
 \tag{6.2}
\]

\[
 \prod_C\psi_C(-b)
 =\frac{(-1)^{(\ell-1)/2}}{\ell}(bc)^{H_\ell}.
 \tag{6.3}
\]

Multiplying the three identities and ignoring the explicit harmless sign,

\[
 \boxed{
 \left|
  \prod_C
   \psi_C(0)\psi_C(a)\psi_C(-b)
 \right|
 =\ell^{-3}(abc)^{(\ell^2-1)/2}.}
 \tag{6.4}
\]

There are `ell+1` cyclic lines.  Therefore the logarithmic geometric mean of
the raw three-boundary kernel values is

\[
 \boxed{
 \frac1{\ell+1}\sum_C
  \log\left|
   \psi_C(0)\psi_C(a)\psi_C(-b)
  \right|
 =\frac{\ell-1}{2}\log(abc)
  -\frac3{\ell+1}\log\ell.}
 \tag{6.5}
\]

The coefficient `(ell-1)/2` is exactly the symmetric-power/Hodge coefficient
in the active Steinberg interpolation route.

## 7. Research consequence

Equation (6.5) identifies the raw algebraic average which is invisible in the
projective packet.  The canonical/noncanonical Tate signal is not obtained by
pretending this common factor is absent; it is obtained by passing to a
projective or dual metric and recording the Hodge/Bernoulli normalization that
removes the common average.

This yields three concrete obligations for the global proof.

1. Map the projective classes of the cyclic kernel sections into the
   symmetric-power interpolation module.
2. Prove that the arithmetic metric subtracts the explicit common term in
   (6.5), with no unrecorded Jacobian.
3. Bound the remaining projective oscillation by conductor, different, and
   `O(ell log ell)`.

A comparison which preserves only divisors but not the common factor (6.5) is
insufficient.  This applies equally to the classical determinant route and to
any proposed IUT/ATS Rosetta map.

## 8. Lean plan

The formalization is separated into three layers.

1. Kernel-check the numerical exponent identities in the two parity branches
   of the induction.
2. Prove an abstract recurrence theorem for a sequence whose even terms vanish
   and whose odd terms satisfy (2.1).
3. Connect the abstract theorem to Mathlib division polynomials once the
   required generalized Weierstrass recurrence API is available.

No layer assumes `ABCConjecture` or the unresolved global metric comparison.
