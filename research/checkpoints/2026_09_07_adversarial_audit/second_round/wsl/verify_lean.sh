#!/usr/bin/env bash
set -euo pipefail
round_dir=$(cd "$(dirname "$0")/.." && pwd)
repo_dir=$(cd "$round_dir/../../../.." && pwd)
lean_bin=${LEAN_BIN:-$(command -v lean || true)}
if [[ -z "$lean_bin" && -x "$HOME/.elan/bin/lean" ]]; then
  lean_bin="$HOME/.elan/bin/lean"
fi
if [[ -z "$lean_bin" ]]; then
  printf '%s\n' 'Set LEAN_BIN to the existing compiler.' >&2
  exit 1
fi
mkdir -p "$round_dir/verification" "$repo_dir/tmp/abc_20260907/second_round_olean"
cd "$repo_dir"
"$lean_bin" --version | tee "$round_dir/verification/lean_version.txt"
"$lean_bin" -DwarningAsError=true \
  -o "$repo_dir/tmp/abc_20260907/second_round_olean/ShiftedResidueCounts.olean" \
  research/checkpoints/2026_09_07_adversarial_audit/second_round/Lean/ShiftedResidueCounts.lean \
  | tee "$round_dir/verification/lean_build.log"
