# CB1–CB3: complete independent same-source inverse review

Status: **full ordinary PASS**, 2026-09-07.
Source `research/checkpoints/2026_09_07_independent_route/eighteenth_round/next_cubic_same_source_boundary.md`, SHA256 `e68c6dc1102248f1db9f3dcf772acc4bd79a679a122534efe6488e3986b90ff4`.

The complete new note was actually read. The relevant actual definitions and inverse domains were also reread in independent-route EQ1–EQ2 (`thirteenth_round/elliptic_quotient_gate.md`), HG1/HG3 (`twelfth_round/hyperelliptic_quotients.md`), RL2–RL4 (`twelfth_round/rational_biquadratic_locus.md`), SS1–SS2 (`fourteenth_round/simultaneous_elliptic_gate.md`) and CL2–CL3 (`thirteenth_round/cubic_unit_local_gate.md`). This is a transfer from those exact definitions, not an identification by a matching curve equation alone.

CB1's inverse charts compose to the identity and satisfy (s+1)^6 S((s−1)/(s+1))=64P(s). The points over z=1 transfer using y/s^3=W/(1+z)^3; the two points at infinity transfer to s=−1 with y=−epsilon. All omitted affine denominators are therefore covered on the smooth projective models. The independently reviewed fixed-C classification gives precisely two H points over each source 0, −1 and infinity.

For CB2, multiplication by zeta changes the actual cubic coefficients to A=−B_0 and B=A_0+B_0. The first quotient is y_1^2=A_0(A_0+B_0), while the second is y_2^2=(A_0+B_0)(A_0+4B_0), at the same projective source. At all three possible sources B is nonzero and A=0. Each first-quotient point has exactly two rational second lifts, so there are exactly twelve D points. The square roots are nonzero and the branch values are avoided; normalization introduces no further points there.

The inverse parameter values infinity, 1, −1 and −1/2 are all verified against the original v,w rational functions. In particular the (−1,−1) value is resolved at t=−1/2, not discarded as a 0/0 exception. These are the four simple projective roots of r(t)=0. The homogeneous first-root output reduces to (1,0), (0,1), (0,−1), (−1,0). The t=1 and t=−1/2 inputs may have content 3; their primitive quotients remain boundary pairs. Thus no ramified or infinite input creates a positive seed.

CB3 uses the actual positive domain: finite t>1, equivalently 0<r<1/3 and v>0. None of the twelve points is in it. Every positive primitive M-square, F-cube seed in the oriented unit-zeta class gives the actual same-source point by RL/CI, so this excludes that entire specified branch, not merely an auxiliary necessary square. The full converse on this positive domain was already established in RL/CI.

For odd g=3k, L_(zeta,g)=L_(zeta,3) composed with L_(1,k) gives the projective morphism retaining t. Its extension covers all apparent source exceptions; positive points would map to the empty positive locus. The conclusion therefore propagates within this same coefficient class. It does not count every boundary preimage for higher g.

The distinct class zeta^2 is correctly retained: conjugation changes r to −1−r, outside the required positive interval. General residuals, a ramified first norm, uncovered exponents and uniform ABC estimates remain open. No new finite computation or Lean verification is claimed in this review; the fixed-C proof and its F13 evidence are separately reviewed in `next_fixed_curve_rational_points_review.md`.
