#!/usr/bin/env python3
"""Replay the exact bounded quotient/local supplement without asymptotic inference."""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    base = ROOT / 'research/checkpoints/2026_09_07_independent_route/thirteenth_round'
    script = base / 'replay_genus_two_probe.py'
    certificate = base / 'verification/genus_two_probe.json'
    files = {p.relative_to(ROOT).as_posix(): sha(p)
             for p in [script, certificate, base / 'genus_two_probe.gp']}
    proc = subprocess.run([sys.executable, str(script), '--check'],
                          capture_output=True, text=True, timeout=300)
    assert proc.returncode == 0 and not proc.stderr.strip(), (proc.stdout, proc.stderr)
    replay = json.loads(proc.stdout)
    assert replay['status'] == 'PASS' and replay['sha256'] == sha(certificate)
    for path, digest in files.items():
        assert sha(ROOT / path) == digest, path
    result = {
        'status': 'PASS: exact finite replay with unchanged source and certificate bytes',
        'records': [{'script': script.relative_to(ROOT).as_posix(),
                     'arguments': ['--check'], 'files_sha256': files, 'result': replay}],
        'not_claimed': ['ABC proof or disproof', 'all rational points',
                        'complete elliptic or Jacobian rank computation',
                        'analytic or geometric theorem proved by sampling']}
    target = HERE / 'verification/finite_replay_validation.json'
    target.parent.mkdir(exist_ok=True)
    target.write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps({'status': result['status'], 'replays': 1}, indent=2))

if __name__ == '__main__':
    main()
