# Exceptional-set amplification threshold for the abc conjecture

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** unconditional scalar reduction; no claim of an abc proof

## 1. Purpose

Let

\[
E_\lambda(X)=\#\{(a,b,c):a+b=c,\ \gcd(a,b,c)=1,\ c\le X,
\ \operatorname{rad}(abc)<c^\lambda\}.
\]

The best exponent currently represented in this audit is

\[
E_\lambda(X)\ll_{\lambda,\varepsilon}X^{56/85+\varepsilon}
\]

in the relevant parameter range.  Such an upper bound does **not** imply that
the exceptional set is finite: a lacunary infinite sequence can have a much
smaller counting function.  To deduce finiteness from a power-saving envelope,
one needs a propagation or amplification theorem for every putative bad
triple.

This note isolates the exact exponent demanded of such an amplification.

## 2. Abstract amplification lemma

Assume that a bad source object of height comparable to `H` produces at least

\[
H^\gamma
\]

pairwise distinct bad output objects, all of target height at most

\[
H^d.
\]

Suppose also that the target exceptional set satisfies

\[
E(X)\le C X^\beta.
\]

Then

\[
H^\gamma\le E(H^d)\le C H^{d\beta}.
\]

Along an unbounded sequence of source heights this is impossible whenever

\[
\boxed{\gamma>d\beta}.
\]

Equivalently, every viable amplification route must either:

1. decrease the height-dilation exponent `d`;
2. increase the number of provably distinct descendants `gamma`; or
3. improve the global exceptional-set exponent `beta`.

The Lean theorem

```lean
no_unbounded_log_amplification_above_envelope
```

formalizes this argument after taking logarithms.  It has no analytic-number-
theory axiom and no abc hypothesis.

## 3. Numerical consequences of the current exponent

Set

\[
\beta_{\mathrm{BLT}}=\frac{33}{50},\qquad
\beta_{\mathrm{Li}}=\frac{56}{85}.
\]

The exact numerical improvement is

\[
\frac{33}{50}-\frac{56}{85}=\frac1{850}.
\]

However,

\[
\frac{56}{85}-\frac12=\frac{27}{170}>0.
\]

Thus an amplification whose available family has only `H^{1/2+o(1)}` degrees
of freedom cannot meet the present global threshold even before collision and
coprimality losses are charged.

For quadratic target-height dilation, one needs

\[
\gamma>2\cdot\frac{56}{85}=\frac{112}{85}>1;
\]

for quartic dilation, one needs

\[
\gamma>4\cdot\frac{56}{85}=\frac{224}{85}>2.
\]

These thresholds explain why the fixed-Pythagorean and moving-parameter
variants audited elsewhere in the repository cannot close merely from their
ambient parameter counts.

## 4. What remains a genuine research target

A successful descendant construction must prove all of the following, not
merely a formal parameterization:

- every descendant remains exceptional for one fixed quality exponent;
- the target height is bounded uniformly by `H^d`;
- at least `H^{gamma-o(1)}` descendants are pairwise distinct after all
  symmetries and common factors are removed;
- `gamma>d beta` for the applicable exceptional-set theorem;
- every quantifier is uniform in the source triple.

The most promising way to improve the ledger is therefore not another
one-parameter Pythagorean map, but a genuinely multi-parameter arithmetic
correspondence with bounded fibres and subquadratic height growth.

## 5. References

- J. D. Lichtman, *The abc conjecture is true almost always*, arXiv:2505.13991.
- T. D. Browning, J. D. Lichtman, J. Teräväinen, work giving the exponent
  `33/50` for the exceptional set.
- R. Li, *On the exceptional set in the abc conjecture*, arXiv:2507.02885,
  giving the exponent `56/85` used in this threshold audit.

The cited analytic estimates are **not** imported as Lean theorems here.  The
Lean module formalizes only the implication from a supplied logarithmic upper
envelope and a supplied logarithmic amplification lower bound.
