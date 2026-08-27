#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

must_have() {
  grep -Fqx "$2" "$1" || { echo "missing marker in $1: $2" >&2; exit 1; }
}

test "$(cat p31_chebyshev_bdf_threshold_scan.exit)" = 0
grep -Fq 'THRESHOLD_BEGIN 80000000' p31_chebyshev_bdf_threshold_scan.transcript
must_have p31_chebyshev_bdf_threshold_scan.transcript 'FULL_BDF_RESULT=PASS'
grep -Fq 'full_margin_lower_endpoint = 0.2944058601757084546999811576257929871041149041402660860920359033230486824475' p31_chebyshev_bdf_threshold_scan.transcript
(cd ../.. && sha256sum -c Lean/audit_scripts/p31_chebyshev_bdf_threshold_scan.sha256 >/dev/null)

test "$(sha256sum p31_chebyshev_cl1_bdf_principal_generators_generation_v1.gp | cut -d' ' -f1)" = 069354f279a1ab49282bd25886f878ca7804da13a826f41cea44021bbe1edcd5
grep -Fqx 'PRODUCER_SHA256=069354f279a1ab49282bd25886f878ca7804da13a826f41cea44021bbe1edcd5' p31_chebyshev_cl1_bdf_principal_generation_attempt1.meta
grep -Fqx 'PRODUCER_SHA256=069354f279a1ab49282bd25886f878ca7804da13a826f41cea44021bbe1edcd5' p31_chebyshev_cl1_bdf_principal_publish_attempt2.meta
test "$(cat p31_chebyshev_cl1_bdf_principal_generation_attempt1.exit)" = 1
test "$(cat p31_chebyshev_cl1_bdf_principal_publish_attempt2.exit)" = 1
grep -Fq 'PRESERVED_TEMP_DIR=' p31_chebyshev_cl1_bdf_principal_generation_attempt1.transcript
grep -Fq 'PRESERVED_PUBLISH_DIR=' p31_chebyshev_cl1_bdf_principal_publish_attempt2.transcript
grep -Fq 'P31_BDF_PRINCIPAL_GENERATION_PASS' p31_chebyshev_cl1_bdf_principal_publish_attempt2.transcript
grep -Fq 'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS' p31_chebyshev_cl1_bdf_principal_publish_attempt2.transcript

test "$(cat p31_chebyshev_cl1_bdf_principal_smoke.exit)" = 0
must_have p31_chebyshev_cl1_bdf_principal_smoke.transcript 'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS'
! grep -Fqi 'syntax error' p31_chebyshev_cl1_bdf_principal_smoke.transcript
grep -Fqx "PRODUCER_SHA256=$(sha256sum p31_chebyshev_cl1_bdf_principal_generators.gp | cut -d' ' -f1)" p31_chebyshev_cl1_bdf_principal_smoke.meta

test "$(cat p31_chebyshev_cl1_bdf_principal_full.exit)" = 0
for marker in \
  'STRICT_NORM_BOUND=80000000' \
  'VERIFIED_SHARDS=16' \
  'VERIFIED_FACTOR_BASE_IDEALS=4668356' \
  'VERIFIED_HIGHER_DEGREE_IDEALS=660' \
  'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 4667696, 2: 600, 3: 60}' \
  'NO_BNF_OR_CLASS_GROUP_USED=1' \
  'NO_UNIT_GROUP_OR_REGULATOR_USED=1' \
  'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS' \
  'P31_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS' \
  'P31_BDF_PRINCIPAL_PUBLISH_RECOVERY_PASS' \
  'EXIT_CODE=0'; do
  must_have p31_chebyshev_cl1_bdf_principal_full.transcript "$marker"
done

