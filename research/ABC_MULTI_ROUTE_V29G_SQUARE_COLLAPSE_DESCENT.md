# ABC multi-route research note v29g: descent closes the square-collapse boundary

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. The zero-contact branch

The right scaled contact is

\[
Rg=B-mSy^2.
\]

If `g=0`, then

\[
B=mSy^2.
\]

For canonical primitive data, `B` is squarefree and coprime to `m`, while
every prime of `S` already lies in `B`.  Therefore:

\[
\boxed{m=1,\qquad |y|=1,\qquad B=S,}
\]

and the original endpoint is

\[
\boxed{c=S^2.}
\]

Thus the zero-contact branch is precisely

\[
1+(S^2-1)=S^2
\]

with `S` squarefree.

## 2. Smaller neighboring triples

Factor

\[
S^2-1=(S-1)(S+1).
\]

If `S` is odd, set

\[
u=\frac{S-1}{2},\qquad v=\frac{S+1}{2}.
\]

Then

\[
u+1=v,
\]

and the radical of `uv` is the radical of `S^2-1` up to no growing factor.
The new height is `log v = log S + O(1)` but the new endpoint `v` is strictly
smaller than `S^2`.

If `S` is even, use

\[
(S-1)+2=S+1.
\]

This is primitive, strictly smaller than `S^2`, and its radical is

\[
2\operatorname{rad}(S^2-1).
\]

Only the fixed factor two is lost.

## 3. Minimal-counterexample transfer

Fix `epsilon>0` and a candidate constant `C`.  Suppose `S^2` were the least
height violating

\[
\log c\le(1+\varepsilon)
\log\operatorname{rad}(abc)+C.
\]

The smaller neighboring triple then satisfies the same inequality.

Write

\[
L=\log S,\qquad R_M=\log\operatorname{rad}(S^2-1).
\]

The smaller triple supplies an estimate of the form

\[
L-\kappa\le(1+\varepsilon)R_M+C,
\]

where `kappa` is a fixed `O(log 2)` loss.  Once

\[
\kappa\le\varepsilon L,
\]

we obtain

\[
2L\le(1+\varepsilon)(L+R_M)+C.
\]

Since `S` is squarefree,

\[
L+R_M=
\log\operatorname{rad}\bigl(S(S^2-1)\bigr),
\]

which is exactly the radical of the original square-collapse triple.
Therefore every sufficiently large zero-contact candidate is ruled out by
strict descent.  The finitely many smaller `S` are absorbed into the constant.

## 4. Consequence

Combining v29f and this descent leaves only the strict negative-contact branch

\[
\boxed{g<0.}
\]

Writing `H=-g>0`, its exact equation is

\[
\boxed{B+RH=mSy^2,}
\]

with

\[
\operatorname{rad}(S)\mid H.
\]

Thus neither the positive branch nor the square-collapse boundary can support
a minimal unbounded abc counterexample.  The remaining core is a primitive,
square-bearing negative-contact equation coupled to

\[
Rx+Sy=1.
\]

## 5. Lean ledger

The logarithmic descent transfer is formalized in

```text
Lean/IUTThreeClosures/SquareCollapseDescentLedger.lean
```

through

```lean
square_endpoint_bound_of_smaller_neighbor
square_endpoint_bound_of_smaller_neighbor_with_fixed_factor
```

The arithmetic parity/factorization split remains to be connected to the
canonical-data structure after the v28 base module is merged.
