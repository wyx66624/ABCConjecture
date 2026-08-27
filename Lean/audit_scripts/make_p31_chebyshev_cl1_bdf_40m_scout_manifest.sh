#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
stem="$root/p31_chebyshev_cl1_bdf_40m_scout"
script="$stem.sage"
source_ledger="$stem.source"
wrapper="$root/run_p31_chebyshev_cl1_bdf_40m_scout.sh"
transcript="$stem.transcript"
meta="$stem.meta"
exit_record="$stem.exit"
document="Lean/P31_CHEBYSHEV_BDF_40M_SCOUT.md"
maker="$root/make_p31_chebyshev_cl1_bdf_40m_scout_manifest.sh"
manifest="$stem.sha256"
tmp="${manifest}.tmp.$$"
image="sagemath/sagemath:10.9"

files=(
  "$source_ledger"
  "$script"
  "$wrapper"
  "$transcript"
  "$meta"
  "$exit_record"
  "$document"
  "$maker"
)

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

for file in "${files[@]}"; do
  test -f "$file"
done

# The process exit records successful execution only.  The mathematical result
# is the explicit negative interval and INCONCLUSIVE marker below.
test "$(tr -d '\r\n' < "$exit_record")" = "0"
grep -Fqx 'EXIT_CODE=0' "$transcript"
grep -Fqx 'P31_BDF_T40000000_REALBALL_INCONCLUSIVE' "$transcript"
if grep -Fqx 'P31_BDF_T40000000_REALBALL_PASS' "$transcript"; then
  exit 21
fi

awk '
  $1 == "margin_upper_endpoint" && $2 == "=" {
    found = 1
    if (!($3 < 0)) exit 1
  }
  END { if (!found) exit 1 }
' "$transcript"
grep -Fqx 'distinct_degree_one_prime_ideals = 2431851' "$transcript"
grep -Fqx 'degree_one_prime_ideal_power_terms = 2432851' "$transcript"
grep -Fqx 'strict_factor_base_counts_by_residue_degree = {1: 2431851, 2: 450, 3: 50}' "$transcript"
grep -Fqx 'directly_factored_higher_degree_rational_primes = 35' "$transcript"
grep -Fqx "rational_prime_split_categories = {'ramified': 2, 'one_root': 2352675, 'thirty_one_roots': 2554, 'no_root': 78423}" "$transcript"

actual_power_counts="$({
  awk '/^  m=[0-9]+ / {
    split($3, field, "=")
    if (count++) printf ","
    printf "%s", field[2]
  }' "$transcript"
  printf '\n'
})"
expected_power_counts='2431851,858,67,22,11,7,5,4,3,3,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1'
test "$actual_power_counts" = "$expected_power_counts"

test "$(sed -n 's/^SCRIPT_SHA256=//p' "$meta")" = "$(sha256sum -- "$script" | cut -d ' ' -f 1)"
test "$(sed -n 's/^SOURCE_LEDGER_SHA256=//p' "$meta")" = "$(sha256sum -- "$source_ledger" | cut -d ' ' -f 1)"
test "$(sed -n 's/^WRAPPER_SHA256=//p' "$meta")" = "$(sha256sum -- "$wrapper" | cut -d ' ' -f 1)"
grep -Fqx 'PRECISION_BITS=256' "$meta"
grep -Fqx 'BOUND_STRICT=40000000' "$meta"
grep -Fqx 'NO_PRINCIPAL_WITNESSES=1' "$meta"
grep -Fqx 'NO_CUTOFF_ABOVE_40000000=1' "$meta"

recorded_image_id="$(sed -n 's/^DOCKER_IMAGE_ID=//p' "$meta")"
current_image_id="$(docker image inspect "$image" --format '{{.Id}}')"
test "$recorded_image_id" = "$current_image_id"
recorded_repo_digests="$(sed -n 's/^DOCKER_REPO_DIGESTS=//p' "$meta")"
current_repo_digests="$(docker image inspect "$image" --format '{{json .RepoDigests}}')"
test "$recorded_repo_digests" = "$current_repo_digests"

for file in "${files[@]}"; do
  sha256sum -- "$file" >> "$tmp"
done
mv -f -- "$tmp" "$manifest"
sha256sum -c "$manifest"
printf '%s\n' 'P31_BDF_40M_NEGATIVE_SCOUT_MANIFEST_PASS'
