#!/usr/bin/env bash
# Run inside an existing Linux x86_64 / WSL Ubuntu environment.
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../../../.." && pwd)"
VERSION=4.32.2
SHA=5f2069e6f5db73780f374ccb49ce8ea649aa20a0cebf0116816744c999ce72aa
HOME_LEAN="${ABC_LEAN_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/abc-research}"
TC="$HOME_LEAN/lean-${VERSION}-linux"
[[ "$(uname -s)" == Linux && "$(uname -m)" == x86_64 ]] || { echo 'Linux x86_64 required.' >&2; exit 2; }
for cmd in curl tar zstd sha256sum python3; do command -v "$cmd" >/dev/null || { echo "Missing $cmd" >&2; exit 2; }; done
TMP="$(mktemp -d)"
trap 'rm -rf -- "$TMP"' EXIT
if [[ ! -x "$TC/bin/lean" ]]; then
  mkdir -p "$HOME_LEAN"
  curl --fail --location --retry 3 -o "$TMP/lean.tar.zst" "https://github.com/leanprover/lean4/releases/download/v${VERSION}/lean-${VERSION}-linux.tar.zst"
  printf '%s  %s\n' "$SHA" "$TMP/lean.tar.zst" | sha256sum -c -
  tar --zstd -xf "$TMP/lean.tar.zst" -C "$TMP"
  [[ ! -e "$TC" ]] || { echo 'Refusing to replace an incomplete installation.' >&2; exit 2; }
  mv "$TMP/lean-${VERSION}-linux" "$TC"
  printf '%s\n' "$SHA" > "$TC/ABC_ARCHIVE_SHA256"
fi
[[ -f "$TC/ABC_ARCHIVE_SHA256" && "$(cat "$TC/ABC_ARCHIVE_SHA256")" == "$SHA" ]] || { echo 'Missing checksum verification marker.' >&2; exit 2; }
cd "$ROOT"
E=research/checkpoints/2026_09_05_eisenstein_descent/Lean/EisensteinDescent.lean
P=research/checkpoints/2026_09_06_exponent_profiles/Lean/ExponentProfiles.lean
C=research/checkpoints/2026_09_05_transverse_lifting/wsl/check_axioms.py
LOGS="${ABC_LOG_DIR:-$TMP/logs}"
mkdir -p "$LOGS" "$TMP/olean"
"$TC/bin/lean" --version | tee "$LOGS/compiler.txt"
"$TC/bin/lean" -DwarningAsError=true -o "$TMP/olean/EisensteinDescent.olean" "$E" | tee "$LOGS/dependency.log"
python3 "$C" "$E" "$LOGS/dependency.log"
LEAN_PATH="$TMP/olean" "$TC/bin/lean" -DwarningAsError=true "$P" | tee "$LOGS/profiles.log"
python3 "$C" "$P" "$LOGS/profiles.log"
echo 'PASS: 16 new scoped declarations and 29 dependency declarations; NOT an ABC proof.'
