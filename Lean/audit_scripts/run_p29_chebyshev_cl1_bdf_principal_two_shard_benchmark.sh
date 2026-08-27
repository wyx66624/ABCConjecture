#!/usr/bin/env bash
set -euo pipefail

# Small benchmark only.  It cross-checks one canonical producer run against
# two independent GP/BNF processes on static rational-prime intervals.  All
# generated artifacts live under /tmp and are deleted on the next invocation.

root="Lean/audit_scripts"
producer="$root/p29_chebyshev_cl1_bdf_principal_generators.gp"
verifier="$root/p29_chebyshev_cl1_bdf_principal_verify.sage"
T="${P29_BENCH_T:-100000}"
split="${P29_BENCH_SPLIT:-50000}"
tmp="/tmp/p29_bdf_principal_two_shard_benchmark"
image="sagemath/sagemath:10.9"

if (( T <= 2 || split <= 2 || split >= T )); then
  printf 'require 2 < P29_BENCH_SPLIT < P29_BENCH_T\n' >&2
  exit 2
fi

mkdir -p -- "$tmp"
rm -f -- "$tmp"/single.tsv "$tmp"/shard0.tsv "$tmp"/shard1.tsv \
  "$tmp"/single.err "$tmp"/shard0.err "$tmp"/shard1.err \
  "$tmp"/single.records "$tmp"/merged.records "$tmp"/merged.tsv \
  "$tmp"/merged.tsv.gz

run_producer() {
  local lo="$1"
  local hi="$2"
  local output="$3"
  local errors="$4"
  P29_BDF_T="$T" P29_Q_LO="$lo" P29_Q_HI="$hi" \
    gp -qf "$producer" > "$output" 2> "$errors"
}

sample_two_rss() {
  local pid0="$1"
  local pid1="$2"
  local max0=0
  local max1=0
  local rss0 rss1
  while kill -0 "$pid0" 2>/dev/null || kill -0 "$pid1" 2>/dev/null; do
    # A background shell function may be represented by a tiny subshell whose
    # direct child is GP.  Sum both so the sample is not merely the wrapper's
    # resident set.
    rss0="$(ps -o rss= -p "$pid0" --ppid "$pid0" 2>/dev/null | awk '{s += $1} END {if (s) print s}' || true)"
    rss1="$(ps -o rss= -p "$pid1" --ppid "$pid1" 2>/dev/null | awk '{s += $1} END {if (s) print s}' || true)"
    [[ -n "$rss0" ]] && (( rss0 > max0 )) && max0="$rss0"
    [[ -n "$rss1" ]] && (( rss1 > max1 )) && max1="$rss1"
    sleep 0.1
  done
  printf '%s %s\n' "$max0" "$max1" > "$tmp/shard_peak_rss_kb"
}

start_ns="$(date +%s%N)"
run_producer 2 "$split" "$tmp/shard0.tsv" "$tmp/shard0.err" &
pid0="$!"
run_producer "$split" "$T" "$tmp/shard1.tsv" "$tmp/shard1.err" &
pid1="$!"
sample_two_rss "$pid0" "$pid1"
wait "$pid0"
wait "$pid1"
end_ns="$(date +%s%N)"
two_wall_ms="$(( (end_ns - start_ns) / 1000000 ))"

start_ns="$(date +%s%N)"
run_producer 2 "$T" "$tmp/single.tsv" "$tmp/single.err"
end_ns="$(date +%s%N)"
single_wall_ms="$(( (end_ns - start_ns) / 1000000 ))"

LC_ALL=C awk '!/^#/' "$tmp/single.tsv" > "$tmp/single.records"
LC_ALL=C awk '!/^#/' "$tmp/shard0.tsv" "$tmp/shard1.tsv" > "$tmp/merged.records"
cmp "$tmp/single.records" "$tmp/merged.records"

record_count="$(wc -l < "$tmp/merged.records" | tr -d ' ')"
{
  printf '#P29_BDF_PRINCIPAL_CERT_V1\n'
  printf '#STRICT_NORM_BOUND=%s\n' "$T"
  printf '#RATIONAL_Q_RANGE=[2,%s)\n' "$T"
  printf '#POLYNOMIAL=x^29-2\n'
  printf '#FIELDS=q,f,beta_c0,...,beta_c28,alpha_c0,...,alpha_c28\n'
  LC_ALL=C awk '!/^#/' "$tmp/shard0.tsv" "$tmp/shard1.tsv"
  printf '#COUNT=%s\n' "$record_count"
  printf '#P29_BDF_PRINCIPAL_CERT_END\n'
} > "$tmp/merged.tsv"
gzip -n -9 -c "$tmp/merged.tsv" > "$tmp/merged.tsv.gz"

docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "/mnt/e/AImath/abc猜想:/work:ro" -v "$tmp:/bench:ro" "$image" \
  -lc "cp /work/$verifier /tmp/verify.sage && \
       sage /tmp/verify.sage /bench/shard0.tsv /bench/shard1.tsv && \
       sage /tmp/verify.sage /bench/merged.tsv.gz"

read -r peak0 peak1 < "$tmp/shard_peak_rss_kb"
printf 'BENCH_T=%s\n' "$T"
printf 'STATIC_Q_RANGES=[2,%s),[%s,%s)\n' "$split" "$split" "$T"
printf 'RECORDS=%s\n' "$record_count"
printf 'TWO_WORKER_WALL_MS=%s\n' "$two_wall_ms"
printf 'SINGLE_WORKER_WALL_MS=%s\n' "$single_wall_ms"
printf 'SHARD_PEAK_RSS_KB=%s,%s\n' "$peak0" "$peak1"
printf 'UNCOMPRESSED_BYTES=%s\n' "$(wc -c < "$tmp/merged.tsv" | tr -d ' ')"
printf 'GZIP_N9_BYTES=%s\n' "$(wc -c < "$tmp/merged.tsv.gz" | tr -d ' ')"
printf 'SINGLE_VS_TWO_SHARDS_BYTE_IDENTICAL_RECORDS=1\n'
printf 'DIRECT_TWO_SHARD_AND_MERGED_VERIFY_PASS=1\n'
printf 'P29_BDF_PRINCIPAL_TWO_SHARD_BENCHMARK_PASS\n'
