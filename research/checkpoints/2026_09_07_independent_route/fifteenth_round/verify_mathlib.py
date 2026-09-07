"""Fresh scoped compilation of GD integer and rational arithmetic against pinned Mathlib."""
from pathlib import Path
import hashlib
import json
import os
import re
import shutil
import subprocess
import tempfile


def main():
    here = Path(__file__).resolve().parent
    root = here.parents[3]
    project = root/'Lean'
    mathlib = project/'.lake/packages/mathlib'
    pin = '81a5d257c8e410db227a6665ed08f64fea08e997'
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=mathlib,
                                   text=True).strip() == pin
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD', '--',
                    'Mathlib', 'lean-toolchain'], cwd=mathlib,
                   capture_output=True, check=True)
    lake = shutil.which('lake') or '/root/.elan/bin/lake'
    compiler = subprocess.check_output([lake, 'env', 'lean', '--version'],
                                       cwd=project, text=True).strip()
    assert 'version 4.32.0,' in compiler
    source = here/'Lean/GaussianDescentArithmetic.lean'
    raw = source.read_bytes()
    code = raw.decode()
    assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit)\b', code, re.M)
    namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
    declarations = re.findall(r'^theorem\s+(\w+)', code, re.M)
    queries = re.findall(r'^#print axioms\s+(\w+)', code, re.M)
    assert len(declarations) == 15 and set(declarations) == set(queries)
    env = json.loads(subprocess.check_output([lake, 'env', 'python3', '-c',
        'import os,json; print(json.dumps(dict(os.environ)))'], cwd=project, text=True))
    out = here/'verification'
    out.mkdir(exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='abc-gd-fresh-') as fresh:
        fresh = Path(fresh)
        copy = fresh/source.name
        copy.write_bytes(raw)
        env['LEAN_PATH'] = str(fresh)+os.pathsep+env.get('LEAN_PATH', '')
        proc = subprocess.run(['lean', '--root='+str(fresh), '-DwarningAsError=true',
                               '-o', str(fresh/(source.stem+'.olean')), str(copy)],
                              cwd=project, env=env, capture_output=True, text=True)
        log = proc.stdout+proc.stderr
        (out/'fresh-mathlib-build.log').write_bytes(log.encode())
        if proc.returncode or 'sorryAx' in log or re.search(r'\b(error|warning):', log):
            raise RuntimeError(log)
        assert (fresh/(source.stem+'.olean')).is_file()
    found = re.findall(r"'([^']+)' depends on axioms:\s*\[([^]]*)\]", log)
    axioms = {name: [a.strip() for a in block.split(',') if a.strip()]
              for name, block in found}
    expected = {namespace+'.'+name for name in declarations}
    assert set(axioms) == expected
    allowed = {'propext', 'Classical.choice', 'Quot.sound'}
    assert all(set(values) <= allowed for values in axioms.values())
    assert raw == source.read_bytes()
    record = {'status': 'PASS', 'compiler': compiler, 'mathlib_commit': pin,
              'source': source.relative_to(root).as_posix(),
              'source_sha256': hashlib.sha256(raw).hexdigest(),
              'declarations': 15, 'axiom_queries': axioms,
              'fresh_temporary_source_and_olean': True,
              'warnings_as_errors': True,
              'scope': 'Actual GD integer norm and mod-27 arithmetic, inverse rational identities and rational-chart tripling identities. Does not formalize UFDs, cube roots, curve groups, isogeny degree, Jacobian rank or rational-point completeness.'}
    data = (json.dumps(record, sort_keys=True, indent=2)+'\n').encode()
    (out/'mathlib_validation.json').write_bytes(data)
    print(json.dumps({'status': 'PASS', 'declarations': 15,
                      'source_sha256': record['source_sha256'],
                      'manifest_sha256': hashlib.sha256(data).hexdigest()}))


if __name__ == '__main__':
    main()
