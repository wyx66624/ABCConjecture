# ABC multi-route research note v16: exact compensated cubeful excess

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. The remaining integer inequality

For a positive primitive abc point, let

\[
M=\max(a,b),\qquad n=Mc,
\]

and write

\[
R_n=\operatorname{rad}(n),
\qquad
R=\operatorname{rad}(abc).
\]

Because `n` divides `abc`, its radical divides the full radical.  Define the
exact omitted radical quotient

\[
E=\frac{R}{R_n}.
\]

For a primitive abc point this is the radical contribution of the smaller
summand; the formal theorem only needs the divisibility and therefore does not
hide a coprimality-dependent simplification.

Recall the two exponent-layer factors

\[
Q_+(n)=\frac{n}{\gcd(n,R_n^2)},
\qquad
L(n)=\frac{R_n^2}{\gcd(n,R_n^2)}.
\]

They satisfy

\[
nL(n)=R_n^2Q_+(n).
\]

## 2. Exact coefficient-one compensation criterion

Assume

\[
\boxed{
Q_+(n)\le L(n)E^2.
}
\]

Multiplying by `R_n^2` and using the decomposition gives

\[
nL(n)
=R_n^2Q_+(n)
\le R_n^2L(n)E^2
=R^2L(n).
\]

Since `L(n)>0`, cancellation yields

\[
\boxed{n\le R^2.}
\]

The large-endpoint inequality

\[
c^2\le2Mc=2n
\]

then gives

\[
c^2\le2R^2,
\]

and hence

\[
\boxed{
\log c\le
\log R+\frac{\log2}{2}.
}
\]

Thus the full coefficient-one abc estimate already holds whenever the positive
exponent-above-two mass on the two large endpoints is compensated by

1. their exponent-one factor `L(n)`; and
2. the square of the omitted radical contribution `E`.

This strictly extends the cube-free and signed-nonpositive regions.

## 3. Exact obstruction in every remaining violation

The contrapositive is unconditional.  If

\[
\log c>
\log R+\frac{\log2}{2},
\]

then

\[
\boxed{
L(n)E^2<Q_+(n).
}
\]

Consequently a difficult abc point must have more multiplicative mass in prime
exponents above two on `Mc` than is supplied jointly by all exponent-one
primes on `Mc` and two copies of the radical outside `Mc`.

This is much sharper than the statement “some prime cube divides a large
endpoint”.  A fixed cube, or even finitely many bounded repeated primes, cannot
satisfy the required strict imbalance at arbitrarily large quality.

## 4. Remaining quantitative theorem

The full abc conjecture asks for the epsilon-relaxed form

\[
\log Q_+(n)-\log L(n)-2\log E
\le
2\epsilon\log R+O_\epsilon(1).
\]

The v16 coefficient-one theorem proves the entire nonpositive region exactly.
The unresolved set therefore consists only of points with genuinely positive
uncompensated exponent-layer mass.  Future work can concentrate on proving
that this positive mass cannot retain a fixed conductor slope along an
unbounded short-gap family.

## 5. Lean formalization

The module

```text
Lean/IUTThreeClosures/LargeEndpointCompensatedExcess.lean
```

formalizes:

```lean
ABCPoint.largeEndpointProductRadical_dvd_abcRadical
ABCPoint.largeEndpointProductRadical_mul_externalRadicalQuotient
ABCPoint.largeEndpoint_mul_c_le_abcRadical_sq_of_compensatedExcess
ABCPoint.height_le_conductor_add_log_two_div_two_of_compensatedExcess
ABCPoint.compensatedExcess_strict_of_strong_violation
```

The targeted module and the complete pinned Lean project were both built
locally before submission.  No `axiom`, `sorry`, or `admit` is introduced.

This is an unconditional partial closure and an exact obstruction theorem, not
a claim that the positive uncompensated region has already been eliminated.
