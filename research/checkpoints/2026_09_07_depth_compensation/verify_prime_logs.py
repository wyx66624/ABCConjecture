#!/usr/bin/env python3
"""Compile the actual prime-log module from fresh source bytes against pinned Mathlib.

The dependency environment is the repository's existing Lean project by
default, or --project for a standalone pinned Mathlib checkout in CI.
Mathlib dependency oleans are reused; no whole-Mathlib source rebuild is claimed.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
PIN = '81a5d257c8e410db227a6665ed08f64fea08e997'
ALLOWED = {'propext','Classical.choice','Quot.sound'}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--project', type=Path, default=ROOT / 'Lean')
    args = parser.parse_args()
    project = args.project.resolve()
    mathlib = project / '.lake/packages/mathlib'
    rev = subprocess.check_output(['git','rev-parse','HEAD'], cwd=mathlib, text=True).strip()
    assert rev == PIN, rev
    subprocess.run(['git','diff','--exit-code','HEAD','--','Mathlib','lean-toolchain'], cwd=mathlib, check=True,
                   stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    compiler = subprocess.check_output(['lake','env','lean','--version'], cwd=project, text=True).strip()
    assert 'version 4.32.0,' in compiler, compiler
    scratch = ROOT / 'tmp/abc_20260907'
    scratch.mkdir(parents=True, exist_ok=True)
    build = Path(tempfile.mkdtemp(prefix='actual-prime-log-fresh-', dir=scratch))
    modules = {}
    for name in ['ActualPrimeLogCompensation', 'ActualPrimeLogHeight']:
        source = HERE / 'Lean' / (name+'.lean')
        data = source.read_bytes()
        code = data.decode()
        assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', code, re.M)
        namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', code, re.M)
        queries = re.findall(r'^#print axioms\s+(\w+)', code, re.M)
        assert len(queries) == len(set(queries)) and set(queries) == set(declarations)
        (build / source.name).write_bytes(data)
        modules[name] = dict(source=source.relative_to(ROOT).as_posix(),
                            sha256=hashlib.sha256(data).hexdigest(),
                            declarations=len(declarations),
                            queries=[namespace+'.'+q for q in queries])
    out = HERE / 'verification'
    out.mkdir(exist_ok=True)
    record = dict(status='RUNNING: fresh source compilation not yet successful',
                  compiler=compiler, mathlib_commit=rev,
                  declarations=sum(m['declarations'] for m in modules.values()), modules=modules)
    result_path = out / 'prime_log_validation.json'
    result_path.write_text(json.dumps(record, indent=2)+'\n')
    # Capture the configured environment internally, never print its contents.
    configured = json.loads(subprocess.check_output(['lake','env','python3','-c',
        'import os,json; print(json.dumps(dict(os.environ)))'], cwd=project, text=True))
    configured['LEAN_PATH'] = str(build)+os.pathsep+configured.get('LEAN_PATH','')
    logs = []
    for name, module in modules.items():
        copied = build / (name+'.lean')
        command = ['lean','--root='+str(build),'-DwarningAsError=true','-o',str(build/(name+'.olean')),str(copied)]
        proc = subprocess.run(command, cwd=project, env=configured, capture_output=True, text=True)
        current = proc.stdout+proc.stderr
        logs.append(current)
        if proc.returncode or 'sorryAx' in current or re.search(r'\berror:',current):
            (out / 'prime-log-lean.log').write_bytes(('\n'.join(logs)).encode())
            record['status'] = 'FAIL: fresh source compilation did not verify these bytes'
            result_path.write_text(json.dumps(record, indent=2)+'\n')
            raise SystemExit(current)
        assert hashlib.sha256(copied.read_bytes()).hexdigest() == module['sha256']
        assert (ROOT / module['source']).read_bytes() == copied.read_bytes()
    log = '\n'.join(logs)
    (out / 'prime-log-lean.log').write_bytes(log.encode())
    union = set()
    for query in [q for module in modules.values() for q in module['queries']]:
        match = re.search("'"+re.escape(query)+r"' depends on axioms:\s*\[([^\]]*)\]", log)
        assert match, query
        axioms = {x.strip() for x in match.group(1).split(',') if x.strip()}
        assert axioms <= ALLOWED, (query, axioms)
        union |= axioms
    record.update(status='PASS: fresh actual-prime-log source compilation and complete axiom audit',
                  axiom_union=sorted(union),
                  dependency_build_scope='Pinned Mathlib cache reused; fresh compilation of the two new modules only.',
                  not_claimed=['ABC proof or disproof','whole repository or Mathlib rebuild',
                               'analytic two-place bound','arbitrary-root signed membership',
                               'Eisenstein primitivity preservation'])
    result_path.write_bytes((json.dumps(record, indent=2)+'\n').encode())
    print(json.dumps({k:v for k,v in record.items() if k not in {'modules'}}, indent=2))


if __name__ == '__main__':
    main()
