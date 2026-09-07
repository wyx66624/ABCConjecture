"""Canonical wrapper for the independently rerun exact PARI newspace probe."""
from argparse import ArgumentParser
from hashlib import sha256
from json import dumps
from pathlib import Path
import subprocess
import sys


def main():
    parser=ArgumentParser();parser.add_argument('--check',action='store_true')
    args=parser.parse_args()
    source=Path(__file__).with_suffix('.gp').resolve()
    if sys.platform=='win32':
        linux_path='/mnt/'+source.drive[0].lower()+source.as_posix()[2:]
        command=['wsl','-d','Ubuntu-24.04','--','gp','-q','-f',linux_path]
    else:command=['gp','-q','-f',str(source)]
    result=subprocess.run(command,capture_output=True,text=True,check=True,timeout=180)
    lines=result.stdout.splitlines()
    assert lines[0]=='["PARI_VERSION", [2, 15, 4]]'
    assert lines[-1]=='EXACT_NEWSPACE_REPLAY_PASS'
    assert not any('***' in line for line in lines)
    assert not any('error' in line.lower() for line in result.stderr.splitlines())
    assert sum(line.startswith('["SPACE",') for line in lines)==5
    assert sum(line.startswith('["ORBIT",') for line in lines)==6
    payload={'scope':'exact PARI modular-space diagnostics; not a Lean proof or seed exclusion',
             'pari_version':'2.15.4','source_sha256':sha256(source.read_bytes()).hexdigest(),
             'stdout_lines':lines}
    raw=(dumps(payload,sort_keys=True,indent=2)+'\n').encode('utf-8')
    path=source.parent/'verification'/'modular_space_results.json'
    if args.check:assert path.read_bytes()==raw,'canonical modular-space result differs'
    else:path.parent.mkdir(exist_ok=True);path.write_bytes(raw)
    print(dumps({'status':'PASS','spaces':5,'orbits':6,'sha256':sha256(raw).hexdigest()}))


if __name__=='__main__':main()
