# Reproduce the root-route cross-audit

From this directory, the complete recorded replay is:

```text
powershell -NoProfile -ExecutionPolicy Bypass -File run_cross_audit.ps1
```

The individual commands executed by that script are, from the repository
root:

```text
cd Lean
lake env lean -DwarningAsError=true IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903.lean
lake env lean -DwarningAsError=true IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903AxiomAudit.lean
lake env lean -DwarningAsError=true IUTThreeClosures/AlternativeQualityPackingBridge20260903.lean
lake env lean -DwarningAsError=true IUTThreeClosures/AlternativeQualityPackingBridge20260903AxiomAudit.lean
```

Then run:

```text
cd ../research/sources/alternative_quality_metrics_2026_09_03
python verify_source.py
cd ../../computation/2026_09_03_root_route_cross_audit
python verify_cross_audit.py
```

The cross-audit script expects the recorded Lean and source-verifier logs in
this directory.  `run_cross_audit.ps1` regenerates them with the matching
`*_stdout.txt` and `*.exitcode.txt` names before running the final check.

The script is offline.  The separate byte-for-byte comparison with a fresh
official arXiv download is described in `ROOT_ROUTE_CROSS_AUDIT.md` and is
not required for replay.
