# Sixth continuation: actual intervals, compatible quartics and modular budgets

Standard ABC remains unproved and undisproved. This checkpoint integrates
independent arithmetic, geometric and modular advances and their exact
boundaries. The designated manuscript is
`output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf`, now 421 pages.

## Ordinary mathematical results

**RW1--RW6: actual integer-root intervals.** For roots `w_k=3k+zeta`,
`B<=k<2B`, the mean positive prime-window excess divided by actual height
is at most `10 log Y/(Y^3 log(3B)) + 12(Z+1)/B + log n/(n log(3B))`.
Exact first-rank counts and their forced prime progressions remove an
exponent factor from the endpoint error. With B=n^4, the window can reach
n^3 or B/(log n)^2 for most actual roots. Exceptional roots and the primes
above the window remain uncontrolled; this is not a full-tail theorem.

**SC1--SC5: one actual quartic field.** Minkowski's bound proves class
number one for L=Q(alpha), where alpha is a root of the actual quartic.
Ideal extraction has exact norms V and Q even with shared prime support.
A single unit class controls all four conjugates. At most
`4 w_L 4^omega(V) g` compatible covers suffice; all V<=exp(Ag) cost at
most `4 w_L g exp(3Ag)`. Coefficient heights are at most
`(log V)/2 + C_L g`. An explicit smooth geometrically connected (g,g)
complete intersection over Q captures actual seeds and has genus
`1+g^2(g-2)`. No converse for arbitrary rational points or uniform
individual point-height bound is asserted.

**FM1--FM7: an actual Frey Q-curve.** The inverse-square gate is kept in
`x^2+3y^4=4F(a,b)`. The curve over Q(sqrt(-3)) has a degree-two isogeny
to a twist of its conjugate. Complete ordinary Tate branches give local
conductor exponents 6 over 2 and 2 over 3. Named character, big-image and
Serre-modularity inputs yield, for F=VQ^p, p>7 and V p-free, exact level
`2^e*9*rad(V/p^vpV)`, 2<=e<=6, with weight 2 if p does not divide V
and p+1 otherwise. The candidate dimension budget over V<=exp(Ap) is
`485(p+1)exp(3Ap)`. It does not eliminate those candidates. Composite
exponents require a new p-free residual; small original lambda alone
does not guarantee a small p-parameter.

**BS1--BS4: an exact modular boundary.** Two complete finite-field
Frobenius calculations prove the boundary curve E0 has no geometric CM
via incompatible 17-adic centralizers. Actual positive primitive seeds
shadow its local states at every specified finite precision. A specified
Mazur residue product therefore fails if its boundary eigenform has been
exactly identified. The corrected character-twisted trace at thirteen is
-4 at both primes. Identification with the level-576 orbit remains
conditional here; a few coefficients do not prove it. The two non-CM
candidate newspaces remain unexcluded.

The full proofs and their independent reviews are in this directory and
the three agents' `sixth_round` directories. Root review is recorded in
`verification/ordinary_review.md`. External number-field, Tate-module,
Tate-algorithm, modularity and modular-form inputs are explicitly retained.
Independent agent review is not external peer review.

## Formal verification

`Lean/FreySeedArithmetic.lean` contains 18 new declarations for the actual
integer seed: generalized-Fermat and inverse-square identities, the odd
chart, conjugate norm/product, quotient and twist coefficients, c4/c6 and
discriminant, universal primitive parity/three-unit statements, primitive
discriminant nonvanishing, and exact consecutive-seed Frey residues.

```text
python3 research/checkpoints/2026_09_07_quartic_compatibility/verify_round.py
```

The final fresh Lean 4.32.0 build recompiles all 18 new and 65 unchanged
dependency declarations with warnings treated as errors. Every declaration
has an axiom inventory; only propext, Classical.choice and Quot.sound occur.
An intermediate multiplication-cancellation tactic failure was corrected
before the successful fresh build of the final source bytes. The independent
signature review agrees with those exact bytes. The module formalizes
arithmetic, not the full isogeny, Tate reduction, class number, geometry,
modularity, interval theorem or ABC. This is not a full repository build.

## Exact finite evidence and manuscript

Root independently reran six checks: the separate exact-rank and actual-
interval replays, complete boundary Frobenius enumerations, the full 48-unit
character table and 2304 products, independent PARI modular newspaces, and
the Frey/Tate arithmetic replay with all 768 admissible mod-32 pairs and
159 primitive local examples. All match their stored results. Exact whole-
artifact versus compact-payload hashes are distinguished in
`verification/finite_replay_validation.json`.

The new GitHub workflow repeats the fresh scoped Lean audit and all six
finite replays. PARI/GP 2.15.4 is installed from the exact official Ubuntu
24.04 package and checked against its SHA-256 before installation. Finite
software computations do not replace the general ordinary proofs or supply
an infinite ABC certificate.

The full manuscript compiles from 133 actual TeX inputs. The seal records
the exact PDF, source and rendered-page hashes, and the 20 pages actually
visually inspected: page 1 and pages 403--421. The previous 408-page seal
and its source evidence remain archived in the fifth checkpoint. Seventh-
round explorations are outside this publication. All unrefuted parent
directions remain active.
