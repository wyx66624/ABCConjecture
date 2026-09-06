#!/usr/bin/env python3
"""Record a successfully executed scoped build; do not manufacture proof claims."""
from __future__ import annotations
import hashlib,json,os,re,subprocess
from pathlib import Path
from pypdf import PdfReader
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]

def digest(p:Path)->str:return hashlib.sha256(p.read_bytes()).hexdigest()

def main()->None:
    pdf=ROOT/'output/pdf/ChatGPT_ABC_Uniformity_2026.pdf'
    log=(ROOT/'paper/ChatGPT_ABC_Uniformity_2026.log').read_text(errors='replace')
    bad=('There were undefined references','Citation `','Reference `','multiply defined')
    if any(s in log for s in bad):raise RuntimeError('Unresolved references or duplicate labels')
    if len(PdfReader(pdf).pages)<=347:raise RuntimeError('Expected actual supplement in the master')
    proofs={'dependency':29,'profiles':16}
    for name,count in proofs.items():
        text=(ROOT/f'verification-profiles/{name}.log').read_text()
        hits=re.findall(r"'([^']+)' (?:depends on axioms:|does not depend on any axioms)",text)
        if len(set(hits))!=count or 'sorryAx' in text:raise RuntimeError(f'Proof log mismatch: {name}')
    report={'status':'PASS: scoped kernels, exact finite replay and master PDF; NOT an ABC proof',
       'tested_input_commit':os.environ.get('GITHUB_SHA','local-uncommitted'),
       'run_id':os.environ.get('GITHUB_RUN_ID'),
       'baseline_commit':'e27d295939e2130e2565b4686549e6c4a3b6ac8a',
       'pdf_pages':len(PdfReader(pdf).pages),'pdf_bytes':pdf.stat().st_size,
       'pdf_sha256':digest(pdf),'new_lean_queries':16,'dependency_lean_queries':29,
       'axiom_whitelist':['propext','Classical.choice','Quot.sound'],
       'source_hashes':{p:digest(ROOT/p) for p in [
          'paper/ChatGPT_ABC_Uniformity_2026.tex',
          'paper/supplements/checkpoint_exponent_profiles_20260906.tex',
          'research/checkpoints/2026_09_06_exponent_profiles/Lean/ExponentProfiles.lean']},
       'overfull_hbox_count_including_baseline':log.count('Overfull \\hbox'),
       'not_claimed':['standard ABC proof','whole manuscript formalization',
          'full repository build','independent autonomous agents','external peer review','personal WSL access']}
    out=HERE/'verification/build_validation.json';out.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))
if __name__=='__main__':main()
