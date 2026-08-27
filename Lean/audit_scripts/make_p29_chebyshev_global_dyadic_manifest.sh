#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
manifest="$root/p29_chebyshev_global_dyadic_overapprox.sha256"
tmp="${manifest}.tmp.$$"
script="$root/p29_chebyshev_global_dyadic_overapprox.sage"
wrapper="$root/run_p29_chebyshev_global_dyadic_overapprox.sh"
transcript="$root/p29_chebyshev_global_dyadic_overapprox.transcript"
meta="$root/p29_chebyshev_global_dyadic_overapprox.meta"
exit_record="$root/p29_chebyshev_global_dyadic_overapprox.exit"
class1_manifest="$root/p29_chebyshev_cl1_bdf_principal.sha256"
class1_recheck="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.transcript"
report="Lean/P29_CHEBYSHEV_GLOBAL_DYADIC_CERTIFICATE.md"
lean_core="Lean/IUTThreeClosures/P29SelmerLinearCore.lean"

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

test "$(tr -d '\r\n' < "$exit_record")" = 0
grep -Fqx 'P29_CLASS_NUMBER_ONE_MANIFEST_PASS' "$transcript"
grep -Fqx 'SQUARECLASS_DETECTION_RANK 19' "$transcript"
grep -Fqx 'NORM_RANK 4' "$transcript"
grep -Fq 'P3COUNT 2 P3_DEGREES [1, 28] LOCAL3_PAIR_RANK 4 L3_DIM 1' \
  "$transcript"
grep -Fq 'COMBINED_CONSTRAINT_RANK 5 W3DIM 14 COUNT 16384' "$transcript"
grep -Fq 'W2_SIGNATURE_RANK 14 KERNEL_DIM 0 GAMMA2_RANK 2' "$transcript"
grep -Fqx 'P29_GLOBAL_DYADIC_OVERAPPROX_PASS' "$transcript"
grep -Fqx 'P29_GLOBAL_DYADIC_FROZEN_RUN_PASS' "$transcript"
grep -Fqx 'EXIT_CODE=0' "$transcript"
grep -Fq 'END_UTC=' "$meta"

grep -Fqx "SCRIPT_SHA256=$(hash_file "$script")" "$meta"
grep -Fqx "CLASS1_MANIFEST_SHA256=$(hash_file "$class1_manifest")" "$meta"
grep -Fqx "CLASS1_RECHECK_TRANSCRIPT_SHA256=$(hash_file "$class1_recheck")" "$meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$wrapper")" "$meta"

sha256sum -c -- "$class1_manifest"

files=(
  "$script"
  "$wrapper"
  "$transcript"
  "$meta"
  "$exit_record"
  "$class1_manifest"
  "$class1_recheck"
  "$report"
  "$lean_core"
  "$0"
)

test "${#files[@]}" -eq 10
for required in "${files[@]}"; do
  test -f "$required"
done

sha256sum -- "${files[@]}" > "$tmp"
test "$(wc -l < "$tmp")" -eq 10
mv -f -- "$tmp" "$manifest"
sha256sum -c -- "$manifest"
printf 'P29_GLOBAL_DYADIC_MANIFEST_PASS\n'
