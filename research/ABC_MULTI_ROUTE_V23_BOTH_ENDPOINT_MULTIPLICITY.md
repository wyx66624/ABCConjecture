# ABC multi-route research note v23: simultaneous multiplicity on both large endpoints

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Why the previous one-endpoint localization was not enough

The signed square-radical defect proves that an abc violation forces a large
net exponent surplus on at least one of the two large adjacent endpoints.  A
one-sided high-power statement alone cannot close the problem: explicit
families show that an arbitrary nearby integer can absorb the gap while
carrying a large radical.

The full conductor inequality gives more.  Because the radical of each
endpoint is individually bounded by the total abc radical, a violation forces
large multiplicity beyond the first radical layer on **both** large endpoints.
This is the first genuinely simultaneous conclusion in the endpoint route.

## 2. Exact theorem

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

For a positive integer `n`, define its logarithmic multiplicity excess

\[
E_1(n)=\log n-\log\operatorname{rad}(n).
\]

Suppose that, for some `epsilon>0` and real constant `C`,

\[
(1+\varepsilon)R+C<h.
\]

Since

\[
\log\operatorname{rad}(c)\le R,
\]

we obtain

\[
\boxed{
\varepsilon h+C
<
(1+\varepsilon)E_1(c).
}
\]

Also `c<=2M`, hence

\[
\log M\ge h-\log2.
\]

Together with

\[
\log\operatorname{rad}(M)\le R
\]

this gives

\[
\boxed{
\varepsilon h+C-(1+\varepsilon)\log2
<
(1+\varepsilon)E_1(M).
}
\]

Thus every unbounded counterexample family has a fixed positive height slope
in the multiplicity excess of both `M` and `c`.

More explicitly, once

\[
2\bigl(|C|+(1+\varepsilon)\log2\bigr)
\le \varepsilon h,
\]

we have simultaneously

\[
\boxed{
\frac{\varepsilon}{2}h
<
(1+\varepsilon)E_1(M)
}
\]

and

\[
\boxed{
\frac{\varepsilon}{2}h
<
(1+\varepsilon)E_1(c).
}
\]

## 3. Consequence for canonical square parts

Write the prime factorization of `n` as

\[
n=\prod_p p^{e_p}
\]

and define its canonical square root

\[
s_2(n)=\prod_p p^{\lfloor e_p/2\rfloor}.
\]

The deterministic exponent inequality

\[
e-1\le2\lfloor e/2\rfloor
\qquad(e\ge1)
\]

implies

\[
E_1(n)
=\sum_p(e_p-1)\log p
\le2\log s_2(n).
\]

Therefore every sufficiently large abc violation forces

\[
\boxed{
\log s_2(M),\ \log s_2(c)
>
\frac{\varepsilon}{4(1+\varepsilon)}h.
}
\]

In particular, both large adjacent endpoints contain square divisors of size
at least

\[
c^{\varepsilon/(2(1+\varepsilon))}
\]

up to the explicit fixed constants above.

## 4. Canonical generalized Pell reduction

For every positive integer `n`, unique factorization gives a canonical
square decomposition

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

The abc equation becomes

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

Multiplying by `v` yields the canonical generalized Pell equation

\[
\boxed{
(vY)^2-uvX^2=vm.
}
\]

Here `uv` is squarefree because `u` and `v` are squarefree and coprime, and

\[
uv\mid\operatorname{rad}(Mc).
\]

The new theorem supplies a quantitative lower bound on both `X` and `Y`; the
remaining problem is no longer a one-sided perfect-power gap.  It is a
uniform radical-growth problem for the two coordinates of a canonical Pell
solution whose discriminant and right-hand side are drawn from the abc
support.

## 5. What this does and does not prove

The simultaneous-square conclusion is unconditional under the assumption
that a given triple violates a specified abc inequality.  It does not by
itself contradict Pell equations: a fixed generalized Pell equation can have
arbitrarily large solutions.  The next required input must control the
radical contributed by the Pell coordinates uniformly as the discriminant
and right-hand side vary.

A valid closure theorem must exploit the full package simultaneously:

1. `X` and `Y` are both height-scale;
2. `u` and `v` are canonical squarefree kernels;
3. `uX^2` and `vY^2` differ by the third coprime abc endpoint;
4. the radicals of `m`, `uX`, and `vY` are all charged to the same conductor.

The Lean module for the first, fully proved part is

```text
Lean/IUTThreeClosures/BothLargeEndpointMultiplicityExcess.lean
```

It contains no `axiom`, `sorry`, or `admit` and does not assume an abc
conclusion.
