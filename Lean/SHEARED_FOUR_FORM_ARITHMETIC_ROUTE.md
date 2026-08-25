# Sheared four-form arithmetic: exact core and strict barriers

**Status.** Offline research note.  The determinant identities, primitive
counterexample families, three-square construction, radical inequalities,
and scalar coefficient transfer below are formalized in
`IUTThreeClosures/ShearedFourFormArithmetic.lean`.  No statement in that
module assumes a truncated SMT, a Subspace theorem, an S-unit height bound,
or `ABCConjecture`.  This note does not prove `abc`.

## 1. The target in arithmetic coordinates

Let

```text
a+b=c,       gcd(a,b,c)=1,       h=log c,
q=log rad(abc),                  D_u=|c-u a|.
```

The divisor obtained by restricting the two-coordinate shear
`(lambda,u lambda)` to its source curve is supported on the four linear
forms

```text
a, b, c, c-u a.
```

A coefficient strong enough for the surface argument has the arithmetic
shape

```text
(2-eta)h <= log rad(abc D_u)+O_u,eta(1).              (1.1)
```

The elementary upper bound

```text
log rad(D_u) <= log D_u <= h+log(u+1)                 (1.2)
```

then leaves

```text
(1-eta)h <= q+O_u,eta(1).                             (1.3)
```

Thus the required coefficient is exactly two before the new form is paid
for.  The Lean theorem `four_form_threshold_rearrangement` verifies this
coefficient calculation without storing (1.1) as an assumption in any
structure.

## 2. What the resultants really prove

Use the signed form

```text
d_u=c-u a.
```

For two parameters `u,v`, direct subtraction gives

```text
d_u-d_v=(v-u)a.                                       (2.1)
```

Consequently every common divisor of `d_u,d_v` divides `(v-u)a`.  Since
`gcd(a,c)=1`, also `gcd(a,d_u)=1`, and cancellation gives

```text
gcd(d_u,d_v) | |v-u|.                                 (2.2)
```

The overlaps with the old tripod are equally explicit:

```text
gcd(a,d_u)=1,
gcd(c,d_u) | u,
gcd(b,d_u) | u-1.                                    (2.3)
```

For example, a divisor of `c` and `d_u` divides `c-d_u=u a`; it is coprime
to `a`, so it divides `u`.  The proof for `b` uses
`b-d_u=(u-1)a`.  In particular, outside the fixed primes dividing
`u(u-1)`, the new support is disjoint from the old support.  Adjacent shears
are coprime:

```text
gcd(d_u,d_{u+1})=1.                                   (2.4)
```

These statements are genuine local-support progress.  They show that a new
prime is not charged twice.  They do **not** bound the exponent of that new
prime inside one `d_u`.  The Lean theorems
`commonDivisor_two_shears_dvd_resultant`,
`coprime_commonDivisor_two_shears_dvd_parameterDifference`,
`commonDivisor_a_shear_dvd_c`,
`commonDivisor_c_shear_dvd_u_mul_a`,
`commonDivisor_b_shear_dvd_u_sub_one_mul_a`, and
`isCoprime_adjacent_shears` formalize precisely this boundary.

## 3. One fixed shear: a strict constant-radical counterexample

Fix `u=v+1`.  For every `n>=0`, put

```text
a=1,
b=2^(n+1)+v,
c=2^(n+1)+v+1.
```

This is a positive primitive abc triple: `b,c` are consecutive and the
other entry is one.  But

```text
c-u a=2^(n+1),             rad(c-u a)=2.              (3.1)
```

At the same time `c -> infinity`.  Hence the following concrete proposal is
strictly false for every fixed `u`:

> There exist `delta>0,C` such that
> `log rad|c-u a| >= delta log c-C` for all primitive abc triples.

This is not an exceptional finite family and does not rely on an unproved
distribution assertion.  Lean verifies the primitive point, (3.1), and
unboundedness in `fixedShearPowerPoint_shear_radical` and
`fixedShearPowerPoint_unbounded`.

## 4. Two adjacent shears: pairwise coprimality still gives no gain

Fix any `u>=1`, let

```text
Q=2^(n+1),       A=Q-1,
a=A,
b=u A+1,
c=(u+1)A+1.
```

Again `a+b=c`, and

```text
gcd(a,b)=gcd(A,uA+1)=1,
```

which implies pairwise primitivity of the abc triple.  The two adjacent
forms are

```text
c-u a       =Q,
c-(u+1)a    =1.                                        (4.1)
```

Their radicals are simultaneously `2` and `1`, although `c` is unbounded.
Notice that this is fully compatible with (2.4): the two values are
coprime.  Therefore the assertion

> among two adjacent, resultant-separated shears, one new radical has a
> fixed positive height proportion

is strictly false.  The Lean theorem
`adjacentShearPowerPoint_two_constant_radicals` verifies (4.1) and the
radicals, while `adjacentShearPowerPoint_unbounded` rules out a finite-error
escape.

This counterexample retires every argument whose only inputs are the two
sizes and their coprimality/resultant.  It does not retire a theorem using
three or more values together with genuinely new arithmetic information.

## 5. Three adjacent shears can all be perfect squares

The next test is stronger.  Set `t=2k+4` and

