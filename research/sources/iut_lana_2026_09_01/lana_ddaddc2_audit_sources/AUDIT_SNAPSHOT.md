# Project LANA audit source snapshot

This directory contains the exact Apache-2.0 source files used to audit the
public `lana-agents/iut` repository at commit
`ddaddc274281adb5674d647e24fa478745ac6d40` (checked 2026-09-01).

It is a deliberately small source snapshot, not a vendored build dependency.
The paths are preserved from the upstream repository.  The mathematical audit
is `research/ABC_IUT_LANA_SAME_PILOT_AUDIT_2026_09_01.md`.  The unchanged
upstream `LICENSE` is included.  `SHA256SUMS` freezes every file in this
directory except itself.

The snapshot supports the field and source-line audit.  A direct Lean replay
must use the complete pinned upstream repository because these files import
additional upstream modules.
