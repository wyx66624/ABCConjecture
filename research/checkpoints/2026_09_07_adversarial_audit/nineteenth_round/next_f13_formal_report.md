# F13 finite arithmetic: actual fresh verification

Status: author fresh compilation PASS; critical-bottleneck complete independent source/scope/evidence review PASS. Root separately reported its own fresh fifteen-theorem compilation PASS. This is a future-batch result, outside the sealed 24-theorem publication.

The ordinary contract was written in `next_f13_formal_scope.md` before implementation. The final source `next_Lean/F13FixedCurveArithmetic.lean` proves fifteen theorems and prints exactly fifteen corresponding axiom queries. It imports no previous ABC project module.

The successful run used Lean 4.32.0 (compiler commit 8c9756b28d64dab099da31a4c09229a9e6a2ef35), Mathlib 81a5d257c8e410db227a6665ed08f64fea08e997, a new project `/tmp/abc-f13-kernel-fresh-rl8pt9vj`, and the existing read-only dependency cache. The command compiled only this source to an olean with warnings as errors. It returned exit zero. Every query uses only propext, Classical.choice and Quot.sound. No native evaluation axiom, sorry or new axiom occurs.

## Exact mathematical coverage

1. Literal polynomial evaluation and a Bezout identity in `Polynomial (ZMod 13)`. The latter follows from a polynomial linear combination of the proved coefficient equality 13=0. It is not a list of thirteen evaluations.
2. The exact fourteen-element affine sextic table, fourteen affine points on each of the two elliptic equations, two infinity signs, and sixteen valid points of the explicitly defined disjoint-sum data model.
3. The actual coordinate projections satisfy their affine elliptic equations on the nonzero, zero and infinity charts.
4. Substitution of the actual elliptic equation into the third-division x-numerator.
5. Nonzero-chart simultaneous numerator exclusion, the zero-chart psi value 7, the infinity-chart second numerator value 9, and the assembled finite-predicate exclusion over every valid model point.

Finite rational expressions use ordinary kernel reduction via `decide +kernel`, required because the definition of ZMod inversion contains gcdA. This option invokes the Lean kernel directly; it is distinct from `decide +native`. The corresponding proof terms were accepted and their entire axiom dependencies are recorded.

The disjoint-sum data model is not a construction of a smooth projective curve. The module does not identify the polynomial predicates with abstract elliptic multiplication by three. Good reduction, the prime-to-five index argument, p-adic analytic zero certification and the rational-point classification remain separately reviewed ordinary mathematics. None was inserted as an assumption or axiom here. This module makes no ABC conclusion.

## Reproduction and bound evidence

Run in WSL from any directory:

```sh
python3 /mnt/e/agent/ABCConjecture/research/checkpoints/2026_09_07_adversarial_audit/nineteenth_round/next_verify_f13.py --cache-project /root/abc-lean-build
```

The script creates a different fresh directory and evidence subdirectory on every invocation. It validates the cache pin and toolchain, binds source and scope bytes, records all queries and checks the entire axiom union. It compiles a literal copy of the source, checks that neither copy changed during the run, and hashes the resulting olean. Previous failed attempts remain marked FAIL; their compiler errors are not counted as proofs. No existing release manifest or cached dependency source was altered.

Final SHA256 values:

| Object | SHA256 |
| --- | --- |
| Lean source | a459a5f16e8f0b8f6a2dd2dbfd742c672721f3963220463eed10e8b456e006ec |
| Prior ordinary scope | d0135616ccf588da1d5ee58288184fab8386b1e0344f21ac0c48390dfe0fb1e1 |
| Reproduction script | c429f5f3f0fec012be8ea28911734f454b4a475af5276f22f01d0fa0dd6855fb |
| `next_verification/f13-20260908T055706020261Z/validation.json` | c1732fee24ee5f93e87ed8e1aecd93687f87dba98f550002124c6826c2476294 |
| Same run `fresh-build.log` | 9b802e7ef262bcb8ecb8508d3ad238ff5def73db1b1e01fdaf97ba92f0ae14df |
| Fresh olean | f69d7c0a7794b364eae4c2c36889ecb7def307e8133dd46a11d18183edb6e6ad |

The full final manifest and compiler log were read after completion, and all five repository-file hashes above were independently recomputed from the resulting files.

The independent semantic review is recorded in `research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round/next_f13_kernel_review.md`. That reviewer read all fifteen proofs and the scope, verifier, manifest and log, then recomputed the five hashes; it did not claim an additional compiler run. Root's separate fresh-run report is not substituted for the author manifest bound above.