```text
x=t^2+2t-1 = 4k^2+20k+23,
y=t^2+1    = 4k^2+16k+17,
z=t^2-2t-1 = 4k^2+12k+7.
```

Expansion gives the classical three-square progression

```text
x^2+z^2=2y^2.                                         (5.1)
```

Let

```text
A=x^2-y^2,
a=A,
b=x^2+A,
c=x^2+2A.
```

The point is primitive.  Indeed, `x-y=2(t-1)`.  Both `x` and `t-1` are odd,
and reducing `x` modulo `t-1` gives `2`; hence `gcd(x,y)=1`.  Therefore

```text
gcd(A,x)=gcd(x^2-y^2,x)=1,
```

and then `gcd(A,x^2+A)=1`; the equality `a+b=c` gives the other two pairwise
coprimalities.

Using (5.1), the three consecutive shears are exactly

```text
c-2a=x^2,
c-3a=y^2,
c-4a=z^2.                                             (5.2)
```

Thus every one of the three new radicals is at most the square root of its
form.  There is a strict integral formulation.  For every proposed constant
`C`, choose `k>C`.  Since `rad(w^2)<=w`, simultaneously for
`w=x,y,z` one has

```text
C rad(w^2)^3 < w^4=(w^2)^2.                           (5.3)
```

So no uniform lower bound of exponent `2/3` for at least one of the three
shears follows from their resultants.  Lean verifies (5.1), primitivity,
(5.2), the square-root radical bounds, and the simultaneous strict
counterexample (5.3) in
`threeSquareShearPoint_simultaneous_two_thirds_counterexample`.

This does not disprove an estimate involving the old radical `rad(abc)`;
in this family that old radical can be large.  It precisely disproves the
attempt to manufacture the missing coefficient solely from the new forms.

## 6. The quadratic identity exposes the circular core

There is an exact identity for every `u`:

```text
(u-1)a^2 + c(c-u a) = b(c-(u-1)a).                    (6.1)
```

It follows by substituting `b=c-a` and expanding.  At `u=2`, this becomes

```text
a^2+c(c-2a)=b^2.                                      (6.2)
```

When `c-2a` is positive, (6.2) is an abc equation whose radical is supported
on exactly

```text
a, b, c, c-2a.
```

Its natural height is quadratic in `c`, which is why an abc estimate applied
to (6.2) would produce the desired coefficient two in (1.1).  But that use
is circular: it applies the missing conjecture to a quadratic re-encoding of
the original point.  For negative `c-2a`, moving the negative term to the
other side gives the same conclusion.  Lean verifies (6.1)--(6.2) in
`adjacent_shear_quadratic_identity` and
`shear_two_difference_of_squares`.

This identity is also a useful audit test for any proposed proof.  If its
decisive input is an unproved radical bound for the three terms of (6.2),
then the input has not escaped the abc core.

## 7. Audit of the suggested standard tools

### Fixed-support S-unit theory

For fixed support `S`, (6.1) or the linear relation among the shears can be
treated by S-unit methods.  Here

```text
S=supp(abc D_u)
```

varies with the point.  A constant depending on this `S` cannot be absorbed
into `C_epsilon`.  Neither the resultant formulas nor the counterexample
families make that dependence uniform.

### gcd and resultant estimates

Equations (2.1)--(2.4) are the complete pairwise resultant information.
Sections 3--5 give strict counterexamples to upgrading that information to a
positive radical exponent for one, two, or three fixed consecutive shears.
This route is therefore retired **only in its resultant-only form**.

### Large sieve or squarefree sieve

A sieve can exploit the fact that, away from primes dividing parameter
differences, a prime divides at most one shear.  For a fixed set of two or
three candidates, Sections 4--5 show that this local exclusion is not enough.
A genuinely growing candidate set is not refuted by those families and is
not discarded.  To be useful, however, it must prove a worst-case theorem
uniform in the progression `(c-u a)`, not merely a density statement after
averaging over `a,c`; and every growth term `log u` must remain visible in the
height and boundary estimates.

### Subspace theorem

The finite-dimensional Subspace theorem controls multiplicative proximity
to fixed forms outside exceptional subspaces.  It does not replace
`v_p(d_u)` by the level-one indicator `1_{p|d_u}` at a prime set which varies
with the point.  In the present coordinates, a theorem that supplied the
missing level-one coefficient would prove (1.1), and hence (1.3).  Calling it
"structure-sensitive nondegeneracy" would only rename the target.

## 8. Surviving core targets

The following possibilities have not been disproved here:

1. A new variable-prime truncation theorem proving (1.1) directly, with a
   point-uniform constant and a fully described exceptional set.
2. A quantitative theorem for a candidate set whose size grows with the
   point, provided the cost of `u`, exceptional-set avoidance, and the sieve
   constants is proved to be `o(h)` rather than hidden.
3. A cancellation theorem for the quadratic identity (6.1) which uses more
   than its radical support and is demonstrably weaker than applying abc to
   that identity.

The exact unresolved statement remains the coefficient-two, level-one
inequality (1.1).  The new result is a sharper boundary: fixed-shear radical
gain, two-shear resultant gain, and a `2/3` gain from three consecutive
resultant-separated shears are now strictly false, while the genuine
variable-prime truncation problem remains open.
