# General power cores and the square--cube horizon

For

\[
 n=\prod_pp^{e_p}
\]

and an integer `k>=2`, define

\[
 U_k(n)=\prod_pp^{\lfloor e_p/k\rfloor}.
\]

Then `U_k(n)^k` is the largest canonical `k`-th-power divisor obtained by
rounding every prime exponent down to a multiple of `k`.

## Theorem 1 (general power-core bound)

For every `k>=2`,

\[
 U_k(n)^k\geq \frac{n}{\operatorname{rad}(n)^{k-1}}.
\]

### Proof

For every integer exponent `e>=1`,

\[
 k\lfloor e/k\rfloor\ge e-(k-1).
\]

Multiplying the corresponding prime-power inequalities proves the result.

## Theorem 2 (power core forced by an abc violation)

Let `a,b,c` be positive pairwise coprime integers with `a+b=c`, and put

\[
 R=\operatorname{rad}(abc),\qquad U_k=U_k(abc).
\]

If

\[
 c>R^{1+\epsilon},
\]

then

\[
 U_k^k
 >c^{\sigma_k(\epsilon)}\left(1-\frac1c\right),
 \qquad
 \sigma_k(\epsilon)=
 2-\frac{k-1}{1+\epsilon}
 =\frac{3+2\epsilon-k}{1+\epsilon}.
\]

### Proof

Since `ab>=c-1`,

\[
 abc\ge c(c-1).
\]

Theorem 1 gives

\[
 U_k^k\ge\frac{abc}{R^{k-1}}
 \ge\frac{c(c-1)}{R^{k-1}}.
\]

The assumed violation implies

\[
 R^{k-1}<c^{(k-1)/(1+\epsilon)}.
\]

Substitution gives the formula.

## Corollary 3 (one term has a large power core)

Pairwise coprimality implies

\[
 U_k(abc)=U_k(a)U_k(b)U_k(c).
\]

Hence one of the three terms satisfies

\[
 U_k(n)^k
 >c^{\sigma_k(\epsilon)/3}
   \left(1-\frac1c\right)^{1/3}
\]

whenever `sigma_k(epsilon)>0`.

## Theorem 4 (square--cube horizon)

The elementary radical argument supplies a polynomially growing `k`-th-power
core exactly in the range

\[
 k<3+2\epsilon.
\]

In particular, for every

\[
 0<\epsilon\le\frac12,
\]

only `k=2` and `k=3` have a positive exponent.  For every `k>=4` and every

\[
 0<\epsilon\le\frac{k-3}{2},
\]

Theorem 2 has nonpositive exponent and gives no polynomial lower bound for
`U_k`.

## Consequence

Because the abc conjecture must be proved for arbitrarily small positive
`epsilon`, the pure multiplicity-extraction method has two genuinely useful
fixed-power outputs:

1. a square-core/conic reduction;
2. a cube-core/genus-one reduction.

Higher fixed-power cores require additional arithmetic information not present
in the sole inequality `c>rad(abc)^(1+epsilon)`.  This is a no-go theorem only
for the unenhanced power-core argument; it does not exclude higher powers
arising from a separate modular, Galois, or combinatorial theorem.
