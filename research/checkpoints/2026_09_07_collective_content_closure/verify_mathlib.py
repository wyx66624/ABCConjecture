#!/usr/bin/env python3
"""Fresh scoped source compilation against the exact pinned Mathlib cache.

The new arithmetic modules are compiled, including their explicit theorem
axiom queries. This does not rebuild all Mathlib or formalize the geometric
and analytic ordinary proofs that motivate these finite theorems.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
PIN = '81a5d257c8e410db227a6665ed08f64fea08e997'
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}
SOURCES = {
    'EisensteinDescent': ('2026_09_05_eisenstein_descent', False),
    'ActualGramRigidity': ('2026_09_07_signed_moment_descent', False),
    'ActualSignedProducts': ('2026_09_07_signed_moment_descent', False),
    'JointPhasePackets': ('2026_09_07_joint_packets_and_jacobians', False),
    'ComplementContent': ('2026_09_07_collective_content_closure', True),
    'SquarefreePowerExtraction': ('2026_09_07_collective_content_closure', True),
}


def main():
    initial_out = HERE / 'verification'
    initial_out.mkdir(exist_ok=True)
    (initial_out / 'mathlib_validation.json').write_text(
        json.dumps({'status': 'NOT_RUN: current invocation has not passed preflight or compilation'}) + '\n')
    (initial_out / 'fresh-mathlib-build.log').write_text('Current invocation: no compiler output yet.\n')
    parser = argparse.ArgumentParser()
    parser.add_argument('--project', type=Path, default=ROOT / 'Lean')
    args = parser.parse_args()
    project = args.project.resolve()
    mathlib = project / '.lake/packages/mathlib'
    rev = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=mathlib, text=True).strip()
    assert rev == PIN, rev
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD', '--', 'Mathlib', 'lean-toolchain'],
                   cwd=mathlib, check=True, capture_output=True)
    compiler = subprocess.check_output(['lake', 'env', 'lean', '--version'],
                                       cwd=project, text=True).strip()
    assert 'version 4.32.0,' in compiler, compiler
    build = Path(tempfile.mkdtemp(prefix='abc-collective-content-fresh-'))
    inventory = {}
    for name, (checkpoint, new) in SOURCES.items():
        source = ROOT / 'research/checkpoints' / checkpoint / 'Lean' / (name + '.lean')
        data = source.read_bytes()
        code = data.decode()
        assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', code, re.M)
        namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', code, re.M)
        queries = re.findall(r'^#print axioms\s+([\w.]+)', code, re.M)
        qualified = [q if '.' in q else namespace + '.' + q for q in queries]
        assert len(qualified) == len(set(qualified))
        assert set(qualified) == {namespace + '.' + d for d in declarations}
        (build / source.name).write_bytes(data)
        inventory[name] = dict(source=source.relative_to(ROOT).as_posix(),
                               sha256=hashlib.sha256(data).hexdigest(), new=new,
                               declarations=len(declarations), queries=qualified)
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    record = dict(status='RUNNING: no successful result for these source bytes yet',
                  compiler=compiler, mathlib_commit=rev, modules=inventory,
                  new_declarations=sum(m['declarations'] for m in inventory.values() if m['new']),
                  dependency_declarations=sum(m['declarations'] for m in inventory.values() if not m['new']))
    result_path = out / 'mathlib_validation.json'
    def save():
        result_path.write_bytes((json.dumps(record, indent=2) + '\n').encode())
    save()
    configured = json.loads(subprocess.check_output(['lake', 'env', sys.executable, '-c',
        'import os,json; print(json.dumps(dict(os.environ)))'], cwd=project, text=True))
    configured['LEAN_PATH'] = str(build) + os.pathsep + configured.get('LEAN_PATH', '')
    logs = []
    for name, module in inventory.items():
        source = build / (name + '.lean')
        command = ['lean', '--root=' + str(build), '-DwarningAsError=true',
                   '-o', str(build / (name + '.olean')), str(source)]
        proc = subprocess.run(command, cwd=project, env=configured, capture_output=True,
                              text=True, encoding='utf-8')
        logs.append(proc.stdout + proc.stderr)
        (out / 'fresh-mathlib-build.log').write_bytes(('\n'.join(logs)).encode())
        if proc.returncode or 'sorryAx' in logs[-1] or re.search(r'\berror:', logs[-1]):
            record['status'] = 'FAIL: fresh source compilation did not verify these bytes'
            save()
            raise SystemExit(logs[-1])
        assert (ROOT / module['source']).read_bytes() == source.read_bytes()
        assert hashlib.sha256(source.read_bytes()).hexdigest() == module['sha256']
    log = '\n'.join(logs)
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
    record.update(status='PASS: fresh scoped source compilation and complete axiom audit',
                  axiom_union=sorted(union),
                  dependency_build_scope='Pinned Mathlib compiled cache reused; listed source modules freshly compiled.',
                  not_claimed=['ABC proof or disproof', 'whole repository or Mathlib rebuild',
                               'actual aggregate prime profile and interval distribution', 'p-adic closure or height normalization',
                               'arbitrary-root signed membership',
                               'divisor asymptotics or sieve', 'complete rational locus formalization'])
    save()
    print(json.dumps({k: v for k, v in record.items() if k != 'modules'}, indent=2))


if __name__ == '__main__':
    main()
