#!/usr/bin/env python3
"""Fresh, scoped Std-only compilation of support and power-class arithmetic."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent / 'verification'
MODULES = {
    'EisensteinDescent': '2026_09_05_eisenstein_descent',
    'LocalPowerArithmetic': '2026_09_07_support_power_classes',
}
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    scratch = ROOT / 'tmp/abc_20260907'
    scratch.mkdir(parents=True, exist_ok=True)
    build = Path(tempfile.mkdtemp(prefix='support-power-fresh-', dir=scratch))
    (build / 'lean-toolchain').write_text('leanprover/lean4:v4.32.0\n')
    roots = ', '.join(json.dumps(n) for n in MODULES)
    (build / 'lakefile.toml').write_text(
        'name = "ABCSupportPowerAudit"\nversion = "0.1.0"\n'
        'defaultTargets = ["SupportPowerAudit"]\n[leanOptions]\nwarningAsError = true\n'
        '[[lean_lib]]\nname = "SupportPowerAudit"\nroots = [' + roots + ']\n')
    inventory = {}
    for name, checkpoint in MODULES.items():
        source = ROOT / 'research/checkpoints' / checkpoint / 'Lean' / (name + '.lean')
        data = source.read_bytes()
        code = data.decode('utf-8')
        assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', code, re.M), source
        namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', code, re.M)
        queries = re.findall(r'^#print axioms\s+([\w.]+)', code, re.M)
        qualified = [q if '.' in q else namespace + '.' + q for q in queries]
        assert len(qualified) == len(set(qualified)), name
        assert set(qualified) == {namespace + '.' + d for d in declarations}, name
        shutil.copyfile(source, build / (name + '.lean'))
        assert data == (build / (name + '.lean')).read_bytes()
        inventory[name] = {
            'source': source.relative_to(ROOT).as_posix(),
            'sha256': hashlib.sha256(data).hexdigest(),
            'theorems': len(declarations), 'queries': qualified,
            'new': name == 'LocalPowerArithmetic',
        }
    compiler = subprocess.check_output(['lean', '--version'], cwd=build, text=True).strip()
    assert 'version 4.32.0,' in compiler, compiler
    (OUT / 'lean_validation.json').write_bytes((json.dumps({
        'status': 'RUNNING: no successful result for these source bytes yet',
        'compiler': compiler, 'modules': inventory,
    }, indent=2) + '\n').encode())
    proc = subprocess.run(['lake', 'build'], cwd=build, capture_output=True, text=True)
    log = proc.stdout + proc.stderr
    (OUT / 'fresh-lake-build.log').write_bytes(log.encode())
    if proc.returncode or 'sorryAx' in log or re.search(r'\berror:', log):
        (OUT / 'lean_validation.json').write_bytes((json.dumps({
            'status': 'FAIL: fresh build did not verify these source bytes',
            'compiler': compiler, 'modules': inventory,
        }, indent=2) + '\n').encode())
        raise SystemExit(f'Fresh build failed; inspect {OUT / "fresh-lake-build.log"}')
    union = set()
    for module in inventory.values():
        for query in module['queries']:
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
                        'private-depth estimate', 'global probability transfer',
                        'complete fourth-round formalization', 'Hensel or Faltings theorem', 'finite Kummer descent', 'external peer review'],
    }
    (OUT / 'lean_validation.json').write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps({k: v for k, v in result.items() if k != 'modules'}, indent=2))


if __name__ == '__main__':
    main()
