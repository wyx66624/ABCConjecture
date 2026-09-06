#!/usr/bin/env python3
"""Idempotently add this reviewed supplement to the hash-pinned 347-page source."""
from __future__ import annotations
import hashlib
import json
import re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE_SHA='cd0a867057a2a89adeba041c26e84a72bcb6d3fa63385ecea80b72cfec56f175'
MARKS=('EXPONENT PROFILE INPUT','EXPONENT PROFILE REFERENCES')

def strip(s:str)->str:
    for tag in MARKS:
        s=re.sub(r'% BEGIN '+tag+r' 2026-09-06\n.*?% END '+tag+r' 2026-09-06\n','',s,flags=re.S)
    return s

def run()->dict:
    master=ROOT/'paper/ChatGPT_ABC_Uniformity_2026.tex'
    old=master.read_text();base=strip(old)
    observed=hashlib.sha256(base.encode()).hexdigest()
    if observed!=BASE_SHA:raise RuntimeError(f'Baseline mismatch: {observed}; refusing to replace unknown work')
    target=ROOT/'paper/supplements/checkpoint_exponent_profiles_20260906.tex'
    target.write_bytes((HERE/'paper/body.tex').read_bytes()+b'\n'+(HERE/'paper/envelope_obstruction.tex').read_bytes())
    anchor=r'\section{Formal verification and remaining obligations}'
    if base.count(anchor)!=1:raise RuntimeError('Expected exactly one formal-scope anchor')
    addition='% BEGIN EXPONENT PROFILE INPUT 2026-09-06\n'+r'\input{supplements/checkpoint_exponent_profiles_20260906}'+'\n% END EXPONENT PROFILE INPUT 2026-09-06\n'
    new=base.replace(anchor,addition+anchor)
    bib=(HERE/'paper/references.tex').read_text()
    end=r'\end{thebibliography}'
    if new.count(end)!=1:raise RuntimeError('Expected one bibliography')
    new=new.replace(end,'% BEGIN EXPONENT PROFILE REFERENCES 2026-09-06\n'+bib+'\n% END EXPONENT PROFILE REFERENCES 2026-09-06\n'+end)
    if strip(new)!=base:raise RuntimeError('Failed exact baseline preservation')
    master.write_text(new)
    return {'baseline_sha256':BASE_SHA,'master_sha256':hashlib.sha256(new.encode()).hexdigest(),
            'original_source_recovered_exactly':True,'changed':new!=old,
            'supplement':str(target.relative_to(ROOT))}
if __name__=='__main__':print(json.dumps(run(),indent=2))
