#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

must_have() { grep -Fqx "$2" "$1" || { echo "missing marker: $1: $2" >&2; exit 1; }; }

sha256sum -c p31_chebyshev_s_squareclass.sha256 >/dev/null
test "$(cat p31_chebyshev_s_squareclass.exit)" = 0
must_have p31_chebyshev_s_squareclass.transcript 'P31_S_SQUARECLASS_EXACT_VERIFY_PASS'

must_have p31_chebyshev_global_dyadic_scout_attempt1.ledger 'RESULT=FAILED_BEFORE_W_CONSTRUCTION'
must_have p31_chebyshev_global_dyadic_scout_attempt1.ledger 'CORRECTION=use_(-1)^15_times_U_endpoint_evaluation'
must_have p31_chebyshev_global_dyadic_scout_attempt1.ledger 'EXIT_CODE=1'

test "$(cat p31_chebyshev_global_dyadic.exit)" = 0
grep -Fq 'SIGNATURE (1, 15) UNIT_RANK 15' p31_chebyshev_global_dyadic.transcript
must_have p31_chebyshev_global_dyadic.transcript 'EXPECTED_S_SQUARECLASS_DIM 20'
grep -Fq 'ENDPOINT_COORD_D1 (0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)' p31_chebyshev_global_dyadic.transcript
grep -Fq 'ENDPOINT_COORD_D9 (1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)' p31_chebyshev_global_dyadic.transcript
must_have p31_chebyshev_global_dyadic.transcript 'NORM_RANK 4'
grep -Fq 'P3COUNT 2 P3_DEGREES [1, 30] LOCAL3_PAIR_RANK 4 L3_DIM 1' p31_chebyshev_global_dyadic.transcript
grep -Fq 'COMBINED_CONSTRAINT_RANK 5 W_DIM 15 W_COUNT 32768' p31_chebyshev_global_dyadic.transcript
must_have p31_chebyshev_global_dyadic.transcript 'DYADIC_TEST_CLASSES 33 GLOBAL_REP_DYADIC_RANK 19 W_DYADIC_RANK 15 KERNEL_DIM 0 GAMMA2_RANK 2'
must_have p31_chebyshev_global_dyadic.transcript 'P31_GLOBAL_DYADIC_INJECTION_PASS'
must_have p31_chebyshev_global_dyadic.transcript 'P31_GLOBAL_DYADIC_FROZEN_RUN_PASS'
must_have p31_chebyshev_global_dyadic.transcript 'EXIT_CODE=0'
grep -Fqx "SOURCE_SHA256=$(sha256sum p31_chebyshev_global_dyadic_verify.sage | cut -d' ' -f1)" p31_chebyshev_global_dyadic.meta
grep -Fqx "BASE_SOURCE_SHA256=$(sha256sum p31_chebyshev_s_squareclass_verify.sage | cut -d' ' -f1)" p31_chebyshev_global_dyadic.meta
grep -Fqx "BASE_MANIFEST_SHA256=$(sha256sum p31_chebyshev_s_squareclass.sha256 | cut -d' ' -f1)" p31_chebyshev_global_dyadic.meta
grep -Fqx "WRAPPER_SHA256=$(sha256sum run_p31_chebyshev_global_dyadic_verify.sh | cut -d' ' -f1)" p31_chebyshev_global_dyadic.meta
grep -Fqx 'DOCKER_IMAGE_ID=sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667' p31_chebyshev_global_dyadic.meta

files=(
  p31_chebyshev_global_dyadic_verify.sage
  run_p31_chebyshev_global_dyadic_verify.sh
  p31_chebyshev_global_dyadic_scout_attempt1.ledger
  p31_chebyshev_global_dyadic.transcript
  p31_chebyshev_global_dyadic.meta
  p31_chebyshev_global_dyadic.exit
  p31_chebyshev_s_squareclass.sha256
  ../P31_CHEBYSHEV_GLOBAL_DYADIC_CERTIFICATE.md
  make_p31_chebyshev_global_dyadic_manifest.sh
)
sha256sum "${files[@]}" > p31_chebyshev_global_dyadic.sha256
test "$(wc -l < p31_chebyshev_global_dyadic.sha256)" -eq 9
echo P31_GLOBAL_DYADIC_MANIFEST_PASS
