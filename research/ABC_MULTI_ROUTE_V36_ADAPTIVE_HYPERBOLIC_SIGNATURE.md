# ABC multi-route research note v36: adaptive hyperbolic signatures

**Author:** ChatGPT  
**Date:** 2026-08-31

## Status

The fixed-power reductions v31--v35 force square, cube, and fourth-power parts,
but the visible fixed signature `(4,3,2)` is spherical:

\[
\frac14+\frac13+\frac12>1.
\]

This note proves a stronger adaptive statement.  In the non-short-gap branch,
choose a separate exponent from the height-to-radical ratio of each endpoint.
The resulting three integer exponents are all at least two, their reciprocal
sum is strictly below one, and every corresponding canonical power root has a
fixed positive endpoint-height share.

Thus every hypothetical abc counterexample in this branch produces a genuine
hyperbolic moving-coefficient generalized-Fermat equation.  The theorem is
unconditional arithmetic bookkeeping; it does not assume uniform finiteness
for the resulting moving signatures.

## 1. Adaptive exponent for one endpoint

Let an endpoint have logarithmic total weight `T>0` and radical weight `r>0`.
Fix a margin

\[
0<\delta<1
\]

and define

\[
\boxed{
k(T,r)=
\left\lfloor\frac{(1-\delta)T}{r}\right\rfloor+1.
}                                                       \tag{1.1}
\]

The floor inequalities give

\[
k(T,r)-1
\le
\frac{(1-\delta)T}{r}                                  \tag{1.2}
\]

and

\[
rac{(1-\delta)T}{r}<k(T,r).                           \tag{1.3}
\]

The second inequality implies

\[
\boxed{
\frac1{k(T,r)}
<
\frac{r}{(1-\delta)T}.
}                                                       \tag{1.4}
\]

If the right side of (1.1) before taking the floor is at least one, then

\[
\boxed{k(T,r)\ge2.}                                    \tag{1.5}
\]

## 2. Canonical root retains a fixed height margin

Let `Q_k` denote the logarithmic weight of the canonical extracted `k`-th
root.  The exact exponent-residue ledger is

\[
T\le(k-1)r+kQ_k.                                       \tag{2.1}
\]

For the adaptive exponent (1.1), equation (1.2) gives

\[
(k-1)r\le(1-\delta)T.                                  \tag{2.2}
\]

Combining (2.1) and (2.2),

\[
\boxed{
\delta T\le kQ_k.
}                                                       \tag{2.3}
\]

Thus the selected power root is not merely nontrivial.  Its powered
contribution carries at least a fixed proportion `delta` of the entire
endpoint height.

## 3. Parameters supplied by an abc violation

Let

\[
a+b=c,
\quad
m=\min(a,b),
\quad
M=\max(a,b),
\quad
h=\log c,
\quad
R=\log\operatorname{rad}(abc).
\]

Assume the asymptotic violation

\[
(1+\varepsilon)R<h,
\qquad
\varepsilon>0.                                        \tag{3.1}
\]

In the non-short-gap branch all endpoint heights are eventually bounded below
by the common fraction

\[
\alpha_\varepsilon h,
\qquad
\alpha_\varepsilon=
\frac{2+\varepsilon}{2(1+\varepsilon)}.                \tag{3.2}
\]

For `m`, this is the definition of the non-short-gap branch.  For `c`, it is
immediate.  For `M`, the elementary inequality `M>=c/2` gives
`log M>=h-log 2`; once

\[
h\ge\frac{2(1+\varepsilon)}{\varepsilon}\log2,
\]

this is at least `alpha_epsilon h`.  The bounded complementary range can be
absorbed into the eventual abc constant.

Choose

\[
\boxed{
\delta_\varepsilon=
\frac{\varepsilon}{2(2+\varepsilon)}.
}                                                       \tag{3.3}
\]

Then

\[
(1-\delta_\varepsilon)\alpha_\varepsilon
=
\frac{4+\varepsilon}{4(1+\varepsilon)}.                \tag{3.4}
\]

