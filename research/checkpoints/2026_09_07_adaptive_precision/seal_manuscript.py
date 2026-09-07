#!/usr/bin/env python3
"""Seal only the final compiled PDF whose rendered changed pages were reviewed.

Run after final-pass.txt and visual_review.json have been produced. The visual
review lists actual PNG hashes and the matching PDF hash; it is a review record,
not an automated claim that pixels prove mathematics.
"""
from pathlib import Path
import hashlib
import json
import re
import shutil
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
BUILD = ROOT / 'tmp/abc_20260907/round14pdf'
PREVIOUS_SHA = 'fefb61573ea9408f26f5c7d85f5383899bd9f29e8175033cc1f86998a993a74a'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    pdf = BUILD / 'ChatGPT_ABC_Uniformity_2026.pdf'
    log = (BUILD / 'final-pass.txt').read_text(encoding='utf-8')
    assert not re.search(r'Overfull \\[hv]box|undefined|multiply defined|^!', log, re.M)
    review = json.loads((BUILD / 'visual_review.json').read_text(encoding='utf-8'))
    build_sources = json.loads((BUILD / 'final_source_inventory.json').read_text())
    assert review['pdf_sha256'] == sha(pdf)
    assert review['status'] == 'PASS: changed pages visually reviewed'
    for relative, digest in review['raster_sha256'].items():
        assert sha(ROOT / relative) == digest, relative
    for relative, digest in build_sources.items():
        assert sha(ROOT / relative) == digest, relative
    prior = json.loads((ROOT / 'research/checkpoints/2026_09_07_uniform_moments/verification/manuscript_validation.json').read_text())
    unchanged_children = 0
    for relative, digest in prior['actual_tex_inputs_sha256'].items():
        if relative != 'paper/ChatGPT_ABC_Uniformity_2026.tex':
            assert sha(ROOT / relative) == digest, relative
            unchanged_children += 1
    assert unchanged_children == review['previous_unchanged_child_sources'] == 190
    for record in review['independent_review_records']:
        assert sha(ROOT / record['path']) == record['sha256']
    pages = len(PdfReader(pdf).pages)
    assert review['pages'] == pages and 1 in review['visually_reviewed_pages']
    assert len(build_sources) > 50 and len(review['visually_reviewed_pages']) >= 15
    prefix = review['unchanged_text_prefix_pages']
    assert set(range(prefix + 1, pages + 1)) <= set(review['visually_reviewed_pages'])
    previous = BUILD / 'previous_designated.pdf'
    assert sha(previous) == PREVIOUS_SHA
    previous_reader, current_reader = PdfReader(previous), PdfReader(pdf)
    assert all(previous_reader.pages[i].extract_text() == current_reader.pages[i].extract_text()
               for i in range(prefix)), 'Previously unchanged manuscript text differs'
    target = ROOT / 'output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf'
    assert sha(target) in {PREVIOUS_SHA, sha(pdf)}, 'Designated PDF changed independently'
    formal = json.loads((HERE / 'verification/mathlib_validation.json').read_text())
    assert formal['status'].startswith('PASS:')
    assert formal['new_declarations'] == 35 and formal['dependency_declarations'] == 15
    assert len(formal['modules']) == 4
    for entry in formal['modules'].values():
        assert sha(ROOT / entry['source']) == entry['sha256']
    finite = json.loads((HERE / 'verification/finite_replay_validation.json').read_text())
    assert finite['status'].startswith('PASS:') and len(finite['records']) == 2
    for record in finite['records']:
        for relative, digest in record['files_sha256'].items():
            assert sha(ROOT / relative) == digest, relative
    shutil.copyfile(pdf, target)
    assert sha(target) == review['pdf_sha256']
    result = {'status': 'PASS: full manuscript compiled and changed pages visually reviewed',
              'pdf': target.relative_to(ROOT).as_posix(), 'pages': pages,
              'pdf_bytes': target.stat().st_size, 'pdf_sha256': sha(target),
              'previous_sealed_pdf_sha256': PREVIOUS_SHA,
              'actual_tex_inputs_sha256': build_sources,
              'overfull_boxes': 0, 'unresolved_references_or_citations': 0,
              'visually_reviewed_pages': review['visually_reviewed_pages'],
              'unchanged_text_prefix_pages': prefix,
              'previous_unchanged_child_sources': unchanged_children,
              'root_actually_viewed_pages': review['root_actually_viewed_pages'],
              'independent_review_records': review['independent_review_records'],
              'raster_sha256': review['raster_sha256'],
              'formal_records': ['verification/mathlib_validation.json'],
              'not_claimed': ['ABC proof or disproof', 'all-page visual review',
                              'whole manuscript formalization', 'external peer review']}
    (HERE / 'verification/manuscript_validation.json').write_bytes(
        (json.dumps(result, indent=2) + '\n').encode('utf-8'))
    shutil.copyfile(BUILD / 'final-pass.txt', HERE / 'verification/manuscript-build.txt')
    print(json.dumps({k: result[k] for k in ['status', 'pdf', 'pages', 'pdf_sha256']}, indent=2))


if __name__ == '__main__':
    main()
