#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
script="$root/p29_chebyshev_cl2_bdf_factorbase_plan.sage"
source_ledger="$root/p29_chebyshev_cl2_bdf_factorbase.source"
transcript="$root/p29_chebyshev_cl2_bdf_factorbase.transcript"
meta="$root/p29_chebyshev_cl2_bdf_factorbase.meta"
exit_record="$root/p29_chebyshev_cl2_bdf_factorbase.exit"
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

for required in "$script" "$source_ledger" "$0"; do
  test -f "$required"
done

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'SCRIPT_SHA256=%s\n' "$(hash_file "$script")"
  printf 'SOURCE_LEDGER_SHA256=%s\n' "$(hash_file "$source_ledger")"
  printf 'WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'SAGE_VERSION='
  docker run --rm --cpus=1 "$image" sage --version
  printf 'PRECISION_BITS=256\n'
  printf 'BOUND_STRICT=40000000\n'
  printf 'EXPECTED_DEGREE_ONE_IDEALS=2434529\n'
} >> "$meta" 2>&1

docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$script /tmp/p29_bdf.sage && sage /tmp/p29_bdf.sage" \
  >> "$transcript" 2>&1

grep -Fqx 'P29_BDF_FACTORBASE_REALBALL_PASS' "$transcript"
grep -Fqx 'distinct_degree_one_prime_ideals = 2434529' "$transcript"
