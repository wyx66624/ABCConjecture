#!/usr/bin/env python3
"""Integrate source proofs into the hash-pinned monograph, with explicit provenance.

Six historical proof bodies, two labelled proof consolidations and one new
paper are included. This is source integration, not PDF concatenation. The
original main-text source is recovered and checked before every rerun.
"""
from __future__ import annotations
import hashlib
import json
import re
from pathlib import Path

BASE='08762e9d25b4f024f09e3a732945ebd6078250723e90e5776b01b463753e504a'
MARK='% BEGIN INTEGRATED CHECKPOINTS 2026-09-06'
PREAMBLE='% INTEGRATION PREAMBLE 2026-09-06\n\\usepackage{mathrsfs}\n'
SOURCES=[
 ('fcrt','Flagged CRT obstructions and exact divisor gaps','2026_09_05_chatgpt/paper/ChatGPT_ABC_FCRT_UnitGap_2026_09_05.tex'),
 ('signed','Signed endpoint transport and exact losses','2026_09_05_chatgpt/paper/ChatGPT_ABC_Signed_Endpoints_2026_09_05.tex'),
 ('multiflag','Unitary faces, safe multiple outputs, and valuation lifting','2026_09_05_multiflag/paper/ChatGPT_ABC_Unitary_Multiflow_Lifting_2026_09_05.tex'),
 ('normal','Signed normal forms and arithmetic Wronskians','2026_09_05_normal_forms/paper/ChatGPT_ABC_Normal_Forms_Transversality_2026_09_05.tex'),
 ('transverse','Quantitative transverse integer lifting','2026_09_05_transverse_lifting/paper/ChatGPT_ABC_Transverse_Lifting_2026_09_05.tex'),
 ('power','Power-radical descent and first-depth obstructions','2026_09_05_power_descent/paper/ChatGPT_ABC_Power_Descent_2026_09_05.tex'),
 ('eisenstein','Eisenstein descent and strong boundary divisibility','2026_09_05_eisenstein_descent/paper/ChatGPT_ABC_Eisenstein_Descent_2026_09_05.tex'),
 ('rank','First-appearance depth and the norm-seven orbit','2026_09_05_rank_law/paper/ChatGPT_ABC_Rank_Depth_2026_09_05.tex'),
 ('moving','Moving norm support and compensated cubic boundaries','2026_09_06_moving_support/paper/ChatGPT_ABC_Moving_Support_2026_09_06.tex'),
]


def balanced(s: str, i: int, left='{', right='}') -> tuple[str,int]:
    if s[i]!=left: raise ValueError('Expected group at '+str(i))
    level=0
    for j in range(i,len(s)):
        if j and s[j-1]=='\\': continue
        if s[j]==left: level+=1
        if s[j]==right:
            level-=1
            if level==0: return s[i:j+1],j+1
    raise ValueError('Unbalanced TeX group')


def macros(pre: str) -> str:
    out=[]
    pat=re.compile(r'\\(?:newcommand|renewcommand|DeclareMathOperator)\*?\s*')
    for m in pat.finditer(pre):
        key,j=balanced(pre,m.end())
        if not re.fullmatch(r'\{\\[A-Za-z]+\}',key): raise ValueError(key)
        while j<len(pre) and pre[j].isspace(): j+=1
        if pre[j]=='[':
            _,j=balanced(pre,j,'[',']')
            while pre[j].isspace(): j+=1
            if pre[j]=='[':
                _,j=balanced(pre,j,'[',']')
                while pre[j].isspace(): j+=1
        _,j=balanced(pre,j)
        command=pre[m.start():j].replace('\\renewcommand','\\newcommand')
        command=re.sub(r'\\DeclareMathOperator\{(\\[A-Za-z]+)\}\{([^}]+)\}',lambda q:r'\newcommand{'+q.group(1)+r'}{\operatorname{'+q.group(2)+'}}',command)
        out.append('\\let'+key[1:-1]+'\\relax\n'+command)
    return '\n'.join(out)+'\n'


def keyspace(s: str,prefix: str) -> str:
    pattern=r'\\(label|ref|eqref|pageref|autoref|cite|bibitem)(\[[^\]]*\])?\{([^}]+)\}'
    def repl(m):
        keys=','.join(prefix+':'+k.strip() for k in m.group(3).split(','))
        return '\\'+m.group(1)+(m.group(2) or '')+'{'+keys+'}'
    return re.sub(pattern,repl,s)


