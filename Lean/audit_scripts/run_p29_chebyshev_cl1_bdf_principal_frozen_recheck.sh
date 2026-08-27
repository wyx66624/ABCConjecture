#!/usr/bin/env bash
set -euo pipefail

# Recheck the two accepted interfaces that imply Cl(Q(2^(1/29)))=1:
# the unconditional BDF factor-base inequality and exact principality of every
# prime ideal in that factor base.  No BNF or class-group computation is used.

root="Lean/audit_scripts"
formula="$root/p29_chebyshev_cl2_bdf_factorbase_plan.sage"
source_ledger="$root/p29_chebyshev_cl2_bdf_factorbase.source"
factorbase_wrapper="$root/run_p29_chebyshev_cl2_bdf_factorbase.sh"
factorbase_transcript="$root/p29_chebyshev_cl2_bdf_factorbase.transcript"
factorbase_meta="$root/p29_chebyshev_cl2_bdf_factorbase.meta"
factorbase_exit="$root/p29_chebyshev_cl2_bdf_factorbase.exit"
producer="$root/p29_chebyshev_cl1_bdf_principal_generators.gp"
verifier="$root/p29_chebyshev_cl1_bdf_principal_verify.sage"
full_wrapper="$root/run_p29_chebyshev_cl1_bdf_principal_full.sh"
full_transcript="$root/p29_chebyshev_cl1_bdf_principal_full.transcript"
full_meta="$root/p29_chebyshev_cl1_bdf_principal_full.meta"
full_exit="$root/p29_chebyshev_cl1_bdf_principal_full.exit"
generation_attempt_transcript="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1.transcript"
generation_attempt_meta="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1.meta"
generation_attempt_exit="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1.exit"
cert_dir="$root/p29_chebyshev_cl1_bdf_principal_shards_v1"
shard_manifest="$cert_dir/SHARDS.sha256"
transcript="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.transcript"
meta="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.meta"
exit_record="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.exit"
image="sagemath/sagemath:10.9"
mount="/mnt/e/AImath/abc猜想:/work:ro"
expected_records=2434953
expected_higher_degree=424

: > "$transcript"
: > "$meta"
: > "$exit_record"

on_exit() {
  rc=$?
  printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
  printf '%s\n' "$rc" > "$exit_record"
  printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  trap - EXIT
  exit "$rc"
}
trap on_exit EXIT

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

required_files=(
  "$formula"
  "$source_ledger"
  "$factorbase_wrapper"
  "$factorbase_transcript"
  "$factorbase_meta"
  "$factorbase_exit"
  "$producer"
  "$verifier"
  "$full_wrapper"
  "$full_transcript"
  "$full_meta"
  "$full_exit"
  "$generation_attempt_transcript"
  "$generation_attempt_meta"
  "$generation_attempt_exit"
  "$shard_manifest"
  "$0"
)
for required in "${required_files[@]}"; do
  test -f "$required"
done

# Refuse to recheck a certificate unless both archived prerequisite runs
# themselves ended cleanly and still match their executable inputs.
test "$(tr -d '\r\n' < "$factorbase_exit")" = 0
test "$(tr -d '\r\n' < "$full_exit")" = 0
grep -Fqx 'P29_BDF_FACTORBASE_REALBALL_PASS' "$factorbase_transcript"
grep -Fqx 'distinct_degree_one_prime_ideals = 2434529' "$factorbase_transcript"
grep -Fqx 'EXIT_CODE=0' "$factorbase_transcript"
grep -Fq 'END_UTC=' "$factorbase_meta"
grep -Fqx "SCRIPT_SHA256=$(hash_file "$formula")" "$factorbase_meta"
grep -Fqx "SOURCE_LEDGER_SHA256=$(hash_file "$source_ledger")" "$factorbase_meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$factorbase_wrapper")" "$factorbase_meta"

