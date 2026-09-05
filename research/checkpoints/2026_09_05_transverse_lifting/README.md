# Quantitative transverse lifting checkpoint

Author: **ChatGPT**. Date: September 5, 2026.

**Status: partial research, not an unconditional proof or disproof of ABC.** The general lifting and equivalence theorems have ordinary proofs. Twenty-four named theorems about two exact arithmetic optimization problems have actually passed standalone Lean 4.32.2. Neither those modules nor their successful tests assert `ABCConjecture`.

## Main mathematical result

For a nontrivial primitive triple `a+b=c`, write `R=rad(abc)`, `D=abc/R`, and let `I*Z` be the exact Wronskian image. Put `J=I/D` and

```text
h0 = (J/R) * max(c/(Omega(a)+Omega(b)),
                 b/(Omega(a)+Omega(c)),
                 a/(Omega(b)+Omega(c))).
```

The least integer norm in Wronskian level `m` satisfies

```text
|m|*h0 <= H_m <= |m|*h0 + E,
E <= (log_2(c))^2/2 + log_2(c).
```

The proof gives an actual construction: exact exponent-content formula, nearest CRT representatives, a bounded residue-graph correction, and rounding in the one-dimensional aggregate fibre. It handles all nonzero levels and entries equal to one. It assumes the factorizations are available; it is not an efficient factoring algorithm.

Consequently the previous uniform small-transverse-derivative condition is **equivalent** to ABC. It is not an independently weaker bridge and remains unresolved. The theorem controls the auxiliary integer-realization overhead, not the scalar defect `c/R`.

A new exact counterexample at `5+7=12` has `I=4`, least transverse norm `1/5`, and least primitive-class norm `2/5`. Every transverse minimizer has level `3` or `-3`, not level `1` or `-1`. The earlier benchmark `2+3^10*109=23^5` has minimum `1644/23`; the new constructor reaches that value without a lattice search.

Full definitions, proofs, edge cases, dependency audit and remaining gap are in `paper/ChatGPT_ABC_Transverse_Lifting_2026_09_05.tex`. The conversation bundle additionally supplies the compiled PDF. Priority outside the inspected project and external peer review are not claimed.

## Reproduce the exact computations

From the checkpoint directory, with Python 3.10 or later:

```bash
python3 verify.py
```

This checks the source manifest, regenerates the default exact results, compares their bytes with the supplied JSON, and validates the saved axiom-report format. It **does not run Lean**. The default replay covers 30,000 content profiles, 29,995 local lifts, 2,400 further lifts on 1,200 generated factorizations, 54,749 normalized primitive triples, and 2,256 additional signed levels. Two original complete runs were byte-identical. Finite checks are not the proofs of the general theorems.

## Run Lean in an existing WSL Ubuntu environment

Inside an x86_64 Ubuntu/WSL terminal, from this checkpoint directory:

```bash
sudo apt-get update
sudo apt-get install -y curl ca-certificates tar zstd coreutils python3
bash wsl/verify_lean.sh
```

The script installs checksum-pinned Lean 4.32.2 under `~/.local/share/abc-research/` by default, runs both `.lean` files with warnings treated as errors, and checks all declared axiom-query reports against the whitelist `propext`, `Classical.choice`, `Quot.sound`. It does not change elan defaults or the repository's existing `Lean/lean-toolchain`. `ABC_LEAN_HOME` can select a different isolated installation directory.

The same setup-and-check script is executed by the dedicated GitHub Actions workflow. Actual hosted execution is on Ubuntu, **not on the user's own WSL machine**, which was not remotely accessible. This does not build the entire repository or formalize the general CRT lifting theorem.

The first successful 24-theorem source run is `33970484302`, job `101317995486`, commit `3bf8bd92cef6bbd74f571eeb50035cc01271b1e4`. See `verification/validation.json` for source blob hashes and the exact scope. `verification/lean_axioms.txt` is a normalized transcription of the axiom output, not a replacement for the original hosted logs. The final integration workflow additionally runs the whitelist parser and finite replay.

## Integration boundary

This checkpoint is additive. Existing research, verification ledgers, toolchain files, dependencies, and verified import graph are unchanged. The new standalone modules are not imported into the established project build. Their successful compilation is a scoped verification result, not a proof of standard ABC.
