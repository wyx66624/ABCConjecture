# ABC multi-route research note v15: localization of high prime powers

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Purpose

The v13 power-free closure proves that every violation of the explicit strong
bound

\[
\log c\le \log\operatorname{rad}(abc)+\frac{\log2}{2}
\]

forces a prime cube in

\[
\max(a,b)c.
\]

This note removes the remaining ambiguity in that product statement. The two
large adjacent endpoints are coprime, so every prime-power obstruction is
supported on exactly one endpoint.

## 2. Coprimality of the large endpoints

Let

\[
M=\max(a,b).
\]

If `M=b`, primitive pairwise coprimality gives `gcd(b,c)=1`; if `M=a`, it
gives `gcd(a,c)=1`. Hence

\[
\boxed{\gcd(M,c)=1.}
\]

## 3. Prime-power localization

Let `p` be prime and `k>0`. If

\[
p^k\mid Mc,
\]

then the prime-power divisor theorem for coprime products yields

\[
\boxed{p^k\mid M\quad\text{or}\quad p^k\mid c.}
\]

The alternatives are mutually exclusive. Indeed, if both held, then `p`
would divide both `M` and `c`, contradicting their coprimality.

Thus

\[
\boxed{
p^k\mid Mc
\Longrightarrow
p^k\text{ occurs on exactly one of }M,c.
}
\]

## 4. Consequence for an abc violation

Combining the preceding result with v13 gives:

> If
> \[
> \log c>
> \log\operatorname{rad}(abc)+\frac{\log2}{2},
> \]
> then there exists a prime `p` for which `p^3` divides exactly one of
> `max(a,b)` and `c`.

This turns the residual endpoint problem into a one-integer concentration
problem rather than a product-support problem.

## 5. Limitation and next target

A single prime cube is not sufficient to contradict or prove abc; a fixed
cube can be absorbed into the additive constant. The next quantitative step
is therefore to decompose the complete cubeful excess into the two coprime
endpoints and prove that every violation forces conductor-scale excess on at
least one of them.

The Lean module is

```text
Lean/IUTThreeClosures/LargeEndpointPrimePowerLocalization.lean
```

with core declarations

```lean
ABCPoint.largeEndpoint_coprime_c
ABCPoint.prime_pow_dvd_largeEndpoint_or_c
ABCPoint.not_prime_pow_dvd_largeEndpoint_and_c
ABCPoint.prime_pow_dvd_exactly_one_largeEndpoint_or_c
ABCPoint.exists_prime_cube_on_exactly_one_largeEndpoint_of_strong_violation
```

This is an unconditional localization theorem, not a complete proof of the
abc conjecture.