grep -Fqx "PRODUCER_SHA256=$(hash_file "$producer")" "$full_meta"
grep -Fqx "VERIFIER_SHA256=$(hash_file "$verifier")" "$full_meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$full_wrapper")" "$full_meta"
grep -Fqx 'GENERATION_MODE=RESUME_PRESERVED_SHARDS' "$full_meta"
grep -Fqx "GENERATION_ATTEMPT_TRANSCRIPT_SHA256=$(hash_file "$generation_attempt_transcript")" "$full_meta"
grep -Fqx "GENERATION_ATTEMPT_META_SHA256=$(hash_file "$generation_attempt_meta")" "$full_meta"
grep -Fqx "GENERATION_ATTEMPT_EXIT_SHA256=$(hash_file "$generation_attempt_exit")" "$full_meta"
grep -Fq 'END_UTC=' "$full_meta"
grep -Fqx "GENERATED_FACTOR_BASE_IDEALS=$expected_records" "$full_transcript"
grep -Fqx 'VERIFIED_SHARDS=16' "$full_transcript"
grep -Fqx "VERIFIED_FACTOR_BASE_IDEALS=$expected_records" "$full_transcript"
grep -Fqx "VERIFIED_HIGHER_DEGREE_IDEALS=$expected_higher_degree" "$full_transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 2434529, 2: 406, 4: 14, 7: 4}' "$full_transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$full_transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$full_transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS' "$full_transcript"
grep -Fqx 'EXIT_CODE=0' "$full_transcript"

test "$(tr -d '\r\n' < "$generation_attempt_exit")" = 1
grep -Fqx 'GENERATED_FACTOR_BASE_IDEALS=2434953' "$generation_attempt_transcript"
grep -Fq "PermissionError: [Errno 13] Permission denied: '/cert/p29_bdf_principal_00.tsv.gz'" \
  "$generation_attempt_transcript"
grep -Fq 'PRESERVED_TEMP_DIR=/tmp/p29_bdf_principal_full.' \
  "$generation_attempt_transcript"
grep -Fqx 'EXIT_CODE=1' "$generation_attempt_transcript"
grep -Fq 'END_UTC=' "$generation_attempt_meta"

certificates=()
verify_paths=()
for index in $(seq 0 15); do
  stem="$(printf 'p29_bdf_principal_%02d' "$index")"
  certificate="$cert_dir/${stem}.tsv.gz"
  test -f "$certificate"
  certificates+=("$certificate")
  verify_paths+=("/cert/${stem}.tsv.gz")
  gzip -t -- "$certificate"
  awk -v name="${stem}.tsv.gz" \
    '$2 == name { count += 1 } END { exit(count == 1 ? 0 : 1) }' \
    "$shard_manifest"
