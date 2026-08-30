# ABC multi-route research note v21: an explicit no-go for bare power-part gaps

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Identity

For every integer `X>=2`,

\[
\boxed{
1+X(X-2)=(X-1)^2.
}
\]

Substituting

\[
X=x^k
\]

gives

\[
\boxed{
1+x^k(x^k-2)=(x^k-1)^2.
}
\]

For `x^k>=3`, this is a positive primitive abc triple because it is an
adjacent triple of the form `1+b=b+1`.

## 2. Structural consequence

The lower large endpoint

\[
b=x^k(x^k-2)
\]

is divisible by the arbitrarily high perfect power `x^k`, while the upper
endpoint

\[
c=(x^k-1)^2
\]

is an exact square.

Thus the following proposed gap statement is false:

> two coprime nearby integers cannot simultaneously contain a large
> `k`-th-power divisor and a large square divisor.

The identity supplies an infinite algebraic counterfamily for every exponent
`k`.

## 3. Why it is not an abc counterexample

The residual factor

\[
x^k-2
\]

and the square root

\[
x^k-1
\]

typically contribute substantial new radical.  The family therefore shows
that **power-part size alone is insufficient**; it does not show that the abc
conjecture fails.

A viable endpoint theorem must simultaneously control:

1. the extracted power roots;
2. the squarefree or low-exponent residue coefficients;
3. the additive relation between those residues.

This validates the v17--v20 focus on multiplicity excess together with the
full radical budget, rather than on large square or cube divisors by
themselves.

## 4. Lean deliverable

```text
Lean/IUTThreeClosures/PowerSquareAdjacentIdentityNoGo.lean
```

The module formalizes the identity, the primitive adjacent triple, the
prescribed perfect-power divisor, and the exact-square upper endpoint.  It
contains no abc counterexample claim.
