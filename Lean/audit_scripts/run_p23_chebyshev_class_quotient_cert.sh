#!/usr/bin/env bash
set -uo pipefail

transcript="Lean/audit_scripts/p23_chebyshev_class_quotient_cert.transcript"
exit_record="Lean/audit_scripts/p23_chebyshev_class_quotient_cert.exit"
meta_record="Lean/audit_scripts/p23_chebyshev_class_quotient_cert.meta"

: > "$transcript"
: > "$exit_record"
{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'PARI_VERSION='
  gp -qf <<'GP_VERSION'
print(default(parisize));
print(version());
quit;
GP_VERSION
} > "$meta_record" 2>&1

gp -qf Lean/audit_scripts/p23_chebyshev_class_quotient_cert.gp \
  >> "$transcript" 2>&1
rc=$?
printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
printf '%s\n' "$rc" > "$exit_record"
printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta_record"
exit "$rc"
