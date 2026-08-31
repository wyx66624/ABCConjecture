# ABC multi-route research note v34: the three-endpoint fourth-root frontier

**Author:** ChatGPT  
**Date:** 2026-08-31

## Status

This note continues the conductor-supported moving-Pell reduction now present in
`main`.  It proves a new deterministic higher-power consequence of any
hypothetical logarithmic abc violation in the non-short-gap branch:

> at least one of the three endpoints contains a canonical fourth-power root
> of fixed positive source-height exponent.

More generally, it computes the exact gain for a canonical `k`-th root.  The
gain is

\[
8+3\varepsilon-2k.
\]

Thus exponent four is the largest integer exponent whose gain is positive for
every positive `epsilon`.  No global generalized-Fermat, Mordell, or moving
conic estimate is assumed, so this is a structural reduction rather than a
complete proof of abc.

## 1. Canonical `k`-th-power extraction

For a positive integer

\[
n=\prod_{p\mid n}p^{e_p}
\]

and an integer `k>=2`, define

\[
t_k(n)=\prod_{p\mid n}p^{\lfloor e_p/k\rfloor},
\qquad
\kappa_k(n)=\prod_{p\mid n}p^{e_p\bmod k}.
\]

Then

\[
\boxed{n=\kappa_k(n)t_k(n)^k.}                         \tag{1.1}
\]

Every residue exponent is at most `k-1`, hence

\[
\log\kappa_k(n)
\le
(k-1)\log\operatorname{rad}(n).                       \tag{1.2}
\]

Consequently

\[
\boxed{
\log n
\le
(k-1)\log\operatorname{rad}(n)
+k\log t_k(n).
}                                                       \tag{1.3}
\]

The Lean theorem is formulated for arbitrary finite exponent profiles and
arbitrary nonnegative real coordinate weights:

\[
T\le(k-1)R+kQ_k.                                       \tag{1.4}
\]

Here `T` is total exponent weight, `R` is radical weight, and `Q_k` is the
canonical `k`-th-root weight.

## 2. Three-way radical pigeonhole

Let

\[
a+b=c,
\qquad
m=\min(a,b),
\qquad
M=\max(a,b),
\]

be a positive primitive abc point.  Write

\[
h=\log c,
\qquad
R=\log\operatorname{rad}(abc),
\]

and

\[
r_m=\log\operatorname{rad}(m),
\quad
r_M=\log\operatorname{rad}(M),
\quad
r_c=\log\operatorname{rad}(c).
\]

Pairwise coprimality gives the exact sum

\[
r_m+r_M+r_c=R.                                         \tag{2.1}
\]

Therefore at least one endpoint `n` satisfies

\[
\boxed{3\log\operatorname{rad}(n)\le R.}              \tag{2.2}
\]

This uses all three endpoints, rather than only the two large endpoints.  It
is the reason exponent four, rather than exponent three, becomes available in
the non-short-gap branch.

## 3. The non-short-gap source fraction

Assume that the desired abc estimate fails at fixed `epsilon>0` and `C`:

\[
\boxed{h>(1+\varepsilon)R+C.}                          \tag{3.1}
\]

The v31 short-gap/three-square dichotomy says that either

\[
2(1+\varepsilon)\log m<(2+\varepsilon)h,               \tag{3.2}
\]

or the small endpoint also has a height-scale square part.

In the complementary non-short-gap branch,

\[
\log m\ge
\alpha_\varepsilon h,
\qquad
\alpha_\varepsilon
=
\frac{2+\varepsilon}{2(1+\varepsilon)}.                \tag{3.3}
\]

The other endpoint heights satisfy

\[
\log M\ge h-\log2,
\qquad
\log c=h.                                               \tag{3.4}
\]

Since `alpha_epsilon<=1`, all three endpoint heights have the common lower
form

\[
\log n_i\ge\alpha_\varepsilon h-L_i,                   \tag{3.5}
\]

where one may take

\[
L_m=0,
\qquad
L_M=\log2,
\qquad
L_c=0.                                                  \tag{3.6}
\]

## 4. Exact general `k`-th-root gain

Choose the endpoint supplied by (2.2), and denote its radical log by `r`, its
height by `T`, its canonical `k`-th-root log by `Q_k`, and its loss by `L`.
From (1.3),

\[
T\le(k-1)r+kQ_k.                                       \tag{4.1}
\]

Using

\[
T\ge\alpha_\varepsilon h-L,
\qquad
3r\le R,                                                \tag{4.2}
\]

we obtain

\[
kQ_k
\ge
\alpha_\varepsilon h-L-\frac{k-1}{3}R.                \tag{4.3}
\]

Multiply by `3(1+epsilon)` and use (3.1):

