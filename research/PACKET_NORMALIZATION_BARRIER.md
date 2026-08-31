# The packet-normalization barrier

## 1. Why the scalar one-sixth identity is not yet abc

The centered theta-weight calculation proves the exact numerical identity

\[
 S_\ell
 =\frac{M_\ell}{6}L,
 \qquad
 M_\ell=\frac{\ell(\ell^2-1)}2.
\tag{1.1}
\]

It is tempting to divide a frame determinant by `M_ell` and read (1.1) as the
required `L/6` term.  This is not legitimate until the same normalization is
proved for the **entire arithmetic line bundle** carrying that determinant.

This note records the precise barrier and corrects any interpretation of
(1.1) as an already completed height--conductor inequality.

## 2. Hodge weight of a square frame minor

The even theta coefficient space has dimension

\[
 d_\ell=\frac{\ell^2+1}{2}.
\tag{2.1}
\]

A square `d_ell by d_ell` frame minor formed from ordinary theta constants is a
section whose scalar modular/Hodge weight is, before additional determinant
corrections,

\[
 k_\ell=\frac{d_\ell}{2}
 =\frac{\ell^2+1}{4}.
\tag{2.2}
\]

If one formally divides both the local order and the line-bundle degree by
`M_ell`, then the Hodge weight becomes

\[
 \frac{k_\ell}{M_\ell}
 =\frac{\ell^2+1}
        {2\ell(\ell^2-1)}
 \sim\frac1{2\ell},
\tag{2.3}
\]

not the coefficient of order one required on the conductor side of abc.

Therefore the operation

\[
 S_\ell/M_\ell=L/6
\]

by itself cannot be inserted into the product formula.  The level cover,
boundary divisor, determinant-of-cohomology factors and the pure theta key
formula must supply the rest of the arithmetic degree and its poles.

## 3. Valence interpretation

A high-level modular theta determinant can have a large vanishing order at a
chosen cusp despite modest scalar weight because:

- the level cover has large degree;
- cusp widths grow with `ell`;
- the section may have poles or zeros at many other boundary components;
- integral descent introduces elementary divisors at the level prime.

The global divisor degree balances all of these contributions.  Keeping only
one cusp order and dividing by the number of transverse kernels ignores this
balance.

### No-go theorem 3.1

A proof route using only:

1. the scalar identity (1.1);
2. a square theta-frame minor of scalar Hodge weight (2.2);
3. arbitrary rescaling of its local logarithmic order by `1/M_ell`;

cannot produce a valid arithmetic inequality.  It lacks a line bundle whose
global degree carries the same normalization.

This excludes the **naive packet-division shortcut**, not the pure-theta frame
route.

## 4. Correct surviving formulation

The pure-extension key formula supplies a canonical adelic line in which the
Hodge and boundary components are tied together.  A valid proof must construct
an integral frame/Plucker section in that line and compute its complete divisor:

\[
 \operatorname{div}(\mathfrak p_\ell)
 =\text{multiplicative boundary}
  +\text{other cusps}
  +\text{level divisors}
  +\text{horizontal divisors}.
\tag{4.1}
\]

The desired conclusion follows only if one proves that, after the canonical
pure-theta and determinant corrections,

\[
 \frac1{M_\ell}
 \operatorname{ord}_{\rm mult}
  (\mathfrak p_\ell)
 =\frac16Q+O(N),
\tag{4.2}
\]

while the similarly normalized remaining negative divisor and metric terms are
bounded by

\[
 (1+o(1))(D+N)+O(\log\ell).
\tag{4.3}
\]

Thus the exact centered weight identifies the local leading term, but the
integral pure-theta divisor comparison remains indispensable.

## 5. Consequence for current research

The following results remain valid and useful:

- exact finite frame lower singular value;
- exact centered tropical exponent;
- exact finite convolution determinant;
- pure adelic theta metric;
- algebraic norm selection via a global Plucker section.

The closest unresolved theorem is now the **complete divisor and elementary-
divisor computation** of that Plucker section on the level compactification.
No archimedean equidistribution and no arbitrary metric normalization remain,
but one cannot skip the global divisor calculation.
