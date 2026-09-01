# Replay commands

The full portable replay is:

    & '.\Lean\verification\2026_09_01_holonomy_depth_continuation\validate.ps1'

The package integrity replay is:

    & '.\Lean\verification\2026_09_01_holonomy_depth_continuation\verify-package.ps1'

The Lean commands executed from the `Lean` directory are equivalent to:

    lake env lean IUTThreeClosures/AffineDensityAttack20260901.lean
    lake env lean IUTThreeClosures/DanilovWSSEscape20260901.lean
    lake env lean IUTThreeClosures/IUTCorrectedVolumeHolonomy20260901.lean
    lake env lean IUTThreeClosures/PellFourPrimeCoupling20260901.lean
    lake build IUTThreeClosures

The lightweight Python replays are equivalent to:

    python research/computation/2026_09_01_affine_density_attack/verify_square_conic.py
    python research/computation/2026_09_01_pell_four_prime_coupling/verify_manifest.py
    python research/computation/2026_09_01_pell_four_prime_coupling/verify_hits_bigint.py
    python research/computation/2026_09_01_pell_four_prime_coupling/verify_coupling_examples.py
    python research/computation/2026_09_01_danilov_wss_escape/verify_manifest.py
    python research/computation/2026_09_01_danilov_wss_escape/verify_wss_escape_claims.py
    python research/sources/iut_corrected_volume_holonomy_2026_09_01/verify_source_metadata.py

The driver does not rerun `depth3_scan_segmented.cpp` or `verify_depth3_scan_dense.cpp` through `q <= 10^9`. Their sources and recorded outputs are frozen by `SHA256SUMS`; the independent arbitrary-precision replay checks every recorded hit.

All manifest, source, forbidden-artifact, declaration, axiom, and frozen-input checks are implemented in `validate.ps1`. Any disagreement terminates the run with a nonzero PowerShell exit status.
