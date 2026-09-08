# Independent full ordinary review of PA1--PA3

2026-09-07. Next-only review, outside the frozen publication inventory.

Reviewed the complete
`2026_09_07_adversarial_audit/eighteenth_round/next_paired_packet_certificate.md`,
SHA256 `1d0e7c40efb39ce1f2440af34b8a536a45dfaed70dd80f7341b236dbf6f4ff3c`.
**Full ordinary PASS.**

PA1 uses actual disjoint factors of the squarefree radical, so every
restricted divisor and its complementary packet use each prime exactly
once. The subset sums of positive log ratios have largest adjacent gap at
most the largest individual ratio logarithm; the union-of-two-translates
proof includes both overlap and nonoverlap. The two endpoint assumptions
make the central interval intersect their span. If no endpoint or subset
sum is already central, the interval lies inside one actual restricted
gap, whose two distances sum to at most log rho-D. This gives the stated
half-gap penalty and the exact cost inequality with the original rules.

PA2's example uses the earlier completely certified actual radical. I
independently executed the three displayed integer comparisons and the
full factorization equality for 2^41*3^26-1; all four passed. This is only
a small additional exact arithmetic check, not a new primality proof or a
claim about an infinite family. The comparison with the global Lambda
test is accurate: a local, well-placed pair can succeed even when the
largest gap elsewhere is too large. Both hypotheses in the stated
asymptotic gate remain explicit, including the restricted scalar ABC
quantity D itself.

For PA3, all divisors containing q below dq are at most qt<=R/d. A divisor
omitting q above R/d has complementary divisor in R strictly below d,
so it is at least R/t>=dq. The strict R<d^2q orders the two endpoints,
and their product is Q. Thus the stated adjacent-divisor penalty is exact.
For the prime-prefix specialization, every divisor below d uses only
primes below d, and their complete product T is itself below d; hence
t=T exactly. These statements do not infer a universal supply of paired
packets from a largest-prime bound and do not change the original cost.

No publication change, new Lean theorem, or infinite counterexample is
claimed by this review.

## Strengthened constructive version

I subsequently re-read the complete revised PA note, SHA256
`1c299478c53ba9bbb8288c46fc48775ef0856646de9b931fbf0ed11c5ba26be6`.
The replacement of subset-sum enumeration by the monotone chain of m+1
actual divisors is correct and stronger algorithmically. Each replacement
divides exactly by the previously unused U_j and multiplies by V_j. The
first chain point >=Q/B is either central or has a predecessor strictly
below Q/B; the chain ratio bounds the same two-sided gap. At most m exact
updates and rational comparisons therefore produce the certificate.
The rest of PA2--PA3 is unchanged mathematically; the closing notation now
correctly says R=Q/q. **Final revised ordinary PASS.**
