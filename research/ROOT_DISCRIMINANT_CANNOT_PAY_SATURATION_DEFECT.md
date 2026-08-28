# Root discriminant cannot pay the Kummer saturation defect

## 1. The proposed but false estimate

The actual-root globalization theorem gives Kummer fields with

\[
  \log\operatorname{rd}(K_p)
  \le \log p+2\log N+C_0.
\]

The local saturation theorem gives the missing multiplicity contribution

\[
  \frac2N\operatorname{length}(B/A)\log p
  =(N-1)\log p.
\]

It is tempting to hope that the second quantity can be bounded by a fixed
multiple of the first.  The following theorem disproves that hope.

## 2. No-go theorem

### Theorem 2.1

Fix a rational prime `p`.  For every constants `A>=0` and `B`, there are
arbitrarily large positive integers `N` such that

\[
 (N-1)\log p
 >A(\log p+2\log N)+B.
\]

Consequently no estimate of the form

\[
 \frac2N\operatorname{length}(B/A)\log p
 \le A\log\operatorname{rd}(K_p)+B
\]

can hold uniformly in `N` merely from the root-discriminant bound above.

### Proof

The left side is linear in `N`, while the right side is logarithmic.  More
explicitly, take `N=2^k`.  Then

\[
 (N-1)\log p=(2^k-1)\log p,
\]

whereas

\[
 A(\log p+2\log N)+B
 =A\log p+2Ak\log2+B.
\]

The exponential `2^k` eventually exceeds every affine function of `k`.

## 3. Stronger global counterexample family

Take one fixed prime `p` and local Tate parameters

\[
 q_N=p^N.
\]

The actual-root globalization may be taken in a pure Kummer field of normalized
discriminant `O(log N)`, but the exact saturation defect is

\[
 (N-1)\log p.
\]

Thus even a perfect radical-plus-entropy bound for the globalization field
does not control the quantity lost when the root is saturated.

## 4. Route consequence

This eliminates the proposed mechanism

\[
 \text{root discriminant}
 \Longrightarrow
 \text{saturation-length bound}.
\]

The broader Kummer route is retained only in forms that introduce an
additional genuinely geometric negative or averaging term, such as:

- a canonical stack degree whose stabilizer contribution cancels the local
  saturation length;
- an archimedean determinant with a proved matching negative main term;
- a nonlinear hull or maximal-slope theorem using more than the field
  discriminant;
- a comparison in which the saturation quotient enters with alternating sign
  in a determinant-of-cohomology complex.

Any future compensation theorem must exhibit this additional term explicitly;
root-discriminant control alone is quantitatively insufficient.
