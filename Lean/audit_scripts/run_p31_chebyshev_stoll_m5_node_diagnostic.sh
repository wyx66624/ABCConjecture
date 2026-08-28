#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
precision=${1:-10000}
case "$precision" in 10000|12000|16000) ;; *) exit 2;; esac
base=p31_chebyshev_stoll_m5_node_diagnostic_${precision}
transcript=${base}.transcript; meta=${base}.meta; exit_file=${base}.exit
image=sagemath/sagemath:10.9; tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
: > "$transcript"; : > "$meta"; : > "$exit_file"
on_exit(){ code=$?; echo "EXIT_CODE=$code" >> "$transcript"; echo "$code" > "$exit_file"; echo "END_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"; trap - EXIT; exit "$code"; }
trap on_exit EXIT
for f in p31_chebyshev_s_squareclass_verify.sage p31_chebyshev_global_dyadic_verify.sage p31_chebyshev_stoll_m5_node_diagnostic.sage; do cp "$f" "$tmp/"; done
chmod 755 "$tmp"; chmod 644 "$tmp"/*.sage
{
 echo "START_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)"; echo "PRECISION_BITS=$precision"
 echo "SOURCE_SHA256=$(sha256sum p31_chebyshev_stoll_m5_node_diagnostic.sage|cut -d' ' -f1)"
 echo "FROZEN_8K_MANIFEST_SHA256=$(sha256sum p31_chebyshev_stoll_gamma2_8k_failure.sha256|cut -d' ' -f1)"
 docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
} > "$meta"
docker run --rm --entrypoint /bin/bash -e P31_DIAGNOSTIC_PRECISION="$precision" -v "$tmp:/cert:ro" -w /tmp "$image" -lc 'cp /cert/*.sage /tmp/ && sage /tmp/p31_chebyshev_stoll_m5_node_diagnostic.sage' >> "$transcript" 2>&1
grep -Fqx 'P31_M5_SINGLE_NODE_DIAGNOSTIC_PASS' "$transcript"
