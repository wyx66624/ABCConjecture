# LM1--LM5 independent ordinary review

Status: PASS. I actually read the complete ordinary proof at
`research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round/affine_owner_selectors.md`,
SHA256 `b5bc78149929704394cc7c542a81d82eb8d30d13569b80ef67aec78f9fe7b648`.
No independent replay or Lean verification is claimed by this review.

The two-coordinate finite-difference identity supplies an actual nonzero
coefficient vector in the kernel, so only a kernel-blind nonzero-output
inference is refuted. The CRT selector with precision e_q+1 retains exact
selected cubic depths. The two determinant identities prove g_t divides
Delta, and selected norm units prove its coprimality to M. They also give the
lower height cost after primitive cancellation; division by content does not
silently remove that cost.

For the fixed-data density result, the exceptional set includes 2,3, all
prescribed moduli, the determinant and all three slopes. Freezing each cubic
valuation one digit deeper freezes the coordinate content as well, since its
valuation is at most one third of the cubic valuation. The resulting quotient
arms have integral positive slopes. Outside the fixed exceptional set their
three roots are simple and distinct modulo p. Hence a square dividing their
product must divide one arm, which is at most C_0 X. This justifies the crucial
upper cutoff sqrt(C_0 X) in the elementary tail count, rather than an invalid
cutoff obtained from the cubic product's full size.

Finite CRT densities and that tail prove the exact convergent product density,
at least 1/4, for actual parameters. The frozen K includes all remaining prime
depths. Thus T=KR, R squarefree and coprime K, gives the complete signed formula
J=-2log(T)+3log(K/rad(K)) and limit -6 against log(a+b). Negative prime-depth
contributions have not been dropped. The constants and useful scale are fixed-
data quantities; no uniformity across changing prescribed packets is inferred.

The n>=2, B>=n positive-cone proof supplies the required actual roots and
positive difference. I checked the n=2,B=2 pairs (35,13),(80,19), determinant
375 and selected distinct owners 13,19 by exact small arithmetic. This sample
does not satisfy the original large prime-index block restrictions, as stated.
The outputs are new primitive affine points and need not be n-th powers.
Their signed bound is therefore not a bound on the original owner tails.

Final additional example was actually re-read and checked by a separate exact
integer calculation. With k1=4973918 and k2=4888691, the second coordinates are
19^4*229 and 13^5*79. The first coordinate is -3/4 modulo the marked prime,
the remaining arm and norm are units, and the other owner does not hit that
prime. Thus the complete selected boundary depths are exactly 4 and 5 and the
selected signed cost is positive. The revised ordinary SHA256 is
`76ca4bd2770971523fc917f83f3f54228fa0202ed7e7ef6030e3c7448bc03a51`.
This additional calculation is not a claim to have rerun the author's full
selector certificate or to have verified an example in the original US domain.
