#!/usr/bin/env python3
"""Seal the actually compiled, visually reviewed manuscript at the requested path."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[3]
WORK = ROOT / 'tmp/abc_20260907'
BUILD = WORK / 'pdfbuild'
OUT = Path(__file__).resolve().parent / 'verification'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    pdf = BUILD / 'ChatGPT_ABC_Uniformity_2026.pdf'
    log = (BUILD / 'final-pass.txt').read_text(encoding='utf-8')
    assert not re.search(r'Overfull \\[hv]box|undefined|multiply defined|^!', log, re.M)
    reader = PdfReader(pdf)
    assert len(reader.pages) == 360
    sources = {}
    for line in (BUILD / 'ChatGPT_ABC_Uniformity_2026.fls').read_text().splitlines():
        if not line.startswith('INPUT ') or not line.endswith('.tex'):
            continue
        raw = line[6:]
        if raw.startswith('/mnt/e/'):
            path = Path('E:/' + raw[len('/mnt/e/'):]) if ROOT.drive else Path(raw)
        elif raw.startswith('/'):
            continue
        else:
            path = ROOT / 'paper' / raw
        path = path.resolve()
        if not path.is_relative_to(ROOT):
            continue
        sources[path.relative_to(ROOT).as_posix()] = sha(path)
    assert 'paper/ChatGPT_ABC_Uniformity_2026.tex' in sources
    assert len(sources) > 50
    # Verify the recorder-enabled pass has the same page rasters already inspected.
    subprocess.run(['pdftoppm', '-f', '1', '-l', '1', '-scale-to', '1400', '-png',
                    str(pdf), str(WORK / 'seal-title')], check=True)
    subprocess.run(['pdftoppm', '-f', '349', '-l', '356', '-scale-to', '1500', '-png',
                    str(pdf), str(WORK / 'seal-new')], check=True)
    pages = {}
    for n in [1, *range(349, 357)]:
        stem = 'title' if n == 1 else 'new'
        prior = WORK / f'final-{stem}-{n:03d}.png'
        final = WORK / f'seal-{stem}-{n:03d}.png'
        assert sha(prior) == sha(final), f'Review required for changed raster page {n}'
        pages[str(n)] = sha(final)
    target = ROOT / 'output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf'
    original_sha = '0dfc4b7be5f7b32c65d357bf43d1e0df91a4ec8c35eb68cec7f46c56898e4e9f'
    assert sha(target) in {original_sha, sha(pdf)}, 'User-designated file changed independently'
    shutil.copyfile(pdf, target)
    assert len(PdfReader(target).pages) == 360 and sha(target) == sha(pdf)
    OUT.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(BUILD / 'final-pass.txt', OUT / 'manuscript-build.txt')
    result = {
        'status': 'PASS: compiled full manuscript, resolved references, visual review of changed pages',
        'baseline_commit': subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT,
                                                   text=True).strip(),
        'pdf': target.relative_to(ROOT).as_posix(), 'pages': 360,
        'pdf_sha256': sha(target), 'pdf_bytes': target.stat().st_size,
        'original_user_pdf_pages': 93, 'original_user_pdf_sha256': original_sha,
        'overfull_boxes': 0, 'unresolved_references_or_citations': 0,
        'visually_reviewed_pages': [1, *range(349, 357)],
        'final_raster_sha256': pages, 'actual_tex_inputs_sha256': dict(sorted(sources.items())),
        'build': 'pdflatex -recorder -interaction=nonstopmode -halt-on-error -file-line-error',
        'layout_dependencies': ['pdfTeX 1.40.25', 'cm-super scalable fonts'],
        'formal_validation': 'verification/lean_validation.json',
        'not_claimed': ['ABC proof or disproof', 'all-page visual review',
                        'full manuscript formalization', 'external peer review'],
    }
    (OUT / 'manuscript_validation.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in ['status', 'pdf', 'pages', 'pdf_sha256',
                                           'overfull_boxes', 'unresolved_references_or_citations']}))


if __name__ == '__main__':
    main()
