# ABC multi-route research note v16: more than one height unit of multiplicity

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Definition

For a positive primitive triple `a+b=c`, put

\[
M=\max(a,b),\qquad
h=\log c,\qquad
R=\log\operatorname{rad}(abc).
\]

Define the net multiplicity surplus of the two large nearby integers by

\[
\boxed{
L=\log(Mc)-R.
}
\]

Although `R` also charges the radical of the small endpoint, this is useful:
`L` is a conservative lower measure of repeated-prime mass in the large pair.

## 2. Universal lower corridor

Since `c<=2M`,

\[
c^2\le2Mc.
\]

Taking logarithms gives

\[
2h-\log2\le\log(Mc),
\]

and therefore

\[
\boxed{
2h-\log2-R\le L.
}
\]

## 3. Subunit surplus slope closes abc

Suppose

\[
L\le(1+\delta)h+K,
\qquad \delta<1.
\]

Combining the upper and lower bounds gives

\[
(1-\delta)h\le R+K+\log2,
\]

hence

\[
\boxed{
h\le\frac{R+K+\log2}{1-\delta}.
}
\]

Thus the exact frontier is not whether the large pair has repeated factors,
but whether its net multiplicity exceeds one full height unit.

## 4. Necessary condition for a counterexample

Assume

\[
h>(1+\varepsilon)R+C,
\qquad \varepsilon>0.
\]

Multiply the lower corridor by `1+epsilon` and use

\[
(1+\varepsilon)R+C<h.
\]

This yields

\[
\boxed{
(1+2\varepsilon)h+C-(1+\varepsilon)\log2
 <(1+\varepsilon)L.
}
\]

Equivalently,

\[
L>
\left(1+\frac{\varepsilon}{1+\varepsilon}\right)h
+
\frac{C}{1+\varepsilon}-\log2.
\]

Therefore every genuine counterexample family requires more than one height
unit of net multiplicity in the two large nearby endpoints.

## 5. Why this improves the cubeful-excess formulation

The family

\[
1+2^k=2^k+1
\]

may have almost one full height unit of repeated-prime mass in `2^k`.  This is
compatible with abc because the opposite endpoint can carry almost one full
height unit of radical.  The v16 inequality identifies exactly what a
counterexample must do beyond this model: it must obtain an additional fixed
positive height proportion of repeated-prime mass after the entire radical of
all three coordinates has already been charged.

The next arithmetic step is to localize `L` between `M` and `c`.  Since each
individual endpoint contributes at most one height unit, the v16 lower bound
strongly suggests that both coprime nearby endpoints must have a positive
height proportion of repeated-prime mass.  Formalizing and then proving the
corresponding two-endpoint square-divisor gap theorem is the next concentrated
target.

## 6. Lean deliverable

```text
Lean/IUTThreeClosures/LargePairMultiplicitySurplus.lean
```

Main declarations:

```lean
ABCPoint.two_mul_height_sub_log_two_le_largePairLog
ABCPoint.two_mul_height_sub_log_two_sub_conductor_le_surplus
ABCPoint.height_le_of_largePairMultiplicitySurplus_heightSlope
ABCPoint.largePairMultiplicitySurplus_large_of_abc_violation
```

No height estimate or abc conclusion is assumed.
