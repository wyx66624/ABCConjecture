# Root ordinary review of next NP and NG candidates

This record is outside the sealed publication at main 455c68d. Root actually
read the complete ordinary proofs NP1--NP4 and NG1--NG5, and the complete
standalone NG verifier. Both ordinary arguments PASS on their stated domains.
No new Lean proof or ABC conclusion is recorded here.

## NP1--NP4: retained pure squares

Reviewed source:
`../2026_09_07_critical_bottleneck/eighteenth_round/next_nonlinear_square_selectors.md`
SHA256 `a6ee6cc8de335702ec51c23efb6707b364008f153ccc1e43a8d25c433be43166`.

The actual square gives (9k^2-1,6k+1); its coordinate gcd divides three
and its first coordinate is a unit modulo three. The boundary factors into
the five displayed linear factors with distinct simple roots modulo every
prime greater than three. Their pairwise differences introduce only two and
three. The norm-unit assertion follows from primitive pairwise coprimality
and norm multiplicativity, including a prime dividing the sum arm.

Fixing one digit beyond each actual valuation preserves the whole boundary
valuation. Freezing all exceptional primes then leaves exactly five forbidden
classes modulo each remaining p^2. A squared prime divides one single linear
factor, so p is bounded by sqrt(C0 X), not by the square root of the full
degree-five boundary. This justifies the complete large-prime error in NP9.
Finite CRT densities and the tail prove the natural density, with lower
bound 1/6. The radical identity, both logarithmic limits and the explicit
constant in NP8 follow from the complete boundary, with no omitted credit.

The arbitrary finite packet and nonlinear construction are actual, but the
exponent is fixed at two, lambda=1/2, and all progression and content data
are fixed before the limit. Neither moving-packet uniformity nor coverage
of the original large-prime-exponent family follows. This is a positive
construction complementary to the affine intersection obstruction.

## NG1--NG5: actual divisor chains and a medium-prime barrier

Reviewed ordinary source:
`../2026_09_07_adversarial_audit/eighteenth_round/next_prime_chain_partition.md`
SHA256 `ff60c1c92642f6914e731d364fb62f50c22581ee7e0ab1b7bab412f8f5fea3e1`.

The inductive maximum-gap bound is correct for disjoint and overlapping
translated divisor spans. Each positive candidate gap between R_i and p_i
survives in the final radical, proving equality rather than just an upper
bound. The central interval argument then gives the stated sufficient class;
it does not identify a global maximum gap with the central gap.

For NG4, a divisor below rq containing q has remaining factor 1 or p and
lies at or below R/r. A divisor above R/r omitting q has complementary
factor 1 or p and lies at or above rq. The two exact inequalities therefore
prove consecutiveness for every divisor, and the product of the endpoints
is Q. This proves the central optimum and its stated asymmetric A,B formula.

The Gaussian plus-one primality criterion is sufficient: reduction at every
odd prime ell dividing the candidate gives a norm-one group of order ell-1
or ell+1. The witnesses force each full prime-power factor of m+1 to divide
that same group order, so ell is at least m. The candidate must be prime.
Different witnesses for different factors do not invalidate this argument.

Root actually ran the read-only verifier with --check. Result PASS:
47 proved prime nodes, 134 witnesses, 64 and 1024 complete divisor lists.
It uses no factorization oracle, probable-prime test or floating logarithm.
The exact successful nonsquare endpoint and the endpoint with
20 P^+(Q)<min(A,B), 0<D<1 and Gamma>2D both pass. These refute exactly the
claimed zero-gap and Gamma<=D strengthenings, not an estimate with an
arbitrary additive constant, an infinite-family assertion or ABC.

Verified files and SHA256:

* `next_replay_medium_partition.py`:
  `8d2293d9e68fad4cb2fb796689b3e98608bb5a38155b731325802083ed6fb279`
* `next_verification/medium_prime_lucas_certificate.json`:
  `728b162122cada8d4847f5153881d10847ace34e63997691b64d4775669f395e`
* `next_verification/medium_partition_exact.json`:
  `26d04f39748d763f5139794465afb78058f18474567b629f6937abcae2ec9af2`

All three paths above are relative to the reviewed adversarial eighteenth
round. Changes to any proof or verifier require rechecking this review.
