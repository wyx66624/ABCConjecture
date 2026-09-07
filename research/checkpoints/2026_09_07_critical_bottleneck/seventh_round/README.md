# Seventh critical-bottleneck round

This checkpoint retains three distinct proof mechanisms:

* `sieved_rank_window.md`: an actual root-interval average, using exact rank strata and the uniform Brun--Titchmarsh inequality. Its prime window can exceed the root-interval length on bounded-divisor-sum index families. The upper tail and exceptional actual roots remain open.
* `affine_slice_escape.md`: effective exponent and finiteness bounds on three actual affine charts, using established Berczes--Evertse--Gyory inputs. Fixed-residual bounded-slice seeds are effectively finite. Moving slices are not excluded.
* `square_gap_escape.md`: elementary, residue-sensitive square-gap bounds in two specific norm square classes and an explicit divisor parametrization on each fixed nonzero diagonal slice.

All three ordinary proofs have completed independent reviews. Their self-contained transcriptions are in `paper/`. The review log also records independent audits of the other group's fixed-boundary modularity and residual-congruence support conditions. No master manuscript, earlier frozen source or Git reference is changed by this checkpoint.

Run `python research/checkpoints/2026_09_07_critical_bottleneck/seventh_round/replay.py --check` from the repository root for the exact local algebra and explicitly bounded diagnostics. This replay does not verify the external analytic, transcendence, modularity or elliptic-descent theorems. All scoped statuses and seals are recorded in `review.md`.

A separate new collaboration is examining the full class-thirteen elliptic descent. Its ordinary proof is being assembled by `independent_route`; the finite scan in this directory is not evidence of universal nonexistence and does not replace that proof.
