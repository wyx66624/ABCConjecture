# ABC multi-route research note v13: power-free closure on the large endpoints

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Purpose

The endpoint-balance transfer reduces any unresolved coefficient-three
product route to triples in which the smaller summand is substantially below
`c`.  This note attacks that endpoint locus directly by examining the two
large adjacent integers

\[
M=\max(a,b),\qquad c=M+\min(a,b).
\]

The result is unconditional: if `Mc` is cube-free, the coefficient-one abc
bound already holds with an explicit absolute constant.  Therefore every
remaining violation must contain a prime cube in the product of the two large
adjacent endpoints.

## 2. Exponent caps and radical expansion

For `k>=0`, say that `n` has exponent cap `k` when

\[
v_p(n)\le k
\]

for every prime `p`.  Unique factorization gives

\[
n\mid \operatorname{rad}(n)^k,
\]

hence

\[
n\le \operatorname{rad}(n)^k.
\]

Conversely, if a nonzero `n` does not have exponent cap `k`, there is a prime
`p` such that

\[
p^{k+1}\mid n.
\]

The Lean module proves both directions directly from `Nat.factorization`; no
power-free distribution theorem is assumed.

## 3. The two-large-endpoint estimate

Let `(a,b,c)` be a positive primitive abc point and set `M=max(a,b)`.  Since
`a+b=c`,

\[
c\le2M,
\]

and therefore

\[
c^2\le2Mc.
\]

Moreover `Mc` divides `abc`, so radical monotonicity gives

\[
\operatorname{rad}(Mc)\le\operatorname{rad}(abc).
\]

If `Mc` has exponent cap `k`, then

\[
Mc\le\operatorname{rad}(Mc)^k
\le\operatorname{rad}(abc)^k.
\]

Combining the inequalities yields

\[
\boxed{c^2\le2\operatorname{rad}(abc)^k}.
\]

Taking logarithms gives the exact height estimate

\[
\boxed{
2\log c\le\log2+k\log\operatorname{rad}(abc)
}
\]

or

\[
\boxed{
\log c\le
\frac{k}{2}\log\operatorname{rad}(abc)+\frac{\log2}{2}.
}
\]

## 4. Cube-free closure

At `k=2`:

\[
\boxed{
\log c\le
\log\operatorname{rad}(abc)+\frac{\log2}{2}.
}
\]

Thus every primitive abc triple for which

\[
\max(a,b)c
\]

is cube-free satisfies a strong coefficient-one abc inequality with the
explicit constant `log(2)/2`.

The contrapositive is equally concrete.  If

\[
\log c>
\log\operatorname{rad}(abc)+\frac{\log2}{2},
\]

then there exists a prime `p` such that

\[
\boxed{p^3\mid \max(a,b)c.}
\]

Because `max(a,b)` and `c` are coprime, the cube is supported on exactly one
of the two large adjacent endpoints.  The Lean module formalizes the product
statement; splitting it between the coprime factors is a subsequent local
refinement rather than an input to the closure theorem.

## 5. Consequence for the endpoint route

The unresolved endpoint locus is now much narrower than “short gap” alone.
Any sufficiently strong counterexample must combine both:

1. endpoint degeneration, forced by the coefficient-three balance transfer;
2. an actual prime-cube concentration in one of the two large adjacent
   endpoints, forced by the present theorem.

Hence an endpoint proof can concentrate on controlling cubeful mass in
coprime short-interval pairs.  A counterexample construction must instead
produce an unbounded short-gap family with enough repeated-prime mass on the
large endpoints to defeat the explicit cube-free closure.

## 6. Lean deliverable

The corresponding module is

```text
Lean/IUTThreeClosures/LargeEndpointPowerFreeClosure.lean
```

Its core declarations are:

```lean
IsExponentAtMost.dvd_radical_pow
IsExponentAtMost.le_radical_pow
IsExponentAtMost.exists_prime_pow_succ_dvd_of_not
ABCPoint.c_sq_le_two_abcRadical_pow
ABCPoint.two_mul_height_le_log_two_add_k_mul_conductor
ABCPoint.height_le_conductor_add_log_two_div_two_of_cubeFreeLargeProduct
ABCPoint.exists_prime_cube_dvd_largeProduct_of_strong_violation
```

The result is an unconditional partial abc theorem, not a parameter-free proof
of the full conjecture.
