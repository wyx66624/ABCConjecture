# Primary-source ledger for the prime--unit--label vector bridge

This directory records the exact primary-source state used to delimit the
claims in
`research/ABC_IUT_PRIME_UNIT_LABEL_VECTOR_BRIDGE_2026_09_01.md`.

The new reconstruction and counterexample theorems are elementary algebra and
are proved in that report before being formalized in Lean.  The external
sources are used only for the IUT/LANA type boundary:

* Mochizuki's IUT III keeps unit/coric data and mono-analytic log-shells in the
  object-level construction before the scalar log-volume comparison.
* The Project LANA container retains rational-place fibers and procession
  labels in packet components, while its README explicitly leaves the
  multiradial output algorithm and Corollary 3.12 comparison unproved.

No source is duplicated here.  `source-metadata.json` records relative paths,
byte lengths, SHA-256 digests, upstream URLs, and the pinned Project LANA
commit.  `REMOTE_HEAD.txt` records the read-only remote query made on
2026-09-01; the pinned commit was still both `HEAD` and `main`.

Run

```text
D:\anaconda3\python.exe verify_source_metadata.py
```

from this directory to verify every referenced source and the remote record.
`SHA256SUMS` freezes the four ledger files other than itself.

