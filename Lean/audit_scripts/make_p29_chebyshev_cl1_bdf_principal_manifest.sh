#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
manifest="$root/p29_chebyshev_cl1_bdf_principal.sha256"
tmp="${manifest}.tmp.$$"
formula="$root/p29_chebyshev_cl2_bdf_factorbase_plan.sage"
source_ledger="$root/p29_chebyshev_cl2_bdf_factorbase.source"
factorbase_wrapper="$root/run_p29_chebyshev_cl2_bdf_factorbase.sh"
factorbase_transcript="$root/p29_chebyshev_cl2_bdf_factorbase.transcript"
factorbase_meta="$root/p29_chebyshev_cl2_bdf_factorbase.meta"
factorbase_exit="$root/p29_chebyshev_cl2_bdf_factorbase.exit"
producer="$root/p29_chebyshev_cl1_bdf_principal_generators.gp"
verifier="$root/p29_chebyshev_cl1_bdf_principal_verify.sage"
full_wrapper="$root/run_p29_chebyshev_cl1_bdf_principal_full.sh"
full_transcript="$root/p29_chebyshev_cl1_bdf_principal_full.transcript"
full_meta="$root/p29_chebyshev_cl1_bdf_principal_full.meta"
full_exit="$root/p29_chebyshev_cl1_bdf_principal_full.exit"
generation_attempt_transcript="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1.transcript"
generation_attempt_meta="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1.meta"
generation_attempt_exit="$root/p29_chebyshev_cl1_bdf_principal_generation_attempt1.exit"
recheck_wrapper="$root/run_p29_chebyshev_cl1_bdf_principal_frozen_recheck.sh"
recheck_transcript="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.transcript"
recheck_meta="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.meta"
recheck_exit="$root/p29_chebyshev_cl1_bdf_principal_frozen_recheck.exit"
cert_dir="$root/p29_chebyshev_cl1_bdf_principal_shards_v1"
shard_manifest="$cert_dir/SHARDS.sha256"
report="Lean/P29_CL2_BDF_FACTORBASE_ROUTE.md"
lean_core="Lean/IUTThreeClosures/P29BDFFactorbaseCore.lean"

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

test "$(tr -d '\r\n' < "$factorbase_exit")" = 0
test "$(tr -d '\r\n' < "$full_exit")" = 0
test "$(tr -d '\r\n' < "$recheck_exit")" = 0

grep -Fqx 'P29_BDF_FACTORBASE_REALBALL_PASS' "$factorbase_transcript"
grep -Fqx 'distinct_degree_one_prime_ideals = 2434529' "$factorbase_transcript"
grep -Fqx 'EXIT_CODE=0' "$factorbase_transcript"
grep -Fq 'END_UTC=' "$factorbase_meta"
grep -Fqx "SCRIPT_SHA256=$(hash_file "$formula")" "$factorbase_meta"
grep -Fqx "SOURCE_LEDGER_SHA256=$(hash_file "$source_ledger")" "$factorbase_meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$factorbase_wrapper")" "$factorbase_meta"

grep -Fqx 'GENERATED_FACTOR_BASE_IDEALS=2434953' "$full_transcript"
grep -Fqx 'VERIFIED_SHARDS=16' "$full_transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=2434953' "$full_transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=424' "$full_transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 2434529, 2: 406, 4: 14, 7: 4}' "$full_transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$full_transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$full_transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_FULL_CERTIFICATE_PASS' "$full_transcript"
grep -Fqx 'EXIT_CODE=0' "$full_transcript"
grep -Fq 'END_UTC=' "$full_meta"
grep -Fqx "PRODUCER_SHA256=$(hash_file "$producer")" "$full_meta"
grep -Fqx "VERIFIER_SHA256=$(hash_file "$verifier")" "$full_meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$full_wrapper")" "$full_meta"
grep -Fqx 'GENERATION_MODE=RESUME_PRESERVED_SHARDS' "$full_meta"
grep -Fqx "GENERATION_ATTEMPT_TRANSCRIPT_SHA256=$(hash_file "$generation_attempt_transcript")" "$full_meta"
grep -Fqx "GENERATION_ATTEMPT_META_SHA256=$(hash_file "$generation_attempt_meta")" "$full_meta"
grep -Fqx "GENERATION_ATTEMPT_EXIT_SHA256=$(hash_file "$generation_attempt_exit")" "$full_meta"

test "$(tr -d '\r\n' < "$generation_attempt_exit")" = 1
grep -Fqx 'GENERATED_FACTOR_BASE_IDEALS=2434953' "$generation_attempt_transcript"
grep -Fq "PermissionError: [Errno 13] Permission denied: '/cert/p29_bdf_principal_00.tsv.gz'" \
  "$generation_attempt_transcript"
grep -Fqx 'EXIT_CODE=1' "$generation_attempt_transcript"
grep -Fq 'END_UTC=' "$generation_attempt_meta"

