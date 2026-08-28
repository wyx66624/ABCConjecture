#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

base=p31_chebyshev_global_dyadic
transcript=${base}.transcript
meta=${base}.meta
exit_file=${base}.exit
image=sagemath/sagemath:10.9
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

: > "$transcript"
: > "$meta"
: > "$exit_file"
on_exit() {
  code=$?
  echo "EXIT_CODE=$code" >> "$transcript"
  echo "$code" > "$exit_file"
  echo "END_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  trap - EXIT
  exit "$code"
}
trap on_exit EXIT

sha256sum -c p31_chebyshev_s_squareclass.sha256 >> "$transcript" 2>&1
echo P31_S_SQUARECLASS_MANIFEST_PASS >> "$transcript"

cp p31_chebyshev_s_squareclass_verify.sage "$tmp/"
cp p31_chebyshev_global_dyadic_verify.sage "$tmp/"
chmod 755 "$tmp"
chmod 644 "$tmp"/*.sage
{
  echo "START_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "BASE_SOURCE_SHA256=$(sha256sum p31_chebyshev_s_squareclass_verify.sage | cut -d' ' -f1)"
  echo "SOURCE_SHA256=$(sha256sum p31_chebyshev_global_dyadic_verify.sage | cut -d' ' -f1)"
  echo "BASE_MANIFEST_SHA256=$(sha256sum p31_chebyshev_s_squareclass.sha256 | cut -d' ' -f1)"
  echo "WRAPPER_SHA256=$(sha256sum "$0" | cut -d' ' -f1)"
  echo "DOCKER_IMAGE=$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
} >> "$meta"

docker run --rm --entrypoint /bin/bash -v "$tmp:/cert:ro" -w /tmp "$image" \
  -lc 'cp /cert/*.sage /tmp/ && sage /tmp/p31_chebyshev_global_dyadic_verify.sage' \
  >> "$transcript" 2>&1

grep -Fqx 'EXPECTED_S_SQUARECLASS_DIM 20' "$transcript"
grep -Fq 'P3COUNT 2 P3_DEGREES [1, 30] LOCAL3_PAIR_RANK 4 L3_DIM 1' "$transcript"
grep -Fq 'COMBINED_CONSTRAINT_RANK 5 W_DIM 15 W_COUNT 32768' "$transcript"
grep -Fqx 'DYADIC_TEST_CLASSES 33 GLOBAL_REP_DYADIC_RANK 19 W_DYADIC_RANK 15 KERNEL_DIM 0 GAMMA2_RANK 2' "$transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$transcript"
grep -Fqx 'NO_UNIT_GROUP_OR_REGULATOR_USED=1' "$transcript"
grep -Fqx 'P31_GLOBAL_DYADIC_INJECTION_PASS' "$transcript"
echo P31_GLOBAL_DYADIC_FROZEN_RUN_PASS >> "$transcript"
