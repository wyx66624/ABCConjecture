#!/usr/bin/env bash
set -uo pipefail

transcript="Lean/audit_scripts/p29_chebyshev_class_quotient_cert_pari217_debug.transcript"
exit_record="Lean/audit_scripts/p29_chebyshev_class_quotient_cert_pari217_debug.exit"
meta_record="Lean/audit_scripts/p29_chebyshev_class_quotient_cert_pari217_debug.meta"

: > "$transcript"
: > "$exit_record"
{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'DOCKER_IMAGE=%s\n' 'sagemath/sagemath:10.9'
  docker image inspect sagemath/sagemath:10.9 --format 'DOCKER_IMAGE_ID={{.Id}}'
  printf 'INPUT_SHA256='
  sha256sum Lean/audit_scripts/p29_chebyshev_class_quotient_cert_pari217_debug.sage | awk '{print $1}'
} > "$meta_record" 2>&1

docker run --rm --entrypoint /bin/bash \
  -v '/mnt/e/AImath/abc猜想:/work:ro' \
  sagemath/sagemath:10.9 \
  -lc "cp /work/Lean/audit_scripts/p29_chebyshev_class_quotient_cert_pari217_debug.sage /tmp/p29_class_cert_debug.sage && sage /tmp/p29_class_cert_debug.sage" \
  >> "$transcript" 2>&1
rc=$?
printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
printf '%s\n' "$rc" > "$exit_record"
printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta_record"
exit "$rc"
