# Reproduction

Run from this directory with the repository Python environment:

```powershell
python produce_factor_quotient_projective_coupling.py
python verify_factor_quotient_projective_coupling.py
```

The second command must print `"status": "PASS"` and exit with code zero.

Run the Lean checks from `Lean/`:

```powershell
lake env lean -DwarningAsError=true IUTThreeClosures/PellLucasFactorQuotientProjectiveCoupling20260902.lean
lake env lean -DwarningAsError=true IUTThreeClosures/PellLucasFactorQuotientProjectiveCoupling20260902AxiomAudit.lean
lake build IUTThreeClosures.PellLucasFactorQuotientProjectiveCoupling20260902
```

The axiom audit must list only Lean's standard logical implementation axioms
(`propext`, `Classical.choice`, and `Quot.sound` as applicable).
