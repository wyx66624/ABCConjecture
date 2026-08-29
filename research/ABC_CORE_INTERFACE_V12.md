# ABC core-interface attack v12: balance localization and the near-neutral twist target

**Author:** ChatGPT  
**Date:** 2026-08-29  
**Status:** mathematical reductions proved before Lean formalization; no unconditional proof of `abc` is claimed.

## 1. Objective

The repository already contains several implications of the form

```text
missing arithmetic/geometric estimate -> ABCConjecture.
```

The purpose of this round is not to create another structure whose inhabitation
contains the desired estimate.  Instead, we attack two concrete interfaces and
prove exact scalar and arithmetic theorems which remove avoidable losses:

1. the loss from a coefficient-three estimate for `log(abc)` to the standard
   height `log c`;
2. the loss incurred when an almost-all estimate is transferred from a
   quadratic twist back to the original Frey curve.

The first theorem confines every remaining violation to an explicit endpoint
region.  The second identifies the exact size at which a good twist would
already close the slope-six Frey estimate.

## 2. Balance-sensitive symmetric-product theorem

Let

```text
a+b=c,
gcd(a,b)=gcd(b,c)=gcd(c,a)=1,
H = log c,
R = log rad(abc),
S = log(abc),
m = min(a,b).
```

### 2.1 Exact lower bound

Assume first that `a<=b`.  Then

```text
c=a+b<=2b,
```

and multiplication by the positive number `ac` gives

```text
a c^2 <= 2abc.
```

Since `m=a`, this is `m c^2<=2abc`.  The case `b<=a` is symmetric.  Therefore

\[
\boxed{m c^2\le 2abc.}
\tag{2.1}
\]

Taking logarithms gives

\[
\boxed{2H+\log m-\log2\le S.}
\tag{2.2}
\]

The earlier endpoint estimate `2H-log 2<=S` is the specialization `m>=1`.
Equation (2.2) retains the balance information that was previously discarded.

### 2.2 General transfer

Suppose

\[
S\le \lambda R+E
\tag{2.3}
\]

and, for some `delta<3`,

\[
\log m\ge(1-\delta)H-K.
\tag{2.4}
\]

Combining (2.2)--(2.4) gives

\[
(3-\delta)H\le \lambda R+E+K+\log2,
\]

hence

\[
\boxed{
H\le
\frac{\lambda R+E+K+\log2}{3-\delta}.
}
\tag{2.5}
\]

No conjecture enters this calculation.

### 2.3 Coefficient three closes the balanced region

Fix `epsilon>0` and take

\[
\delta=\frac{\epsilon}{1+\epsilon}.
\tag{2.6}
\]

If

\[
S\le(3+\epsilon)R+E,
\tag{2.7}
\]

and

\[
\log m\ge
\left(1-\frac{\epsilon}{1+\epsilon}\right)H-K,
\tag{2.8}
\]

with `E,K>=0`, then

\[
\boxed{
H\le(1+\epsilon)R+E+K+\log2.
}
\tag{2.9}
\]

Indeed, after multiplying the right side of (2.9) by `3-delta`, its conductor
coefficient is

\[
(3-\delta)(1+\epsilon)=3+2\epsilon\ge3+\epsilon,
\]

and its error coefficient is at least one.

The contrapositive is the useful localization theorem.  Under (2.7), every
triple violating (2.9) must satisfy

\[
\boxed{
\log\min(a,b)<
\left(1-\frac{\epsilon}{1+\epsilon}\right)\log c-K.
}
\tag{2.10}
\]

Thus a coefficient-three product theorem does not leave a diffuse global
problem.  It leaves a quantitatively endpoint-shaped problem.  This is the
correct place to concentrate the S-unit, smooth-neighbour and shifted-power
attacks.

## 3. Quadratic-twist distortion at the correct slope

Write a logarithmic auxiliary transformation as

\[
H'=H+\alpha D,\qquad N'=N+\beta D.
\]

A transformed estimate

\[
H'\le\lambda N'+C
\]

descends exactly to

\[
H\le\lambda N+(\lambda\beta-\alpha)D+C.
\tag{3.1}
\]

For a squarefree quadratic twist at new good primes, the nominal exponents are

\[
\alpha=6,\qquad\beta=2.
\]

Therefore the distortion is

\[
\boxed{2\lambda-6.}
\tag{3.2}
\]

The neutral slope is not six but three:

\[
2\lambda-6\le0\quad\Longleftrightarrow\quad\lambda\le3.
\tag{3.3}
\]

At slope `3+eta`, (3.1) is

\[
H\le(3+\eta)N+2\eta D+C.
\tag{3.4}
\]

Consequently, if a good twist can be found with

\[
D\le\frac{3N}{2\eta}+K,
\tag{3.5}
\]

then

\[
\boxed{
H\le(6+\eta)N+C+2\eta K.
}
\tag{3.6}
\]

Equation (3.6) is precisely the slope-six scale needed by the Frey route.
This sharpens the research target: an almost-all twist theorem is useful only
when its first good twist is bounded uniformly as in (3.5).  Density one with
a threshold depending arbitrarily on the original curve is insufficient.

## 4. What remains genuinely open after the reduction

The two theorems above do not insert a hidden version of `abc`.  They expose
where new arithmetic must enter.

### 4.1 Product/IUT/S-unit side

One must prove a coefficient-three product estimate from an independently
valid source and then treat the endpoint region (2.10).  In that region one
summand is polynomially smaller than `c`; the remaining core is a uniform
radical theorem for a short additive gap.  Fixed-support finiteness and
fixed-core Roth estimates do not yet provide the required uniformity as the
support and residual cores vary.

### 4.2 Frey/twist side

One must prove a relative exceptional-set theorem for the twist fibre which
produces a good twist before the bound (3.5).  An ambient almost-all theorem
cannot by itself do this, because an entire thin twist fibre may lie in the
ambient exceptional set.  The estimate must be uniform in the source Frey
curve.

## 5. Lean coverage

The following modules formalize the mathematics above without `sorry`,
`admit`, a new axiom, or a structure field containing the target estimate:

```text
IUTThreeClosures/SymmetricProductCoefficientBarrier.lean
IUTThreeClosures/BalanceSensitiveSymmetricProductReduction.lean
IUTThreeClosures/FreyAuxiliaryDistortionBarrier.lean
```

The exact theorem names include

```text
ABCPoint.minSummand_mul_c_sq_le_two_abc
ABCPoint.two_height_add_log_minSummand_sub_log_two_le_symmetricProductLog
height_le_of_product_bound_and_minSummand_growth
height_le_one_plus_epsilon_of_coefficient_three_and_balance
endpoint_of_product_bound_and_abc_failure
quadraticTwist_nonpositive_penalty_iff
quadraticTwist_descend_at_three_add
quadraticTwist_small_good_twist_gives_slope_six
```

The branch is eligible for `main` only after the kernel build and the
all-module audit both pass.  Passing these checks certifies the reductions; it
does not change the completion label of the full `abc` project.
