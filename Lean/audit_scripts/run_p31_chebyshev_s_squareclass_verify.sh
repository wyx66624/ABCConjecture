#!/usr/bin/env bash
set -u
cd "$(dirname "$0")"

base=p31_chebyshev_s_squareclass
transcript=${base}.transcript
meta=${base}.meta
exit_file=${base}.exit
image=sagemath/sagemath:10.9
start=$(date -u +%Y-%m-%dT%H:%M:%SZ)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cp p31_chebyshev_s_squareclass_verify.sage "$tmp/verify.sage"
chmod a+rx "$tmp"
chmod a+r "$tmp/verify.sage"
{
  echo "START_UTC=$start"
  echo "SOURCE_SHA256=$(sha256sum p31_chebyshev_s_squareclass_verify.sage | cut -d' ' -f1)"
  echo "DISCOVERY_SOURCE_SHA256=$(sha256sum p31_chebyshev_s_squareclass_discover.gp | cut -d' ' -f1)"
  echo "WRAPPER_SHA256=$(sha256sum "$0" | cut -d' ' -f1)"
  echo "DOCKER_IMAGE=$image"
  echo "DOCKER_IMAGE_ID=$(docker image inspect "$image" --format '{{.Id}}')"
  echo "DOCKER_REPO_DIGESTS=$(docker image inspect "$image" --format '{{json .RepoDigests}}')"
} > "$meta"

set +e
docker run --rm --entrypoint /bin/bash -v "$tmp:/cert:ro" -w /tmp "$image" \
  -lc 'cp /cert/verify.sage /tmp/verify.sage && sage /tmp/verify.sage' \
  > "$transcript" 2>&1
code=$?
set -e

echo "EXIT_CODE=$code" >> "$transcript"
echo "$code" > "$exit_file"
echo "END_UTC=$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"

if [[ $code -ne 0 ]]; then exit "$code"; fi
grep -Fqx 'EXPECTED_S_SQUARECLASS_DIM 20' "$transcript"
grep -Fqx 'COMBINED_SQUARECLASS_DETECTION_RANK 20' "$transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$transcript"
grep -Fqx 'NO_UNIT_GROUP_OR_REGULATOR_USED=1' "$transcript"
grep -Fqx 'P31_S_SQUARECLASS_EXACT_VERIFY_PASS' "$transcript"
grep -Fqx 'EXIT_CODE=0' "$transcript"
echo P31_S_SQUARECLASS_FROZEN_RUN_PASS
