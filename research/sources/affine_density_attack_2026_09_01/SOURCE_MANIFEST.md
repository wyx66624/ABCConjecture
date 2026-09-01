# Primary-source manifest for the affine density attack

Retrieved: 2026-09-01.  The PDFs are pinned original arXiv versions.

| File | Source | Use and scope | SHA-256 |
|---|---|---|---|
| `Nunes_1402.0684v2.pdf` | Ramon M. Nunes, *Square-free numbers in arithmetic progressions*, [arXiv:1402.0684v2](https://arxiv.org/pdf/1402.0684v2) | Theorems 1.1--1.2 and Corollary 1.3: variance/correlation for squarefree integers in arithmetic progressions. Cited only for comparison; no theorem from it is assumed in Lean. | `53a397818face350217fd47e3ae056ae62fa2d3598c1f70cbd36950f4370606d` |
| `Li_2507.02885v1.pdf` | Runbo Li, *On the exceptional set in the abc conjecture*, [arXiv:2507.02885v1](https://arxiv.org/pdf/2507.02885v1) | Theorem 1.3 / stated `56/85` global exponent. Recorded as historical comparison; superseded for this audit by BBLT v2's `0.6` theorem. | `17e9d7acad2b0af655afd50573a7fb6bb059a46a18735735b96f61b27b911692` |

The current four-author primary source is already pinned at
`research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`, SHA-256
`ee57b904398692ffecd0ccf8ccdcb0641f8e63ba6b971d6c9343bbac60d53470`.
Its Theorem 1.3 gives `N_lambda(X) << X^(0.6+epsilon)` for fixed
`lambda in (0,1)`, and Proposition 1.1 records the de Bruijn radical-tail
consequence used by the inherited affine pair-projection upper bound.

No externally cited statement is introduced as a Lean axiom.
