# Exact validation commands

All commands were run in PowerShell on 2026-09-01.  Raw outputs and recorded
exit codes are under `logs/`.

## Pinned LANA snapshot

Working directory:

```text
E:\AImath\abc猜想\tmp\lana_iut_2026_09_01
```

For a fresh dependency checkout, initialize the official mathlib cache once:

```powershell
lake exe cache get
```

Then run:

```powershell
lake build Iut.Cor312.Statement
lake build Iut.Cor312.SpecificationNoGoAudit
lake env lean Iut/Cor312/SpecificationNoGoAudit.lean
```

The three corresponding logs are
`logs/upstream-statement-build.log`, `logs/upstream-audit-build.log`, and
`logs/upstream-audit-direct-lean.log`.

## Main project

Working directory:

```text
E:\AImath\abc猜想\Lean
```

Run:

```powershell
lake build IUTThreeClosures.IUTLanaSpecificationNoGo20260901
lake env lean IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean
lake build IUTThreeClosures
```

The corresponding logs are `logs/main-audit-build.log`,
`logs/main-audit-direct-lean.log`, and `logs/main-aggregate-build.log`.

## Source and axiom scans

The prohibited-token scan used PCRE2 word boundaries so that the required
command `#print axioms` is not confused with an `axiom` declaration:

```powershell
rg -n --pcre2 '(?<![A-Za-z0-9_])(sorry|admit|native_decide|axiom|opaque|unsafe)(?![A-Za-z0-9_])' `
  tmp/lana_iut_2026_09_01/Iut/Cor312/SpecificationNoGoAudit.lean `
  Lean/IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean
```

The `#print axioms` logs were checked with:

```powershell
rg -n -S sorryAx Lean/verification/2026_09_01_iut_lana_specification_nogo/logs -g '*audit*.log'
```

Both searches returned no matches; this expected no-match condition is
recorded explicitly in `logs/forbidden-scan.log`.
