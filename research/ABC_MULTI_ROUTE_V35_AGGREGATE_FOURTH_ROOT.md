# ABC multi-route research note v35: aggregate fourth-root amplification

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Improvement over the endpointwise selector

The v34 endpointwise argument first selects an endpoint whose radical weight is
at most one third of the full conductor and then applies the canonical
`k`-th-root ledger.  Its exact gain is

\[
8+3\varepsilon-2k.
\]

A stronger method sums the three root ledgers before selecting the largest
root.  This uses the full endpoint height sum and pays the conductor only once.
In the non-short-gap branch it improves the exact gain to

\[
\boxed{8+5\varepsilon-2k.}
\]

No new Diophantine assumption is involved.

## 2. Aggregate endpoint height

For a positive primitive abc point write

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad h=\log c.
\]

In the non-short-gap branch,

\[
\log m\ge
\frac{2+\varepsilon}{2(1+\varepsilon)}h,
\]

while

\[
\log M\ge h-\log2,
\qquad
\log c=h.
\]

Therefore

\[
\begin{aligned}
\log m+\log M+\log c
&\ge
\left(2+\frac{2+\varepsilon}{2(1+\varepsilon)}\right)h
-\log2\\
&=
\frac{6+5\varepsilon}{2(1+\varepsilon)}h-
\log2.
\end{aligned}
\]

Equivalently,

\[
\boxed{
(6+5\varepsilon)h-2(1+\varepsilon)\log2
\le
2(1+\varepsilon)(T_m+T_M+T_c),
}
\]

where `T_n=log n`.

## 3. Summed canonical root ledger

For the canonical `k`-th root of each endpoint, let its logarithmic weight be
`Q_{k,n}` and let the endpoint radical logs be `r_n`.  The finite-profile
ledger gives

\[
T_n\le(k-1)r_n+kQ_{k,n}.
\]

Summing over all three endpoints and using pairwise coprimality,

\[
\boxed{
T_m+T_M+T_c
\le
(k-1)R+k(Q_{k,m}+Q_{k,M}+Q_{k,c}),
}
\]

where

\[
R=\log\operatorname{rad}(abc).
\]

Assume a violation

\[
h>(1+\varepsilon)R+C.
\]

Combining the last three displays yields

\[
\boxed{
(8+5\varepsilon-2k)h+2(k-1)C
<
2k(1+\varepsilon)
(Q_{k,m}+Q_{k,M}+Q_{k,c})
+2(1+\varepsilon)\log2.
}
\]

At least one of the three root weights is at least one third of their sum.
Consequently one endpoint satisfies

\[
\boxed{
(8+5\varepsilon-2k)h+2(k-1)C
<
6k(1+\varepsilon)Q_{k,n}
+2(1+\varepsilon)\log2.
}
\]

## 4. Improved quartic lower bound

For `k=4`, the gain becomes `5 epsilon`.  Hence at least one endpoint satisfies

\[
\boxed{
5\varepsilon h+6C
<
24(1+\varepsilon)Q_{4,n}
+2(1+\varepsilon)\log2.
}
\]

Equivalently,

\[
\boxed{
Q_{4,n}
>
\frac{5\varepsilon h+6C}{24(1+\varepsilon)}
-
\frac{\log2}{12}.
}
\]

The coefficient of `h` improves from

\[
\frac{3\varepsilon}{24(1+\varepsilon)}
\]

to

\[
\frac{5\varepsilon}{24(1+\varepsilon)}.
\]

## 5. Sharpness of the exponent obtained by this mechanism

At exponent five, the aggregate gain is

\[
8+5\varepsilon-10=5\varepsilon-2.
\]

For

\[
0<\varepsilon\le\frac25,
\]

this is nonpositive.  Thus even after optimal aggregate accounting, the
canonical fourth root remains the maximal exponent forced uniformly for every
small positive epsilon by the three-endpoint residue budget alone.

Obtaining a uniform fifth root would require additional arithmetic input such
as correlated residue classes, repeated support across moduli, or a descent on
the moving conic; it cannot result from another rearrangement of the same
height and radical inequalities.

## 6. Lean implementation

The strengthened result is formalized in

```text
Lean/IUTThreeClosures/AggregateThreeEndpointKthRootThreshold.lean
```

with declarations

```lean
sum_le_triple_one
one_endpoint_has_kthRootScale_from_aggregate
one_endpoint_has_fourthRootScale_from_aggregate
aggregate_quartic_gain_pos_and_quintic_gain_nonpos
```

The proof uses the three actual finite exponent-profile root weights.  It does
not introduce an abc conclusion, a Mordell height theorem, a generalized
Fermat finiteness theorem, `axiom`, `sorry`, or `admit`.

## 7. Remaining arithmetic frontier

In the non-short-gap branch, every hypothetical counterexample now has all of
the following simultaneously:

1. a conductor-supported primitive squarefree moving conic;
2. cyclic quadratic residue conditions on the three term supports;
3. height-scale square roots on all three endpoints;
4. a height-scale cube root on one large endpoint;
5. a height-scale fourth root on at least one endpoint, with the improved
   coefficient above.

A successful closure must exploit correlations among these structures.  The
individual existence of large square, cube, or fourth-power divisors is not by
itself sufficient, because moving-coefficient low-signature equations can have
infinite algebraic families with large residual radical.
