# Independent review of actual cyclotomic rank packets

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read the complete critical-agent `fifth_round/cyclotomic_rank_packets.md`,
CP1--CP5. The ordinary proofs pass independent review.

CP1 uses actual Eisenstein boundary integers. Unramified primitivity
makes (w) and (bar w) coprime; a root-of-unity quotient would force
both to be unit ideals, contradicting Q>=7. Thus every displayed
cyclotomic factor is nonzero. Reciprocity gives symmetry for d>=2,
including the degree-one factor X+Y at d=2. Conjugation therefore
fixes its algebraic-integer value in the imaginary quadratic field,
making it a rational integer. The exact product for P(w^n) preserves
the signs and correctly takes C1=P(w), after cancellation of the
common cubic-difference factor. The complex factor bound and its
uniform relaxation to 2 phi(d) log Q are valid.

CP2's proposed valuations have exactly the known divisor sum for
v_p(T_n), since p does not divide the rank. Divisor inversion gives
the first-rank value s_p and the only later occurrences at d_p p^j,
each of depth one in its own cyclotomic factor. This includes rank
one. The argument does not treat p-power repetitions as new first
depths and does not omit negative signs in the integer factorization.

The full first-depth packet B_d divides the actual |C_d|, so its
totient budget is unconditional. The assembly of signed A_d packets
and the lifting divisor of n is exact. The identity sum_{d|n}phi(d)=n
eliminates the divisor-count loss but leaves a linear-height upper
bound; no sublinear estimate is inferred from that alone.

CP4 discards only nonpositive whole packets. The true positive-sector
height satisfies Q^n<=c_n^2, giving the stated factor four in front
of the exceptional totient mass. The bounded-rank and KD conditions
are sufficient conditional subclasses. The conclusion is vanishing
positive part of the signed ratio, not two-sided convergence. Its
analytic application keeps n tending to infinity and the actual
cutoff n^(1/6); it does not extend to bounded exponents and moving
roots. The distinction between net-positive packets and ranks with
one high-depth prime is explicit and necessary.

CP5 requires one function epsilon(d), uniform over all actual data
in the sequence. Its finite-small-rank argument and the totient sum
give the claimed one-sided limit. The elementary lower bound
phi(d)>=sqrt(d/2) is correct prime-power by prime-power: only 2^1
can contribute a factor below one in phi(d)^2/d, and its factor is
one half. Thus the older fixed nonnegative polynomial-budget exponent
does imply the new saving condition. Neither condition has been proved
for arbitrary actual arithmetic packets.

The prime-exponent specialization correctly reduces the unresolved
upper-bound problem to the net top-rank packet at scale n log Q.
The accompanying actual HR family refutes only the coarser automatic
high-depth-rank sparsity. No contradiction to CP4 or CP5 is asserted.
No new Lean or ABC conclusion is claimed by this record.

Read the complete final `fifth_round/paper/cyclotomic_rank_packets.tex`.
Its CP1--CP5 transcription passes. The author incorporated the requested
explicit integer D>=0 domain for the triangular rank sum, so the exact
sum formula and the stated real bounds have no cutoff-domain ambiguity.
The net-sign versus single-high-depth distinction remains explicit.
