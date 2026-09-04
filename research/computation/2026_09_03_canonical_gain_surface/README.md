# Canonical gain-surface finite search

Run from the repository root:

```powershell
python research/computation/2026_09_03_canonical_gain_surface/search_gain_surface.py --max-c 6000
python research/computation/2026_09_03_canonical_gain_surface/verify_output.py
```

The search enumerates unordered primitive triples with `2 <= a <= b` and
`a+b=c <= 6000`.  It checks the canonical approximation corridor and records
abc hits and canonical power gain above three.  Floating-point logarithms are
used only for ranking and display.  The counterexample
`3 + 125 = 128`, its radical `30`, and the comparison
`48000 > 30^3` are checked with exact integers.

This is finite evidence and has no asymptotic force.

