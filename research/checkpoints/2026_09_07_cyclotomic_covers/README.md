# Fifth continuation: actual cyclotomic packets and quantitative covers

Standard ABC remains unproved and undisproved. The designated manuscript is
`output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf`, now 408 pages. Ordinary
proofs and independent reviews preceded the scoped Lean formalization.

## Ordinary results and exact boundaries

- **CP1--CP5:** integer cyclotomic factors of the actual Eisenstein boundary
  isolate exact first-rank depths and later prime-power lifting. Their
  totient-weight budget sums to the exponent, avoiding a divisor-count loss.
  A precise sparse-positive-packet subclass has negligible normalized signed
  tail. Membership in that subclass, particularly the net top-rank saving at
  prime exponents, remains unproved in general.
- **HR1--HR3:** an infinite actual primitive family puts a depth-four prime
  at the maximal rank beyond the moving cutoff. This refutes automatic
  sparsity of ranks merely containing a deep prime. The selected prime's
  normalized cost tends to zero; the complete packet's sign is undetermined.
  It is not a counterexample to signed-packet saving or ABC.
- **QC1--QC6:** the fixed degree-eight splitting field permits at most
  `C_K * 4^(8 omega(V)) * g^9` covers for each actual g-free residual V,
  when g>8. All V<=exp(Lg), L<log(2), cost at most
  `C_K * g^9 * exp(17Lg)` covers. Coefficient heights are at most
  `2 log V + C'_K g`. Generic unit power classes have a proved linear
  height barrier. These counting and height statements supply no uniform
  bound for individual actual points, and the hard generic unit classes
  have not been shown to carry actual seeds.

The full source arguments and cross-reviews reside in the three agent
`fifth_round` directories. Root review and dependency scope are recorded in
`verification/ordinary_review.md`. Number-field and geometric statements
retain their named classical inputs and are not presented as kernel proofs.

## Formal scope

`Lean/GeneralLucasBoundary.lean` has ten new declarations for arbitrary
integer Eisenstein pairs: cubic trace and discriminant, shifted recurrence,
norm of every power, a general integer recurrence solution, the actual Lucas
formula, and boundary divisibility. Zero and negative inputs are included.

`Lean/QuarticSupportArithmetic.lean` has eleven new declarations. It transfers
finite residue identities to all primitive integer seeds, proves F=1 mod 3,
proves exact depth one whenever 13 divides F, and excludes 13 from every
extraction root Q in an actual F=VQ^g with g>=2.

Run the fresh standalone build with the repository-pinned toolchain:

```text
python3 research/checkpoints/2026_09_07_cyclotomic_covers/verify_round.py
```

Lean 4.32.0 accepted all 21 new and recompiled 44 unchanged dependency
declarations with warnings treated as errors. Every declaration received an
axiom inventory; only `propext`, `Classical.choice`, and `Quot.sound` occur.
The final source hashes, fresh build log and independent signature review
are included. This is not a full repository build or a formalization of
cyclotomic valuation classification, totient budgets, Kummer descent, unit
lattices, Faltings, or ABC.

## Finite checks and manuscript seal

All three finite checks were independently rerun by root with matching output:

| Replay | Scope | Reported SHA-256 |
| --- | --- | --- |
| critical fifth `replay.py --check` | 180 actual factorizations, 16560 valuations, 540 retained-prime signed assemblies | Canonical payload `81941c0830df549d9998b5e75d8687d82534ba328522e318e25ab2303edaf5db` |
| adversarial fifth `replay_high_rank.py` | 14 actual positive primitive maximal-rank/depth constructions | Whole artifact `0dd4ea0a667c7607db490684126ff827a34f1fa8b285276fd4369d32d3fcba9a` |
| independent fifth `exact_cover_arithmetic.py` | quadratic factors, discriminant 117, norm 13, complete primitive residue checks modulo 3 and 169 | Whole artifact `860bc44890b89079ad72911ff9cd038bd43920a4bd8406de23f02e804b94ee52` |

Canonical-payload hashes are distinguished from whole JSON byte hashes in
`verification/finite_replay_validation.json`. These finite checks supplement
the ordinary proofs; they are not infinite asymptotic certificates.

The full manuscript builds from 125 actual TeX inputs. The seal records all
input hashes, the PDF hash, and the 16 pages actually visually inspected:
page 1 and pages 394--408. The preceding 400-page seal remains recorded in
the fourth checkpoint. A dedicated main-branch workflow repeats the fresh
scoped build and all three finite replays.

## Continuing work

The net primitive rank packet, actual exceptional-root depth, moving-class
point heights, and the unbounded two-norm radical family remain open. No
unrefuted parent direction is retired. Sixth-round and later research files
are separate from this fifth-round publication.
