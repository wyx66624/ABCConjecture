#!/usr/bin/env python3
"""Replay the three exact finite supplements; no asymptotic inference."""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
CASES = [
    ('2026_09_07_adversarial_audit/twelfth_round', 'replay_phase_fibers.py',
     'phase_fiber_results.json', 'sha256'),
    ('2026_09_07_critical_bottleneck/twelfth_round', 'replay_private_norm.py',
     'verification/private_norm_replay.json', 'json_file_sha256'),
    ('2026_09_07_independent_route/twelfth_round', 'replay_rational_geometry.py',
     'verification/rational_geometry_replay.json', 'sha256'),
]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    records = []
    for directory, script, certificate, hash_key in CASES:
        base = ROOT / 'research/checkpoints' / directory
        files = {p.relative_to(ROOT).as_posix(): digest(p)
                 for p in [base / script, base / certificate]}
        proc = subprocess.run([sys.executable, str(base / script), '--check'],
                              capture_output=True, text=True, timeout=300)
        assert proc.returncode == 0, (script, proc.stdout, proc.stderr)
        assert not proc.stderr.strip(), (script, proc.stderr)
        result = json.loads(proc.stdout)
        assert result['status'] == 'PASS', result
        for relative, expected in files.items():
            assert digest(ROOT / relative) == expected, relative
        assert result[hash_key] == digest(base / certificate), certificate
        records.append({'script': (base / script).relative_to(ROOT).as_posix(),
                        'arguments': ['--check'], 'files_sha256': files, 'result': result})
    result = {
        'status': 'PASS: three exact finite replays with unchanged source and certificate bytes',
        'records': records,
        'not_claimed': ['ABC proof or disproof', 'asymptotic density or signed-tail bound',
                        'deep-prime membership of phase examples',
                        'complete rational-point or Jacobian-rank computation',
                        'geometric theorem proved by finite sampling'],
    }
    target = HERE / 'verification/finite_replay_validation.json'
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps({'status': result['status'], 'replays': len(records)}, indent=2))


if __name__ == '__main__':
    main()
