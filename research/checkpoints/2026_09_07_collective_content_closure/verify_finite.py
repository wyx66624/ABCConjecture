#!/usr/bin/env python3
"""Replay exact certificates without inferring infinite or geometric results."""
from pathlib import Path
import hashlib
import json
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
SOURCES = [
    ('2026_09_07_critical_bottleneck', 'replay_collective_content.py', 'collective_content_exact.json',
     'cbb9f7a0a1de88576c9c2014e02da2c7fe32f03e17e6b3ccef8fabbba7a5ff34'),
    ('2026_09_07_critical_bottleneck', 'replay_complement_determinants.py', 'complement_determinants_exact.json',
     'c87bc0a10dd7e357a2cb0dc7248edead501fe496dbacf081efbac1b0a9f5c1b6'),
    ('2026_09_07_critical_bottleneck', 'replay_collective_profile.py', 'collective_profile_exact.json',
     '6716dca74364d0faa8acb4636f52bf545bcb2097dd2939d79c58d8839903df1c'),
    ('2026_09_07_independent_route', 'replay_padic_entry.py', 'padic_entry_exact.json',
     '2bc0673769cc10abba959725e1683676d162918afa7fbf89a463f664c9b24696'),
    ('2026_09_07_adversarial_audit', 'replay_divisor_partition.py', 'divisor_partition_exact.json',
     '6b7a363b91b7fad5c570696ed8b5fcd50be50d73607a7d0c0d829bc1b75c551d'),
]


def main():
    out = HERE/'verification'
    out.mkdir(exist_ok=True)
    target = out/'finite_replay_validation.json'
    target.write_text(json.dumps({'status':'NOT_RUN: current invocation has not validated certificates'})+'\n')
    records = []
    for directory, program, filename, digest in SOURCES:
        source = ROOT/'research/checkpoints'/directory/'seventeenth_round'
        script, certificate = source/program, source/'verification'/filename
        assert hashlib.sha256(certificate.read_bytes()).hexdigest() == digest, certificate
        proc = subprocess.run([sys.executable,str(script),'--check'],check=True,
                              capture_output=True,text=True,encoding='utf-8')
        assert hashlib.sha256(certificate.read_bytes()).hexdigest() == digest
        records.append({'output':proc.stdout.strip(),'files_sha256':{
            p.relative_to(ROOT).as_posix():hashlib.sha256(p.read_bytes()).hexdigest()
            for p in [script,certificate]}})
    lp = ROOT/'research/checkpoints/2026_09_07_adversarial_audit/eighteenth_round'
    program = lp/'replay_large_prime_partition.py'
    certificate = lp/'verification/large_prime_partition_exact.json'
    digest = '3b4de60c0f5fb1fcba68b7def3b655db4b406047de5ea764f7b29b66f729fb51'
    assert hashlib.sha256(certificate.read_bytes()).hexdigest() == digest
    proc = subprocess.run([sys.executable,str(program),'--check'],check=True,
                          capture_output=True,text=True,encoding='utf-8')
    files = [program,certificate,lp/'verification/large_prime_lucas_certificate.json']
    records.append({'output':proc.stdout.strip(),'files_sha256':{
        p.relative_to(ROOT).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in files}})
    program = HERE/'verify_height_exact.py'
    proc = subprocess.run([sys.executable,str(program)],check=True,
                          capture_output=True,text=True,encoding='utf-8')
    ht = ROOT/'research/checkpoints/2026_09_07_independent_route/eighteenth_round'
    files = [program,ht/'replay_height_transport.py',ht/'replay_height_transport.gp',
             ht/'verification/height_transport.json']
    records.append({'output':proc.stdout.strip(),'files_sha256':{
        p.relative_to(ROOT).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in files}})
    lm = ROOT/'research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round'
    program = lm/'replay_affine_selectors.py'
    certificate = lm/'verification/affine_selector_exact.json'
    digest = '70945a8da8fdecee2a8857dd9ea71ab2bb12f9054a8f25b35ad87f342df6d767'
    assert hashlib.sha256(certificate.read_bytes()).hexdigest() == digest
    before = {p:hashlib.sha256(p.read_bytes()).hexdigest() for p in [program,certificate]}
    proc = subprocess.run([sys.executable,str(program),'--check'],check=True,
                          capture_output=True,text=True,encoding='utf-8')
    assert all(hashlib.sha256(p.read_bytes()).hexdigest() == h for p,h in before.items())
    records.append({'output':proc.stdout.strip(),'files_sha256':{
        p.relative_to(ROOT).as_posix():h for p,h in before.items()}})
    result = {'status':'PASS: eight finite replays; HT checks exact leading digits and recorded balls only',
              'records':records}
    target.write_bytes((json.dumps(result,indent=2)+'\n').encode())
    print(json.dumps({'status':result['status'],'records':len(records)}))


if __name__ == '__main__':
    main()
