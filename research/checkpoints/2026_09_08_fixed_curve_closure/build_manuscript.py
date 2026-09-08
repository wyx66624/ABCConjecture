#!/usr/bin/env python3
"""Compile the full manuscript with a stable inventory of its actual TeX inputs.

Use the existing WSL/Linux TeX environment. Rendering and human/model visual
inspection follow separately; successful compilation alone is not visual QA.
"""
from pathlib import Path
import hashlib
import json
import re
import subprocess

ROOT = Path(__file__).resolve().parents[3]
BUILD = ROOT / 'tmp/abc_20260908/fixed_curve_pdf'


def compile_once():
    proc = subprocess.run(['pdflatex', '-recorder', '-interaction=nonstopmode',
        '-halt-on-error', '-file-line-error', '-output-directory=' + str(BUILD),
        'ChatGPT_ABC_Uniformity_2026.tex'], cwd=ROOT / 'paper', capture_output=True, text=True)
    log = proc.stdout + proc.stderr
    (BUILD / 'final-pass.txt').write_text(log)
    if proc.returncode:
        raise SystemExit(log[-4000:])
    return log


def input_paths():
    paths = set()
    for line in (BUILD / 'ChatGPT_ABC_Uniformity_2026.fls').read_text().splitlines():
        if not line.startswith('INPUT ') or not line.endswith('.tex'):
            continue
        path = Path(line[6:])
        if not path.is_absolute():
            path = ROOT / 'paper' / path
        path = path.resolve()
        if path.is_relative_to(ROOT):
            paths.add(path)
    return paths


def inventory(paths):
    return {p.relative_to(ROOT).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(paths)}


def main():
    BUILD.mkdir(parents=True, exist_ok=True)
    compile_once()
    paths = input_paths()
    before = inventory(paths)
    compile_once()
    log = compile_once()
    assert paths == input_paths() and before == inventory(paths), 'TeX inputs changed during build'
    assert not re.search(r'Overfull \\[hv]box|undefined|multiply defined|^!', log, re.M)
    (BUILD / 'final_source_inventory.json').write_text(json.dumps(before, indent=2) + '\n')
    print(json.dumps({'actual_tex_sources': len(before), 'layout_and_reference_warnings': 0,
                      'next': 'Render and visually inspect changed pages; compilation is not visual review.'}))


if __name__ == '__main__':
    main()
