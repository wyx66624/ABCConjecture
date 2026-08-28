#!/usr/bin/env bash
set -euo pipefail

# Validate the complete local p=31 Coleman output and freeze its seven-byte-set
# ledger.  This is deliberately independent of every global/dyadic package.

root="Lean/audit_scripts"
manifest="$root/p31_chebyshev_gamma2_coleman_local.sha256"
tmp="${manifest}.tmp.$$"

source_file="$root/p31_chebyshev_gamma2_coleman_final.sage"
wrapper="$root/run_p31_chebyshev_gamma2_coleman_final.sh"
transcript="$root/p31_chebyshev_gamma2_coleman_final.transcript"
meta="$root/p31_chebyshev_gamma2_coleman_final.meta"
exit_record="$root/p31_chebyshev_gamma2_coleman_final.exit"
report="Lean/P31_CHEBYSHEV_COLEMAN_LOCAL_CERTIFICATE.md"

cleanup() {
  rm -f -- "$tmp"
}
trap cleanup EXIT

hash_file() {
  sha256sum -- "$1" | cut -d ' ' -f 1
}

for required in \
  "$source_file" "$wrapper" "$transcript" "$meta" "$exit_record" \
  "$report" "$0"; do
  test -f "$required"
done

# Provenance must bind exactly the immutable source and wrapper used by the
# completed read-only execution.
test "$(tr -d '\r\n' < "$exit_record")" = 0
grep -Fqx "SOURCE_SHA256=$(hash_file "$source_file")" "$meta"
grep -Fqx "WRAPPER_SHA256=$(hash_file "$wrapper")" "$meta"
grep -Fqx 'DOCKER_IMAGE=sagemath/sagemath:10.9' "$meta"
grep -Fqx \
  'DOCKER_IMAGE_ID=sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667' \
  "$meta"
grep -Fqx \
  'DOCKER_REPO_DIGESTS=["sagemath/sagemath@sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667"]' \
  "$meta"
grep -Fqx 'SAGE_VERSION=SageMath version 10.9, Release Date: 2026-05-04' \
  "$meta"
grep -Fqx 'REPOSITORY_MOUNT_MODE=read-only' "$meta"
grep -Fqx 'P_ADIC_PRIME=5' "$meta"
grep -Fqx 'Q5_PRECISION=120' "$meta"
grep -Fqx 'GENUS=15' "$meta"
grep -Fq 'START_UTC=' "$meta"
grep -Fq 'COLEMAN_START_UTC=' "$meta"
grep -Fq 'COLEMAN_END_UTC=' "$meta"
grep -Fq 'END_UTC=' "$meta"

# The frozen source itself must retain every mathematical assertion.  These
# checks make it harder for a superficially similar transcript to be rebound
# to a weakened executable.
grep -Fqx 'assert f.is_monic()' "$source_file"
grep -Fqx 'assert f.is_irreducible()' "$source_file"
grep -Fqx 'assert f.discriminant().valuation(p) == 0' "$source_file"
grep -Fqx 'assert len(pts) == 6' "$source_file"
grep -Fqx 'assert f5_roots == [(k(0), 1)]' "$source_file"
grep -Fqx 'precision = 120' "$source_file"
grep -Fqx 'assert contents == [1, 1]' "$source_file"
grep -Fqx 'assert M == expected_M' "$source_file"
grep -Fqx 'assert M.rank() == 2' "$source_file"
grep -Fqx 'cbar = vector(k, [1] + [0]*12 + [1, 1])' "$source_file"
grep -Fqx 'assert M*cbar == 0' "$source_file"
grep -Fqx 'assert type_evals == [k(1), k(3), k(1), k(1)]' "$source_file"
grep -Fqx 'pair = (0, 1)' "$source_file"
grep -Fqx 'assert k(unit_minor_det) == k(3)' "$source_file"
grep -Fq 'K(ZZ(cbar[j]))' "$source_file"
grep -Fqx 'assert min(dot_precisions) >= 110' "$source_file"
grep -Fqx 'assert len(roots) == 1' "$source_file"
grep -Fqx 'assert roots[0][1] == 1' "$source_file"
grep -Fqx 'assert k(roots[0][0]) == 0' "$source_file"

# Full exact output: special fibre, simple root, normalized matrix, rank,
# fixed kernel vector, all six evaluations, unit minor, numerical margin,
# Q_5 root, success markers, and clean exit.
grep -Fqx \
  'GOOD_REDUCTION_POINTS [(1 : 0 : 0), (0 : 0 : 1), (1 : 2 : 1), (1 : 3 : 1), (4 : 1 : 1), (4 : 4 : 1)]' \
  "$transcript"
