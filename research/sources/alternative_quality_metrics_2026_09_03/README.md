# Sankaran alternative-quality source capsule

Retrieved from the official arXiv record on 3 September 2026.

- Akilan Sankaran, *Variants on the abc-Conjecture using Alternative Quality
  Metrics*, arXiv:2606.08416v1, 7 June 2026, 24 pages.
- Abstract page: <https://arxiv.org/abs/2606.08416>
- Versioned PDF: <https://arxiv.org/pdf/2606.08416v1>
- License recorded in the PDF: CC BY 4.0.

The `.txt` file is a UTF-8 extraction produced with the bundled `pypdf`
runtime.  Nonprinting PDF extraction controls were replaced by spaces; it is
provided for search and quotation location, while the PDF is authoritative.

Scope audit: the paper studies doubly geometric mean and power-mean quality
metrics.  Its unconditional use of Chen's theorem proves divergence for an
alternative metric, not the standard abc conjecture.  The packing-efficiency
identity in Theorem 4.13 and the equivalence in Theorem 4.15 are useful
coordinate changes, but the latter supplies no new upper bound unless abc is
already assumed.  This capsule therefore supports comparison and concept
design only; it is not evidence that abc has been proved.

Independent scope check: the decay clause of Lemma 4.12 holds with the
number of prime factors and the complementary product fixed while one prime
grows.  The extension following Theorem 4.13 applies it in a regime where
the prime count grows and the complementary product may vary.  The claimed
packing-efficiency decay does not follow from the displayed largest-prime
hypothesis alone.  The accompanying identification of
`log(P_n) = O(log(c_n))` with `P_n ~ c_n^kappa` is also not an equivalence.
Separately, the displayed critical-boundary proof of Theorem 4.10 derives an
upper estimate but calls the limiting constant exact; the later limsup upper
bound needs only the estimate.  These issues do not affect the exact identity
`q_standard = eta*q_DGM`, Theorem 4.15's algebraic equivalence, or the
Chen-based divergence result for the alternative metric.  See
`research/ABC_ALTERNATIVE_QUALITY_PACKING_AUDIT_2026_09_03.md` for the proof
boundary and a clustered-prime-coordinate stress test.
