# Eisenstein descent and exact boundary divisibility

Author: **ChatGPT**. September 5, 2026, America/Chicago.
Inspected baseline: `9edd965d6df645dbebc0869530f3f5a40fb8cddc`.

**Status: partial research, not an unconditional proof or disproof of ABC.**
Forty named standalone Lean theorems have actually passed compilation and
axiom checking. The general boundary gcd and orbit strong-divisibility
identities are fully covered by those files; the all-triple Euclidean
coverage theorem and asymptotic radical interpretations are ordinary proofs.

## Mathematical results

Represent `x+y*rho`, `rho^2=rho-1`, by `(x,y)`. Put
`N=x*x+x*y+y*y`, `F=x*y*(x+y)`, and `H=max(abs(x),abs(y),abs(x+y))`.

1. Every primitive nonunit pair has an actual factorization `z=pi*w` with
   `N(pi)` a rational prime and `H(w)<=2*H(z)/3`. Iteration covers every
   primitive abc triple without requiring common integer powers. This is
   algebraic coverage, not a radical-loss estimate.
2. For **every** primitive `w` and **every** integer pair `beta`,
   `gcd(abs(F(w)),abs(F(beta*w))) = gcd(abs(F(w)),abs(F(beta)))`.
   This is an exact gcd, including multiplicities, not only a support bound.
3. On the orbit `(2+rho)^n=(x_n,y_n)`, all pairs are primitive and
   `F_n=6*U_n`, where `U_0=0`, `U_1=1`, and
   `U_(n+2)=20*U_(n+1)-343*U_n`. The whole boundary sequence satisfies
   `gcd(abs(F_m),abs(F_n))=abs(F_gcd(m,n))` for all natural indices.
4. For `n=6*j+1`, the signed cubic quotient is exactly
   `(x_n^3-y_n^3)/(x_n-y_n)=7^n`, and `abs(x_n)=2 mod 4` is not a
   nontrivial perfect power. The first-appearance excess is `7^(n-1)`;
   with `h=max(abs(x_n),abs(y_n))` it lies between `3*h^2/28` and `3*h^2/7`.
   This refutes independent subquadratic excess estimates on normalized
   signed homogeneous bases. It is not an ABC counterexample.
5. At `z=(2+rho)^6`, **all** prime-norm parents are unit-equivalent to
   `(2+rho)^5`. The associated triples are `(37,323,360)` and `(62,87,149)`.
   Height increases from 149 to 360 while radical falls from 803706 to
   358530. Thus choosing another prime-norm factor cannot rescue the
   universal pointwise no-loss policy. In addition, `1+48=49` at
   epsilon `1/25` violates constant one although both factors of every
   prime-norm factorization satisfy it. Amortized descent is not refuted.

Full proofs and precise dependencies are in
`paper/ChatGPT_ABC_Eisenstein_Descent_2026_09_05.tex`.
The conversation artifact additionally supplies the eleven-page PDF.
Priority outside the inspected project and external peer review are not claimed.

## Formal checks actually performed

The first complete 40-theorem check is commit
`b228479c215d45d6555e56a1f6b42c08b665a8fb`, Actions run `34005200961`,
job `101410985755`, conclusion `success`. It used Lean 4.32.2,
compiler commit `f3b06c705e6c85f5314019d5d3baab0fec5b580c`, with
warnings treated as errors. All 40 axiom queries passed; their union is
`propext`, `Classical.choice`, `Quot.sound`, with no `sorryAx`.
The final integration workflow reruns both the finite replay and actual
compilation. Saved normalized axiom reports are not substitutes for compilation.

`EisensteinDescent.lean` contains 29 theorems. `BoundaryGcd.lean` imports
its freshly generated `.olean` and contains 11 more. The latter proves
the complete boundary gcd theorem under `Int.gcd x y = 1`, the actual
orbit primitivity, and strong divisibility for arbitrary indices.
The Euclidean coverage proof, general real height estimates, full prime
classification of the finite obstruction, and asymptotic cubic-radical
interpretations are **not** completely formalized. The product identities
in the numerical Lean certificate are not a general radical implementation.
There is no final `ABCConjecture` term.

## Reproduction

From this directory with Python 3.10 or later:

```sh
python3 verify.py
```

This checks manifest hashes, regenerates the full default JSON, compares
its bytes, and checks the format of saved axiom reports. It does not run Lean.
Two complete original local replays were byte-identical. Counts: 230,000
full gcd cases; 24,339 primitive triples and 51,381 actual descent steps;
58,081 index-pair gcd checks; 476 norm/Lucas indices; 80 normalized cubic
quotients; ten small full-factorization cubic checks; and all twelve prime-norm
factorizations of the positive-defect counterexample. Those finite counts
are not proofs of universal assertions.

Inside an existing x86_64 Ubuntu/WSL terminal:

```sh
sudo apt-get update
sudo apt-get install -y curl ca-certificates tar zstd coreutils python3
bash wsl/verify_lean.sh
```

The second command installs checksum-pinned Lean in an isolated directory,
compiles both modules and checks the **actual** axiom output. It does not
modify elan defaults or the original repository toolchain. Hosted Ubuntu
execution is not execution in the user's personal WSL, which was not accessed.

## Remaining gap

The full factor descent exists, but no independent uniform estimate on its
radical loss has been proved. A bound on the total telescoping loss would
simply restate ABC and is not presented as a weaker bridge.
The cubic family requires joint control of
`rad(abs(x_n*y_n*(x_n-y_n)))`; it is not the strong-divisibility boundary
`rad(abs(x_n*y_n*(x_n+y_n)))`. Conflating these two forms is invalid.
The inherited IUT, geometric, transport, and fixed-parameter first-valuation
gates remain open. See `ROUTES.md` for the explicitly scoped registry.

Existing research files, workflows, toolchains and verified imports are
unchanged by this additive checkpoint. Its new modules are isolated from
the established main Lean build. No full-repository build, autonomous
subagent audit, or external peer review is claimed.
