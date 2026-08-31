# ABC multi-route research note v36: split-square radical transfer

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Setting

Assume that the two large endpoints of a primitive positive abc triple are
squares:

\[
M=x^2,
\qquad
c=y^2,
\qquad
0<x<y.
\]

Put

\[
d=y-x,
\qquad
s=y+x.
\]

Then

\[
m=c-M=y^2-x^2=ds,
\]

and the root equation is

\[
d+x=y.
\]

Let

\[
H=\log y.
\]

Ignoring only the harmless overlap at the prime two, write the radical budget
as

\[
R_{\mathrm{root}}+R_s,
\]

where \(R_{\mathrm{root}}\) is the radical log of the root triple
\((d,x,y)\), and \(R_s\) is the additional radical contribution of the
factor \(s=y+x\).

Suppose the original square-endpoint point violates an abc bound:

\[
(1+\varepsilon)
(R_{\mathrm{root}}+R_s)+C
<2H.
\]

## 2. Exact transfer threshold

Define

\[
\boxed{
\alpha_\varepsilon
=
\frac{2}{(1+\varepsilon)(2+\varepsilon)}.
}
\]

For every \(\varepsilon>0\),

\[
0<\alpha_\varepsilon<1.
\]

The defining identity is

\[
\boxed{
\left(1+\frac{\varepsilon}{2}\right)
\left(2-(1+\varepsilon)\alpha_\varepsilon\right)
=1+\varepsilon.
}
\]

Assume that, for some fixed loss \(K\),

\[
R_s\ge \alpha_\varepsilon H-K.
\]

Substituting into the original violation and using the identity above gives

\[
\boxed{
\left(1+\frac{\varepsilon}{2}\right)R_{\mathrm{root}}
+
\frac{1+\varepsilon/2}{1+\varepsilon}
\bigl(C-(1+\varepsilon)K\bigr)
<H.
}
\]

Thus the root triple \(d+x=y\) is an abc violation with exponent
\(\varepsilon/2\), up to an explicitly transformed constant. The height has
fallen from \(2\log y\) to \(\log y\).

This is a genuine descent statement, not merely a structural analogy.

## 3. The complementary square-gain branch

If the omitted sum radical is below the threshold,

\[
R_s<\alpha_\varepsilon H-K,
\]

write the canonical square decomposition of \(s\) in logarithmic form. If
\(T_s=\log s\), and \(q_s\) is the logarithmic size of the extracted square
root, then

\[
T_s\le R_s+2q_s.
\]

Since \(s=y+x\ge y\), one may take \(T_s\ge H\); the formal theorem allows
a general fixed loss \(L\):

\[
H-L\le T_s.
\]

Combining the inequalities yields

\[
\boxed{
2q_s>
(1-\alpha_\varepsilon)H+K-L.
}
\]

The gain coefficient has the closed form

\[
\boxed{
1-\alpha_\varepsilon
=
\frac{\varepsilon(3+\varepsilon)}
{(1+\varepsilon)(2+\varepsilon)}
>0.
}
\]

Therefore the complementary branch produces an actual square divisor of
\(s=y+x\) whose logarithmic size is a fixed positive proportion of the root
height.

## 4. Complete split-square dichotomy

Every hypothetical split-square counterexample satisfies at least one of:

1. **root-triple descent**
   \[
   d+x=y
   \]
   is an \(\varepsilon/2\)-level abc violation with half the original
   logarithmic height;

2. **sum-square concentration**
   \[
   s=y+x
   \]
   contains a square divisor with logarithmic size at least
   \[
   \frac{
   \varepsilon(3+\varepsilon)
   }{
   2(1+\varepsilon)(2+\varepsilon)
   }H-O(1).
   \]

This replaces the undifferentiated split-square branch by a recursive
counterexample branch and a new perfect-power concentration branch.

## 5. Lean formalization

The module is

```text
Lean/IUTThreeClosures/SplitSquareRadicalTransfer.lean
```

with core declarations

```lean
rootConductor_transfer
halfEpsilonCriticalAlpha
halfEpsilonCriticalAlpha_identity
halfEpsilon_rootTransfer
squareRoot_gain_of_small_sumRadical
rootViolation_or_sumSquareGain
one_sub_halfEpsilonCriticalAlpha
```

The module is purely non-circular real arithmetic. It contains no `axiom`,
`sorry`, or `admit`, and assumes neither ABC nor a radical estimate.

## 6. Next arithmetic task

The root-descent branch can be iterated only if the corresponding auxiliary
factor remains radical-large. Otherwise each descent stage creates a
height-scale square factor in the complementary sum. The remaining pointwise
problem is therefore to prove that an unbounded chain cannot alternate between

* decreasing-height abc violations, and
* fresh square concentration in the companion sums,

while preserving pairwise coprimality and the inherited cube/quartic
concentration from the nonsplit analysis.
