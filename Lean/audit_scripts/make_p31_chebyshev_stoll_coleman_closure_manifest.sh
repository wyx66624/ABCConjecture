#!/usr/bin/env bash
set -euo pipefail

# Assemble the complete fixed-index p=31 Stoll--Coleman closure ledger.  The
# two numerical packages remain independently reproducible: this maker reruns
# both semantic gates, checks the composition boundary, and then freezes the
# exact outer byte set used by the Lean/status integration.

root="Lean/audit_scripts"
manifest="$root/p31_chebyshev_stoll_coleman_closure.sha256"
tmp="${manifest}.tmp.$$"

formal_maker="$root/make_p31_chebyshev_stoll_gamma2_formal12k_manifest.sh"
formal_manifest="$root/p31_chebyshev_stoll_gamma2_formal12k.sha256"
coleman_maker="$root/make_p31_chebyshev_gamma2_coleman_local_manifest.sh"
coleman_manifest="$root/p31_chebyshev_gamma2_coleman_local.sha256"

algebra_core="Lean/IUTThreeClosures/FreyPellChebyshevIndexThirtyOneAlgebraicCore.lean"
lean_companion="Lean/IUTThreeClosures/FreyPellChebyshevIndexThirtyOneStollGammaCertificate.lean"
prime_reduction="Lean/IUTThreeClosures/FreyPellChebyshevPrimeIndexReduction.lean"
local_barrier="Lean/IUTThreeClosures/FreyPellChebyshevPrimeIndexLocalPermutationBarrier.lean"
axiom_audit="Lean/IUTThreeClosures/AxiomAudit.lean"
umbrella="Lean/IUTThreeClosures.lean"
report="Lean/P31_CHEBYSHEV_STOLL_COLEMAN_CLOSURE.md"
threshold_report="Lean/FREY_PELL_CHEBYSHEV_POST_P31_UNIFORM_THRESHOLD.md"
literature_report="Lean/FREY_PELL_CHEBYSHEV_POST_P31_LITERATURE_AUDIT.md"
research_status="Lean/RESEARCH_STATUS.md"

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

for required in \
  "$formal_maker" "$formal_manifest" \
  "$coleman_maker" "$coleman_manifest" \
  "$algebra_core" "$lean_companion" "$prime_reduction" "$local_barrier" \
  "$axiom_audit" "$umbrella" "$report" "$threshold_report" \
  "$literature_report" "$research_status" "$0"; do
  test -f "$required"
done

# Re-execute the complete formal-12k and Coleman-local semantic gates.  The
# formal manifest is rooted in audit_scripts, whereas the Coleman manifest
# records repository-root paths.
bash "$formal_maker"
bash "$coleman_maker"
(
  cd "$root"
  sha256sum -c -- "$(basename "$formal_manifest")"
)
sha256sum -c -- "$coleman_manifest"
test "$(wc -l < "$formal_manifest")" -eq 10
test "$(wc -l < "$coleman_manifest")" -eq 7

# Preserve the exact mathematical boundary of the composition: Stoll yields
# rational saturation, the unit minor supplies exact Coleman annihilation,
# and diskwise injectivity is used because 5 is not greater than 2g.
grep -Fq 'J(Q_2)[2]=0' "$report"
grep -Fq 'Sat_Q(Gamma2)' "$report"
grep -Fq 'ordinary integer lifts' "$report"
grep -Fq 'finite-precision zeros certify a stability margin' "$report"
grep -Fq 'difference quotient' "$report"
grep -Fq 'five rational anchors' "$report"
grep -Fq 'Weierstrass zero is not rational' "$report"
grep -Fq 'X=4x' "$report"
grep -Fq 'D_-=[P_--O]=-2*H1' "$report"
grep -Fq 'only the two points with `T=-1`' "$report"
grep -Fq 'primes `p>=37`' "$report"
grep -Fq 'closure manifest binds these nested manifests' "$report"
grep -Fq 'No GRH, BSD' "$report"

