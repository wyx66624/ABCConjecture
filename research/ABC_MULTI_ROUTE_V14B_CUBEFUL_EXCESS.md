# ABC multi-route research note v14b: quantitative cubeful excess

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. The remaining repeated-prime object

For a positive primitive triple `a+b=c`, put

\[
M=\max(a,b).
\]

The large-endpoint power-free theorem gives

\[
c^2\le 2Mc.
\]

To measure exactly the prime-exponent mass above two, define

\[
Q(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)}.
\]

Primewise,

\[
v_p(Q(n))=\max(v_p(n)-2,0).
\]

Thus `Q(n)=1` exactly when `n` is cube-free.

## 2. Exact deterministic inequality

Since

\[
n=\gcd(n,\operatorname{rad}(n)^2)Q(n)
\]

and the gcd is at most `rad(n)^2`,

\[
\boxed{n\le\operatorname{rad}(n)^2Q(n)}.
\]

Because `Mc` divides `abc`, radical monotonicity gives

\[
\operatorname{rad}(Mc)\le\operatorname{rad}(abc).
\]

Consequently

\[
\boxed{
c^2\le
2\operatorname{rad}(abc)^2Q(Mc).
}
\]

Writing

\[
h=\log c,
\qquad
R=\log\operatorname{rad}(abc),
\]

we obtain the exact ledger

\[
\boxed{
2h\le\log2+2R+\log Q(Mc).
}
\]

## 3. A sufficient quantitative closure

For a fixed positive `epsilon`, an estimate

\[
\log Q(Mc)\le 2\epsilon R+K_\epsilon
\]

implies

\[
\boxed{
h\le(1+\epsilon)R+
\frac{K_\epsilon+\log2}{2}.}
\]

Uniform validity for every positive `epsilon` therefore implies the standard
logarithmic abc conjecture.

This is a genuine arithmetic target: it refers only to the prime exponents of
two explicitly defined coprime adjacent endpoints. No IUT output, modified
Szpiro estimate, or abc conclusion is stored in the definition.

## 4. Quantitative necessity for a violation

The same ledger gives the strict contrapositive. If

\[
h>(1+\epsilon)R+C,
\]

then

\[
\boxed{
\log Q(Mc)>
2\epsilon R+2C-\log2.
}
\]

Hence a counterexample family must accumulate conductor-scale mass in prime
exponents above two. A single bounded prime cube, or any uniformly bounded
cubeful factor, is absorbed into the additive constant and cannot disprove
abc.

## 5. Scope and next target

The uniform cubeful-excess estimate is sufficient rather than necessary for
all triples; triples with a large ordinary radical may satisfy abc by other
corridors even when this particular estimate is weak. The useful target is
therefore the residual endpoint-degenerate and low-radical region isolated by
the coefficient-three endpoint-balance transfer.

The next arithmetic step is to split `Q(Mc)` across the coprime factors `M`
and `c`, relate each part to canonical cube divisors, and prove either:

1. a subcritical cubeful-excess estimate on the residual low-radical locus; or
2. a rigorous no-go/counterexample showing such an estimate cannot be the
   final closure.

## 6. Lean module

The kernel candidate is

```text
Lean/IUTThreeClosures/LargeEndpointCubefulExcess.lean
```

with main declarations

```lean
gcd_mul_cubefulExcess_eq
le_radical_sq_mul_cubefulExcess
ABCPoint.c_sq_le_two_radical_sq_mul_cubefulExcess
ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_log_cubefulExcess
ABCPoint.height_le_of_cubefulExcess_bound
ABCPoint.cubefulExcess_large_of_height_violation
abc_of_uniformLargeEndpointCubefulExcessBound
```

The module contains no `axiom`, `sorry`, or `admit` and does not claim that the
remaining uniform estimate has already been proved.
