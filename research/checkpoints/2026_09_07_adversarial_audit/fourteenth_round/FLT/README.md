# Official FLT audit and an actually reusable small proof

Review date: 2026-09-07. Reviewer: adversarial_audit.

**Local result:** two unchanged official sources and a direct-import bridge were freshly compiled with the project's Lean 4.32.0 and pinned Mathlib cache. The resulting theorem is `S₂(Γ₀(2)) = 0`, with exactly the standard three axioms. **The complete FLT import has not been locally compiled.** The isolated official 4.33.1 toolchain is installed; the existing ABC toolchain and published thirteenth-round sources were not changed.

## Exact official identity and full statement

The [Anthropic research announcement](https://www.anthropic.com/research/formalizing-fermats-last-theorem), dated September 4, 2026, directly links the public repository [anthropics/fermats-last-theorem](https://github.com/anthropics/fermats-last-theorem). Read-only Git and GitHub checks pinned the actual checkout to:

`aa2d8b34692b16c70f699536de0d8e75b9a3e9ef`.

This repository contains a complete-FLT theorem, not only a proposed statement or project skeleton:

- [Theorems/Thm_fermat_last_theorem.lean, line 128](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/Theorems/Thm_fermat_last_theorem.lean#L128) quantifies over all natural exponents at least three and all positive natural bases.
- [FinalCheck.lean, lines 1–8](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/FinalCheck.lean#L1) imports that theorem, guards its printed axiom list, and derives `flt_mathlib : FermatLastTheorem` at line 7. It also prints the latter's axioms.
- The chosen theorem's proof wrapper invokes `P2MW.S_fermat_last_theorem.solution`; the [solution, lines 129–130](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/P2M/Sol/S_fermat_last_theorem.lean#L129) calls `FLT.fermatLastTheorem`. The next proof reduces to odd primes, using Mathlib's exponent-three theorem and the Frey-package argument for primes at least five.

The current ABC Mathlib `FLT/Basic.lean` instead defines `FermatLastTheorem`; the definition itself is not a proof. The official `flt_mathlib` has that proposition as its proved type. `FullFLTBridge.lean.example` records the intended exact import interface, clearly marked **not locally compiled** and excluded from the Lean inventory.

## Pins, trust status, and build preflight

The official [lean-toolchain](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/lean-toolchain#L1) specifies 4.33.1. Its [lakefile, line 12](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/lakefile.lean#L12) pins Mathlib `db584cd6d46c92f209a44c0f1c829460d327499d`. Our tested small proof uses 4.32.0, Mathlib `81a5d257c8e410db227a6665ed08f64fea08e997`. Oleans cannot simply be shared between these Lean versions.

The authors [report](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/README.md#L30) a fresh 60,475-module build, a comparator check, and an independent nanoda check. Their stated footprint includes 67 GB of build products, approximately 220 GB transient C output, and up to 36 GB for a single module. They state no matching precompiled Mathlib cache exists for their toolchain; comparator is substantially more memory intensive. These are **author-reported runs**, not runs independently repeated in this audit.

Live GitHub API inspection found no releases. The sole visible successful Actions run at the pin, 33887573561, was **Pages deployment**, not proof CI. Its `github-pages` artifact was expired. The published comparator/nanoda directories provide scripts and configurations; no full proof-build log or downloadable proof olean asset was found in this audit. Their comparator `Challenge.lean` deliberately contains `sorry` and is outside the proof package; it must not be misreported as a gap in the packaged proof. We did not scan all 60,000-plus source files or independently replay the full proof's axiom closure.

Actual resource inspection is bound in `verification/resource_preflight.json`: WSL has approximately 62.7 GiB RAM and 16 GiB swap, 24 CPUs; the physical E: filesystem had about 167 GiB available. The roughly 830 GiB virtual ext4 free space is not physical backing capacity. Therefore no full build or comparator was started. This is a resource-limited local verification boundary, not a mathematical objection to the official theorem.

The exact pin is checked out sparsely in `/root/abc-flt-20260907` (13 MB). The new 4.33.1 compiler reports commit `819816b2e0a3bf405af45ae5c7af2491d8f5bee6`. Installation used `elan toolchain install leanprover/lean4:v4.33.1`, without changing the default or the old build. A stale WSL Git proxy prevented the first lightweight clone; per-command `git -c http.proxy= -c https.proxy=` resolved it without changing global configuration.

## Actually compiled narrow dependency closure

The chosen module is mathematically useful to level-lowering arguments and imports only seven existing Mathlib modules plus `P2M.Util`. Its two local files are:

| Official source | SHA256 |
| --- | --- |
| `P2M/Util.lean` | `66f62069b83c0cf97531f88e5bd2c249e471df011ad873b0bd034eb959b1d8da` |
| `P2M/Sol/S_ModularForm_S2_Gamma0_2_eq_zero.lean` | `e9c16a42e589727cf2902879750087479c936629236ba07a943047bccd276d63` |

The [solution at line 211](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/P2M/Sol/S_ModularForm_S2_Gamma0_2_eq_zero.lean#L211) uses Mathlib's actual `CuspForm` and `CongruenceSubgroup.Gamma0` types. The proof establishes index three, takes the norm of a weight-two cusp form to weight six at level one, and uses the vanishing of that level-one space. The complete selected proof and helper source were read. No official byte was changed.

An initial isolated compilation succeeded. The reproducible script was then actually executed in a second **fresh output directory**. It independently checks source hashes and the Mathlib pin, builds both sources, creates and compiles `S2Bridge.lean`, and checks the two exact axiom-output lines. The report `verification/small_reuse.json` contains the complete outputs, exact commands, fresh paths, compiler identity, source and log hashes. Its SHA256 at execution is `333d014de95948d8db64e08478617428fb6fbd677f9bffe21d277fa4ae2fb039`.

Both the official solution and the directly derived bridge report `[propext, Classical.choice, Quot.sound]`. The official source emitted two deprecation warnings (an import alias and `tendsto_finset_prod`), not proof errors. Existing Mathlib oleans were reused; Mathlib itself was not rebuilt. This validates a genuine unchanged **source-compatible subproof** on 4.32.0, not binary compatibility of official 4.33.1 artifacts or local verification of complete FLT.

Reproduce inside WSL, with the existing pinned ABC cache available:

```sh
python3 /mnt/e/agent/ABCConjecture/research/checkpoints/2026_09_07_adversarial_audit/fourteenth_round/FLT/verify_small_reuse.py \
  --output /root/abc-flt-small-432/repeated-evidence.json
```

The script downloads only the two hash-pinned source files. `--source-dir` optionally uses an existing exact source copy. Each execution creates a new local build directory, writes complete logs, requires exact successful axiom output, and exits nonzero on compilation or hash mismatch. No existing ABC source or cached olean is written. The upstream code is Apache-2.0, as stated in its pinned `LICENSE`/`NOTICE`; this package records URLs and hashes rather than redistributing those source files.

## What can and cannot replace the existing ordinary inputs

The official [proof-path strength table, lines 81–97](https://github.com/anthropics/fermats-last-theorem/blob/aa2d8b34692b16c70f699536de0d8e75b9a3e9ef/PROOF-PATH.md#L81) matters: the named Mazur result is Frey irreducibility, not the general rational torsion classification; Wiles is formulated for a chosen semistable integral model; Ribet is the Frey conductor-supported level-lowering statement. These restrictions were cross-checked against selected actual theorem signatures. None automatically replaces the current quadratic-field Q-curve, additive-at-two/three, or general Ribet/Khare–Wintenberger ordinary arguments. A future reuse must first match the exact hypotheses and definitions, then build that selected closure.

The verified `S₂(Γ₀(2)) = 0` is now available as a concrete small import. It does not eliminate the current level-288/576 candidates, provide general modularity, or prove ABC. All other analytic, geometric and adversarial routes remain open.

## Actual complete import graph, without a full build

A separate read-only analysis streamed the entire pinned source archive, bounded by 512 MiB of compressed input and 16 GiB of expanded logical input. The actual archive used 272,017,611 compressed bytes and 1,563,898,473 expanded logical bytes. It was not unpacked to disk. Each of its 60,478 `.lean` files was hashed and its `import` lines extracted. This is a lexical **module-import** graph, not a minimized proof-term dependency graph, a theorem-semantic review, or an axiom audit.

The actual transitive closures, independently traversed from the recorded imports, are:

| Target | Local modules |
| --- | ---: |
| `FinalCheck` | 60,475 |
| `Theorems.Thm_fermat_last_theorem` | 60,474 |
| `P2M.Sol.S_fermat_last_theorem` | 60,473 |

The first includes 29,511 theorem modules, 29,511 solution modules, 1,450 definition modules, `P2M.Util`, one `P2M.Derive` module, and `FinalCheck`. The other three Lean files in the archive are the lakefile and comparator Challenge/Solution. Consequently, merely bypassing `FinalCheck` saves one module, and bypassing the last theorem wrapper saves one more; neither materially reduces the published import closure. This conclusion comes from actual source imports, not solely the earlier generated website graph.

The closures have **1,706 external direct imports: 1,705 Mathlib modules plus `Lean`**. Every one of those Mathlib source paths and cached olean paths exists in the present 4.32.0 build. The standard-library `Lean.lean` and `Lean.olean` were checked separately in the 4.32.0 toolchain. Thus the missing-path lists are empty; API and theorem compatibility of the remaining 60,000-plus local modules has not thereby been proved.

The deterministic gzip `verification/full_import_graph.json.gz` retains every source hash and import list. Its uncompressed report hash is `59e08b96e46fbffc586df6383ec6e463a0f6f23cff9cb6bb1ddab6d8b6cd424a`. `verification/full_import_summary.json` separates external/Mathlib/standard-library imports and records the actual file checks. `verify_import_graph.py --check` was actually run successfully: it checks the gzip/report hashes and recomputes all three closures without rewriting evidence. Optional `--refetch` independently streams and hash-checks every source against the fixed archive; the final wrapper's refetch mode has not been separately rerun after the original complete stream acquisition.

The full-import goal remains active. A lean-only build using `-o` need not generate the author's 220 GB of C output. Such a build could reuse the old cache only if actual 4.32 source compatibility holds; this is not inferred from zero missing import paths. Further capped, resumable compatibility probes and resource measurements are kept in `fifteenth_round/FLT`, outside this frozen fourteenth-round evidence. No full-build resource estimate is extrapolated from the two-file result.