# Bind the transparent Lean interface and the exact residual shift from 31 to
# 37.  The rational-point certificate remains a proposition supplied by the
# accepted external proof, never a hidden Lean axiom.
grep -Fq 'pellChebyshevThirtyOne_stollGammaValuationMarginLedger' \
  "$lean_companion"
grep -Fq '2000 < 12021' "$lean_companion"
grep -Fq '2000 < 9795' "$lean_companion"
grep -Fq 'pellChebyshevThirtyOne_saturatedIntegralZeroLedger' \
  "$lean_companion"
grep -Fq 'pellChebyshevThirtyOne_stollGammaColemanUnitMinorLedger' \
  "$lean_companion"
grep -Fq 'PARISageRationalTargetDiskCertificateIndexThirtyOne' \
  "$lean_companion"
grep -Fq 'OddPrimeShiftSquareExclusionAtLeastThirtySeven' "$prime_reduction"
grep -Fq 'prime_eq_thirtyOne_of_ge_thirtyOne_lt_thirtySeven' \
  "$prime_reduction"
grep -Fq 'oddChebyshevIndex_primeDivisor_reduction_atLeastThirtySeven' \
  "$prime_reduction"
grep -Fq 'no_oddChebyshevIndex_shiftSquare_of_primeRanges_afterThirtyOne' \
  "$prime_reduction"
grep -Fq 'pellPrimeLocal_thirtySevenThreshold' "$local_barrier"
grep -Fq 'pellPrimeLocal_fourThirtySevenParityThreshold' "$local_barrier"
grep -Fq 'pellPrimeLocal_activeHeightFloorAfterThirtyOne' "$local_barrier"
grep -Fq \
  'IUTThreeClosures.pellChebyshevThirtyOne_stollGammaColemanUnitMinorLedger' \
  "$axiom_audit"
grep -Fq \
  'IUTThreeClosures.oddChebyshevIndex_primeDivisor_reduction_atLeastThirtySeven' \
  "$axiom_audit"
grep -Fq 'IUTThreeClosures.pellPrimeLocal_thirtySevenThreshold' \
  "$axiom_audit"
grep -Fq 'IUTThreeClosures.pellPrimeLocal_fourThirtySevenParityThreshold' \
  "$axiom_audit"
grep -Fq 'IUTThreeClosures.pellPrimeLocal_activeHeightFloorAfterThirtyOne' \
  "$axiom_audit"
grep -Fq \
  'import IUTThreeClosures.FreyPellChebyshevIndexThirtyOneStollGammaCertificate' \
  "$umbrella"

# The post-p31 reports and status must state the improved scale while retaining
# the unresolved uniform boundary.  The literature audit must not smuggle in
# a fixed-index finiteness theorem as an effective uniform exclusion.
grep -Fq '4/37' "$threshold_report"
grep -Fq '1519^37' "$threshold_report"
grep -Fq '260000000000000000000000000000' "$threshold_report"
grep -Fq 'does not prove' "$threshold_report"
grep -Fq 'p\ge37' "$literature_report"
grep -Fq 'Bilu--Tichy' "$literature_report"
grep -Fq 'Runge' "$literature_report"
grep -Fq 'prescribed-Frobenius' "$literature_report"
grep -Fq 'p>=37' "$research_status"
grep -Fq '4/37' "$research_status"
grep -Fq '260000000000000000000000000000' "$research_status"

files=(
  "$formal_manifest"
  "$coleman_manifest"
  "$algebra_core"
  "$lean_companion"
  "$prime_reduction"
  "$local_barrier"
  "$axiom_audit"
  "$umbrella"
  "$report"
  "$threshold_report"
  "$literature_report"
  "$research_status"
  "$0"
)

test "${#files[@]}" -eq 13
sha256sum -- "${files[@]}" > "$tmp"
test "$(wc -l < "$tmp")" -eq 13
mv -f -- "$tmp" "$manifest"
sha256sum -c -- "$manifest"
printf 'P31_STOLL_COLEMAN_CLOSURE_MANIFEST_PASS\n'
