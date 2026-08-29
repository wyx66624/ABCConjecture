# Prime-power exceptional exponent threshold and a centre-wise mean-square target

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** unconditional reduction and obstruction; not a proof or disproof of the abc conjecture

## 1. Purpose

The smooth-neighbour counterexample program has two logically different ways to obtain a useful integer immediately after a prime power `p^k`:

1. prove a theorem directly at prime-power centres;
2. prove an ambient almost-all theorem and transfer it to the sparse prime-power locus.

The second strategy is often invoked too quickly. This note computes the exact power-saving threshold that a direct cardinality transfer must cross, compares it with the quantitative exceptional bounds available in current short-interval results, and proposes a centre-wise mean-square statement that avoids the loss.

The main conclusion is:

> For fixed `k`, an exceptional estimate of the form `O(X^(1-delta))` can force a good centre among `p^k in [X,2X]` by cardinality only if
> 
> `delta > 1 - 1/k`.
>
> In the square-root low-radical route, the density barrier already forces `k >= 5`; hence such an ambient transfer needs `delta > 4/5`.

This is far stronger than an `o(X)` estimate or any fixed logarithmic saving.

## 2. Prime-power centres

Fix an integer `k >= 2` and define

`C_k(X) = { p^k : p prime and X <= p^k <= 2X }`.

The prime number theorem gives

`#C_k(X) = pi((2X)^(1/k)) - pi(X^(1/k))`

and therefore

`#C_k(X) asymp_k X^(1/k) / log X`.

At power-exponent level the centre family has exponent

`sigma_k = 1/k`.

Suppose an ambient theorem produces an exceptional set `E(X)` with

`#E(X) <= C X^(1-delta)`.

A sufficient direct-transfer condition is

`#(E(X) intersect C_k(X)) < #C_k(X)`.

The ambient bound alone implies this for large `X` when

`1 - delta < 1/k`,

or equivalently

`delta > 1 - 1/k`.

The inequality must be strict. At equality, an `O(X^(1/k))` exceptional bound is still larger than the expected `X^(1/k)/log X` centre count and can contain every prime-power centre.

The finite theorem behind this observation is elementary but decisive. If a numerical exceptional cap is at least the number of centres, the model `exceptional = centres` satisfies the cap. Conversely, a cap strictly below the centre count, together with coverage of every failure, forces a good centre. Both statements are formalized in `PrimePowerExceptionalExponentThreshold.lean`.

## 3. Combination with the square-root low-radical barrier

For a neighbour construction

`c = p^k + a`,

with gap exponent `theta`, prime-power radical exponent `1/k`, and neighbour-radical exponent `beta`, the abc-disproof slope is

`theta + 1/k + beta`.

The all-interval smooth-number input naturally gives `theta = 1/2 + o(1)`. The low-radical density audit proved that a theorem covering a positive-density/all-primes family forces

`beta >= 1/k`.

Subcriticality then requires

`1/2 + 2/k < 1`,

so `k > 4`. Thus the first feasible exponent is `k = 5`.

For every `k >= 5`, the direct-transfer threshold is

`1 - 1/k >= 4/5`.

Consequently a route that combines

- an ambient almost-all theorem,
- direct cardinality transfer,
- square-root gaps,
- and positive-density/all-primes coverage

must prove an exceptional-set power saving strictly larger than `4/5`. Equivalently, the exceptional set must have cardinality `O(X^gamma)` for some `gamma < 1/5` in the fifth-power case. This is a much more severe requirement than merely showing that the exceptional set is `o(X)`.

## 4. Audit of Jain's smooth-number theorem

Sarvagya Jain, *Smooth Numbers in Short Intervals*, arXiv:2502.10530, proves that for

`y >= exp(C (log X)^(2/3) (log log X)^(4/3))`

and a specified subexponential interval length, `[x,x+h]` contains a `y`-smooth number for almost all `x in [X,2X]`. In the proof of Theorem 1.1, the exceptional set is bounded by

`|E| <<_eps X (rho(u-v) / log X)^(eps/4)`,

where `u = log X / log y`, and Lemma 4.1 permits `rho(u-v)` and `rho(u)` to be interchanged up to constants in the relevant estimates.

In the theorem's full smoothness range,

`u <= O((log X)^(1/3) / (log log X)^(4/3))`.

The Dickman asymptotic

`-log rho(u) = (1+o(1)) u (log u + log log u - 1)`

then gives

`-log rho(u) = o(log X)`.

Hence

`rho(u-v) = X^(-o(1))`

and the displayed exceptional cap has size

