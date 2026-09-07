#!/usr/bin/env python3
"""Compile exact new files and two original dependencies into fresh olean outputs.

Invoke from Lean with: lake env python3 ../research/checkpoints/
2026_09_07_radical_transport/verify_mathlib.py
Uses the pinned installed Mathlib environment. This is not a full repository build.
"""
from pathlib import Path
import hashlib
import json
import os
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
MODULES = [
    ('IUTThreeClosures.DivisionPolynomialTwoTorsionNumerics',
     ROOT / 'Lean/IUTThreeClosures/DivisionPolynomialTwoTorsionNumerics.lean', False),
    ('IUTThreeClosures.ABCStatement', ROOT / 'Lean/IUTThreeClosures/ABCStatement.lean', False),
    ('RadicalTransport', HERE / 'Lean/RadicalTransport.lean', True),
    ('TwoStepABCObstruction', HERE / 'Lean/TwoStepABCObstruction.lean', True),
]
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}
MATHLIB_REVISION = '81a5d257c8e410db227a6665ed08f64fea08e997'


def main():
    if os.name == 'nt' or not os.environ.get('LEAN_PATH'):
        raise SystemExit('Use lake env python3 in the existing WSL/Linux Lean directory.')
    scratch_root = ROOT / 'tmp/abc_20260907'
    scratch_root.mkdir(parents=True, exist_ok=True)
    scratch = Path(tempfile.mkdtemp(prefix='fresh-radical-', dir=scratch_root))
    env = os.environ.copy()
    env['LEAN_PATH'] = str(scratch) + os.pathsep + env['LEAN_PATH']
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    logs = []
    inventory = {}
    all_queries = []
    for name, source, is_new in MODULES:
        data = source.read_bytes()
        text = data.decode('utf-8')
        namespace = re.search(r'^namespace\s+(\w+)', text, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', text, re.M)
        queries = [namespace + '.' + d for d in declarations]
        all_queries.extend(queries)
        if is_new:
            assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', text, re.M)
            prints = re.findall(r'^#print axioms\s+([\w.]+)', text, re.M)
            assert set(prints) == set(queries) and len(prints) == len(queries), name
        target = scratch / (name.replace('.', '/') + '.olean')
        target.parent.mkdir(parents=True, exist_ok=True)
        command = ['lean', '-DwarningAsError=true', '-o', str(target), str(source)]
        proc = subprocess.run(command, cwd=ROOT, env=env, capture_output=True, text=True)
        log = proc.stdout + proc.stderr
        logs.append(log)
        (out / 'fresh-compiler.log').write_text('\n'.join(logs), encoding='utf-8')
        if proc.returncode or 'sorryAx' in log or re.search(r'\berror:', log):
            raise SystemExit(log)
        inventory[name] = {'source': source.relative_to(ROOT).as_posix(),
                           'sha256': hashlib.sha256(data).hexdigest(),
                           'theorems': len(queries), 'new': is_new}
    audit = scratch / 'AxiomAudit.lean'
    audit.write_text('\n'.join('import ' + name for name, _, _ in MODULES) + '\n' +
                     '\n'.join('#print axioms ' + q for q in all_queries) + '\n')
    proc = subprocess.run(['lean', '-DwarningAsError=true', str(audit)],
                          cwd=ROOT, env=env, capture_output=True, text=True)
    audit_log = proc.stdout + proc.stderr
    logs.append(audit_log)
    (out / 'fresh-compiler.log').write_text('\n'.join(logs), encoding='utf-8')
    assert proc.returncode == 0 and 'sorryAx' not in audit_log, audit_log
    union = set()
    for query in all_queries:
        stem = "'" + re.escape(query) + "' "
        match = re.search(stem + r'depends on axioms:\s*\[([^\]]*)\]', audit_log)
        if match:
            axioms = {a.strip() for a in match.group(1).split(',') if a.strip()}
            assert axioms <= ALLOWED, (query, axioms)
            union |= axioms
        else:
            assert re.search(stem + 'does not depend on any axioms', audit_log), query
    compiler = subprocess.check_output(['lean', '--version'], env=env, text=True).strip()
    assert 'version 4.32.0,' in compiler, compiler
    manifest = json.loads((ROOT / 'Lean/lake-manifest.json').read_text())
    mathlib = next(p for p in manifest['packages'] if p['name'] == 'mathlib')['rev']
    actual = subprocess.check_output(['git', 'rev-parse', 'HEAD'],
        cwd=ROOT / 'Lean/.lake/packages/mathlib', text=True).strip()
    assert actual == mathlib == MATHLIB_REVISION, (actual, mathlib, MATHLIB_REVISION)
    result = {'status': 'PASS: fresh compiler outputs and complete theorem axiom audit',
              'compiler': compiler, 'mathlib_revision': mathlib, 'modules': inventory,
              'new_theorems': sum(v['theorems'] for v in inventory.values() if v['new']),
              'dependency_theorems': sum(v['theorems'] for v in inventory.values() if not v['new']),
              'axiom_union': sorted(union),
              'not_claimed': ['existence of the unbounded two-norm gate family',
                              'ABC proof or disproof', 'full repository build',
                              'fresh build of all Mathlib source']}
    (out / 'lean_validation.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
