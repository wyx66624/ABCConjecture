# Independent full ordinary review of DP1--DP4

Ordinary mathematical PASS, 2026-09-07. Read the entire peer
`research/checkpoints/2026_09_07_adversarial_audit/seventeenth_round/actual_divisor_partition.md`,
SHA-256 `c480c79d7cb610e1ff635d7a559505ef224e917566d823b98290f2a5e2476744`.
Also reread sections 4--6 of the inherited FCRT unit-gap obstruction,
including the exact-prime-power premise of the no-face theorem and the
actual divisor-interval optimization. Its old partial Lean file remains
explicitly uncompiled; this review does not change that status.

For x=2^u 3^v, the full factors x-1 and x+1 are odd and coprime, so their
radicals partition the entire sink support. The two prescribed valuations
give the displayed H and J bounds regardless of unprescribed factors.
The balance range supplies A>=3x/8, B>=x/4 and the strict no-face inequality
2 min(M,N)-max(M,N)>1 for x>6. The complete actual divisor H lies in the
specified interval, while AB>Q and the strict logarithmic defect lower
bound both follow from k>=2.

The two prime-power congruences follow by elementary binomial induction.
The formula for u correctly retains the factor (2r+1), which is odd and
preserves the minus sign modulo 5^k; the required multiples at 7^k and
for v at both moduli are exact.

The irrational-rotation construction is valid for either sign of its
small approximation error. The nearest multiple of that error approaches
one half, so taking the floor supplies r+1/2-alpha s tending to zero.
The modulus L is fixed during each limit; a subsequent diagonal selection
gives unbounded c and absolute defect without exchanging these limits.

Only automatic positive fragmentation is refuted on the displayed
arithmetic subclass. No positive lower bound on defect divided by height,
no ABC counterexample, and no universal bound on the surviving scalar
defect or divisor gap is asserted. All ordinary statements pass. No new
finite computation or formal verification was performed for this review.
