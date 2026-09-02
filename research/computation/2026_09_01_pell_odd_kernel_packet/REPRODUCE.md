# Reproduction

Run from this directory with Python 3 and SymPy available.

```powershell
python search_prime_index_squarefull.py `
  --max-index 5000 `
  --trial-prime-bound 2000000 `
  --certificate-max-index 191 `
  --output prime_index_squarefull_search.json
```

The exact-factor producer can take about one minute on the recorded machine.
Then run the independent replay:

```powershell
python verify_prime_index_squarefull.py `
  --input prime_index_squarefull_search.json `
  --output prime_index_squarefull_verification.json
```

Expected replay summary:

```text
status: PASS
bounded prime indices: 668
bounded hits: 481
bounded unresolved: 187
bounded repeated-factor candidate tests: 648189
bounded repeated hits: 1
bounded depth-three hits: 0
exact simple-divisor certificates: 42
all odd prime indices through: 191
```

To check the frozen files:

```powershell
Get-Content SHA256SUMS.txt | ForEach-Object {
  $hash, $name = $_ -split '  ', 2
  if ((Get-FileHash -Algorithm SHA256 -LiteralPath $name).Hash.ToLower() -ne $hash) {
    throw "hash mismatch: $name"
  }
}
```
