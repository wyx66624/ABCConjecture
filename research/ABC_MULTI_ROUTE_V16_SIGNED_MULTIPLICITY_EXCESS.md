# ABC multi-route research note v16: signed multiplicity excess

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. A sharper residual invariant

The unsigned cubeful quotient records only exponents above two.  A sharper
quantity also credits exponent-one primes, which help the radical:

\[
\Sigma(n)=\log n-2\log\operatorname{rad}(n).
\]

Primewise,

\[
\Sigma(n)=\sum_{p\mid n}(v_p(n)-2)\log p.
\]

Thus exponent-one primes contribute `-log p`, exponent-two primes contribute
zero, and higher exponents contribute positively.  The remaining obstruction
is therefore not raw cubeful mass but cubeful mass after cancellation by the
squarefree layer.

## 2. Exact abc ledger

For a primitive positive abc point, let

\[
M=\max(a,b),\qquad n=Mc.
\]

Since `c^2<=2Mc` and `rad(Mc)<=rad(abc)`, one obtains

\[
\boxed{
2\log c\le
\log2+2\log\operatorname{rad}(abc)+\Sigma(Mc).
}
\]

Consequently, a bound

\[
\Sigma(Mc)\le
2\epsilon\log\operatorname{rad}(abc)+K_\epsilon
\]

implies

\[
\log c\le
(1+\epsilon)
\log\operatorname{rad}(abc)+
\frac{K_\epsilon+\log2}{2}.
\]

Conversely, every violation forces

\[
\boxed{
\Sigma(Mc)>
2\epsilon\log\operatorname{rad}(abc)+2C-\log2.
}
\]

## 3. Endpoint-only target

Combining this ledger with the coefficient-three endpoint-balance theorem
shows that signed-excess control is required only when

\[
\log\min(a,b)<
\left(1-\frac\epsilon2\right)\log c.
\]

This target is strictly weaker than bounding the unsigned cubeful quotient:
large high-multiplicity mass may be offset by a comparably large squarefree
prime layer on the two large endpoints.

## 4. Lean files

```text
Lean/IUTThreeClosures/LargeEndpointSignedMultiplicityExcess.lean
Lean/IUTThreeClosures/EndpointSignedExcessSynthesis.lean
```

The second module proves that a uniform coefficient-three product estimate,
together with endpoint-local signed-excess control, implies the full
logarithmic abc conjecture.  Neither difficult input is asserted as an axiom.
