#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
stem="$root/p31_chebyshev_bdf_threshold_scan"
script="$stem.sage"
source_ledger="$stem.source"
transcript="$stem.transcript"
meta="$stem.meta"
exit_record="$stem.exit"
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
  printf 'THRESHOLDS=40000000,80000000,160000000,320000000\n'
  printf 'MAX_BOUND_STRICT=320000000\n'
  printf 'SEGMENT_LENGTH=1000000\n'
  printf 'NO_PRINCIPAL_WITNESSES=1\n'
} >> "$meta" 2>&1

docker run --rm --cpus=1 --memory=6g --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$script /tmp/p31_bdf_threshold_scan.sage || exit 90
start_seconds=\$SECONDS
sage /tmp/p31_bdf_threshold_scan.sage
rc=\$?
printf 'CONTAINER_ELAPSED_SECONDS=%s\\n' \"\$((SECONDS-start_seconds))\"
printf 'CONTAINER_MEMORY_PEAK_BYTES=%s\\n' \"\$(cat /sys/fs/cgroup/memory.peak)\"
printf 'CONTAINER_MEMORY_CURRENT_BYTES=%s\\n' \"\$(cat /sys/fs/cgroup/memory.current)\"
exit \"\$rc\"" \
  >> "$transcript" 2>&1

grep -Fqx 'P31_BDF_THRESHOLD_SCAN_COMPLETE' "$transcript"
grep -Fqx 'NO_PRINCIPAL_WITNESSES_CONSTRUCTED=1' "$transcript"