grep -Fqx 'P29_BDF_PRINCIPAL_SHARD_MANIFEST_PASS' "$recheck_transcript"
grep -Fqx 'BDF_FORMULA_RECHECK_EXIT_CODE=0' "$recheck_transcript"
grep -Fqx 'P29_BDF_FACTORBASE_REALBALL_PASS' "$recheck_transcript"
grep -Fqx 'VERIFIER_RECHECK_EXIT_CODE=0' "$recheck_transcript"
grep -Fqx 'VERIFIED_SHARDS=16' "$recheck_transcript"
grep -Fqx 'VERIFIED_FACTOR_BASE_IDEALS=2434953' "$recheck_transcript"
grep -Fqx 'VERIFIED_HIGHER_DEGREE_IDEALS=424' "$recheck_transcript"
grep -Fqx 'VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 2434529, 2: 406, 4: 14, 7: 4}' "$recheck_transcript"
grep -Fqx 'NO_BNF_OR_CLASS_GROUP_USED=1' "$recheck_transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_EXACT_VERIFY_PASS' "$recheck_transcript"
grep -Fqx 'P29_BDF_PRINCIPAL_FROZEN_RECHECK_PASS' "$recheck_transcript"
grep -Fqx 'EXIT_CODE=0' "$recheck_transcript"
grep -Fq 'END_UTC=' "$recheck_meta"

grep -Fqx "FORMULA_SHA256=$(hash_file "$formula")" "$recheck_meta"
grep -Fqx "SOURCE_LEDGER_SHA256=$(hash_file "$source_ledger")" "$recheck_meta"
grep -Fqx "FACTORBASE_WRAPPER_SHA256=$(hash_file "$factorbase_wrapper")" "$recheck_meta"
grep -Fqx "FACTORBASE_TRANSCRIPT_SHA256=$(hash_file "$factorbase_transcript")" "$recheck_meta"
grep -Fqx "FACTORBASE_META_SHA256=$(hash_file "$factorbase_meta")" "$recheck_meta"
grep -Fqx "FACTORBASE_EXIT_SHA256=$(hash_file "$factorbase_exit")" "$recheck_meta"
grep -Fqx "PRODUCER_SHA256=$(hash_file "$producer")" "$recheck_meta"
grep -Fqx "VERIFIER_SHA256=$(hash_file "$verifier")" "$recheck_meta"
grep -Fqx "FULL_WRAPPER_SHA256=$(hash_file "$full_wrapper")" "$recheck_meta"
grep -Fqx "FULL_TRANSCRIPT_SHA256=$(hash_file "$full_transcript")" "$recheck_meta"
grep -Fqx "FULL_META_SHA256=$(hash_file "$full_meta")" "$recheck_meta"
grep -Fqx "FULL_EXIT_SHA256=$(hash_file "$full_exit")" "$recheck_meta"
grep -Fqx "GENERATION_ATTEMPT_TRANSCRIPT_SHA256=$(hash_file "$generation_attempt_transcript")" "$recheck_meta"
grep -Fqx "GENERATION_ATTEMPT_META_SHA256=$(hash_file "$generation_attempt_meta")" "$recheck_meta"
grep -Fqx "GENERATION_ATTEMPT_EXIT_SHA256=$(hash_file "$generation_attempt_exit")" "$recheck_meta"
grep -Fqx "RECHECK_WRAPPER_SHA256=$(hash_file "$recheck_wrapper")" "$recheck_meta"
grep -Fqx "SHARD_MANIFEST_SHA256=$(hash_file "$shard_manifest")" "$recheck_meta"

certificates=()
for index in $(seq 0 15); do
  stem="$(printf 'p29_bdf_principal_%02d' "$index")"
  certificate="$cert_dir/${stem}.tsv.gz"
  test -f "$certificate"
  certificates+=("$certificate")
  gzip -t -- "$certificate"
  awk -v name="${stem}.tsv.gz" \
    '$2 == name { count += 1 } END { exit(count == 1 ? 0 : 1) }' \
    "$shard_manifest"
  grep -Fqx "CERTIFICATE_SHARD_$(printf '%02d' "$index")_SHA256=$(hash_file "$certificate")" \
    "$recheck_meta"
  grep -Fqx "CERTIFICATE_SHARD_$(printf '%02d' "$index")_BYTES=$(stat -c %s "$certificate")" \
    "$recheck_meta"
done
test "$(awk 'NF { count += 1 } END { print count + 0 }' "$shard_manifest")" = 16
(
  cd "$cert_dir"
  sha256sum -c -- "$(basename "$shard_manifest")"
)

files=(
  "$formula"
  "$source_ledger"
  "$factorbase_wrapper"
  "$factorbase_transcript"
  "$factorbase_meta"
  "$factorbase_exit"
  "$producer"
  "$verifier"
  "$full_wrapper"
  "$full_transcript"
  "$full_meta"
  "$full_exit"
  "$generation_attempt_transcript"
  "$generation_attempt_meta"
  "$generation_attempt_exit"
  "$recheck_wrapper"
  "$recheck_transcript"
  "$recheck_meta"
  "$recheck_exit"
  "$shard_manifest"
  "${certificates[@]}"
  "$report"
  "$lean_core"
  "$0"
)

test "${#files[@]}" -eq 39
for required in "${files[@]}"; do
  test -f "$required"
done

sha256sum -- "${files[@]}" > "$tmp"
test "$(wc -l < "$tmp")" -eq 39
mv -f -- "$tmp" "$manifest"
sha256sum -c -- "$manifest"
printf 'P29_BDF_PRINCIPAL_MANIFEST_PASS\n'
