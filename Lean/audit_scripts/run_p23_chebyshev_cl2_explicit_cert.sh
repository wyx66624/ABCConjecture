#!/usr/bin/env bash
set -uo pipefail

root="Lean/audit_scripts"
formula="$root/p23_chebyshev_cl2_explicit_formula.sage"
generator="$root/p23_chebyshev_cl2_principal_generators.gp"
verifier="$root/p23_chebyshev_cl2_principal_verify.sage"
certificate="$root/p23_chebyshev_cl2_principal_generators.tsv.gz"
transcript="$root/p23_chebyshev_cl2_explicit_cert.transcript"
meta="$root/p23_chebyshev_cl2_explicit_cert.meta"
exit_record="$root/p23_chebyshev_cl2_explicit_cert.exit"
image="sagemath/sagemath:10.9"
mount="/mnt/e/AImath/abc猜想:/work:ro"
temporary_certificate="${certificate}.tmp.$$"

: > "$transcript"
: > "$exit_record"
: > "$meta"

cleanup() {
  rm -f -- "$temporary_certificate"
}
trap cleanup EXIT

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
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
  printf 'GZIP_VERSION='
  gzip --version | head -n 1
  printf 'BOUND=8928769\n'
  printf 'EXPECTED_DEGREE_ONE_IDEALS=598492\n'
  printf 'EXPECTED_CERTIFICATE_RECORDS=598490\n'
} >> "$meta" 2>&1

printf 'FORMULA_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$formula /tmp/p23_formula.sage && sage /tmp/p23_formula.sage" \
  >> "$transcript" 2>&1
rc=$?
printf 'FORMULA_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( rc != 0 )); then
  printf 'FORMULA_EXIT_CODE=%s\n' "$rc" >> "$transcript"
  printf '%s\n' "$rc" > "$exit_record"
  printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  exit "$rc"
fi

printf 'GENERATOR_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
LC_ALL=C TZ=UTC nice -n 15 gp -qf "$generator" \
  2>> "$transcript" | gzip -n -9 > "$temporary_certificate"
rc=$?
printf 'GENERATOR_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( rc != 0 )); then
  printf 'GENERATOR_EXIT_CODE=%s\n' "$rc" >> "$transcript"
  printf '%s\n' "$rc" > "$exit_record"
  printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
  exit "$rc"
fi
mv -f -- "$temporary_certificate" "$certificate"

printf 'VERIFIER_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$verifier /tmp/p23_verify.sage && sage /tmp/p23_verify.sage /work/$certificate" \
  >> "$transcript" 2>&1
rc=$?
printf 'VERIFIER_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
printf '%s\n' "$rc" > "$exit_record"
printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
exit "$rc"