grep -Fqx 'F5_WEIERSTRASS_ROOTS [(0, 1)]' "$transcript"
grep -Fqx 'LOG_CONTENTS [1, 1]' "$transcript"
test "$(grep -c '^NORMALIZED_LOG_REDUCTION$' "$transcript")" = 1
grep -Fqx '[3 1 2 2 3 4 1 4 1 4 1 4 3 3 4]' "$transcript"
grep -Fqx '[1 3 4 0 2 3 4 2 3 3 3 4 1 2 2]' "$transcript"
grep -Fqx 'NORMALIZED_LOG_RANK 2' "$transcript"
grep -Fqx \
  'ANNIHILATOR_REDUCTION (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1)' \
  "$transcript"
grep -Fqx \
  'ANNIHILATOR_TYPE_EVALS_X0_X1_XNEG1_INFINITY [1, 3, 1, 1]' \
  "$transcript"
grep -Fqx \
  "ANNIHILATOR_POINT_EVALS [('(1 : 0 : 0)', 1), ('(0 : 0 : 1)', 1), ('(1 : 2 : 1)', 3), ('(1 : 3 : 1)', 3), ('(4 : 1 : 1)', 1), ('(4 : 4 : 1)', 1)]" \
  "$transcript"
grep -Fqx 'UNIT_MINOR (0, 1) DET_REDUCTION 3' "$transcript"

# Bind the precise numerical stability output.  Exact annihilation comes from
# the unit-minor argument, not from interpreting these finite-precision zeros
# as symbolic equalities.
test "$(grep -c '^DOTS ' "$transcript")" = 1
grep -Fqx 'DOTS [O(5^116), O(5^116)] DOT_PRECISIONS [116, 116]' \
  "$transcript"

grep -Fqx 'Q5_ROOTS 1 ROOT_REDUCTIONS [0] MULTIPLICITIES [1]' \
  "$transcript"
grep -Fqx 'P31_GOOD_REDUCTION_F5_POINT_COUNT=6' "$transcript"
grep -Fqx 'P31_UNIQUE_SIMPLE_WEIERSTRASS_ROOT_X0' "$transcript"
grep -Fqx 'P31_ENDPOINT_LOG_CONTENTS_1_1' "$transcript"
grep -Fqx 'P31_NORMALIZED_LOG_RANK_2' "$transcript"
grep -Fqx 'P31_ANNIHILATOR_FIXED_VECTOR_PASS' "$transcript"
grep -Fqx 'P31_ANNIHILATOR_ALL_SIX_DISKS_UNIT' "$transcript"
grep -Fqx 'P31_UNIT_MINOR_COLUMNS_0_1_DET_3' "$transcript"
grep -Fqx 'P31_DOT_PRECISION_MARGIN_AT_LEAST_110' "$transcript"
grep -Fqx 'P31_Q5_UNIQUE_ROOT_REDUCTION_0' "$transcript"
grep -Fqx 'P31_GAMMA2_COLEMAN_LOCAL_FINAL_CERTIFICATE_PASS' "$transcript"
grep -Fqx 'COLEMAN_EXIT_CODE=0' "$transcript"
grep -Fqx 'P31_GAMMA2_COLEMAN_LOCAL_FINAL_FROZEN_RUN_PASS' "$transcript"
grep -Fqx 'EXIT_CODE=0' "$transcript"
! grep -Eq 'Traceback|AssertionError|(^|[^A-Z_])ERROR([^A-Z_]|$)' \
  "$transcript"

# Preserve the local-only mathematical boundary in the human-readable
# certificate.
grep -Fq 'This package does **not** certify Mordell--Weil generation' "$report"
grep -Fq 'ordinary integer' "$report"
grep -Fq 'exact-lift conclusion comes from the unit minor' "$report"
grep -Fq 'not, by themselves, symbolic equalities' "$report"
grep -Fq 'Here `p=5` and `2g=30`' "$report"
grep -Fq 'difference quotient is therefore a 5-adic unit' "$report"
grep -Fq 'does not prove `abc`' "$report"

files=(
  "$source_file"
  "$wrapper"
  "$transcript"
  "$meta"
  "$exit_record"
  "$report"
  "$0"
)

test "${#files[@]}" -eq 7
sha256sum -- "${files[@]}" > "$tmp"
test "$(wc -l < "$tmp")" -eq 7
mv -f -- "$tmp" "$manifest"
sha256sum -c -- "$manifest"
printf 'P31_GAMMA2_COLEMAN_LOCAL_MANIFEST_PASS\n'
