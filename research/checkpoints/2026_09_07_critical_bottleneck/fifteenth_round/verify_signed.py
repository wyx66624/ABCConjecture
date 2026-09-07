#!/usr/bin/env python3
"""Fresh bounded signed-moment arithmetic and complete axiom queries.

Pinned Mathlib dependency oleans are reused. No whole-repository or
whole-Mathlib rebuild is claimed. Run under WSL with Lean 4.32.0.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[4]
HERE = Path(__file__).resolve().parent
PIN = '81a5d257c8e410db227a6665ed08f64fea08e997'
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}
SOURCES = {
    'UniformMomentArithmetic': HERE.parent / 'thirteenth_round/Lean/UniformMomentArithmetic.lean',
    'AdaptiveOwnerArithmetic': HERE.parent / 'fourteenth_round/Lean/AdaptiveOwnerArithmetic.lean',
    'SignedMomentArithmetic': HERE / 'Lean/SignedMomentArithmetic.lean',
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--project', type=Path, default=ROOT / 'Lean')
    args = parser.parse_args()
    project = args.project.resolve()
    mathlib = project / '.lake/packages/mathlib'
    rev = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=mathlib, text=True).strip()
    assert rev == PIN, rev
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD', '--', 'Mathlib', 'lean-toolchain'],
                   cwd=mathlib, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    compiler = subprocess.check_output(['lake', 'env', 'lean', '--version'], cwd=project, text=True).strip()
    assert 'version 4.32.0,' in compiler, compiler
    scratch = ROOT / 'tmp/abc_20260907'
    scratch.mkdir(parents=True, exist_ok=True)
    build = Path(tempfile.mkdtemp(prefix='signed-moment-fresh-', dir=scratch))
    modules = {}
    for name, source in SOURCES.items():
        data = source.read_bytes()
        code = data.decode('utf-8-sig')
        assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', code, re.M)
        namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', code, re.M)
        queries = re.findall(r'^#print axioms\s+(\w+)', code, re.M)
        assert len(queries) == len(set(queries)) and set(queries) == set(declarations)
        (build / source.name).write_bytes(data)
        modules[name] = dict(source=source.relative_to(ROOT).as_posix(),
                            sha256=hashlib.sha256(data).hexdigest(),
                            new=(name == 'SignedMomentArithmetic'),
                            declarations=len(declarations),
                            queries=[namespace+'.'+q for q in queries])
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    record = dict(status='RUNNING: fresh source compilation not yet successful',
                  compiler=compiler, mathlib_commit=rev,
                  new_declarations=sum(m['declarations'] for m in modules.values() if m['new']),
                  dependency_declarations=sum(m['declarations'] for m in modules.values() if not m['new']),
                  modules=modules)
    result_path = out / 'signed_validation.json'
    result_path.write_bytes((json.dumps(record, indent=2)+'\n').encode())
    configured = json.loads(subprocess.check_output(['lake', 'env', 'python3', '-c',
        'import os,json; print(json.dumps(dict(os.environ)))'], cwd=project, text=True))
    configured['LEAN_PATH'] = str(build)+os.pathsep+configured.get('LEAN_PATH', '')
    logs = []
    for name, module in modules.items():
        copied = build / (name+'.lean')
        command = ['lean', '--root='+str(build), '-DwarningAsError=true', '-o',
                   str(build/(name+'.olean')), str(copied)]
        proc = subprocess.run(command, cwd=project, env=configured, capture_output=True, text=True)
        current = proc.stdout+proc.stderr
        logs.append(current)
        if proc.returncode or 'sorryAx' in current or re.search(r'\berror:', current):
            (out / 'signed-lean.log').write_bytes(('\n'.join(logs)).encode())
            record['status'] = 'FAIL: these source bytes were not verified'
            result_path.write_bytes((json.dumps(record, indent=2)+'\n').encode())
            raise SystemExit(current)
        assert hashlib.sha256(copied.read_bytes()).hexdigest() == module['sha256']
        assert (ROOT / module['source']).read_bytes() == copied.read_bytes()
    log = '\n'.join(logs)
    (out / 'signed-lean.log').write_bytes(log.encode())
    union = set()
    for query in [q for module in modules.values() for q in module['queries']]:
        match = re.search("'"+re.escape(query)+r"' depends on axioms:\s*\[([^\]]*)\]", log)
        if match:
            axioms = {x.strip() for x in match.group(1).split(',') if x.strip()}
        else:
            assert re.search("'"+re.escape(query)+"' does not depend on any axioms", log), query
            axioms = set()
        assert axioms <= ALLOWED, (query, axioms)
        union |= axioms
    record.update(status='PASS: fresh signed-moment finite arithmetic, complete axiom audit',
                  axiom_union=sorted(union),
                  dependency_build_scope='Fresh compilation of the listed local sources; pinned Mathlib dependency cache reused.',
                  not_claimed=['ABC proof or disproof', 'whole repository or Mathlib rebuild',
                               'finite-field torsion, lifting, or private norm construction', 'Brun--Titchmarsh or divisor asymptotics',
                               'uniform tuple determinant or density proof', 'actual tail membership or exceptional-root control'])
    result_path.write_bytes((json.dumps(record, indent=2)+'\n').encode())
    print(json.dumps({k: v for k, v in record.items() if k != 'modules'}, indent=2))


if __name__ == '__main__':
    main()
