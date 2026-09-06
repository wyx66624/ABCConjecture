#!/usr/bin/env bash
set -euo pipefail
D="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="$(cd "$D/../../.." && pwd)"
if [[ "$(uname -s)" != Linux || "$(uname -m)" != x86_64 ]]; then
  echo 'This pinned installer supports x86_64 Linux, including WSL Ubuntu.' >&2; exit 1
fi
HOME_LEAN="${ABC_LEAN_HOME:-$HOME/.cache/abc-lean/lean-4.32.2-linux}"
if [[ ! -x "$HOME_LEAN/bin/lean" ]]; then
  TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
  curl --fail --location --retry 3 -o "$TMP/lean.tar.zst" https://github.com/leanprover/lean4/releases/download/v4.32.2/lean-4.32.2-linux.tar.zst
  echo "5f2069e6f5db73780f374ccb49ce8ea649aa20a0cebf0116816744c999ce72aa  $TMP/lean.tar.zst" | sha256sum -c -
  tar --zstd -xf "$TMP/lean.tar.zst" -C "$TMP"
  mkdir -p "$(dirname "$HOME_LEAN")"
  mv "$TMP/lean-4.32.2-linux" "$HOME_LEAN"
fi
LOG="${ABC_VERIFY_OUTPUT:-$D/verification/runtime}"
mkdir -p "$LOG"
"$HOME_LEAN/bin/lean" --version | tee "$LOG/compiler.txt"
grep -q 'version 4.32.2,' "$LOG/compiler.txt"
F="$D/Lean/CorrelatedCompletions.lean"
sha256sum "$F" | tee "$LOG/source.sha256"
"$HOME_LEAN/bin/lean" -DwarningAsError=true -o "$LOG/CorrelatedCompletions.olean" "$F" | tee "$LOG/axioms.log"
python3 "$ROOT/research/checkpoints/2026_09_05_transverse_lifting/wsl/check_axioms.py" "$F" "$LOG/axioms.log"
echo 'PASS: scoped declarations compiled; not an ABC proof.'
