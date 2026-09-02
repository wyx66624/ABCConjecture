# Source audit: critical slow-slack Mersenne gate

**Date:** 1 September 2026
**Auditor:** ChatGPT

## Scope

This audit checks whether the latest primary sources already archived by the
repository give a uniform fixed-base-two estimate strong enough for either
surviving arm in
`ABC_MERSENNE_BALANCED_MULTIPLIER_DEPTH_LOCALIZATION_2026_09_01.md`, and it
checks the exact quantifiers used by the new slow-slack theorem.

## Findings

- Yamada's Theorem 1.2(7) is unconditional and pointwise for every prime
  `p`.  It bounds `v_p(2^(p-1)-1)` by
  `floor(283 (p-1) log(3) log(6)/(log p)^2)+4`.  It is the only external
  analytic input to the new proof.
- Murty--Séguin's exact-order valuation dictionary is unconditional.  Their
  polynomial largest-prime theorem assumes a uniform bound on all canonical
  valuations; their non-Wieferich theorem assumes finiteness of
  super-Wieferich primes.  Neither premise is available here.
- Pomerance's 2025 Theorem 1 is unconditional but proves compositeness for
  many primitive cyclotomic parts, not an upper bound for repeated weighted
  mass.  Theorem 2 is abc-conditional.  The Aurifeuillean splitting at
  indices `4 mod 8` gives no little-oh estimate for the combined repeated
  mass.
- Li--Zhao's 2026 Theorem 1.1 fixes one prime ideal and one non-torsion
  element before producing its depth threshold.  The threshold is not
  uniform over varying rational primes.
- Fellini--Murty's 2026 quantitative conclusions assume number-field abc or
  finiteness of the relevant super-Wieferich primes.
- Erdős--Murty is unweighted and global over almost all primes.  The
  large-sieve Fermat-quotient results average the base variable.  Neither
  controls the fixed-base-two exact-order/Wieferich intersection.

No source audited here proves the old arms (6.9), (6.10), or their critical
`sigma = 1` versions.  The slow-slack theorem does not claim otherwise.

## Primary records

- Yamada: <https://arxiv.org/abs/math/0607072>,
  <https://doi.org/10.1016/j.jnt.2010.02.018>
- Murty--Séguin: <https://mast.queensu.ca/~murty/murty-seguin.pdf>,
  <https://doi.org/10.1016/j.jnt.2019.02.016>
- Pomerance: <https://math.dartmouth.edu/~carlp/cyclotomicprimesfinal.pdf>,
  <https://doi.org/10.1016/j.jnt.2025.02.013>
- Li--Zhao: <https://arxiv.org/abs/2601.12753v1>
- Fellini--Murty: <https://arxiv.org/abs/2508.08472v2>,
  <https://doi.org/10.1016/j.jnt.2026.01.002>
- Erdős--Murty: <https://mast.queensu.ca/~murty/erdos-ram.pdf>
- Shparlinski: <https://arxiv.org/abs/1104.3909>

## Local evidence and integrity

The exact PDFs and text extractions used for the audit remain in:

- `research/sources/mersenne_balanced_multiplier_depth_2026_09_01/`;
- `research/sources/mersenne_prime_layer_radical_2026_09_01/`.

Their recorded hashes were rechecked before this audit.  In particular:

- Yamada PDF:
  `3fcba1b6672b97b15dc4163b52464ee58e435229167da0579d47b1f57bcca64d`;
- Li--Zhao PDF:
  `c7e22d14b5120263b5ed27e28f6723d68685f01f9c5f6aa10f4820f7ec510639`;
- Murty--Séguin PDF:
  `7760c4a0147d8285d04dad93bd69c5fa0abaa480e4a48014756ccae55e1ec68f`;
- Pomerance PDF:
  `6acc2701cd366a0e366b8721c16862fda2035b1e23ebbda85d24acbaa26ec5e6`.

The mathematical report gives the exact theorem-level applicability
analysis.  This audit adds no assumptions to the proof.
