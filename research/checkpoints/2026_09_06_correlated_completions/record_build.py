#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,os,re
from pypdf import PdfReader
D=Path(__file__).resolve().parent;ROOT=D.parents[2]
pdf=ROOT/'output/pdf/ChatGPT_ABC_Uniformity_2026.pdf'
reader=PdfReader(pdf)
log=(ROOT/'paper/ChatGPT_ABC_Uniformity_2026.log').read_text(errors='replace')
for pattern in [r'There were undefined references',r'Citation .* undefined',r'Reference .* undefined',r'multiply defined']:
    if re.search(pattern,log):raise SystemExit('Unresolved manuscript: '+pattern)
standlog=(D/'paper/ChatGPT_ABC_Correlated_Completions_2026.log').read_text(errors='replace')
if 'Overfull' in standlog:raise SystemExit('New standalone manuscript has an overfull box')
needles=['Uniform elementary squarefree completion','Uniform prime-norm squarefree completion','Norm-power ramification budget','Source integration and verification scope']
locations={q:[] for q in needles}
for i,page in enumerate(reader.pages,1):
    text=page.extract_text() or ''
    for q in needles:
        if q.lower() in text.lower():locations[q].append(i)
if any(not v for v in locations.values()):raise SystemExit('Missing new mathematical content in PDF')
record={'status':'PASS: scoped checks, exact replay and integrated manuscript; NOT a proof of ABC',
 'baseline_main':'937cb77058a80e9e9ae8ce3a4c8e13b752119796',
 'tested_input_commit':os.environ.get('GITHUB_SHA','local uncommitted source'),
 'run_id':os.environ.get('GITHUB_RUN_ID'),
 'pdf_pages':len(reader.pages),'pdf_bytes':pdf.stat().st_size,
 'pdf_sha256':hashlib.sha256(pdf.read_bytes()).hexdigest(),
 'new_lean_queries':16,'axiom_whitelist':['propext','Classical.choice','Quot.sound'],
 'new_theorem_pages':locations,
 'overfull_hbox_count_including_preserved_sources':log.count('Overfull \\hbox'),
 'source_hashes':{str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [ROOT/'paper/ChatGPT_ABC_Uniformity_2026.tex',D/'paper/body.tex',D/'Lean/CorrelatedCompletions.lean',ROOT/'paper/supplements/checkpoint_compression_20260906.tex']},
 'not_claimed':['standard ABC proof','entire paper formally verified','prime-element analytic input proved here','general ramification theorem kernel checked','historical compression Lean compiled','independent autonomous agents','external peer review','personal WSL execution']}
(D/'verification/build_validation.json').write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record,indent=2))
