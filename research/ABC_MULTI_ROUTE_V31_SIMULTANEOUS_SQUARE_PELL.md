# ABC multi-route research note v31: simultaneous square parts and the moving Pell frontier

**Author:** ChatGPT  
**Date:** 2026-08-30

## Status

This note gives a new unconditional structural reduction for any hypothetical
counterexample to logarithmic `abc`.  It does **not** assert the remaining
uniform Pell/radical estimate and therefore does not claim a complete proof of
`abc`.

The accompanying Lean modules formalize:

- the canonical square-root weight inequality for an arbitrary finite
  exponent profile;
- the exact scalar transfer from an `abc` height violation to simultaneous
  endpoint square-root growth;
- the canonical square decomposition and its moving Pell norm equation;
- the quantitative short-gap versus three-square-parts dichotomy.

## 1. Canonical square decomposition

For a positive integer

\[
 n=\prod_{p\mid n}p^{e_p},
\]

put

\[
 s(n)=\prod_{p\mid n}p^{\lfloor e_p/2\rfloor},
 \qquad
 \kappa_2(n)=\prod_{p\mid n}p^{e_p\bmod 2}.
\]

Then

\[
 \boxed{n=\kappa_2(n)s(n)^2.}                         \tag{1.1}
\]

The parity kernel `kappa_2(n)` is squarefree.  Its support is a subset of the
support of `n`, so

\[
 \log\kappa_2(n)\le\log\operatorname{rad}(n).         \tag{1.2}
\]

Consequently

\[
 \boxed{
 2\log s(n)
 =\log n-\log\kappa_2(n)
 \ge\log n-\log\operatorname{rad}(n).
 }                                                     \tag{1.3}
\]

The finite-profile Lean theorem is slightly more general.  With arbitrary
nonnegative real coordinate weights it proves

\[
 T\le R+2S,
 \qquad
 \frac{T-R}{2}\le S,                                  \tag{1.4}
\]

where `T` is total exponent weight, `R` is radical weight, and `S` is the
canonical square-root weight.

## 2. Both large endpoints of every violation have large square parts

Let

\[
 a+b=c,
 \qquad
 m=\min(a,b),
 \qquad
 M=\max(a,b),
\]

be a positive primitive `abc` point.  Write

\[
 h=\log c,
 \qquad
 R=\log\operatorname{rad}(abc).
\]

Suppose that for fixed `epsilon>0` and real `C` the point violates the desired
bound:

\[
 h>(1+\varepsilon)R+C.                                \tag{2.1}
\]

Since `M>=c/2`,

\[
 \log M\ge h-\log2.                                   \tag{2.2}
\]

Write the canonical square decompositions

\[
 M=u x^2,
 \qquad
 c=v y^2.                                             \tag{2.3}
\]

Using (1.3), `log rad(M)<=R`, and (2.1),

\[
\begin{aligned}
2\log x
&\ge \log M-\log\operatorname{rad}(M)\\
&\ge h-\log2-R\\
&>\frac{\varepsilon}{1+\varepsilon}h
  +\frac{C}{1+\varepsilon}-\log2.
\end{aligned}                                         \tag{2.4}
\]

Likewise,

\[
\begin{aligned}
2\log y
&\ge h-\log\operatorname{rad}(c)\\
&\ge h-R\\
&>\frac{\varepsilon}{1+\varepsilon}h
  +\frac{C}{1+\varepsilon}.
\end{aligned}                                         \tag{2.5}
\]

Therefore

\[
 \boxed{
 \log x>
 \frac{\varepsilon h+C}{2(1+\varepsilon)}-rac{\log2}{2},
 \qquad
 \log y>
 \frac{\varepsilon h+C}{2(1+\varepsilon)}.
 }                                                     \tag{2.6}
\]

This is stronger than merely finding one large square divisor of the product
`Mc`: both coprime large endpoints separately contain square divisors of fixed
positive height exponent.

## 3. Exact moving Pell equation

Substituting (2.3) into `m+M=c` gives

\[
 \boxed{m+u x^2=v y^2.}                               \tag{3.1}
\]

Multiplying by `v`,

\[
 \boxed{(vy)^2-(uv)x^2=vm.}                           \tag{3.2}
\]

Thus every hypothetical counterexample gives a solution of a Pell-type norm
equation in the moving quadratic field

\[
 \mathbf Q(\sqrt{uv}).                                \tag{3.3}
\]

The parameters are not arbitrary:

