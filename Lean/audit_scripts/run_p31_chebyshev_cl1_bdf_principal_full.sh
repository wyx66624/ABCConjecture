#!/usr/bin/env bash
set -euo pipefail

# Produce and independently verify principal generators for every prime ideal
# in the strict 80M BDF factor base of Q(2^(1/31)).

root="Lean/audit_scripts"
producer="$root/p31_chebyshev_cl1_bdf_principal_generators.gp"
verifier="$root/p31_chebyshev_cl1_bdf_principal_verify.sage"
planner="$root/p31_chebyshev_cl1_bdf_principal_shard_boundaries.sage"
cert_dir="$root/p31_chebyshev_cl1_bdf_principal_shards_v1"
transcript="$root/p31_chebyshev_cl1_bdf_principal_full.transcript"
meta="$root/p31_chebyshev_cl1_bdf_principal_full.meta"
exit_record="$root/p31_chebyshev_cl1_bdf_principal_full.exit"
attempt_prefix="$root/p31_chebyshev_cl1_bdf_principal_generation_attempt1"
attempt_transcript="${attempt_prefix}.transcript"
attempt_meta="${attempt_prefix}.meta"
attempt_exit="${attempt_prefix}.exit"
image="sagemath/sagemath:10.9"
bound=80000000
expected_records=4668356
expected_higher_degree=660
workers=16
boundaries=(
  2 4117260 8686188 13421394 18266310 23180768 28173492 33192312
  38283368 43407854 48549312 53724692 58934148 64181618 69427148
  74704184 80000000
)

resume_source="${P31_BDF_RESUME_DIR:-}"
if [[ -n "$resume_source" ]]; then
  test -d "$resume_source"
  temp_dir="$(realpath -- "$resume_source")"
  case "$temp_dir" in
    /tmp/p31_bdf_principal_full.*) ;;
    *) printf 'refusing unexpected resume path: %s\n' "$temp_dir" >&2; exit 2 ;;
  esac
  resuming=1
else
  temp_dir="$(mktemp -d /tmp/p31_bdf_principal_full.XXXXXX)"
  resuming=0
fi
publish_dir="${cert_dir}.tmp.$$"
pids=()
monitor_pid=""

if (( resuming != 0 )); then
  test -f "$transcript" -a -f "$meta" -a -f "$exit_record"
  test "$(tr -d '\r\n' < "$exit_record")" = "1"
  grep -Fqx "PRESERVED_TEMP_DIR=$temp_dir" "$transcript"
  cp -- "$transcript" "$attempt_transcript"
  cp -- "$meta" "$attempt_meta"
  cp -- "$exit_record" "$attempt_exit"
fi

: > "$transcript"
: > "$meta"
: > "$exit_record"

safe_remove_work_dir() {
  local path="$1"
  case "$path" in
    /tmp/p31_bdf_principal_full.*|\
    "$root"/p31_chebyshev_cl1_bdf_principal_shards_v1.tmp.*)
      rm -rf -- "$path" ;;
    *) printf 'refusing to remove unexpected path: %s\n' "$path" >&2; return 1 ;;
  esac
}

on_exit() {
  local rc=$?
  trap - EXIT INT TERM
  set +e
  if (( rc != 0 )); then
    for pid in "${pids[@]}"; do kill "$pid" 2>/dev/null || true; done
    for pid in "${pids[@]}"; do wait "$pid" 2>/dev/null || true; done
  fi
  [[ -n "$monitor_pid" ]] && wait "$monitor_pid" 2>/dev/null || true
  if (( rc == 0 )); then
    [[ -d "$temp_dir" ]] && safe_remove_work_dir "$temp_dir" || true
    [[ -d "$publish_dir" ]] && safe_remove_work_dir "$publish_dir" || true
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

hash_file() { sha256sum -- "$1" | cut -d ' ' -f 1; }

for required in "$producer" "$verifier" "$planner" "$0"; do test -f "$required"; done
if [[ -e "$cert_dir" || -L "$cert_dir" || -e "$publish_dir" ]]; then
  printf 'refusing to overwrite existing certificate directory\n' >&2
  exit 2
fi

producer_run="$temp_dir/producer.gp"
verifier_run="$temp_dir/verifier.py"
if (( resuming == 0 )); then
  cp -- "$producer" "$producer_run"
  cp -- "$verifier" "$verifier_run"
else
  test -f "$producer_run" -a -f "$verifier_run"
  test "$(hash_file "$producer_run")" = "$(hash_file "$producer")"
  test "$(hash_file "$verifier_run")" = "$(hash_file "$verifier")"
fi

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'PRODUCER_SHA256=%s\n' "$(hash_file "$producer")"
  printf 'VERIFIER_SHA256=%s\n' "$(hash_file "$verifier")"
  printf 'PLANNER_SHA256=%s\n' "$(hash_file "$planner")"
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
  printf 'WORKERS=%s\n' "$workers"
  printf 'BOUNDARIES=%s\n' "${boundaries[*]}"
  printf 'GENERATION_SCRATCH_FILESYSTEM=WSL_EXT4_TMP\n'
  if (( resuming == 0 )); then
    printf 'GENERATION_MODE=FRESH_RECOVERABLE_16_WORKER_RUN\n'
  else
    printf 'GENERATION_MODE=RESUME_VALIDATED_SHARDS\n'
    printf 'RESUMED_TEMP_DIR=%s\n' "$temp_dir"
    printf 'GENERATION_ATTEMPT_TRANSCRIPT_SHA256=%s\n' "$(hash_file "$attempt_transcript")"
    printf 'GENERATION_ATTEMPT_META_SHA256=%s\n' "$(hash_file "$attempt_meta")"
    printf 'GENERATION_ATTEMPT_EXIT_SHA256=%s\n' "$(hash_file "$attempt_exit")"
  fi
} >> "$meta" 2>&1

