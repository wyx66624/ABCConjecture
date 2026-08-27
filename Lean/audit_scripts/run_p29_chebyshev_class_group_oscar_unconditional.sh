#!/usr/bin/env bash
set -uo pipefail

transcript="Lean/audit_scripts/p29_chebyshev_class_group_oscar_unconditional.transcript"
exit_record="Lean/audit_scripts/p29_chebyshev_class_group_oscar_unconditional.exit"
meta_record="Lean/audit_scripts/p29_chebyshev_class_group_oscar_unconditional.meta"

: > "$transcript"
: > "$exit_record"
{
  printf 'START_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'HOST=%s\n' "$(hostname)"
  printf 'WRAPPER_PID=%s\n' "$$"
  printf 'DOCKER_IMAGE=%s\n' 'julia:1.11-bookworm'
  docker image inspect julia:1.11-bookworm --format 'DOCKER_IMAGE_ID={{.Id}}'
  docker image inspect julia:1.11-bookworm --format 'DOCKER_REPO_DIGESTS={{json .RepoDigests}}'
  printf 'JULIA_DEPOT_VOLUME=%s\n' 'p29_oscar_julia'
  printf 'INPUT_SHA256='
  sha256sum Lean/audit_scripts/p29_chebyshev_class_group_oscar_unconditional.jl | awk '{print $1}'
} > "$meta_record" 2>&1

docker run --rm --entrypoint /bin/bash \
  -v 'p29_oscar_julia:/root/.julia' \
  -v '/mnt/e/AImath/abc猜想:/work:ro' \
  julia:1.11-bookworm \
  -lc "cp /work/Lean/audit_scripts/p29_chebyshev_class_group_oscar_unconditional.jl /tmp/p29_class_group.jl && /usr/local/julia/bin/julia /tmp/p29_class_group.jl" \
  >> "$transcript" 2>&1
rc=$?
printf 'EXIT_CODE=%s\n' "$rc" >> "$transcript"
printf '%s\n' "$rc" > "$exit_record"
printf 'END_UTC=%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$meta_record"
exit "$rc"
