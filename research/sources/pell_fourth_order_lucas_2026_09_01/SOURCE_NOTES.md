# Source notes: fourth-order and all-order Pell--Lucas congruences

**Audit date:** 2026-09-01

**Auditor:** ChatGPT

## Primary source

Geng-Rui Zhang, *13 unknowns over quadratic integer rings and Lucas
congruences*, arXiv:2608.30389v1, submitted 2026-08-31.

Official records:

* abstract: <https://arxiv.org/abs/2608.30389>
* version-1 PDF: <https://arxiv.org/pdf/2608.30389>
* version-1 source export: <https://export.arxiv.org/e-print/2608.30389>

The local PDF has 25 pages.  The source export contains the submitted TeX
and arXiv's `00README.json`.  The `.txt` file is a page-delimited extraction
made with `pypdf`; it is convenient for search but is not authoritative for
formulas.  Formula checks used the PDF rendering and the submitted TeX.

## Imported statements and literal quantifier boundary

The Pell report imports only the following source results.

1. **Proposition 5.1 (all-orders expansion).**  For the norm-one Lucas
   recurrence with characteristic polynomial `X^2-aX+1`, every positive odd
   multiplier `k`, and every positive `n` with `u_n != 0`, the quotient
   `u_(nk)/u_n` is the finite polynomial
   `sum_r c_r(k) delta^r u_n^(2r)`, with the explicit positive integral
   coefficients stated in the source.
2. **Corollary 5.2 (fourth-order expansion).**  Under the same hypotheses,
   the quotient is congruent modulo `u_n^4` to its constant and quadratic
   terms.  The companion identity is
   `v_(nk) = v_n (1 + (k^2-1) delta u_n^2 / 8 + u_n^4 Psi_k^*)`.
   It may be called a companion quotient only when `v_n != 0`; this extra
   condition is automatic in the report's `a=6` specialization because
   `v_n=2*A_(2n)>0`, but it is not part of Corollary 5.2's general
   hypotheses.
3. **Corollary 5.3 (exact deviation valuation).**  This is used only as a
   consistency check for support primes; the new all-order staircase is
   instead derived directly from Proposition 5.1 and the proved
   coefficient-coprimality lemma.
4. **Theorem 5.6 (local surjectivity).**  For fixed nonzero `u_n`, any
   nonzero divisor `s | u_n`, any odd `t`, and every residue class modulo
   `s`, infinitely many positive odd `k` congruent to `t` modulo `u_n^2`
   realize that normalized second-order residue.

No undecidability theorem, integrality-transfer theorem, Fibonacci
Wall--Sun--Sun conclusion, or density assertion from the paper is used in
the Pell proof.  In particular, Theorem 5.6 is a single-sequence local
surjectivity theorem.  It does not assert independent simultaneous control
of the `u` and `v` companion corrections.

## Specialization audit

The report sets

`alpha = 3 + 2*sqrt(2)`, `beta = 3 - 2*sqrt(2)`, `a = 6`, and
`delta = a^2 - 4 = 32`.

Then the source sequence is exactly

`u_n = B_(2n)/2 = A_n B_n`, `v_n = 2 A_(2n)`.

The all-orders theorem is applied with base index `n = ell` and multiplier
`k = ell`, where `ell` is an odd prime.  The additional fact that every
support prime satisfies `p >= 2*ell-1` is not claimed by Zhang; it comes from
the separately audited balancing-Pell rank and channel congruences in this
repository.

## Claim-risk notes

* This is arXiv version 1 and had not been treated as peer-reviewed in this
  audit.
* The submitted TeX says that the all-orders identity is a reformulation of
  the classical Lucas multiplication formula in Ballot--Williams (2023).
* The local-surjectivity result refutes fixed-residue rigidity for one
  normalized correction.  It does not refute the paired-companion or
  all-order routes.
* The repository does not promote any source theorem to a Lean axiom.
  Formal modules take external recurrence identities as explicit hypotheses
  and kernel-check the downstream algebra.

## Integrity

All hashes are recorded in `SHA256SUMS.txt`.  The PDF and source archive were
downloaded from the official arXiv endpoints above on 2026-09-01.
