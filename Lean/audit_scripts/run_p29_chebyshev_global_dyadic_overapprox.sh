#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
script="$root/p29_chebyshev_global_dyadic_overapprox.sage"
class1_manifest="$root/p29_chebyshev_cl1_bdf_principal.sha256"
class1_recheck_transcript="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.transcript"
class1_recheck_exit="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.exit"
transcript="$root/p29_chebyshev_global_dyadic_overapprox.transcript"
meta="$root/p29_chebyshev_global_dyadic_overapprox.meta"
exit_record="$root/p29_chebyshev_global_dyadic_overapprox.exit"
image="sagemath/sagemath:10.9"
mount="/mnt/e/AImath/abc猜想:/work:ro"

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

for required in "$script" "$class1_manifest" \
  "$class1_recheck_transcript" "$class1_recheck_exit" "$0"; do
  test -f "$required"
done

# This is the external completeness gate for the 19 independently detected
# supported squareclasses.  It binds the rank-theorem application to the
# separately frozen unconditional class-number-one certificate.
test "$(tr -d '\r\n' < "$class1_recheck_exit")" = 0
grep -Fqx 'P29_BDF_PRINCIPAL_FROZEN_RECHECK_PASS' "$class1_recheck_transcript"
grep -Fqx 'EXIT_CODE=0' "$class1_recheck_transcript"
sha256sum -c -- "$class1_manifest" >> "$transcript" 2>&1
printf 'P29_CLASS_NUMBER_ONE_MANIFEST_PASS\n' >> "$transcript"

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'SCRIPT_SHA256=%s\n' "$(hash_file "$script")"
  printf 'CLASS1_MANIFEST_SHA256=%s\n' "$(hash_file "$class1_manifest")"
  printf 'CLASS1_RECHECK_TRANSCRIPT_SHA256=%s\n' \
    "$(hash_file "$class1_recheck_transcript")"
  printf 'WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'SAGE_VERSION='
  docker run --rm --cpus=1 "$image" sage --version
  printf 'EXPECTED_S_SIZE=4\n'
  printf 'EXPECTED_S_SQUARECLASS_DIMENSION=19\n'
  printf 'EXPECTED_NORM_RANK=4\n'
  printf 'EXPECTED_LOCAL3_PAIR_RANK=4\n'
  printf 'EXPECTED_LOCAL3_ENDPOINT_DIMENSION=1\n'
  printf 'EXPECTED_W_DIMENSION=14\n'
  printf 'EXPECTED_DYADIC_SIGNATURE_RANK=14\n'
} >> "$meta" 2>&1

docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$script /tmp/p29_global_dyadic.sage && sage /tmp/p29_global_dyadic.sage" \
  >> "$transcript" 2>&1

grep -Fq 'S_SIZE 4 SIGNATURE (1, 14) UNIT_RANK 14 EXPECTED_S_SQUARECLASS_DIM 19' \
  "$transcript"
grep -Fqx 'SQUARECLASS_DETECTION_RANK 19' "$transcript"
grep -Fqx 'NORM_RANK 4' "$transcript"
grep -Fq 'P3COUNT 2 P3_DEGREES [1, 28] LOCAL3_PAIR_RANK 4 L3_DIM 1' \
  "$transcript"
grep -Fq 'COMBINED_CONSTRAINT_RANK 5 W3DIM 14 COUNT 16384' "$transcript"
grep -Fq 'DYADIC_TEST_CLASSES 18' "$transcript"
grep -Fq 'W2_SIGNATURE_RANK 14 KERNEL_DIM 0' \
  "$transcript"
grep -Fqx 'P29_GLOBAL_DYADIC_OVERAPPROX_PASS' "$transcript"
printf 'P29_GLOBAL_DYADIC_FROZEN_RUN_PASS\n' >> "$transcript"
