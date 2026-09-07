# Independent review of the common-set large-cutoff signed bridge

Date: 2026-09-07. LC1--LC3 ordinary proof read in full: PASS.
Source: `2026_09_07_critical_bottleneck/eleventh_round/large_cutoff_signed_bridge.md`.
Reviewed SHA256:
`ff77c5f1abdf7fadc6e1581cac55d4edbebd41207af6935e02f3d6d4eaf18cfb`.

The set G_n is selected using only the actual full small-prime mass
L_Z(T)/t. Markov applied to the already reviewed EA/FM mean gives its
stated cardinality. Hence the set is independent of every subsequent
cap choice, and the finite RC inequality applies there simultaneously
to all root-dependent cap triples without a union bound.

On B=n^4, the angular estimate gives Delta/t<=4/n. The actual norm
bounds give log c1/t<=2/n and log T1/t<=3/n. The reciprocal assumption
implies Ccap>=3, while A<=6 and Bcap<=2 uniformly, including infinite
caps. Substituting these estimates into RC and retaining its exact
negative credits gives log W_Z(T)/t<=39/n+2*eta+E_Z/t. The signed
contribution below Z is at most L_Z(T), not an absolute value of that
contribution. This correctly yields the global signed bound with
39/n+3*eta. No small-prime radical term is accidentally added positively.

Since log T/t=3-Delta/t, solving the signed identity for log rad(T)/t
and replacing E_Z by its positive part gives exactly the coefficient
43/(3n), the eta term, and -E_Z_positive/(3t). All quantities here
use actual prime factorizations of the actual positive boundary product.

The cap-only result is uniform over roots and cap choices within the
common set. Its finite cap hypothesis annihilates the positive excess;
the unrestricted-arm radical credits remain nonpositive. The more
general positive-net-excess condition is correctly a condition on a
sequence of actual roots, not a uniform rate asserted for every choice.
The restricted epsilon conclusion c<=rad(T)^(1+epsilon) follows once
the lower radical ratio exceeds 1/(1+epsilon). Neither the cap-only
nor the sequence result proves that any fixed positive fraction of
G_n actually has the required membership. Exceptional roots and
bounded indices remain explicitly open.

The larger cutoff Z/B tends to infinity, so the tail condition tests
fewer primes than the earlier n^(1/6) condition on roots in this set.
This does not assert inclusion of every earlier root or replace a
pointwise result by a density result.

The TD comparison now has the correct domains. The published CRT
representatives satisfy a>=3(6n+1)^15 and cannot lie in B=n^4 for
eligible n>=5. Separately, whenever such a representative is compared
with a block a=3k, B<=k<2B, its selected q_i have
q_i^(s_i+1)<=a/3<2B, hence q_i<(2B)^(1/5). They lie below Z on
the present asymptotic scale if block membership is assumed. These
are conditional comparisons; neither is treated as a construction
inside G_n. The unselected factors remain uncontrolled. The existing
TD counterfamily therefore neither proves nor disproves this new
large-cutoff membership condition by its selected primes alone.

No mathematical correction is required. This is a new ordinary
combination of reviewed finite and analytic inputs; no new finite
experiment, Lean theorem, or ABC proof is claimed in this review.
