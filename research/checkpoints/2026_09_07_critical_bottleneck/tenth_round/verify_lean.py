#!/usr/bin/env python3
"""Fresh Lean 4.32.0 audit of reciprocal caps and the integer weighted ledger."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
OUT = HERE / 'verification'
SOURCES = {
    'EisensteinDescent': ROOT / 'research/checkpoints/2026_09_05_eisenstein_descent/Lean/EisensteinDescent.lean',
    'GeneralLucasBoundary': ROOT / 'research/checkpoints/2026_09_07_cyclotomic_covers/Lean/GeneralLucasBoundary.lean',
    'SignedArmArithmetic': ROOT / 'research/checkpoints/2026_09_07_critical_bottleneck/ninth_round/Lean/SignedArmArithmetic.lean',
    'ReciprocalDepthArithmetic': HERE / 'Lean/ReciprocalDepthArithmetic.lean',
}
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}


def save(name, obj):
    (OUT / name).write_bytes((json.dumps(obj, indent=2) + '\n').encode('utf-8'))


def main():
    OUT.mkdir(exist_ok=True)
    scratch = ROOT / 'tmp/abc_20260907'
    scratch.mkdir(parents=True, exist_ok=True)
    build = Path(tempfile.mkdtemp(prefix='reciprocal-depth-fresh-', dir=scratch))
    (build / 'lean-toolchain').write_bytes(b'leanprover/lean4:v4.32.0\n')
    roots = ', '.join(json.dumps(n) for n in SOURCES)
    (build / 'lakefile.toml').write_bytes((
        'name = "ReciprocalDepthFreshAudit"\nversion = "0.1.0"\n'
        'defaultTargets = ["ReciprocalDepthFreshAudit"]\n[leanOptions]\nwarningAsError = true\n'
        '[[lean_lib]]\nname = "ReciprocalDepthFreshAudit"\nroots = [' + roots + ']\n').encode())
    inventory = {}
    for name, source in SOURCES.items():
        data = source.read_bytes()
        code = data.decode('utf-8')
        assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', code, re.M)
        namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', code, re.M)
        queries = re.findall(r'^#print axioms\s+([\w.]+)', code, re.M)
        qualified = [q if '.' in q else namespace + '.' + q for q in queries]
        assert len(qualified) == len(set(qualified))
        assert set(qualified) == {namespace + '.' + d for d in declarations}
        shutil.copyfile(source, build / (name + '.lean'))
        assert (build / (name + '.lean')).read_bytes() == data
        inventory[name] = {'source': source.relative_to(ROOT).as_posix(),
                           'sha256': hashlib.sha256(data).hexdigest(),
                           'new': name == 'ReciprocalDepthArithmetic',
                           'theorems': len(declarations), 'queries': qualified}
    compiler = subprocess.check_output(['lean', '--version'], cwd=build, text=True).strip()
    assert 'version 4.32.0,' in compiler
    save('lean_validation.json', {'status': 'RUNNING', 'compiler': compiler, 'modules': inventory})
    process = subprocess.run(['lake', 'build'], cwd=build, capture_output=True, text=True)
    log = process.stdout + process.stderr
    (OUT / 'fresh-lake-build.log').write_bytes(log.encode('utf-8'))
    if process.returncode or 'sorryAx' in log or re.search(r'\berror:', log):
        save('lean_validation.json', {'status': 'FAIL', 'compiler': compiler, 'modules': inventory})
        raise SystemExit('Fresh build failed; inspect fresh-lake-build.log')
    union = set()
    for module in inventory.values():
        for query in module['queries']:
            stem = "'" + re.escape(query) + "' "
            match = re.search(stem + r'depends on axioms:\s*\[([^\]]*)\]', log)
            if match:
                axioms = {a.strip() for a in match.group(1).split(',') if a.strip()}
                assert axioms <= ALLOWED
                union |= axioms
            else:
                assert re.search(stem + 'does not depend on any axioms', log), query
    result = {'status': 'PASS: fresh scoped Lake build and complete axiom inventory',
              'compiler': compiler, 'command': ['lake', 'build'],
              'new_theorems': sum(v['theorems'] for v in inventory.values() if v['new']),
              'dependency_theorems': sum(v['theorems'] for v in inventory.values() if not v['new']),
              'axiom_union': sorted(union), 'modules': inventory,
              'not_claimed': ['full repository build', 'ABC',
                              'primitive unramified root implies primitive powers',
                              'polynomial quotient objects before specialization',
                              'cyclotomic prime valuations', 'real logarithmic weights',
                              'LR2 logarithmic-form estimates',
                              'general membership in the signed compensation criterion',
                              'common-exponent progression allocation']}
    save('lean_validation.json', result)
    print(json.dumps({k: v for k, v in result.items() if k != 'modules'}))


if __name__ == '__main__':
    main()