test "$(sha256sum p31_chebyshev_cl1_bdf_principal_publish_attempt2.transcript | cut -d' ' -f1)" = "$(sed -n 's/^PUBLISH_ATTEMPT2_TRANSCRIPT_SHA256=//p' p31_chebyshev_cl1_bdf_principal_full.meta)"
test "$(sha256sum p31_chebyshev_cl1_bdf_principal_publish_attempt2.meta | cut -d' ' -f1)" = "$(sed -n 's/^PUBLISH_ATTEMPT2_META_SHA256=//p' p31_chebyshev_cl1_bdf_principal_full.meta)"
test "$(sha256sum p31_chebyshev_cl1_bdf_principal_publish_attempt2.exit | cut -d' ' -f1)" = "$(sed -n 's/^PUBLISH_ATTEMPT2_EXIT_SHA256=//p' p31_chebyshev_cl1_bdf_principal_full.meta)"

pushd p31_chebyshev_cl1_bdf_principal_shards_v1 >/dev/null
test "$(wc -l < SHARDS.sha256)" -eq 16
sha256sum -c SHARDS.sha256 >/dev/null
for shard in p31_bdf_principal_*.tsv.gz; do gzip -t "$shard"; done
test "$(find . -maxdepth 1 -name 'p31_bdf_principal_*.tsv.gz' | wc -l)" -eq 16
test "$(find . -maxdepth 1 -name 'p31_bdf_principal_*.tsv.gz' -printf '%s\n' | awk '{s+=$1} END{print s}')" = 200764930
popd >/dev/null

files=(
  p31_chebyshev_bdf_threshold_scan.source
  p31_chebyshev_bdf_threshold_scan.sage
  run_p31_chebyshev_bdf_threshold_scan.sh
  make_p31_chebyshev_bdf_threshold_scan_manifest.sh
  p31_chebyshev_bdf_threshold_scan.transcript
  p31_chebyshev_bdf_threshold_scan.meta
  p31_chebyshev_bdf_threshold_scan.exit
  p31_chebyshev_bdf_threshold_scan.sha256
  ../P31_CHEBYSHEV_BDF_THRESHOLD_SCAN.md
  p31_chebyshev_cl1_bdf_principal_generators_generation_v1.gp
  p31_chebyshev_cl1_bdf_principal_generators.gp
  p31_chebyshev_cl1_bdf_principal_verify.sage
  p31_chebyshev_cl1_bdf_principal_shard_boundaries.sage
  run_p31_chebyshev_cl1_bdf_principal_smoke.sh
  p31_chebyshev_cl1_bdf_principal_smoke.transcript
  p31_chebyshev_cl1_bdf_principal_smoke.meta
  p31_chebyshev_cl1_bdf_principal_smoke.exit
  run_p31_chebyshev_cl1_bdf_principal_full.sh
  run_p31_chebyshev_cl1_bdf_principal_publish_recovery.sh
  p31_chebyshev_cl1_bdf_principal_generation_attempt1.transcript
  p31_chebyshev_cl1_bdf_principal_generation_attempt1.meta
  p31_chebyshev_cl1_bdf_principal_generation_attempt1.exit
  p31_chebyshev_cl1_bdf_principal_publish_attempt2.transcript
  p31_chebyshev_cl1_bdf_principal_publish_attempt2.meta
  p31_chebyshev_cl1_bdf_principal_publish_attempt2.exit
  p31_chebyshev_cl1_bdf_principal_full.transcript
  p31_chebyshev_cl1_bdf_principal_full.meta
  p31_chebyshev_cl1_bdf_principal_full.exit
  p31_chebyshev_cl1_bdf_principal_shards_v1/SHARDS.sha256
  ../P31_CL1_BDF_FACTORBASE_ROUTE.md
  make_p31_chebyshev_cl1_bdf_principal_manifest.sh
)
for shard in p31_chebyshev_cl1_bdf_principal_shards_v1/p31_bdf_principal_*.tsv.gz; do files+=("$shard"); done

sha256sum "${files[@]}" > p31_chebyshev_cl1_bdf_principal.sha256
test "$(wc -l < p31_chebyshev_cl1_bdf_principal.sha256)" -eq 47
echo P31_BDF_PRINCIPAL_MANIFEST_PASS
