# ABC multi-route research note v24: the single-Wronskian normalized-mass no-go

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Setting

For a positive primitive triple

\[
a+b=c,
\]

write

\[
A=\operatorname{rad}(a),\qquad
B=\operatorname{rad}(b),\qquad
C=\operatorname{rad}(c),
\]

and

\[
a=Aq_a,\qquad b=Bq_b,\qquad c=Cq_c.
\]

Pairwise coprimality implies

\[
\operatorname{rad}(abc)=ABC
\]

and the three powerful quotients `q_a,q_b,q_c` are pairwise coprime.

Suppose integers `D_a,D_b,D_c` satisfy

\[
D_a+D_b=D_c,
\]

\[
q_a\mid D_a,\qquad q_b\mid D_b,\qquad q_c\mid D_c.
\]

Define

\[
L_a=\frac{D_a}{a},
\qquad
L_b=\frac{D_b}{b},
\]

and the Wronskian

\[
W=aD_b-bD_a=ab(L_b-L_a).
\]

The established powerful-part divisibility argument gives

\[
q_aq_bq_c\mid W.
\]

## 2. Exact quantization of the normalized gap

If `W` is nonzero, write

\[
W=kq_aq_bq_c
\]

for a nonzero integer `k`.  Since

\[
ab=ABq_aq_b,
\]

we obtain

\[
AB(L_b-L_a)=kq_c.
\]

Taking absolute values gives

\[
\boxed{
AB|L_b-L_a|=|k|q_c.
}
\]

Since `|k|>=1`,

\[
|L_b-L_a|\ge\frac{q_c}{AB}.
\]

The triangle inequality therefore yields

\[
\boxed{
|L_a|+|L_b|
\ge
\frac{q_c}{AB}.
}
\]

But

\[
\frac{q_c}{AB}
=
\frac{Cq_c}{ABC}
=
\frac{c}{\operatorname{rad}(abc)}.
\]

Consequently every nondegenerate admissible single derivation satisfies

\[
\boxed{
|L_a|+|L_b|
\ge
\frac{c}{\operatorname{rad}(abc)}.
}
\]

## 3. Why the standard Wronskian upper bound is tautologically saturated

The usual triangle-inequality step is

\[
|W|
\le
ab(|L_a|+|L_b|).
\]

Together with `q_aq_bq_c | W`, it gives

\[
c
\le
\operatorname{rad}(abc)(|L_a|+|L_b|).
\]

The new lower bound shows that the parenthesized mass is automatically at
least `c/rad(abc)`.  Hence the right-hand side is automatically at least `c`.
The method cannot produce a strict height improvement merely by finding a
“smaller” nondegenerate compatible derivation: such a derivation does not
exist below the exact quantized floor.

This is stronger than the previous observation that generic Siegel lemma may
return a degenerate short vector.  It proves that even an ideal
nondegeneracy-aware selector cannot beat the required normalized mass within
the single-Wronskian/triangle-inequality architecture.

## 4. What remains possible

The no-go does not exclude arithmetic-differential methods altogether.  A
successful route must add a mechanism absent from the scalar chain, for
example:

1. two or more compatible derivations whose Wronskians have additional gcd or
   resultant control;
2. a signed cancellation estimate stronger than the triangle inequality;
3. divisibility of the Wronskian by more than the three powerful quotients;
4. an independent archimedean or adelic estimate coupling several
   derivations.

Without one of these genuinely new inputs, further optimization of a single
kernel vector cannot close ABC.

## 5. Lean formalization

The scalar core is formalized in

```text
Lean/IUTThreeClosures/WronskianNormalizedMassNoGo.lean
```

The module proves

```lean
normalized_mass_lower_bound_of_quantized_gap
not_mass_lt_quantized_floor
normalized_mass_floor_is_sharp
```

and introduces no `axiom`, `sorry`, or `admit`.
