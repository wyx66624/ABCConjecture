# Independent ordinary review of SR1--SR5

Reviewer: independent_route. Status: full ordinary proof review PASS.
This is a next-only review, outside the sealed fixed-curve publication.

Actually read the complete source
`research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round/next_shifted_boundary_resultants.md`,
SHA256 `3c7f8cce60282796ec07df5cc5f079c8958efff8eb3bdea048f9472633a51e03`.
No independent finite replay or compiler execution is asserted here.

SR1 correctly accounts for all 3n-1 roots, including the excluded
embedding-zero inputs and the two rational roots. The ratio takes its
values in the same cyclotomic field for every root. The three orbit
means follow from the actual arm coefficients and the n modulo six
rational-root allocation. Their diameter is below three, whereas the
normalized field trace of an integer translation in the a=3X chart
changes by 3h. This proves coprimality for every nonzero integer shift,
without a generic-polynomial assumption or an identification of the
minimal polynomials of two roots.

SR2 retains each prime's full maximum common valuation, even when
different primes attain that maximum at different pairs. The integral
Sylvester identity yields the complete lcm divisibility. Multiplication
by three commutes with the nonempty lcm, so the higher three-adic
depths have not been discarded. The coefficient translation estimate
and its two Sylvester row blocks give the stated H_n(h).

SR3 is an exact signed decomposition before any inequality. In
particular the common packet's full radical and the unmatched
depth-one/two credits remain present. The single assigned three-label
is restored once after partitioning by shifts. The fixed-shift and
growing-shift normalization statements use the actual block lower
bound; summing all shifts is correctly identified as too expensive.

SR4 was checked arithmetically in the proof: the CRT step sizes fit
inside B; the shifted residues after dividing by 7^4 and 13^5 are
respectively 2 and 12. The identity P(-1-a)=P(a) gives the exact
second-owner depths. The split norm-one argument checks the entire
other boundary, including separately the zero-norm case, and the
four indices are distinct. This is a genuine original-block example
with two different positive labels, and its fixed small primes are
not misrepresented as a far-tail example.

SR5 correctly applies the corrected CG three-adic adjustment to the
complete assigned packet. Its coefficient-height inequality is a
sufficient condition, with the actual signed remainder retained. No
construction for singleton owners, a covering by few shifts, or a
pointwise ABC implication is inferred. No mathematical revision is
needed.
