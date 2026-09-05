# Unitary faces, multi-output transport, and exponent lifting

Author: ChatGPT. Third September 5, 2026 supplement.

**Status: partial mathematical research, with 14 actually compiled elementary Lean theorems. Not a proof or disproof of standard ABC.** The required uniform estimate is unresolved.

## Main results

1. **Sharp general unitary-face threshold.** For a primitive positive triple `a+b=c`, a unitary divisor `M>=4` of `c`, and an actual nonempty proper whole-prime-power face `(A,B)` with `M | A+B`, the product `ab` is at least `(M-1)(2M+1)`. When `M=1 mod 3`, the sharper lower bound is `(2M-1)(M+1)`. Both are attained for every eligible `M`. Within-arm coprimality is essential. The paper gives the complete arithmetic proof and sharp constructions.
2. **Once-charged multi-output successor.** A block may serve several genuinely compatible proper-face outputs, but their product is bounded by its single surplus budget. The exact height accounting remains valid. A finite cut formula computes the full residual for fixed blocks and ownership. This is explicitly a new model, not a silent alteration of the old FCRT definition.
3. **Uniform repeated-lifting budget.** For `x>=2, n>=1`, the excess factor of `x^n-1` splits exactly as `T*L`, where `L | n`. The two-adic case is handled separately. The uncontrolled first-apparition factor is `T`, not `L`. The paper proves a uniform ABC bound on the explicit restricted stratum `T<=n^A`, without claiming this stratum exhausts the triples.

## What was formally checked

`Lean/CapacityAndLifting.lean` imports only `Std`. Successful check:

- Lean 4.32.2, compiler commit `f3b06c705e6c85f5314019d5d3baab0fec5b580c`.
- Source commit `539db3ad12faeb5a78ebc18b2a44895218744a6a`.
- GitHub Actions run `33968189781`, job `101311920225`, conclusion `success`.
- Command: `lean -DwarningAsError=true research/checkpoints/2026_09_05_multiflag/Lean/CapacityAndLifting.lean`.
- 14 theorem declarations and 14 executed axiom queries.
- Axiom union: `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`.

Formal scope: discrete two-output allocation, zero transfer without faces, elementary product estimates, the parity-excluded unit cell, the **baseline threshold in explicit arithmetic normal form**, and the geometric-sum congruence/gcd identity.

The complete actual-face-to-normal-form map, the mod-3 improvement and all-modulus sharpness, the real-capacity cut theorem, full arithmetic accounting map, and full valuation-lifting theorem have ordinary proofs but are **not all formalized** here. Nothing in this module states or assumes `ABCConjecture`. Earlier uncompiled drafts and the existing project toolchain/build are unchanged. Two earlier versions of this new module failed to compile and were repaired; only the successful source is certified.

## Reproducibility and scope

Run the self-contained core checks from the repository root:

```sh
python3 research/checkpoints/2026_09_05_multiflag/verify.py
```

This requires Python 3 and a C++17 compiler. It checks the successful Lean source hash (not a substitute for compiling Lean), compares two independent exact rational network solvers on 5,000 seeded cases, and repeats the `c<=5000` unitary-face scan. The separate read-only GitHub workflow compiles the Lean module with a checksum-pinned compiler.

The **expanded conversation research bundle** additionally contains the 38 selected arithmetic triples, full block/ownership enumeration and its 1,273 cut/augmentation comparisons, the 498 supplied power-neighbour factorization certificates and deterministic verifier, original raw output JSON, and the compiled PDF. Those larger supplementary datasets and their replay scripts are not duplicated in this core repository import. Their results are separately labelled in `verification/summary.json`; `verify.py` does not claim to rerun them.

The arithmetic scan found **no strict improvement in any of the 38 selected triples**. The abstract two-output example is not asserted arithmetically realizable. Finite scans do not prove the global uniform estimate. Independent algorithms were used; independent autonomous research agents and external peer review are not claimed.

## Remaining mathematical obligations

The sufficient global target remains `E_multi <= epsilon*log(rad(abc)) + C_epsilon`, uniformly in every primitive positive triple, for every positive epsilon. No proof is supplied for this estimate. No-face regions have no new output edges at all. The first-apparition budget `T` is not globally bounded. IUT all-place/Ind1--Ind3/same-pilot constructions, the canonical correlated defect, compensated packets, Pell valuations, Mersenne depth-three counting, positive five-term fillings and geometric uniformity retain their prior unresolved status. No parent route is retired merely because it is difficult or because a finite search is null.
