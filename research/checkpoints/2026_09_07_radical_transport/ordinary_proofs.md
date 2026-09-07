# Integer radical transport: proof before formalization

Date: 2026-09-07. Status: ordinary proofs below; Lean verification is recorded separately.
This checkpoint proves a conditional disproof criterion, not its arithmetic premise.

For coprime positive integers a,b write c=a+b, M=a²+ab+b² and
N=(ab)²+abM+M². The first and second transforms are (ab,M,c²) and
(abM,N,c⁴). Let rad be the product of distinct prime divisors, with rad(1)=1.

1. M is coprime to a,b,c: reduction modulo a and c leaves b², and reduction
   modulo b leaves a². Thus M is coprime to abc. Also ab+M=c².
   Applying the same argument to the coprime pair ab,M proves that N is
   coprime to abM and to c², hence to c. Both transforms are primitive.
   These gcd arguments already occur in FreyBranchQuarticBarrier.lean; they
   are reused at the mathematical level, not claimed as new discoveries.
2. Radicals are multiplicative for coprime factors and invariant under
   positive integer powers. Consequently
   rad(ab*M*c²)=rad(abc)rad(M) and
   rad(ab*M*N*c⁴)=rad(abc)rad(M)rad(N).
   No coprimality assumption on generic compressed factors V,Q is needed
   for rad(d*V*Q^g) <= d*V*Q when d,V,Q,g are positive: use divisibility
   rad(xy) | rad(x)rad(y), rad(Q^g)=rad(Q), and rad(x)<=x.
3. If [rad(M)rad(N)]^5 <= c, then the second boundary radical R₂ obeys
   R₂^5 <= c^16. Indeed rad(abc)<=abc<=c³, hence
   R₂^5 = rad(abc)^5[rad(M)rad(N)]^5 <= c^15*c.
4. If such primitive positive seeds have unbounded log(c), standard ABC
   is false. Apply ABC with epsilon=1/8 to the actual second transform:
   4log(c) <= (9/8)log(R₂)+C <= (18/5)log(c)+C, implying
   (2/5)log(c)<=C. Unbounded log(c) contradicts this uniform constant.

The last premise is deliberately explicit and currently unproved. Finite
examples, an arbitrarily deep single prime, or a first compressed norm do
not establish it. The same criterion follows from the ordinary two-step
logarithmic compression estimate in next_boundary_transport.md; this file
provides an integer-exponent form linked to actual radical arithmetic.

Formalization plan: first compile radical compression, primitivity, and
one/two-step radical equalities against Mathlib; then formalize the integer
gate and its conditional consequence for the repository ABCConjecture.
