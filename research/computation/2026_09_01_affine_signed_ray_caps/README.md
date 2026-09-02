# Affine signed-ray and canonical-arm pressure test

This directory contains the independent finite audit for
`research/ABC_AFFINE_SIGNED_RAY_CANONICAL_CAPS_2026_09_01.md`.

The mathematical results are proved symbolically in that note before their
Lean formalization.  The Python program is a pressure test: it exhausts
small complete ledgers, checks the displayed premises in its enumerated
ranges, and records exact counterexamples to named over-strengthenings.  A
finite no-hit is not treated as a proof or as a reason to abandon the affine
route.

The script uses only the Python standard library.  Its principal checks are:

- 15,840 signed directions for `1 <= B < C <= 9`;
- 1,776,807 complete cubic period/capture ledgers;
- 2,390,018 complete normalized arm ledgers;
- 43,403 primitive exact-capture instances, split by each arm's exact
  premises (`U=12,133`, `V=15,391`, `W=15,879`);
- the pointwise shifted-to-unshifted bridge for occupancies `0..1000`;
- full-premise countermodels for a closed large-label threshold, one extra
  period factor, each of the four independent coefficient-coprimality
  premises, nonprimitive parametrization on each arm, coefficient six in the
  global bridge, and deletion of selected-kernel catalogue membership;
- all actual arm-divisor labels above `N^2` in four affine `M=10` boxes; and
- the actual selected powerful-kernel catalogues, their owner budgets, three
  coordinate moments, arm-energy ceiling, and formula (8.5) in those boxes
  plus a `B=4, C=5, M=30` non-arm stress case.

The broader all-arm-divisor layer in the four boxes contains 4,307 distinct
large labels and 259 repeated labels.  It tests every local ray theorem but
is not used in the owner bound.  The selected-kernel subcatalogues contain
110 large labels and 12 repeated labels; their owner bounds and global
energy ceilings are checked separately.  The `M=30` stress case contains
113 selected large labels, nine repeated, including one non-arm label, so
both terms of (8.5) are exercised.

`verification.json` is the deterministic machine-readable result and
`OUTPUT.txt` is the captured console transcript.
