#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
manifest="$root/p29_chebyshev_stoll_gamma2.sha256"
tmp="${manifest}.tmp.$$"
script="$root/p29_chebyshev_stoll_gamma2.sage"
wrapper="$root/run_p29_chebyshev_stoll_gamma2.sh"
transcript="$root/p29_chebyshev_stoll_gamma2.transcript"
meta="$root/p29_chebyshev_stoll_gamma2.meta"
exit_record="$root/p29_chebyshev_stoll_gamma2.exit"
global_script="$root/p29_chebyshev_global_dyadic_overapprox.sage"
global_wrapper="$root/run_p29_chebyshev_global_dyadic_overapprox.sh"
global_transcript="$root/p29_chebyshev_global_dyadic_overapprox.transcript"
global_meta="$root/p29_chebyshev_global_dyadic_overapprox.meta"
global_manifest="$root/p29_chebyshev_global_dyadic_overapprox.sha256"
class1_manifest="$root/p29_chebyshev_cl1_bdf_principal.sha256"
report="Lean/P29_CHEBYSHEV_STOLL_GAMMA2_CERTIFICATE.md"

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

for required in "$script" "$wrapper" "$transcript" "$meta" \
  "$exit_record" "$global_script" "$global_wrapper" \
  "$global_transcript" "$global_meta" "$global_manifest" \
  "$class1_manifest" "$report" "$0"; do
  test -f "$required"
done

# The frozen metadata must describe the exact executable inputs that are
# currently being packaged.
test "$(tr -d '\r\n' < "$exit_record")" = 0
grep -Fqx "SCRIPT_SHA256=$(hash_file "$script")" "$meta"
grep -Fqx "GLOBAL_SCRIPT_SHA256=$(hash_file "$global_script")" "$meta"
grep -Fqx "GLOBAL_WRAPPER_SHA256=$(hash_file "$global_wrapper")" "$meta"
grep -Fqx "GLOBAL_TRANSCRIPT_SHA256=$(hash_file "$global_transcript")" "$meta"
grep -Fqx "GLOBAL_META_SHA256=$(hash_file "$global_meta")" "$meta"
grep -Fqx "CLASS1_MANIFEST_SHA256=$(hash_file "$class1_manifest")" "$meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$wrapper")" "$meta"
grep -Fqx 'PADIC_PRECISION=8000' "$meta"
grep -Fqx 'EXPECTED_W_DIMENSION=14' "$meta"
grep -Fqx 'EXPECTED_SIGNATURE_MINOR_RANK=14' "$meta"
grep -Fqx 'EXPECTED_TERMINAL_SQUARECLASSES=2' "$meta"
grep -Fqx 'EXPECTED_SHELL_MAXIMA=5,6,7' "$meta"
grep -Fqx 'EXPECTED_TAIL_M=5' "$meta"
grep -Fq 'ACCEPTED_INTERFACE=Stoll_Theorem_2.1_Lemma_2.4_' "$meta"
grep -Fq 'END_UTC=' "$meta"

# Recursively verify the complete global dyadic prerequisite.
sha256sum -c -- "$global_manifest"

# PASS gates and exact computation shape.
grep -Fqx 'P29_CLASS_NUMBER_ONE_MANIFEST_PASS' "$transcript"
grep -Fqx 'P29_GLOBAL_DYADIC_PREREQUISITE_PASS' "$transcript"
grep -Fqx 'P29_GLOBAL_DYADIC_OVERAPPROX_PASS' "$transcript"
grep -Fq 'P29_EXACT_CANTOR_SUM_PASS ROUNDS 7' "$transcript"
grep -Fqx 'P29_GAMMA2_LOCAL_INDEPENDENCE_PASS' "$transcript"
grep -Fqx 'TERMINAL_SQUARECLASS_COUNT 2' "$transcript"
grep -Fqx \
  'ADAPTIVE_SHELL_SUMMARIES [(3, 5, 16, 5, 7148), (4, 5, 16, 6, 7347), (5, 5, 16, 7, 7168)]' \
  "$transcript"
