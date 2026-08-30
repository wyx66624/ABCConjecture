# ABC multi-route research note v14: quantitative cubeful excess

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Objective

The v13 power-free theorem shows that an abc violation forces a prime cube in
the product of the two large adjacent endpoints.  A single cube is only a
qualitative obstruction.  This note replaces it by an exact quantitative
quantity measuring all exponent mass above two.

For a positive integer `n`, define

\[
Q(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)}.
\]

Primewise,

\[
v_p(Q(n))=\max(v_p(n)-2,0).
\]

Thus `Q(n)=1` exactly when `n` is cube-free, while large `Q(n)` records the
full cubeful concentration.

## 2. Elementary excess inequality

Since

\[
\gcd(n,\operatorname{rad}(n)^2)\mid\operatorname{rad}(n)^2,
\]

and

\[
n=\gcd(n,\operatorname{rad}(n)^2)Q(n),
\]

we have

\[
\boxed{n\le\operatorname{rad}(n)^2Q(n)}.
\]

No asymptotic or distribution result is used.

## 3. Application to the two large endpoints

For a positive primitive abc triple, set

\[
M=\max(a,b),\qquad n=Mc,
\]

and let

\[
Q_P=Q(Mc).
\]

From the v13 estimate,

\[
c^2\le2Mc.
\]

Since `Mc` divides `abc`,

\[
\operatorname{rad}(Mc)\le\operatorname{rad}(abc).
\]

Therefore

\[
\boxed{
c^2\le
2\operatorname{rad}(abc)^2Q_P.
}
\]

Taking logarithms gives the exact ledger

\[
\boxed{
2\log c\le
\log2+2\log\operatorname{rad}(abc)+\log Q_P.
}
\]

## 4. Quantitative closure criterion

If for some `epsilon` and `K` one has

\[
\log Q_P\le
2\epsilon\log\operatorname{rad}(abc)+K,
\]

then

\[
\boxed{
\log c\le
(1+\epsilon)\log\operatorname{rad}(abc)
+
\frac{K+\log2}{2}.
}
\]

Hence a uniform bound of this form for every positive `epsilon` proves the
standard logarithmic abc conjecture.

The point of the criterion is that the residual arithmetic object is now
explicit and local to two coprime short-interval integers; no IUT certificate,
Szpiro estimate, or abstract height conclusion is hidden in its definition.

## 5. Necessary growth in every violation

The same ledger yields a quantitative contrapositive.  If

\[
\log c>
(1+\epsilon)
\log\operatorname{rad}(abc)+C,
\]

then

\[
\boxed{
\log Q_P>
2\epsilon\log\operatorname{rad}(abc)
+2C-\log2.
}
\]

Thus an unbounded counterexample family must carry a fixed positive proportion
of conductor-scale mass in prime exponents above two on the large adjacent
endpoints.  Merely producing one repeated prime or one isolated cube is not
enough.

## 6. Interaction with the endpoint-balance theorem

Under a verified coefficient-three symmetric-product estimate with sublinear
error, v12 forces every remaining abc violation into an endpoint region

\[
\min(a,b)<c^{1-\delta}.
\]

The present theorem then forces the adjacent pair

\[
\max(a,b),\ c
\]

to have cubeful excess satisfying the lower bound above.  Consequently the
remaining positive problem is sharply formulated:

> prove that the cubeful excess of coprime integers in the relevant
> power-saving short intervals is `rad^{o(1)}` uniformly enough to absorb it.

The opposite counterexample program must construct a short-gap family whose
cubeful excess has a fixed positive conductor slope.

## 7. Lean deliverable

The Lean module is

```text
Lean/IUTThreeClosures/LargeEndpointCubefulExcess.lean
```

Its main declarations are:

```lean
gcd_mul_cubefulExcess_eq
le_radical_sq_mul_cubefulExcess
ABCPoint.c_sq_le_two_radical_sq_mul_cubefulExcess
ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_cubefulExcess
ABCPoint.height_le_of_cubefulExcess_bound
ABCPoint.cubefulExcess_large_of_height_violation
abc_of_uniformLargeEndpointCubefulExcessBound
```

This is an exact reduction and a partial closure theorem, not a claim that the
uniform cubeful-excess estimate has already been proved.
