# Flagged CRT and anchored residue-cube checkpoint

This bundle verifies the 2026-09-04 FCRT-1 accounting and anchored-prefix
selection checkpoint. It does not claim a proof or disproof of standard abc.

From the repository root, run with a Python installation containing `sympy`:

```powershell
D:\anaconda3\python.exe `
  Lean/verification/2026_09_04_flagged_crt_residue_cube/verify_round.py
```

The script performs strict direct compilation of the three source modules and
their one-for-one axiom audits, builds the umbrella Lean library, reruns the
independent exact SCRT/FCRT validator, scans the new Lean code for forbidden
escape tokens after removing comments, checks declaration/query counts, and
seals the principal sources and outputs with SHA-256.

The expected declaration/audit counts are `70/70`, `18/18`, and `28/28`.
The expected kernel-dependency union is exactly `propext`,
`Classical.choice`, and `Quot.sound`.

The precise open obligations are the concrete arithmetic map into the owner
kernel, the uniform FCRT-1 and SCRT-0 estimates, the anchored endpoint entropy
bound, and standard `ABCConjecture` itself.
