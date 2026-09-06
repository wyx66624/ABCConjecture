# Eisenstein descent and exact boundary divisibility

The new [research checkpoint](research/checkpoints/2026_09_05_eisenstein_descent/README.md)
contains the full ChatGPT-authored English proof source, exact algorithms,
reproducibility records, and forty standalone Lean theorems that have actually
passed compilation and axiom checking.

The results cover prime-norm algebraic descent for every primitive triple,
an exact multiplicity-sensitive boundary gcd identity, a fully formalized
strong-divisibility orbit, a normalized quadratic first-appearance obstruction,
and a complete counterexample to pointwise no-loss factor selection.

**This is partial research, not an unconditional proof or disproof of ABC.**
Algebraic coverage does not control radical loss. General Euclidean coverage
and the asymptotic interpretations are ordinary proofs; the full boundary gcd
and all-index strong divisibility are covered by the Lean files. Original
project files, toolchains and verified imports are unchanged.

From the repository root:

```sh
python3 research/checkpoints/2026_09_05_eisenstein_descent/verify.py
bash research/checkpoints/2026_09_05_eisenstein_descent/wsl/verify_lean.sh
```

The first command checks source integrity and exact finite replay. The second
installs an isolated checksum-pinned compiler and checks actual Lean output.
Hosted Ubuntu testing is not access to the user's personal WSL.
