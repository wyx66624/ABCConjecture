# Affine ownership aggregation computation

This directory is the independent finite certificate for
`research/ABC_AFFINE_OWNERSHIP_MAXIMAL_INTERSECTION_AGGREGATION_2026_09_02.md`.
It does not prove an asymptotic estimate or the abc conjecture.

The computation uses the pair-saturated family of **all** exact point-pair
gcd tops before taking global coordinate-divisibility maxima.  This matters:
the linear-support proof cannot silently replace that family by an
unsaturated edge sample.

Files:

- `ownership_aggregation.py` independently rebuilds canonical arms,
  powerful kernels, large-label fibres, all exact pair tops, global maximal
  tops, supports, owners, exact inverse-period masses, the cubic pressure
  `H3`, and one pairwise-coprime lcm envelope per direction.
- `verify_canonical_boundaries.py` verifies the period-direction boundary,
  the three-pair/one-top collapse, and the one-class/two-maximal-tops
  boundary, including all local canonical arithmetic.
- `verify_abstract_sharpness.py` verifies the complete-graph powerful-kernel
  ledger where the ownership Cauchy inequality is an equality.
- `verify_beta_inflation_witnesses.py` and `OUTPUT_BETA_INFLATION.txt`
  exhaustively replay the canonical local witnesses with exact catalogue
  inflation above one and above two.
- `canonical_grid_scan.py` and `OUTPUT_GRID_SCAN.txt` record the broader
  2208-case complete-box adversarial search.  The scan checks the exact
  equality of the reduced-skeleton and all-pair maximal systems, and also
  checks `sum_mu Q(mu) <= E_non` in every case.
- `independent_replay.py` recomputes the boundary arithmetic through a second
  implementation, runs the two public verifiers, audits theorem/axiom counts,
  checks the report for control-character damage, and invokes both the main
  Lean module and its separate axiom audit with warnings as errors.
- `verification.json` records the final replay, Lean, TeX-fragment, source,
  and manifest checks.  `SHA256SUMS.txt` seals the complete deliverable.

The three canonical boundary selections are local admissible selections.
They are not asserted to satisfy the exceptional-point inequality.  They
retire only the exact strengthened statements named in the report.

Expected core results:

- `B=7,C=8,M=400`: one maximal top, two owned labels,
  `T_lambda=1<T_mu=3`, `S=445280/3`, `E=445280`.
- `B=4,C=5,M=390`: three point pairs collapse to one maximal top with
  `r=3`, and `S^2=E*H3`.
- `B=5,C=6,M=254`: one singleton kernel class is contained in two
  incomparable maximal tops whose supports intersect in exactly one point.
- `B=55123,C=55124,M=3`: the unique top has 34 period-one catalogue
  terms, `Q=55122`, `w_mu=25200`, and `Q/w_mu=9187/4200>2`.
- Abstract `K4`: six maximal tops on four vertices, `S=E=H3=371`.

The grid covers `B=1..12`, both full and singleton modes, and 92 values of
`M` (exactly 2208 cases).  Its finite no-hit fields are observations only;
they are not promoted to theorems.
