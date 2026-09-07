# Fourth-round independent review record

Date: 2026-09-07. This record does not modify the frozen third round.

## Third-round final typography

I actually viewed pages 376--380 in the third-round rendered PDF. All
formulas and text were readable and unclipped. I reported the missing
visible proof label at the beginning of page 378. The parent independently
confirmed and corrected that typographic issue, then reported an actual
second visual inspection of page 378 including its right-aligned QED.
The parent reports that the other nineteen reviewed page images have
unchanged pixel hashes. The final sealed 391-page PDF SHA-256 is
09a27c4efe251f01f86a1089011a4a09a25bc3ed09f017e2cde8b883accf385c.
The corrected page was inspected by the parent, not independently
re-viewed by this agent; the earlier five-page inspection was mine.

## Independent route: PL1--PL5

I read the complete file
`research/checkpoints/2026_09_07_independent_route/fourth_round/power_class_lifting.md`.
The direct-map integer exponents, h-free integrality, exact denominator
class injection, direct-cover genus, finite S-ideal class argument,
four-branch Kummer cover, and fixed-exponent finiteness all pass ordinary
proof review. In particular, the three ratio classes are independent
also for composite h by their valuations at their distinct zeroes;
their common pole has diagonal inertia of order h. Thus the cover has
degree h^3 and genus 1+h^2(h-2). The actual seeds avoid all branch
points, so their affine points lift to its smooth normalization.

I independently opened the author-hosted primary PDF:
<https://www.math.mcgill.ca/darmon/pub/Articles/Research/12.Granville/pub12.pdf>.
Printed page 514, Theorem 1 and its following consequence, gives the
claimed classical fixed-exponent finiteness for four simple roots and
exponent at least three. The new note correctly identifies its result
as this established mechanism applied to the actual second norm.
It does not exchange fixed-exponent finiteness for a uniform bound over
moving exponents. PL5's least odd prime factor escape is correct after
the explicit additional hypothesis that the exponents tend to infinity.

## Adversarial route: LP1--LP3

I read the complete file
`research/checkpoints/2026_09_07_adversarial_audit/fourth_round/local_power_boundary.md`.
All three ordinary statements pass. The direct finite-modulus family
has both norm values equal to one modulo the specified common modulus.
The p-adic construction satisfies the strong Hensel inequality for
both exponents, including primes that divide those exponents.

For LP3 I checked the root orientations: at a=1 modulo seven,
z0=1+2*zeta; at a=1 modulo sixty-seven, z1=2+7*zeta. These elements
have norms seven and sixty-seven. Primitivity excludes the conjugate
prime factors, so exact norm valuations give actual divisibility by
the claimed element powers, not just a norm congruence. Dividing cannot
create a rational common divisor of the quotient coordinates.
The conditions a=5 modulo 13^2 and a=14 modulo 31^2 preserve the exact
residual valuations, since N_c(5)=91 and F_c(14)=574771=31*18541 with
18541=3 modulo 31. The nonsquare residuals therefore satisfy the full
stated premises. The growing residual size at fixed exponents is
explicitly retained, so the family does not refute the small-lambda gate.

## Signed-support entropy proof

`signed_support_entropy.md` contains the new ordinary statements SE1--SE3.
The independent adversarial agent has checked the initial derivation:
the conditional geometric law, half-moment, signs in the relative-entropy
identity and the binomial height count all pass. The complete written
version subsequently passed its full independent review. The common height t is explicit;
there is no exchange with varying unbounded individual heights. Every
actual depth lies strictly below the chosen finite precision cap, so
the finite reference cross entropy on actual states agrees exactly
with the infinite geometric formula.

The complete TeX transcription in `paper/signed_support_entropy.tex`
subsequently passed the adversarial agent's final independent review.
I also read its complete `fourth_round/paper/local_power_boundary.tex`
and approved the ordinary-to-TeX transcription, including the added
finite-total-support corollary. That corollary follows from PL4 by
fixing exponent three and taking the finitely many cube-free classes
on the specified prime support; it does not require a uniform theorem
over exponents.

I ran `fourth_round/replay.py` and then its independent stored-payload
`--check` mode. Both passed. The canonical payload SHA-256 is
9cf9f7cdfbbbc671d63e2c05c4641b8ef6d4c299ea70f0d5eaeef28684a6f67e.
All local probabilities and the exponentiated entropy identity are
checked with exact fractions; the latter uses fifty actual primitive
seeds and a nontrivial conditional depth distribution on one support.

No new Lean formalization is asserted in this record. The missing
arithmetic allowance bound on actual conditional depth entropy remains
an open step, as does the full signed-tail gate.
