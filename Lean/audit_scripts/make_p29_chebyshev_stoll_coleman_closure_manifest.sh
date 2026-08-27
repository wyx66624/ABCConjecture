#!/usr/bin/env bash
set -euo pipefail

# Assemble the complete fixed-index p=29 closure ledger.  This maker reruns
# the semantic gates of the nested global and Stoll manifest-makers, then
# checks every decisive Coleman datum before freezing the outer byte set.

root="Lean/audit_scripts"
manifest="$root/p29_chebyshev_stoll_coleman_closure.sha256"
tmp="${manifest}.tmp.$$"

global_maker="$root/make_p29_chebyshev_global_dyadic_manifest.sh"
global_manifest="$root/p29_chebyshev_global_dyadic_overapprox.sha256"
stoll_maker="$root/make_p29_chebyshev_stoll_gamma2_manifest.sh"
stoll_manifest="$root/p29_chebyshev_stoll_gamma2.sha256"

coleman_source="$root/p29_chebyshev_gamma2_coleman.sage"
coleman_wrapper="$root/run_p29_chebyshev_gamma2_coleman.sh"
coleman_transcript="$root/p29_chebyshev_gamma2_coleman.transcript"
coleman_meta="$root/p29_chebyshev_gamma2_coleman.meta"
coleman_exit="$root/p29_chebyshev_gamma2_coleman.exit"

lean_companion="Lean/IUTThreeClosures/FreyPellChebyshevIndexTwentyNineStollGammaCertificate.lean"
prime_reduction="Lean/IUTThreeClosures/FreyPellChebyshevPrimeIndexReduction.lean"
axiom_audit="Lean/IUTThreeClosures/AxiomAudit.lean"
report="Lean/P29_CHEBYSHEV_STOLL_COLEMAN_CLOSURE.md"

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

for required in \
  "$global_maker" "$global_manifest" \
  "$stoll_maker" "$stoll_manifest" \
  "$coleman_source" "$coleman_wrapper" "$coleman_transcript" \
  "$coleman_meta" "$coleman_exit" \
  "$lean_companion" "$prime_reduction" "$axiom_audit" "$report" "$0"; do
  test -f "$required"
done

# Re-execute the semantic gates of both nested certificate makers.  Their
# manifests are deterministic lists of hashes, so this also rejects any stale
# prerequisite before the outer manifest is produced.
bash "$global_maker"
bash "$stoll_maker"
sha256sum -c -- "$global_manifest"
sha256sum -c -- "$stoll_manifest"

# The Coleman metadata must bind the exact executable inputs being packaged.
test "$(tr -d '\r\n' < "$coleman_exit")" = 0
grep -Fqx "SOURCE_SHA256=$(hash_file "$coleman_source")" "$coleman_meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$coleman_wrapper")" "$coleman_meta"
grep -Fqx 'SAGE_VERSION=SageMath version 10.9, Release Date: 2026-05-04' \
  "$coleman_meta"
grep -Fqx 'P_ADIC_PRIME=5' "$coleman_meta"
grep -Fqx 'Q5_PRECISION=110' "$coleman_meta"
grep -Fqx 'GENUS=14' "$coleman_meta"
grep -Fq 'COLEMAN_START_UTC=' "$coleman_meta"
grep -Fq 'COLEMAN_END_UTC=' "$coleman_meta"
grep -Fq 'END_UTC=' "$coleman_meta"

# Exact model, good-reduction, irreducibility, and simple-root assertions are
# part of the frozen source rather than inferred from transcript prose.
grep -Fqx 'assert f.is_irreducible()' "$coleman_source"
grep -Fqx 'assert f.discriminant().valuation(p) == 0' "$coleman_source"
grep -Fqx 'assert f5_roots == [(k(0), 1)]' "$coleman_source"
grep -Fqx 'assert contents == [1, 1]' "$coleman_source"
grep -Fqx 'pair = (0, 2)' "$coleman_source"
grep -Fq 'K(ZZ(cbar[j]))' "$coleman_source"

# Full exact Coleman output shape: six points, one simple mod-5 root, the
# normalized 2 x 14 matrix, rank, annihilator, unit minor, precision margin,
# and unique Q_5 Weierstrass lift.
grep -Fqx \
  'GOOD_REDUCTION_POINTS [(1 : 0 : 0), (0 : 0 : 1), (1 : 1 : 1), (1 : 4 : 1), (4 : 2 : 1), (4 : 3 : 1)]' \
  "$coleman_transcript"
