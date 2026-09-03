# Quadratic Veronese peeling computation

This directory contains the deterministic finite audit accompanying
`research/ABC_QUADRATIC_VERONESE_PEELING_ANALYSIS_2026_09_02.md`.

Run from this directory:

```text
python quadratic_veronese_peeling_scan.py --output scan_results.json
python verify_quadratic_veronese_peeling.py
```

The producer checks all consecutive parameters `1 <= t <= 20000` and the
power-of-two subsequence through `t=2^18`.  It verifies the Pythagorean and
consecutive identities, pairwise coprimality, exact positive-area
conservation, outer-square and maximal-exponent cost ledgers, the
calibrated-boundary lower margin, and primewise layer duplication under
squaring.

`lean_axiom_audit.log` is the frozen output of the one-for-one audit of all
53 theorem declarations.  Its dependency union is the standard
`propext`, `Classical.choice`, and `Quot.sound` basis.

The finite scan is not a proof of an asymptotic statement.  The infinite
fixed-policy counterexamples are proved in the report and Lean module.  The
unrestricted multi-move Gate VF and the abc conjecture remain open.
