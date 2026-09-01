# Reproduction helper sources

These scripts are copies of the helpers actually used for the recorded
build, audit, environment capture, rendering and completed-QA metadata.
Only their repository-root calculation changes to reflect this directory.
They are included for reproducibility; the exact recorded outputs are
in the parent directory.

The ordinary proof reproduction commands are listed in `../VALIDATION.md`.
Run `../verify_manifest.py` without `--write` for a read-only integrity
check. The command does not compile Lean or certify mathematical inputs.

These helper scripts **write** their named output records. Do not run
them into an accepted frozen stage when continuing research. Work in a
copy or a new verification stage. Recompiling the PDF can change its
creation metadata; the resulting artifact must be identified and
visually reviewed independently. The finalization helper checks the
exact accepted hash and records an already completed human-visible
agent image inspection; it is not an automatic visual-review algorithm.

The original snapshot-capture script is intentionally not a reproduction
step: its six input canonical paths now point to newer files. Historical
verification uses the preserved snapshots and explicit mappings instead.
