# ABC multi-route research note v44: canonical k-th-power divisors

**Author:** ChatGPT  
**Date:** 2026-08-31

For a positive integer

\[
n=\prod_p p^{e_p}
\]

and an integer \(k>0\), define

\[
q_k(n)=\prod_p p^{\lfloor e_p/k\rfloor}.
\]

Primewise,

\[
k\left\lfloor\frac{e_p}{k}\right\rfloor\le e_p,
\]

so

\[
\boxed{q_k(n)^k\mid n.}
\]

For every positive exponent,

\[
e_p\le(k-1)+k\left\lfloor\frac{e_p}{k}\right\rfloor.
\]

Therefore

\[
\boxed{
n\mid
\operatorname{rad}(n)^{k-1}q_k(n)^k.
}
\]

Taking logarithms yields

\[
\boxed{
\log n-(k-1)\log\operatorname{rad}(n)
\le k\log q_k(n).
}
\]

At \(k=4\),

\[
\boxed{
\log n
\le
3\log\operatorname{rad}(n)+4\log q_4(n).
}
\]

This supplies actual integer fourth roots for the aggregate quartic reduction;
no finite-profile square-root witness remains abstract.

Lean module:

```text
Lean/IUTThreeClosures/CanonicalKthPowerDivisor.lean
```

Core declarations:

```lean
kthRootFactorization
canonicalKthRoot
factorization_canonicalKthRoot
canonicalKthRoot_pow_dvd
self_dvd_radical_pow_mul_canonicalKthRoot_pow
log_sub_abcRadical_layers_le_k_mul_log_canonicalKthRoot
log_le_three_log_abcRadical_add_four_log_canonicalFourthRoot
```

The construction is derived entirely from `Nat.factorization`.
