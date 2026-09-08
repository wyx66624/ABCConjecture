#!/usr/bin/env python3
"""Invalidate checked-in PASS records before any current CI dependency work."""
from pathlib import Path
import json

HERE = Path(__file__).resolve().parent


def main():
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    for name in ['mathlib_validation.json', 'finite_replay_validation.json']:
        (out / name).write_text(json.dumps({
            'status': 'NOT_RUN: this CI job has not completed the corresponding verification'
        }) + '\n')
    (out / 'fresh-mathlib-build.log').write_text('This CI job has produced no compiler output yet.\n')


if __name__ == '__main__':
    main()
