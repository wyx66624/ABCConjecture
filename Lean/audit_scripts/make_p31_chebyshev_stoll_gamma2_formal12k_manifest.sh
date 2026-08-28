#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
must_have(){ grep -Fqx "$2" "$1" || { echo "missing $1: $2" >&2; exit 1; }; }
sha256sum -c p31_chebyshev_global_dyadic.sha256 >/dev/null
sha256sum -c p31_chebyshev_stoll_gamma2_8k_failure.sha256 >/dev/null
sha256sum -c p31_chebyshev_stoll_m5_diagnostic.sha256 >/dev/null
test "$(cat p31_chebyshev_stoll_gamma2_formal12k.exit)" = 0
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'P31_GLOBAL_DYADIC_INJECTION_PASS'
grep -Fq 'P31_EXACT_CANTOR_SUM_PASS ROUNDS 8' p31_chebyshev_stoll_gamma2_formal12k.transcript
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'P31_GAMMA2_LOCAL_INDEPENDENCE_PASS'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'P31_W_SIGNATURE_MINOR [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18] DETERMINANT 1'
test "$(grep -c '^P31_INITIAL_DIVISOR_RESIDUAL_VALUATION ' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 48
test "$(grep -c '^P31_INITIAL_DIVISOR_RESIDUAL_VALUATION 12015$' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
test "$(grep -c '^P31_INITIAL_DIVISOR_RESIDUAL_VALUATION 12018$' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
test "$(grep -c '^P31_INITIAL_DIVISOR_RESIDUAL_VALUATION 12021$' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
awk '$1=="P31_INITIAL_DIVISOR_RESIDUAL_VALUATION" && $2<=2000 {bad=1} END{exit bad}' p31_chebyshev_stoll_gamma2_formal12k.transcript
awk '$1=="P31_INITIAL_DIVISOR_RESIDUAL_VALUATION" {pending=$2; next}
     $1=="NODE" {
       expected=($3==3?12021:($3==4?12018:($3==5?12015:-1)))
       if(pending!=expected) bad=1
       pending=""
     }
     END {if(pending!="") bad=1; exit bad}' p31_chebyshev_stoll_gamma2_formal12k.transcript
test "$(grep -c '^NODE ' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 48
test "$(grep -c 'TERMINAL_IN_W False' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 48
test "$(grep -c 'DIRECT_SQUARE_MEMBERSHIP False' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 2
! grep -Fq 'TERMINAL_IN_W True' p31_chebyshev_stoll_gamma2_formal12k.transcript
! grep -Fq 'DIRECT_SQUARE_MEMBERSHIP True' p31_chebyshev_stoll_gamma2_formal12k.transcript
expected_units='1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31'
for m in 3 4 5; do
 test "$(awk -v m=$m '$1=="NODE"&&$3==m{n++}END{print n+0}' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
 test "$(awk -v m=$m '$1=="NODE"&&$3==m{print $5}' p31_chebyshev_stoll_gamma2_formal12k.transcript|paste -sd ' ' -)" = "$expected_units"
done
awk '$1=="NODE" {key=$3 SUBSEP $5; if(seen[key]++) bad=1}
     END {
       for(m=3;m<=5;m++) for(u=1;u<=31;u+=2)
         if(seen[m SUBSEP u]!=1) bad=1
       exit bad
     }' p31_chebyshev_stoll_gamma2_formal12k.transcript
