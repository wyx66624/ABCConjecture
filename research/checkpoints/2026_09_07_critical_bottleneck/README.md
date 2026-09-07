# Shared exponent generators and strict envelope improvement

Author: ChatGPT. Date: 2026-09-07.

This checkpoint does **not** prove or disprove standard ABC. It extends the
positive exponent-profile route with actual shared-factor representations,
ordinary analytic proofs, an exact finite replay, and a narrowly matched Lean
algebraic core recorded in the sibling `2026_09_07_overlap_formal` checkpoint.

## New ordinary mathematical results

- A nonnegative exponent matrix replaces disjoint exponent blocks. The same
  oriented split prime may occur in several generator columns. The exact norm
  budget and both existing logarithmic-form bounds continue to hold.
- For `e_i=g*f_i+r_i`, put `v=product pi_i^r_i`, `w=product pi_i^f_i`, and
  `rho=max(1,log N(v))*log(4+g)/g`. The two-column penalty is at most
  `A*rho*log c`. At cutoff `Y=rho^(-1/6)`, the full small-prime logarithmic mass
  is at most `(A/6)*sqrt(rho)*log(1/rho)*log c`.
- Small `rho` implies `min(a,b)>c^(1-eta)` without any radical or high-prime
  assumption. The same data imply `c<=R^(1+epsilon)` only with the explicitly
  retained signed-tail hypothesis `W_Y(T)<=g^B0`.
- On actual content-one profiles `e_i=g+i` with same-scale norm primes and
  `g=ceil(r^4*(log X)^2)`, **every** old disjoint partition has penalty at least
  `(log 4/8)*log M`, while the shared two-column penalty is `o(log c)`. This
  includes old partitions with a growing number of blocks. Thus the new
  representation strictly improves the entire preceding partition envelope,
  not just its bounded-block corollary.

No tail bound is proved for all triples or for the infinite separating family.
Prime-norm terminal cases remain outside the small-rho regime. No parent route
is retired by these results.

## Files

- `ordinary_proofs.md`: full ordinary derivation and dependency chain. The
  elementary reconstruction proof was supplied to the formalizing agent before
  the matching two-column formalization.
- `paper/shared_generators.tex`: complete proof text for insertion into the
  manuscript, with `sg-` labels and precise formal-scope boundaries.
- `replay.py`: deterministic integer-only verification.
- `verification/exact_results.json`: actual finite-run output.
- `verification/review.md`: independent agent review and source-check scope.

## Actual verification

Run from the repository root:

```sh
python research/checkpoints/2026_09_07_critical_bottleneck/replay.py
```

The completed run checked 240 shared matrix reconstructions, 66 quotient and
remainder reconstructions, 240 primitive-coordinate and cubic identities,
15,882 partition profiles, 63,435 block certificates, 9,924 largest-block
inequalities, and 1,000 elementary exponential inequalities. All use integers;
no floating-point test is used as an analytic proof.

Output SHA-256:

`43ac8ef532180043c6489827598a92b5d5586166c07b4f11a49d3920ccd89b8e`

The matching Lean signatures were independently read and checked against the
ordinary theorem. Actual compiler and axiom logs belong to the sibling formal
checkpoint. They verify finite reconstruction and norms in the actual integer
pair algebra, not Bugeaud's estimates, prime distribution, real asymptotics,
splitting classification, or the standard ABC theorem.

## Established external inputs

The exact two logarithmic-form inputs were checked directly in Bugeaud's
[`B'`](https://arxiv.org/html/2209.00275v1), Theorem 1.1 (1.2) and the **first**
inequality of Theorem 1.3. They do not impose multiplicative independence. The
conditional refinements later in Theorem 1.3 are not used.

Infinitude of same-scale split-prime lists uses only a standard fixed-modulus
prime distribution bound, checked in Bennett, Martin, O'Bryant, and Rechnitzer,
[`Explicit bounds for primes in arithmetic progressions`](https://arxiv.org/abs/1802.00085v3).
It supplies prime availability only; it is not assumed as a Lean axiom.
