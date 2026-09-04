# ABC multi-route research note v17: both large endpoints must carry repeated-prime mass

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Multiplicity excess

For a positive integer `n`, define

\[
E(n)=\log n-\log\operatorname{rad}(n).
\]

This measures all prime-multiplicity mass beyond first occurrence.  It is zero
for squarefree integers and positive precisely when repeated prime factors are
present.

Let

\[
a+b=c,\qquad M=\max(a,b),\qquad h=\log c,\qquad
R=\log\operatorname{rad}(abc).
\]

Since both `c` and `M` divide `abc`, radical monotonicity gives

\[
\log\operatorname{rad}(c)\le R,\qquad
\log\operatorname{rad}(M)\le R.
\]

Also `c<=2M`, hence

\[
\log M\ge h-\log2.
\]

## 2. Coordinatewise localization theorem

Assume that for some `epsilon>0` and real constant `C`,

\[
(1+\varepsilon)R+C<h.
\]

For the `c` coordinate,

\[
(1+\varepsilon)\log\operatorname{rad}(c)+C<h.
\]

Rearranging gives

\[
\boxed{
\varepsilon h+C<(1+\varepsilon)E(c).
}
\]

For the larger summand,

\[
\log M\ge h-\log2,\qquad
\log\operatorname{rad}(M)\le R,
\]

and therefore

\[
\boxed{
\varepsilon h+C-(1+\varepsilon)\log2
 <(1+\varepsilon)E(M).
}
\]

Equivalently,

\[
E(c)>
\frac{\varepsilon}{1+\varepsilon}h+
\frac{C}{1+\varepsilon},
\]

and

\[
E(M)>
\frac{\varepsilon}{1+\varepsilon}h+
\frac{C}{1+\varepsilon}-\log2.
\]

Thus every genuine abc counterexample forces a fixed positive height
proportion of repeated-prime mass in **both** large nearby coprime endpoints.

## 3. Why this removes a false direction

The family

\[
1+2^k=2^k+1
\]

shows that a single highly powerful endpoint is compatible with abc.  The
other endpoint can supply enough radical to compensate.  The v17 theorem
proves that this phenomenon cannot occur in a genuine counterexample: the
opposite large endpoint must also have a positive-height multiplicity excess.

Consequently it is not enough to count numbers having one prime cube.  The
remaining problem concerns pairs of coprime nearby integers whose squarefree
cores are simultaneously small.

## 4. Square-divisor interpretation

For every positive integer there is a canonical factorization

\[
n=sx^2,
\]

with `s` squarefree.  Primewise,

\[
2\lfloor v_p(n)/2\rfloor\ge v_p(n)-1,
\]

so the square part satisfies

\[
x^2\ge \frac{n}{\operatorname{rad}(n)}.
\]

The v17 lower bounds therefore force both `M` and `c` to contain square
divisors whose roots have size at least a fixed positive power of `c` along
any putative counterexample family.  Writing

\[
M=u x^2,\qquad c=v y^2,
\]

with `u,v` squarefree, the additive equation becomes

\[
\boxed{v y^2-u x^2=\min(a,b).}
\]

The squarefree coefficients move, so a fixed Pell equation theorem is not
sufficient.  The concentrated next target is a uniform gap theorem for two
coprime integers in a power-saving interval whose squarefree kernels are both
small.

## 5. Lean deliverable

```text
Lean/IUTThreeClosures/EndpointMultiplicityLocalization.lean
```

Main declarations:

```lean
ABCPoint.radical_c_le_abcRadical
ABCPoint.radical_largeEndpoint_le_abcRadical
ABCPoint.log_radical_c_le_conductor
ABCPoint.log_radical_largeEndpoint_le_conductor
ABCPoint.height_sub_log_two_le_log_largeEndpoint
ABCPoint.multiplicityExcess_c_large_of_abc_violation
ABCPoint.multiplicityExcess_largeEndpoint_large_of_abc_violation
ABCPoint.both_large_coordinates_have_multiplicityExcess_of_abc_violation
```

No abc conclusion, height estimate, or distribution theorem is assumed.
