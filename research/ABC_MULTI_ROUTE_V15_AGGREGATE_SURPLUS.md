# ABC multi-route research note v15: signed aggregate surplus

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Why primewise positive-part excess is too strong

For `M=max(a,b)`, the previous cubeful quantity

\[
Q(Mc)=\frac{Mc}{\gcd(Mc,\operatorname{rad}(Mc)^2)}
\]

retains only positive prime-exponent mass above two.  As a global target this
can be much too large: a high prime power on one endpoint may be fully
compensated by many exponent-one primes on the other endpoint.  The
primewise positive part discards that compensation.

The first correct aggregate quantity is instead

\[
\boxed{
D_2(M,c)=
\log(Mc)-2\log\operatorname{rad}(Mc).
}
\]

Primewise,

\[
D_2(M,c)=
\sum_{p\mid Mc}(v_p(Mc)-2)\log p.
\]

Unlike `log Q`, primes of exponent one contribute negatively.

## 2. Exact height corridor

Since `M<=c`,

\[
\log(Mc)\le2\log c.
\]

Since `c<=2M`,

\[
c^2\le2Mc,
\]

and therefore

\[
2\log c-\log2\le\log(Mc).
\]

Writing

\[
h=\log c,
\qquad
r_{Mc}=\log\operatorname{rad}(Mc),
\]

we obtain

\[
\boxed{
2h-\log2-2r_{Mc}
\le D_2(M,c)
\le2h-2r_{Mc}.
}
\]

Thus the aggregate surplus is exactly the failure of the pair radical to
supply half of the pair-product height.

## 3. Transfer to the full conductor

Because `Mc` divides `abc`,

\[
r_{Mc}\le R,
\qquad
R=\log\operatorname{rad}(abc).
\]

The lower height corridor becomes the exact ledger

\[
\boxed{
2h\le
\log2+2R+D_2(M,c).
}
\]

Consequently, a bound

\[
D_2(M,c)\le2\epsilon R+K_\epsilon
\]

implies

\[
\boxed{
h\le
(1+\epsilon)R+
\frac{K_\epsilon+\log2}{2}.}
\]

Conversely, every violation

\[
h>(1+\epsilon)R+C
\]

forces

\[
\boxed{
D_2(M,c)>
2\epsilon R+2C-\log2.
}
\]

## 4. Improvement over the cubeful positive part

For each prime exponent `e`,

\[
e-2\le\max(e-2,0).
\]

Hence

\[
D_2(M,c)\le\log Q(Mc).
\]

The aggregate target is therefore never stronger than the positive-part
cubeful target and can be dramatically weaker.  This removes false
obstructions coming from a single high-power endpoint paired with an endpoint
of nearly full radical.

## 5. Remaining arithmetic problem

The pointwise problem is now:

> rule out an unbounded primitive short-gap family for which the signed
> average prime multiplicity of `M*c` stays strictly above two by a fixed
> conductor-scale amount.

Equivalently, a counterexample family must satisfy both:

1. the endpoint degeneration supplied by the coefficient-three balance
   transfer;
2. a positive conductor-scale value of `D_2(M,c)`.

The next useful decomposition is the layer-cake identity

\[
\sum_p(v_p-2)\log p
=
-\sum_{v_p=1}\log p
+
\sum_{j\ge3}\sum_{v_p\ge j}\log p,
\]

which exposes the competition between the exponent-one layer and the nested
`j`-full layers.  This is the appropriate object for combining the existing
`KFullRadicalCompression` and generalized-Fermat modules.

## 6. Lean deliverable

The corresponding kernel candidate is

```text
Lean/IUTThreeClosures/LargeEndpointAggregateSurplus.lean
```

with declarations

```lean
ABCPoint.largePairLog
ABCPoint.largePairRadicalLog
ABCPoint.largePairAggregateSurplus
ABCPoint.largePairLog_le_two_height
ABCPoint.two_height_sub_log_two_le_largePairLog
ABCPoint.largePairRadicalLog_le_conductor
ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
ABCPoint.height_le_of_aggregateSurplus_bound
ABCPoint.aggregateSurplus_large_of_height_violation
ABCPoint.aggregateSurplus_corridor
abc_of_uniformLargePairAggregateSurplusBound
```

No estimate for the aggregate surplus is assumed or hidden in a structure.
The module proves only the deterministic transfer and strict contrapositive.
