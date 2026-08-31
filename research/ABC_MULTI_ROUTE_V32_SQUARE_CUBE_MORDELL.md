# ABC multi-route research note v32: square-cube selection and the moving Mordell frontier

**Author:** ChatGPT  
**Date:** 2026-08-30

## Status

This note strengthens the v31 simultaneous-square reduction.  Every
hypothetical logarithmic `abc` violation has large square parts on both large
endpoints, and one of those two endpoints also has a large cube part.  Hence
it produces an integral point on a moving Mordell curve.

The argument is unconditional and elementary.  It does **not** insert a
uniform Mordell height estimate and therefore does not claim a complete proof
of `abc`.

## 1. Canonical cubic decomposition

For

\[
 n=\prod_{p\mid n}p^{e_p},
\]

put

\[
 t_3(n)=\prod_{p\mid n}p^{\lfloor e_p/3\rfloor},
 \qquad
 \kappa_3(n)=\prod_{p\mid n}p^{e_p\bmod 3}.
\]

Then

\[
 \boxed{n=\kappa_3(n)t_3(n)^3.}                         \tag{1.1}
\]

Since every residue exponent is at most two,

\[
 \log\kappa_3(n)
 \le2\log\operatorname{rad}(n).                         \tag{1.2}
\]

Consequently

\[
 \boxed{
 3\log t_3(n)
 \ge
 \log n-2\log\operatorname{rad}(n).
 }                                                       \tag{1.3}
\]

The Lean module `CubePartExponentWeight.lean` proves the weighted finite-profile
version

\[
 T\le2R+3Q_3,
 \qquad
 \frac{T-2R}{3}\le Q_3.                                 \tag{1.4}
\]

## 2. Radical pigeonhole on the two large endpoints

Let

\[
 a+b=c,
 \qquad
 m=\min(a,b),
 \qquad
 M=\max(a,b),
\]

and write

\[
 h=\log c,
 \qquad
 R=\log\operatorname{rad}(abc),
\]

\[
 r_M=\log\operatorname{rad}(M),
 \qquad
 r_c=\log\operatorname{rad}(c).
\]

Pairwise coprimality gives

\[
 r_M+r_c\le R.                                         \tag{2.1}
\]

Therefore

\[
 2r_M\le R
 \quad\hbox{or}\quad
 2r_c\le R.                                            \tag{2.2}
\]

Assume a violation

\[
 h>(1+\varepsilon)R+C,
 \qquad \varepsilon>0.                                \tag{2.3}
\]

If `2r_M<=R`, then `log M>=h-log 2` and (1.3) imply

\[
\begin{aligned}
3\log t_3(M)
&\ge h-\log2-2r_M\\
&\ge h-\log2-R\\
&>
 \frac{\varepsilon h+C}{1+\varepsilon}-\log2.
\end{aligned}                                         \tag{2.4}
\]

Thus

\[
 \boxed{
 \log t_3(M)>
 \frac{\varepsilon h+C}{3(1+\varepsilon)}-rac{\log2}{3}.
 }                                                       \tag{2.5}
\]

If instead `2r_c<=R`, then

\[
 \boxed{
 \log t_3(c)>
 \frac{\varepsilon h+C}{3(1+\varepsilon)}.
 }                                                       \tag{2.6}
\]

Hence one large endpoint contains a cube divisor of fixed positive height
exponent.  This conclusion is stronger than the previous positive-surplus
statement because it selects a canonical cube root without imposing a global
exponent cap.

## 3. Combination with the simultaneous square parts

The v31 reduction gives canonical square decompositions

\[
 M=u_2x_2^2,
 \qquad
 c=v_2y_2^2,                                           \tag{3.1}
\]

with both `x_2` and `y_2` of height scale.  The cube selector gives one of the
two alternatives

\[
 M=u_3x_3^3                                             \tag{3.2}
\]

or

\[
 c=v_3y_3^3.                                           \tag{3.3}
\]

Therefore every violation yields one of the mixed equations

\[
 \boxed{m+u_3x_3^3=v_2y_2^2}                           \tag{3.4}
\]

