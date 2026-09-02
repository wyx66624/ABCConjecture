# Actual Haar admissible-orbit computation

This directory provides an independent numerical check of the coefficient
bookkeeping proved in
`Lean/IUTThreeClosures/IUTActualHaarAdmissibleOrbit20260902.lean`.

Run from the repository root:

```powershell
python research/computation/2026_09_02_iut_actual_haar_orbit/verify_normalization.py `
  > research/computation/2026_09_02_iut_actual_haar_orbit/verification_output.json
```

The script checks `e log(p^f)=ef log p`, division by `ef`, the packet weight
sum, and the full-premise counterexample showing that raw Haar volume plus
ordinary weight-sum normalization is insufficient in residue degree two.
The numerical run is supporting evidence; the identities and inequality are
proved symbolically in Lean.
