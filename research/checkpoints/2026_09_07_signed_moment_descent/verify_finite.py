#!/usr/bin/env python3
"""Replay exact descent identities and the complete primitive mod-27 table."""
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
    base = ROOT / 'research/checkpoints/2026_09_07_independent_route/fifteenth_round'
    script = base / 'replay_gaussian_descent.py'
    certificate = base / 'verification/gaussian_descent.json'
    files = {p.relative_to(ROOT).as_posix(): sha(p) for p in [script, certificate]}
    proc = subprocess.run([sys.executable, str(script), '--check'],
                          capture_output=True, text=True, timeout=300)
    assert proc.returncode == 0 and not proc.stderr.strip(), (proc.stdout, proc.stderr)
    replay = json.loads(certificate.read_text(encoding='utf-8'))
    assert replay['status'] == 'PASS'
    assert replay['rational_function_identity_count'] == 11
    assert replay['mod27_primitive_curve_residue_hits'] == 486
    assert replay['mod27_primitive_curve_hits_with_3_dividing_B'] == 0
    expected = 'PASS 11 identities; 486 primitive mod27 hits; ' + sha(certificate)
    assert proc.stdout.strip() == expected, proc.stdout
    for path, digest in files.items():
        assert sha(ROOT / path) == digest, path
    record = {'script': script.relative_to(ROOT).as_posix(),
              'arguments': ['--check'], 'files_sha256': files, 'result': replay,
              'actual_stdout': proc.stdout.strip()}
    result = {'status': 'PASS: exact finite replay with unchanged source and certificate bytes',
              'records': [record],
              'not_claimed': ['ABC proof or disproof', 'all rational points',
                              'a rank theorem proved by finite sampling',
                              'analytic or geometric theorem proved by sampling']}
    target = HERE / 'verification/finite_replay_validation.json'
    target.parent.mkdir(exist_ok=True)
    target.write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps({'status': result['status'], 'replays': 1}, indent=2))


if __name__ == '__main__':
    main()
