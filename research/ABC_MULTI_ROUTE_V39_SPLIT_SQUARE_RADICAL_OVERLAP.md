# ABC multi-route research note v39: fixed-prime radical overlap

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. General radical-overlap inequality

For positive integers `a,b`, radical monotonicity gives

\[
\operatorname{lcm}(\operatorname{rad}a,\operatorname{rad}b)
\mid\operatorname{rad}(ab).
\]

Moreover

\[
\gcd(\operatorname{rad}a,\operatorname{rad}b)\mid\gcd(a,b).
\]

Using

\[
\gcd(r_a,r_b)\operatorname{lcm}(r_a,r_b)=r_ar_b
\]

therefore yields

\[
\boxed{
\operatorname{rad}(a)\operatorname{rad}(b)
\le
\gcd(a,b)\operatorname{rad}(ab).
}
\]

If \(\gcd(a,b)\mid2\), then

\[
\boxed{
\operatorname{rad}(a)\operatorname{rad}(b)
\le2\operatorname{rad}(ab).
}
\]

## 2. Application to split squares

For the primitive-root data

\[
d=y-x,
\qquad
s=y+x,
\qquad
\gcd(x,y)=1,
\]

v38 proves \(\gcd(d,s)\mid2\).  Hence

\[
\operatorname{rad}(d)\operatorname{rad}(s)
\le2\operatorname{rad}(ds).
\]

Because `d` and `s` are each coprime to `x` and `y`, and `x,y` are coprime,
radical multiplicativity gives

\[
\operatorname{rad}(dxy)
=
\operatorname{rad}(d)\operatorname{rad}(x)\operatorname{rad}(y)
\]

and

\[
\operatorname{rad}(dsxy)
=
\operatorname{rad}(ds)\operatorname{rad}(x)\operatorname{rad}(y).
\]

Multiplying the two-factor overlap bound by the root radicals yields

\[
\boxed{
\operatorname{rad}(dxy)\operatorname{rad}(s)
\le2\operatorname{rad}(dsxy).
}
\]

## 3. Logarithmic form

All radicals are positive, so logarithmic monotonicity gives

\[
\boxed{
\log\operatorname{rad}(dxy)
+
\log\operatorname{rad}(s)
\le
\log\operatorname{rad}(dsxy)+\log2.
}
\]

Thus the sum of the root-triple conductor and the full companion-sum radical
exceeds the original four-factor support conductor by at most the fixed
quantity \(\log2\).  This is the exact fixed-overlap input needed to instantiate
the v36b radical-transfer dichotomy on actual integers.

## 4. Lean module

```text
Lean/IUTThreeClosures/SplitSquareRadicalOverlap.lean
```

Core declarations:

```lean
radical_mul_le_gcd_mul_radical_product
radical_mul_le_two_mul_radical_product
Data.rootRadical_eq_factor_product
Data.supportRadical_eq_factor_product
Data.rootRadical_mul_sumRadical_le_two_mul_supportRadical
Data.log_rootRadical_add_log_sumRadical_le_log_supportRadical_add_log_two
```

The module contains no `axiom`, `sorry`, or `admit`.
