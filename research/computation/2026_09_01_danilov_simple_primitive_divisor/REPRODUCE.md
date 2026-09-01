# Reproducing the simple-primitive-divisor evidence

Run all commands from the repository root. A standard Python 3 interpreter is
sufficient; no network access and no third-party package is needed for the
certificate verifiers.

In PowerShell, choose the interpreter and bundle path once:

```powershell
$python = (Get-Command python).Source
$dir = 'research/computation/2026_09_01_danilov_simple_primitive_divisor'
```

## Fast exact checks

```powershell
& $python "$dir/verify_small_fibonacci_certificates.py"
& $python "$dir/verify_real_lucas_counterexample.py"
& $python "$dir/verify_final_state_constraints.py"
& $python "$dir/replay_hong_threshold.py"
& $python "$dir/verify_manifest.py"
```

The first verifier independently checks primality by trial division, the
rank-at-$n$ witnesses, valuation one modulo $p^2$, and the eligible-$Q$
partition. The second proves the complete real-Lucas counterexample by direct
recurrence. The third reconstructs the exact 638-factor modulus from the
earlier recursive-lift certificates. The fourth is a floating-point replay of
Hong's appendix and is supporting evidence only. The fifth checks every file,
size, and SHA-256 entry in this package.

## Full bounded search regeneration

The following command reruns the exhaustive prime sieve through fifty million
and regenerates both bounded-search outputs:

```powershell
& $python "$dir/search_small_fibonacci_simple_primitive.py" `
  --q-max 1000 --p-max 50000000 `
  --out "$dir/small_fibonacci_certificates.csv" |
  Set-Content -LiteralPath "$dir/small_fibonacci_search_summary.json"
```

After regeneration, rerun the first verifier and then rebuild/check hashes:

```powershell
& $python "$dir/build_manifest.py"
& $python "$dir/verify_manifest.py"
```

The bounded search is finite evidence. A missing certificate below the cutoff
is not a proof that a simple primitive divisor does not exist.
