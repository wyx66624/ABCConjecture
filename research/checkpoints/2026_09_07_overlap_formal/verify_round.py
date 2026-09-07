#!/usr/bin/env python3
"""Fresh scoped Lake build; never a claim of a full-repository or ABC proof."""
from pathlib import Path
import hashlib
import json
import os
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent / 'verification'
MODULES = {
    'EisensteinDescent': '2026_09_05_eisenstein_descent',
    'ExponentProfiles': '2026_09_06_exponent_profiles',
    'PowerDescent': '2026_09_05_power_descent',
    'OverlapColumns': '2026_09_07_overlap_formal',
    'CubicAmplification': '2026_09_07_adversarial_audit',
    'ProductTripodRectangle': '2026_09_07_independent_route',
}
NEW = {'OverlapColumns', 'CubicAmplification', 'ProductTripodRectangle'}
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}


def main():
    if os.name == 'nt':
        raise SystemExit('Run in the existing WSL/Linux environment; no toolchain changes are made.')
    OUT.mkdir(parents=True, exist_ok=True)
    scratch = ROOT / 'tmp' / 'abc_20260907'
    scratch.mkdir(parents=True, exist_ok=True)
    build = Path(tempfile.mkdtemp(prefix='fresh-lake-', dir=scratch))
    (build / 'lean-toolchain').write_text('leanprover/lean4:v4.32.0\n')
    (build / 'lakefile.toml').write_text('''name = "ABCResearchRound20260907"
version = "0.1.0"
defaultTargets = ["ResearchRound"]
[leanOptions]
warningAsError = true
[[lean_lib]]
name = "ResearchRound"
roots = ["EisensteinDescent", "ExponentProfiles", "PowerDescent", "OverlapColumns", "CubicAmplification", "ProductTripodRectangle"]
''')
    inventory = {}
    for name, checkpoint in MODULES.items():
        source = ROOT / 'research/checkpoints' / checkpoint / 'Lean' / (name + '.lean')
        data = source.read_bytes()
        text = data.decode('utf-8')
        if re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', text, re.M):
            raise AssertionError(f'Unapproved declaration/proof placeholder in {source}')
        namespace = re.search(r'^namespace\s+(\w+)', text, re.M).group(1)
        decls = re.findall(r'^(?:theorem|lemma)\s+(\w+)', text, re.M)
        raw_queries = re.findall(r'^#print axioms\s+([\w.]+)', text, re.M)
        queries = [q if '.' in q else namespace + '.' + q for q in raw_queries]
        assert len(queries) == len(set(queries)), name
        assert set(queries) == {namespace + '.' + d for d in decls}, name
        shutil.copyfile(source, build / (name + '.lean'))
        assert data == (build / (name + '.lean')).read_bytes()
        inventory[name] = {
            'source': source.relative_to(ROOT).as_posix(),
            'sha256': hashlib.sha256(data).hexdigest(),
            'theorems': len(decls), 'queries': queries, 'new': name in NEW,
        }
    compiler = subprocess.run(['lean', '--version'], cwd=build, check=True,
                              capture_output=True, text=True).stdout.strip()
    assert 'version 4.32.0,' in compiler, compiler
    proc = subprocess.run(['lake', 'build'], cwd=build, capture_output=True, text=True)
    log = proc.stdout + proc.stderr
    (OUT / 'fresh-lake-build.log').write_text(log)
    if proc.returncode or 'sorryAx' in log or re.search(r'\berror:', log):
        raise SystemExit(f'Fresh build failed ({proc.returncode}); inspect {OUT / "fresh-lake-build.log"}')
    union = set()
    for entry in inventory.values():
        for query in entry['queries']:
            stem = "'" + re.escape(query) + "' "
            match = re.search(stem + r'depends on axioms:\s*\[([^\]]*)\]', log)
            if match:
                axioms = {a.strip() for a in match.group(1).split(',') if a.strip()}
                assert axioms <= ALLOWED, (query, axioms)
                union |= axioms
            else:
                assert re.search(stem + 'does not depend on any axioms', log), query
    result = {
        'status': 'PASS: fresh scoped Lake build and complete theorem axiom inventory',
        'compiler': compiler, 'command': ['lake', 'build'],
        'new_theorems': sum(v['theorems'] for v in inventory.values() if v['new']),
        'dependency_theorems': sum(v['theorems'] for v in inventory.values() if not v['new']),
        'axiom_union': sorted(union), 'modules': inventory,
        'not_claimed': ['ABC proof or disproof', 'full repository build',
                        'analytic theorem formalization', 'geometric classification formalization',
                        'general radical compression formalization', 'external peer review'],
    }
    (OUT / 'lean_validation.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in ['status', 'compiler', 'new_theorems',
                                           'dependency_theorems', 'axiom_union']}, indent=2))


if __name__ == '__main__':
    main()
