# Independent full ordinary review: ramified cubic source

Status: full ordinary review PASS. This is a new candidate review, outside the frozen manuscript and without a new compiler or finite-computation claim.

The complete RS1--RS4 source actually read is
research/checkpoints/2026_09_07_independent_route/nineteenth_round/next_ramified_square_cube.md.
Its independently recomputed SHA-256 is
8c840dd90e2193b974a647b29133b9b8ce04d655b55e7cdbbb70c8088c685341.

The three literal cubic coordinate pairs, Mobius conjugacy, all nine branch points and independent square classes were checked. The projective conic has no point with L=0 over Q_3. Its valuation equation forces v to be a unit, w in 3 Z_3, and v_3(r)=-1, whereas every projective cubic source gives only the valuations explicitly listed in RS10--RS11. Zero coordinates and the entire exceptional fibres are retained.

The primitive integer norm-cube extraction is exact: no inert prime, no ramified prime and no two conjugate orientations can appear. Hence the unit classes reduce to the displayed three without projective content division. The second coordinate has valuation at least two in the identity class, and valuation zero in the other classes, whereas primitive M has valuation zero or one. This proves the stated stronger obstruction F=Q^3 implies 3 does not divide M.

RS4 was checked in its final general-g form. For every positive k, composition of the actual power maps gives a dominant map from the g=3k ramified source to the cubic source. The distinct simple fibres ensure both square classes remain independent, including even g, so the normalization is connected. A nonconstant rational map extends on smooth projective curves. I opened the cited primary Stacks Section 53.2 and checked Lemma 53.2.2 and Theorem 53.2.6 directly:
https://stacks.math.columbia.edu/tag/0BXX

The example (a,b)=(1,4) was independently checked by exact arithmetic: M=21, F=541, U^2=7 is locally soluble, and (1+3t)^3=541 is equivalent to t+3t^2+3t^3=60 with simple residue root zero. Thus the numerical equations over Q_3 are not being incorrectly identified with the common-source covers. The global integral extraction is the extra input.

The result does not cover arbitrary nonunit second residuals, exponents not divisible by three, or all ABC triples. No uniform height or complete ABC conclusion is claimed.

## Complete final paper transcription

I subsequently actually read all 337 lines of research/checkpoints/2026_09_08_descent_and_shift/paper/ramified_cubic_exclusion.tex and independently recomputed SHA-256 3eb6c1b95c557d19790fade596a77049138dafc7af12ed81aa6f1a1c412cf4cf. Full ordinary-to-TeX transcription PASS.

All cubic coordinates, geometric branch and genus counts, the exhaustive projective valuation cases, exact primitive extraction, the stronger integer obstruction, all positive-integer domains and the complete general-g propagation are retained. The (1,4) local numerical example and the distinction between numerical norm solubility and actual common-source covers remain explicit. The final verification paragraph does not claim Lean, a uniform residual estimate, or ABC coverage. This review did not rerun a compiler or inspect PDF pages.