planner_output="$temp_dir/planner.output"
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "/mnt/e/AImath/abc猜想:/work:ro" "$image" \
  -lc "cp /work/$planner /tmp/planner.sage && sage /tmp/planner.sage" \
  > "$planner_output"
grep -Fqx "BOUNDARIES=${boundaries[*]}" "$planner_output"
grep -Fqx "TOTAL_FACTOR_BASE_IDEALS=$expected_records" "$planner_output"
grep -Fqx 'P31_BDF_PRINCIPAL_BOUNDARY_PLAN_PASS' "$planner_output"
sed 's/^/PLANNER: /' "$planner_output" >> "$transcript"

generate_shard() {
  local index="$1" lo="$2" hi="$3" stem raw compressed errors timing
  stem="$(printf 'p31_bdf_principal_%02d' "$index")"
  raw="$temp_dir/${stem}.tsv"
  compressed="$temp_dir/${stem}.tsv.gz"
  errors="$temp_dir/${stem}.stderr"
  timing="$temp_dir/${stem}.timing"
  printf 'WORKER=%02d START_UTC=%s RANGE=[%s,%s)\n' \
    "$index" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$lo" "$hi" > "$timing"
  local start_seconds=$SECONDS
  LC_ALL=C TZ=UTC P31_BDF_T="$bound" P31_Q_LO="$lo" P31_Q_HI="$hi" \
    nice -n 15 gp -qf "$producer_run" > "$raw" 2> "$errors"
  gzip -n -9 -c "$raw" > "$compressed"
  rm -f -- "$raw"
  printf 'WORKER=%02d END_UTC=%s ELAPSED_SECONDS=%s\n' \
    "$index" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$((SECONDS-start_seconds))" >> "$timing"
}

valid_existing_shard() {
  local index="$1" stem compressed errors timing
  stem="$(printf 'p31_bdf_principal_%02d' "$index")"
  compressed="$temp_dir/${stem}.tsv.gz"
  errors="$temp_dir/${stem}.stderr"
  timing="$temp_dir/${stem}.timing"
  [[ -f "$compressed" && -f "$errors" && -f "$timing" ]] || return 1
  gzip -t -- "$compressed" || return 1
  grep -Fqx 'P31_BDF_PRINCIPAL_GENERATION_PASS' "$errors" || return 1
  grep -Eq '^WORKER=[0-9][0-9] END_UTC=.* ELAPSED_SECONDS=[0-9]+$' "$timing"
}

printf 'GENERATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
for index in $(seq 0 15); do
  if (( resuming != 0 )) && valid_existing_shard "$index"; then
    printf 'RESUME_REUSED_SHARD=%02d\n' "$index" >> "$transcript"
    continue
  fi
  stem="$(printf 'p31_bdf_principal_%02d' "$index")"
  rm -f -- "$temp_dir/${stem}.tsv" "$temp_dir/${stem}.tsv.gz" \
    "$temp_dir/${stem}.stderr" "$temp_dir/${stem}.timing"
  generate_shard "$index" "${boundaries[$index]}" "${boundaries[$((index + 1))]}" &
  pids+=("$!")
done

