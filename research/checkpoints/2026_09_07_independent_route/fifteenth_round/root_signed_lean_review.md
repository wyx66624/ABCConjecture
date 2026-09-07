# Full semantic review of the root signed-product core

Reviewer: independent_route. Status: PASS.
Actually read the full final ActualGramRigidity.lean (four declarations)
and ActualSignedProducts.lean (twelve declarations), including signatures
and proof bodies, against the already reviewed ordinary scope.

The Gram module uses the explicitly qualified old integer Eisenstein
norm. It proves its nonnegativity, the true coordinate identity, and
the actual modulus criterion with no injectivity hypothesis. Squaring
the integer divisibility is valid for every sign of the modulus; the
strict bound handles zero without an omitted precondition.

The signed-product source maps the actual product through each private
homomorphism, extracts its genuine integer zpow coefficient, and uses
the nonzero diagonal for cancellation. The unit-kernel lemma and finite
target bridge preserve explicit arithmetic premises. No desired
coordinate equality is imported as a hypothesis.

The finite diamond is constructed as two Fin-product summands. Four
integer corner bounds prove the actual radius. The coordinate map,
pair-vector map, private product and finite target each have a proved
injection, and actual Fintype cardinality yields 2r^2+2r+1. Radius zero,
negative coordinates, opposite signs, and the two-summand parity
separation are handled by the proofs.

The remaining residue-algebra/prime-valuation realization and global
signed tail are not part of either module. I have not independently
rerun the compiler in this review; the parent reports the separate
sixteen-new plus twenty-nine-old fresh build and standard-axiom audit.

