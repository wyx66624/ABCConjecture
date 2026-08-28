#!/usr/bin/env bash
set -euo pipefail

# Freeze and replay the local p=31 Coleman calculation under SageMath 10.9.
# The repository is mounted read-only.  The output is a local unit-minor
# certificate, not a Mordell--Weil, Stoll, or rational-point certificate.

root="Lean/audit_scripts"
source_file="$root/p31_chebyshev_gamma2_coleman_final.sage"
transcript="$root/p31_chebyshev_gamma2_coleman_final.transcript"
meta="$root/p31_chebyshev_gamma2_coleman_final.meta"
exit_record="$root/p31_chebyshev_gamma2_coleman_final.exit"
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
trap 'exit 130' INT TERM

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

for required in "$source_file" "$0"; do
  test -f "$required"
done

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'SOURCE_SHA256=%s\n' "$(hash_file "$source_file")"
  printf 'WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'SAGE_VERSION='
  docker run --rm --cpus=1 --network none "$image" sage --version
  printf 'REPOSITORY_MOUNT_MODE=read-only\n'
  printf 'P_ADIC_PRIME=5\n'
  printf 'Q5_PRECISION=120\n'
  printf 'GENUS=15\n'
} >> "$meta" 2>&1

printf 'COLEMAN_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
set +e
docker run --rm --cpus=1 --network none --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$source_file /tmp/p31_coleman_final.sage && sage /tmp/p31_coleman_final.sage" \
  >> "$transcript" 2>&1
coleman_rc=$?
set -e
printf 'COLEMAN_EXIT_CODE=%s\n' "$coleman_rc" >> "$transcript"
printf 'COLEMAN_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( coleman_rc != 0 )); then
  exit "$coleman_rc"
fi

grep -Fqx 'P31_GOOD_REDUCTION_F5_POINT_COUNT=6' "$transcript"
grep -Fqx 'P31_UNIQUE_SIMPLE_WEIERSTRASS_ROOT_X0' "$transcript"
grep -Fqx 'P31_ENDPOINT_LOG_CONTENTS_1_1' "$transcript"
grep -Fqx 'P31_NORMALIZED_LOG_RANK_2' "$transcript"
grep -Fqx 'P31_ANNIHILATOR_FIXED_VECTOR_PASS' "$transcript"
grep -Fqx 'P31_ANNIHILATOR_ALL_SIX_DISKS_UNIT' "$transcript"
grep -Fqx 'P31_UNIT_MINOR_COLUMNS_0_1_DET_3' "$transcript"
grep -Fqx 'P31_DOT_PRECISION_MARGIN_AT_LEAST_110' "$transcript"
grep -Fqx 'P31_Q5_UNIQUE_ROOT_REDUCTION_0' "$transcript"
grep -Fqx 'P31_GAMMA2_COLEMAN_LOCAL_FINAL_CERTIFICATE_PASS' "$transcript"
printf 'P31_GAMMA2_COLEMAN_LOCAL_FINAL_FROZEN_RUN_PASS\n' >> "$transcript"