def editorial(source: Path,tag: str) -> str:
    s=source.read_text()
    if tag=='normal':
        # This source is already a labelled edited proof edition. Remove two
        # redundant candidate choices and retain the complete correct argument.
        start=r'Choose $L$ with $2^L\equiv1\pmod{a(a+2)}$'
        if start in s:
            i=s.index(start)
            j=s.index(r'\end{proof}',i)
            replacement=r'''Choose $L\ge1$ such that $2^L\equiv1\pmod{a|a-2|}$, omitting modulus-one factors, and let $M=2^{kL}>a$ have exponent at least two. Use $(x,X,y,Y)=(1,a,M+1,2M+a)$, so $s=1,r=2$ and $n=M(2M+a+2)$. Both factors of $b=(M+1)(2M+a)$ are congruent to two modulo the odd integer $a$, so $\gcd(a,b)=1$. Their gcd divides $a-2$ and also $M+1\equiv2\pmod{|a-2|}$; hence it is one. The quotient $2M+a+2$ is odd, proving completeness of the dyadic source. These infinitely many choices attain equality.
'''
            s=s[:i]+replacement+s[j:]
    if tag=='moving' and r'\label{prop:first-to-final}' not in s:
        addition=r'''
\begin{proposition}[From first-depth excess to the present budget]\label{prop:first-to-final}
On the norm-seven orbit, with $P(z_n)=6U_n$, the exact local valuation law of the preceding supplement implies
\[
 E_3(|P(z_n)|)\le6\mathcal L_n F_n\le6nF_n.
\]
\end{proposition}
\begin{proof}
For each supported prime write $v_p(U_n)=s_p+\ell_p$. The elementary inequality
\[
 (s_p+\ell_p+v_p(6)-3)_+\le(s_p-3)_++\ell_p+v_p(6)
\]
gives the claim on multiplying; any prime supplied only by six contributes at most its factor in six. Finally $\mathcal L_n\mid n$. Thus a fixed polynomial bound on $F_n$ implies a polynomial logarithmic bound on the actual-boundary excess because $n\ll\log H_n$. This connects the preceding sufficient class to the present one without confusing first exponents with final exponents.
\end{proof}
'''
        anchor=r'\section{Dependency ledger and formal scope}'
        if s.count(anchor)!=1: raise RuntimeError('Moving paper anchor changed')
        s=s.replace(anchor,addition+'\n'+anchor)
    source.write_text(s)
    return s


def convert(s: str,tag: str,title: str) -> tuple[str,str]:
    pre,body=s.split('\\begin{document}',1)
    body=body.rsplit('\\end{document}',1)[0]
    body=re.sub(r'\\begin\{abstract\}.*?\\end\{abstract\}','',body,flags=re.S)
    for cmd in ['maketitle','raggedbottom','tableofcontents']:
        body=body.replace('\\'+cmd,'')
    while True:
        m=re.search(r'\\hypersetup\s*',body)
        if not m: break
        _,end=balanced(body,m.end())
        body=body[:m.start()]+body[end:]
    bib=''
    m=re.search(r'\\begin\{thebibliography\}\{[^}]+\}',body)
    if m:
        end=body.index('\\end{thebibliography}',m.end())
        bib=body[m.end():end]
        body=body[:m.start()]+body[end+len('\\end{thebibliography}'):]
    notation=macros(pre)
    text='\\clearpage\n\\begingroup\n'+notation
    text+='\\section*{Integrated checkpoint: '+title+'}\n'
    text+='\\phantomsection\\label{checkpoint:'+tag+'}\n'
    text+='\\addcontentsline{toc}{section}{Integrated checkpoint: '+title+'}\n'
    if tag in ('normal','rank'):
        caption='Edited proof consolidation; provenance and historical verification boundaries are stated below.'
    elif tag=='moving':
        caption='New research supplement, with external analytic input and formal scope explicitly separated.'
    else:
        caption='Full mathematical proof body of the historical checkpoint. Historical execution statements retain their original scope.'
    text+='\\noindent\\textit{'+caption+'}\\medskip\n'
    text+=keyspace(body,tag)+'\n\\endgroup\n'
    bibliography=('\\begingroup\n'+notation+keyspace(bib,tag)+'\n\\endgroup\n') if bib.strip() else ''
    return text,bibliography