monitor_workers() {
  local max_total=0 max_one=0 live=1 total one rss pid
  while (( live != 0 )); do
    live=0; total=0
    for pid in "${pids[@]}"; do
      if kill -0 "$pid" 2>/dev/null; then live=1; fi
      rss="$( { ps -o rss= -p "$pid" --ppid "$pid" 2>/dev/null || true; } | \
        awk '{s+=$1} END {print s+0}')"
      total=$((total + rss))
      (( rss > max_one )) && max_one=$rss
    done
    (( total > max_total )) && max_total=$total
    (( live != 0 )) && sleep 1
  done
  printf 'GENERATION_MAX_TOTAL_RSS_KB=%s\nGENERATION_MAX_ONE_WORKER_RSS_KB=%s\n' \
    "$max_total" "$max_one" > "$temp_dir/resource.ledger"
}

if (( ${#pids[@]} > 0 )); then
  monitor_workers & monitor_pid=$!
else
  printf '%s\n' \
    'GENERATION_MAX_TOTAL_RSS_KB=NOT_REMEASURED_ALL_SHARDS_REUSED' \
    'GENERATION_MAX_ONE_WORKER_RSS_KB=NOT_REMEASURED_ALL_SHARDS_REUSED' \
    > "$temp_dir/resource.ledger"
fi
worker_failure=0
for pid in "${pids[@]}"; do
  if ! wait "$pid"; then worker_failure=1; fi
done
[[ -n "$monitor_pid" ]] && wait "$monitor_pid"
monitor_pid=""
pids=()
if (( worker_failure != 0 )); then
  printf 'one or more producer shards failed\n' >&2
  exit 1
fi
printf 'GENERATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
cat "$temp_dir/resource.ledger" >> "$meta"

total_records=0
shard_manifest="$temp_dir/SHARDS.sha256"
: > "$shard_manifest"
for index in $(seq 0 15); do
  stem="$(printf 'p31_bdf_principal_%02d' "$index")"
  compressed="$temp_dir/${stem}.tsv.gz"
  errors="$temp_dir/${stem}.stderr"
  timing="$temp_dir/${stem}.timing"
  gzip -t -- "$compressed"
  grep -Fqx 'P31_BDF_PRINCIPAL_GENERATION_PASS' "$errors"
  count_lines="$(gzip -dc -- "$compressed" | grep -Ec '^#COUNT=[0-9]+$')"
  [[ "$count_lines" = 1 ]]
  count="$(gzip -dc -- "$compressed" | sed -n 's/^#COUNT=\([0-9][0-9]*\)$/\1/p')"
  total_records=$((total_records + count))
  {
    printf 'SHARD=%02d RANGE=[%s,%s) RECORDS=%s BYTES=%s SHA256=%s\n' \
      "$index" "${boundaries[$index]}" "${boundaries[$((index + 1))]}" \
      "$count" "$(stat -c %s "$compressed")" "$(hash_file "$compressed")"
    cat "$timing"
    sed 's/^/  /' "$errors"
  } >> "$transcript"
  (cd "$temp_dir" && sha256sum -- "${stem}.tsv.gz") >> "$shard_manifest"
done
if (( total_records != expected_records )); then
  printf 'wrong total records: %s != %s\n' "$total_records" "$expected_records" >&2
  exit 1
fi
printf 'GENERATED_FACTOR_BASE_IDEALS=%s\n' "$total_records" >> "$transcript"

temp_abs="$(realpath "$temp_dir")"
chmod a+rx -- "$temp_abs"
verify_paths=()
for index in $(seq 0 15); do
  verify_paths+=("/cert/$(printf 'p31_bdf_principal_%02d.tsv.gz' "$index")")
done
printf 'VERIFICATION_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
docker run --rm --cpus=1 -v "$temp_abs:/cert:ro" "$image" \
  sage -python /cert/verifier.py "${verify_paths[@]}" >> "$transcript" 2>&1
printf 'VERIFICATION_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"

grep -Fqx 'STRICT_NORM_BOUND=80000000' "$transcript"
grep -Fqx 'VERIFIED_SHARDS=16' "$transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=4668356' "$transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=660' "$transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 4667696, 2: 600, 3: 60}' "$transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$transcript"
grep -Fqx 'NO_UNIT_GROUP_OR_REGULATOR_USED=1' "$transcript"
grep -Fqx 'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"

rm -f -- "$temp_dir"/*.stderr "$temp_dir"/*.timing "$temp_dir/resource.ledger" \
  "$temp_dir/planner.output" "$temp_dir/producer.gp" "$temp_dir/verifier.py"
mkdir -- "$publish_dir"
cp -- "$temp_dir"/*.tsv.gz "$temp_dir/SHARDS.sha256" "$publish_dir"/
(cd "$publish_dir" && sha256sum -c SHARDS.sha256)
if [[ -e "$cert_dir" || -L "$cert_dir" ]]; then exit 2; fi
mv -T -- "$publish_dir" "$cert_dir"
safe_remove_work_dir "$temp_dir"
printf 'P31_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS\n' >> "$transcript"
