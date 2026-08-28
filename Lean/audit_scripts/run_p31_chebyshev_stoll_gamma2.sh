#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

base=p31_chebyshev_stoll_gamma2
transcript=${base}.transcript
meta=${base}.meta
exit_file=${base}.exit
image=sagemath/sagemath:10.9
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
: > "$transcript"; : > "$meta"; : > "$exit_file"
on_exit() {
  code=$?
  echo "EXIT_CODE=$code" >> "$transcript"
  echo "$code" > "$exit_file"
  echo "END_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  trap - EXIT
  exit "$code"
}
trap on_exit EXIT

sha256sum -c p31_chebyshev_global_dyadic.sha256 >> "$transcript" 2>&1
echo P31_GLOBAL_DYADIC_MANIFEST_PASS >> "$transcript"
for source in p31_chebyshev_s_squareclass_verify.sage \
  p31_chebyshev_global_dyadic_verify.sage \
  p31_chebyshev_stoll_gamma2.sage; do cp "$source" "$tmp/"; done
chmod 755 "$tmp"; chmod 644 "$tmp"/*.sage
{
  echo "START_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "SOURCE_SHA256=$(sha256sum p31_chebyshev_stoll_gamma2.sage | cut -d' ' -f1)"
  echo "GLOBAL_SOURCE_SHA256=$(sha256sum p31_chebyshev_global_dyadic_verify.sage | cut -d' ' -f1)"
  echo "GLOBAL_MANIFEST_SHA256=$(sha256sum p31_chebyshev_global_dyadic.sha256 | cut -d' ' -f1)"
  echo "WRAPPER_SHA256=$(sha256sum "$0" | cut -d' ' -f1)"
  echo "PRECISION_BITS=8000"
  echo "REQUIRED_IDENTITY_VALUATION=2000"
  echo "DOCKER_IMAGE=$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
} >> "$meta"

docker run --rm --entrypoint /bin/bash -v "$tmp:/cert:ro" -w /tmp "$image" \
  -lc 'cp /cert/*.sage /tmp/ && sage /tmp/p31_chebyshev_stoll_gamma2.sage' \
  >> "$transcript" 2>&1

grep -Fqx 'P31_GLOBAL_DYADIC_INJECTION_PASS' "$transcript"
grep -Fq 'P31_EXACT_CANTOR_SUM_PASS ROUNDS 8' "$transcript"
grep -Fqx 'P31_GAMMA2_LOCAL_INDEPENDENCE_PASS' "$transcript"
grep -Fqx 'P31_W_SIGNATURE_MINOR [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18] DETERMINANT 1' "$transcript"
grep -Fqx 'P31_STOLL_GAMMA2_OVERAPPROX_PASS' "$transcript"
echo P31_STOLL_GAMMA2_FROZEN_RUN_PASS >> "$transcript"
