# Independent cross-review of shared exponent generators

Reviewer: `independent_route` research agent, 2026-09-07.
Reviewed manuscript:
`research/checkpoints/2026_09_07_critical_bottleneck/ordinary_proofs.md`.
Comparison source:
`research/checkpoints/2026_09_06_exponent_profiles/paper/body.tex`.

## Verdict

The shared-generator extension, quotient-remainder compression, unconditional
balance theorem, tail-conditional ABC class, and the strict separation from
**every** old disjoint partition pass this independent mathematical review.
The result is restricted positive progress, not a global ABC estimate or a
formal proof of the external analytic inputs.

## Specific checks

1. Sharing the same oriented split prime factor between two generators does
   not introduce its conjugate into either. Each nonempty column therefore
   still gives `eta_j != 1`. The height inequality only needs integrality and
   the two equal complex absolute values, not coprimality between columns.
2. Since every column norm divides the full norm and `gcd(M,abc)=1`, all
   generators and their conjugates remain units at every place over a prime
   dividing `abc`. Shared columns do not change this premise.
3. The complex logarithmic-form input and the first p-adic input require
   neither multiplicative independence nor disjoint columns. Their constants
   are bounded by a degree-dependent constant raised to the number of inputs.
   The later conditional refinement of the p-adic theorem is not used.
4. I flagged the initially omitted `m >= 1` boundary: an empty representation
   otherwise permits the exceptional triple `(1,1,2)` and fails the invoked
   `m+1 >= 2` premise. The author repaired the definition and handles that
   trivial triple separately.
5. For `e_i=g f_i+r_i`, the norm budget gives `g log Q <= 2 log c`. Both the
   two-column case and the unit-remainder case give `B <= A rho log c`.
   The choice `Y=rho^(-1/6)` yields the stated square-root-rho small-prime
   estimate. The unconditional balance contradiction uses the independently
   valid `log c >= g log(7)/2`, and its threshold is uniform.
6. The tail hypothesis remains explicit in the ABC class. The division by
   `log c` and the threshold `3 epsilon/(1+epsilon)` produce the stated
   exponent without a hidden norm-prime dependence.
7. The stronger Theorem 6 uses comparable norm primes and
   `g=ceil(r^4 (log X)^2)`. The new two-generator penalty is sublinear
   uniformly in `log X >= log 7`. For every old partition, the two cases
   `m <= r/2` and `m > r/2` cover all possible block counts, including counts
   growing with `r`. The largest-block gcd argument in the first case and the
   exponential-in-m lower bound in the second prove the claimed uniform
   linear lower bound for the old **explicit penalty objective**. They do not
   claim a lower bound on the true angular defect.

## Independently opened primary sources

- Bugeaud, *B prime*, arXiv:2209.00275v1, Theorem 1.1 equation (1.2) and
  Theorem 1.3 first inequality:
  <https://arxiv.org/html/2209.00275v1>.
- Bennett--Martin--O'Bryant--Rechnitzer, *Explicit bounds for primes in
  arithmetic progressions*, arXiv:1802.00085v3, Theorem 1.2 and equations
  (1.10)--(1.11): <https://arxiv.org/html/1802.00085v3> and
  <https://arxiv.org/pdf/1802.00085v3>.

The second source gives the stated weaker `1/160` bound (in fact its displayed
uniform constant is stronger for modulus three), so the dyadic prime-count
lower bound used solely for availability is valid.

This is review by a separate research agent. It is not external journal peer
review, and it does not kernel-check the geometry-of-numbers, logarithmic-form,
prime-distribution, or limiting arguments.
