#!/usr/bin/env python3
"""Publish the final PDF only after byte-bound mathematical and visual review."""
from pathlib import Path
import hashlib
import json
import re
import shutil
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
BUILD = ROOT / 'tmp/abc_20260907/round17pdf'
PREVIOUS_SHA = 'aec9b8b9f59fd51d8830abcaaab64dd15f69e0248064d09ea9b042f247cc6cd7'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    pdf = BUILD / 'ChatGPT_ABC_Uniformity_2026.pdf'
    log = (BUILD / 'final-pass.txt').read_text(encoding='utf-8')
    assert not re.search(r'Overfull \\[hv]box|undefined|multiply defined|^!', log, re.M)
    review = json.loads((BUILD / 'visual_review.json').read_text(encoding='utf-8'))
    sources = json.loads((BUILD / 'final_source_inventory.json').read_text())
    assert review['pdf_sha256'] == sha(pdf)
    assert review['status'] == 'PASS: changed pages visually reviewed'
    for relative, digest in review['raster_sha256'].items():
        assert sha(ROOT / relative) == digest, relative
    for relative, digest in sources.items():
        assert sha(ROOT / relative) == digest, relative
    ordinary = json.loads((HERE / 'verification/ordinary_source_inventory.json').read_text())
    for relative,digest in ordinary.items():
        assert sha(ROOT / relative) == digest, relative
    prior = json.loads((ROOT / 'research/checkpoints/2026_09_07_joint_packets_and_jacobians/verification/manuscript_validation.json').read_text())
    unchanged = 0
    for relative, digest in prior['actual_tex_inputs_sha256'].items():
        if relative != 'paper/ChatGPT_ABC_Uniformity_2026.tex':
            assert sha(ROOT / relative) == digest, relative
            unchanged += 1
    assert unchanged == review['previous_unchanged_child_sources'] == 207
    for record in review['independent_review_records']:
        assert sha(ROOT / record['path']) == record['sha256'], record['path']
    pages = len(PdfReader(pdf).pages)
    assert review['pages'] == pages and 1 in review['visually_reviewed_pages']
    assert set(review['root_actually_viewed_pages']) <= set(review['visually_reviewed_pages'])
    assert len(sources) == 217
    prefix = review['unchanged_text_prefix_pages']
    assert prefix >= 530
    assert set(range(prefix + 1, pages + 1)) <= set(review['visually_reviewed_pages'])
    previous = BUILD / 'previous_designated.pdf'
    assert sha(previous) == PREVIOUS_SHA
    old, new = PdfReader(previous), PdfReader(pdf)
    assert all(old.pages[i].extract_text() == new.pages[i].extract_text()
               for i in range(prefix)), 'Previously unchanged manuscript text differs'
    target = ROOT / 'output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf'
    assert sha(target) in {PREVIOUS_SHA, sha(pdf)}, 'Designated PDF changed independently'
    formal = json.loads((HERE / 'verification/mathlib_validation.json').read_text())
    assert formal['status'].startswith('PASS:')
    assert formal['new_declarations'] == 40 and formal['dependency_declarations'] == 55
    assert len(formal['modules']) == 6
    for entry in formal['modules'].values():
        assert sha(ROOT / entry['source']) == entry['sha256'], entry['source']
    finite = json.loads((HERE / 'verification/finite_replay_validation.json').read_text())
    assert finite['status'].startswith('PASS:') and len(finite['records']) == 8
    for record in finite['records']:
        for relative, digest in record['files_sha256'].items():
            assert sha(ROOT / relative) == digest, relative
    shutil.copyfile(pdf, target)
    assert sha(target) == review['pdf_sha256']
    result = {
        'status': 'PASS: full manuscript compiled and changed pages visually reviewed',
        'pdf': target.relative_to(ROOT).as_posix(), 'pages': pages,
        'pdf_bytes': target.stat().st_size, 'pdf_sha256': sha(target),
        'previous_sealed_pdf_sha256': PREVIOUS_SHA,
        'actual_tex_inputs_sha256': sources,
        'overfull_boxes': 0, 'unresolved_references_or_citations': 0,
        'visually_reviewed_pages': review['visually_reviewed_pages'],
        'unchanged_text_prefix_pages': prefix,
        'previous_unchanged_child_sources': unchanged,
        'root_actually_viewed_pages': review['root_actually_viewed_pages'],
        'independent_review_records': review['independent_review_records'],
        'raster_sha256': review['raster_sha256'],
        'formal_records': ['verification/mathlib_validation.json'],
        'finite_records': ['verification/finite_replay_validation.json'],
        'not_claimed': ['ABC proof or disproof', 'all-page visual review',
                        'whole manuscript formalization', 'external peer review']}
    (HERE / 'verification/manuscript_validation.json').write_bytes(
        (json.dumps(result, indent=2) + '\n').encode('utf-8'))
    shutil.copyfile(BUILD / 'final-pass.txt', HERE / 'verification/manuscript-build.txt')
    print(json.dumps({k: result[k] for k in ['status','pdf','pages','pdf_sha256']}, indent=2))


if __name__ == '__main__':
    main()
