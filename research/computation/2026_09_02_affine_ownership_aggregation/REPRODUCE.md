# Reproduction commands

From this directory:

```text
python verify_canonical_boundaries.py
python verify_abstract_sharpness.py
python verify_beta_inflation_witnesses.py
python independent_replay.py
```

If the complete-box scan is being replayed:

```text
python canonical_grid_scan.py
```

Lean can also be checked directly from the repository's `Lean` directory:

```text
lake env lean -DwarningAsError=true IUTThreeClosures/AffineOwnershipMaximalIntersectionAggregation20260902.lean
lake env lean -DwarningAsError=true IUTThreeClosures/AffineOwnershipMaximalIntersectionAggregation20260902AxiomAudit.lean
lake build IUTThreeClosures.AffineOwnershipMaximalIntersectionAggregation20260902
lake build IUTThreeClosures.AffineOwnershipMaximalIntersectionAggregation20260902AxiomAudit
```

`independent_replay.py` already performs the first Lean command and requires
24 theorem declarations, 24 matching inline `#print axioms` commands, 24
matching prints in the separate audit, no custom axiom/sorry/admit, and no
`native_decide`.
