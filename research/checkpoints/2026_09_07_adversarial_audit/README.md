# Independent adversarial audit and cubic defect amplification

Date: 2026-09-07. Author: ChatGPT.

This checkpoint is partial research, not a proof or disproof of standard ABC.
Its new ordinary proof appears in `paper/cubic_amplification.tex`. It proves
that an actual cubic power map has unbounded multiplicative amplification of
the cleared ABC defect on normalized bases, for each fixed integer m >= 2.
This refutes only the universal bounded-loss relative defect comparison.
Seed-sensitive power descent remains active.

## Independent audit of the existing latest estimates

- Read the complete 2026-09-06 moving-support and exponent-profile ordinary
  proofs, including the prime-norm envelope obstruction.
- Reopened the primary Bugeaud source, arXiv:2209.00275v1, Theorem 1.1 (1.2)
  and the first inequality of Theorem 1.3 on 2026-09-07. The degree-only base
  constants, exponential dependence on the number of logarithms, normalized
  local valuation and permissibility of a zero last p-adic coefficient match
  the actual applications. No issue was found in those particular inputs.
  Source: https://arxiv.org/html/2209.00275v1
- The verified ordinary estimates remain restricted by exponent profiles and
  signed large-prime excess. The local Lean modules do not formalize Bugeaud,
  Linnik, all asymptotic estimates or an unconditional ABC term.
- The main route ledger predates the latest checkpoints; those checkpoint
  route tables must also be read. Squarefree/prime norm inputs obstruct the
  specific optimized logarithmic-form envelope, not all norm methods.

## New proof dependencies

Polynomial digit lifting and the Chinese remainder theorem produce bases
x_h with v_2(x_h)=1 and 7^h dividing x_h^2+x_h+1. Elementary radical accounting
gives R_3 < 84 x_h R_1. The exact ratio of actual defects then grows at least
as x_h^(m-1)/84^(m+1). The proof does not use the previous T_n definitions,
unknown factors of the polynomial values, Linnik, or an ABC hypothesis.

The positive real-exponent version works for each fixed 0 < epsilon < 1.
The endpoint epsilon = 1 remains undecided by this argument.

`verify.py` independently checks CRT lifts, exact factorization and actual
radical ratios on a bounded range. Six fully factorized rows and 100 lifting
levels passed using exact integer and rational arithmetic. This is diagnostic
replay, not a proof of the infinite family or the final conjecture.

## Actual formal scope and reproduction

`Lean/CubicAmplification.lean` has nine named declarations, checked with
Lean 4.32.0, warnings as errors. They prove the polynomial cap and monotonicity,
an explicit root exceeding any given bound, normalized unbounded root
certificates, the compression-to-defect implication, and the impossibility of
a uniform relative bound conditional on the displayed compression inequality.
The actual radical function and its prime-factorization inequality are ordinary
proofs in the paper; the formal module does not assert that they have been
formalized. The nine declarations use only `propext`, `Classical.choice` and
`Quot.sound`. Their imported 29-declaration PowerDescent module was freshly
compiled by the same compiler. This is a scoped 38-declaration check, not a
full-repository build.

Run from the repository root in the existing WSL/Linux environment:

```sh
python3 research/checkpoints/2026_09_07_adversarial_audit/verify.py
bash research/checkpoints/2026_09_07_adversarial_audit/wsl/verify_lean.sh
```

`geometry_review.md` independently reviews the separate product-tripod proof
and identifies its precise characteristic-p boundary.
