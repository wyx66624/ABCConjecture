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
bound=40000000
expected_records=2434953
expected_higher_degree=424
generation_attempt_prefix="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1"
generation_attempt_transcript="${generation_attempt_prefix}.transcript"
generation_attempt_meta="${generation_attempt_prefix}.meta"
generation_attempt_exit="${generation_attempt_prefix}.exit"

# Boundaries balance the exact expected record count, including the 424
# higher-degree primes in the first shard.  Every interval is half-open.
boundaries=(
  2 2045348 4339208 6701868 9105842 11567660 14054732 16567074
  19107234 21674552 24236028 26836764 29453388 32066052 34717958
  37361954 40000000
)

resume_source="${P29_BDF_RESUME_DIR:-}"
if [[ -n "$resume_source" ]]; then
  test -d "$resume_source"
  temp_dir="$(realpath -- "$resume_source")"
  case "$temp_dir" in
    /tmp/p29_bdf_principal_full.*) ;;
    *)
      printf 'refusing to resume from unexpected path: %s\n' "$temp_dir" >&2
      exit 2
      ;;
  esac
  resuming=1
else
  temp_dir="$(mktemp -d /tmp/p29_bdf_principal_full.XXXXXX)"
  resuming=0
fi
publish_dir="${cert_dir}.tmp.$$"
pids=()

: > "$transcript"
: > "$meta"
: > "$exit_record"

safe_remove_work_dir() {
  local path="$1"
  case "$path" in
    /tmp/p29_bdf_principal_full.*|\
    "$root"/p29_chebyshev_cl1_bdf_principal_shards_v1.tmp.*)
      rm -rf -- "$path"
      ;;
    *)
      printf 'refusing to remove unexpected temporary path: %s\n' "$path" >&2
      return 1
      ;;
  esac
}

on_exit() {
  local rc=$?
  trap - EXIT INT TERM
  set +e
  if (( rc != 0 )); then
    for pid in "${pids[@]}"; do
      kill "$pid" 2>/dev/null || true
    done
    for pid in "${pids[@]}"; do
      wait "$pid" 2>/dev/null || true
    done
  fi
  if (( rc == 0 )); then
    if [[ -d "$temp_dir" ]]; then
      safe_remove_work_dir "$temp_dir" || true
    fi
    if [[ -d "$publish_dir" ]]; then
      safe_remove_work_dir "$publish_dir" || true
    fi
  else
    if [[ -d "$temp_dir" ]]; then
      printf 'PRESERVED_TEMP_DIR=%s\n' "$temp_dir" >> "$transcript"
      printf 'PRESERVED_TEMP_DIR=%s\n' "$temp_dir" >> "$meta"
    fi
    if [[ -d "$publish_dir" ]]; then
      printf 'PRESERVED_PUBLISH_DIR=%s\n' "$publish_dir" >> "$transcript"
      printf 'PRESERVED_PUBLISH_DIR=%s\n' "$publish_dir" >> "$meta"
    fi
  fi
  printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
  printf '%s\n' "$rc" > "$exit_record"
  printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  exit "$rc"
}
trap on_exit EXIT
trap 'exit 130' INT TERM

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

for required in "$producer" "$verifier" "$0"; do
  test -f "$required"
done
if (( resuming != 0 )); then
  for required in "$generation_attempt_transcript" "$generation_attempt_meta" \
      "$generation_attempt_exit"; do
    test -f "$required"
  done
  test "$(tr -d '\r\n' < "$generation_attempt_exit")" = 1
  grep -Fqx 'GENERATED_FACTOR_BASE_IDEALS=2434953' "$generation_attempt_transcript"
  grep -Fqx "PRESERVED_TEMP_DIR=$temp_dir" "$generation_attempt_transcript"
fi
if [[ -e "$cert_dir" || -e "$publish_dir" ]]; then
  printf 'refusing to overwrite an existing certificate directory\n' >&2
  exit 2
fi

# Execute immutable snapshots of the two mathematical programs.  This makes
# the recorded startup hashes describe the exact bytes used after generation.
producer_run="$temp_dir/producer.gp"
verifier_run="$temp_dir/verifier.py"
cp -- "$producer" "$producer_run"
cp -- "$verifier" "$verifier_run"

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
  printf 'GENERATION_SCRATCH_FILESYSTEM=WSL_EXT4_TMP\n'
  if (( resuming != 0 )); then
    printf 'GENERATION_MODE=RESUME_PRESERVED_SHARDS\n'
    printf 'RESUMED_TEMP_DIR=%s\n' "$temp_dir"
    printf 'GENERATION_ATTEMPT_TRANSCRIPT_SHA256=%s\n' \
      "$(hash_file "$generation_attempt_transcript")"
    printf 'GENERATION_ATTEMPT_META_SHA256=%s\n' \
      "$(hash_file "$generation_attempt_meta")"
    printf 'GENERATION_ATTEMPT_EXIT_SHA256=%s\n' \
      "$(hash_file "$generation_attempt_exit")"
  else
    printf 'GENERATION_MODE=FRESH_16_WORKER_RUN\n'
  fi
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
    nice -n 15 gp -qf "$producer_run" > "$raw" 2> "$errors"
  gzip -n -9 -c "$raw" > "$compressed"
  rm -f -- "$raw"
}

if (( resuming == 0 )); then
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
  pids=()
  if (( worker_failure != 0 )); then
    printf 'one or more producer shards failed\n' >&2
    exit 1
  fi
  printf 'GENERATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
else
  printf 'RESUME_VALIDATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
fi

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
chmod a+rx -- "$temp_abs"
verify_paths=()
for index in $(seq 0 15); do
  verify_paths+=("/cert/$(printf 'p29_bdf_principal_%02d.tsv.gz' "$index")")
done

printf 'VERIFICATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
docker run --rm --cpus=1 \
  -v "$temp_abs:/cert:ro" "$image" \
  sage -python /cert/verifier.py "${verify_paths[@]}" \
  >> "$transcript" 2>&1
printf 'VERIFICATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"

grep -Fqx 'VERIFIED_SHARDS=16' "$transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=2434953' "$transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=424' "$transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 2434529, 2: 406, 4: 14, 7: 4}' "$transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"

rm -f -- "$temp_dir"/*.stderr
mkdir -- "$publish_dir"
cp -- "$temp_dir"/*.tsv.gz "$temp_dir/SHARDS.sha256" "$publish_dir"/
(cd "$publish_dir" && sha256sum -c SHARDS.sha256)
if [[ -e "$cert_dir" || -L "$cert_dir" ]]; then
  printf 'certificate directory appeared during the run\n' >&2
  exit 2
fi
mv -T -- "$publish_dir" "$cert_dir"
safe_remove_work_dir "$temp_dir"
printf 'P29_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS\n' >> "$transcript"
