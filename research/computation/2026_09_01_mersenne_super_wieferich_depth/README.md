# Finite base-two super-Wieferich depth scan

This directory supports Section 7 of
`../../ABC_MERSENNE_SUPER_WIEFERICH_DEPTH_2026_09_01.md`.

Run with the bundled Python runtime or any Python 3.11+ interpreter:

```text
python scan_super_wieferich.py --limit 10000000 --output scan_10m.json
python verify_super_wieferich.py --input scan_10m.json --output verification.json
```

The generator uses a full Eratosthenes sieve.  The verifier independently
uses a segmented sieve and recomputes every Fermat congruence, exact-order
certificate, and prime-power depth certificate.

The output is a strictly finite audit.  In particular, an empty
`super_wieferich_primes` list does not prove finiteness, density zero, or any
asymptotic estimate for the deep mass `D_d`.

The independent verification covers all 664,579 primes through ten million.
It finds exactly `1093` and `3511`, both at canonical depth two; `3511` has
the odd exact order `1755`.  `verification.json` records the PASS result.

`lean_audit.json` records a direct compile of
`Lean/IUTThreeClosures/MersenneSuperWieferichDepth20260901.lean`: 36 theorem
declarations, 12 definitions, 36 `#print axioms` commands, no forbidden proof
tokens, and only the standard Mathlib axioms `Classical.choice`, `propext`,
and `Quot.sound`.  It explicitly records `standard_abc_closed=false`.

Run `verify_hashes.ps1` to check every archived file against `SHA256SUMS`.
