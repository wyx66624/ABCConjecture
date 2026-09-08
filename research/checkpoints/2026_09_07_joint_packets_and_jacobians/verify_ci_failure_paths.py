#!/usr/bin/env python3
"""Exercise failed preflights in isolated copies, never reusing historical PASS."""
from pathlib import Path
import hashlib
import json
import shutil
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent


def main():
    scripts = ['initialize_ci_evidence.py', 'verify_mathlib.py', 'verify_finite.py']
    outputs = ['mathlib_validation.json', 'finite_replay_validation.json']
    with tempfile.TemporaryDirectory(prefix='abc-ci-evidence-negative-') as temporary:
        dest = Path(temporary) / 'research/checkpoints/sample'
        dest.mkdir(parents=True)
        evidence = dest / 'verification'
        evidence.mkdir()
        for name in scripts:
            shutil.copyfile(HERE / name, dest / name)
        for name in outputs:
            (evidence / name).write_text(json.dumps({'status': 'PASS: stale'}))
        proc = subprocess.run([sys.executable, str(dest / scripts[0])], capture_output=True)
        assert proc.returncode == 0
        assert all(json.loads((evidence / s).read_text())['status'].startswith('NOT_RUN:')
                   for s in outputs)
        checks = ['CI reset invalidates both historical PASS files']
        (evidence / outputs[0]).write_text(json.dumps({'status': 'PASS: stale'}))
        proc = subprocess.run([sys.executable, str(dest / scripts[1]), '--project',
                               str(dest / 'missing-project')], capture_output=True)
        assert proc.returncode != 0
        assert json.loads((evidence / outputs[0]).read_text())['status'].startswith('NOT_RUN:')
        checks.append('Missing Mathlib preflight cannot preserve PASS')
        (evidence / outputs[1]).write_text(json.dumps({'status': 'PASS: stale'}))
        proc = subprocess.run([sys.executable, str(dest / scripts[2])], capture_output=True)
        assert proc.returncode != 0
        assert json.loads((evidence / outputs[1]).read_text())['status'].startswith('NOT_RUN:')
        checks.append('Missing finite certificate cannot preserve PASS')
    result = {'status': 'PASS: actual negative-path checks in isolated temporary copies',
              'checks': checks, 'sources_sha256': {name: hashlib.sha256(
                  (HERE / name).read_bytes()).hexdigest() for name in scripts}}
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    (out / 'ci_negative_path_validation.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
