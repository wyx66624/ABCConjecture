# Formal companion proof notes for the exact Frey isogeny Weil heights

Author: ChatGPT. Date: 2026-08-31.

This is a new companion to the frozen mathematical report
`research/FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md`, SHA256
`0ed2d3d5915f23d4fc583af5d436722f1727169f0cad52f7b0c451ae1b28c729`.
The complete number-theoretic proof in that report was written and independently
reviewed before this formal companion. The additional elementary proof details
below are recorded before their Lean implementation.

## 1. Actual library objects and intended boundary

The four curves are the already defined Weierstrass curves
`FreyEntireIsogenyArithmetic20260831.familyCurve n i`, with the existing
`ModelLabel` type. No new proxy elliptic curve or artificial height is used.

Mathlib defines `Height.mulHeight₁` and `Height.logHeight₁` from all admissible
absolute values. Over the rationals, `Rat.mulHeight₁_eq_max` and
`Rat.logHeight₁_eq_log_max` identify them with the usual maximum of the
canonical numerator and positive denominator. The existing dependency defines
`Heights.normalizedLogHeight K` by dividing the relative logarithmic height
by the field degree; for K = Q the degree is one. Thus both logarithmic APIs
give exactly the absolute rational Weil height used in the frozen report.

The planned formal statements concern the actual four curves indexed by
`ModelLabel`. Identifying this enumeration with the entire rational isogeny
class remains the separately proved paper theorem, using rational cyclic
isogeny classification and the good-reduction Frobenius theorem. Neither
external theorem is added as an axiom or a hypothesis pretending to close that
classification in Lean. This work does not establish an abc estimate.

## 2. Bezout details for the polynomial gcd proofs

Put c = 1792n + 2 and u = 896n + 1, so c = 2u. For the four polynomials
P = c²-c+1, Q = c²-16c+16, R = c²+14c+1, S = 16c²-16c+1,
the useful exact identities are

| polynomial | identity modulo u | identity modulo c-1 |
|---|---|---|
| P | P = 1 + u(4u-2) | P = 1 + (c-1)c |
| Q | Q = 16 + u(4u-32) | Q = 1 + (c-1)(c-15) |
| R | R = 1 + u(4u+28) | R = 16 + (c-1)(c+15) |
| S | S = 1 + u(64u-32) | S = 1 + (c-1)16c |

There are also explicit identities

2(-448n) + u = 1, and 2(-896n) + (c-1) = 1.

Hence 2, and consequently every power of 2, is coprime to both u and c-1.
Each entry in the table proves the indicated coprimality: if x = r + ky
and A r + B y = 1, then A x + (B-Ak)y = 1. This also covers the residue
16 entries. Coprimality is preserved by taking positive powers on either
side, products of coprime factors, and changing the sign of a numerator.
It therefore proves the full integer coprimality of all four signed
numerators and denominators, not just the odd-prime part.

## 3. Canonical rational coordinates and the library height

Let N,D be integers with D > 0 and gcd(N,D)=1. If a rational number z is
N/D, uniqueness of its reduced positive-denominator expression gives
z.num=N and the integer cast of z.den=D. This is the content of the existing
`Rat.num_div_eq_of_coprime` and `Rat.den_div_eq_of_coprime` APIs.

If in addition 1 <= |z|, then D <= |N| by multiplication by D > 0.
Consequently the actual library height is

mulHeight₁(z) = |N|, and logHeight₁(z) = log |N|.

For the four curves with n >= 1, the earlier proved actual-model bound
|j| >= 2c supplies this extra hypothesis. Thus one need not replace the
actual rational invariant by a separately defined height on polynomials.

## 4. Positivity and comparison details

For c >= 32, Q-c²/2 = c(c-32)/2+16 > 0 and Q<c². Also
P-Q=15(c-1)>0, R-Q=15(2c-1)>0, S-Q=15(c²-1)>0.
Thus Q,P,R,S are positive. The absolute numerators are exactly
64P³, Q³, 8R³, 8S³. The latter three comparisons with Q³ are strict,
because cubing is strictly increasing on positive numbers and the
additional factors 64 or 8 exceed one. Taking logarithms proves the unique
minimum of the four actual curve heights, attained at the zero-kernel
quotient, and the exact value 3 log Q.

The inequalities c²/2<Q<c² imply
6 log c - 3 log 2 < 3 log Q < 6 log c by monotonicity of log and the identities
log(c²)=2 log c and log(c²/2)=2 log c-log 2. No asymptotic, isogeny, or abc
assumption occurs in these elementary comparisons.

## 5. Implementation and validation

The implementation is complete in
`Lean/IUTThreeClosures/FreyIsogenyWeilHeight20260831.lean`, 17762 bytes,
SHA256
`40421af9b48a4898b6e4982dbf68a0b1bdd17dd7885d8026bcfa734781a06587`.

Before the comment-only revision in Section 7, the direct proof-check command,
run from the existing Lean project, was

```
lake env lean IUTThreeClosures/FreyIsogenyWeilHeight20260831.lean
```

