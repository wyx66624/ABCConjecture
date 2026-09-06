#!/usr/bin/env python3
"""Append, do not overwrite, the live 353-page source and the attached continuation."""
from pathlib import Path
import hashlib,json,re
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
MASTER=ROOT/'paper/ChatGPT_ABC_Uniformity_2026.tex'
BASE='f1f673a4b1de8bba0979a76d69f826177ade04126ba61cc30b2f45fbbffc15a9'
PAT=r'% BEGIN CR-20260906 (BODY|BIBLIO)\n.*?% END CR-20260906 \1\n'
BODY=r'''% BEGIN CR-20260906 BODY
\clearpage
\subsection*{Source integration and verification scope: September 6 continuation}
The live main-branch source at commit
\texttt{937cb77058a80e9e9ae8ce3a4c8e13b752119796} builds the 353-page
exponent-profile edition. The separately attached 354-page edition contains
an additional exponent-compression and prime-norm obstruction supplement.
Both research bodies are preserved here: the live source is not replaced by
the stale attachment. The following archived compression text is unchanged;
its statements about an uncompiled companion and unavailable tools describe
its earlier execution, not the present environment. That exact old Lean file
is still not certified by the new scoped checks. The next, newly added
completion supplement has its own explicitly narrower verification scope.
None of these texts asserts a proof of standard abc.
\input{supplements/checkpoint_compression_20260906}
\clearpage
\subsection*{Correlated completions and the ramification cost of normalization}
\input{supplements/checkpoint_correlated_completions_20260906}
% END CR-20260906 BODY
'''
BIB=r'''% BEGIN CR-20260906 BIBLIO
\bibitem{XC-ThornerZaman}
J.~Thorner and A.~Zaman, An explicit bound for the least prime ideal in the
Chebotarev density theorem, \emph{Algebra Number Theory} \textbf{11} (2017),
no.~5, 1135--1197. Theorem~3.1 in the author manuscript
\href{https://arxiv.org/abs/1604.01750}{arXiv:1604.01750}.
\bibitem{XC-Pasten}
H.~Pasten, The largest prime factor of $n^2+1$ and improvements on
subexponential ABC, arXiv:2312.03566v1, 2023, Theorem~2.5.
\href{https://arxiv.org/abs/2312.03566}{Author preprint}.
'''
def main():
    original=MASTER.read_text()
    base=re.sub(PAT,'',original,flags=re.S)
    assert hashlib.sha256(base.encode()).hexdigest()==BASE, 'Main source moved: reconcile, do not overwrite.'
    historical=ROOT/'paper/supplements/checkpoint_compression_20260906.tex'
    assert hashlib.sha256(historical.read_bytes()).hexdigest()== '323ecb6df9351796fe1f2f8409c5fde466975789003cb80383cee7a9593239e5'
    body=(HERE/'paper/body.tex').read_bytes()
    out=ROOT/'paper/supplements/checkpoint_correlated_completions_20260906.tex'
    out.write_bytes(body)
    target=r'\section{Formal verification and remaining obligations}'
    assert base.count(target)==1 and base.count(r'\end{thebibliography}')==1
    updated=base.replace(target,BODY+target,1)
    bib=BIB+(HERE/'paper/references.tex').read_text()+'% END CR-20260906 BIBLIO\n'
    updated=updated.replace(r'\end{thebibliography}',bib+r'\end{thebibliography}',1)
    assert re.sub(PAT,'',updated,flags=re.S)==base
    MASTER.write_text(updated)
    print(json.dumps({'base_sha256':BASE,'updated_sha256':hashlib.sha256(updated.encode()).hexdigest(),
        'new_body_sha256':hashlib.sha256(body).hexdigest(),'preserved_main_math':True,
        'already_integrated':original==updated},indent=2))
if __name__=='__main__':main()
