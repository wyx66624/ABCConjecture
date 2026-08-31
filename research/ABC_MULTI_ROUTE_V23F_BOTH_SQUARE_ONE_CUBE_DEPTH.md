# ABC multi-route research note v23f: both-square and one-cube depth

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Two multiplicity levels without choosing a prime factorization

For a positive integer `n`, define

\[
L_1(n)=\gcd(n,\operatorname{rad}(n)),
\qquad
Q_1(n)=n/L_1(n).
\]

Next put

\[
L_2(n)=\gcd(L_1(n),Q_1(n)),
\qquad
Q_2(n)=Q_1(n)/L_2(n).
\]

Then

\[
\boxed{n=L_1(n)L_2(n)Q_2(n)}
\]

and

\[
\boxed{L_2(n)^2\mid n.}
\]

The logarithm splits exactly:

\[
\boxed{
\log Q_1(n)=\log L_2(n)+\log Q_2(n).
}
\]

Thus a large first multiplicity quotient produces either a large genuine
square divisor or a large second quotient.

Refine once more:

\[
L_3(n)=\gcd(L_2(n),Q_2(n)),
\qquad
Q_3(n)=Q_2(n)/L_3(n).
\]

Then

\[
\boxed{L_3(n)^3\mid n}
\]

and

\[
\boxed{
\log Q_2(n)=\log L_3(n)+\log Q_3(n).
}
\]

The definitions use only gcd and exact division.  Primewise they coincide
with the supports of exponents at least two and at least three, but no selected
factorization is needed in the proof.

## 2. Every abc violation reaches square depth on both large endpoints

For a positive primitive triple set

\[
m=\min(a,b),
\qquad
M=\max(a,b),
\qquad
m+M=c,
\]

and write

\[
h=\log c,
\qquad
R=\log\operatorname{rad}(abc).
\]

If

\[
(1+\varepsilon)R+C<h,
\qquad \varepsilon>0,
\]

then

\[
\varepsilon h+C
<
(1+\varepsilon)
\bigl(\log c-\log\operatorname{rad}(c)\bigr),
\]

and, because `M>=c/2`,

\[
\varepsilon h+C-(1+\varepsilon)\log2
<
(1+\varepsilon)
\bigl(\log M-\log\operatorname{rad}(M)\bigr).
\]

Since

\[
\log n-\log\operatorname{rad}(n)
\le\log Q_1(n),
\]

both `Q_1(M)` and `Q_1(c)` have a fixed positive height slope in every
unbounded counterexample family.  Applying the exact first split independently
to both endpoints shows that each endpoint must carry either

- a large square divisor `L_2^2`, or
- a large quotient `Q_2` supported at multiplicity level three and above.

## 3. One endpoint necessarily reaches cube depth

For one integer define the signed exponent-two defect

\[
\delta_2(n)
=
\log n-2\log\operatorname{rad}(n).
\]

The exact endpoint localization already proved in the repository states that
every abc violation forces one of `M,c` to satisfy

\[
T<\delta_2(n),
\]

where

\[
T=
\log\operatorname{rad}(m)
+
\varepsilon R+C-rac{\log2}{2}.
\]

The gcd layers satisfy

\[
n\le\operatorname{rad}(n)^2Q_2(n),
\]

hence

\[
\delta_2(n)\le\log Q_2(n).
\]

Therefore one of the two large endpoints has

\[
T<\log Q_2(n).
\]

Using

\[
\log Q_2(n)=\log L_3(n)+\log Q_3(n)
\]

gives the exact alternative

\[
\boxed{
\frac{T}{2}<\log L_3(n)
\quad\text{and}\quad
L_3(n)^3\mid n,
}
\]

or

\[
\boxed{
\frac{T}{2}<\log Q_3(n).
}
\]

Thus every alleged abc counterexample has the simultaneous structure:

1. **both** large adjacent endpoints reach square multiplicity depth;
2. **at least one** reaches cube depth or retains an equally large deeper
   multiplicity quotient.

This is stronger than a one-sided perfect-power localization and stronger than
merely asserting the existence of one prime cube.

## 4. Remaining arithmetic target

This result still does not contradict the additive equation.  Identities and
Pell-type families show that large square divisors on both nearby endpoints,
or a square divisor on one endpoint and a high-power divisor on the other,
can coexist indefinitely when residual cofactors contribute enough radical.

The remaining pointwise target is therefore:

> control the radical of the residual cofactors in a pair of coprime nearby
> integers when both have height-scale first multiplicity quotient and one
> has height-scale second multiplicity quotient.

Equivalently, after canonical decompositions the route enters a varying
coefficient generalized Pell/Hall equation.  Any valid closure theorem must
use the residual radical; power-divisor size alone is insufficient.

## 5. Lean modules

```text
Lean/IUTThreeClosures/BothLargeEndpointMultiplicityExcess.lean
Lean/IUTThreeClosures/BothEndpointFirstLayerExcessQuotient.lean
Lean/IUTThreeClosures/FirstLayerGCDRefinement.lean
Lean/IUTThreeClosures/BothSquareOneCubeDepth.lean
```

No module introduces `axiom`, `sorry`, or `admit`, and no module assumes the
abc conjecture.
