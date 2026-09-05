# September 5 transverse-lifting results

See the [quantitative transverse lifting checkpoint](research/checkpoints/2026_09_05_transverse_lifting/README.md) for the full ChatGPT-authored English paper source, constructive exact algorithms, two actually compiled standalone Lean modules, a WSL-compatible isolated setup, and reproducibility records.

The ordinary mathematics bounds the integer-lifting overhead by `(log_2 c)^2/2 + log_2 c` and proves that the proposed uniform small-transverse-derivative condition is equivalent to ABC. A checked counterexample at `5+7=12` shows primitive Wronskian classes need not minimize the norm. The large benchmark's exact minimum is also formally checked.

**This is partial research, not an unconditional ABC proof or disproof.** The general lifting and equivalence proofs are not fully formalized. Twenty-four scoped Lean theorems and their axiom queries passed; neither source states `ABCConjecture`. Existing toolchain and verified imports are unchanged.

From the repository root:

```sh
python3 research/checkpoints/2026_09_05_transverse_lifting/verify.py
bash research/checkpoints/2026_09_05_transverse_lifting/wsl/verify_lean.sh
```

The second command works inside an existing x86_64 Ubuntu/WSL environment with the dependencies documented in the checkpoint. It was tested on hosted Ubuntu; the user's own WSL was not remotely accessed.
