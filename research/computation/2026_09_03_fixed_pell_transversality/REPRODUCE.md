# Reproduce the fixed-T=2 Pell search

From this directory run:

```text
python produce_fixed_two_search.py --max-index 20000 --prime-bound 10000000 --output fixed_two_search.json
python verify_fixed_two_search.py --input fixed_two_search.json --output fixed_two_verification.json
```

The producer uses binary powering in `Z[U]/(U^2-2)`.  The verifier uses
independently written binary powering of the integer matrix
`[[1,2],[1,1]]`.  Both enumerate the same fully specified finite rectangle.

No no-hit statement is extrapolated past either bound.
