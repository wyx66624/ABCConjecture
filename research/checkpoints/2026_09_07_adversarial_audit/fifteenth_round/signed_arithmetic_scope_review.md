# Signed finite arithmetic: pre-formal ordinary scope review

Reviewer: adversarial_audit. Status: PASS after actual complete reading. This is a review of the proposed ordinary proof and interfaces, not a compiler claim.

The finite binomial sum is correctly separated from its integer-ball interpretation. The radius-two, radius-three and M=2 identities, monotonicity, and one-deep-index consequence hold also at the stated zero boundaries. The chosen natural radius floor(sqrt(floor(n/2)))+1 need not equal the original real ceiling, but satisfies 2r^2>=n and, for n>=18, r^2<=n. In the latter argument s>=3 makes (s+1)^2<=2s^2. No missing parity case occurs in 2r^2>=n.

The maximum is selected from the actual finite depths; its singleton contains every filter with cardinality at most one. For e<h, the exact natural excess is at most (h-4) times the depth-four indicator, including h=4 and empty sets. The ceiling estimate and the individual e*w<=nL cap give total <=(2r M4+n)L. The integer square (r-2M4)^2>=0 yields 4r M4<=3n and hence 2 total<=5nL. Natural truncation must remain inside the cast as the draft explicitly requires. The normalized conclusion needs the actual positive height assumptions retained in the draft; L=0 causes no division issue when using positive t0.

The two-range formula covers every remaining positive layer, including h0=h1, e=h0 and empty intermediate ranges. Its exact finite remainder uses (6M4+2rMh0)L; the later fractional-power 7/14 estimate is expressly ordinary. The proposed module neither constructs the finite torsion group nor proves Gram rigidity, prime distribution, density, all-prime summability, or membership of the complement.

Source SHA256: c35e1ada55d04d308cd20585b62ab993b1d291cde4275d43fe5f45f25e16f75f
