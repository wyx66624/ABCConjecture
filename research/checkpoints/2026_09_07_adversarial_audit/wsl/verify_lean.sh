#!/usr/bin/env bash
set -euo pipefail
checkpoint_dir=$(cd "$(dirname "$0")/.." && pwd)
repo_dir=$(cd "$checkpoint_dir/../../.." && pwd)
build_dir="$repo_dir/tmp/abc_20260907/olean"
lean_bin=${LEAN_BIN:-$(command -v lean || true)}
if [[ -z "$lean_bin" && -x "$HOME/.elan/bin/lean" ]]; then
  lean_bin="$HOME/.elan/bin/lean"
fi
if [[ -z "$lean_bin" ]]; then
  printf '%s\n' 'Lean is not available; set LEAN_BIN to the existing compiler.' >&2
  exit 1
fi
mkdir -p "$build_dir" "$checkpoint_dir/verification"
cd "$repo_dir"
"$lean_bin" --version | tee "$checkpoint_dir/verification/lean_version.txt"
"$lean_bin" -DwarningAsError=true -o "$build_dir/PowerDescent.olean" \
  research/checkpoints/2026_09_05_power_descent/Lean/PowerDescent.lean \
  | tee "$checkpoint_dir/verification/power_descent_build.log"
LEAN_PATH="$build_dir${LEAN_PATH:+:$LEAN_PATH}" \
  "$lean_bin" -DwarningAsError=true -o "$build_dir/CubicAmplification.olean" \
  research/checkpoints/2026_09_07_adversarial_audit/Lean/CubicAmplification.lean \
  | tee "$checkpoint_dir/verification/cubic_amplification_build.log"
