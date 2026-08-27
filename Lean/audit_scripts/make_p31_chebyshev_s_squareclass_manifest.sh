#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

must_have() { grep -Fqx "$2" "$1" || { echo "missing marker: $1: $2" >&2; exit 1; }; }

sha256sum -c p31_chebyshev_cl1_bdf_principal.sha256 >/dev/null
test "$(cat p31_chebyshev_cl1_bdf_principal_full.exit)" = 0
must_have p31_chebyshev_cl1_bdf_principal_full.transcript 'P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS'
must_have p31_chebyshev_cl1_bdf_principal_full.transcript 'P31_BDF_PRINCIPAL_PUBLISH_RECOVERY_PASS'

for n in 0 1 2; do test "$(cat p31_chebyshev_s_squareclass_wrapper_attempt${n}.exit)" != 0; done
grep -Fq 'cp: missing file operand' p31_chebyshev_s_squareclass_wrapper_attempt0.transcript
grep -Fq 'cannot execute binary file' p31_chebyshev_s_squareclass_wrapper_attempt1.transcript
grep -Fq "Permission denied" p31_chebyshev_s_squareclass_wrapper_attempt2.transcript

test "$(cat p31_chebyshev_s_squareclass.exit)" = 0
grep -Fq 'SIGNATURE (1, 15) UNIT_RANK 15' p31_chebyshev_s_squareclass.transcript
grep -Fq "S_SIZE 4 S_RESIDUE_DEGREES {2: [1], 3: [1, 30], 31: [1]}" p31_chebyshev_s_squareclass.transcript
must_have p31_chebyshev_s_squareclass.transcript 'EXPECTED_S_SQUARECLASS_DIM 20'
grep -Fq '[(1, -1, []), (2, 1, [])' p31_chebyshev_s_squareclass.transcript
grep -Fq '(17, 2, [2]), (18, -3, [3]), (19, -205891132094649, [3]), (20, 31, [31])' p31_chebyshev_s_squareclass.transcript
must_have p31_chebyshev_s_squareclass.transcript 'NORM_SIGNATURE_RANK 4 P3_SIGNATURE_RANK 4 DYADIC_SIGNATURE_RANK 19'
must_have p31_chebyshev_s_squareclass.transcript 'COMBINED_SQUARECLASS_DETECTION_RANK 20'
must_have p31_chebyshev_s_squareclass.transcript 'NO_BNF_OR_CLASS_GROUP_USED=1'
must_have p31_chebyshev_s_squareclass.transcript 'NO_UNIT_GROUP_OR_REGULATOR_USED=1'
must_have p31_chebyshev_s_squareclass.transcript 'P31_S_SQUARECLASS_EXACT_VERIFY_PASS'
must_have p31_chebyshev_s_squareclass.transcript 'EXIT_CODE=0'
grep -Fqx "SOURCE_SHA256=$(sha256sum p31_chebyshev_s_squareclass_verify.sage | cut -d' ' -f1)" p31_chebyshev_s_squareclass.meta
grep -Fqx "DISCOVERY_SOURCE_SHA256=$(sha256sum p31_chebyshev_s_squareclass_discover.gp | cut -d' ' -f1)" p31_chebyshev_s_squareclass.meta
grep -Fqx "WRAPPER_SHA256=$(sha256sum run_p31_chebyshev_s_squareclass_verify.sh | cut -d' ' -f1)" p31_chebyshev_s_squareclass.meta
grep -Fqx 'DOCKER_IMAGE_ID=sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667' p31_chebyshev_s_squareclass.meta

files=(
  p31_chebyshev_s_squareclass_discover.gp
  p31_chebyshev_s_squareclass_verify.sage
  run_p31_chebyshev_s_squareclass_verify.sh
  p31_chebyshev_s_squareclass_wrapper_attempt0.transcript
  p31_chebyshev_s_squareclass_wrapper_attempt0.meta
  p31_chebyshev_s_squareclass_wrapper_attempt0.exit
  p31_chebyshev_s_squareclass_wrapper_attempt1.transcript
  p31_chebyshev_s_squareclass_wrapper_attempt1.meta
  p31_chebyshev_s_squareclass_wrapper_attempt1.exit
  p31_chebyshev_s_squareclass_wrapper_attempt2.transcript
  p31_chebyshev_s_squareclass_wrapper_attempt2.meta
  p31_chebyshev_s_squareclass_wrapper_attempt2.exit
  p31_chebyshev_s_squareclass.transcript
  p31_chebyshev_s_squareclass.meta
  p31_chebyshev_s_squareclass.exit
  ../P31_CHEBYSHEV_S_SQUARECLASS_CERTIFICATE.md
  p31_chebyshev_cl1_bdf_principal.sha256
  ../P31_CL1_BDF_FACTORBASE_ROUTE.md
  make_p31_chebyshev_s_squareclass_manifest.sh
)
sha256sum "${files[@]}" > p31_chebyshev_s_squareclass.sha256
test "$(wc -l < p31_chebyshev_s_squareclass.sha256)" -eq 19
echo P31_S_SQUARECLASS_MANIFEST_PASS
