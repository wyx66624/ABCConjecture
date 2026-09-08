#!/usr/bin/env python3
"""Check literal release bytes and optional Git index; no proof-status inference."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
PREFIX = HERE.relative_to(ROOT).as_posix()


def read(relative):
    return json.loads((ROOT / relative).read_text(encoding='utf-8-sig'))


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--staged', action='store_true')
    args = parser.parse_args()
    inventory_path = PREFIX + '/verification/publication_inventory.json'
    inventory = read(inventory_path)
    bindings = dict(inventory['files_sha256'])

    def merge(values):
        for path, expected in values.items():
            if path in bindings and bindings[path] != expected:
                raise ValueError('Conflicting byte binding: ' + path)
            bindings[path] = expected

    merge(read(PREFIX + '/verification/ordinary_source_inventory.json'))
    transfer = read(PREFIX + '/verification/transcription_review.json')
    merge(transfer['tex_sha256'])
    merge(transfer['independent_review_records_sha256'])
    merge(read(PREFIX + '/verification/finite_input_inventory.json')['files_sha256'])
    merge(read(PREFIX + '/root_review_receipt.json')['files_sha256'])
    manuscript = read(PREFIX + '/verification/manuscript_validation.json')
    merge(manuscript['actual_tex_inputs_sha256'])
    merge(manuscript['independent_review_records_sha256'])
    merge({manuscript['pdf']: manuscript['pdf_sha256']})
    geometry = read(PREFIX + '/geometry_source_inventory.json')
    for key in ('tex_inputs', 'ordinary_sources', 'finite_dependencies'):
        merge({item['path']: item['sha256'] for item in geometry[key]})
    review = read('research/checkpoints/2026_09_07_adversarial_audit/'
                  'nineteenth_round/next_descent_shift_ci_review.json')
    merge(review['source_hashes'])
    formal = read(PREFIX + '/verification/mathlib_validation.json')
    merge({item['source']: item['sha256'] for item in formal['modules'].values()})

    assert len(inventory['files_sha256']) == inventory['file_count']
    assert len(manuscript['actual_tex_inputs_sha256']) == 240
    assert manuscript['pages'] == 621 and manuscript['ordinary_proof_sources'] == 7
    assert manuscript['new_lean_declarations'] == formal['new_declarations'] == 15
    assert manuscript['exact_finite_replays'] == 2
    for path, expected in bindings.items():
        assert digest((ROOT / path).read_bytes()) == expected, 'Working bytes changed: ' + path

    if args.staged:
        def git(*command):
            return subprocess.check_output(['git', *command], cwd=ROOT)
        actual = set(git('diff', '--cached', '--name-only', '-z').decode().split('\0')) - {''}
        expected = set(inventory['files_sha256']) | {inventory_path}
        assert actual == expected, ('Unexpected staged paths', actual ^ expected)
        for path, expected_hash in bindings.items():
            assert digest(git('show', ':' + path)) == expected_hash, 'Index bytes changed: ' + path
        assert git('show', ':' + inventory_path) == (ROOT / inventory_path).read_bytes()
        assert git('rev-parse', 'HEAD').decode().strip() == inventory['previous_main']
        assert git('rev-parse', 'origin/main').decode().strip() == inventory['previous_main']
        subprocess.run(['git', 'diff', '--cached', '--check'], cwd=ROOT, check=True)

    print(json.dumps({'status': 'PASS: literal byte and scope audit',
                      'release_files_excluding_inventory': inventory['file_count'],
                      'checked_byte_bindings': len(bindings),
                      'staged_checked': args.staged,
                      'not_claimed': 'Mathematical proof verification or GitHub CI success'}))


if __name__ == '__main__':
    main()
