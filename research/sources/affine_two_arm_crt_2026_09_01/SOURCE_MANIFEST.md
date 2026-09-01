# Primary-source manifest for the affine two-arm CRT continuation

Retrieved: 2026-09-01.  Both files are pinned original arXiv PDFs.

| File | Primary source | Use and audit status | SHA-256 |
|---|---|---|---|
| `Carella_2608.16764v2.pdf` | N. A. Carella, *Note on the Exceptional Set in the ABC Conjecture*, [arXiv:2608.16764v2](https://arxiv.org/abs/2608.16764) | Audited because it claims infinitely many fixed-epsilon exceptional triples.  The report identifies the unsupported replacement of an `O(h)` Taylor-summation error by `O(h rho(u))` in the Lemma 4.2/4.4 moment chain.  No theorem from this preprint is used. | `d65c52ba83c31a586e1aba937ffc76242ad47859bc81b630cedd3efc369bf2b1` |
| `Jain_2502.10530v1.pdf` | Sarvagya Jain, *Smooth Numbers in Short Intervals*, [arXiv:2502.10530v1](https://arxiv.org/abs/2502.10530) | Original source for the short-interval theorem cited by Carella.  Used only to check the stated parameter range; no theorem is assumed in Lean. | `b0f628e1c6b863a8f131fc67b6a2c1c592e99a374eef3f31503bf381ad0079ec` |

The established exceptional-set and squarefree-progression sources already
pinned in the repository remain authoritative for comparison:

- `research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`;
- `research/sources/affine_density_attack_2026_09_01/Nunes_1402.0684v2.pdf`.

The CRT packet and the insufficiency counterexample are elementary and do not
depend on an external theorem.  No external statement is introduced as a Lean
axiom.

