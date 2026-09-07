#!/usr/bin/env python3
"""Seal the reviewed US paper and 22 finite theorems, excluding later work."""
from pathlib import Path
import argparse
import hashlib
import json

HERE = Path(__file__).resolve().parent
FILES = [
    'README.md',
    'review.md',
    'unit_signed_moments.md',
    'ordinary_signed_scope.md',
    'formal_completion.md',
    'Lean/SignedMomentArithmetic.lean',
    'paper/unit_signed_moments.tex',
    'verify_signed.py',
    'verification/signed_validation.json',
    'verification/signed-lean.log',
    'seal_sources.py',
]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--write', action='store_true')
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    assert args.write != args.check, 'Choose exactly one mode'
    manifest = json.loads((HERE / 'verification/signed_validation.json').read_bytes())
    assert manifest['status'].startswith('PASS:')
    assert manifest['new_declarations'] == 22
    assert manifest['dependency_declarations'] == 27
    data = {name: (HERE / name).read_bytes() for name in FILES}
    source_hash = hashlib.sha256(data['Lean/SignedMomentArithmetic.lean']).hexdigest()
    assert source_hash == manifest['modules']['SignedMomentArithmetic']['sha256']
    for name, value in data.items():
        if name.endswith('.tex'):
            assert not any(byte < 32 and byte not in (9, 10, 13) for byte in value), name
    record = {
        'scope': 'Reviewed US ordinary paper and 22 finite signed-moment theorems; no later candidates.',
        'source_files': [
            {'path': name, 'bytes': len(data[name]),
             'sha256': hashlib.sha256(data[name]).hexdigest()}
            for name in FILES
        ],
        'new_theorems': 22,
        'old_local_dependency_theorems_freshly_compiled': 27,
        'excluded': ['sixteenth-round candidates', 'rendered PDF visual QA',
                     'global ABC proof', 'complete residue-torsion construction'],
    }
    payload = (json.dumps(record, indent=2) + '\n').encode('utf-8')
    target = HERE / 'source_evidence.json'
    if args.write:
        target.write_bytes(payload)
    else:
        assert target.read_bytes() == payload, 'Delivery bytes differ from the seal'
    print(json.dumps({'status': 'PASS', 'files': len(FILES),
                      'mode': 'write' if args.write else 'check',
                      'source_evidence_sha256': hashlib.sha256(payload).hexdigest()}))


if __name__ == '__main__':
    main()