It completed with exit code 0 and no warnings in that direct invocation.
This did not include all project-level style checks enabled by `lake build`;
the distinction and final build result are recorded in Section 7.
No dependency, lake lockfile, aggregate import, previous module, or accepted
verification record was changed.
The module contains 27 public theorems, three private elementary helper
theorems, and five data definitions without proof fields. In the namespace
`IUTThreeClosures.FreyIsogenyWeilHeight20260831`, the main public results are:

- `reduced_coprime`: full integer coprimality of the signed numerator and
  positive denominator for each actual model and every n >= 0.
- `familyCurve_j_eq_reduced`, `familyCurve_j_num`, `familyCurve_j_den`:
  exact actual signed invariants and their canonical Rat coordinates.
- `familyCurve_mulHeight`, `familyCurve_logHeight`: the exact four-row tables
  for the actual mathlib heights, for n >= 1.
- `familyCurve_mulHeight_isLeast`, `familyCurve_logHeight_isLeast`:
  the exact attained minima over the actual model enumeration.
- `familyCurve_logHeight_eq_min_iff`: the minimizer is uniquely zeroKernel.
- `familyCurve_normalizedLogHeight`: the bridge to the existing normalized
  height API over Q, with no replacement height definition.
- `familyCurve_normalizedLogHeight_isLeast` and
  `familyCurve_normalizedLogHeight_eq_min_iff`: the same minimum and uniqueness
  stated directly with that normalized API.
- `zeroKernel_logHeight_bounds`: the explicit strict double inequality
  6 log c - 3 log 2 < h(j(E0)) < 6 log c.

Six explicit `#print axioms` commands inspect the actual coordinate,
multiplicative-height, minimum/uniqueness, normalized-height, and double-bound
endpoints. Every output lists only `propext`, `Classical.choice`, and
`Quot.sound`; none lists `sorryAx` or a new axiom. Source inspection finds no
`sorry`, `admit`, `axiom` declaration, or `native_decide`. Root's central
audit will separately inspect the full declaration set.

The signed rational identities and coprimality allow n = 0; no positivity
claim for Q at n = 0 is used. All exact positive-polynomial height tables,
minimum statements, and endpoint logarithmic bounds explicitly assume n >= 1.

The full rational isogeny classification is not formalized by this module.
Nor does it formalize the paper's sharper complex-minimum comparison, the
explicit finite-place contribution, limiting statements, bounded-gain
formula, or obstruction quantified over the entire rational isogeny class.
Those remain the complete independently reviewed paper proofs, rather than
unproved declarations in Lean. No abc conclusion is claimed.

## 6. New English paper input and static checks

The independent input is
`paper/uniform_continuation_weil_height_2026.tex`, 10583 bytes, SHA256
`fa24fbcca18eafea6beb2d94ff40a6abca88f22ffff4c08d770854763e4e6ffe`.
Its stable section label is `sec:uniform-weil-height`; its principal theorem
is `thm:wh-exact-minimum`, and its precise obstruction corollary is
`cor:wh-no-leading-exponent-saving`.

It supplies all signed-coordinate gcd proofs, the three complex ratios,
both exact minima, both forms of the height bounds, the finite-place gap,
the limits, the bounded improvement, the exact quantified obstruction, and
the formal boundary above. It references the existing entire-class and
class-bound labels and requires no new bibliography key.

Static validation passed: 17 distinct local labels, no unresolved references
among the project's TeX files, four theorem-like environments with four
proof environments, balanced braces and environments, and ASCII-only input.
No main TeX, accepted PDF, or previous input was modified. Rendering and
integration belong to the root agent's final document build.

## 7. Comment-only style correction and final module hash

The root agent's subsequent full build succeeded, but its project-enabled
style linter reported two `longLine` warnings for the documentation strings
at original lines 292 and 336. These warnings were absent from the earlier
direct `lake env lean` invocation. No proof or theorem statement failed.

Only those two documentation strings were folded onto shorter lines, with
minor sentence punctuation. No theorem, proof, definition, import, option,
or linter setting was changed. The original module hash was
`eefb51c969574aacd347cf161025d700ba83b81ecb475f051cf06d55bf38d620`;
the final module is still 17762 bytes and its SHA256 is
`40421af9b48a4898b6e4982dbf68a0b1bdd17dd7885d8026bcfa734781a06587`.
The count remains 27 public theorems, three private theorems, and five data
definitions. The frozen mathematical report and English TeX input are unchanged.

The final project-configured module check was

```
lake build IUTThreeClosures.FreyIsogenyWeilHeight20260831
```

It returned exit code 0 and `Build completed successfully (8762 jobs).`
There were zero warnings for the target module and zero errors. The complete
output also replayed 19 pre-existing warnings from dependencies; thus this is
a zero-warning result for the new module, not a claim that every dependency
is warning-free. All six target-module axiom reports still list only
`propext`, `Classical.choice`, and `Quot.sound`.

The captured output is
`tmp/frey_isogeny_weil_height_target_build_2026_08_31.log`, 7172 bytes,
SHA256 `c71bdc91e6c32bbf69f5b337cf9dd3136cc915176211ec1ceff1e9ea015e3616`.
The direct check establishes elaboration/kernel acceptance with that command's
default checks; the final targeted Lake build additionally exercises the
project's enabled style linters. No linter was disabled to obtain this result.