done
test "$(awk 'NF { count += 1 } END { print count + 0 }' "$shard_manifest")" = 16
(
  cd "$cert_dir"
  sha256sum -c -- "$(basename "$shard_manifest")"
) >> "$transcript" 2>&1
printf 'P29_BDF_PRINCIPAL_SHARD_MANIFEST_PASS\n' >> "$transcript"

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'FORMULA_SHA256=%s\n' "$(hash_file "$formula")"
  printf 'SOURCE_LEDGER_SHA256=%s\n' "$(hash_file "$source_ledger")"
  printf 'FACTORBASE_WRAPPER_SHA256=%s\n' "$(hash_file "$factorbase_wrapper")"
  printf 'FACTORBASE_TRANSCRIPT_SHA256=%s\n' "$(hash_file "$factorbase_transcript")"
  printf 'FACTORBASE_META_SHA256=%s\n' "$(hash_file "$factorbase_meta")"
  printf 'FACTORBASE_EXIT_SHA256=%s\n' "$(hash_file "$factorbase_exit")"
  printf 'PRODUCER_SHA256=%s\n' "$(hash_file "$producer")"
  printf 'VERIFIER_SHA256=%s\n' "$(hash_file "$verifier")"
  printf 'FULL_WRAPPER_SHA256=%s\n' "$(hash_file "$full_wrapper")"
  printf 'FULL_TRANSCRIPT_SHA256=%s\n' "$(hash_file "$full_transcript")"
  printf 'FULL_META_SHA256=%s\n' "$(hash_file "$full_meta")"
  printf 'FULL_EXIT_SHA256=%s\n' "$(hash_file "$full_exit")"
  printf 'GENERATION_ATTEMPT_TRANSCRIPT_SHA256=%s\n' \
    "$(hash_file "$generation_attempt_transcript")"
  printf 'GENERATION_ATTEMPT_META_SHA256=%s\n' \
    "$(hash_file "$generation_attempt_meta")"
  printf 'GENERATION_ATTEMPT_EXIT_SHA256=%s\n' \
    "$(hash_file "$generation_attempt_exit")"
  printf 'RECHECK_WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'SHARD_MANIFEST_SHA256=%s\n' "$(hash_file "$shard_manifest")"
  for index in $(seq 0 15); do
    certificate="${certificates[$index]}"
    printf 'CERTIFICATE_SHARD_%02d_SHA256=%s\n' "$index" "$(hash_file "$certificate")"
    printf 'CERTIFICATE_SHARD_%02d_BYTES=%s\n' "$index" "$(stat -c %s "$certificate")"
  done
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'SAGE_VERSION='
  docker run --rm --cpus=1 "$image" sage --version
  printf 'GZIP_VERSION_BEGIN\n'
  gzip --version
  printf 'GZIP_VERSION_END\n'
  printf 'STRICT_NORM_BOUND=40000000\n'
  printf 'EXPECTED_FACTOR_BASE_IDEALS=%s\n' "$expected_records"
  printf 'EXPECTED_HIGHER_DEGREE_IDEALS=%s\n' "$expected_higher_degree"
  printf 'EXPECTED_SHARDS=16\n'
} >> "$meta" 2>&1

printf 'BDF_FORMULA_RECHECK_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
set +e
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$formula /tmp/p29_bdf.sage && sage /tmp/p29_bdf.sage" \
  >> "$transcript" 2>&1
formula_rc=$?
set -e
printf 'BDF_FORMULA_RECHECK_EXIT_CODE=%s\n' "$formula_rc" >> "$transcript"
printf 'BDF_FORMULA_RECHECK_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( formula_rc != 0 )); then
  exit "$formula_rc"
fi

grep -Fqx 'P29_BDF_FACTORBASE_REALBALL_PASS' "$transcript"
grep -Fqx 'distinct_degree_one_prime_ideals = 2434529' "$transcript"

cert_abs="$(realpath "$cert_dir")"
printf 'VERIFIER_RECHECK_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
set +e
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" -v "$cert_abs:/cert:ro" "$image" \
  -lc 'cp "$1" /tmp/p29_verify.sage && shift && sage /tmp/p29_verify.sage "$@"' \
  p29-bdf-principal-recheck "/work/$verifier" "${verify_paths[@]}" \
  >> "$transcript" 2>&1
verifier_rc=$?
set -e
printf 'VERIFIER_RECHECK_EXIT_CODE=%s\n' "$verifier_rc" >> "$transcript"
printf 'VERIFIER_RECHECK_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( verifier_rc != 0 )); then
  exit "$verifier_rc"
fi

grep -Fqx 'STRICT_NORM_BOUND=40000000' "$transcript"
grep -Fqx 'VERIFIED_SHARDS=16' "$transcript"
grep -Fqx "VERIFIED_FACTOR_BASE_IDEALS=$expected_records" "$transcript"
grep -Fqx "VERIFIED_HIGHER_DEGREE_IDEALS=$expected_higher_degree" "$transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 2434529, 2: 406, 4: 14, 7: 4}' "$transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"
printf 'P29_BDF_PRINCIPAL_FROZEN_RECHECK_PASS\n' >> "$transcript"