\[
\begin{aligned}
3k(1+\varepsilon)Q_k
&\ge
3(1+\varepsilon)\alpha_\varepsilon h
-3(1+\varepsilon)L
-(k-1)(1+\varepsilon)R\\
&>
\left(\frac32(2+\varepsilon)-(k-1)\right)h
+(k-1)C
-3(1+\varepsilon)L.
\end{aligned}                                          \tag{4.4}
\]

Multiplying by two gives the denominator-free exact inequality

\[
\boxed{
\bigl(8+3\varepsilon-2k\bigr)h
+2(k-1)C
<
6k(1+\varepsilon)Q_k
+6(1+\varepsilon)L.
}                                                       \tag{4.5}
\]

This coefficient is not an artifact of a loose estimate.  It is the exact
combination of:

- the non-short-gap source fraction;
- the three-way radical pigeonhole;
- the `k-1` residue layers in a canonical `k`-th-power decomposition.

## 5. The quartic consequence

Set `k=4`.  Then

\[
8+3\varepsilon-2k=3\varepsilon>0.                      \tag{5.1}
\]

After division by three, at least one endpoint satisfies

\[
\boxed{
\varepsilon h+2C
<
8(1+\varepsilon)Q_4
+2(1+\varepsilon)L.
}                                                       \tag{5.2}
\]

For the three actual endpoints this yields one of

\[
\log t_4(m)
>
\frac{\varepsilon h+2C}{8(1+\varepsilon)},             \tag{5.3}
\]

\[
\log t_4(M)
>
\frac{\varepsilon h+2C}{8(1+\varepsilon)}
-\frac{\log2}{4},                                      \tag{5.4}
\]

or

\[
\log t_4(c)
>
\frac{\varepsilon h+2C}{8(1+\varepsilon)}.             \tag{5.5}
\]

Thus, in the non-short-gap branch, a hypothetical counterexample has:

1. height-scale square parts on all three endpoints;
2. a height-scale cube part on one of the two large endpoints;
3. a height-scale fourth-power part on at least one of the three endpoints.

The fourth-power conclusion uses no exponent cap and no distribution theorem.

## 6. Why exponent four is the uniform frontier of this argument

At `k=5`, the gain in (4.5) is

\[
8+3\varepsilon-10=3\varepsilon-2.                      \tag{6.1}
\]

For

\[
0<\varepsilon\le\frac23,
\]

this is nonpositive.  Therefore the three-way radical-pigeonhole mechanism
cannot force a fifth-power root with a positive source-height coefficient for
all positive epsilon.

In contrast, the quartic gain is `3 epsilon`, always strictly positive.  Hence
`k=4` is the maximal uniform exponent obtainable from this precise mechanism.
A fifth-power conclusion would require additional arithmetic information, not
merely a sharper rearrangement of the same inequalities.

## 7. New geometric frontier

Combining the v31 and v32 reductions with the present theorem gives several
cases.  Schematically, the original relation has simultaneously:

\[
\text{square part on }m,
\quad
\text{square part on }M,
\quad
\text{square part on }c,                               \tag{7.1}
\]

one cube part on `M` or `c`, and one fourth-power part on one of
`m,M,c`.

When the selected power parts lie on distinct endpoints, the relation becomes
a moving-coefficient generalized-Fermat equation of type `(4,3,2)` up to the
residue kernels.  When they lie on the same endpoint, the exponent profile has
simultaneously large canonical roots at two different moduli, which is a
separate residue-layer constraint.

The signature `(4,3,2)` by itself is not hyperbolic:

\[
\frac14+\frac13+\frac12=\frac{13}{12}>1.               \tag{7.2}
\]

Thus the mere coexistence of these powers cannot finish abc.  A valid next
step must retain the conductor-supported residue kernels, pairwise
coprimality, and the cyclic local splitting conditions already merged in v33.

## 8. Lean implementation

The module

```text
Lean/IUTThreeClosures/ThreeEndpointKthRootThreshold.lean
```

contains:

```lean
kthRootWeight
totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
one_of_three_triple_le
endpoint_kthRootScale_product
one_endpoint_has_kthRootScale
one_endpoint_has_fourthRootScale
quartic_gain_pos_and_quintic_gain_nonpos_for_small_epsilon
```

The endpoint root weights are computed directly from finite exponent profiles.
No abc conclusion, generalized-Fermat finiteness theorem, moving-Mordell height
bound, `axiom`, `sorry`, or `admit` is introduced.

## 9. Remaining decisive task

After v33 and v34, the non-short-gap counterexample locus is constrained by:

- a primitive conductor-supported squarefree conic;
- three cyclic quadratic residue conditions;
- three height-scale square parts;
- one height-scale cube part;
- one height-scale fourth-power part.

The remaining theorem must use these conditions jointly.  Treating only one
power divisor, only the real Pell approximation, or only the squarefree
coefficients is insufficient.  The natural next target is a local-global
sieve or descent that proves conductor growth for the correlated `(4,3,2)`
and coincident-root cases without inserting an abc-equivalent height bound as
an assumption.
