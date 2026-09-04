# Verification: packet radical-excess obstruction

This frozen checkpoint verifies the independent module, its complete axiom
inventory, the exhaustive integer search, and the inputtable English paper
fragment.

Run from the repository root:

```powershell
Push-Location Lean
lake env lean -DwarningAsError=true `
  IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903.lean
lake build `
  IUTThreeClosures.SynchronizedPacketRadicalExcessObstruction20260903
lake env lean -DwarningAsError=true `
  IUTThreeClosures/SynchronizedPacketRadicalExcessObstruction20260903AxiomAudit.lean
Pop-Location

python research/computation/2026_09_03_packet_radical_excess_obstruction/search_packet_radical_excess.py `
  --limit 3000 --dyadic-limit 20 `
  --output research/computation/2026_09_03_packet_radical_excess_obstruction/OUTPUT.json

python research/verification/2026_09_03_packet_radical_excess_obstruction/verify_artifacts.py
```

The paper wrapper was compiled with bundled Tectonic via the
`latex:latex-compile` skill.  `latex-compile.json` records the exact command,
two-pass log, exit code, and PDF path.

Verified facts:

- 37 new Lean declarations and 37 `#print axioms` targets;
- direct main and audit compilation with `-DwarningAsError=true`;
- axiom union exactly `propext`, `Classical.choice`, and `Quot.sound`;
- no `sorry`, `admit`, custom `axiom`, or `native_decide` in the main module;
- 1,365,095 primitive triples and 1,366,531 full-premise packets exhausted;
- all 21 tested dyadic rows pass the exact obstruction assertions;
- search script self-hash and computation checksums match;
- all authored text is UTF-8 with no disallowed C0 controls;
- the English fragment compiles to a three-page PDF.

`SHA256SUMS` seals all authored inputs, computation outputs, compile logs,
exit-code files, verifier output, and the compiled fragment PDF.  It is a
checksum manifest, not a digital signature or timestamp.
