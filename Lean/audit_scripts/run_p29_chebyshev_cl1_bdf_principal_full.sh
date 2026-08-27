#!/usr/bin/env bash
set -euo pipefail

# Generate and independently verify exact principal generators for the entire
# BDF factor base of K=Q(a), a^29=2, with strict norm bound 40,000,000.

root="Lean/audit_scripts"
producer="$root/p29_chebyshev_cl1_bdf_principal_generators.gp"
verifier="$root/p29_chebyshev_cl1_bdf_principal_verify.sage"
cert_dir="$root/p29_chebyshev_cl1_bdf_principal_shards_v1"
transcript="$root/p29_chebyshev_cl1_bdf_principal_full.transcript"
meta="$root/p29_chebyshev_cl1_bdf_principal_full.meta"
exit_record="$root/p29_chebyshev_cl1_bdf_principal_full.exit"
image="sagemath/sagemath:10.9"
mount="/mnt/e/AImath/abc猜想:/work:ro"
bound=40000000
expected_records=2434953
expected_higher_degree=424

# Boundaries balance the exact expected record count, including the 424
# higher-degree primes in the first shard.  Every interval is half-open.
boundaries=(
  2 2045348 4339208 6701868 9105842 11567660 14054732 16567074
  19107234 21674552 24236028 26836764 29453388 32066052 34717958
  37361954 40000000
)

temp_dir="${cert_dir}.tmp.$$"
pids=()
completed=0

: > "$transcript"
: > "$meta"
: > "$exit_record"

safe_remove_temp() {
  case "$temp_dir" in
    "$root"/p29_chebyshev_cl1_bdf_principal_shards_v1.tmp.*)
      rm -rf -- "$temp_dir"
      ;;
    *)
      printf 'refusing to remove unexpected temporary path: %s\n' "$temp_dir" >&2
      return 1
      ;;
  esac
}

on_exit() {
  rc=$?
  if (( rc != 0 )); then
    for pid in "${pids[@]}"; do
      kill "$pid" 2>/dev/null || true
    done
    for pid in "${pids[@]}"; do
      wait "$pid" 2>/dev/null || true
    done
  fi
  if (( completed == 0 )) && [[ -d "$temp_dir" ]]; then
    safe_remove_temp || true
  fi
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

for required in "$producer" "$verifier" "$0"; do
  test -f "$required"
done
if [[ -e "$cert_dir" || -e "$temp_dir" ]]; then
  printf 'refusing to overwrite an existing certificate directory\n' >&2
  exit 2
fi
mkdir -- "$temp_dir"

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'PRODUCER_SHA256=%s\n' "$(hash_file "$producer")"
  printf 'VERIFIER_SHA256=%s\n' "$(hash_file "$verifier")"
  printf 'WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'PARI_GP_VERSION='
  gp -qf <<'GP_VERSION'
print(version());
quit;
GP_VERSION
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'SAGE_VERSION='
  docker run --rm --cpus=1 "$image" sage --version
  printf 'STRICT_NORM_BOUND=%s\n' "$bound"
  printf 'EXPECTED_FACTOR_BASE_IDEALS=%s\n' "$expected_records"
  printf 'EXPECTED_HIGHER_DEGREE_IDEALS=%s\n' "$expected_higher_degree"
  printf 'WORKERS=16\n'
  printf 'BOUNDARIES=%s\n' "${boundaries[*]}"
} >> "$meta" 2>&1

generate_shard() {
  local index="$1"
  local lo="$2"
  local hi="$3"
  local stem
  stem="$(printf 'p29_bdf_principal_%02d' "$index")"
  local raw="$temp_dir/${stem}.tsv"
  local compressed="$temp_dir/${stem}.tsv.gz"
  local errors="$temp_dir/${stem}.stderr"

  LC_ALL=C TZ=UTC P29_BDF_T="$bound" P29_Q_LO="$lo" P29_Q_HI="$hi" \
    nice -n 15 gp -qf "$producer" > "$raw" 2> "$errors"
  gzip -n -9 -c "$raw" > "$compressed"
  rm -f -- "$raw"
}

printf 'GENERATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
for index in $(seq 0 15); do
  generate_shard "$index" "${boundaries[$index]}" "${boundaries[$((index + 1))]}" &
  pids+=("$!")
done

worker_failure=0
for pid in "${pids[@]}"; do
  if ! wait "$pid"; then
    worker_failure=1
  fi
done
if (( worker_failure != 0 )); then
  printf 'one or more producer shards failed\n' >&2
  exit 1
fi
printf 'GENERATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"

total_records=0
shard_manifest="$temp_dir/SHARDS.sha256"
: > "$shard_manifest"
for index in $(seq 0 15); do
  stem="$(printf 'p29_bdf_principal_%02d' "$index")"
  compressed="$temp_dir/${stem}.tsv.gz"
  errors="$temp_dir/${stem}.stderr"
  gzip -t -- "$compressed"
  grep -Fqx 'P29_BDF_PRINCIPAL_GENERATION_PASS' "$errors"
  count_lines="$(gzip -dc -- "$compressed" | grep -Ec '^#COUNT=[0-9]+$')"
  if [[ "$count_lines" != 1 ]]; then
    printf 'shard %s has an invalid count footer multiplicity\n' "$index" >&2
    exit 1
  fi
  count="$(gzip -dc -- "$compressed" | sed -n 's/^#COUNT=\([0-9][0-9]*\)$/\1/p')"
  total_records="$((total_records + count))"
  {
    printf 'SHARD=%02d RANGE=[%s,%s) RECORDS=%s BYTES=%s SHA256=%s\n' \
      "$index" "${boundaries[$index]}" "${boundaries[$((index + 1))]}" \
      "$count" "$(stat -c %s "$compressed")" "$(hash_file "$compressed")"
    printf 'SHARD_%02d_STDERR_BEGIN\n' "$index"
    sed 's/^/  /' "$errors"
    printf 'SHARD_%02d_STDERR_END\n' "$index"
  } >> "$transcript"
  (cd "$temp_dir" && sha256sum -- "${stem}.tsv.gz") >> "$shard_manifest"
done
if (( total_records != expected_records )); then
  printf 'wrong total record count: %s != %s\n' "$total_records" "$expected_records" >&2
  exit 1
fi
printf 'GENERATED_FACTOR_BASE_IDEALS=%s\n' "$total_records" >> "$transcript"

temp_abs="$(realpath "$temp_dir")"
verify_paths=()
for index in $(seq 0 15); do
  verify_paths+=("/cert/$(printf 'p29_bdf_principal_%02d.tsv.gz' "$index")")
done

printf 'VERIFICATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
docker run --rm --cpus=1 \
  -v "$mount" -v "$temp_abs:/cert:ro" "$image" \
  sage "/work/$verifier" "${verify_paths[@]}" \
  >> "$transcript" 2>&1
printf 'VERIFICATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"

grep -Fqx 'VERIFIED_SHARDS=16' "$transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=2434953' "$transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=424' "$transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 2434529, 2: 406, 4: 14, 7: 4}' "$transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"

rm -f -- "$temp_dir"/*.stderr
mv -- "$temp_dir" "$cert_dir"
completed=1
printf 'P29_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS\n' >> "$transcript"
