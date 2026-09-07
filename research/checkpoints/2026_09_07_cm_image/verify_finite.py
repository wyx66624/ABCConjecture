#!/usr/bin/env python3
"""Replay the three exact finite certificates, without inferring global theorems."""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
CASES = [
    ('2026_09_07_adversarial_audit/eighth_round', 'replay_cm_shadow.py',
     'cm_shadow_results.json', ['replay_cm_shadow.py']),
    ('2026_09_07_independent_route/eighth_round', 'replay_boundary_twist.py',
     'boundary_twist_results.json', ['replay_boundary_twist.py', 'boundary_twist_certificate.gp']),
    ('2026_09_07_adversarial_audit/eighth_round', 'replay_twist_independent.py',
     'independent_twist_results.json', ['replay_twist_independent.py', 'replay_twist_independent.gp']),
]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    records = []
    for directory, script, certificate, sources in CASES:
        base = ROOT / 'research/checkpoints' / directory
        files = {p.relative_to(ROOT).as_posix(): digest(p)
                 for p in [base / s for s in sources] + [base / certificate]}
        command = [sys.executable, str(base / script), '--check']
        proc = subprocess.run(command, capture_output=True, text=True, timeout=300)
        assert proc.returncode == 0, (script, proc.stdout, proc.stderr)
        assert not proc.stderr.strip(), (script, proc.stderr)
        result = json.loads(proc.stdout)
        assert result['status'] == 'PASS', result
        for relative, expected in files.items():
            assert digest(ROOT / relative) == expected, relative
        assert result['sha256'] == digest(base / certificate), certificate
        records.append({'script': (base / script).relative_to(ROOT).as_posix(),
                        'arguments': ['--check'], 'files_sha256': files, 'result': result})
    result = {
        'status': 'PASS: three exact finite replays with unchanged source and certificate bytes',
        'records': records,
        'not_claimed': ['ABC proof or disproof', 'Lean modular-form construction',
                        'Sturm theorem without its separate ordinary proof',
                        'global representation theorem from finite shadows'],
    }
    target = HERE / 'verification/finite_replay_validation.json'
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps({'status': result['status'], 'replays': len(records)}, indent=2))


if __name__ == '__main__':
    main()
