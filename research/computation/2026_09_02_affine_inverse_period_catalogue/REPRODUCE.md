# Reproduction commands

Run these commands from this directory with Python 3.11 or later:

```powershell
python verify_inverse_period_catalogue.py
python verify_cross_singleton.py
python verify_subcritical_full_catalogues.py
python verify_euler_and_subcritical.py
python independent_replay.py
python run_canonical_catalogue_scan.py
```

The expected final lines are:

```text
PASS: canonical M=388 T=1 non-arm witness and full selected catalogue
PASS: canonical M=170 cross-singleton repeated-label witness
PASS: subcritical canonical B=8 T=1 cross-singleton fibre
PASS: exact Euler factors, hybrid tails, and canonical boundary witnesses
PASS: independent direct-divisor and congruence replay
PASS: canonical catalogue identities and support covers in all six cases
```

The Lean companion module is checked from the repository `Lean` directory:

```powershell
lake env lean -DwarningAsError=true IUTThreeClosures/AffineInversePeriodCatalogueNovelty20260902.lean
lake build IUTThreeClosures.AffineInversePeriodCatalogueNovelty20260902
```
