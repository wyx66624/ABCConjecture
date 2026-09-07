# Fourth continuation: signed support and higher-power classes

Standard ABC remains unproved and undisproved. This checkpoint integrates
three independently developed ordinary arguments, followed by scoped Lean
verification of their arithmetic pieces. The designated manuscript is
`output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf`, now 400 pages.

## Ordinary mathematical results

1. **Signed support entropy (SE1--SE3).** Conditioning the primitive reference
   depth law on the actual supported primes retains their negative depth-one
   and depth-two contributions. Under a common bound `log A <= 3t`, the exact
   identity is `E signed = D_depth - 2 E log rad + H_depth - E c_J`.
   The last two terms are uniformly `o(t)` as the cutoff grows. The allowance
   `D_depth <= 2 E log rad + o(t)` is still an unproved arithmetic target.
2. **Higher-power arithmetic descent (PL1--PL6).** The correct affine lift
   retains the denominator class modulo `h/gcd(h,4)`. A finite Kummer descent
   uses integral primitivity to prove fixed-exponent, fixed-residual-class
   finiteness without that denominator restriction. This is an explicit
   Darmon--Granville specialization. Its consequences force residual support
   or exponent escape, with no uniform height bound as the exponent varies.
3. **Actual local boundaries (LP1--LP4).** Direct norm-power tests at finitely
   many fixed moduli admit an unbounded actual primitive family. Every prime
   separately admits primitive nonzero local power solutions. Hensel lifting
   and CRT also produce infinitely many actual simultaneous Eisenstein
   extractions at any two prescribed exponents, retaining nonsquare residuals
   at thirteen and thirty-one. Their residuals are not analytically small;
   their second residual supports escape every fixed finite set.

The source proofs and their independent reviews are in the three agents'
`fourth_round` directories. `verification/ordinary_review.md` records the
root review, dependency scope and the primary source checked.

## Formal and finite verification

`Lean/LocalPowerArithmetic.lean` contains 15 new declarations. The main
statement supplies actual positive primitive seeds beyond every height bound
passing every direct test whose modulus divides a specified positive integer.
It also verifies the actual polynomial expansions, primitive mixed coordinates,
simple-root arithmetic, and elementary denominator valuation identities.

Run a fresh standalone build with the installed repository toolchain:

```text
python3 research/checkpoints/2026_09_07_support_power_classes/verify_round.py
```

The final fresh build recompiled the 15 new declarations and all 29 declarations
in the unchanged Eisenstein norm dependency, with warnings treated as errors.
Every declaration received an axiom audit. Only `propext`, `Classical.choice`
and `Quot.sound` occur. Exact source hashes and logs are saved in `verification/`.
No Hensel, Kummer, Faltings, full rational lifting, entropy, or ABC theorem is
claimed to be formalized by this module. This is not a full repository build.

Three independently replayed finite checks accompany the ordinary arguments:

| Replay | Scope | SHA-256 meaning and value |
| --- | --- | --- |
| critical fourth `replay.py --check` | 407952 local primitive states, 28800 joint states, 50 actual seed entropy checks with exact fractions, 13 finite composition ranges | Canonical payload: `9cf9f7cdfbbbc671d63e2c05c4641b8ef6d4c299ea70f0d5eaeef28684a6f67e` |
| independent fourth `exact_power_lifting.py` | 555 primitive seeds, 6105 exact rational lifts | Whole JSON artifact: `bf5c7c23b679358f6ea408001c07b033fa2a604d45d529779c00aafe819cfc44` |
| adversarial fourth `replay.py` | 21 actual Eisenstein divisions and reconstructions; a separate 76116-pair diagnostic cube scan | Whole JSON artifact: `ebd5c2bf871da0b0650efdfd990bfc88f5c3e350f61d9d014ac09f5170c43fbd` |

The zero second-cube hits in that finite scan are not a global exclusion.
The finite entropy calculation is an exact exponentiated fraction identity,
not a floating-point certificate. The dedicated GitHub workflow repeats the
fresh scoped build and all three arithmetic replays on main.

## Manuscript and continuing gates

The full manuscript builds from 120 actual TeX inputs. The seal records their
exact hashes, the final PDF hash, and the pages actually visually inspected.
The preceding 391-page seal and all third-round source files remain archived
in their existing checkpoint. The filename of the current PDF is historical.

Next work attacks the actual first-depth/rank/support allowance, uniform
moving-exponent or moving-residual-class bounds, and construction or exclusion
of the unbounded two-norm radical family. All unrefuted parent directions
remain active. New fifth-round exploratory files are outside this publication.
