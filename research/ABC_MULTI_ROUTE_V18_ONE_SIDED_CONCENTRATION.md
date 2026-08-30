# ABC multi-route research note v18: one-sided endpoint concentration

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Additive signed excess

For a positive integer `x`, define

\[
\sigma_2(x)=\log x-2\log\operatorname{rad}(x).
\]

If `x` and `y` are coprime, radical multiplicativity gives

\[
\boxed{\sigma_2(xy)=\sigma_2(x)+\sigma_2(y).}
\]

For a primitive abc point, put

\[
m=\min(a,b),\qquad M=\max(a,b).
\]

The three integers `m`, `M`, and `c` are pairwise coprime, so the signed
large-product excess decomposes exactly as

\[
\boxed{
\Sigma(P)=
\sigma_2(M)+\sigma_2(c)-2\log\operatorname{rad}(m).
}
\]

## 2. Quantitative one-sided concentration

The exact large-endpoint corridor proved in v15 is

\[
2h-2R\le\Sigma(P)+\log2,
\]

where

\[
h=\log c,\qquad R=\log\operatorname{rad}(abc).
\]

Suppose

\[
h>(1+\varepsilon)R+C.
\]

Then

\[
\sigma_2(M)+\sigma_2(c)
>
2\log\operatorname{rad}(m)
+2\varepsilon R+2C-\log2.
\]

Consequently at least one `x` in `{M,c}` satisfies

\[
\boxed{
\sigma_2(x)>
\log\operatorname{rad}(m)
+\varepsilon R+C-\frac{\log2}{2}.
}
\]

This is a genuine one-endpoint concentration theorem: a global abc violation
cannot be distributed harmlessly between the two large adjacent endpoints.

## 3. Strong integer form

At the coefficient-one threshold

\[
h>R+\frac{\log2}{2},
\]

one of `M` and `c` satisfies

\[
\log\operatorname{rad}(m)<
\log x-2\log\operatorname{rad}(x).
\]

Exponentiating yields the exact natural-number inequality

\[
\boxed{
\operatorname{rad}(x)^2\operatorname{rad}(m)<x.
}
\]

Thus every strong violation contains a single large endpoint whose radical is
below its square-root scale even after multiplication by the entire radical of
the small endpoint.

Primewise, if

\[
x=\prod p^{e_p},
\]

then this says

\[
\prod_{e_p\ge3}p^{e_p-2}
>
\operatorname{rad}(m)
\prod_{e_p=1}p.
\]

The exponent-two layer is exactly neutral.  Only exponent-one support can
compensate the positive mass from exponents at least three.

## 4. Consequence for the remaining attack

The unresolved arithmetic problem is now one-sided:

> rule out an unbounded coprime short-gap family `x, x+m` in which one endpoint
> satisfies
> \[
> x>\operatorname{rad}(x)^2\operatorname{rad}(m)
> \]
> with the stronger conductor-proportional margin required by a fixed-quality
> abc violation.

This suggests a precise exponent-layer split:

1. **dispersed cubeful support:** many primes occur to exponent at least three;
2. **concentrated high powers:** a bounded set of primes carries most excess;
3. **mixed case:** separate a large cube-divisor core from the exponent-one
   coefficient and the small-endpoint radical.

The first case is naturally attacked by counting and incidence amplification;
the second by p-adic or generalized-Fermat descent; the third requires a
quantitative threshold between the two.

## 5. Lean formalization

The module

```text
Lean/IUTThreeClosures/LargeEndpointOneSidedConcentration.lean
```

contains:

```lean
exponentTwoSignedExcess_mul_of_coprime
nat_concentration_of_exponentTwoSignedExcess
ABCPoint.largeEndpoint_coprime_c
ABCPoint.largeEndpointSignedExcess_eq_endpointExcessSum_sub_smallRadical
ABCPoint.one_largeEndpoint_excess_of_height_violation
ABCPoint.one_largeEndpoint_excess_of_strong_violation
ABCPoint.one_largeEndpoint_nat_concentration_of_strong_violation
```

The targeted module and the full pinned project were built locally.  No
`axiom`, `sorry`, or `admit` is introduced.

This is an unconditional concentration theorem, not yet the elimination of
all one-sided concentrated families.
