#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess,sys
D=Path(__file__).resolve().parent
ROOT=D.parents[2]
manifest=json.loads((D/'verification/source_manifest.json').read_text())
for rel,expected in manifest.items():
    path=ROOT/rel
    if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest()!=expected:
        raise SystemExit('Source mismatch: '+rel)
print('PASS: sealed source hashes',len(manifest))
result=subprocess.run([sys.executable,str(D/'computation/replay.py')],check=True,capture_output=True).stdout
expected=(D/'verification/results.json').read_bytes()
if result!=expected:raise SystemExit('Exact replay differs from sealed result')
print('PASS: complete exact replay, bytes',len(result),'sha256',hashlib.sha256(result).hexdigest())
print('NOT an ABC proof or a numerical test of analytic asymptotics.')
