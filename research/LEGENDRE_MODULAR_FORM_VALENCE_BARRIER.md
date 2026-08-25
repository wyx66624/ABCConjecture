# The one-sixth valence barrier on the Legendre base

## 1. Set-up

Let

\[
  X(2)\simeq\mathbb P^1
\]

be the compactified Legendre modular curve, with cusps labelled
`0,1,infinity`.  Let `L` be the Hodge line.  The maximal Kodaira--Spencer
isomorphism gives

\[
  \deg L=\frac12.
\]

Let `s` be a nonzero holomorphic section of `L^k`.  Write its vanishing orders
at the three cusps as

\[
  r_0,r_1,r_\infty\ge0.
\]

## 2. Valence inequality

### Theorem 2.1

\[
  r_0+r_1+r_\infty\le\frac{k}{2}.
\]

### Proof

The zero divisor of `s` is effective and has total degree

\[
  \deg L^k=\frac{k}{2}.
\]

The three cusp orders are part of this effective divisor, so their sum cannot
exceed its degree.

### Corollary 2.2 (uniform cusp barrier)

\[
  \min\{r_0,r_1,r_\infty\}\le\frac{k}{6}.
\]

Consequently no scalar modular form of Hodge weight `k` can vanish to order
strictly greater than `k/6` at all three Legendre cusps.

## 3. Equality case

Equality

\[
  r_0=r_1=r_\infty=\frac{k}{6}
\]

forces the section to have no interior zeros.  Up to a nonzero scalar, the
divisor is the corresponding rational power of the Legendre discriminant
section.  In integral weights, powers of the modular discriminant realize the
optimal ratio.

For the usual discriminant, Hodge weight `12` and cusp order `2` give

\[
  \frac{2}{12}=rac16.
\]

## 4. Arithmetic consequence

Any proof using one scalar global modular form and estimating a specialization
through its cusp vanishing orders has boundary-gain/Hodge-cost ratio at most
`1/6`.  The coefficient required by abc is therefore the geometric optimum,
not a value with spare margin.

This proves a strict no-go theorem for attempts to improve the abc coefficient
merely by replacing the discriminant with a different scalar Legendre modular
form.  A successful proof must instead establish a sharp arithmetic inequality
at the optimal `1/6` boundary, or use a genuinely nonlinear/vector-valued
construction whose slope is not governed by the scalar valence count.

The theorem does not disprove the parabolic Hodge--Arakelov route.  It explains
why the remaining arithmetic specialization estimate has no coefficient slack
and why a generic positivity or Hadamard bound cannot suffice.
