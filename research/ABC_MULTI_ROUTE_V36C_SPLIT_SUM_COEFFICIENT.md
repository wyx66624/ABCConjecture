# ABC multi-route research note v36c: power-saving companion coefficient

**Author:** ChatGPT  
**Date:** 2026-08-31

In the square-concentration side of the split-square dichotomy, write

\[
s=y+x=A r^2.
\]

Let

\[
H=\log y,
\quad T_s=\log s,
\quad K_s=\log A,
\quad q=\log r.
\]

Then

\[
T_s=K_s+2q.
\]

The v36b square gain gives

\[
2q>
(1-\alpha_\varepsilon)H+K-L,
\]

where

\[
\alpha_\varepsilon=
\frac{2}{(1+\varepsilon)(2+\varepsilon)}.
\]

Since \(s=y+x<2y\), one has

\[
T_s\le H+\log2.
\]

Combining these exact inequalities yields

\[
\boxed{
K_s<
\alpha_\varepsilon H+\log2-K+L.
}
\]

Because \(0<\alpha_\varepsilon<1\), the moving coefficient in

\[
x+y=A r^2
\]

has power-saving height. Thus the corrected split-square frontier is:

1. either the root triple \((y-x)+x=y\) is an \(\varepsilon/2\)-level abc
   violation at half logarithmic height;
2. or the companion sum has the form \(A r^2\), where \(r^2\) is
   height-scale and \(A\) is power-saving.

Lean module:

```text
Lean/IUTThreeClosures/SplitSquareSumCoefficientSaving.lean
```

This is an exact consequence of the v36b dichotomy and assumes no new
arithmetic theorem.
