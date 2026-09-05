#!/usr/bin/env python3
"""Check original source hashes and rerun both finite, exact research experiments.

This is not a Lean build or an unconditional ABC proof. Uses Python 3.10+
standard library only. Run from any directory; --output-dir must be new.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_sources() -> int:
    count = 0
    for line in (ROOT / 'SOURCE_SHA256SUMS').read_text(encoding='utf-8').splitlines():
        expected, relative = line.split('  ', 1)
        path = (ROOT / relative).resolve()
        if not path.is_relative_to(ROOT) or not path.is_file():
            raise ValueError(f'Invalid source path: {relative}')
        if digest(path) != expected:
            raise ValueError(f'Source hash mismatch: {relative}')
        count += 1
    if count != 9:
        raise ValueError(f'Expected 9 original primary files, found {count}')
    return count


def replay(output_dir: Path) -> None:
    record = json.loads((ROOT / 'verification/merge_validation.json').read_text(encoding='utf-8'))
    computations = ROOT / 'research/computation'
    cases = [
        ('fcrt', [sys.executable, str(computations / 'fcrt_unit_gap_2026_09_05.py')]),
        ('signed', [sys.executable, str(computations / 'abc_signed_endpoint_2026_09_05.py'),
                    '--certificate', str(ROOT / 'research/verification/2026_09_05_signed/prime_certificate.json')]),
    ]
    for name, command in cases:
        result = output_dir / f'{name}_results.json'
        log = output_dir / f'{name}_replay.log'
        if result.exists() or log.exists():
            raise FileExistsError(f'Refusing to overwrite {name} replay output')
        with log.open('w', encoding='utf-8') as stream:
            subprocess.run(command + ['--output', str(result)], cwd=ROOT,
                           stdout=stream, stderr=subprocess.STDOUT, check=True)
        expected = record['local_replay'][name]
        if result.stat().st_size != expected['output_bytes']:
            raise ValueError(f'{name}: output size mismatch; see {log}')
        if digest(result) != expected['output_sha256']:
            raise ValueError(f'{name}: output hash mismatch; see {log}')
        if json.loads(result.read_text(encoding='utf-8')).get('all_checks_passed') is not True:
            raise ValueError(f'{name}: computation reported incomplete checks')
        print(f'{name}: exact result matches archived SHA-256 and byte count')


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', type=Path, help='New directory for complete JSON outputs and logs')
    args = parser.parse_args()
    print(f'Original primary sources verified: {check_sources()}')
    if args.output_dir is not None:
        destination = args.output_dir.resolve()
        destination.mkdir(parents=True, exist_ok=False)
        replay(destination)
        print(f'Full results retained in {destination}')
    else:
        with tempfile.TemporaryDirectory(prefix='abc_checkpoint_') as temp:
            replay(Path(temp))
    print('PASS: finite computation replay only. Lean and unconditional ABC remain unverified.')


if __name__ == '__main__':
    main()
