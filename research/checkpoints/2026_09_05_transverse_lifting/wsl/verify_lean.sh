#!/usr/bin/env bash
# Author: ChatGPT. Run inside an existing x86_64 Ubuntu/WSL distribution.
# Installs an isolated, checksum-pinned Lean; does not change elan defaults
# or the repository's existing Lean/lean-toolchain.
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION=4.32.2
ARCHIVE_SHA=5f2069e6f5db73780f374ccb49ce8ea649aa20a0cebf0116816744c999ce72aa
URL="https://github.com/leanprover/lean4/releases/download/v${VERSION}/lean-${VERSION}-linux.tar.zst"
INSTALL_ROOT="${ABC_LEAN_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/abc-research}"
TOOLCHAIN="$INSTALL_ROOT/lean-${VERSION}-linux"
if [[ "$(uname -s)" != Linux || "$(uname -m)" != x86_64 ]]; then
  echo 'This pinned distribution requires Linux x86_64, including x86_64 WSL.' >&2
  exit 2
fi
for cmd in curl tar zstd sha256sum grep python3; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Missing dependency: $cmd" >&2
    echo 'Inside Ubuntu/WSL: sudo apt-get update && sudo apt-get install -y curl ca-certificates tar zstd coreutils python3' >&2
    exit 2
  fi
done
tmp=""
logs=""
cleanup() {
  [[ -z "$tmp" ]] || rm -rf -- "$tmp"
  [[ -z "$logs" ]] || rm -rf -- "$logs"
}
trap cleanup EXIT
if [[ ! -x "$TOOLCHAIN/bin/lean" ]]; then
  mkdir -p "$INSTALL_ROOT"
  tmp="$(mktemp -d "$INSTALL_ROOT/.lean-install.XXXXXXXX")"
  curl --fail --location --retry 3 --output "$tmp/lean.tar.zst" "$URL"
  printf '%s  %s\n' "$ARCHIVE_SHA" "$tmp/lean.tar.zst" | sha256sum --check -
  tar --zstd -xf "$tmp/lean.tar.zst" -C "$tmp"
  if [[ -e "$TOOLCHAIN" ]]; then
    echo "Refusing to replace an incomplete existing installation: $TOOLCHAIN" >&2
    exit 2
  fi
  mv -- "$tmp/lean-${VERSION}-linux" "$TOOLCHAIN"
  printf '%s\n' "$ARCHIVE_SHA" > "$TOOLCHAIN/ABC_ARCHIVE_SHA256"
fi
if [[ ! -f "$TOOLCHAIN/ABC_ARCHIVE_SHA256" ]] ||
   [[ "$(cat "$TOOLCHAIN/ABC_ARCHIVE_SHA256")" != "$ARCHIVE_SHA" ]]; then
  echo 'Existing installation lacks the matching archive-verification marker.' >&2
  exit 2
fi
"$TOOLCHAIN/bin/lean" --version
logs="$(mktemp -d)"
for source in TransverseBenchmark.lean PrimitiveClass.lean; do
  printf '\nChecking %s\n' "$source"
  "$TOOLCHAIN/bin/lean" -DwarningAsError=true "$ROOT/Lean/$source" | tee "$logs/$source.log"
  python3 "$ROOT/wsl/check_axioms.py" "$ROOT/Lean/$source" "$logs/$source.log"
done
printf '\nPASS: both scoped Lean modules compiled; this is not an ABC proof.\n'
