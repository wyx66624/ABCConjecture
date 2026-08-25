# The eta-quotient packet of cyclic `ell`-lines

## 1. Jacobi multiplication formula

Let `tau` lie in the upper half-plane and put

\[
  q=e^{2\pi i\tau}.
\]

Use the product conventions

\[
 \vartheta_1(z,\tau)
 =2q^{1/8}\sin(\pi z)
  \prod_{n\ge1}(1-q^n)
  (1-q^ne^{2\pi iz})(1-q^ne^{-2\pi iz}),
\]

\[
 \eta(\tau)=q^{1/24}\prod_{n\ge1}(1-q^n).
\]

### Theorem 1.1

For every integer `ell>=2`,

\[
 \prod_{j=1}^{\ell-1}
   \vartheta_1(j/\ell,\tau)
 =\ell\,\eta(\tau)^{\ell-3}\eta(\ell\tau)^2.
 \tag{1}
\]

### Proof

First,

\[
 \prod_{j=1}^{\ell-1}2\sin(\pi j/\ell)=\ell.
\]

For every `x`,

\[
 \prod_{j=1}^{\ell-1}(1-xe^{2\pi ij/\ell})
 =\frac{1-x^\ell}{1-x}.
\]

Apply this twice with `x=q^n`.  The product of all non-sine factors is

\[
 q^{(\ell-1)/8}
 \prod_{n\ge1}(1-q^n)^{\ell-3}
 \prod_{n\ge1}(1-q^{\ell n})^2.
\]

The q-exponent in
`eta(tau)^(ell-3) eta(ell tau)^2` is

\[
 \frac{\ell-3}{24}+\frac{2\ell}{24}
 =\frac{\ell-1}{8},
\]

which proves (1).

### Corollary 1.2

After dividing by the natural Hodge normalization
`eta(tau)^(ell-1)`, the canonical cyclic-line coordinate is the eta quotient

\[
 u_\infty(\tau)
 =\ell\left(\frac{\eta(\ell\tau)}{\eta(\tau)}\right)^2.
 \tag{2}
\]

Its q-order at infinity is `(ell-1)/12`, the canonical Tate-line coefficient.

## 2. Product of the noncanonical quotients

Assume now that `ell` is prime.  For `0<=k<ell`, put

\[
 \tau_k=\frac{\tau+k}{\ell}.
\]

### Theorem 2.1

There is a root of unity `zeta_ell` such that

\[
 \prod_{k=0}^{\ell-1}\eta(\tau_k)
 =\zeta_\ell\,
  \frac{\eta(\tau)^{\ell+1}}{\eta(\ell\tau)}.
 \tag{3}
\]

### Proof

Multiplying the leading eta factors gives `q^(1/24)` times a root of unity.
For a fixed positive integer `n`, multiplication over `k` gives

\[
 \prod_{k=0}^{\ell-1}
 (1-q^{n/\ell}e^{2\pi i nk/\ell})
 =
 \begin{cases}
   1-q^n,&\ell\nmid n,\\
   (1-q^{n/\ell})^\ell,&\ell\mid n.
 \end{cases}
\]

Therefore the total infinite product is

\[
 \frac{\prod_{n\ge1}(1-q^n)^{\ell+1}}
      {\prod_{n\ge1}(1-q^{\ell n})}.
\]

Converting back to eta functions cancels the remaining q-powers and proves
(3).

## 3. The complete cyclic-line packet

Define

\[
 u_\infty(\tau)
 =\ell\frac{\eta(\ell\tau)^2}{\eta(\tau)^2},
\]

and, for `0<=k<ell`,

\[
 u_k(\tau)
 =\ell^{-1}
  \frac{\eta((\tau+k)/\ell)^2}{\eta(\tau)^2}.
 \tag{4}
\]

These are the analytic representatives of the `ell+1` cyclic-line modular
units, with the differential scaling of the corresponding isogenies included.

### Theorem 3.1 (complete packet product)

\[
 u_\infty(\tau)
 \prod_{k=0}^{\ell-1}u_k(\tau)
 =\zeta_\ell^2\,\ell^{1-\ell}.
 \tag{5}
\]

In particular,

\[
 |u_\infty(\tau)|
 \prod_{k=0}^{\ell-1}|u_k(\tau)|
 =\ell^{1-\ell}.
\]

### Proof

Insert (3) into (4).  The eta factors cancel, leaving the displayed power of
`ell` and the root of unity.

This exact constant-product identity is the analytic/modular-unit form of the
linear Galois-average cancellation theorem.

## 4. Cusp slopes and oscillation

Let

\[
  L=2\pi\,\operatorname{Im}\tau=-\log|q|.
\]

As `Im tau -> infinity`, the eta product gives

\[
 -\log|u_\infty(\tau)|
 =\frac{\ell-1}{12}L-\log\ell+o(1),
 \tag{6}
\]

while, uniformly in `k`,

\[
 -\log|u_k(\tau)|
 =-\frac{\ell-1}{12\ell}L+\log\ell+o(1).
 \tag{7}
\]

Hence the projective oscillation of the inverse packet is

\[
 \operatorname{osc}
   ([u_C(\tau)^{-1}]_C)
 =\frac{(\ell-1)(\ell+1)}{12\ell}L
  -2\log\ell+o(1).
 \tag{8}
\]

At a nonarchimedean split multiplicative place away from `ell`, the constant
`ell` is a unit and the corresponding valuation formula has no logarithmic
constant; the oscillation is exactly the coefficient in (8) times the Tate
order.

## 5. Research consequence

The eta-quotient packet supplies the algebraic/modular coordinates required by
the nonlinear torsion tropical-norm route.  It simultaneously explains:

- why every symmetric linear average cancels;
- why the projective oscillation survives;
- why only an `O(log ell)` normalization error appears at the level prime and
  archimedean places.

The unresolved global theorem is not the existence of the packet.  It is a
sharp height estimate for the projective packet, or for its modular-unit ratios,
in terms of truncated conductor rather than ordinary specialization height.
