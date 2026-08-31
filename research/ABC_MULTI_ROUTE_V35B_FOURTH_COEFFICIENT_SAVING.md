# ABC multi-route research note v35b: explicit quartic coefficient saving

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. From a large fourth root to a small moving coefficient

Suppose an endpoint has a fourth-power decomposition

\[
n=A d^4.
\]

Write

\[
T=\log n,\qquad K=\log A,\qquad q=\log d.
\]

Then

\[
T=K+4q.
\]

The aggregate v35 theorem shows that one of the three endpoints satisfies

\[
5\varepsilon h+6C-2(1+\varepsilon)L
<24(1+\varepsilon)q,
\]

where

\[
L=L_m+L_M+L_c.
\]

Since every endpoint is at most \(c\), we have \(T\le h\). Multiplying
\(T=K+4q\) by \(6(1+\varepsilon)\) and substituting the lower bound for
\(24(1+\varepsilon)q\) gives

\[
\boxed{
6(1+\varepsilon)K
<
(6+\varepsilon)h-6C+2(1+\varepsilon)L.
}
\]

Equivalently, after division by the positive number
\(6(1+\varepsilon)\),

\[
\boxed{
K<
\frac{6+\varepsilon}{6(1+\varepsilon)}h
-
\frac{C}{1+\varepsilon}
+
\frac{L}{3}.
}
\]

The coefficient exponent is therefore

\[
\frac{6+\varepsilon}{6(1+\varepsilon)}
=
1-
\frac{5\varepsilon}{6(1+\varepsilon)}
<1.
\]

Thus the moving fourth-power-free coefficient is not merely supported on the
ABC radical: its numerical size is power-saving relative to the total height.

## 2. Remaining quartic frontier

Every hypothetical non-short-gap counterexample now yields an endpoint
representation

\[
n=A d^4
\]

with both

\[
d^4\ge c^{\frac{5\varepsilon}{6(1+\varepsilon)}-o(1)}
\]

and

\[
A\le c^{1-\frac{5\varepsilon}{6(1+\varepsilon)}+o(1)}.
\]

Combined with the existing square and cube selectors, this produces a moving
generalized-Fermat equation whose coefficients have explicit power-saving
height. The unresolved issue is no longer arbitrary coefficient growth, but
whether radical-supported coefficients of this reduced size can coexist with
the pairwise-coprime Pell/Mordell and local residue constraints.

## 3. Lean module

The formalization is

```text
Lean/IUTThreeClosures/FourthPowerCoefficientSaving.lean
```

with declarations

```lean
coefficient_saving_of_fourthRoot_gain
one_endpoint_fourthPowerFreeCoefficient_small
```

No arithmetic existence theorem or ABC conclusion is assumed.
