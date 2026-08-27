#!/usr/bin/env bash
set -euo pipefail

# Recover only the already generated and independently verified publish set.
# This wrapper never invokes the GP producer.

root="Lean/audit_scripts"
verifier="$root/p31_chebyshev_cl1_bdf_principal_verify.sage"
full_wrapper="$root/run_p31_chebyshev_cl1_bdf_principal_full.sh"
recovery_wrapper="$root/run_p31_chebyshev_cl1_bdf_principal_publish_recovery.sh"
cert_dir="$root/p31_chebyshev_cl1_bdf_principal_shards_v1"
transcript="$root/p31_chebyshev_cl1_bdf_principal_full.transcript"
meta="$root/p31_chebyshev_cl1_bdf_principal_full.meta"
exit_record="$root/p31_chebyshev_cl1_bdf_principal_full.exit"
attempt2_prefix="$root/p31_chebyshev_cl1_bdf_principal_publish_attempt2"
attempt2_transcript="${attempt2_prefix}.transcript"
attempt2_meta="${attempt2_prefix}.meta"
attempt2_exit="${attempt2_prefix}.exit"
image="sagemath/sagemath:10.9"

temp_dir="$(realpath -- "${P31_BDF_TEMP_DIR:?set P31_BDF_TEMP_DIR}")"
publish_dir="$(realpath -- "${P31_BDF_PUBLISH_DIR:?set P31_BDF_PUBLISH_DIR}")"
case "$temp_dir" in /tmp/p31_bdf_principal_full.*) ;; *) exit 2 ;; esac
case "$publish_dir" in
  */Lean/audit_scripts/p31_chebyshev_cl1_bdf_principal_shards_v1.tmp.*) ;;
  *) exit 2 ;;
esac
test -d "$temp_dir" -a -d "$publish_dir"
if [[ -e "$cert_dir" || -L "$cert_dir" ]]; then exit 2; fi

test "$(tr -d '\r\n' < "$exit_record")" = 1
grep -Fqx 'GENERATED_FACTOR_BASE_IDEALS=4668356' "$transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=4668356' "$transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=660' "$transcript"
grep -Fqx 'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"
grep -Fqx "PRESERVED_TEMP_DIR=$temp_dir" "$transcript"
recorded_publish="$(sed -n 's/^PRESERVED_PUBLISH_DIR=//p' "$transcript")"
test -n "$recorded_publish"
test "$(realpath -- "$recorded_publish")" = "$publish_dir"
cp -- "$transcript" "$attempt2_transcript"
cp -- "$meta" "$attempt2_meta"
cp -- "$exit_record" "$attempt2_exit"

: > "$transcript"
: > "$meta"
: > "$exit_record"

on_exit() {
  local rc=$?
  trap - EXIT
  printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
  printf '%s\n' "$rc" > "$exit_record"
  printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  exit "$rc"
}
trap on_exit EXIT

hash_file() { sha256sum -- "$1" | cut -d ' ' -f 1; }

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'RECOVERY_MODE=EXISTING_PUBLISH_DIR_NO_PRODUCER\n'
  printf 'VERIFIER_SHA256=%s\n' "$(hash_file "$verifier")"
  printf 'FULL_WRAPPER_SHA256=%s\n' "$(hash_file "$full_wrapper")"
  printf 'RECOVERY_WRAPPER_SHA256=%s\n' "$(hash_file "$recovery_wrapper")"
  printf 'PUBLISH_ATTEMPT2_TRANSCRIPT_SHA256=%s\n' "$(hash_file "$attempt2_transcript")"
  printf 'PUBLISH_ATTEMPT2_META_SHA256=%s\n' "$(hash_file "$attempt2_meta")"
  printf 'PUBLISH_ATTEMPT2_EXIT_SHA256=%s\n' "$(hash_file "$attempt2_exit")"
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'STRICT_NORM_BOUND=80000000\n'
  printf 'EXPECTED_FACTOR_BASE_IDEALS=4668356\n'
  printf 'EXPECTED_HIGHER_DEGREE_IDEALS=660\n'
} >> "$meta" 2>&1

shard_manifest="$publish_dir/SHARDS.sha256"
test -f "$shard_manifest"
test "$(awk 'NF {n++} END {print n+0}' "$shard_manifest")" = 16
(cd "$publish_dir" && sha256sum -c SHARDS.sha256) >> "$transcript" 2>&1
printf 'P31_BDF_PRINCIPAL_SHARD_MANIFEST_PASS\n' >> "$transcript"

verify_paths=()
for index in $(seq 0 15); do
  stem="$(printf 'p31_bdf_principal_%02d' "$index")"
  shard="$publish_dir/${stem}.tsv.gz"
  test -f "$shard"
  gzip -t -- "$shard"
  verify_paths+=("/cert/${stem}.tsv.gz")
done

publish_abs="$(realpath "$publish_dir")"
printf 'RECOVERY_VERIFICATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "/mnt/e/AImath/abc猜想:/work:ro" -v "$publish_abs:/cert:ro" "$image" \
  -lc 'cp "$1" /tmp/p31_verify.sage && shift && sage /tmp/p31_verify.sage "$@"' \
  p31-publish-recovery "/work/$verifier" "${verify_paths[@]}" \
  >> "$transcript" 2>&1
printf 'RECOVERY_VERIFICATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"

grep -Fqx 'STRICT_NORM_BOUND=80000000' "$transcript"
grep -Fqx 'VERIFIED_SHARDS=16' "$transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=4668356' "$transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=660' "$transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 4667696, 2: 600, 3: 60}' "$transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$transcript"
grep -Fqx 'NO_UNIT_GROUP_OR_REGULATOR_USED=1' "$transcript"
grep -Fqx 'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"

mv -T -- "$publish_dir" "$cert_dir"
case "$temp_dir" in
  /tmp/p31_bdf_principal_full.*) rm -rf -- "$temp_dir" ;;
  *) exit 2 ;;
esac
printf 'P31_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS\n' >> "$transcript"
printf 'P31_BDF_PRINCIPAL_PUBLISH_RECOVERY_PASS\n' >> "$transcript"
