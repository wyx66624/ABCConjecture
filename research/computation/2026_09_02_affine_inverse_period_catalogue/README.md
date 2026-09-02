# Affine inverse-period catalogue certificates

This directory independently audits the finite arithmetic used in
`research/ABC_AFFINE_INVERSE_PERIOD_CATALOGUE_NOVELTY_2026_09_02.md`.
All programs use only the Python standard library.

The scripts have separate roles:

- `verify_inverse_period_catalogue.py` exhausts the complete selected
  canonical box for the `B=5, C=6, M=388` same-class period-one witness.
- `verify_cross_singleton.py` exhausts the complete `B=3, C=4, M=170`
  box and verifies that the repeated large label is supported by two
  distinct singleton kernel classes.
- `verify_subcritical_full_catalogues.py` solves the restrictive congruences
  first and then enumerates the complete large tails for the
  `B=8, C=9, R=6<C` cross-singleton witness.
- `verify_euler_and_subcritical.py` checks 588 prime-power Euler cases,
  48,400 general Euler cases, 10,001 occupancy values, the `q=3` Euler
  correction witness, and the subcritical period-one witness.  It writes
  `verification.json`.
- `independent_replay.py` imports none of the other certificate or search
  modules.  It recomputes the sharp constants, the Euler witness by direct
  divisor enumeration, and the subcritical fibre by modular inverses.
- `catalogue_novelty_search.py` implements the general finite catalogue and
  support-cover checks.  `run_canonical_catalogue_scan.py` applies it to six
  canonical boxes.

`SHA256SUMS.txt` records the final hashes of this package, the companion
research report, and the Lean module.

The six-box scan covers 755,322 admissible selected points, 3,885 powerful
kernel classes, 7,641 large labels, 631 repeated labels, and 34 repeated
non-arm labels.  Every tested incidence identity, optimal bridge, and
support-cover inequality passes.  This finite no-hit information is an
audit only.  It is not used to infer an asymptotic theorem or to abandon the
affine route.

The strongest local boundary has

```text
B=8, C=9, R=6<C, M=22143, N=22142
lambda=(137^2,173^2,1), D=561737401>N^2
fibre={(3128,10183),(21897,11423)}
class multiplicities=(1,1), T=1
w=S_non=554413792, w/D=23392/23701
```

It refutes only claims that derive a strict non-arm saving from `R<C`, from
singleton decomposition, or from the basic period bound `T>=1` alone.  It
does not refute bounds using cross-class geometry, catalogue sparsity, or the
affine mother route.