`X^(1-o(1))`.

For every fixed `k`, this cap is much larger than

`#C_k(X) = X^(1/k-o(1))`.

This does **not** show that all prime powers are exceptional. It shows that the published ambient estimate, by itself, cannot exclude that possibility and therefore cannot be inserted into the sparse-transfer gate.

There is an additional real-versus-discrete issue: an almost-all theorem is initially a Lebesgue-measure statement in the centre variable. A bad discrete centre must first be thickened to a positive-measure bad cell, usually by shortening the interval by a bounded buffer. Even granting an optimal unit-cell conversion, the exponent comparison above still fails.

## 5. Audit of current multiplicative-function mean squares

A recent result of T. Menon, *Improved bounds for multiplicative functions in almost all short intervals*, arXiv:2607.15574, proves for suitable 1-bounded multiplicative functions supported on smooth numbers a normalized second-moment estimate of the form

`exp(-(2-o(1)) M(f;X))`

`+ (log log h)^2 / (log h)^2`

`+ 1 / (log X)^(2-o(1))`.

Even when the pretentious-distance term is negligible, Chebyshev's inequality at a fixed relative threshold yields only a logarithmic exceptional saving, of order

`X / (log X)^(2-o(1))`

at square-root scale. This is again `X^(1-o(1))`, so it cannot force a hit on any fixed prime-power family by direct cardinality transfer.

Moreover, the positive tilted weights needed for low-omega extraction are not automatically nonpretentious, and an upper/cancellation estimate is not a lower main-term estimate. Thus this theorem is not presently a replacement for the missing tilted short-interval lower bound.

## 6. The correct centre-wise analytic target

The loss comes from first proving a statement on `X` ambient centres and only afterwards specializing to roughly `X^(1/k)/log X` prime-power centres. A more efficient target is to average directly over those centres.

Let `P = X^(1/k)` and let `W_h(p)` denote a nonnegative tilted smooth-number mass in

`[p^k, p^k+h]`.

Let `W_H(p)` be a longer local reference average for which a uniform lower bound

`W_H(p) >= mu_X > 0`

is available. It is enough to prove

`sum_{p in [P,2^(1/k)P]} |W_h(p)-W_H(p)|^2`

`< pi_k(X) mu_X^2`,

where `pi_k(X)` denotes the number of relevant prime centres. Then at least one prime `p` satisfies

`|W_h(p)-W_H(p)| < mu_X`,

and therefore `W_h(p) > 0`.

This deterministic implication is formalized in `PrimePowerCenteredMeanSquareGate.lean`.

A plausible analytic implementation would replace the ambient integral in the usual Parseval reduction by a discrete prime-power-centred second moment. Mellin inversion introduces phases `p^(ikt)`, so the new input becomes a hybrid estimate involving

- the factored Dirichlet polynomial used to detect smooth/low-omega integers, and
- a prime Dirichlet polynomial evaluated at frequency `k t`.

The required estimate is relative to the number of prime centres from the start, so it avoids the `delta > 1-1/k` ambient-transfer tax. Proving it remains a substantial analytic-number-theory problem; the repository does not claim it as an established theorem.

## 7. Exact remaining alternatives

The smooth-neighbour route can now close only through one of the following genuinely stronger inputs:

1. **Direct prime-power-centred theorem.** Prove a tilted smooth/low-radical lower bound at infinitely many `p^k` centres.
2. **Centre-wise relative mean square.** Prove the discrete estimate in Section 6 with error `o(#C_k(X) mu_X^2)`.
3. **Very strong ambient exceptional bound.** Prove `#E(X) = o(X^(1/k)/log X)`; for the dense square-root route this means a saving exceeding `4/5`.
4. **Source-dependent fibre amplification.** Attach enough controlled candidates to each prime-power source that the exceptional fibre is strictly smaller than its candidate fibre.
5. **All-interval low-radical theorem.** Directly produce a neighbour with radical exponent `beta < 1/2 - 1/k`; the density obstruction shows this can only begin at `k >= 5` for dense/all-primes coverage.

## 8. Lean trust boundary

The accompanying Lean files contain only:

- finite cardinality extraction and countermodels;
- exact real exponent arithmetic;
- the combination with the already formalized square-root density barrier;
- a finite centre-wise mean-square extraction theorem.

They do not assume the prime number theorem, the Dickman asymptotic, Jain's theorem, Menon's theorem, an IUT source object, a modified-Szpiro estimate, or the abc conjecture.

The mathematical conclusion of this note is therefore a rigorous narrowing of the research target, not an unconditional proof or disproof of abc.
