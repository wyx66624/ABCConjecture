# Reproduction commands

Run these commands from this directory in PowerShell.  No package
installation is required.

```powershell
g++ -O3 -std=c++17 certificate_search.cpp -o certificate_search.exe
.\certificate_search.exe 2000 80 200000 500000000

$py = 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $py factordb_fallback.py

g++ -O3 -std=c++17 deep_prime_index_search.cpp -o deep_prime_index_search.exe
.\deep_prime_index_search.exe 500000000 10000000000 2> balancing_deep_prime_index_progress_500m_10b.txt
Move-Item balancing_deep_prime_index_certificates.csv balancing_deep_prime_index_certificates_500m_10b.csv -Force
.\deep_prime_index_search.exe 10000000000 50000000000 2> balancing_deep_prime_index_progress_10b_50b.txt
Move-Item balancing_deep_prime_index_certificates.csv balancing_deep_prime_index_certificates_10b_50b.csv -Force

& $py exact_audit.py > exact_audit_stdout.json
& $py make_manifest.py
```

`factordb_fallback.py` can run offline from the archived JSON responses in
`factordb_raw`.  FactorDB is used for candidate discovery only.  The final
audit independently proves the accepted candidates prime and rechecks every
valuation modulo \(p^2\).

The C++ scan intentionally returns a nonzero status if its larger exploratory
range still contains unresolved entries.  That status means “finite search
incomplete,” not a failed arithmetic assertion.

