#!/usr/bin/env python3
"""Replay the two independent exact elliptic supplements with frozen certificates."""
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
    records = []
    for agent, script_name, certificate_name in [
        ('independent_route', 'replay_simultaneous_gate.py', 'simultaneous_gate.json'),
        ('adversarial_audit', 'replay_elliptic_gate_review.py', 'elliptic_gate_identity_review.json')]:
        base = ROOT / ('research/checkpoints/2026_09_07_' + agent + '/fourteenth_round')
        script, certificate = base / script_name, base / 'verification' / certificate_name
        files = {p.relative_to(ROOT).as_posix(): sha(p) for p in [script, certificate]}
        proc = subprocess.run([sys.executable, str(script), '--check'],
                              capture_output=True, text=True, timeout=300)
        assert proc.returncode == 0 and not proc.stderr.strip(), (proc.stdout, proc.stderr)
        replay = json.loads(proc.stdout)
        assert replay['status'] == 'PASS' and replay['sha256'] == sha(certificate)
        for path, digest in files.items():
            assert sha(ROOT / path) == digest, path
        records.append({'script': script.relative_to(ROOT).as_posix(),
                        'arguments': ['--check'], 'files_sha256': files, 'result': replay})
    result = {
        'status': 'PASS: two exact finite replays with unchanged source and certificate bytes',
        'records': records,
        'not_claimed': ['ABC proof or disproof', 'all rational points',
                       'complete elliptic or Jacobian rank computation',
                       'analytic or geometric theorem proved by sampling']}
    target = HERE / 'verification/finite_replay_validation.json'
    target.parent.mkdir(exist_ok=True)
    target.write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps({'status': result['status'], 'replays': len(records)}, indent=2))

if __name__ == '__main__':
    main()
