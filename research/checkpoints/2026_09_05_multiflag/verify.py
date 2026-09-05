#!/usr/bin/env python3
"""Replay only the self-contained core checks; expanded datasets are separate."""
from pathlib import Path
import hashlib
import importlib.util
import json
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent
EXPECTED_LEAN = '1bb648834b0570daac70f8a4dbe021f35ddd35ba0adceb69667345376bd929c0'
EXPECTED_SCAN = {'c_bound':5000,'primitive_triples':3800229,'proper_faces':70740182,
    'compatible_unitary_modulus_cases':8435196,'mod3_refined_cases':3866583,
    'equality_cases':1156,'counterexamples':0}

def main():
    source = ROOT / 'Lean/CapacityAndLifting.lean'
    if hashlib.sha256(source.read_bytes()).hexdigest() != EXPECTED_LEAN:
        raise RuntimeError('Lean source differs from the recorded successful CI source')
    spec = importlib.util.spec_from_file_location('exact_multiflow', ROOT/'computation/exact_multiflow.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    networks = module.test_networks(5000)
    compiler = shutil.which('g++') or shutil.which('clang++')
    if not compiler:
        raise RuntimeError('C++17 compiler required; unitary scan was not rerun')
    with tempfile.TemporaryDirectory(prefix='abc-core-') as temp:
        binary = str(Path(temp)/'unitary_scan')
        subprocess.run([compiler,'-std=c++17','-O2',str(ROOT/'computation/unitary_scan.cpp'),'-o',binary],check=True,timeout=120)
        scan = json.loads(subprocess.run([binary,'5000'],check=True,capture_output=True,text=True,timeout=180).stdout)
    if scan != EXPECTED_SCAN:
        raise RuntimeError('Unitary scan differs from recorded result')
    print(json.dumps({'core_checks':'passed','lean_source_hash':'matched',
        'lean_compilation_this_command':'not executed; see pinned GitHub workflow',
        'network_crosscheck':networks,'unitary_scan':scan,
        'expanded_arithmetic_and_lifting_datasets':'not rerun by this core-only command',
        'ABC_proved':False},indent=2,sort_keys=True))

if __name__ == '__main__':
    main()
