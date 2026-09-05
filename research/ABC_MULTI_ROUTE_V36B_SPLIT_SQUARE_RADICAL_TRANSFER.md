# ABC multi-route research note v36b: split-square radical transfer

**Author:** ChatGPT  
**Date:** 2026-08-31

Assume the two large endpoints are squares,

\[
M=x^2,
\qquad c=y^2,
\qquad d=y-x,
\qquad s=y+x.
\]

The root equation is \(d+x=y\), with root height \(H=\log y\).  Split the
original radical budget into the root-triple part \(R_{\rm root}\) and the
additional sum-factor part \(R_s\), up to a harmless fixed prime-two loss.

For \(\varepsilon>0\), define

\[
\alpha_\varepsilon=
\frac{2}{(1+\varepsilon)(2+\varepsilon)}.
\]

The exact identity

\[
\left(1+\frac\varepsilon2\right)
\left(2-(1+\varepsilon)\alpha_\varepsilon\right)
=1+\varepsilon
\]

gives the following dichotomy from any original violation

\[
(1+\varepsilon)(R_{\rm root}+R_s)+C<2H.
\]

If

\[
R_s\ge\alpha_\varepsilon H-K,
\]

then the smaller root triple satisfies

\[
\left(1+\frac\varepsilon2\right)R_{\rm root}
+
\frac{1+\varepsilon/2}{1+\varepsilon}
\bigl(C-(1+\varepsilon)K\bigr)
<H.
\]

Otherwise, if \(T_s\le R_s+2q_s\) is the canonical square budget for the sum
factor and \(H-L\le T_s\), then

\[
2q_s>
(1-\alpha_\varepsilon)H+K-L,
\]

where

\[
1-\alpha_\varepsilon
=
\frac{\varepsilon(3+\varepsilon)}
{(1+\varepsilon)(2+\varepsilon)}>0.
\]

Thus every split-square counterexample either descends to a smaller-height
abc violation with exponent \(\varepsilon/2\), or produces a height-scale
square divisor in the companion sum \(s=y+x\).

Lean module:

```text
Lean/IUTThreeClosures/SplitSquareRadicalTransfer.lean
```

The proof is exact real arithmetic and contains no ABC assumption.
