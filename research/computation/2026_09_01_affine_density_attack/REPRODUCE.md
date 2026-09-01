# Reproduction

From the repository root, with any Python 3.10+ interpreter:

```powershell
$taskPython = 'C:/Users/Admin/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
& $taskPython research/computation/2026_09_01_affine_density_attack/verify_square_conic.py
```

A successful replay ends with:

```text
scope=finite_no_hit_only
captured_output_match=true
```

To deliberately replace the captured body after an audited source change,
run the same command with `--write-output`, then rerun it without that flag.

The fixed bound and full seed list are source constants in
`verify_square_conic.py`; no network access or third-party Python package is
used.
