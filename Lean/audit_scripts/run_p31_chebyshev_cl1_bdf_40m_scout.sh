#!/usr/bin/env bash
set -uo pipefail

root="Lean/audit_scripts"
script="$root/p31_chebyshev_cl1_bdf_40m_scout.sage"
source_ledger="$root/p31_chebyshev_cl1_bdf_40m_scout.source"
transcript="$root/p31_chebyshev_cl1_bdf_40m_scout.transcript"
meta="$root/p31_chebyshev_cl1_bdf_40m_scout.meta"
exit_record="$root/p31_chebyshev_cl1_bdf_40m_scout.exit"
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
  test -f "$required" || exit 97
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
  printf 'NO_PRINCIPAL_WITNESSES=1\n'
  printf 'NO_CUTOFF_ABOVE_40000000=1\n'
} >> "$meta" 2>&1 || exit $?

docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$script /tmp/p31_bdf_40m.sage && sage /tmp/p31_bdf_40m.sage" \
  >> "$transcript" 2>&1
rc=$?

if [ "$rc" -ne 0 ]; then
  exit "$rc"
fi
if grep -Fqx 'P31_BDF_T40000000_REALBALL_PASS' "$transcript"; then
  exit 0
fi
grep -Fqx 'P31_BDF_T40000000_REALBALL_INCONCLUSIVE' "$transcript" || exit 98
exit 0
