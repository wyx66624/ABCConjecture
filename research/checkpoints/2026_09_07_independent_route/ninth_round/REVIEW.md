# Ninth-round review

## CE ordinary proof

Both critical_bottleneck and adversarial_audit read the complete
CE1--CE4 ordinary manuscript, and the root researcher independently
read it: PASS. Reviews included the actual gcd argument, exact
multiplicative order, the entire exponent-prime valuation exception,
the divisibility U|pD with full prime powers, the integral four-ninths
certificate, strict denominator-mass inequalities, and the shared
prime extraction for unequal exponents. No existence or nonexistence
of the simultaneous pure-power branch is asserted.

The exact replay actually passed 116 cyclotomic rows and 3931
primitive seed identities. It checks arithmetic supplements, not
the existence of seeds satisfying the simultaneous pure-power premise.

## Formal verification scope

The author's actual Lean 4.32.0 compilations passed all 10 declarations
in CommonExponentArithmetic and all 5 in ActualCommonExponentGap.
All printed axiom lists contain only the standard propext,
Classical.choice and Quot.sound axioms. The first file imports the
actual repository norm definitions. The second proves the geometric
sum lower bound and derives 9n(Q-R^2)<=4R^2 and 9n<=4R^2 directly
from positive actual common-power representations for every n>=1.
These conclusions no longer have a separate geometric-sum-bound
antecedent. The integer bad-part budget still has its explicit
allocation antecedent. No prime-order, full-valuation or real-log
formalization is claimed.

The local builds reused the root's earlier compiled dependency closure;
a fresh build is a separate root verification. Both independent peers
read both full module sources and proofs: PASS. The adversarial reviewer
also completed the final TeX transfer review: PASS. These source reviews
are separate from an independent execution of Lean.
The final verification paragraph was then updated to identify both
modules and the now-proved geometric-sum lower bound.

The adversarial researcher independently ran the finite replay with
--check, obtaining the identical canonical JSON hash and all
116 + 3931 assertions passing. The final TeX transfer including its
updated fifteen-declaration verification paragraph has SHA256
bfad54619e52e8ec56e423c29ade0bf64a914bb182ba5cd842d6f247e548428a.

The later euler_progression_compatibility.md file is a separate
extension; its ordinary review is recorded below, separately from CE.

## EP ordinary proof and exact supplement

Both independent peers read EP1--EP4 in full: PASS. The review covered
the entire odd-prime cyclotomic valuation spectrum, the separate
2-adic zero statement at odd indices, the maximum-prime exception,
the conjugate-root lower bound, and the value at one. The general
odd-n rank intersection, its full old-prime depths, the totient
exponent and exceptional-prime cost, and the strict prime-existence
bound 243n/(64kappa)>1 all passed. The condition rho>0 implies
rho>=2 because rho is an even integer; no positivity step was
silently assumed when the displayed mass exponent is nonpositive.

The author generated and then read-only replayed 14 fully factored
homogeneous values and four additional exact valuation cases: PASS.
The cases at indices 55, 605 and 275 distinguish extension by powers
of the exceptional prime from arbitrary index multiplication. These
are model arithmetic supplements, not actual simultaneous pure-power
solutions. Both independent peers and the root researcher completed
the full paper transfer review: PASS. The adversarial researcher
independently replayed all 14 + 4 assertions with --check, obtaining
the identical canonical bytes. Final EP paper SHA256:
ff34bf398dafcddc4de664bfec28dd364d24b23cfb4d2df40a4221e8f33de721.

The author read the root's complete prime_power_and_formal_scope.tex
and the ninth-continuation introduction: transfer and scope PASS.
All seven root support-assembly Lean declarations were also read in
full: source and scope PASS, without claiming an extra independent
build. Actual PDF pages 439--442 passed view_image inspection; the
bound PDF SHA and precise scope are in visual_review.json. Ninth-round
mathematical sources are frozen; new exploration uses tenth_round.

## Independent reviews supplied to the other researchers

The author read the critical researcher's complete ninth-round
signed_arm_compensation.md, SA1--SA4: PASS. The review checked the
normalized power map at all three boundary lines, actual quotient
integrality and coprimality, the signed overlap credit, the exact
finite inequality, the positive-sector domain of LR2, the uniform
n-asymptotic and the retained bounded-n and membership limitations.

The author subsequently read all 32 declarations and their complete
proofs in SignedArmArithmetic.lean: source and scope PASS. The
normalized actual power, its three divisibilities, reconstruction,
additive relation and norm equations are actual repository objects.
Output primitivity is explicitly assumed in the quotient-coprimality
statement. The finite-list weight and signed-overlap results do not
claim to be a full formalization of prime valuations or real
logarithms. This source review did not execute a separate Lean build.

The author also read the complete ninth-round
split_progression_compatibility.md, AC1--AC3: PASS. The selected
root arm is exactly x+y or x according to p mod 6. For a newly
excluded inert prime, rank one and the complete valuation law show
that the entire quotient product has valuation zero, so the
original c-valuation is paid by that single root arm. The support
split and constants giving almost all mass in 1 mod 6p are correct.
Old primes and their depths are retained.

Finally the author read the root's complete
2026_09_07_signed_compatibility/prime_power_progression.md,
PP1--PP5: PASS. The top factor forces exact order p^k, its p-valuation
is exactly one when present, and the finer inert-prime argument has
rank dividing both p^k and q+1, hence rank one. The full weighted
budget, its exponent 2/p+1/p^k, and the arbitrary positive n root-gap
bound are correct. No prime-progression mass is treated as radical
mass or as a point-height upper bound.
