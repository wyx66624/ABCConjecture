# ABC multi-route research note v11

**Author:** ChatGPT  
**Date:** 2026-08-29  
**Base commit:** `f5f314de3a7f8575d5dee9e43371c2dcce9eaf83`

## Status

This note records three new unconditional reductions/barriers and the current
four-route target. It does **not** assert a parameter-free proof or disproof of
the abc conjecture.

The accompanying Lean modules contain no new arithmetic-existence axiom. They
formalize only elementary arithmetic, finite-density exponent bookkeeping,
linear auxiliary-family distortion, and the exact relation between
`log(abc)` and the standard abc height.

## 1. Smooth-neighbour route: the exact density-gap threshold

Let a prospective counterexample have the form

\[
a_n+p_n^k=c_n,
\]

with

\[
a_n\le (p_n^k)^{\theta+o(1)},\qquad
\operatorname{rad}(c_n)\le (p_n^k)^{\beta+o(1)}.
\]

The prime-power term contributes the logarithmic radical slope `1/k`, so the
deterministic total slope is

\[
\theta+\frac1k+\beta.
\]

The low-radical counting argument already in `main` shows that a theorem on a
prime-power family dense enough to have exponent `1/k` forces

\[
\beta\ge \frac1k.
\]

Hence a density-compatible subcritical slope exists if and only if

\[
\boxed{\theta+\frac{2}{k}<1},
\]

or, equivalently,

\[
\boxed{2<(1-\theta)k}.
\]

This is now kernel-formalized in
`PrimePowerDensityGapThreshold.lean`. At square-root gap scale
`theta=1/2`, the criterion becomes exactly `k>4`; it is not merely a
necessary estimate but the complete feasible region for the exponent
bookkeeping under the density lower bound.

### Consequence for the analytic target

Recent all-interval smooth-number results reach intervals of
square-root type but do not impose the required radical exponent or low
`omega` condition. The next genuinely positive target is therefore not another
unweighted smooth-number count. It is one of the following:

1. an infinite, height-unbounded sparse set of prime-power centres satisfying a
   local tilted low-`omega` estimate; or
2. a direct low-radical neighbour theorem with parameters inside
   `theta + 2/k < 1`.

The candidate family may have density zero. The exact disproof gate already on
`main` only requires an unbounded family, not positive density.

## 2. Frey--modified-Szpiro route: sharp auxiliary distortion

Suppose an auxiliary operation changes the logarithmic quantities by

\[
H'=H+\alpha D,\qquad N'=N+\beta D.
\]

From

\[
H'\le \lambda N'+C
\]

one obtains exactly

\[
\boxed{
H\le \lambda N+(\lambda\beta-\alpha)D+C.
}
\]

Thus an auxiliary-family estimate descends uniformly for all `D>=0` whenever

\[
\lambda\beta\le\alpha.
\]

If `lambda*beta-alpha>0`, the transformed inequality alone cannot imply any
uniform base-curve constant: the Lean module gives an explicit real-valued
countermodel for every proposed constant.

For the nominal quadratic-twist bookkeeping

\[
\alpha=6,\qquad \beta=2,
\]

and the modified-Szpiro slope `lambda=6+epsilon`, the distortion is

\[
(6+\epsilon)2-6=6+2\epsilon>0.
\]

Therefore an unbounded-good-twist argument cannot be closed by simply
untwisting the resulting inequalities. A viable twist amplification must add
new cancellation, prove that a good twist can be chosen with uniformly bounded
`D`, or use an auxiliary operation with nonpositive distortion at the target
slope.

This is formalized in `FreyAuxiliaryDistortionBarrier.lean`.

## 3. IUT/effective-abc route: the symmetric-product coefficient threshold

For every positive abc point `a+b=c`,

\[
ab\ge c-1\ge \frac c2,
\]

and hence

\[
abc\ge \frac{c^2}{2}.
\]

Taking logarithms gives the exact universal endpoint estimate

\[
\boxed{
2\log c-\log2\le \log(abc).
}
\]

Consequently a symmetric-product inequality

\[
\log(abc)\le \lambda\log\operatorname{rad}(abc)+E
\]

implies only

\[
\boxed{
\log c\le
\frac{\lambda}{2}\log\operatorname{rad}(abc)
+
\frac{E+\log2}{2}.
}
\]

Without a further balance-sensitive input, coefficient three in `log(abc)`
therefore transfers to coefficient `3/2` in the standard height; it does not
by itself reach abc coefficient one. Coefficient two is a clean sufficient
threshold.

The new Lean module proves the actual `ABCPoint` inequality and the following
non-circular closure criterion:

> If, for every `epsilon>0`, one has one constant valid for every abc point such
> that
> \[
> \log(abc)\le (2+2\epsilon)
> \log\operatorname{rad}(abc)+C_\epsilon,
> \]
> then `ABCConjecture` follows.

This criterion identifies a precise target for any IUT-derived estimate stated
in the symmetric product rather than in `log c`. The coefficient-three
inequality announced in arXiv:2503.14510 is therefore valuable but is not, in
this form alone, the final coefficient-one closure.

The formalization is in `SymmetricProductCoefficientBarrier.lean`.

## 4. S-unit / Arakelov route

The existing modules already establish:

- the exact rational S-unit/tripod reformulation;
- absorption of local overhead `g(p)=o(log p)` into an arbitrarily small
  multiple of `log rad` plus one fixed constant;
- non-absorption of a fixed positive residual conductor slope;
- the six-element ceiling for the orbit generated only by complement and
  inversion.

The remaining positive theorem is still a genuine uniform height estimate. A
successful proof may use the symmetric-product coefficient-two target above,
or it may prove the standard height inequality directly. Merely proving
finiteness for every fixed support, or bounding the number of solutions in
terms of `|S|`, does not control the height uniformly as the support varies.

## 5. Current four-route frontier

| Route | Exact remaining arithmetic/geometric theorem |
|---|---|
| Smooth-neighbour disproof | Construct an unbounded prime-power neighbour family inside `theta+2/k<1`, or prove no such family exists. |
| Frey--modified-Szpiro proof | Prove a source-uniform slope-six estimate; auxiliary amplification must pass the nonpositive-distortion criterion or provide bounded auxiliary size. |
| IUT proof | Construct the genuine source-derived theta possible-image output and a quantifier-correct global comparison; a symmetric-product formulation must reach coefficient two, or add balance-sensitive information sufficient to compensate a larger coefficient. |
| S-unit / Arakelov proof | Prove a varying-support height estimate with leading conductor coefficient one; support entropy bookkeeping alone is already exhausted. |

## 6. Merge standard

The new statements should enter `main` only after both repository workflows
succeed:

1. `Lean kernel build`;
2. `Lean all-module audit`.

A successful merge records a sharper research frontier, not a final abc
closure. A final claim requires either a kernel-checked inhabitant of a
non-circular proof bridge or a kernel-checked unbounded counterexample family.
