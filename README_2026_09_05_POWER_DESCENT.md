# Power descent and normalized first-appearance obstruction

The [power-descent checkpoint](research/checkpoints/2026_09_05_power_descent/README.md)
contains the complete ChatGPT-authored English proof source, an exact radical
budget and same-constant descent criterion, an infinite normalized family
with first-appearance factor `T_3(x,1)>x/28`, and a sharper pair-energy lifting
estimate for arithmetic derivatives.

Twenty-nine scoped Lean theorems, including universal statements for every
recursion depth, passed Lean 4.32.2 and the explicit axiom whitelist. General
radical translation and the real-valued proximity theorem have ordinary
proofs, not complete formalizations. This is **partial research, not an
unconditional ABC proof or disproof**.

From the repository root:

```sh
python3 research/checkpoints/2026_09_05_power_descent/verify.py
bash research/checkpoints/2026_09_05_power_descent/wsl/verify_lean.sh
```

The second command invokes the real compiler. Its isolated Linux installer
is suitable for an existing x86_64 Ubuntu/WSL distribution. The user's own
WSL was not remotely accessed. Earlier research and verified project imports,
dependencies, and toolchain are unchanged. See the checkpoint's route registry
and verification record for exact mathematical and formal boundaries.
