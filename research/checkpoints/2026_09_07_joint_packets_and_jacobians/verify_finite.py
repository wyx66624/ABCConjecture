#!/usr/bin/env python3
"""Regenerate the reviewed QS certificate; finite evidence only."""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
SOURCE = ROOT / 'research/checkpoints/2026_09_07_independent_route/sixteenth_round'


def main():
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    (out / 'finite_replay_validation.json').write_text(
        json.dumps({'status': 'NOT_RUN: current invocation has not validated the finite certificate'})
        + '\n')
    script = SOURCE / 'replay_rational_simple_quotients.py'
    certificate = SOURCE / 'verification/rational_simple_quotients.json'
    digest = hashlib.sha256(certificate.read_bytes()).hexdigest()
    assert digest == '6ba65a743aa190819b6d3b43c7e357d0f5aacb1e53508078cab882a46f240883'
    proc = subprocess.run([sys.executable, str(script), '--check'], check=True,
                          capture_output=True, text=True, encoding='utf-8')
    result = {'status': 'PASS: exact QS finite replay; no geometric or point-completeness oracle',
              'records': [{'output': proc.stdout.strip(),
                           'files_sha256': {p.relative_to(ROOT).as_posix():
                               hashlib.sha256(p.read_bytes()).hexdigest()
                               for p in [script, certificate]}}]}
    (out / 'finite_replay_validation.json').write_bytes(
        (json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
