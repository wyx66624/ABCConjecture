# Prime-layer Mersenne radical audit

This directory contains the reproducible finite computation accompanying
`research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`.

The scan covers every prime index from 3 through 61.  The upper limit keeps
every Mersenne value below \(2^{64}\), where the seven listed Miller--Rabin
bases are deterministic.  Factorization uses a fixed Pollard-rho parameter
order.  `verify_prime_layers.py` independently checks every listed factor,
the exact products, radicals, power losses, congruences, exact order at a
prime index, and the proved square radical bound.

This is a finite audit.  In particular, the empty list of repeated-prime
indices is not extrapolated to squarefreeness or any asymptotic statement.

Run from the repository root in PowerShell:

```powershell
$py = 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $py research/computation/2026_09_01_mersenne_prime_layer_radical/scan_prime_layers.py `
  --max-index 61 `
  --output research/computation/2026_09_01_mersenne_prime_layer_radical/prime_layers_3_61.json
& $py research/computation/2026_09_01_mersenne_prime_layer_radical/verify_prime_layers.py `
  research/computation/2026_09_01_mersenne_prime_layer_radical/prime_layers_3_61.json `
  --output research/computation/2026_09_01_mersenne_prime_layer_radical/verification.json
```

Expected verifier status:

```json
{
  "failures": [],
  "rows_verified": 17,
  "verified": true
}
```

The actual file includes the input SHA-256.  `SHA256SUMS` records all stable
delivered files except itself.

The companion Lean audit is reproduced with:

```powershell
Set-Location Lean
lake env lean IUTThreeClosures/MersennePrimeLayerRadical20260901.lean
```

`lean_audit.json` records 33 theorem declarations, 33 explicit
`#print axioms` commands, no source `sorry`/`axiom` marker, exit code zero,
and the exact module hash.  `lean_build.log` contains the complete compiler
and axiom-audit output.  The module also proves an abstract total-mass bridge
under explicit decomposition and lifting hypotheses; it does not formalize
the arithmetic global lifting-product identity.

Verify both source and computation manifests from the repository root:

```powershell
& research/computation/2026_09_01_mersenne_prime_layer_radical/verify_hashes.ps1
```