grep -Fqx 'F5_WEIERSTRASS_ROOTS [(0, 1)]' "$coleman_transcript"
grep -Fqx 'LOG_CONTENTS [1, 1]' "$coleman_transcript"
test "$(grep -c '^NORMALIZED_LOG_REDUCTION$' "$coleman_transcript")" = 1
grep -Fqx '[1 0 3 1 4 0 3 3 0 2 2 0 1 0]' "$coleman_transcript"
grep -Fqx '[2 0 2 3 2 0 4 2 2 1 4 3 2 3]' "$coleman_transcript"
grep -Fqx 'NORMALIZED_LOG_RANK 2' "$coleman_transcript"
grep -Fqx \
  'ANNIHILATOR_REDUCTION (4, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1) EVALS [4, 3, 4, 1]' \
  "$coleman_transcript"
grep -Fqx 'UNIT_MINOR (0, 2) DET_REDUCTION 1' "$coleman_transcript"
grep -Fqx \
  'DOTS [O(5^107), O(5^107)] DOT_PRECISIONS [107, 107]' \
  "$coleman_transcript"
grep -Fqx 'Q5_ROOTS 1 ROOT_REDUCTIONS [0]' "$coleman_transcript"
grep -Fqx 'P29_GOOD_REDUCTION_F5_POINT_COUNT=6' "$coleman_transcript"
grep -Fqx 'P29_ENDPOINT_LOG_CONTENTS_1_1' "$coleman_transcript"
grep -Fqx 'P29_NORMALIZED_LOG_RANK_2' "$coleman_transcript"
grep -Fqx 'P29_ANNIHILATOR_EVALS_4_3_4_1' "$coleman_transcript"
grep -Fqx 'P29_UNIT_MINOR_COLUMNS_0_2' "$coleman_transcript"
grep -Fqx 'P29_GAMMA2_COLEMAN_LOCAL_CERTIFICATE_PASS' "$coleman_transcript"
grep -Fqx 'COLEMAN_EXIT_CODE=0' "$coleman_transcript"
grep -Fqx 'P29_GAMMA2_COLEMAN_FROZEN_RUN_PASS' "$coleman_transcript"
grep -Fqx 'EXIT_CODE=0' "$coleman_transcript"
! grep -Eq 'Traceback|AssertionError|(^|[^A-Z_])ERROR([^A-Z_]|$)' \
  "$coleman_transcript"

# The composition ledger must preserve the precise mathematical boundary:
# ordinary integer lifts, exact lift from the unit minor, diskwise rather than
# p>2g point counting, and an explicit residual uniform statement.
grep -Fq 'ordinary integer representative' "$report"
grep -Fq 'finite-precision zeros are a stability margin' "$report"
grep -Fq 'difference quotient is therefore a 5-adic unit' "$report"
grep -Fq 'five rational anchors' "$report"
grep -Fq 'The point `W` is not rational' "$report"
grep -Fq 'X=4x' "$report"
grep -Fq 'D_-=[P_--O]=-2*H1' "$report"
grep -Fq 'Only the two' "$report"
grep -Fq 'anchors with `T=-1` remain' "$report"
grep -Fq 'primes at least `31`' "$report"

# Bind the current transparent Lean interface and the exact residual shift.
grep -Fq 'pellChebyshevTwentyNine_stollGammaColemanUnitMinorLedger' \
  "$lean_companion"
grep -Fq 'pellChebyshevTwentyNine_saturatedIntegralZeroLedger' \
  "$lean_companion"
grep -Fq 'PARISageRationalTargetDiskCertificateIndexTwentyNine' \
  "$lean_companion"
grep -Fq 'OddPrimeShiftSquareExclusionAtLeastThirtyOne' "$prime_reduction"
grep -Fq \
  'IUTThreeClosures.pellChebyshevTwentyNine_stollGammaColemanUnitMinorLedger' \
  "$axiom_audit"
grep -Fq \
  'IUTThreeClosures.pellChebyshevTwentyNine_saturatedIntegralZeroLedger' \
  "$axiom_audit"

files=(
  "$global_manifest"
  "$stoll_manifest"
  "$coleman_source"
  "$coleman_wrapper"
  "$coleman_transcript"
  "$coleman_meta"
  "$coleman_exit"
  "$lean_companion"
  "$prime_reduction"
  "$axiom_audit"
  "$report"
  "$0"
)

test "${#files[@]}" -eq 12
sha256sum -- "${files[@]}" > "$tmp"
test "$(wc -l < "$tmp")" -eq 12
mv -f -- "$tmp" "$manifest"
sha256sum -c -- "$manifest"
printf 'P29_STOLL_COLEMAN_CLOSURE_MANIFEST_PASS\n'
