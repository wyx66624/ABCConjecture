# Reproduction commands

Run from any directory in PowerShell:

```powershell
& 'E:\AImath\abc猜想\Lean\verification\2026_09_01_prime_unit_two_arm_layer\validate.ps1'
& 'E:\AImath\abc猜想\Lean\verification\2026_09_01_prime_unit_two_arm_layer\verify-package.ps1'
```

The first command verifies the frozen source snapshot and reruns every Lean,
source-ledger, and finite-computation check.  Ordinary reruns write into the
repository's ignored `tmp/verification` directory, so they do not mutate the
sealed evidence.  The second command verifies the exact immutable file set of
this validation package; it therefore still passes after an ordinary rerun.

Maintainers first stage every intended mathematical, formal, paper, and
evidence input. The freeze step accepts only stage-zero Git-indexed inputs and
requires each working-tree file to be byte-identical to its indexed blob; local
ignored/untracked scratch files are excluded. They then create
`input-manifest.json` and record one audited run with:

```powershell
& 'E:\AImath\abc猜想\Lean\verification\2026_09_01_prime_unit_two_arm_layer\validate.ps1' -FreezeInputs
& 'E:\AImath\abc猜想\Lean\verification\2026_09_01_prime_unit_two_arm_layer\validate.ps1' -Record
```

They create `SHA256SUMS` only after that successful recorded run:

```powershell
& 'E:\AImath\abc猜想\Lean\verification\2026_09_01_prime_unit_two_arm_layer\freeze-package.ps1'
```

The freeze command refuses to overwrite an existing `SHA256SUMS`. Both the
freeze and verification commands require the exact eight-module inventory, the
exact fourteen-run inventory, every recorded log and exit-code file, and every
recorded log SHA-256 value.
