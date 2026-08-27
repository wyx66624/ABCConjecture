#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
stem="$root/p31_chebyshev_bdf_threshold_scan"
source_ledger="$stem.source"
script="$stem.sage"
wrapper="$root/run_p31_chebyshev_bdf_threshold_scan.sh"
transcript="$stem.transcript"
meta="$stem.meta"
exit_record="$stem.exit"
document="Lean/P31_CHEBYSHEV_BDF_THRESHOLD_SCAN.md"
maker="$root/make_p31_chebyshev_bdf_threshold_scan_manifest.sh"
manifest="$stem.sha256"
tmp="${manifest}.tmp.$$"
image="sagemath/sagemath:10.9"

files=(
  "$source_ledger"
  "$script"
  "$wrapper"
  "$transcript"
  "$meta"
  "$exit_record"
  "$document"
  "$maker"
)

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

for file in "${files[@]}"; do
  test -f "$file"
done

test "$(tr -d '\r\n' < "$exit_record")" = "0"
grep -Fqx 'EXIT_CODE=0' "$transcript"
grep -Fqx 'P31_BDF_THRESHOLD_SCAN_COMPLETE' "$transcript"
grep -Fqx 'NO_PRINCIPAL_WITNESSES_CONSTRUCTED=1' "$transcript"
grep -Fqx 'FIRST_SCANNED_DEGREE_ONE_PASS = 160000000' "$transcript"
grep -Fqx 'FIRST_SCANNED_FULL_BDF_PASS = 80000000' "$transcript"
grep -Fqx 'directly_factored_higher_degree_rational_primes = 78' "$transcript"

awk '
  /^THRESHOLD_BEGIN / { threshold=$2 }
  /^degree_one_margin_lower_endpoint = / { degree_lower[threshold]=$3 }
  /^degree_one_margin_upper_endpoint = / { degree_upper[threshold]=$3 }
  /^full_margin_lower_endpoint = / { full_lower[threshold]=$3 }
  /^full_margin_upper_endpoint = / { full_upper[threshold]=$3 }
  END {
    if (!(degree_upper[40000000] < 0)) exit 1
    if (!(full_upper[40000000] < 0)) exit 2
    if (!(degree_upper[80000000] < 0)) exit 3
    if (!(full_lower[80000000] > 0)) exit 4
    if (!(degree_lower[160000000] > 0 && full_lower[160000000] > 0)) exit 5
    if (!(degree_lower[320000000] > 0 && full_lower[320000000] > 0)) exit 6
  }
' "$transcript"

for expected in \
  'DEGREE_ONE_RESULT=STRICT_NEGATIVE' \
  'FULL_BDF_RESULT=STRICT_NEGATIVE' \
  'FULL_BDF_RESULT=PASS' \
  'DEGREE_ONE_RESULT=PASS'; do
  grep -Fqx "$expected" "$transcript"
done

awk '
  /^THRESHOLD_BEGIN / { threshold=$2 }
  threshold == 80000000 && /^rational_primes_below_threshold = / { rp=$3 }
  threshold == 80000000 && /^degree_one_prime_ideals = / { d1=$3 }
  threshold == 80000000 && /^full_prime_ideals = / { full=$3 }
  threshold == 80000000 && /^degree_one_prime_power_terms = / { d1p=$3 }
  threshold == 80000000 && /^full_prime_ideal_power_terms = / { fullp=$3 }
  threshold == 80000000 && /^prime_ideal_counts_by_residue_degree = / {
    degrees=substr($0, index($0, "{") )
  }
  END {
    if (rp != 4669382 || d1 != 4667696 || full != 4668356) exit 1
    if (d1p != 4668998 || fullp != 4669693) exit 2
    if (degrees != "{1: 4667696, 2: 600, 3: 60}") exit 3
  }
' "$transcript"

grep -Fqx 'CONTAINER_ELAPSED_SECONDS=144' "$transcript"
grep -Fqx 'CONTAINER_MEMORY_PEAK_BYTES=732934144' "$transcript"
grep -Fqx 'CONTAINER_MEMORY_CURRENT_BYTES=323555328' "$transcript"

test "$(sed -n 's/^SCRIPT_SHA256=//p' "$meta")" = "$(sha256sum -- "$script" | cut -d ' ' -f 1)"
test "$(sed -n 's/^SOURCE_LEDGER_SHA256=//p' "$meta")" = "$(sha256sum -- "$source_ledger" | cut -d ' ' -f 1)"
test "$(sed -n 's/^WRAPPER_SHA256=//p' "$meta")" = "$(sha256sum -- "$wrapper" | cut -d ' ' -f 1)"
grep -Fqx 'PRECISION_BITS=256' "$meta"
grep -Fqx 'THRESHOLDS=40000000,80000000,160000000,320000000' "$meta"
grep -Fqx 'MAX_BOUND_STRICT=320000000' "$meta"
grep -Fqx 'SEGMENT_LENGTH=1000000' "$meta"
grep -Fqx 'NO_PRINCIPAL_WITNESSES=1' "$meta"

recorded_image_id="$(sed -n 's/^DOCKER_IMAGE_ID=//p' "$meta")"
current_image_id="$(docker image inspect "$image" --format '{{.Id}}')"
test "$recorded_image_id" = "$current_image_id"
recorded_repo_digests="$(sed -n 's/^DOCKER_REPO_DIGESTS=//p' "$meta")"
current_repo_digests="$(docker image inspect "$image" --format '{{json .RepoDigests}}')"
test "$recorded_repo_digests" = "$current_repo_digests"

for file in "${files[@]}"; do
  sha256sum -- "$file" >> "$tmp"
done
mv -f -- "$tmp" "$manifest"
sha256sum -c "$manifest"
printf '%s\n' 'P31_BDF_THRESHOLD_SCAN_MANIFEST_PASS'
