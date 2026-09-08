#!/usr/bin/env python3
"""Prepare an isolated dependency-only project for the collective-content-closure CI job."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
TARGET = ROOT / 'tmp/abc_20260907/collective-content-closure-ci-project'
PIN = '81a5d257c8e410db227a6665ed08f64fea08e997'


def main():
    TARGET.mkdir(parents=True, exist_ok=True)
    files = {
        'lean-toolchain': 'leanprover/lean4:v4.32.0\n',
        'lakefile.toml': (
            'name = "ABCCollectiveContentDependencies"\nversion = "0.1.0"\n'
            '[[require]]\nname = "mathlib"\n'
            'git = "https://github.com/leanprover-community/mathlib4.git"\n'
            'rev = "' + PIN + '"\n'),
    }
    for name, code in files.items():
        path = TARGET / name
        data = code.encode()
        if path.exists():
            assert path.read_bytes() == data, 'Existing project differs: ' + str(path)
        else:
            path.write_bytes(data)
    print(TARGET.relative_to(ROOT).as_posix())


if __name__ == '__main__':
    main()
