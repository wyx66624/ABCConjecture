#!/usr/bin/env python3
"""Add the explicitly proved p-adic continuation, then run source integration."""
from pathlib import Path
import json
import integrate_monograph as integration

root=Path(__file__).resolve().parents[3]
D=Path(__file__).resolve().parent
p=D/'paper/ChatGPT_ABC_Moving_Support_2026_09_06.tex'
s=p.read_text()
addition=(D/'paper/adic_addendum.tex').read_text()
if r'\label{sec:adic-moving}' not in s:
    anchor=r'\section{Dependency ledger and formal scope}'
    if s.count(anchor)!=1: raise RuntimeError('Addendum anchor mismatch')
    s=s.replace(anchor,addition+'\n'+anchor)
    old='All restrictions are explicit.'
    new='A non-Archimedean logarithmic-form bound then controls the entire small-prime part uniformly on the same norm-support regime, so the cubic-excess restriction is needed only above a moving cutoff. All restrictions are explicit.'
    if old not in s: raise RuntimeError('Abstract anchor mismatch')
    s=s.replace(old,new,1)
    s=s.replace('Theorem~1.1, equation~(1.2). \\href', 'Theorem~1.1, equation~(1.2), and the first inequality of Theorem~1.3. \\href')
    p.write_text(s)
print(json.dumps(integration.run(root),indent=2))
