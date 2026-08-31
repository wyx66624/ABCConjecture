# ABC multi-route research note v23: simultaneous multiplicity on both large endpoints

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Exact two-endpoint theorem

Let

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad m+M=c,
\]

and put

\[
h=\log c,
\qquad
R=\log\operatorname{rad}(abc).
\]

For a positive integer `n`, define

\[
E_1(n)=\log n-\log\operatorname{rad}(n).
\]

Suppose that, for `epsilon>0`,

\[
(1+\varepsilon)R+C<h.
\]

Since each endpoint radical is bounded by the full abc radical,

\[
\log\operatorname{rad}(c)\le R,
\qquad
\log\operatorname{rad}(M)\le R.
\]

The first inequality gives

\[
\boxed{
\varepsilon h+C
<
(1+\varepsilon)E_1(c).
}
\]

Also `c<=2M`, hence `log M>=h-log 2`, and therefore

\[
\boxed{
\varepsilon h+C-(1+\varepsilon)\log2
<
(1+\varepsilon)E_1(M).
}
\]

Thus every unbounded counterexample family has a fixed positive height slope
in the multiplicity excess of **both** large adjacent endpoints.

Once

\[
2\bigl(|C|+(1+\varepsilon)\log2\bigr)
\le \varepsilon h,
\]

we obtain simultaneously

\[
\boxed{
\frac{\varepsilon}{2}h
<
(1+\varepsilon)E_1(M),
\qquad
\frac{\varepsilon}{2}h
<
(1+\varepsilon)E_1(c).
}
\]

## 2. Canonical square-part consequence

Write

\[
n=\prod_p p^{e_p}
\]

and define

\[
s_2(n)=\prod_p p^{\lfloor e_p/2\rfloor}.
\]

Since `e-1<=2 floor(e/2)` for every positive exponent,

\[
E_1(n)\le2\log s_2(n).
\]

Consequently, every sufficiently large abc violation forces both canonical
square roots to satisfy

\[
\boxed{
\log s_2(M),\ \log s_2(c)
>
\frac{\varepsilon}{4(1+\varepsilon)}h.
}
\]

This is a simultaneous statement.  It is strictly stronger than extracting a
perfect-power divisor from only one endpoint.

## 3. Canonical generalized Pell equation

Unique factorization gives

\[
n=u_2(n)s_2(n)^2,
\]

where

\[
u_2(n)=\prod_p p^{e_p\bmod2}
\]

is squarefree and divides `rad(n)`.

Write

\[
M=uX^2,
\qquad
c=vY^2.
\]

Then

\[
\boxed{
vY^2-uX^2=m.
}
\]

Pairwise coprimality of `(m,M,c)` implies

\[
\gcd(uX,vY)=1,
\qquad
\gcd(uv,m)=1.
\]

Multiplying by `v` yields

\[
\boxed{
(vY)^2-uvX^2=vm.
}
\]

Because `u` and `v` are coprime and squarefree, `uv` is squarefree.  Moreover
`uv` is supported on the original abc radical.  The remaining positive route
is therefore a uniform radical-growth theorem for the two coordinates of
this canonical generalized Pell equation, with both coordinates already
known to be height-scale.

## 4. Status

The two-endpoint multiplicity theorem is proved mathematically and formalized
in

```text
Lean/IUTThreeClosures/BothLargeEndpointMultiplicityExcess.lean
```

The canonical integer square decomposition and Pell conversion are recorded
here as the next formalization target.  No Pell radical-growth theorem and no
abc conclusion is assumed.
