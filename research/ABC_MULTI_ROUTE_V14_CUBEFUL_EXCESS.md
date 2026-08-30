# ABC multi-route research note v14: quantitative cubeful excess

**Author:** ChatGPT  
**Date:** 2026-08-30  
**Base:** main after the v13 large-endpoint power-free merge

## 1. Exact remaining arithmetic mass

For a positive integer `n`, define

\[
Q(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)}.
\]

Primewise,

\[
v_p(Q(n))=\max(v_p(n)-2,0).
\]

Thus `Q(n)=1` precisely when `n` is cube-free, while `Q(n)` measures all
prime-exponent mass above level two.

The elementary identity

\[
n=\gcd(n,\operatorname{rad}(n)^2)Q(n)
\]

gives

\[
\boxed{n\le \operatorname{rad}(n)^2Q(n)}.
\]

## 2. Application to an abc point

Let `a+b=c` be a positive primitive abc triple and set

\[
M=\max(a,b),\qquad Q_P=Q(Mc).
\]

The v13 inequality is

\[
c^2\le 2Mc.
\]

Since `Mc` divides `abc`, radical monotonicity yields

\[
\boxed{c^2\le 2\operatorname{rad}(abc)^2Q_P}.
\]

Taking logarithms gives the exact ledger

\[
\boxed{
2\log c\le \log2+2\log\operatorname{rad}(abc)+\log Q_P.
}
\]

## 3. Closure and contrapositive

If, for every `epsilon>0`, there is a constant `K_epsilon` such that

\[
\log Q_P\le
2\epsilon\log\operatorname{rad}(abc)+K_\epsilon,
\]

then

\[
\log c\le
(1+\epsilon)\log\operatorname{rad}(abc)
+
\frac{K_\epsilon+\log2}{2},
\]

which is the standard logarithmic abc conjecture.

Conversely, a violation

\[
\log c>(1+\epsilon)\log\operatorname{rad}(abc)+C
\]

forces

\[
\boxed{
\log Q_P>
2\epsilon\log\operatorname{rad}(abc)+2C-\log2.
}
\]

A prospective counterexample therefore requires conductor-scale cubeful mass;
a single fixed prime cube or any bounded excess can be absorbed into the abc
constant.

## 4. Exact next problem

Combined with the v12 endpoint-balance transfer, the unresolved locus consists
of short-gap triples

\[
m+M=c,\qquad m<c^{1-\delta},
\]

for which the coprime adjacent pair `M,c` carries a cubeful excess of positive
conductor slope.  The next step is to split `Q(Mc)` primewise between the two
coprime endpoints and extract canonical cube carriers.  That converts the
remaining problem into a moving-coefficient difference-of-cubes equation.

## 5. Lean file

```text
Lean/IUTThreeClosures/LargeEndpointCubefulExcess.lean
```

The file proves the exact ledger, its quantitative contrapositive, and the
non-circular implication from a uniform cubeful-excess bound to
`ABCConjecture`.  It does not assume or claim that the uniform arithmetic bound
has already been established.
