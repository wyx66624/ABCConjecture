# Critical slow-slack finite replay

Run from the repository root:

```powershell
python research/computation/2026_09_01_mersenne_critical_slow_slack/verify.py --verify
```

For the full route-local replay, including hashes and the independent Lean
module, run:

```powershell
python research/computation/2026_09_01_mersenne_critical_slow_slack/validate.py
```

The script independently:

- sieves every prime through `100000`;
- computes the exact order of `2` modulo every odd prime;
- verifies `(2/p) = (-1)^r` for `r = (p-1)/ord_p(2)`;
- enumerates the complete allowed `(d mod 8, r mod 8)` table;
- finds the base-two Wieferich rows `1093` and `3511` and recomputes their
  exact orders, depths, multipliers, and square/cube divisibility.

The scan is finite.  Its lack of any depth-three row is not used as evidence
for an asymptotic estimate.  The row `1093` is used only as a full-premise
counterexample to the exact universal claim that every repeated exact-order
multiplier is even.

Compile the independent formal module from `Lean/`:

```powershell
lake env lean -DwarningAsError=true IUTThreeClosures/MersenneCriticalSlowSlackGate20260901.lean
```

The module is intentionally not added to the shared aggregate import by this
route task; integration belongs to the root checkpoint.
