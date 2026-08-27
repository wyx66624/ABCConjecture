#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
manifest="$root/p23_chebyshev_cl2_explicit_cert.sha256"
formula="$root/p23_chebyshev_cl2_explicit_formula.sage"
generator="$root/p23_chebyshev_cl2_principal_generators.gp"
verifier="$root/p23_chebyshev_cl2_principal_verify.sage"
source_ledger="$root/p23_chebyshev_cl2_explicit_formula.source"
original_wrapper="$root/run_p23_chebyshev_cl2_explicit_cert.sh"
certificate="$root/p23_chebyshev_cl2_principal_generators.tsv.gz"
run_transcript="$root/p23_chebyshev_cl2_explicit_cert.transcript"
run_meta="$root/p23_chebyshev_cl2_explicit_cert.meta"
run_exit="$root/p23_chebyshev_cl2_explicit_cert.exit"
recheck_wrapper="$root/run_p23_chebyshev_cl2_frozen_recheck.sh"
recheck_transcript="$root/p23_chebyshev_cl2_frozen_recheck.transcript"
recheck_meta="$root/p23_chebyshev_cl2_frozen_recheck.meta"
recheck_exit="$root/p23_chebyshev_cl2_frozen_recheck.exit"
report="Lean/P23_CHEBYSHEV_CL2_EXPLICIT_CERTIFICATE.md"
main_report="Lean/FREY_PELL_CHEBYSHEV_INDEX_TWENTY_THREE_STOLL_GAMMA_CLOSURE.md"
lean_companion="Lean/IUTThreeClosures/FreyPellChebyshevIndexTwentyThreeStollGammaCertificate.lean"

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

test "$(tr -d '\r\n' < "$run_exit")" = 0
test "$(tr -d '\r\n' < "$recheck_exit")" = 0
grep -Fqx 'P23_CL2_EXPLICIT_FORMULA_PASS' "$run_transcript"
grep -Fqx 'GENERATOR_RECORDS=598490' "$run_transcript"
grep -Fqx 'P23_CL2_PRINCIPAL_GENERATION_PASS' "$run_transcript"
grep -Fqx 'VERIFIED_RECORDS=598490' "$run_transcript"
grep -Fqx 'POWER_BASIS_DEDEKIND_INDEX_CHECK=1' "$run_transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$run_transcript"
grep -Fqx 'P23_CL2_PRINCIPAL_EXACT_VERIFY_PASS' "$run_transcript"
grep -Fqx 'EXIT_CODE=0' "$run_transcript"
grep -Fq 'END_UTC=' "$run_meta"
grep -Fqx 'P23_CL2_FROZEN_RECHECK_PASS' "$recheck_transcript"
grep -Fqx 'FORMULA_RECHECK_EXIT_CODE=0' "$recheck_transcript"
grep -Fqx 'VERIFIED_RECORDS=598490' "$recheck_transcript"
grep -Fqx 'VERIFIER_RECHECK_EXIT_CODE=0' "$recheck_transcript"
grep -Fqx 'EXIT_CODE=0' "$recheck_transcript"
grep -Fq 'END_UTC=' "$recheck_meta"
grep -Fqx "FORMULA_SHA256=$(hash_file "$formula")" "$recheck_meta"
grep -Fqx "GENERATOR_SHA256=$(hash_file "$generator")" "$recheck_meta"
grep -Fqx "VERIFIER_SHA256=$(hash_file "$verifier")" "$recheck_meta"
grep -Fqx "SOURCE_LEDGER_SHA256=$(hash_file "$source_ledger")" "$recheck_meta"
grep -Fqx "ORIGINAL_WRAPPER_SHA256=$(hash_file "$original_wrapper")" "$recheck_meta"
grep -Fqx "RECHECK_WRAPPER_SHA256=$(hash_file "$recheck_wrapper")" "$recheck_meta"
grep -Fqx "CERTIFICATE_SHA256=$(hash_file "$certificate")" "$recheck_meta"
gzip -t -- "$certificate"

grep -Fq 'P3_DEGREES [1, 11, 11]' \
  "$root/p23_chebyshev_global_dyadic_overapprox.transcript"
grep -Fqx 'P23_GLOBAL_DYADIC_OVERAPPROX_PASS' \
  "$root/p23_chebyshev_global_dyadic_overapprox.transcript"
grep -Fqx 'P23_SUNIT_BASIS_PASS' \
  "$root/p23_chebyshev_sunit_basis.transcript"
grep -Fqx 'P23_STOLL_W3_OVERAPPROX_PASS [5, 6, 7]' \
  "$root/p23_chebyshev_stoll_gamma2.transcript"
grep -Fqx 'P23_GAMMA2_COLEMAN_PASS' \
  "$root/p23_chebyshev_gamma2_coleman.transcript"
grep -Fq 'SageMath version 10.9' \
  "$root/p23_chebyshev_stoll_gamma2_versions.transcript"

files=(
  "$source_ledger"
  "$formula"
  "$generator"
  "$verifier"
  "$original_wrapper"
  "$certificate"
  "$run_transcript"
  "$run_meta"
  "$run_exit"
  "$recheck_wrapper"
  "$recheck_transcript"
  "$recheck_meta"
  "$recheck_exit"
  "$root/p23_chebyshev_global_dyadic_overapprox.sage"
  "$root/p23_chebyshev_global_dyadic_overapprox.transcript"
  "$root/p23_chebyshev_sunit_basis.gp"
  "$root/p23_chebyshev_sunit_basis.transcript"
  "$root/p23_chebyshev_stoll_gamma2.sage"
  "$root/p23_chebyshev_stoll_gamma2.transcript"
  "$root/p23_chebyshev_gamma2_coleman.sage"
  "$root/p23_chebyshev_gamma2_coleman.transcript"
  "$root/p23_chebyshev_stoll_gamma2_versions.transcript"
  "$report"
  "$main_report"
  "$lean_companion"
  "$0"
)

test "${#files[@]}" -eq 26
for required in "${files[@]}"; do
  test -f "$required"
done

sha256sum -- "${files[@]}" > "$manifest"
test "$(wc -l < "$manifest")" -eq 26
sha256sum -c -- "$manifest"
printf 'P23_CL2_MANIFEST_PASS\n'
