# Replay commands

The full portable replay is:

    & '.\Lean\verification\2026_09_01_global_packet_continuation\validate.ps1'

The package integrity replay is:

    & '.\Lean\verification\2026_09_01_global_packet_continuation\verify-package.ps1'

The Lean commands executed by the driver from the `Lean` directory are equivalent to:

    lake env lean IUTThreeClosures/AffineRadicalStep20260901.lean
    lake env lean IUTThreeClosures/DanilovRecursiveLift20260901.lean
    lake env lean IUTThreeClosures/DanilovSimplePrimitiveNoGo20260901.lean
    lake env lean IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean
    lake env lean IUTThreeClosures/PellPrimeRankCounterexamples20260901.lean
    lake build IUTThreeClosures

The driver also invokes the frozen specialized IUT replay through the current PowerShell executable:

    & '.\Lean\verification\2026_09_01_iut_lana_specification_nogo\replay.ps1'

The manifest and source scans are implemented in `validate.ps1` so that failures terminate the run with a nonzero PowerShell exit status.
