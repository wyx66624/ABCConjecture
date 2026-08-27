#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
formula="$root/p23_chebyshev_cl2_explicit_formula.sage"
generator="$root/p23_chebyshev_cl2_principal_generators.gp"
verifier="$root/p23_chebyshev_cl2_principal_verify.sage"
source_ledger="$root/p23_chebyshev_cl2_explicit_formula.source"
original_wrapper="$root/run_p23_chebyshev_cl2_explicit_cert.sh"
certificate="$root/p23_chebyshev_cl2_principal_generators.tsv.gz"
transcript="$root/p23_chebyshev_cl2_frozen_recheck.transcript"
meta="$root/p23_chebyshev_cl2_frozen_recheck.meta"
exit_record="$root/p23_chebyshev_cl2_frozen_recheck.exit"
image="sagemath/sagemath:10.9"
mount="/mnt/e/AImath/abc猜想:/work:ro"

: > "$transcript"
: > "$meta"
: > "$exit_record"

on_exit() {
  rc=$?
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

for required in \
  "$formula" "$generator" "$verifier" "$source_ledger" \
  "$original_wrapper" "$certificate" "$0"; do
  test -f "$required"
done
gzip -t -- "$certificate"

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'FORMULA_SHA256=%s\n' "$(hash_file "$formula")"
  printf 'GENERATOR_SHA256=%s\n' "$(hash_file "$generator")"
  printf 'VERIFIER_SHA256=%s\n' "$(hash_file "$verifier")"
  printf 'SOURCE_LEDGER_SHA256=%s\n' "$(hash_file "$source_ledger")"
  printf 'ORIGINAL_WRAPPER_SHA256=%s\n' "$(hash_file "$original_wrapper")"
  printf 'RECHECK_WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'CERTIFICATE_SHA256=%s\n' "$(hash_file "$certificate")"
  printf 'CERTIFICATE_BYTES=%s\n' "$(stat -c %s "$certificate")"
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
  printf 'GZIP_VERSION_BEGIN\n'
  gzip --version
  printf 'GZIP_VERSION_END\n'
  printf 'BOUND=8928769\n'
  printf 'EXPECTED_DEGREE_ONE_IDEALS=598492\n'
  printf 'EXPECTED_CERTIFICATE_RECORDS=598490\n'
} >> "$meta" 2>&1

printf 'FORMULA_RECHECK_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
set +e
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$formula /tmp/p23_formula.sage && sage /tmp/p23_formula.sage" \
  >> "$transcript" 2>&1
formula_rc=$?
set -e
printf 'FORMULA_RECHECK_EXIT_CODE=%s\n' "$formula_rc" >> "$transcript"
printf 'FORMULA_RECHECK_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( formula_rc != 0 )); then
  exit "$formula_rc"
fi

printf 'VERIFIER_RECHECK_START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
set +e
docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "cp /work/$verifier /tmp/p23_verify.sage && sage /tmp/p23_verify.sage /work/$certificate" \
  >> "$transcript" 2>&1
verifier_rc=$?
set -e
printf 'VERIFIER_RECHECK_EXIT_CODE=%s\n' "$verifier_rc" >> "$transcript"
printf 'VERIFIER_RECHECK_END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta"
if (( verifier_rc != 0 )); then
  exit "$verifier_rc"
fi

grep -Fqx 'P23_CL2_EXPLICIT_FORMULA_PASS' "$transcript"
grep -Fqx 'P23_CL2_PRINCIPAL_EXACT_VERIFY_PASS' "$transcript"
printf 'P23_CL2_FROZEN_RECHECK_PASS\n' >> "$transcript"
