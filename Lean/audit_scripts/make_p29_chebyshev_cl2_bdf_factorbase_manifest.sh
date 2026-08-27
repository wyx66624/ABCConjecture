#!/usr/bin/env bash
set -euo pipefail

root="Lean/audit_scripts"
manifest="$root/p29_chebyshev_cl2_bdf_factorbase.sha256"
tmp="${manifest}.tmp.$$"

files=(
  "$root/p29_chebyshev_cl2_bdf_factorbase_plan.sage"
  "$root/p29_chebyshev_cl2_bdf_factorbase.source"
  "$root/run_p29_chebyshev_cl2_bdf_factorbase.sh"
  "$root/make_p29_chebyshev_cl2_bdf_factorbase_manifest.sh"
  "$root/p29_chebyshev_cl2_bdf_factorbase.transcript"
  "$root/p29_chebyshev_cl2_bdf_factorbase.meta"
  "$root/p29_chebyshev_cl2_bdf_factorbase.exit"
  "Lean/P29_CL2_BDF_FACTORBASE_ROUTE.md"
)

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

for file in "${files[@]}"; do
  test -f "$file"
  sha256sum -- "$file" >> "$tmp"
done

mv -f -- "$tmp" "$manifest"
sha256sum -c "$manifest"
