# Independent eleven-statement finite density source review

2026-09-07, adversarial_audit. Full semantic/source/recorded-output review PASS for PrivateDensityMass.lean, source SHA256 0796e0a4d2d40fc04fcf37a11048215d19aca4b7682d7349ee2f85dfb69ed463.

Both integer cofactor theorems use the actual norm-polynomial equality. They prove multiplication back and discriminant -27, without an inverse when m=0 or any prime-root-count theorem.

The actual_exception_indicator proves the Finset indicator sum from e subset s. The finite mass cut is obtained pointwise and summed over actual indices. It correctly needs neither nonnegative weights nor nonnegative epsilon. The private-mass specialization preserves its full c*card(s) term; c>=0 is sufficient to relax the nonexceptional bound. No cardinality is supplied as an unrelated scalar pretending to be a set.

The three strict numerical gain theorems derive their quotient bounds from epsilon>0, epsilon<=1/10 and C*epsilon<=1/4. The additional loss is explicitly bounded by epsilon/8. No assumption C>=0 or loss>=0 is needed for the algebra; dropping unnecessary restrictions is legitimate.

actual_density_gain_from_mass directly combines the actual finite sum, e subset s, its exact cardinality bound, and actual upper/lower weight inequalities. B>0 and ell>0 justify every division. It does not assume the desired lower bound on card(s). Its application interface is deliberately narrower than an unnormalized DG weight list: hupper is w<=2ell, and the exceptional cardinality bound has no extra remainder. To apply it to DG, one may shift w to log(r)-log49 (the theorem does not require nonnegativity), account for log49*card(s) in the loss using card(s)<=B, and absorb the fixed-epsilon exceptional remainder into a suitable explicit C or earlier budget. None of those analytic estimates is silently formalized by the direct theorem. This exact point was communicated to root for the paper scope.

The added actual_density_gain_with_remainders directly closes that finite application interface: it retains the actual exceptional bound C*eps*B+R, additive upper height c, card(s)<=B and the total error loss+eps*R/B+c/ell. Multiplying totalLoss by B*ell gives exactly loss*B*ell+eps*R*ell+c*B. Nonnegative c and positive B,ell justify the cardinality and division steps. R and loss need not separately be nonnegative for the stated conditional inequality. The final small-error premise remains explicit. This is a genuine finite coupler, not a claim that the arithmetic error premise has been proved.

actual_natural_weighted_cutoff is literally a theorem on Finset Nat and a Nat-to-Real weight function. It explicitly requires every supported index at least one, nonnegative weights, and z>1. The proof uses actual Real.log of the index, the real cutoff filter, finite sum partition and positivity of log(z). Empty sets and zero weights are included. The temporary generic index type is not a hidden input to this Nat theorem.

I independently recomputed the source and manifest/log hashes, counted all eleven theorems, matched all eleven complete axiom outputs and parsed their axiom sets. Every set is contained in propext, Classical.choice and Quot.sound. No errors or sorryAx occur in the recorded log. I did not rerun Lean or Mathlib. Evidence is in verification/density_eleven_source_review.json.

The complete sieve, Euler-product weights and their moments, private ideal valuations, actual prime-distribution estimates, eventual asymptotics, and global signed membership remain ordinary interfaces. This module is not a formal proof of DG or ABC.
