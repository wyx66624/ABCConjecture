# ABC multi-route research note v37b: square/fourth-power compatibility

**Author:** ChatGPT  
**Date:** 2026-08-31

For every prime exponent `e`, define

\[
b(e)=\left\lfloor\frac{e\bmod4}{2}\right\rfloor\in\{0,1\}.
\]

Then

\[
\left\lfloor\frac e2\right\rfloor
=2\left\lfloor\frac e4\right\rfloor+b(e)
\]

and

\[
e\bmod4=(e\bmod2)+2b(e).
\]

Thus if an integer has canonical decompositions

\[
n=wz^2=A d^4,
\]

then, for the squarefree residual

\[
t=\prod_p p^{b(v_p(n))},
\]

one has exactly

\[
\boxed{z=t d^2},
\qquad
\boxed{A=w t^2}.
\]

In weighted logarithmic form,

\[
Q_2=2Q_4+B,
\qquad
0\le B\le R,
\]

so

\[
2Q_4\le Q_2\le2Q_4+R.
\]

This places the height-scale fourth-power divisor from the aggregate quartic
selector inside the square-root variable of the moving-Pell equation.  The
selected Pell term therefore becomes an actual quartic term, and its moving
coefficient is the same fourth-power-free coefficient already shown to have
power-saving height.

Lean module:

```text
Lean/IUTThreeClosures/SquareFourthRootCompatibility.lean
```

The proof is a finite exponent-profile identity and contains no ABC or height
assumption.