def run(root: Path) -> dict:
    paper=root/'paper'; cp=root/'research/checkpoints'
    master=paper/'ChatGPT_ABC_Uniformity_2026.tex'
    original=master.read_text()
    if MARK in original:
        a=original.index(MARK)
        b=original.index('% END INTEGRATED CHECKPOINTS 2026-09-06',a)+len('% END INTEGRATED CHECKPOINTS 2026-09-06\n')
        original=original[:a]+original[b:]
        a=original.index('% BEGIN INTEGRATED BIBLIOGRAPHY 2026-09-06')
        b=original.index('% END INTEGRATED BIBLIOGRAPHY 2026-09-06',a)+len('% END INTEGRATED BIBLIOGRAPHY 2026-09-06\n')
        original=original[:a]+original[b:]
    original=original.replace(PREAMBLE,'')
    if hashlib.sha256(original.encode()).hexdigest()!=BASE:
        raise RuntimeError('Unexpected baseline master; refusing to overwrite concurrent changes')
    dest=paper/'supplements'; dest.mkdir(exist_ok=True)
    records=[]; allbib=[]
    for tag,title,rel in SOURCES:
        source=cp/rel; s=editorial(source,tag)
        body,bib=convert(s,tag,title)
        target=dest/f'checkpoint_{tag}_20260906.tex'
        target.write_text(body); allbib.append(bib)
        kind='edited proof consolidation' if tag in ('normal','rank') else ('new supplement' if tag=='moving' else 'historical full proof body')
        records.append({'tag':tag,'title':title,'edition':kind,'source':str(source.relative_to(root)),
            'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
            'integrated':str(target.relative_to(root)),
            'integrated_sha256':hashlib.sha256(target.read_bytes()).hexdigest(),
            'theorem_environments':len(re.findall(r'\\begin\{(?:theorem|lemma|proposition|corollary)\}',body))})
    note=dest/'integration_ledger_20260906.tex'
    note.write_text(r'''\clearpage
\section{Integrated research edition: provenance and proof status}
\label{sec:integration-20260906}
This edition integrates six historical full mathematical proof bodies, two
explicitly labelled proof consolidations (normal forms and rank/depth), and
one new moving-support paper. It does not concatenate unrelated PDFs.
The two consolidations retain the principal mathematical results with full
proofs, but do not repeat unconfirmed historical runtime narratives or claim
to be byte-identical reprints. Existing main-text mathematics is preserved;
removing the labelled integration blocks recovers the hash-pinned master.
References and local notation in the supplements have isolated namespaces.

The original sealed PDF at the baseline commit has 270 pages. Rebuilding the
current baseline source with pdfLaTeX gives 281 pages before these additions:
the source already contains material not present in that sealed artifact.
Thus the difference from 270 is not a count of newly proved pages. The old
PDF remains recoverable from the baseline Git commit.

\textbf{Global status.} Standard abc is neither proved nor disproved.
The new theorem is uniform only on its explicitly stated growing-support
class. None of the earlier sufficient gates is silently supplied.
The complex logarithmic-form theorem is an established cited input; it is
not proved or formalized by the present Lean modules.

\begin{center}\small
\begin{tabular}{p{.67\textwidth}r}
\toprule Checkpoint & Starts on page\\\midrule
'''+''.join(title+r' & \pageref{checkpoint:'+tag+r'}\\'+'\n' for tag,title,_ in SOURCES)+r'''\bottomrule
\end{tabular}
\end{center}

The integration workflow separately compiles the exact currently included
sources with warnings as errors and an axiom whitelist restricted to
\texttt{propext}, \texttt{Classical.choice}, and \texttt{Quot.sound}.
It checks the two Eisenstein modules (40 named queries), the rank/depth
module (18), and the new moving-support module (12). The full norm--boundary
gcd and general finite-list compensated identity are among the new checks.
These are scoped algebraic certificates, not formalizations of the complete
analytic theorem. Earlier CRT and normal-form drafts are not thereby
certified, and no full-repository Lean build is claimed. Current compiler
logs, source hashes and exact replay results are recorded separately.

The original IUT all-place comparison, compensated packet gate, catalogue
sparsity and Pell/Mersenne distribution obligations remain open. Algebraic
coverage does not resolve unit terminals or prime-norm endpoints. The new
result controls the varying-generator angular constant in a specified
regime, while retaining the unrestricted multiplicity budget as an open
problem. Hosted Ubuntu execution is not access to the user's personal WSL;
no external peer review or independent autonomous-agent audit is claimed.
''')
    block=MARK+'\n\\input{supplements/integration_ledger_20260906}\n'
    block+=''.join('\\input{supplements/checkpoint_'+tag+'_20260906}\n' for tag,_,_ in SOURCES)
    block+='% END INTEGRATED CHECKPOINTS 2026-09-06\n'
    anchor='\\section{Formal verification and remaining obligations}'
    if original.count(anchor)!=1: raise RuntimeError('Master anchor mismatch')
    updated=original.replace(anchor,block+anchor)
    bibblock='% BEGIN INTEGRATED BIBLIOGRAPHY 2026-09-06\n'+''.join(allbib)+'% END INTEGRATED BIBLIOGRAPHY 2026-09-06\n'
    if updated.count('\\end{thebibliography}')!=1: raise RuntimeError('Bibliography mismatch')
    updated=updated.replace('\\end{thebibliography}',bibblock+'\\end{thebibliography}')
    updated=updated.replace(r'\begin{document}',PREAMBLE+r'\begin{document}',1)
    master.write_text(updated)
    result={'status':'Source integration; actual PDF and Lean builds are separate checks',
        'base_commit':'9edd965d6df645dbebc0869530f3f5a40fb8cddc','baseline_master_sha256':BASE,
        'baseline_sealed_pdf_pages':270,'baseline_source_rebuild_pages':281,
        'integrated_master_sha256':hashlib.sha256(master.read_bytes()).hexdigest(),'sources':records}
    out=cp/'2026_09_06_moving_support/verification/source_integration.json'
    out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps(result,indent=2)+'\n')
    return result

if __name__=='__main__':
    print(json.dumps(run(Path(__file__).resolve().parents[3]),indent=2))
