# Current global abc exceptional bounds versus fixed prime-power centres

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** unconditional exponent comparison; no external theorem is imported into Lean

The current merged version of Bernert–Browning–Lichtman–Teräväinen, *Bounds on the exceptional set in the abc conjecture*, arXiv:2410.12234v2, proves for every fixed `lambda<1` and every `delta>0`

`N_lambda(X) << X^(3/5+delta)`.

Here `N_lambda(X)` counts primitive triples `a+b=c`, `c<=X`, with

`rad(abc) < c^lambda`.

For a fixed exponent `k>=2`, the prime-power centres

`C_k(X)={p^k in [X,2X]}`

have cardinality

`#C_k(X) = X^(1/k-o(1))`.

Since

`1/k <= 1/2 < 3/5`,

the global exceptional upper bound is larger, at power scale, than the complete fixed-`k` centre family. It is therefore compatible with every such centre being exceptional. This does **not** assert that prime powers are exceptional; it proves only that direct cardinality specialization is unavailable.

Equivalently, the global theorem supplies a power saving `2/5-delta`, whereas direct transfer to `p^k` requires a saving strictly larger than

`1-1/k >= 1/2`.

For the square-root low-radical construction, the separate density barrier forces `k>=5`, so the required saving increases to strictly more than `4/5`.

The Lean file `IUTThreeClosures/CurrentExceptionalSetPrimePowerNoGo.lean` kernel-formalizes the rational inequalities

`1/k <= 1/2 < 3/5`

and

`2/5 < 1-1/k`

for every `k>=2`. It does not assume the exceptional-set theorem, the prime number theorem, or the abc conjecture.

This comparison reinforces the corrected target: average directly over prime-power centres, prove a relative exceptional estimate inside that sparse family, or construct a source-dependent fibre whose good-point count exceeds its relative exceptional count.
