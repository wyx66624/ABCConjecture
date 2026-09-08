# ZS1--ZS4 complete ordinary review

Next-only record, 2026-09-07; excluded from the sealed publication
inventory. Read the full independent_route/eighteenth_round/
next_zero_slope_sigma.md, including the final even-division-polynomial
sign correction. Final candidate SHA:
63814e40fe99f39f9d325c74a8b43058222d73a5a2e465a693bf36213d90d9ff.
Full ordinary and primary-interface review: PASS.

## Divisor heights, group differences and the multiplication constant

Actually reopened Balakrishnan--Dogra arXiv:1601.00388, Section 7,
the tangent convention immediately before Lemma 7.4, Lemma 7.4
itself, and the subsequent elliptic interpretation. The lemma is
indeed written using divisor differences. The candidate supplies the
necessary extra identification: translation preserves the invariant
differential, its tangent vectors and the splitting of H1, and
functoriality of the local pairing then translates (Q1)-(Q2) into
(Q1-Q2)-(O). It does not treat the divisor notation as group notation
without this argument.

There is no undetermined constant in the multiplication formula.
For the tangent doubling limit, writing R=Q1-Q2 gives
x(Q1)-x(Q2)=2y(Q2)t(R)+higher order, while the normalized local
height of R is -2log5(t(R))+a term tending to zero. Substitution
in the addition identity gives
lambda(2Q)=4lambda(Q)-2log5(2y(Q)). The displayed exact division
polynomial recurrence then proves the general law inductively.
The formal principal terms provide a separate constant check:
psi_n has leading (-1)^(n-1)n t^(1-n^2), so the three logarithmic
principal parts cancel. The previously written unsigned leading
coefficient was corrected; log5(-1)=0, and n=9 retains leading
coefficient +9. This correction does not alter delta_9 or the height
identity. Extension over the stated removable exceptions is legitimate.

The formal sigma identity gives lambda_c-lambda_0=c log_E^2.
Multiplication by nine places every local point in the formal group;
the multiplication law transports this equality to all non-origin
points. Continuity covers nonzero nine-torsion. The global equality
then follows by summing local heights, and alpha_c=alpha_0+c.
Both appearances cancel exactly in the rank-one expression, without
assuming the chosen rational point is a global generator.

## Rational recursions, entire series tails and chart extensions

The implicit equation for w=-1/y, x=t/w and the formula for omega
are correct. The Laurent primitive has zero constant, the apparent
1/t pole cancels, and parity fixes the inner integration constant.
Thus R0 is the actual logarithm of sigma_0/t. Integrality of the
canonical sigma, already source-audited in HT, bounds its logarithm
coefficients; combining with the integral invariant differential
gives the stated -2 floor(log_5 j) bound. The inequality 5^k>=4k
proves convergence and the entire omitted-tail error on t in 5Z5.
It is not inferred from a finite truncation experiment.

The function t([9]Q)/psi_9(Q) has order 81 and leading coefficient
one at O. At any nonzero rational nine-torsion point both numerator
and denominator have simple zeros. At other Q5 points the formal
image prevents poles or unexpected zeros. In Xi, the zero-fiber
parameter t(R2)/z tends to -2/W0 and the infinity parameter t(R1)z
to -2/epsilon. These give the exact cancellation of z^81 and its
inverse. The other quotient remains finite and non-origin. Hence
Xi has no zero or pole on C(Q5), including those special fibers.

The coefficient -2/81 and the logarithm terms in the final expression
follow directly from the multiplication law. The leading digits of
HT imply alpha_0 has valuation -1, so the stated squared-log error
budget loses exactly the allowed digit. Rational-function and log-Xi
evaluation errors remain separately explicit. The twelve residue
disks and their indicated square-root lifts exhaust the local curve.

This review proves no analytic zero count, derivative nonvanishing,
root multiplicity list, rational sieve completion or classification
of the original same-source curve. No new compiler, PARI or finite
replay execution is claimed here.

Primary source reopened:
https://arxiv.org/pdf/1601.00388 , printed pages 29--30 for the
tangent convention and Lemma 7.4. The MST integrality and sigma
input, including its normalization, was independently source-audited
in height_transport_review.md and is reused without a new claim
that its coefficient computation has been executed.

## Subsequent independent finite replay

After completing the ordinary review, read the complete new
next_replay_zero_slope.py and independently executed its read-only
--check. PASS, canonical SHA-256:
13589e3cf79c01417786276a25394ad7ed1245decdcca36e984e01eeb744b0c9.
The script uses exact rational arithmetic for the two degree-40
recursions, their differential equation and parity, actual ninefold
point arithmetic and leading height/logarithm digits. Its primary
calculation does not call PARI; a separately identified comparison
checks the same digits against the earlier pinned PARI audit.
The claimed absolute alpha precision follows from the ordinary
entire-tail bound and the denominator valuation two. These finite
checks do not establish that infinite bound by sampling and do not
isolate any zero of the analytic function.