1. `u` and `v` are squarefree parity kernels;
2. their prime supports are disjoint because `gcd(M,c)=1`;
3. `uv` is supported on `rad(Mc)`, hence
   \[
   \log(uv)\le R;
   \]
4. the right side `vm` is coprime to the square-part support arising from
   `M`;
5. both Pell coordinates `x,y` satisfy the height-scale lower bounds (2.6).

The Lean theorem `profile_gap_to_pell_norm_equation` proves (3.2) directly for
two arbitrary finite exponent profiles.

## 4. Short gap or a third large square part

Let

\[
 m=w z^2                                                     \tag{4.1}
\]

be the canonical square decomposition of the smaller endpoint, and put

\[
 h_m=\log m.
\]

The scalar argument gives the following exact alternative:

\[
 \boxed{
 2(1+\varepsilon)h_m<(2+\varepsilon)h
 }                                                        \tag{4.2}
\]

or

\[
 \boxed{
 \varepsilon h+2C<4(1+\varepsilon)\log z.
 }                                                        \tag{4.3}
\]

Indeed, if (4.2) fails, then

\[
 2(1+\varepsilon)h_m\ge(2+\varepsilon)h.                 \tag{4.4}
\]

Using

\[
 2\log z\ge h_m-\log\operatorname{rad}(m)                 \tag{4.5}
\]

and

\[
 (1+\varepsilon)\log\operatorname{rad}(m)+C<h,            \tag{4.6}
\]

one obtains (4.3) by direct rearrangement.

Thus a hypothetical counterexample lies in one of two concrete regimes.

### Regime A: quantitatively short additive gap

\[
 \log m<
 \frac{2+\varepsilon}{2(1+\varepsilon)}\log c.             \tag{4.7}
\]

The Pell equation (3.2) then has a right side smaller than the main source
height by a definite exponent.  This is the correct entry point for
Archimedean and `p`-adic approximation, but the quadratic irrational and its
support move with the point.

### Regime B: three simultaneous square parts

All three terms have decompositions

\[
 w z^2+u x^2=v y^2,                                       \tag{4.8}
\]

with `x,y,z` of positive height scale.  This is a primitive moving-coefficient
diagonal conic.  The coefficients `u,v,w` are squarefree and their product is
supported on `rad(abc)`.

## 5. Why the Pell identity alone does not close abc

For fixed `u,v,m`, equation (3.2) may have infinitely many solutions generated
by units of a real quadratic field.  Their classical rational approximations
to `sqrt(v/u)` naturally have order `1/y^2`; this is compatible with the
critical exponent in Roth's theorem.  Therefore an Archimedean irrationality
estimate by itself cannot rule out the Pell orbit.

The coefficient field also moves:

\[
 uv\le\operatorname{rad}(Mc),                              \tag{5.1}
\]

and the right side contains the moving low-radical gap `m`.  A valid closure
must exploit the **truncated prime support** of the coefficients, the gap, and
the Pell coordinates simultaneously.  Treating `u,v,m` as fixed before the
constant is chosen would reverse the quantifiers required by `abc`.

The remaining pointwise target can be stated as follows.

> **Moving Pell radical target.** For every `epsilon>0`, uniformly over
> pairwise compatible squarefree `u,v,w` and primitive positive solutions of
> `wz^2+ux^2=vy^2`, the full source height is bounded with coefficient one by
> the truncated prime support of `uvwx y z` (equivalently of the original
> three endpoints), up to an `epsilon`-loss and an additive constant depending
> only on `epsilon`.

Without a further restriction this target is another form of the same global
arithmetic difficulty; the present note does not assume it.

## 6. Concrete next attacks

The reduction makes two attacks precise.

1. **Short-gap Pell attack.** Combine (4.7), the exact error formula
   \[
   \sqrt{v/u}-x/y
   =\frac{m}{u y^2(\sqrt{v/u}+x/y)},                       \tag{6.1}
   \]
   with a simultaneous `S`-adic estimate whose constants depend only on the
   *truncated mass* of the moving support, not on the support set itself.

2. **Three-square conic attack.** Parametrize (4.8), retain all pairwise
   coprimality constraints, and prove coefficient-one radical growth for the
   resulting correlated binary forms.  A generic counting bound for one large
   square divisor is insufficient; the three-term correlation and the
   low-radical coefficient product must be used.

The present branch records the exact algebraic reduction and its quantitative
constants.  It does not merge a theorem named `ABCConjecture`, because the
moving-support estimate in Section 5 has not been proved.
