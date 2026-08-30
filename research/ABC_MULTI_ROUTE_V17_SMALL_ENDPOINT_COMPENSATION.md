# ABC multi-route research note v17: explicit small-endpoint compensation

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Removing the last unnamed quotient

Let

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad a+b=c.
\]

The v16 external quotient was

\[
E=
\frac{\operatorname{rad}(abc)}
     {\operatorname{rad}(Mc)}.
\]

For a positive primitive abc point, `m` is coprime to `Mc`, and

\[
mMc=abc.
\]

Radical multiplicativity for coprime integers therefore gives

\[
\operatorname{rad}(abc)
=
\operatorname{rad}(m)\operatorname{rad}(Mc).
\]

Hence the quotient is exactly

\[
\boxed{E=\operatorname{rad}(m).}
\]

No auxiliary or unnamed radical contribution remains.

## 2. Fully explicit coefficient-one region

For

\[
n=Mc,
\]

recall

\[
Q_+(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)},
\qquad
L(n)=\frac{\operatorname{rad}(n)^2}
          {\gcd(n,\operatorname{rad}(n)^2)}.
\]

The v16 criterion now becomes

\[
\boxed{
Q_+(Mc)
\le
L(Mc)\operatorname{rad}(m)^2.
}
\]

Whenever it holds,

\[
\boxed{
\log c
\le
\log\operatorname{rad}(abc)
+rac{\log2}{2}.
}
\]

Thus the coefficient-one region contains every triple for which the mass of
prime exponents above two on the two large endpoints is compensated by

1. primes occurring exactly once on those endpoints; and
2. two copies of the complete prime support of the smaller endpoint.

## 3. Exact obstruction in every remaining violation

Every triple violating the strong estimate must satisfy

\[
\boxed{
L(Mc)\operatorname{rad}(m)^2
<
Q_+(Mc).
}
\]

Written primewise, this is

\[
\prod_{p^e\parallel Mc,\ e\ge3}p^{e-2}
>
\left(\prod_{p\parallel Mc}p\right)
\operatorname{rad}(m)^2.
\]

This is the concrete integer obstruction that remains after the balanced
coefficient-three region, the cube-free region, and the signed-nonpositive
region have all been closed.

A prospective unbounded counterexample family must therefore exhibit a strict
and eventually conductor-scale imbalance between these two explicitly listed
sets of prime exponents.

## 4. Lean formalization

The module

```text
Lean/IUTThreeClosures/LargeEndpointExternalRadical.lean
```

proves:

```lean
abcRadical_mul_of_coprime
ABCPoint.endpointMin_coprime_largeEndpoint_mul_c
ABCPoint.endpointMin_mul_largeEndpoint_mul_c_eq_abcProduct
ABCPoint.externalRadicalQuotient_eq_endpointMinRadical
ABCPoint.height_le_conductor_add_log_two_div_two_of_endpointCompensation
ABCPoint.endpointCompensation_strict_of_strong_violation
```

The module was checked against the pinned project locally and contains no
`axiom`, `sorry`, or `admit`.

This theorem eliminates an abstraction from the remaining target; it does not
assert that the strict positive imbalance is already impossible.
