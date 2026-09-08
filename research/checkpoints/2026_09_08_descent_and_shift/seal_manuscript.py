#!/usr/bin/env python3
"""Install the rebuilt manuscript only after bound source and visual reviews."""
from pathlib import Path
import hashlib
import json
import re
import shutil
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
BUILD = ROOT / 'tmp/abc_20260908/descent_shift_pdf'
PREVIOUS_SHA = '60732f02f13a00b3f8c057d5cdd9038f1ea39a7d3355cedaec5c223e11de9a72'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text(encoding='utf-8'))


def check_files(files):
    for relative, digest in files.items():
        if sha(ROOT / relative) != digest:
            raise ValueError('Reviewed bytes changed: ' + relative)


def main():
    pdf = BUILD / 'ChatGPT_ABC_Uniformity_2026.pdf'
    log = (BUILD / 'final-pass.txt').read_text(encoding='utf-8')
    if re.search(r'Overfull \\[hv]box|undefined|multiply defined|^!', log, re.M):
        raise ValueError('Manuscript has a layout or reference error')
    sources = read(BUILD / 'final_source_inventory.json')
    check_files(sources)
    if len(sources) != 240:
        raise ValueError('Unexpected full TeX input set')
    ordinary = read(HERE / 'verification/ordinary_source_inventory.json')
    check_files(ordinary)
    if len(ordinary) != 7:
        raise ValueError('Unexpected ordinary proof inventory')
    prior = read(ROOT / 'research/checkpoints/2026_09_08_fixed_curve_closure/verification/manuscript_validation.json')
    unchanged = {p: d for p, d in prior['actual_tex_inputs_sha256'].items()
                 if p != 'paper/ChatGPT_ABC_Uniformity_2026.tex'}
    check_files(unchanged)
    if len(unchanged) != 231:
        raise ValueError('Unexpected prior child source set')
    previous = BUILD / 'previous_designated.pdf'
    if sha(previous) != PREVIOUS_SHA:
        raise ValueError('Previous PDF differs')
    old, new = PdfReader(previous), PdfReader(pdf)
    visual = read(BUILD / 'visual_review.json')
    if visual['status'] != 'PASS: changed pages visually reviewed':
        raise ValueError('No completed visual review')
    if visual['pdf_sha256'] != sha(pdf) or visual['pages'] != len(new.pages):
        raise ValueError('Visual review belongs to another PDF')
    prefix = visual['unchanged_text_prefix_pages']
    if prefix < 580 or not all(old.pages[i].extract_text() == new.pages[i].extract_text()
                              for i in range(prefix)):
        raise ValueError('Previous text prefix differs')
    reviewed = set(visual['visually_reviewed_pages'])
    if 1 not in reviewed or not set(range(prefix + 1, len(new.pages) + 1)) <= reviewed:
        raise ValueError('Not every changed page was visually inspected')
    check_files(visual['raster_sha256'])
    check_files(visual['independent_review_records_sha256'])
    transcription = read(HERE / 'verification/transcription_review.json')
    if transcription['status'] != 'PASS: complete ordinary-to-TeX review':
        raise ValueError('Transcription review incomplete')
    check_files(transcription['tex_sha256'])
    check_files(transcription['independent_review_records_sha256'])
    expected_sources = set(unchanged) | set(transcription['tex_sha256'])
    if set(sources) != expected_sources:
        raise ValueError('Actual input set differs from old sources and reviewed new inputs')
    formal = read(HERE / 'verification/mathlib_validation.json')
    if not formal['status'].startswith('PASS:') or formal['new_declarations'] != 15:
        raise ValueError('New formal scope has not passed')
    if formal['dependency_declarations'] != 0 or len(formal['modules']) != 1:
        raise ValueError('Formal scope differs')
    for module in formal['modules'].values():
        check_files({module['source']: module['sha256']})
        if len(module['queries']) != 15:
            raise ValueError('Axiom query coverage differs')
    if set(formal['axiom_union']) != {'propext', 'Classical.choice', 'Quot.sound'}:
        raise ValueError('Unapproved formal axiom')
    finite = read(HERE / 'verification/finite_replay_validation.json')
    finite_inputs = HERE / 'verification/finite_input_inventory.json'
    if not finite['status'].startswith('PASS:') or len(finite['records']) != 2:
        raise ValueError('Finite replay scope has not passed')
    if finite['input_inventory_sha256'] != sha(finite_inputs):
        raise ValueError('Finite inventory differs from actual run')
    check_files(read(finite_inputs)['files_sha256'])
    target = ROOT / 'output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf'
    if sha(target) not in {PREVIOUS_SHA, sha(pdf)}:
        raise ValueError('Designated PDF changed independently')
    shutil.copyfile(pdf, target)
    record = dict(status='PASS: complete manuscript build, source review and changed-page visual review',
                  pdf=target.relative_to(ROOT).as_posix(), pages=len(new.pages),
                  pdf_bytes=target.stat().st_size, pdf_sha256=sha(target),
                  previous_sealed_pdf_sha256=PREVIOUS_SHA,
                  actual_tex_inputs_sha256=sources, previous_unchanged_child_sources=231,
                  unchanged_text_prefix_pages=prefix, visually_reviewed_pages=sorted(reviewed),
                  raster_sha256=visual['raster_sha256'],
                  independent_review_records_sha256=visual['independent_review_records_sha256'],
                  overfull_boxes=0, unresolved_references_or_citations=0,
                  ordinary_proof_sources=7, new_lean_declarations=15, exact_finite_replays=2,
                  not_claimed=['ABC proof or disproof', 'complete rational-locus Lean chain',
                               'all-page visual review', 'external peer review'])
    (HERE / 'verification/manuscript_validation.json').write_text(
        json.dumps(record, indent=2) + '\n', encoding='utf-8')
    shutil.copyfile(BUILD / 'final-pass.txt', HERE / 'verification/manuscript-build.txt')
    print(json.dumps({k: record[k] for k in ['status', 'pages', 'pdf_sha256']}, indent=2))


if __name__ == '__main__':
    main()
