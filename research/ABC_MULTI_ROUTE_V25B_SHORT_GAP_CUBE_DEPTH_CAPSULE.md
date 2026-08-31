# ABC multi-route research note v25b: the short-gap/cube-depth residual capsule

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Inputs

For a positive primitive abc point, write

\[
m=\min(a,b),
\qquad
M=\max(a,b),
\qquad
m+M=c,
\]

and

\[
h=\log c,
\quad
R=\log\operatorname{rad}(abc),
\quad
S=\log(abc).
\]

Assume the pointwise coefficient-three estimate

\[
S\le3R+\eta h+K
\]

and suppose that the same point violates a proposed abc estimate:

\[
(1+\varepsilon)R+C<h,
\qquad \varepsilon>0.
\]

## 2. Exact short-gap bound

The endpoint product corridor

\[
2h+\log m-\log2\le S
\]

gives

\[
\boxed{
(1+\varepsilon)\log m
<
\bigl(1-2\varepsilon+\eta(1+\varepsilon)\bigr)h
+(1+\varepsilon)(K+\log2)-3C.
}
\]

In particular, if

\[
\eta<\frac{2\varepsilon}{1+\varepsilon},
\]

the remaining endpoint is power-saving.

## 3. A conductor lower bound forced by coefficient three

The same lower and upper product estimates imply

\[
3R
\ge
(2-\eta)h+\log m-K-\log2.
\]

Because `log m>=0`,

\[
\varepsilon R
\ge
\frac{\varepsilon(2-\eta)}{3}h
-
\frac{\varepsilon}{3}K
-
\frac{\varepsilon}{3}\log2.
\]

The signed endpoint localization gives one of `M,c` a square-radical defect
larger than

\[
T=
\log\operatorname{rad}(m)+\varepsilon R+C-rac{\log2}{2}.
\]

Since `log rad(m)>=0`, define

\[
B=
\frac{\varepsilon(2-\eta)}{3}h+C
-rac{\varepsilon}{3}K
-\left(\frac{\varepsilon}{3}+\frac12\right)\log2.
\]

Then

\[
\boxed{B\le T.}
\]

Thus coefficient three makes the signed depth threshold itself height-scale;
it is not merely a qualitative existence statement.

## 4. Cube-depth residual

For a positive integer `n`, the factorization-free gcd layers are

\[
L_1=\gcd(n,\operatorname{rad}(n)),
\qquad
Q_1=n/L_1,
\]

\[
L_2=\gcd(L_1,Q_1),
\qquad
Q_2=Q_1/L_2,
\]

\[
L_3=\gcd(L_2,Q_2),
\qquad
Q_3=Q_2/L_3.
\]

They satisfy

\[
L_3^3\mid n
\]

and

\[
\log Q_2=\log L_3+\log Q_3.
\]

Moreover

\[
\log n-2\log\operatorname{rad}(n)
\le\log Q_2(n).
\]

Consequently one of the two large adjacent endpoints `n in {M,c}` satisfies

\[
\boxed{
\frac{B}{2}<\log L_3(n)
\quad\text{and}\quad
L_3(n)^3\mid n,
}
\]

or

\[
\boxed{
\frac{B}{2}<\log Q_3(n).
}
\]

For fixed `epsilon>0` and a truly sublinear coefficient-three error, the
leading cube-depth slope is asymptotically

\[
\frac{\varepsilon}{3}h.
\]

## 5. Final narrowed core under coefficient three

A verified coefficient-three theorem therefore reduces every alleged abc
counterexample to the simultaneous package:

1. `m` is in an explicit power-saving range;
2. both `M` and `c` have height-scale multiplicity beyond their first radical
   layers;
3. one of `M,c` has a height-scale cube divisor or height-scale multiplicity
   beyond cube depth;
4. the residual cofactors still have to carry enough radical to avoid the
   desired contradiction.

The remaining task is a pointwise radical theorem for this short-gap,
mixed-depth configuration.  Merely extracting large powers is insufficient;
the residual radical must be controlled.

## 6. Lean module

```text
Lean/IUTThreeClosures/CoefficientThreeCubeDepthResidual.lean
```

The module introduces no `axiom`, `sorry`, or `admit`, and it does not assume
an abc conclusion.
