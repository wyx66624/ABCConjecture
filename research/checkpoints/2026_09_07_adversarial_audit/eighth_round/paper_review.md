# Final eighth-round transcription and integration review

Date: 2026-09-07. Status: ordinary mathematical transcription PASS.
PDF rendering and visual inspection are separate checks.

## Boundary twists and torsion support

Read both complete files:

* `2026_09_07_independent_route/eighth_round/paper/boundary_twist_support.tex`;
* `2026_09_07_independent_route/eighth_round/paper/torsion_support_refinement.tex`.

Both faithfully transcribe the ordinary proofs independently reviewed
in `twist_sturm_review.md` and `torsion_support_review.md`. The
complete Gauss-sum level calculation, squared coset-product valence
argument, full coefficient cutoff, field automorphisms, all embeddings,
four allowed quadratic twists and actual residual-module comparison
are retained. The TS proof retains the F_p Hom base-change argument,
the unique inertia-trivial Jordan--Holder character, the parity/Hasse
contradiction at p, and the stronger cutoff and height bounds.

The reviewer requested three explicit prime-domain additions in the
TeX: the BT post-theorem support sentence, the TS cutoff proof, and
the TS pure-power corollary. The author added all three, and the
reviewer reread the actual corrected lines. The ordinary proofs
already had the prime domains; no mathematical argument changed.

The referenced labels `bm-orbit`, `cb-two-orbits`, `bc-pure` and
`bc-density` were found in the intended existing sources. The three
new bibliography entries were read and match the actual source
passages reopened for the ordinary audit. The exact software and
ordinary representation-theory dependencies remain explicit.

The fixed-p density is not promoted to a uniform estimate. No
existence of a global pure-power seed, point-height upper bound,
or ABC conclusion is claimed. The statements apply to the pure
branch and do not reduce arbitrary moving residual levels to the
same two modular orbits.

## Root height budget and formal scope

Read the complete file
`2026_09_07_cm_image/paper/height_budget_and_formal_scope.tex`.
Its stronger premise Q>p is supplied by the reviewed TS theorem,
so p^p<F<=13H^4 and p log p<T follow directly. The reused monotonicity
argument gives p log(p/2)>T under the contrary exponent assumption;
this contradicts the stronger p log p<T. The threshold T>=e^2 and
the effective asymptotic range are retained.

The reviewer requested that the corollary explicitly say Q is an
integer. Root made the change to `for an integer Q>1`, and the
reviewer checked the corrected source. This restores the fully
standalone domain from the already reviewed TS theorem.

The two polynomial certificates and the list of ten Lean declarations
match the final source and manifest independently reviewed in
`boundary_support_lean_review.md`. In particular the split trace-factor
disjunction and p<Q are explicit formal antecedents; no modularity,
local representation theory, analytic logarithm estimate, or complete
ABC formalization is implied by the arithmetic build.

No further mathematical changes are requested. Breaking the two long
displayed SHA256 strings for page layout does not change these proofs;
the final rendered pages still require their own visual QA.

## Other eighth-round transcription reviews

The complete `paper/cm_boundary_shadow.tex` has final independent
transcription PASS from both independent_route and critical_bottleneck,
and root has read the full source. The one double-comma typo reported
by critical_bottleneck was corrected. The separate all-index window
ordinary and TeX review is in `all_index_window_review.md`.
