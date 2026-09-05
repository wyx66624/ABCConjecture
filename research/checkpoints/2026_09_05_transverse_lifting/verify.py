#!/usr/bin/env python3
"""Check this checkpoint's source integrity and exact finite replay; not Lean or ABC."""
from pathlib import Path
import hashlib
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent
EXPECTED = '9b1a73607615b4bf732e8c651c4b381e4c156fbdb258d597ce239a0c8e94d196'

def main():
    manifest = ROOT / 'SOURCE_SHA256SUMS'
    entries = 0
    for line in manifest.read_text().splitlines():
        if not line.strip(): continue
        expected, name = line.split('  ', 1)
        path = ROOT / name
        if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != expected:
            raise SystemExit(f'Source hash mismatch: {name}')
        entries += 1
    with tempfile.TemporaryDirectory(prefix='abc-transverse-replay-') as tmp:
        out = Path(tmp) / 'results.json'
        subprocess.run([sys.executable, str(ROOT/'computation/verify.py'), '--output', str(out)],check=True)
        data = out.read_bytes()
        if hashlib.sha256(data).hexdigest()!=EXPECTED:
            raise SystemExit('Regenerated output hash mismatch')
        if data != (ROOT/'verification/results.json').read_bytes():
            raise SystemExit('Regenerated output bytes differ from the recorded result')
        for name in ['TransverseBenchmark.lean','PrimitiveClass.lean']:
            subprocess.run([sys.executable,str(ROOT/'wsl/check_axioms.py'),str(ROOT/'Lean'/name),
                str(ROOT/'verification/lean_axioms.txt')],check=True)
    print(f'PASS: {entries} source hashes; exact output bytes; saved axiom-report format.')
    print('Lean was not run by this command. Use bash wsl/verify_lean.sh for actual compilation.')

if __name__=='__main__': main()
