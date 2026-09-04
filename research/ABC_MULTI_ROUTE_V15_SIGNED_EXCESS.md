# ABC multi-route research note v15: exact signed exponent-two excess

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Correction of the positive-only target

The v14 cubeful excess

\[
Q_+(n)=\frac{n}{\gcd(n,\operatorname{rad}(n)^2)}
\]

records precisely the prime-exponent mass above two.  It gives a useful
sufficient criterion, but it is not the exact remaining quantity: a prime
occurring once contributes negatively to

\[
\log n-2\log\operatorname{rad}(n),
\]

and that negative mass was discarded by `Q_+`.

Define the compensating exponent-one factor

\[
L(n)=
\frac{\operatorname{rad}(n)^2}
     {\gcd(n,\operatorname{rad}(n)^2)}.
\]

Primewise,

\[
v_p(Q_+(n))=\max(v_p(n)-2,0),
\]

while

\[
v_p(L(n))=
\begin{cases}
1,&v_p(n)=1,\\
0,&v_p(n)\ne1.
\end{cases}
\]

The exact integral identity is

\[
\boxed{
 nL(n)=\operatorname{rad}(n)^2Q_+(n).
}
\]

Therefore

\[
\boxed{
\log n-2\log\operatorname{rad}(n)
=
\log Q_+(n)-\log L(n).
}
\]

This is the signed exponent-two excess: exponent-one primes are negative,
exponent-two primes are neutral, and exponents at least three are positive.

## 2. Exact large-endpoint corridor

For a positive primitive abc point, put

\[
M=\max(a,b),\qquad m=\min(a,b),\qquad a+b=c.
\]

The elementary inequalities

\[
M\le c\le2M
\]

give

\[
Mc\le c^2\le2Mc.
\]

Let

\[
h=\log c,\qquad
R=\log\operatorname{rad}(abc),
\]

and define

\[
\Sigma(P)=\log(Mc)-2R.
\]

Taking logarithms of the two product inequalities yields the exact corridor

\[
\boxed{
\Sigma(P)\le2h-2R\le\Sigma(P)+\log2.
}
\]

Thus the signed excess on the two large adjacent endpoints differs from twice
the usual logarithmic abc quality by at most one absolute constant.

## 3. Exact equivalence with abc

Define the uniform signed-excess statement:

> for every `epsilon>0` there is `K_epsilon`, chosen before the abc point,
> such that
> \[
> \Sigma(P)\le2\epsilon R+K_\epsilon
> \]
> for every positive primitive abc point.

The corridor proves both directions.

### Signed excess implies abc

If

\[
\Sigma(P)\le2\epsilon R+K_\epsilon,
\]

then

\[
2h-2R\le2\epsilon R+K_\epsilon+\log2,
\]

hence

\[
\boxed{
h\le(1+\epsilon)R+
\frac{K_\epsilon+\log2}{2}.
}
\]

### ABC implies signed excess

Conversely, if

\[
h\le(1+\epsilon)R+C_\epsilon,
\]

then

\[
\Sigma(P)\le2h-2R
\le2\epsilon R+2C_\epsilon.
\]

Consequently

\[
\boxed{
\text{Uniform signed exponent-two excess}
\quad\Longleftrightarrow\quad
\text{ABCConjecture}.
}
\]

Unlike an arbitrary bridge record, the left side is an explicit elementary
function of the prime exponents of the original three integers.

## 4. The remaining arithmetic statement in prime-exponent form

Because `M`, `c`, and `m` are pairwise coprime, the remaining inequality can be
read as

\[
\sum_{p\mid Mc}(v_p(Mc)-2)\log p
-2\log\operatorname{rad}(m)
\le
2\epsilon\log\operatorname{rad}(abc)+O_\epsilon(1).
\]

Equivalently, the mass of exponents at least three on the two large adjacent
endpoints must be dominated by

1. the exponent-one support on those endpoints;
2. twice the radical mass of the small endpoint;
3. an arbitrarily small conductor-proportional allowance.

Any counterexample family must violate this domination by a fixed positive
conductor slope.  A single cube or a bounded collection of repeated primes is
not enough.

## 5. Immediate structural consequence for any counterexample

If

\[
h>(1+\epsilon)R+C,
\]

then

\[
\Sigma(P)>2\epsilon R+2C-\log2.
\]

Since

\[
\log M+\log c\ge2h-\log2,
\]

a high-quality counterexample forces the average radical exponent of the two
large endpoints above the exponent-two threshold.  In particular, at least
one of `M` and `c` must have radical strictly below its square-root scale by a
positive conductor-proportional margin after the exponent-one compensation is
included.  This is substantially stronger than merely requiring one prime
cube.

## 6. Lean formalization

The module

```text
Lean/IUTThreeClosures/LargeEndpointSignedExcess.lean
```

kernel-formalizes:

```lean
squarefreeDeficit_pos
mul_squarefreeDeficit_eq_radical_sq_mul_cubefulExcess
log_add_log_squarefreeDeficit_eq_two_log_radical_add_log_cubefulExcess
ABCPoint.largeEndpoint_mul_c_le_c_sq
ABCPoint.largeEndpointSignedExcess_le_two_height_sub_two_conductor
ABCPoint.two_height_sub_two_conductor_le_largeEndpointSignedExcess_add_log_two
abc_of_uniformLargeEndpointSignedExcessBound
uniformLargeEndpointSignedExcessBound_of_abc
uniformLargeEndpointSignedExcessBound_iff_abc
```

The module contains no `axiom`, `sorry`, or `admit`.

## 7. Concentrated next attack

The next positive theorem is no longer an abstract height interface.  It is the
following explicit short-gap exponent theorem:

> for coprime `M` and `c=M+m`, prove that the signed exponent-two excess of
> `Mc`, after subtracting twice the radical of `m`, is
> `o(log rad(Mmc))` uniformly.

The proof program now splits by exponent layers:

- exponent one supplies the compensating factor `L(Mc)`;
- exponent two is neutral;
- exponent at least three is the only genuinely dangerous layer;
- the endpoint-balance theorem restricts unresolved points to power-saving
  gaps, so the remaining problem is a short-interval concentration theorem
  for this positive layer.

This note records an exact reduction, not a claim that the final uniform
short-gap estimate has already been proved.