grep -Fqx 'P29_STOLL_GAMMA2_OVERAPPROX_PASS' "$transcript"
grep -Fqx 'P29_STOLL_GAMMA2_FROZEN_RUN_PASS' "$transcript"
grep -Fqx 'EXIT_CODE=0' "$transcript"

test "$(grep -c '^NEW_TERMINAL_SQUARECLASS ' "$transcript")" = 2
test "$(grep -c '^NEW_TERMINAL_SQUARECLASS 0 ' "$transcript")" = 1
test "$(grep -c '^NEW_TERMINAL_SQUARECLASS 1 ' "$transcript")" = 1
test "$(grep -c 'DIRECT_SQUARE_MEMBERSHIP False' "$transcript")" = 2
test "$(grep -c '^NODE ' "$transcript")" = 48
test "$(grep -c 'TERMINAL_IN_W False' "$transcript")" = 48

expected_units='1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31'
for shell in 3 4 5; do
  test "$(awk -v m="$shell" '$1=="NODE" && $3==m {n++} END {print n+0}' \
    "$transcript")" = 16
  actual_units="$(awk -v m="$shell" '$1=="NODE" && $3==m {print $5}' \
    "$transcript" | paste -sd ' ' -)"
  test "$actual_units" = "$expected_units"
done

test "$(awk '$1=="NODE" && $3==3 && $9==5 {n++} END {print n+0}' \
  "$transcript")" = 16
test "$(awk '$1=="NODE" && $3==4 && $9==6 {n++} END {print n+0}' \
  "$transcript")" = 16
test "$(awk '$1=="NODE" && $3==5 && $9==7 {n++} END {print n+0}' \
  "$transcript")" = 16

# Every X must equal -4+4*2^m*u, every terminal class is 0 or 1, and every
# recorded identity valuation must exceed the executable threshold 2000.
awk '$1=="NODE" {
       expected=-4+4*(2^$3)*$5
       if ($7 != expected || ($11 != 0 && $11 != 1) || $15 <= 2000) bad=1
     }
     END {exit bad}' "$transcript"

grep -Fqx \
  'SHELL_SUMMARY M 3 UNIT_MODULUS 32 REPS 16 MAX_NU 5 MIN_ID_VAL 7148' \
  "$transcript"
grep -Fqx \
  'SHELL_SUMMARY M 4 UNIT_MODULUS 32 REPS 16 MAX_NU 6 MIN_ID_VAL 7347' \
  "$transcript"
grep -Fqx \
  'SHELL_SUMMARY M 5 UNIT_MODULUS 32 REPS 16 MAX_NU 7 MIN_ID_VAL 7168' \
  "$transcript"
grep -Fqx 'TAIL_TEST M 3 BOUND 3 MAX_NU 5 PASS False' "$transcript"
grep -Fqx 'TAIL_TEST M 4 BOUND 5 MAX_NU 6 PASS False' "$transcript"
grep -Fqx 'TAIL_TEST M 5 BOUND 7 MAX_NU 7 PASS True' "$transcript"
grep -Fqx 'TAIL_LEMMA_3_10 M 5 BOUND 7 MAX_NU 7 PASS True' "$transcript"

files=(
  "$script"
  "$wrapper"
  "$transcript"
  "$meta"
  "$exit_record"
  "$global_manifest"
  "$report"
  "$0"
)

test "${#files[@]}" -eq 8
for required in "${files[@]}"; do
  test -f "$required"
done

sha256sum -- "${files[@]}" > "$tmp"
test "$(wc -l < "$tmp")" -eq 8
! grep -Eiq '/[^/]*(coleman|stollgamma).*\.lean([[:space:]]|$)' "$tmp"
mv -f -- "$tmp" "$manifest"
sha256sum -c -- "$manifest"
printf 'P29_STOLL_GAMMA2_MANIFEST_PASS\n'
