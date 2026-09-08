# ZS1–ZS4 full ordinary and source review

Status: PASS. Full source actually read, including the corrected even-n division-polynomial sign. Current SHA256: `63814e40fe99f39f9d325c74a8b43058222d73a5a2e465a693bf36213d90d9ff`. No zero isolation or rational-point completeness is certified.

## Divisor-to-group identification and multiplication constant

I actually reopened the original Balakrishnan–Dogra PDF https://arxiv.org/pdf/1601.00388 (v2), printed pages 29–30, Section 7 and Lemmas 7.3–7.4. The elliptic local function is defined using the diagonal divisor (z)-(O). Its non-disjoint support convention uses normalized tangent parameters. Thus 7.4 alone is initially a divisor identity. The manuscript correctly supplies the additional functorial translation argument: translation preserves the invariant differential, acts trivially on de Rham H1 and preserves the normalized tangent vectors. This identifies the translated diagonal divisors with the group differences without silently invoking local invariance under arbitrary linear equivalence.

Independently, the tangent limit gives the precise doubling constant: as Q tends to P, t(P-Q) tends to zero and x(P)-x(Q) has leading term a sign times 2y(P)t(P-Q). Their logarithmic singularities cancel in the addition law, leaving lambda(2P)=4lambda(P)-2log(2y(P)). The normalized principal term has zero extra constant. The stated division-polynomial identity then inducts the n,n-1 formulas to n+1; log(-1)=0 handles the even-index leading sign. Subtracting the two splitting laws on the formal group and then using n=9 proves the global local-point splitting identity.

## Formal series and actual local exceptional points

The w recursion comes directly from x=t/w,y=-1/w. Differentiating verifies omega=(twprime/w-1)dt/2, and the Laurent primitive has no logarithmic residue. Oddness fixes its integration constant and gives the stated R0 formula. Canonical sigma integrality and the integral slope supply the coefficient lower bounds without computing the slope. The elementary inequality j-2floor(log_5 j)>=ceil(j/2) controls every omitted term, not merely a fixed truncation comparison.

Every point of either E(Q5) maps into the formal group under multiplication by nine. The formal parameter has no zero or pole there apart from its simple zero at O. At nonzero nine-torsion, both t([9]Q) and psi9(Q) vanish simply, since multiplication by nine is etale in characteristic zero. At O their quotient has order 81 and leading coefficient one. Therefore delta has no other local zero or pole. Pulling back by the actual quotient morphisms, the z=0 and infinity fibers have t(R2)/z -> -2/W0 and t(R1)/(1/z) -> -2/epsilon. These are units, so exactly the order-81 factors in Xi cancel. The other quotient remains finite. This covers the zero fibers over Q5 without treating them as Q-rational.

The signs in the resulting F0 formula and log_E=L(T)/9 agree with the multiplication law. The rational q_i=-A_i/B_i formula recovers the previously audited height constants; alpha has valuation -1. Squaring the logarithm gains one error digit, while the alpha approximation needs precision K-2 because the logarithm square lies in 25Z5. Errors from rational functions and log Xi remain explicit, as required. The five finite residue abscissae have two nonzero ordinates each and the two infinity charts are smooth, giving exactly twelve disks. No further exceptional chart or complete analytic zero assertion is suppressed.

This is an ordinary proof/source review. It is not a new PARI computation, formalization, or proof of the remaining zero-list and sieve tasks.

## Independent finite replay

The entire standard-library next_replay_zero_slope.py was actually read and then --check was independently executed successfully. Canonical SHA256 `13589e3cf79c01417786276a25394ad7ed1245decdcca36e984e01eeb744b0c9`. Its exact power-series fixed point, differential equation, parity, coefficient inequalities, actual ninefold coordinates, rational leading digits and secondary recorded-ball comparison were checked. The H0 and L truncation errors give the ordinary alpha precision 19 after dividing by a valuation-two logarithm square. The degree-40 data do not prove the infinite coefficient bound by sampling; that bound remains the separately reviewed ZS theorem. No analytic root certification is included. Script and output byte hashes are in next_verification/zero_slope_replay_review.json.
