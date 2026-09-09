# ABC multi-route research note v41: same-epsilon split-square descent

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Exact no-loss threshold

For the actual split-square data

\[
d=y-x,
\qquad
s=y+x,
\qquad
P_{\rm root}=(d,x,y),
\qquad
P_{\rm sq}=(ds,x^2,y^2),
\]

put

\[
H=h(P_{\rm root})=\log y.
\]

The v40 overlap estimate is

\[
R_{\rm root}+R_s
\le R_{\rm sq}+\log2.
\]

Fix \(\varepsilon>0\) and define

\[
\boxed{
\alpha_\varepsilon^{\rm same}
=
\frac1{1+\varepsilon}.
}
\]

It satisfies the exact transfer identity

\[
\boxed{
(1+\varepsilon)
\left(2-(1+\varepsilon)\alpha_\varepsilon^{\rm same}
\right)
=1+\varepsilon.
}
\]

Choose the threshold loss

\[
K=-\log2.
\]

This cancels the fixed radical-overlap loss exactly.

## 2. Same-epsilon dichotomy

Assume

\[
(1+\varepsilon)R_{\rm sq}+C
<h(P_{\rm sq})=2H.
\]

Then at least one of the following holds.

### Same-parameter root violation

\[
\boxed{
(1+\varepsilon)R_{\rm root}+C<H.
}
\]

Thus the actual primitive root triple is a counterexample for the same
\((\varepsilon,C)\), at exactly half logarithmic height.

### Companion multiplicity excess

\[
\boxed{
\frac{\varepsilon}{1+\varepsilon}H-\log2
<
\log s-\log\operatorname{rad}(s).
}
\]

The coefficient follows from

\[
1-\alpha_\varepsilon^{\rm same}
=
\frac{\varepsilon}{1+\varepsilon}.
\]

This is stronger for descent purposes than the earlier \(\varepsilon/2\)
formulation: neither epsilon nor the additive constant changes in the first
branch.

## 3. Minimal-counterexample consequence

For fixed \(\varepsilon>0\) and \(C\), suppose
\(P_{\rm sq}\) has minimal height among all primitive abc points satisfying

\[
(1+\varepsilon)R+C<h.
\]

The root point cannot also violate this inequality, because

\[
h(P_{\rm root})
=
\frac12h(P_{\rm sq})
< h(P_{\rm sq}).
\]

Therefore every height-minimal split-square counterexample must satisfy

\[
\boxed{
\log(y+x)-\log\operatorname{rad}(y+x)
>
\frac{\varepsilon}{1+\varepsilon}\log y-\log2.
}
\]

This removes the recursive branch by a genuine well-founded minimal-height
argument and leaves only height-scale repeated-prime concentration in the
companion sum.

## 4. Lean module

```text
Lean/IUTThreeClosures/ActualSplitSquareSameEpsilonDescent.lean
```

Core declarations:

```lean
sameEpsilonCriticalAlpha
sameEpsilonCriticalAlpha_identity
one_sub_sameEpsilonCriticalAlpha
sameEpsilon_rootViolation_or_companionMultiplicityExcess
rootPoint_height_pos
rootPoint_height_lt_squarePoint_height
companionMultiplicityExcess_of_heightMinimalViolation
```

No ABC theorem or existence interface is assumed.
