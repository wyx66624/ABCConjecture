# Independent full audit: ZD2 and actual square/cube exclusion

Status: full ordinary PASS for both documents, after actual complete reading and direct primary-source verification.

* Author nineteenth-round next_zeta_squared_two_descent.md: ecbd3ace69864dd32541157d013f82c6260fda2eac2274a54c839f967bb55d5a.
* Author nineteenth-round next_actual_square_cube_exclusion.md: 0c54700c944cc8d10df08d3af03d9f3ccff4407154cca89eeb2ec4b01a738fe4.

Both paths are relative to research/checkpoints/2026_09_07_independent_route/. These hashes were independently recomputed.

## ZD2.1--ZD2.6

The monic model change X=-3s, Y=9y, its factorization, and both branch descent vectors are correct. The odd-degree map is a map on the whole rational Jacobian. The cited construction and exact kernel apply to this monic degree-five curve with rational infinity; it is not an even-degree fake-descent map. I directly opened [Stoll's original paper](https://www.impan.pl/shop/en/publication/transaction/download/product/83397), printed pages 250--251 and 254, and checked the construction and Lemmas 4.1, 4.3, 4.4 and 4.8.

The maximal-order proof uses the discriminant-index identity and excludes a putative field discriminant at most nine by the Minkowski bound. With actual discriminant 81 the bound is two, and inertness of two excludes an ideal of norm two, proving class number one. The three explicit unit signatures form a basis modulo squares; Dirichlet's rank suffices and no fundamental-unit basis or numerical regulator is assumed. I directly checked [Milne, Algebraic Number Theory](https://www.jmilne.org/math/CourseNotes/ANT.pdf), Theorems 4.3 and 5.1, for those inputs.

The discriminant of the full monic polynomial is 3^24. The valuation proof at every prime other than three includes two: after an unramified splitting extension the roots have unit differences. For arbitrary finite closed-point fields E, negative x-valuation is even because the degree is odd, and an integral x has at most one nonunit factor whose valuation is even. Base changes remain unramified over E; transfer by each closed-point norm multiplies valuation by a residue degree and preserves parity. Products with all divisor multiplicities therefore prove the restriction on the entire local Jacobian. There is no substitution of a good-reduction assertion at two and no claim that even valuation implies an unramified quadratic extension there.

At three, the shifted Eisenstein cubic is irreducible, so the full local quotient has order four. The first components of the two rational branch images are independent local classes. They therefore exhaust the local image, and injectivity of the four rational classes into Q3 square classes makes the global first two entries exactly the four displayed pairs. After cancelling an actual rational torsion image, the norm forces the remaining cubic-field entry to be a norm-one unit.

The three real intervals and all signs were checked. Nonreal closed points contribute positive norms at every embedding, so the sign restriction holds for arbitrary real divisor classes. With the first two signs positive the remaining unit is totally positive and hence a square. This gives the exact four-element global image, and the full-Jacobian quotient formula gives rank zero. The already independently replayed good-five/seven torsion bounds are used only to determine the remaining finite torsion, not to infer rank.

The Riemann--Roch argument excludes the fourth possible Abel--Jacobi point image. The degree-two divisor at zero and three is noncanonical because the sole-pole space is spanned by 1,X. Its unique effective representative cannot contain infinity. Thus the three source points are the complete rational locus. The second square root is unramified and has exactly two rational values over each; all six common-source points have v=0 and t=0 or -2, outside the positive domain.

## AC3.1--AC3.3

I read the connecting proof in full and reread the relevant HG positive-chart and CB projective-boundary passages. Primitivity of ab+M*zeta, F congruent to one modulo three, exclusion of inert and simultaneous split orientations, and actual UFD extraction give an integral cube with precisely the three unit classes modulo unit cubes. Signs are absorbed in the root; no nonunit residual or content is silently removed.

If the first norm is a square, its possible three-adic valuation one is excluded. The actual data r=ab/M, v=(a+b)/U and w=(a-b)/U have 0<r<1/3, v>0 and the same source [S:T] as the extracted cube. The reconstructed t=(a+U)/b is finite and greater than one. This uses a common source, not independently chosen quotient points.

The identity class is excluded by its actual second coordinate being divisible by three, or the stronger CL result. The zeta and zeta-squared classes are excluded by their respective complete boundary classifications, without treating conjugation as a positive-domain isomorphism.

For odd g divisible by three the actual composition of projective power maps preserves t and gives a nonconstant map of the established smooth projective curves. The positive-domain exclusion propagates. The numerical reduction of Q^g to a cube holds also for even g, independently of any geometric connectedness assertion for an even-index model.

The resulting theorem is an exact exclusion for positive primitive a,b with M=a^2+ab+b^2 a square and the displayed quartic F a cube. It does not cover the ramified first shape, nonsquare or noncube residuals, or general ABC triples.

No additional rank computation, finite replay, compiler execution, full Lean chain, or publication visual check is claimed by this review.

## Complete final paper transcription audit

The following new-checkpoint files were subsequently read in full, including both complete proofs, all finite tables and the bibliography. Their current hashes were independently recomputed:

| File in research/checkpoints/2026_09_08_descent_and_shift/paper/ | SHA-256 |
|---|---|
| zeta_squared_quotient.tex | 597578f7da9a98a19ff272b0d4843c7a3b3d08731d3d4d95496d1f334a31a012 |
| zeta_squared_two_descent.tex | 82c8c6835c92acf350ace4755fb4cd08c20de1644167b5646ac70ae5179a9219 |
| bibliography_geometry.tex | 02384a34e3d293e466b007ed11781303394b523af67a3f06d672f1813d675b7c |

All three receive final mathematical transcription PASS. The first manuscript retains the actual squared-unit source, the signed order-three lift, all four geometric branch values and all infinity/zero fibers; it uses the finite reductions only for simplicity and torsion, with rank-zero left conditional until the next section. The second manuscript supplies every step of the whole-Jacobian descent, including two, and then the full actual three-unit extraction and precise geometric/numerical propagation. The rank and rational-point closure are ordinary theorems with the explicit standard external inputs; no new Lean or ABC completion is asserted.

The Stoll reference is the actual primary paper opened in this audit, with the correct bibliographic identity and direct publisher link. Existing Milne and curve-extension citations are reused. This is a full mathematical/source transcription audit, not a new typesetting or PDF visual pass.
# Final domain and citation rebind

The subsequent changes in research/checkpoints/2026_09_08_descent_and_shift/paper/zeta_squared_two_descent.tex were actually read: the numerical propagation explicitly quantifies positive integers Q,g and the final profile explicitly quantifies positive integers R,Q,h,g; the curve-extension citation is Lemma 53.2.2 and Theorem 53.2.6 of Stacks. The independently recomputed final SHA-256 is 7ee7c298f08d6ee2245d923309338fc7aaeb2cfe4ade05e66fe10c7d19efdd91. The earlier full transcription PASS remains valid. No new compilation is claimed.
