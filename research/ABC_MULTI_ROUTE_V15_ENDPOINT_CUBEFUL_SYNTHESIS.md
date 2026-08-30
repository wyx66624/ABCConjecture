# ABC multi-route research note v15: endpoint/cubeful synthesis

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Joint obstruction

Let

\[
h=\log c,\qquad R=\log\operatorname{rad}(abc),
\qquad S=\log(abc),
\]

and let

\[
Q=\frac{\max(a,b)c}
{\gcd(\max(a,b)c,\operatorname{rad}(\max(a,b)c)^2)}.
\]

Assume, for `0<epsilon<=1`, the pointwise coefficient-three estimate

\[
S\le 3R+\frac{\epsilon}{2}h+K.
\]

If the corresponding balanced conclusion fails,

\[
h>
(1+\epsilon)R+
\frac{K+\log2}{3-\epsilon},
\]

then two conclusions hold simultaneously:

\[
\boxed{
\log\min(a,b)<
\left(1-\frac{\epsilon}{2}\right)h
}
\]

and

\[
\boxed{
\log Q>
2\epsilon R+
2\frac{K+\log2}{3-\epsilon}-\log2.
}
\]

Thus a remaining violation is not merely unbalanced and not merely cubeful: it
must possess both properties with compatible quantitative constants.

## 2. Endpoint-only closure theorem

Define the endpoint-local target:

for every `epsilon>0`, there are `H,K` such that every abc point satisfying

\[
h\ge H,\qquad
\log\min(a,b)<
\left(1-\frac{\epsilon}{2}\right)h
\]

also satisfies

\[
\log Q\le 2\epsilon R+K.
\]

The Lean synthesis proves:

> a uniform coefficient-three symmetric-product estimate with arbitrarily
> small relative height error, together with this endpoint-local cubeful-excess
> estimate, implies the full logarithmic abc conjecture.

Low-height points are absorbed by an explicit maximum of the height threshold
and the two high-height constants; no finiteness theorem is smuggled into the
quantifier argument.

## 3. Significance

The missing arithmetic estimate no longer has to hold on every abc point.
Balanced points are handled entirely by coefficient-three transfer.  The
cubeful theorem is required only for power-saving short gaps and only for the
exponent mass above level two.

The remaining research problem is therefore:

\[
\boxed{
\text{control conductor-scale cubeful mass in coprime power-saving short-gap pairs.}
}
\]

## 4. Lean deliverable

```text
Lean/IUTThreeClosures/EndpointCubefulSynthesis.lean
```

The module contains no hidden product theorem and no hidden endpoint theorem;
both are explicit hypotheses in the final closure theorem.
