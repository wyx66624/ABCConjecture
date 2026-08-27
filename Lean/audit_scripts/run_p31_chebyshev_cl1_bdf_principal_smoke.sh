#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
producer="$root/p31_chebyshev_cl1_bdf_principal_generators.gp"
verifier="$root/p31_chebyshev_cl1_bdf_principal_verify.sage"
bound="${P31_SMOKE_T:-100000}"
split="${P31_SMOKE_SPLIT:-50000}"
image="sagemath/sagemath:10.9"
transcript="$root/p31_chebyshev_cl1_bdf_principal_smoke.transcript"
meta="$root/p31_chebyshev_cl1_bdf_principal_smoke.meta"
exit_record="$root/p31_chebyshev_cl1_bdf_principal_smoke.exit"
tmp="$(mktemp -d /tmp/p31_bdf_principal_smoke.XXXXXX)"

: > "$transcript"
: > "$meta"
: > "$exit_record"

cleanup() {
  case "$tmp" in
    /tmp/p31_bdf_principal_smoke.*) rm -rf -- "$tmp" ;;
    *) return 1 ;;
  esac
}
on_exit() {
  local rc=$?
  trap - EXIT
  cleanup || true
  printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
  printf '%s\n' "$rc" > "$exit_record"
  printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  exit "$rc"
}
trap on_exit EXIT

hash_file() { sha256sum -- "$1" | cut -d ' ' -f 1; }
{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'PRODUCER_SHA256=%s\n' "$(hash_file "$producer")"
  printf 'VERIFIER_SHA256=%s\n' "$(hash_file "$verifier")"
  printf 'WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'BOUND=%s\nSPLIT=%s\n' "$bound" "$split"
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
} >> "$meta" 2>&1

if (( bound <= 2 || split <= 2 || split >= bound )); then
  exit 2
fi

run_producer() {
  local lo="$1" hi="$2" output="$3" errors="$4"
  P31_BDF_T="$bound" P31_Q_LO="$lo" P31_Q_HI="$hi" \
    gp -qf "$producer" > "$output" 2> "$errors"
}

run_producer 2 "$split" "$tmp/shard0.tsv" "$tmp/shard0.stderr" &
pid0=$!
run_producer "$split" "$bound" "$tmp/shard1.tsv" "$tmp/shard1.stderr" &
pid1=$!
wait "$pid0"
wait "$pid1"

grep -Fqx 'P31_BDF_PRINCIPAL_GENERATION_PASS' "$tmp/shard0.stderr"
grep -Fqx 'P31_BDF_PRINCIPAL_GENERATION_PASS' "$tmp/shard1.stderr"
if grep -Fq 'syntax error' "$tmp/shard0.stderr" "$tmp/shard1.stderr"; then
  exit 3
fi
sed 's/^/SHARD0_STDERR: /' "$tmp/shard0.stderr" >> "$transcript"
sed 's/^/SHARD1_STDERR: /' "$tmp/shard1.stderr" >> "$transcript"
chmod a+rx -- "$tmp"

docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "/mnt/e/AImath/abc猜想:/work:ro" -v "$tmp:/cert:ro" "$image" \
  -lc 'cp "$1" /tmp/p31_verify.sage && sage /tmp/p31_verify.sage /cert/shard0.tsv /cert/shard1.tsv' \
  p31-smoke "/work/$verifier" >> "$transcript" 2>&1

records0="$(sed -n 's/^#COUNT=\([0-9][0-9]*\)$/\1/p' "$tmp/shard0.tsv")"
records1="$(sed -n 's/^#COUNT=\([0-9][0-9]*\)$/\1/p' "$tmp/shard1.tsv")"
{
  printf 'SMOKE_BOUND=%s\n' "$bound"
  printf 'SMOKE_RANGES=[2,%s),[%s,%s)\n' "$split" "$split" "$bound"
  printf 'SMOKE_RECORDS=%s\n' "$((records0 + records1))"
  printf 'SMOKE_UNCOMPRESSED_BYTES=%s\n' \
    "$(( $(stat -c %s "$tmp/shard0.tsv") + $(stat -c %s "$tmp/shard1.tsv") ))"
  printf 'CORRECTED_PRODUCER_NO_SYNTAX_DIAGNOSTIC=1\n'
  printf 'P31_BDF_PRINCIPAL_SMOKE_PASS\n'
} >> "$transcript"
