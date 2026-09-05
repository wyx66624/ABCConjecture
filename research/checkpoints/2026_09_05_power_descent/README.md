# Power-radical descent and pair-energy proximity

Author: **ChatGPT**. Research supplement: September 5, 2026.
Baseline: `d3f7b33b1115538920cb5fcd851a97f0c3a26a3d`.

**Status: partial research, not an unconditional ABC proof or disproof.**
The full English proof source is `paper/ChatGPT_ABC_Power_Descent_2026_09_05.tex`.
The compiled 11-page PDF is supplied in the conversation bundle, not duplicated
in the source import. No external priority or peer-review claim is made.

## Mathematical results

For coprime `x > y >= 1`, define `g_n=(x^n-y^n)/(x-y)`,
`R_1=rad(x*y*(x-y))`, and `R_n=rad(x*y*(x^n-y^n))`.
The exact relative balance is `R_n*B_n=R_1*g_n`, where
`B_n=E_2*L_n*T_n`, `L_n | n`, and `T_n` counts excess valuations at first
appearance of NEW primes relative to the chosen base pair. The explicit
factor `E_2=2^(v_2(x+y)-1)` is necessary when both bases are odd and `n` is
even; otherwise it is one. Odd sum powers have the analogous identity
without this extra correction. The complete budget has an exact composition
law; first-appearance factors alone reallocate under a change of base.

For the cleared abc ratio `Q_m=c^m/rad(abc)^(m+1)`, the difference power
ratio is exactly `x^(m*(n-1))*B_n^(m+1)/g_n^(m+1)`. Thus a seed bound transfers
with the SAME constant whenever `B_n^(m+1)<=x^(n-1)`. The odd-sum condition
is `B_n^(m+1)<=g_n`. A minimal failure of a fixed inequality in these strata
must violate this condition. Neither coverage of every triple nor a global
budget estimate is proved. A separate uniform large-exponent theorem has
explicit hypotheses `T_n<=n^A` and `n>=2*(1+epsilon)/epsilon`.

An infinite normalized obstruction is proved, not inferred from a scan.
Set `phi(x)=x*x+x+1`, `r_0=226`, `r_(k+1)=r_k+32*phi(r_k)`.
For every `k`, `v_7(phi(r_k))=v_7(r_k^3-1)=k+2`, while `r_k=2 mod 4` and
has order three modulo seven. Put `x_k=r_k mod (4*7^(k+2))`.
Then `x_k` is not a nontrivial perfect power, tends to infinity, and
`T_3(x_k,1)>=7^(k+1)>x_k/28`. Consequently no independent estimate
`T_3(x,1)<=C*x^theta` with fixed `theta<1` holds uniformly even on normalized
bases. This refutes that child estimate, NOT ABC or the coupled descent route.

The independent arithmetic-derivative route admits a new pair-energy
lifting envelope `kappa_N<=max_p(v_p(N)/gcd_q v_q(N))`, replacing the previous
sum of normalized exponents. If all normalized exponents are one, the new
error is `(omega(N)-1)/omega(N)<1`. The proof gives a terminating pair-move
algorithm. The real global minimum still contains the scalar factor `c/R`;
this local improvement does not prove its uniform bound.

## What was actually checked in Lean

`Lean/PowerDescent.lean` imports only `Std`. The 29 declarations and all
29 axiom queries passed checksum-pinned Lean 4.32.2 with warnings as errors:

- source commit `67af725edf41a7b4103eae055e9ee19c6be716c6`;
- source blob `eb665612004cc072255419b6fc5af464f4dc1ffe`;
- Actions run `33976085784`, job `101332907717`, conclusion `success`;
- axiom union: `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx`.

Formal scope includes the ALL-DEPTH polynomial orbit, exact seven-adic
power divisibility, exclusion of every nontrivial perfect power, bounded
representatives, abstract integer descent/cocycle cores under an explicit
radical balance, and the algebraic energy-exchange identity.

**Not fully formalized:** general multiplicative order/LTE, the full
radical mapping, real/asymptotic interpretation of the first-appearance
product, the real pair-energy theorem, or standard ABC. The 29 successful
theorems are not 29 proofs of ABC. `verification/validation.json` records the
two unsuccessful development runs as well as the successful source.

## Reproduce

From this checkpoint directory, with Python 3.10 or later:

```sh
python3 verify.py
```

This checks all manifested source hashes, reruns the exact program, and
compares the complete JSON bytes. It does **not** compile Lean. The default
replay covers 3,553 signed radical identities, 14,212 cleared transfers,
405 cocycle checks, 180 rebasing checks, 13 exact orbit valuations,
129 small representatives computed by two different algorithms, and 7,497
local energy lifts. Two original full replays were byte-identical.

Inside an existing **x86_64 Ubuntu/WSL** environment:

```sh
sudo apt-get update
sudo apt-get install -y curl ca-certificates tar zstd coreutils python3
bash wsl/verify_lean.sh
```

This installs Lean 4.32.2 under `~/.local/share/abc-research/`, checks the
release-archive SHA-256, invokes the actual compiler, and applies the
explicit axiom whitelist. `ABC_LEAN_HOME` selects a different isolated
installation directory. It does not change elan defaults or the repository's
`Lean/lean-toolchain`. The dedicated workflow uses the same script and also
runs the exact replay. Hosted Ubuntu is not the user's personal WSL, which
was not remotely accessed.

## Integration and audit boundary

This is an additive checkpoint: earlier research, toolchain, dependencies,
verified imports and existing workflows remain unchanged. The new standalone
module is not imported into the established main Lean project. The final
integration PR records its exact checked head. No full-repository build,
external peer review, or independent autonomous agents are claimed. Different
algorithms and ordinary proof checks are not described as independent human
proof review. The route/dependency registry is `ROUTES.md`.
