#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
manifest="$root/p29_class_group_barrier.sha256"

pari_input="$root/p29_chebyshev_class_quotient_cert_pari217_debug.sage"
pari_wrapper="$root/run_p29_chebyshev_class_quotient_cert_pari217_debug.sh"
pari_meta="$root/p29_chebyshev_class_quotient_cert_pari217_debug.meta"
pari_transcript="$root/p29_chebyshev_class_quotient_cert_pari217_debug.transcript"
pari_exit="$root/p29_chebyshev_class_quotient_cert_pari217_debug.exit"

oscar_input="$root/p29_chebyshev_class_group_oscar_unconditional.jl"
oscar_wrapper="$root/run_p29_chebyshev_class_group_oscar_unconditional.sh"
oscar_meta="$root/p29_chebyshev_class_group_oscar_unconditional.meta"
oscar_transcript="$root/p29_chebyshev_class_group_oscar_unconditional.transcript"
oscar_exit="$root/p29_chebyshev_class_group_oscar_unconditional.exit"

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

grep -Fqx "INPUT_SHA256=$(hash_file "$pari_input")" "$pari_meta"
grep -Fqx 'MANUAL_INTERRUPT_UNIFIED_EXEC_EXIT=1' "$pari_exit"
grep -Fqx 'PARI_VERSION=(2, 17, 1)' "$pari_transcript"
grep -Fqx '  Testing primes <= 2660292872242387' "$pari_transcript"
grep -Fqx 'passing p = 572827 / 2660292872242387' "$pari_transcript"
grep -Fqx 'CERTIFICATE_COMPLETED=false' "$pari_transcript"
if grep -Fq 'CLASS_QUOTIENT_CERT=1' "$pari_transcript"; then
  printf 'unexpected PARI success marker\n' >&2
  exit 1
fi

grep -Fqx "INPUT_SHA256=$(hash_file "$oscar_input")" "$oscar_meta"
grep -Fqx 'MANUAL_INTERRUPT_UNIFIED_EXEC_EXIT=1' "$oscar_exit"
grep -Fqx 'ORPHAN_CONTAINER_STOP_EXIT=0' "$oscar_exit"
grep -Fqx 'OSCAR_PKG_VERSION=1.8.1' "$oscar_transcript"
grep -Fqx 'HECKE_PKG_VERSION=0.39.22' "$oscar_transcript"
grep -Fqx 'CLASS_GROUP_CALL=class_group(O; GRH=false, redo=true)' "$oscar_transcript"
grep -Fqx 'Testing all primes up to 2660292872242388' "$oscar_transcript"
grep -Fqx 'CERTIFICATE_COMPLETED=false' "$oscar_transcript"
if grep -Fq 'UNCONDITIONAL_CLASS_GROUP_CERTIFIED=true' "$oscar_transcript"; then
  printf 'unexpected Oscar success marker\n' >&2
  exit 1
fi

bash -n "$pari_wrapper"
bash -n "$oscar_wrapper"

files=(
  "$pari_input"
  "$pari_wrapper"
  "$pari_meta"
  "$pari_transcript"
  "$pari_exit"
  "$oscar_input"
  "$oscar_wrapper"
  "$oscar_meta"
  "$oscar_transcript"
  "$oscar_exit"
  "Lean/P29_CLASS_GROUP_CERTIFICATION_BARRIER.md"
  "Lean/P29_CL2_GALOIS_MODULE_AMPLIFICATION_AUDIT.md"
  "Lean/P29_CL2_NORM_RELATION_AUDIT.md"
  "Lean/P29_CHEBYSHEV_FIXED_INDEX_SCOUT.md"
  "Lean/IUTThreeClosures/P29FiniteCore.lean"
  "Lean/RESEARCH_STATUS.md"
  "$0"
)

test "${#files[@]}" -eq 17
for required in "${files[@]}"; do
  test -f "$required"
done

sha256sum -- "${files[@]}" > "$manifest"
test "$(wc -l < "$manifest")" -eq 17
sha256sum -c -- "$manifest"
printf 'P29_CLASS_GROUP_BARRIER_MANIFEST_PASS\n'
