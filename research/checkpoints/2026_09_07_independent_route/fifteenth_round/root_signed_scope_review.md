# Independent ordinary review: actual Gram and signed-product scope

Status: FULL ordinary PASS. Reviewer: independent_route.
Source: research/checkpoints/2026_09_07_signed_moment_descent/ordinary_formal_scope.md.

I actually read the complete G1, S1, S2 and proposed formal boundary.

The Gram identity gives 3 D^2 <= 4 NN'. Combining actual m|D with
4 NN'<3m^2 gives D^2<m^2; an integer multiple square must vanish.
The same premise excludes m=0 by the Gram sum-of-squares identity, so
negative moduli and the zero-modulus boundary are handled correctly.

For actual signed products, every private homomorphism maps the product
to the one nonzero integer diagonal coefficient times its signed
exponent. This proves coordinatewise injectivity, with both negative
diagonals and exponents allowed. Unit-kernel normalization preserves the
same hypothesis. The later finite-target rigidity implication is explicit
and is not assumed already proved from arithmetic by the count theorem.

Both finite squares in S2 were checked, including radius zero. The sums
and differences determine i,j within a square; their distinct parity
separates the two images. The identity
|x|+|y|=max(|x+y|,|x-y|) and the actual index bounds give radius r.
The cardinality is exactly (r+1)^2+r^2. Surjectivity onto the whole
diamond is unnecessary for the lower-bound injection and is not claimed.

The proposed formal core proves actual norm/divisibility, integer power
products and a concrete finite source. Arithmetic realization of the
private homomorphisms, torsion residue targets, all-prime normalizations,
and global signed cost remain separate as stated. No mathematical
correction is needed. This is a review of the ordinary proposal, not a
compiler or final Lean-source review.