or

\[
 \boxed{m+u_2x_2^2=v_3y_3^3.}                          \tag{3.5}
\]

All prime supports belonging to different original endpoints are disjoint.
The residue kernels have no new prime support: their primes already occur in
`abc`.

## 4. Exact integral Mordell embeddings

For (3.4), put

\[
 X=u_3v_2x_3,
 \qquad
 Y=u_3v_2^2y_2.
\]

A direct expansion gives

\[
 \boxed{
 Y^2=X^3+u_3^2v_2^3m.
 }                                                       \tag{4.1}
\]

For (3.5), put

\[
 X=u_2v_3y_3,
 \qquad
 Y=u_2^2v_3x_2.
\]

Then

\[
 \boxed{
 X^3=Y^2+u_2^3v_3^2m,
 }                                                       \tag{4.2}
\]

or over the integers

\[
 Y^2=X^3-u_2^3v_3^2m.                                  \tag{4.3}
\]

Thus every hypothetical `abc` counterexample creates an integral point on a
Mordell curve

\[
 E_D:\quad Y^2=X^3+D,                                  \tag{4.4}
\]

where

\[
 D=u_3^2v_2^3m
 \quad\hbox{or}\quad
 D=-u_2^3v_3^2m.                                       \tag{4.5}
\]

The radical of `D` introduces no prime outside `abc`:

\[
 \operatorname{rad}(|D|)
 \mid\operatorname{rad}(abc).                         \tag{4.6}
\]

The Lean module `SquareCubeMordellBridge.lean` proves (4.1)--(4.3) first as
plain natural-number identities and then directly from arbitrary finite
exponent profiles.

## 5. Why this is not yet the final estimate

For a fixed nonzero `D`, the integral points on `Y^2=X^3+D` are finite, but
`D` here moves with the original point and can have large absolute size even
when its radical is small.  A pointwise upper bound with the coefficient
required here would amount to a uniform Hall/Szpiro-type estimate for the
moving Mordell family.  Finiteness for each fixed curve does not supply a
constant independent of the moving residue kernels and the moving low-radical
gap.

The exact remaining statement can be isolated as follows.

> **Moving Mordell radical target.**  For every `epsilon>0`, integral points
> produced by (4.1) or (4.3), with the pairwise support restrictions inherited
> from a primitive `abc` triple, must have source height bounded by
> `(1+epsilon)` times the logarithm of the full truncated prime support, plus a
> constant depending only on `epsilon`.

The general unrestricted version is another presentation of the same global
arithmetic difficulty, so it is not stored as a Lean assumption.

## 6. A sharper branch after the v31 small-endpoint split

If the smaller endpoint is not in the v31 short-gap range, it has a
height-scale square part

\[
 m=wz^2.                                                \tag{6.1}
\]

Then (3.4) or (3.5) becomes a primitive generalized-Fermat equation of
signature `(3,2,2)` or `(2,2,3)`:

\[
 wz^2+u_3x_3^3=v_2y_2^2,                               \tag{6.2}
\]

or

\[
 wz^2+u_2x_2^2=v_3y_3^3.                               \tag{6.3}
\]

Factoring the difference of the two square terms in the appropriate quadratic
field gives a cubic Kummer descent.  The remaining obstruction is uniformity
in the moving quadratic field, its `3`-class group, and the moving truncated
prime support.  Treating the field as fixed before choosing the constant would
reverse the quantifiers and is not valid.

## 7. Current frontier

The route has now passed through four increasingly rigid descriptions:

1. signed exponent-two surplus;
2. simultaneous square parts and a moving Pell norm equation;
3. a canonical cube part on one large endpoint;
4. an integral point on a moving Mordell curve, and in the non-short-gap branch
   a `(2,2,3)` generalized-Fermat equation.

The next decisive task is no longer to find an abstract exponent layer.  It is
to prove a uniform radical-sensitive height estimate for the inherited moving
Mordell/Kummer family, using its pairwise support restrictions.  Until that
estimate is proved, the branch is a verified reduction rather than a complete
proof of `abc`.