This is strictly larger than

\[
\frac1{1+\varepsilon}.                                 \tag{3.5}
\]

## 4. Reciprocal-sum calculation

Let `T_i,r_i` be the total and radical weights of `m,M,c`.  Pairwise
coprimality gives

\[
r_m+r_M+r_c=R.                                         \tag{4.1}
\]

Using `T_i>=alpha_epsilon h`,

\[
\begin{aligned}
\sum_i
\frac{r_i}{(1-\delta_\varepsilon)T_i}
&\le
\frac{R}
{(1-\delta_\varepsilon)\alpha_\varepsilon h}\\
&<
\frac{1/(1+\varepsilon)}
{(4+\varepsilon)/(4(1+\varepsilon))}\\
&=
\frac4{4+\varepsilon}\\
&<1.
\end{aligned}                                          \tag{4.2}
\]

Apply (1.4) to the three adaptive exponents `k_m,k_M,k_c`:

\[
\boxed{
\frac1{k_m}+rac1{k_M}+rac1{k_c}<1.
}                                                       \tag{4.3}
\]

Furthermore, (3.4)--(3.5) imply

\[
\frac{(1-\delta_\varepsilon)T_i}{r_i}>1,
\]

so

\[
\boxed{k_m,k_M,k_c\ge2.}                               \tag{4.4}
\]

## 5. Hyperbolic generalized-Fermat equation

For each endpoint use its canonical adaptive decomposition

\[
m=\kappa_m X_m^{k_m},
\qquad
M=\kappa_M X_M^{k_M},
\qquad
c=\kappa_c X_c^{k_c}.                                  \tag{5.1}
\]

The abc relation becomes

\[
\boxed{
\kappa_m X_m^{k_m}
+
\kappa_M X_M^{k_M}
=
\kappa_c X_c^{k_c}.
}                                                       \tag{5.2}
\]

The adaptive exponents satisfy the hyperbolicity condition (4.3), and the
canonical roots satisfy

\[
\boxed{
\delta_\varepsilon T_i
\le
k_i\log X_i
}
\]                                                      \tag{5.3}

for all three endpoints.  Hence every power term has a fixed positive source
height.  The residue coefficients contain no new prime support: they are built
from the same endpoint primes and their exponents are below the corresponding
adaptive exponent.

This is strictly stronger than merely exhibiting one large fourth-power
factor.  It gives a fully hyperbolic signature, although the signature and
coefficients move with the abc point.

## 6. What remains

Darmon--Granville type finiteness applies to a fixed hyperbolic signature and
fixed coefficients, but (5.2) has both moving exponents and moving residue
coefficients.  Applying a fixed-signature theorem separately and then allowing
the signature or coefficient to vary reverses the quantifiers needed for abc.

The remaining problem is now sharply divided:

1. **bounded adaptive exponents:** only finitely many hyperbolic signatures
   occur, but one needs conductor-uniform control as the coefficients vary;
2. **unbounded adaptive exponent:** at least one endpoint has an extremely
   high canonical power, inviting a high-exponent modular or local-lifting
   argument uniform in the conductor-supported residue kernel.

A genuine closure must establish one of these uniform statements.  The present
result does not insert either statement as an assumption.

## 7. Lean implementation

The module

```text
Lean/IUTThreeClosures/AdaptiveHyperbolicSignature.lean
```

formalizes:

```lean
sourceFraction
marginFraction
adaptiveExponent
ratio_lt_adaptiveExponent
two_le_adaptiveExponent
adaptiveExponent_sub_one_mul_radical_le
adaptiveExponent_reciprocal_lt
adaptive_root_margin
adaptive_exponents_are_hyperbolic
abc_scaled_radical_sum_lt_one
adaptive_profile_signature
```

`adaptive_profile_signature` computes all three exponents directly from the
finite exponent-profile total and radical weights.  It proves the reciprocal
sum and the three root-margin inequalities without storing a generalized
Fermat estimate, an abc conclusion, `axiom`, `sorry`, or `admit`.
