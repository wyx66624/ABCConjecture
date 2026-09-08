#!/usr/bin/env python3
"""Replay two exact finite inputs; the infinite proofs are separate sources."""
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
    output = HERE / 'verification/finite_replay_validation.json'
    output.parent.mkdir(exist_ok=True)
    state = {'status': 'NOT_RUN', 'records': []}

    def save():
        output.write_text(json.dumps(state, indent=2) + '\n', encoding='utf-8')

    save()
    try:
        manifest_path = HERE / 'verification/finite_input_inventory.json'
        manifest = json.loads(manifest_path.read_text(encoding='utf-8'))
        for path, digest in manifest['files_sha256'].items():
            if sha(ROOT / path) != digest:
                raise ValueError('Input changed: ' + path)
        state['status'] = 'RUNNING'
        state['input_inventory_sha256'] = sha(manifest_path)
        save()
        for script in manifest['programs']:
            proc = subprocess.run([sys.executable, '-X', 'utf8', str(ROOT / script), '--check'],
                                  capture_output=True, text=True, encoding='utf-8', timeout=300)
            state['records'].append({'script': script, 'exit_code': proc.returncode,
                                     'output': proc.stdout + proc.stderr})
            save()
            if proc.returncode:
                raise RuntimeError('Finite replay failed: ' + script)
        for path, digest in manifest['files_sha256'].items():
            if sha(ROOT / path) != digest:
                raise ValueError('Input changed during replay: ' + path)
        state.update(status='PASS: two complete exact finite replays',
                     not_claimed=['analytic tails', 'height identities', 'rational-point completeness',
                                  'sieve or asymptotics', 'Lean proof', 'ABC'])
        save()
        print(json.dumps({'status': state['status'], 'records': len(state['records'])}))
    except BaseException as exc:
        state.update(status='FAIL', error=str(exc))
        save()
        raise


if __name__ == '__main__':
    main()
