# Eleventh-round independent inverse-boundary work and reviews

All tenth-round sources remain frozen. This directory contains new
ordinary results, independent reviews, and a finite arithmetic replay.
None asserts a proof or disproof of ABC.

## Own mathematical results

- `projective_content_boundary.md`, PC1--PC2: complete ordinary proofs,
  independently read in full by root, independent_route, and
  critical_bottleneck, all PASS. The actual counterfamily excludes only
  the single projective inverse with the specified exponent and a nonunit
  output root. It does not supply a counterexample to the simultaneous
  double inverse.
- `paper/projective_content_boundary.tex`: full final transcription
  independently reviewed by both peer agents, PASS. SHA256
  `a2cb25096456564790719402d9e99e425bffc9f6891f244ef348406ac3b6433b`.
- `canonical_residual_reflection.md`, CR1--CR3: the n-free subdomain has
  exact V_can=V rad(C)^n/C^2 and R_can=R/rad(C). Full ordinary proof
  reviewed in full by root and both peer agents, all PASS.
  A genuine non-n-free counterexample prevents extending this exact
  formula to the broader IL domain without modification.
- `paper/canonical_residual_reflection.tex`: complete self-contained
  transcription reviewed by root and both peers. Their exponent-quotient
  wording correction is resolved; final SHA256
  `e3dce75b6e24f8220bef6d62e2a0baff2c43574ad8c8ea0422181d2babb6e702`.
- `content_integer_core.md`: the ordinary arithmetic list supplied to
  root before formalization, including the actual-gcd statements and a
  separate scalar residual-depth bill with all premises stated.

## Finite evidence

`replay_projective_content.py` was actually run by this agent in write
and read-only `--check` modes. It checks 24,192 multiplication/content
rows and 128 positive family rows for n=2 through 129. The canonical
result file is `projective_content_results.json`, SHA256
`92bf3f119d79dde439aa3477a31cba2c70b09af6f1b1a72cb19536b358a0d025`;
its payload SHA256 is
`ea8d21c0004833e5d067679bdd18496856019d39e17c7e121beaee5d24dfe2e6`.
These checks supplement, rather than prove, the unrestricted ordinary
theorems. Peer ordinary reviews are not counted as independent replay
runs unless an actual run is separately reported.

## Independent proof and source reviews

- `integral_profile_review.md`: IL1--IL4 full ordinary PASS, including
  complete prime valuations, changed root norms, ramification, positive
  double-inverse reconstruction, and the finite-local test's exact scope.
- `pure_coefficient_review.md`: CI1--CI2 full ordinary PASS, including
  arbitrary primitive projective input, exact gamma-content, the nonunit
  output exceptions, and the even/even obstruction.
- `gaussian_even_profile_review.md`: GE1--GE4 full ordinary PASS after
  correction of an invalid intermediate parity sentence; the Gaussian
  and Eisenstein profiles retain their full common-seed compatibility.
- `biquadratic_cover_review.md`: BK1--BK3 full ordinary PASS, including
  the exact Kummer relation kernel, two even geometric components,
  fixed-field unit twists, and the actual positive-seed lift.
- `large_cutoff_review.md` and `squarefree_outer_window_review.md`:
  LC1--LC3 and SQ1--SQ3 full ordinary PASS. The proved actual good sets
  are distinguished from still-open full-tail membership.
- `paper_transcription_review.md`: IL, CI, LC, SQ, GE, BK, and the actual
  global signed-prime bridge full final TeX reviews
  with exact reviewed hashes and resolved transcription corrections.
- `root_paper_review.md`: the root arithmetic paper's complete final
  transcription/scope review, matching the current 31+53 inventory.
- `actual_content_review.md`: root's actual Int.gcd/primitive reduction
  module, nine new declarations plus 29 old dependencies. Full source
  and recorded build/axiom audit review PASS; root performed compilation.
- `residual_bill_formal_review.md`: seven additional reflected-depth
  and actual prime-support declarations, full source/scope PASS. The
  intermediate root combined inventory was 16 new plus 29 unchanged.
- `actual_log_threshold_review.md`: six further actual integer-radical
  logarithm and strict threshold declarations, full ordinary/source PASS.
  The current complete root inventory is 31 new plus 53 unchanged, with
  all seven source hashes and 84 axiom queries independently matched.
- `global_signed_formal_review.md`: nine actual prime-log global bridge
  declarations plus 24 old local declarations. Full source and recorded
  build/axiom audit review PASS; critical_bottleneck performed compilation.

Ordinary proofs, source-scope reviews, compiler runs, finite replays, and
eventual rendered-page inspection remain separate evidence categories.

## Final rendered-page review

`verification/pdf_visual_review.json` records actual view_image inspection
of pages 465 through 472, eight pages, all PASS. Every PNG hash was
independently matched to the final render inventory, and the actual PDF
hash is `a218aa002ee3ffdbcef99d13b447a69ddb8b213b374e2bc37c1028a91b748021`.
The PDF has 486 pages; no unviewed-page or whole-book visual coverage is
claimed. The canonical UTF-8/LF review JSON has SHA256
`00a0ba0805f71c9a49c800b99a73ca55b4d8e5202c8b9f64ae96bf93cac02f8c`.
