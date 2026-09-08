#!/usr/bin/env python3
"""Fresh one-module finite F13 kernel audit, reusing an exact existing Mathlib cache.

Run in WSL with --cache-project /root/abc-lean-build. No dependency installation,
cache rewrite, native code generation, or published verification file occurs.
Every invocation has a separate project, source copy, manifest and compiler log.
"""
from pathlib import Path
import argparse
import datetime
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
PIN = '81a5d257c8e410db227a6665ed08f64fea08e997'
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--cache-project', type=Path, required=True)
    args = parser.parse_args()
    stamp = datetime.datetime.now(datetime.timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
    out = HERE / 'next_verification' / ('f13-' + stamp)
    out.mkdir(parents=True)
    record = {'status': 'NOT_RUN', 'utc_run_id': stamp}
    result = out / 'validation.json'

    def save():
        result.write_text(json.dumps(record, indent=2) + '\n', encoding='utf-8')

    save()
    cache = args.cache_project.resolve()
    mathlib = cache / '.lake/packages/mathlib'
    try:
        rev = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=mathlib, text=True).strip()
        assert rev == PIN, rev
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD', '--', 'Mathlib', 'lean-toolchain'],
                       cwd=mathlib, check=True, capture_output=True)
        assert (cache / 'lean-toolchain').read_text().strip() == 'leanprover/lean4:v4.32.0'
        build = Path(tempfile.mkdtemp(prefix='abc-f13-kernel-fresh-'))
        shutil.copyfile(cache / 'lean-toolchain', build / 'lean-toolchain')
        (build / 'lakefile.toml').write_text(
            'name = "ABCF13KernelAudit"\nversion = "0.1.0"\n\n'
            '[[require]]\nname = "mathlib"\n'
            'git = "https://github.com/leanprover-community/mathlib4"\n'
            f'rev = "{PIN}"\n', encoding='utf-8')
        manifest = json.loads((cache / 'lake-manifest.json').read_text())
        needed = {p['name'] for p in json.loads((mathlib / 'lake-manifest.json').read_text())['packages']}
        needed.add('mathlib')
        manifest['name'] = 'ABCF13KernelAudit'
        manifest['packages'] = [p for p in manifest['packages'] if p['name'] in needed]
        for package in manifest['packages']:
            package['inherited'] = package['name'] != 'mathlib'
            if package['name'] == 'mathlib':
                package['inputRev'] = PIN
                package['scope'] = ''
        (build / 'lake-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
        packages = build / '.lake/packages'
        packages.mkdir(parents=True)
        for package in (cache / '.lake/packages').iterdir():
            if package.is_dir() and package.name in needed:
                (packages / package.name).symlink_to(package.resolve(), target_is_directory=True)
        # Lake obtains only its environment; compilation below targets the fresh source directly.
        configured = json.loads(subprocess.check_output(['lake', 'env', sys.executable, '-c',
            'import os,json; print(json.dumps(dict(os.environ)))'], cwd=build, text=True))
        compiler = subprocess.check_output(['lean', '--version'], cwd=build, env=configured,
                                            text=True).strip()
        assert 'version 4.32.0,' in compiler, compiler
        source = HERE / 'next_Lean/F13FixedCurveArithmetic.lean'
        data = source.read_bytes()
        code = data.decode('utf-8')
        assert not re.search(r'^\s*(axiom|opaque)\s|\b(sorry|admit|native_decide)\b', code, re.M)
        namespace = re.search(r'^namespace\s+(\w+)', code, re.M).group(1)
        declarations = re.findall(r'^(?:theorem|lemma)\s+(\w+)', code, re.M)
        queries = re.findall(r'^#print axioms\s+([\w.]+)', code, re.M)
        qualified = [q if '.' in q else namespace + '.' + q for q in queries]
        assert len(qualified) == len(set(qualified))
        assert set(qualified) == {namespace + '.' + d for d in declarations}
        assert declarations, 'No declarations to audit'
        fresh = build / source.name
        fresh.write_bytes(data)
        configured['LEAN_PATH'] = str(build) + os.pathsep + configured.get('LEAN_PATH', '')
        configured['LEAN_NUM_THREADS'] = '1'
        command = ['lean', '--root=' + str(build), '-DwarningAsError=true',
                   '-o', str(build / (source.stem + '.olean')), str(fresh)]
        record.update(status='RUNNING', compiler=compiler, mathlib_commit=rev,
                      fresh_project=str(build), cache_project=str(cache), command=command,
                      source=str(source), source_sha256=digest(data),
                      verifier_sha256=digest(Path(__file__).read_bytes()),
                      scope_sha256=digest((HERE / 'next_f13_formal_scope.md').read_bytes()),
                      new_theorems=len(declarations), old_project_theorems_recompiled=0,
                      queries=qualified)
        save()
        proc = subprocess.run(command, cwd=build, env=configured, capture_output=True,
                              text=True, encoding='utf-8', timeout=600)
        log = proc.stdout + proc.stderr
        (out / 'fresh-build.log').write_text(log, encoding='utf-8')
        record['exit_code'] = proc.returncode
        record['log_sha256'] = digest(log.encode())
        assert proc.returncode == 0 and not re.search(r'\berror:|sorryAx', log), log
        assert source.read_bytes() == data == fresh.read_bytes(), 'Source changed while compiling'
        union = set()
        audit = {}
        for query in qualified:
            stem = "'" + re.escape(query) + "' "
            match = re.search(stem + r'depends on axioms:\s*\[([^\]]*)\]', log)
            if match:
                axioms = {a.strip() for a in match.group(1).split(',') if a.strip()}
                assert axioms <= ALLOWED, (query, axioms)
            else:
                assert re.search(stem + 'does not depend on any axioms', log), query
                axioms = set()
            union |= axioms
            audit[query] = sorted(axioms)
        record.update(status='PASS', axiom_union=sorted(union), theorem_axioms=audit,
                      olean_sha256=digest((build / (source.stem + '.olean')).read_bytes()),
                      dependency_scope='Pinned Mathlib cache reused; only the one new module compiled.',
                      excluded=['projective curve or elliptic group construction',
                                'abstract multiplication by three', 'p-adic analysis',
                                'global reduction and index bridge', 'rational-point completeness', 'ABC'])
        save()
        print(json.dumps({'status': record['status'], 'new_theorems': len(declarations),
                          'axiom_union': sorted(union), 'source_sha256': digest(data),
                          'manifest': str(result)}, indent=2))
    except BaseException as exc:
        record['status'] = 'FAIL'
        record['error'] = str(exc)
        save()
        raise


if __name__ == '__main__':
    main()
