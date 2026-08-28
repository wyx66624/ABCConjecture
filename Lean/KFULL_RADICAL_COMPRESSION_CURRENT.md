# K-full radical compression and neighbour thresholds

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status determined by branch CI.

## The theorem

A nonzero integer `n` is `k`-full when every prime divisor occurs with
multiplicity at least `k`. Writing

\[
n=\prod_{p\mid n}p^{e_p},\qquad e_p\ge k,
\]

one has

\[
\operatorname{rad}(n)^k
 =\prod_{p\mid n}p^k\mid n.
\]

Consequently

\[
\operatorname{rad}(n)^k\le n,
\qquad
\log\operatorname{rad}(n)\le\frac{1}{k}\log n
\]

for `k>0`.

The Lean proof derives the divisibility from ordinary prime factorizations and
squarefreeness of the radical. No radical estimate is supplied as an axiom.

## Two-endpoint consequence

If neighbouring coprime integers `b<c` are respectively `r`-full and
`s`-full, then

\[
\log\operatorname{rad}(b)+\log\operatorname{rad}(c)
\le \frac{\log b}{r}+\frac{\log c}{s}.
\]

For `a=c-b` and endpoints of common scale `X`, a gap

\[
a\le X^{\theta+o(1)}
\]

therefore gives the deterministic abc budget

\[
\log\operatorname{rad}(abc)
\le
\left(\theta+\frac1r+\frac1s+o(1)\right)\log X.
\]

Thus an unbounded primitive family would rigorously disprove abc whenever

\[
\boxed{\theta+\frac1r+\frac1s<1.}
\]

## Sharp route diagnostics

- squarefull--squarefull endpoints already spend exponent `1`; fullness alone
  leaves no positive gap margin;
- squarefull--cubefull endpoints spend `5/6`, so a gap exponent below `1/6`
  is required;
- cubefull--cubefull endpoints spend `2/3`, so a gap exponent below `1/3`
  is required.

These are deterministic route-selection theorems. The module does not assert
that the required close coprime k-full neighbours exist. That distributional
Diophantine statement remains the decisive open input.

## Verification boundary

This current-main port exists because the older draft PR failed on an unrelated
stale-base module. The dedicated workflow first builds the present repository,
then directly elaborates this theorem module and its `#print axioms` audit.
