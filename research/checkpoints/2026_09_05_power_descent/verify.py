#!/usr/bin/env python3
"""Source integrity and deterministic finite replay; does not run Lean."""
from __future__ import annotations
import hashlib
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent

def main() -> None:
    manifest = ROOT / 'SOURCE_SHA256SUMS'
    checked = 0
    for row in manifest.read_text(encoding='utf-8').splitlines():
        expected, relative = row.split('  ', 1)
        p = (ROOT / relative).resolve()
        if ROOT not in p.parents or not p.is_file():
            raise SystemExit(f'Invalid source path: {relative}')
        actual = hashlib.sha256(p.read_bytes()).hexdigest()
        if actual != expected:
            raise SystemExit(f'Source checksum mismatch: {relative}')
        checked += 1
    with tempfile.TemporaryDirectory(prefix='abc-power-replay-') as temp:
        output = Path(temp) / 'results.json'
        subprocess.run([sys.executable, str(ROOT/'computation/replay.py'), str(output)],
                       check=True, cwd=ROOT)
        expected_bytes = (ROOT/'verification/results.json').read_bytes()
        if output.read_bytes() != expected_bytes:
            raise SystemExit('Finite replay JSON does not match the recorded bytes')
    print(f'PASS: {checked} source hashes; byte-identical exact finite replay.')
    print('Lean was not run by this command. Run bash wsl/verify_lean.sh.')
    print('The uniform ABC estimate is not proved by this checkpoint.')

if __name__ == '__main__':
    main()
