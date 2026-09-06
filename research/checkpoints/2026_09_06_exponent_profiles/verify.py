#!/usr/bin/env python3
"""Check sealed sources and replay finite arithmetic; no asymptotic inference."""
from __future__ import annotations
import hashlib,json,subprocess,sys,tempfile
from pathlib import Path
HERE=Path(__file__).resolve().parent

def main()->None:
    manifest=json.loads((HERE/'verification/source_manifest.json').read_text())
    for relative,wanted in manifest['sha256'].items():
        p=HERE/relative
        got=hashlib.sha256(p.read_bytes()).hexdigest()
        if got!=wanted:raise RuntimeError(f'Source mismatch: {relative}')
    with tempfile.TemporaryDirectory(prefix='abc-profiles-') as d:
        out=Path(d)/'results.json'
        subprocess.run([sys.executable,str(HERE/'computation/replay.py'),'--output',str(out)],check=True)
        sealed=(HERE/'verification/results.json').read_bytes()
        if out.read_bytes()!=sealed:raise RuntimeError('Exact replay differs from sealed result')
    print(f'PASS: {len(manifest["sha256"])} source hashes and byte-identical finite replay; NOT an ABC proof.')
if __name__=='__main__':main()
