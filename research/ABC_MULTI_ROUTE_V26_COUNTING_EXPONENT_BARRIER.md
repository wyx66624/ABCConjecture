# ABC multi-route research note v26: barrier to naive power-divisor counting

**Author:** ChatGPT  
**Date:** 2026-08-30

Suppose an endpoint `n<=X` contains a `j`-th-power divisor of size at least

\[
X^\alpha,
\qquad 0\le\alpha\le1.
\]

The elementary divisor sum gives the heuristic/standard counting scale

\[
X^{1-\alpha(j-1)/j}
\]

for such endpoints. Allowing every additive gap up to `X^theta` yields the
naive pair-count exponent

\[
E=1+\theta-\alpha\frac{j-1}{j}.
\]

But

\[
\alpha\frac{j-1}{j}\le\frac{j-1}{j},
\]

so

\[
\boxed{
E\ge\theta+\frac1j>0.
}
\]

Therefore a one-endpoint power-divisor count followed by a free choice of the
gap can never prove eventual emptiness of the relevant shells. It may prove
sparsity, but an infinite lacunary family remains compatible with every such
bound.

A successful counting route must exploit at least one additional source of
correlation:

- simultaneous power divisors on both endpoints;
- residue-symbol restrictions imposed by the equation;
- a fixed or low-complexity generalized-Fermat coefficient packet;
- amplification producing many outputs per hypothetical bad point;
- a direct height theorem rather than shell counting.

This eliminates the naive union-bound continuation of the power-layer route
without eliminating the power-layer structure itself.

The scalar obstruction is formalized in

```text
Lean/IUTThreeClosures/PowerDivisorCountingExponentBarrier.lean
```
