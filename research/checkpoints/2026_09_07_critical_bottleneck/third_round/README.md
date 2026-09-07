# Third round: residual collisions and the private-depth reference object

Date: 2026-09-07.

The ordinary mathematical sources are `../next_global_tail.md` and
`../next_owner_measure.md`. They retain the unresolved owner-depth and
special-orbit transfer conditions explicitly. No ABC proof or disproof is
asserted.

For the cumulative manuscript, input these files in this order:

1. `paper/residual_collisions.tex`
2. `paper/owner_measure.tex`

The first section includes exact cross-residual gcd cancellation, repeated
valuation budgets, signed compensation, annotated lattice index and
determinant bounds, fixed-packet capacity, and the pointwise nonowner bound.
The second section includes exact finite-ring depth laws, the whole retained
large-prime positive-excess expectation, reference first-minimum estimates,
finite entropy transfer, its full-state obstruction, the primitive-state
variant, and the excess observable with its two-sided comparability boundary.

Theorems on reference measures are not claims that small-height integer
residuals, or a specified power orbit, are uniformly distributed. The
observable entropy reformulation is not a weaker arithmetic premise: the
proved comparability to expected positive excess is stated in full.

Run the exact finite replay with Python's standard library:

```text
python research/checkpoints/2026_09_07_critical_bottleneck/third_round/replay.py --check
```

The canonical compact payload hash (the `result` object, not the whole file) is
`4b515677f67ee7b8334fece7da1de66985f0279e5e808c2f25496af5d4058818`.
The complete UTF-8/LF JSON file has SHA-256
`b39e6c52f369fd8988903795f3ae03a95490f534fd97e5c537ef878fe0f35832`.
The writer preserves those bytes on Windows and Linux.
The result contains 2790 actual collision pairs and Gram identities, six
whole-family repeated-depth budgets, five owner-depth examples, eight complete
finite-ring counting rows, eighteen annotated lattice index rows, and six
first-minimum reference rows. The largest complete local enumeration has
375000 valid states at prime five and precision four. These are finite exact
checks separate from the ordinary proofs.

Independent review is recorded in `review.md`. New Lean work is managed by
the parent in its separate third-round formal directory. These files do not
claim that the entire lattice or probability theory has been formalized.
