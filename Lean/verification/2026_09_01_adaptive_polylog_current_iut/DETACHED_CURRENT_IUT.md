# Detached current-IUT provenance

The detached audit targets public LANA commit
`6e963070c73c5defd1012320deccc777e2555d22`, whose Git tree is
`3a59644c327100d3e51a2bbaf45abc298daafdee`.

The main repository remains pinned to `ddaddc274281adb5674d647e24fa478745ac6d40`.
The two builds must not be conflated.

Recorded commands in the detached checkout:

```text
lake build Iut
lake env lean CurrentLocalTheoryNoGoAudit.lean
```

Both exited zero. The first completed 8,758 jobs. The second reported for each
of `Iut.localTheory_false_latest` and `Iut.localTheory_isEmpty_latest` exactly
the axiom set `[propext, Classical.choice, Quot.sound]`.

Frozen SHA-256 values before package sealing:

| Object | SHA-256 |
|---|---|
| upstream `Iut/Concrete/LocalTheory.lean` | `e52b4b943d8e75799e503e0f23dac8ce41337413ec9d068437e6d4d071b3b209` |
| upstream `lake-manifest.json` | `76d0a9c08a2c9e1ce1db52c2d455823c907d0f89f9681765c367cb25f3baf225` |
| upstream `lean-toolchain` | `56a12c348c1fb7bb3e6475757349976a7e93e94fa2918bf92811b1b2e9634504` |
| detached audit source | `298a85b116c2c09c3cffc2b7c59a4f3b663762f6e6d98941b18e66cde06524af` |
| detached build log | `db1da4a645dd1622653b6ab420efedce03b5a2e038fd11fe74c37a3b0753f7cb` |
| detached audit log | `2df9ce0ee78d782ce363db9eeac878572db3fbd637c1b6a55a98d9875d5f1e6d` |

The full copied source, exact manifest, audit source, logs, and exit-code files
are included beside this note. The counterexample concerns the unrestricted
total-real-valued field only. It does not reject a repaired nonempty finite
positive-volume domain, IUT, or abc.

