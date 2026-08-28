#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
sha256sum -c p31_chebyshev_stoll_gamma2_8k_failure.sha256 >/dev/null
test "$(sha256sum p31_chebyshev_stoll_gamma2_8k_failure.sha256|cut -d' ' -f1)" = fa7201adf18c6106fd0255dd4c32ec5c6b2916e310f9db904307fe7afc985cec
for p in 10000 12000; do
 test "$(cat p31_chebyshev_stoll_m5_node_diagnostic_${p}.exit)" = 0
 grep -Fqx 'P31_M5_SINGLE_NODE_DIAGNOSTIC_PASS' p31_chebyshev_stoll_m5_node_diagnostic_${p}.transcript
 grep -Fqx 'EXIT_CODE=0' p31_chebyshev_stoll_m5_node_diagnostic_${p}.transcript
done
grep -Fq 'P31_M5_HALF_LAYER 4 D 15 C1 3246 C2 +Infinity C3 2315 MIN 2315' p31_chebyshev_stoll_m5_node_diagnostic_10000.transcript
grep -Fq 'P31_M5_UNIT1_RESULT (7, 2315, 0) HALF_LAYERS 7' p31_chebyshev_stoll_m5_node_diagnostic_10000.transcript
grep -Fq 'P31_M5_HALF_LAYER 4 D 15 C1 5246 C2 +Infinity C3 4315 MIN 4315' p31_chebyshev_stoll_m5_node_diagnostic_12000.transcript
grep -Fq 'P31_M5_UNIT1_RESULT (7, 4315, 0) HALF_LAYERS 7' p31_chebyshev_stoll_m5_node_diagnostic_12000.transcript
files=(p31_chebyshev_stoll_m5_node_diagnostic.sage run_p31_chebyshev_stoll_m5_node_diagnostic.sh
 p31_chebyshev_stoll_m5_node_diagnostic_10000.transcript p31_chebyshev_stoll_m5_node_diagnostic_10000.meta p31_chebyshev_stoll_m5_node_diagnostic_10000.exit
 p31_chebyshev_stoll_m5_node_diagnostic_12000.transcript p31_chebyshev_stoll_m5_node_diagnostic_12000.meta p31_chebyshev_stoll_m5_node_diagnostic_12000.exit
 p31_chebyshev_stoll_gamma2_8k_failure.sha256 ../P31_STOLL_M5_PRECISION_DIAGNOSTIC.md make_p31_chebyshev_stoll_m5_diagnostic_manifest.sh)
sha256sum "${files[@]}" > p31_chebyshev_stoll_m5_diagnostic.sha256
test "$(wc -l < p31_chebyshev_stoll_m5_diagnostic.sha256)" -eq 11
echo P31_STOLL_M5_DIAGNOSTIC_MANIFEST_PASS
