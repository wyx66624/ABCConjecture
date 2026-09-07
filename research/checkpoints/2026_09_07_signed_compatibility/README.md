# Ninth continuation: signed compensation and common-exponent support

Standard ABC remains unproved and undisproved. This checkpoint integrates
independently reviewed ordinary results, three exact finite supplements,
and 54 new scoped Lean declarations.

## Reliable ordinary results

- SA constructs the actual normalized three-arm integer quotients. Their
  signed budget proves a large-exponent subclass: excess in two arms can
  be compensated by the third arm's radical credit. Two large-prime
  cubefree quotient arms suffice, with arbitrary depth in the third.
  General membership is still open.
- CE uses F-M^2=ab(a+b)^2 to force full valuation mass of the actual sum
  coordinate into 1 modulo a shared odd prime exponent, retaining the
  exponent-prime exception. AC uses the actual first norm root to improve
  this to 1 modulo 6p, with bad part at most 4R^(3/2)/(3 sqrt 3).
- PP lifts the modulus to 6p^k with retained mass fraction
  1-2/p-1/p^k. The full common exponent n gives the actual integer
  root budget 9n(Q-R^2)<=4R^2 and the resulting height lower bound.
- EP treats every common n>1 coprime to 6. With phi=phi(n) and
  kappa=maxprime(n)/Phi_n(1), it proves
  27 c_bad(6n)^2<=16 kappa R^(2(n-phi)+1).
  If 2phi(n)>n+1, an actual prime q|c is 1 mod 6n and q>=6n+1.

All masses include multiplicities. They are not radical estimates or
claims that simultaneous pure-power seeds exist. No moving-point upper
height bound or general ABC consequence is obtained.

## Verification

In the repository-pinned Lean 4.32.0 Linux environment:

```sh
python3 research/checkpoints/2026_09_07_signed_compatibility/verify_round.py
python3 research/checkpoints/2026_09_07_signed_compatibility/verify_finite.py
```

The fresh build checks 32 actual arm/finite integer-weight statements,
15 actual common-exponent algebra and gap statements, and 7 support
assembly statements, plus 54 unchanged dependency declarations. Every
theorem has its axiom list checked; the union is only propext,
Classical.choice and Quot.sound. Output primitivity, progression rank
divisibility and support allocation retain their explicit formal scope.
Prime valuations, real logarithms and arbitrary-root membership are not
silently asserted as formalized.

The exact finite replays check 113 actual signed-arm rows / 678 rational
inequalities; 116 cyclotomic instances / 3931 primitive seed identities;
and 14 completely factored general-index values / 4 additional exceptional
valuations. The record distinguishes generic homogeneous examples from
actual norm seeds. Each verifier and certificate is sealed by source hash.

Complete proofs and reviews are in the three agents' ninth_round
directories, the two root ordinary notes, and verification/ordinary_review.md.
build_manuscript.py compiles the full book; seal_manuscript.py requires the
matching source inventory and actually reviewed raster hashes before
replacing the designated PDF. The final pages, hashes and exact scope
are in verification/manuscript_validation.json.

## Live proof obligations

The highest-priority gate is arbitrary actual membership in the signed
compensation condition, retaining private upper-tail depths and negative
credits. The common-exponent route still needs control of high valuations
in the surviving progression. Nonunit residuals, ramified first norms,
relatively prime exponents and moving-cover point heights remain distinct
active routes. A finite null search, failed totient condition or lack of
tools does not retire any of them.
