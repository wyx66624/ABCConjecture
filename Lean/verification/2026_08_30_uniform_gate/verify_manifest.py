"""Verify this completed increment and replay the preceding historical snapshot.

--write records the explicitly scoped completed files; later Galois-lift work
is deliberately excluded and requires its own acceptance record.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
PREVIOUS = ROOT / 'Lean/verification/2026_08_30_continuation'
MANIFEST = HERE / 'SHA256SUMS'


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def manifest_entries(path: Path) -> list[tuple[str, str]]:
    return [tuple(line.split('  ', 1))
            for line in path.read_text(encoding='utf-8-sig').splitlines() if line]


def snapshot_files() -> list[Path]:
    files = {ROOT / name for _, name in manifest_entries(PREVIOUS / 'SHA256SUMS')}
    module_names = json.loads((HERE / 'declarations.json').read_text(encoding='utf-8-sig'))
    files.update(ROOT / 'Lean/IUTThreeClosures' / (name + '.lean') for name in module_names)
    files.add(ROOT / 'Lean/IUTThreeClosures/ResearchUniformGate20260830Audit.lean')
    reports = [
        'ABC_UNIFORM_GATE_2026_08_30.md',
        'ANALYTIC_ACTUAL_RADICAL_UNIFORM_GATE_2026_08_30.md',
        'GEOMETRY_GLOBAL_UNIFORM_GATE_2026_08_30.md',
        'GEOMETRY_COMMON_CURVE_SIEGEL_CROSS_REVIEW_2026_08_30.md',
        'IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md',
        'IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md',
        'UNIFORM_GATE_STRUCTURAL_TESTS_2026_08_30.md',
    ]
    files.update(ROOT / 'research' / name for name in reports)
    files.update((ROOT / 'paper').glob('uniform_gate_*.tex'))
    for directory in [
        ROOT / 'research/sources/uniform_gate_2026_08_30',
        ROOT / 'research/sources/global_uniform_gate_2026_08_30',
        PREVIOUS,
        HERE,
    ]:
        files.update(p for p in directory.rglob('*')
                     if p.is_file() and p != MANIFEST and '__pycache__' not in p.parts)
    return sorted(files, key=lambda p: p.relative_to(ROOT).as_posix())


def verify_entries(entries: list[tuple[str, str]], remapping: dict[str, str] | None = None):
    mapping = remapping or {}
    seen: set[str] = set()
    failures: list[str] = []
    for expected, name in entries:
        actual_name = mapping.get(name, name)
        path = (ROOT / actual_name).resolve()
        if not path.is_relative_to(ROOT.resolve()):
            failures.append(f'Path leaves repository: {actual_name}')
            continue
        if name in seen:
            failures.append(f'Duplicate entry: {name}')
        seen.add(name)
        if not path.is_file():
            failures.append(f'Missing file: {actual_name}')
        elif digest(path) != expected:
            failures.append(f'Hash mismatch: {name} -> {actual_name}')
    return failures


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    if args.write:
        MANIFEST.write_text(''.join(f'{digest(p)}  {p.relative_to(ROOT).as_posix()}\n'
                                    for p in snapshot_files()), encoding='utf-8')
    entries = manifest_entries(MANIFEST)
    failures = verify_entries(entries)
    previous_entries = manifest_entries(PREVIOUS / 'SHA256SUMS')
    mapping = json.loads((HERE / 'previous-manifest-map.json').read_text(encoding='utf-8-sig'))
    previous_failures = verify_entries(previous_entries, mapping)
    summary = json.loads((HERE / 'validation_summary.json').read_text(encoding='utf-8-sig'))
    if digest(ROOT / 'output/pdf/ChatGPT_ABC_Uniformity_2026.pdf') != summary['pdf_sha256']:
        failures.append('PDF differs from the visually reviewed artifact')
    if summary.get('inspected_pages') != list(range(1, summary['pdf_pages'] + 1)):
        failures.append('PDF visual inspection is incomplete')
    if summary.get('unexpected_axioms') or summary.get('audit_has_sorryAx'):
        failures.append('Recorded declaration audit has an unexpected dependency')
    if summary.get('audited_declaration_count') != 89:
        failures.append('Wrong new declaration count')
    if summary.get('standard_abc_proof_or_disproof') is not False:
        failures.append('Acceptance record overstates the ABC conclusion')
    print(json.dumps({'checked_files': len(entries), 'failures': failures,
                      'previous_checked_files': len(previous_entries),
                      'previous_remapped_paths': len(mapping),
                      'previous_failures': previous_failures}, ensure_ascii=False))
    if failures or previous_failures:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
