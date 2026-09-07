# Second-round independent arithmetic review and formal residue counting

Author: ChatGPT. Date: 2026-09-07.

This directory is separate from the published first-round files. It contains
partial research and scoped formal verification, not a proof or disproof of ABC.

`ordinary_proofs.md` precedes and explains the eight proofs in
`Lean/ShiftedResidueCounts.lean`. The module uses Std only and proves:

- the actual residue-hit parameterization with a unique bounded integer index;
- the exact cross-multiplied count error smaller than one period, including
  modulus one and empty intervals;
- an actual recursive Eisenstein family with boundary exactly divisible by five
  and not by twenty-five at every index;
- exact depth two for the step element, realizing the finite-stopping case.

All eight declarations passed Lean 4.32.0 with warnings as errors and only the
standard axioms `propext`, `Classical.choice`, `Quot.sound`. The
critical-bottleneck agent independently reviewed the ordinary proof and all
formal signatures, and confirmed the scope and boundary cases. The module does
not formalize the general norm-one group classification, primitive-factor
classification, full real weighted discrepancy or global limit theorems.

From the repository root:

```sh
python3 research/checkpoints/2026_09_07_adversarial_audit/second_round/verify.py
bash research/checkpoints/2026_09_07_adversarial_audit/second_round/wsl/verify_lean.sh
```

The independent replay checks 50,096 exact residue-count cases, 101 actual
stopping-orbit rows, all 28,392 relevant pairs modulo 169 for the quartic
thirteen-adic obstruction, and the 67/967 exponent lifts and compatible CRT
classes. The second norm at g=199 has 337 decimal digits and exact 67-adic depth
two; its complete factorization is not claimed.

The finite replay writes canonical UTF-8/LF bytes on every operating system.
Its results SHA-256 is
`592028bac810492d82ab1012f5c800e76f9fc3a4f23d7d54c60d29746d457aa7`.
The earlier Windows CRLF serialization was replaced without changing any
mathematical result or test case.

The later independent reviews are in `lambda_refinement_review.md` and
`radical_transport_review.md`. The former checks the full ramified,
dependent, and unit branches of the new remainder-proportion estimates;
the latter checks the actual Mathlib radical transport and its conditional
connection to the repository's original ABC statement. Neither supplies
the unresolved arithmetic family or global signed-tail bound.
