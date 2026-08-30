# ABC multi-route research note v17: exact multiplicity layers

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Exact cancellation identity

For a positive integer `n`, define

\[
Q(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)},
\qquad
L_1(n)=\frac{\operatorname{rad}(n)^2}
              {\gcd(n,\operatorname{rad}(n)^2)}.
\]

Primewise, `Q` contains exponent `max(v_p(n)-2,0)`, while `L_1` contains a
prime exactly when `v_p(n)=1`.  Therefore

\[
\boxed{
nL_1(n)=\operatorname{rad}(n)^2Q(n)
}
\]

and

\[
\boxed{
\log n-2\log\operatorname{rad}(n)
=
\log Q(n)-\log L_1(n).
}
\]

Thus a genuine abc violation requires cubeful mass to dominate the complete
exponent-one cancellation layer, not merely the existence of one prime cube.

## 2. Global obstruction

For an abc point let

\[
\Sigma_{abc}=\log(abc)-2\log\operatorname{rad}(abc).
\]

Since

\[
2\log c-\log2\le\log(abc),
\]

any violation

\[
\log c>(1+\epsilon)
\log\operatorname{rad}(abc)+C
\]

forces

\[
\boxed{
\Sigma_{abc}>
2\epsilon\log\operatorname{rad}(abc)+2C-\log2.
}
\]

Equivalently, the global cubeful quotient must dominate its exponent-one layer
by that amount.

## 3. Bounded-exponent versus high-exponent dichotomy

For a finite weighted prime-exponent profile, write

\[
\Sigma=\sum_p(v_p-2)w_p,
\]

\[
P_+=\sum_p\max(v_p-2,0)w_p,
\qquad
W_1=\sum_{v_p=1}w_p.
\]

Then exactly

\[
\boxed{\Sigma=P_+-W_1.}
\]

If every exponent is at most `B>=3`, then

\[
P_+\le(B-2)W_{\ge3},
\]

where

\[
W_{\ge3}=\sum_{v_p\ge3}w_p.
\]

Consequently, whenever

\[
\Sigma>\delta R,
\]

one has the rigorous dichotomy

\[
\boxed{
\exists p:\ v_p>B
\quad\text{or}\quad
\delta R<(B-2)W_{\ge3}.
}
\]

This splits the remaining arithmetic into two focused branches:

1. **high-exponent concentration**, to be attacked through cyclotomic/Lucas
   valuation and adaptive level-lowering methods;
2. **large cubic support with bounded exponents**, to be converted into a
   moving-coefficient cubic or mixed-signature generalized-Fermat equation.

## 4. Net-excess audit

The quantity

\[
D=\log(\max(a,b)c)-2\log\operatorname{rad}(abc)
\]

satisfies

\[
2\log c-\log2-2R\le D\le2\log c-2R.
\]

Hence a uniform estimate

\[
D\le2\epsilon R+O_\epsilon(1)
\]

is logically equivalent to the abc conjecture itself.  This prevents a
circular strategy from being disguised as a new “net excess” theorem.  The
useful stronger targets are the unsigned or signed large-endpoint estimates,
preferably restricted by the coefficient-three balance theorem to the
endpoint-degenerate locus.

## 5. Lean modules

```text
Lean/IUTThreeClosures/CubefulExponentOneLayer.lean
Lean/IUTThreeClosures/GlobalMultiplicityExcessObstruction.lean
Lean/IUTThreeClosures/SignedMultiplicityExponentLayerDichotomy.lean
Lean/IUTThreeClosures/LargeEndpointNetExcessEquivalence.lean
```

All difficult distribution, modularity, and moving-coefficient estimates
remain explicit future inputs; none is stored as an axiom.
