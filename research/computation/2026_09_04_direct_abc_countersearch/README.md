# Direct bounded abc countersearch

This directory contains an exhaustive search of every unordered primitive
positive triple

```text
1 <= a < b,  a + b = c,  3 <= c <= 100000.
```

The domain contains exactly `1,519,825,376` triples.  The producer found 419
triples satisfying the exact integer condition `c > rad(abc)`.  Those 419
rows suffice to rank standard abc quality and every fixed positive-epsilon
excess used here.  The mathematical reason is given in the companion report
`research/ABC_DIRECT_BOUNDED_COUNTERSEARCH_2026_09_04.md`.

## One-command replay

From this directory, with the bundled Python selected if necessary:

```powershell
$py = 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $py replay_and_compare.py
& $py validate_results.py
```

`replay_and_compare.py` compiles both C++ programs in a temporary directory,
runs the full scan with eight OpenMP threads, runs the independent C++ scan,
recreates the structured-family output and final analysis, and requires all
four frozen artifacts to agree byte for byte.  It does not leave executables
in the repository.

## Expanded commands

```powershell
g++ -O3 -std=c++17 -fopenmp search_direct_abc.cpp -o search_direct_abc.exe
g++ -O3 -std=c++17 -fopenmp validate_direct_abc.cpp -o validate_direct_abc.exe
.\search_direct_abc.exe --max-c 100000 --hits ABC_HITS.csv --summary SCAN_SUMMARY.txt --threads 8
.\validate_direct_abc.exe --max-c 100000 --hits ABC_HITS.csv --threads 8

$py = 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $py search_structured_families.py --output STRUCTURED_OUTPUT.json
& $py analyze_direct_abc.py --hits ABC_HITS.csv --summary SCAN_SUMMARY.txt --structured STRUCTURED_OUTPUT.json --output OUTPUT.json
& $py validate_results.py
```

The producer constructs radicals by a smallest-prime-factor recurrence and
enumerates totatives of each `c` by marking multiples of its distinct prime
divisors.  The independent validator instead constructs radicals by a
prime-multiple sieve, scans every pair against the radical threshold, applies
`gcd` only to threshold candidates, and obtains the total primitive count
from `sum(phi(c)/2)`.

All identities, gcds, radicals, hit membership, fixed-epsilon signs, and
fixed-epsilon rankings use exact integers.  Standard-quality display values
use `Decimal` logarithms; the complete ordering is additionally certified by
exact-rational atanh-series intervals with 120 terms.  The 120-, 180-, and
independent 220-digit decimal orders agree with that certificate.

The structured scan fully factors each tested row in the stated finite ranges:

- Mersenne neighbours, `2 <= n <= 40`;
- `2^(k+4) + 3`, `0 <= k <= 36`;
- the balanced two-prime family, `1 <= r <= 12`;
- `(2, 15^n-2, 15^n)`, `1 <= n <= 8`;
- balancing/Pell squares, `1 <= n <= 14`;
- the first fully factored Danilov-orbit point;
- all 202,861 primitive Pythagorean-square parameter pairs with `m <= 1000`;
- all 9,592 prime-square endpoint rows with `p <= 100000`; and
- the exact benchmark `2 + 3^10*109 = 23^5`.

This package found no disproof of the standard abc conjecture.  Its finite
null conclusions do not retire any infinite family.
