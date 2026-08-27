#!/usr/bin/env bash
set -euo pipefail

# Freeze and replay the local p=29 Coleman calculation under SageMath 10.9.
# The output is a local unit-minor certificate, not a Mordell--Weil or
# rational-point completeness assertion.

root="Lean/audit_scripts"
source_file="$root/p29_chebyshev_gamma2_coleman.sage"
transcript="$root/p29_chebyshev_gamma2_coleman.transcript"
meta="$root/p29_chebyshev_gamma2_coleman.meta"
exit_record="$root/p29_chebyshev_gamma2_coleman.exit"
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
  docker run --rm --cpus=1 "$image" sage --version
  printf 'P_ADIC_PRIME=5\n'
  printf 'Q5_PRECISION=110\n'
  printf 'GENUS=14\n'
} >> "$meta" 2>&1

printf 'COLEMAN_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
set +e
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$source_file /tmp/p29_coleman.sage && sage /tmp/p29_coleman.sage" \
  >> "$transcript" 2>&1
coleman_rc=$?
set -e
printf 'COLEMAN_EXIT_CODE=%s\n' "$coleman_rc" >> "$transcript"
printf 'COLEMAN_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( coleman_rc != 0 )); then
  exit "$coleman_rc"
fi

grep -Fqx 'P29_GOOD_REDUCTION_F5_POINT_COUNT=6' "$transcript"
grep -Fqx 'P29_ENDPOINT_LOG_CONTENTS_1_1' "$transcript"
grep -Fqx 'P29_NORMALIZED_LOG_RANK_2' "$transcript"
grep -Fqx 'P29_ANNIHILATOR_EVALS_4_3_4_1' "$transcript"
grep -Fqx 'P29_UNIT_MINOR_COLUMNS_0_2' "$transcript"
grep -Fqx 'P29_GAMMA2_COLEMAN_LOCAL_CERTIFICATE_PASS' "$transcript"
printf 'P29_GAMMA2_COLEMAN_FROZEN_RUN_PASS\n' >> "$transcript"
