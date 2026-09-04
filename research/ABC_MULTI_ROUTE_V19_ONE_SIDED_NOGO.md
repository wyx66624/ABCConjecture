# ABC multi-route research note v19: one-sided concentration is not sufficient

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. The proposed one-sided elimination theorem is false

The v18 theorem proves that every strong abc violation forces one large
endpoint `x` to satisfy

\[
\operatorname{rad}(x)^2\operatorname{rad}(m)<x,
\]

where `m` is the small endpoint.  It would be tempting to try to prove that no
unbounded coprime short-gap family can satisfy this inequality.  The dyadic
family gives a strict counterexample to that proposed route.

Take

\[
m=1,\qquad x=2^{n+3}.
\]

Then

\[
\operatorname{rad}(x)=2,\qquad
\operatorname{rad}(m)=1,
\]

so

\[
\operatorname{rad}(x)^2\operatorname{rad}(m)=4<2^{n+3}=x.
\]

Moreover

\[
\gcd(x,x+1)=1,
\]

and the family is unbounded.  Therefore one-sided concentration alone cannot
be contradicted by a pointwise theorem.

This does not produce abc counterexamples: the companion radical

\[
\operatorname{rad}(2^{n+3}+1)
\]

has not been controlled.  It proves that the companion endpoint is an
essential part of any successful closure.

## 2. Refined target

The remaining target must retain both terms:

\[
\sigma_2(x)+\sigma_2(x+m)
-2\log\operatorname{rad}(m),
\]

or equivalently the exact product condition

\[
\operatorname{rad}(m)
\operatorname{rad}(x)
\operatorname{rad}(x+m)
\]

relative to the height.  Any strategy which discards the companion radical is
now eliminated by an explicit infinite counterexample family.

For the dyadic subfamily, the full problem becomes a radical lower bound for

\[
2^k+1.
\]

Repeated prime factors of cyclotomic values, rather than the concentration of
`2^k` itself, are the genuine obstruction.  This reconnects the endpoint route
with the repository's cyclotomic and weighted-Wieferich audits.

## 3. Lean formalization

The module

```text
Lean/IUTThreeClosures/OneSidedConcentrationNoGo.lean
```

proves:

```lean
abcRadical_two_pow
dyadic_oneSidedConcentration
dyadic_companion_coprime
exists_unbounded_oneSidedConcentration
```

No `axiom`, `sorry`, or `admit` is introduced.

## 4. Route decision

The following route is discarded by a strict counterexample:

> prove that the one-sided inequality
> `rad(x)^2 rad(m) < x` has no unbounded coprime short-gap solutions.

The retained route is the two-endpoint compensated problem: control the
radical or repeated-prime mass of the companion `x+m` simultaneously with the
concentrated endpoint.
