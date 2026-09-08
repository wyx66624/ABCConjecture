#!/usr/bin/env python3
"""Invalidate historical PASS before dependency setup in a new CI invocation."""
from pathlib import Path
import json

here = Path(__file__).resolve().parent / 'verification'
here.mkdir(exist_ok=True)
for name in ['mathlib_validation.json', 'finite_replay_validation.json']:
    (here / name).write_text(json.dumps({'status': 'NOT_RUN: current CI invocation'}) + '\n')
(here / 'fresh-mathlib-build.log').write_text('Current invocation has no compiler output yet.\n')
