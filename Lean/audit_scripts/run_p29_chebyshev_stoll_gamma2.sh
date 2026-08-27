#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
script="$root/p29_chebyshev_stoll_gamma2.sage"
global_script="$root/p29_chebyshev_global_dyadic_overapprox.sage"
global_wrapper="$root/run_p29_chebyshev_global_dyadic_overapprox.sh"
global_transcript="$root/p29_chebyshev_global_dyadic_overapprox.transcript"
global_meta="$root/p29_chebyshev_global_dyadic_overapprox.meta"
global_exit="$root/p29_chebyshev_global_dyadic_overapprox.exit"
class1_manifest="$root/p29_chebyshev_cl1_bdf_principal.sha256"
class1_recheck_transcript="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.transcript"
class1_recheck_exit="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.exit"
transcript="$root/p29_chebyshev_stoll_gamma2.transcript"
meta="$root/p29_chebyshev_stoll_gamma2.meta"
exit_record="$root/p29_chebyshev_stoll_gamma2.exit"
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

for required in "$script" "$global_script" "$global_wrapper" \
  "$global_transcript" "$global_meta" "$global_exit" \
  "$class1_manifest" "$class1_recheck_transcript" \
  "$class1_recheck_exit" "$0"; do
  test -f "$required"
done

# Refuse to run against a stale or failed global/class-number-one gate.
test "$(tr -d '\r\n' < "$global_exit")" = 0
grep -Fqx 'P29_GLOBAL_DYADIC_OVERAPPROX_PASS' "$global_transcript"
grep -Fqx 'P29_GLOBAL_DYADIC_FROZEN_RUN_PASS' "$global_transcript"
grep -Fqx 'EXIT_CODE=0' "$global_transcript"
test "$(tr -d '\r\n' < "$class1_recheck_exit")" = 0
grep -Fqx 'P29_BDF_PRINCIPAL_FROZEN_RECHECK_PASS' \
  "$class1_recheck_transcript"
grep -Fqx 'EXIT_CODE=0' "$class1_recheck_transcript"
sha256sum -c -- "$class1_manifest" >/dev/null
printf 'P29_CLASS_NUMBER_ONE_MANIFEST_PASS\n' >> "$transcript"
printf 'P29_GLOBAL_DYADIC_PREREQUISITE_PASS\n' >> "$transcript"

{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'SCRIPT_SHA256=%s\n' "$(hash_file "$script")"
  printf 'GLOBAL_SCRIPT_SHA256=%s\n' "$(hash_file "$global_script")"
  printf 'GLOBAL_WRAPPER_SHA256=%s\n' "$(hash_file "$global_wrapper")"
  printf 'GLOBAL_TRANSCRIPT_SHA256=%s\n' "$(hash_file "$global_transcript")"
  printf 'GLOBAL_META_SHA256=%s\n' "$(hash_file "$global_meta")"
  printf 'CLASS1_MANIFEST_SHA256=%s\n' "$(hash_file "$class1_manifest")"
  printf 'WRAPPER_SHA256=%s\n' "$(hash_file "$0")"
  printf 'DOCKER_IMAGE=%s\n' "$image"
  docker image inspect "$image" --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect "$image" --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'SAGE_VERSION='
  docker run --rm --cpus=1 "$image" sage --version
  printf 'PADIC_PRECISION=8000\n'
  printf 'EXPECTED_W_DIMENSION=14\n'
  printf 'EXPECTED_SIGNATURE_MINOR_RANK=14\n'
  printf 'EXPECTED_TERMINAL_SQUARECLASSES=2\n'
  printf 'EXPECTED_SHELL_MAXIMA=5,6,7\n'
  printf 'EXPECTED_TAIL_M=5\n'
  printf '%s\n' \
    'ACCEPTED_INTERFACE=Stoll_Theorem_2.1_Lemma_2.4_Corollary_3.2_Lemma_3.10_Proposition_5.1_Remark_5.2_and_standard_hyperelliptic_Kummer_theory'
} >> "$meta" 2>&1

docker run --rm --cpus=1 --entrypoint /bin/bash \
  -v "$mount" "$image" \
  -lc "set -euo pipefail
       mkdir -p /tmp/p29_stoll
       cp /work/$global_script /tmp/p29_stoll/p29_chebyshev_global_dyadic_overapprox.sage
       cp /work/$script /tmp/p29_stoll/p29_chebyshev_stoll_gamma2.sage
       cd /tmp/p29_stoll
       sage p29_chebyshev_stoll_gamma2.sage" \
  >> "$transcript" 2>&1

grep -Fqx 'P29_GLOBAL_DYADIC_OVERAPPROX_PASS' "$transcript"
grep -Fq 'P29_EXACT_CANTOR_SUM_PASS ROUNDS 7' "$transcript"
grep -Fqx 'P29_GAMMA2_LOCAL_INDEPENDENCE_PASS' "$transcript"
grep -Fq 'SHELL_SUMMARY M 3 UNIT_MODULUS 32 REPS 16 MAX_NU 5' "$transcript"
grep -Fq 'SHELL_SUMMARY M 4 UNIT_MODULUS 32 REPS 16 MAX_NU 6' "$transcript"
grep -Fq 'SHELL_SUMMARY M 5 UNIT_MODULUS 32 REPS 16 MAX_NU 7' "$transcript"
grep -Fqx 'TAIL_LEMMA_3_10 M 5 BOUND 7 MAX_NU 7 PASS True' "$transcript"
grep -Fqx 'TERMINAL_SQUARECLASS_COUNT 2' "$transcript"
grep -Fqx 'P29_STOLL_GAMMA2_OVERAPPROX_PASS' "$transcript"
test "$(grep -c '^NODE ' "$transcript")" = 48
test "$(grep -c 'TERMINAL_IN_W False' "$transcript")" = 48
test "$(grep -c '^NEW_TERMINAL_SQUARECLASS ' "$transcript")" = 2
test "$(grep -c 'DIRECT_SQUARE_MEMBERSHIP False' "$transcript")" = 2

printf 'P29_STOLL_GAMMA2_FROZEN_RUN_PASS\n' >> "$transcript"