awk '$1=="NODE" {expected=-4+4*(2^$3)*$5; if($7!=expected||$15<=2000)bad=1} END{exit bad}' p31_chebyshev_stoll_gamma2_formal12k.transcript
test "$(awk '$1=="NODE"&&$3==3&&$9==5{n++}END{print n+0}' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
test "$(awk '$1=="NODE"&&$3==4&&$9==6{n++}END{print n+0}' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
test "$(awk '$1=="NODE"&&$3==5&&$9==7{n++}END{print n+0}' p31_chebyshev_stoll_gamma2_formal12k.transcript)" = 16
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'SHELL_SUMMARY M 3 UNIT_MODULUS 32 REPS 16 MAX_NU 5 MIN_ID_VAL 9795'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'SHELL_SUMMARY M 4 UNIT_MODULUS 32 REPS 16 MAX_NU 6 MIN_ID_VAL 7419'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'SHELL_SUMMARY M 5 UNIT_MODULUS 32 REPS 16 MAX_NU 7 MIN_ID_VAL 4017'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'TAIL_LEMMA_3_10 M 5 BOUND 7 MAX_NU 7 PASS True'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'SHELL_REFINEMENT M 3 UNIT_BITS 5 REPS 16 MAX_NU 5 COVER_BOUND 8 COVER_REQUIRED 8 COVER_PASS True'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'SHELL_REFINEMENT M 4 UNIT_BITS 5 REPS 16 MAX_NU 6 COVER_BOUND 9 COVER_REQUIRED 9 COVER_PASS True'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'SHELL_REFINEMENT M 5 UNIT_BITS 5 REPS 16 MAX_NU 7 COVER_BOUND 10 COVER_REQUIRED 10 COVER_PASS True'
! grep -Eq 'Traceback|AssertionError|RuntimeError' p31_chebyshev_stoll_gamma2_formal12k.transcript
! grep -Eiq '(^|[^A-Za-z])(ERROR|Error)([^A-Za-z]|$)' p31_chebyshev_stoll_gamma2_formal12k.transcript
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'TERMINAL_SQUARECLASS_COUNT 2'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'P31_STOLL_GAMMA2_OVERAPPROX_PASS'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'P31_STOLL_GAMMA2_FORMAL12K_FROZEN_RUN_PASS'
must_have p31_chebyshev_stoll_gamma2_formal12k.transcript 'EXIT_CODE=0'
grep -Fqx "SOURCE_SHA256=$(sha256sum p31_chebyshev_stoll_gamma2_formal12k.sage|cut -d' ' -f1)" p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx "GLOBAL_SOURCE_SHA256=$(sha256sum p31_chebyshev_global_dyadic_verify.sage|cut -d' ' -f1)" p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx "FAILURE8K_MANIFEST_SHA256=$(sha256sum p31_chebyshev_stoll_gamma2_8k_failure.sha256|cut -d' ' -f1)" p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx "DIAGNOSTIC_MANIFEST_SHA256=$(sha256sum p31_chebyshev_stoll_m5_diagnostic.sha256|cut -d' ' -f1)" p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx "WRAPPER_SHA256=$(sha256sum run_p31_chebyshev_stoll_gamma2_formal12k.sh|cut -d' ' -f1)" p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx 'PRECISION_BITS=12000' p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx 'STRICT_THRESHOLD=2000' p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx 'DOCKER_IMAGE_ID=sha256:e068670ae5863b54b2550e72437ec637b0283acb0dc712c8584c124dbf44e667' p31_chebyshev_stoll_gamma2_formal12k.meta
grep -Fqx 'SAGE_VERSION=SageMath version 10.9, Release Date: 2026-05-04' p31_chebyshev_stoll_gamma2_formal12k.meta
start=$(sed -n 's/^START_UTC=//p' p31_chebyshev_stoll_gamma2_formal12k.meta)
end=$(sed -n 's/^END_UTC=//p' p31_chebyshev_stoll_gamma2_formal12k.meta)
[[ $start =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$ ]]
[[ $end =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$ ]]
[[ $start < $end ]]
files=(p31_chebyshev_stoll_gamma2_formal12k.sage run_p31_chebyshev_stoll_gamma2_formal12k.sh
 p31_chebyshev_stoll_gamma2_formal12k.transcript p31_chebyshev_stoll_gamma2_formal12k.meta p31_chebyshev_stoll_gamma2_formal12k.exit
 p31_chebyshev_global_dyadic.sha256 p31_chebyshev_stoll_gamma2_8k_failure.sha256 p31_chebyshev_stoll_m5_diagnostic.sha256
 ../P31_CHEBYSHEV_STOLL_GAMMA2_FORMAL12K.md
 make_p31_chebyshev_stoll_gamma2_formal12k_manifest.sh)
sha256sum "${files[@]}" > p31_chebyshev_stoll_gamma2_formal12k.sha256
test "$(wc -l < p31_chebyshev_stoll_gamma2_formal12k.sha256)" = 10
echo P31_STOLL_GAMMA2_FORMAL12K_MANIFEST_PASS
