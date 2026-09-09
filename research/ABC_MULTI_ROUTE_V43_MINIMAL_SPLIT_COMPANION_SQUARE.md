# ABC multi-route research note v43: a genuine companion square

**Author:** ChatGPT  
**Date:** 2026-08-31

Let a primitive split-square counterexample be represented by coprime roots

\[
0<x<y,
\qquad
P_{\rm sq}=((y-x)(y+x),x^2,y^2).
\]

Fix \(\varepsilon>0\) and \(C\), and assume this point has minimal height
among all primitive abc points violating

\[
(1+\varepsilon)R+C<h.
\]

The same-epsilon descent theorem forces

\[
\log(y+x)-\log\operatorname{rad}(y+x)
>
\frac{\varepsilon}{1+\varepsilon}\log y-\log2.
\]

Define the canonical square root

\[
q(n)=\prod_p p^{\lfloor v_p(n)/2\rfloor}.
\]

The v42 factorization theorem gives

\[
q(n)^2\mid n
\]

and

\[
\log n-\log\operatorname{rad}(n)
\le2\log q(n).
\]

Applying this to \(n=y+x\) yields the unconditional conclusion

\[
\boxed{q(y+x)^2\mid y+x}
\]

and

\[
\boxed{
\log q(y+x)
>
\frac{\varepsilon}{2(1+\varepsilon)}\log y
-
\frac{\log2}{2}.
}
\]

Thus every height-minimal split-square counterexample contains an actual
square divisor of the companion sum whose logarithmic size is a fixed positive
fraction of the root height.

Lean module:

```text
Lean/IUTThreeClosures/MinimalSplitSquareCompanionSquare.lean
```

Core declarations:

```lean
canonicalCompanionSquare_large_of_heightMinimalViolation
canonicalCompanionSquare_large_coefficient_form
```

No square-root witness, abc theorem, or height estimate is assumed.
