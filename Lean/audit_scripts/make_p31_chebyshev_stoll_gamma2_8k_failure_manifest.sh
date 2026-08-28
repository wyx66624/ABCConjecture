#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
must_have() { grep -Fqx "$2" "$1" || { echo "missing: $1: $2" >&2; exit 1; }; }

sha256sum -c p31_chebyshev_global_dyadic.sha256 >/dev/null
test "$(cat p31_chebyshev_stoll_gamma2.exit)" = 1
must_have p31_chebyshev_stoll_gamma2.transcript 'P31_GLOBAL_DYADIC_INJECTION_PASS'
grep -Fq 'P31_EXACT_CANTOR_SUM_PASS ROUNDS 8' p31_chebyshev_stoll_gamma2.transcript
must_have p31_chebyshev_stoll_gamma2.transcript 'P31_GAMMA2_LOCAL_INDEPENDENCE_PASS'
must_have p31_chebyshev_stoll_gamma2.transcript 'P31_W_SIGNATURE_MINOR [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18] DETERMINANT 1'
grep -Fq 'SHELL_SUMMARY M 3 UNIT_MODULUS 32 REPS 16 MAX_NU 5 MIN_ID_VAL 5795' p31_chebyshev_stoll_gamma2.transcript
grep -Fq 'SHELL_SUMMARY M 4 UNIT_MODULUS 32 REPS 16 MAX_NU 6 MIN_ID_VAL 3419' p31_chebyshev_stoll_gamma2.transcript
must_have p31_chebyshev_stoll_gamma2.transcript 'TAIL_TEST M 4 BOUND 5 MAX_NU 6 PASS False'
grep -Fq 'assert certificate_valuation > required_identity_valuation' p31_chebyshev_stoll_gamma2.transcript
! grep -Fq 'P31_STOLL_GAMMA2_OVERAPPROX_PASS' p31_chebyshev_stoll_gamma2.transcript
must_have p31_chebyshev_stoll_gamma2.transcript 'EXIT_CODE=1'
grep -Fqx 'PRECISION_BITS=8000' p31_chebyshev_stoll_gamma2.meta
grep -Fqx 'REQUIRED_IDENTITY_VALUATION=2000' p31_chebyshev_stoll_gamma2.meta
grep -Fqx "SOURCE_SHA256=$(sha256sum p31_chebyshev_stoll_gamma2.sage | cut -d' ' -f1)" p31_chebyshev_stoll_gamma2.meta

files=(p31_chebyshev_stoll_gamma2.sage run_p31_chebyshev_stoll_gamma2.sh
  p31_chebyshev_stoll_gamma2_scout_attempt1.ledger
  p31_chebyshev_stoll_gamma2_scout_attempt2.ledger
  p31_chebyshev_stoll_gamma2_scout_attempt3.ledger
  p31_chebyshev_stoll_gamma2.transcript p31_chebyshev_stoll_gamma2.meta
  p31_chebyshev_stoll_gamma2.exit p31_chebyshev_global_dyadic.sha256
  ../P31_CHEBYSHEV_STOLL_GAMMA2_8K_FAILURE.md
  make_p31_chebyshev_stoll_gamma2_8k_failure_manifest.sh)
sha256sum "${files[@]}" > p31_chebyshev_stoll_gamma2_8k_failure.sha256
test "$(wc -l < p31_chebyshev_stoll_gamma2_8k_failure.sha256)" -eq 11
echo P31_STOLL_GAMMA2_8K_FAILURE_MANIFEST_PASS
