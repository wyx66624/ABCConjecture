# Eighth-round review record

## Ordinary mathematics and TeX

Both independent researchers `critical_bottleneck` and
`adversarial_audit`, and the root researcher, read the complete
BT1--BT4 and TS1--TS3 ordinary proofs: PASS. All three subsequently
read both complete TeX transfers: PASS. The root also checked the
bibliography input. The adversarial review requested explicit `prime`
in three otherwise abbreviated TeX quantifiers; these were added to
match the already precise ordinary statements. No theorem changed.

BT review included the Gauss-sum twist's level and character, common
level 36864, index 73728, valence cutoff 12288, both coefficient-field
automorphisms, and every embedding in the two newform orbits. The
four possible quadratic characters in the boundary-module conclusion
are retained. The conclusion concerns actual pure prime powers; it
does not reduce all moving-residual spaces to the same two orbits.

TS review included the full Tate module at the exponent prime,
descent of a character subline by Hom base change over F_p, the exact
scope of supersingular F_p-irreducibility, and identification of the
unique inertia-trivial ordinary Jordan--Hoelder character. The proof
uses its unramified quotient, not the trace of an unramified full Tate
module at p. Rational two-torsion and Hasse's bound give the
contradiction. At the remaining primes, the nonzero trace difference
is even and divisible by p, yielding the factor 2p.

## Primary inputs actually inspected

The author and reviewing researchers opened the relevant primary
passages, including:

- Milne, *Modular Functions and Modular Forms*, Proposition 4.12 and
  Example 4.13, for the full-group valence argument.
- Darmon--Diamond--Taylor, *Fermat's Last Theorem*, Propositions
  2.11(c) and 2.12(b), for the local supersingular and Tate inputs.
- Boeckle, Galois-representation notes, Section 1.3.1 and Exercise
  1.30, for the ordinary unramified quotient and Frobenius unit root.
- Pacetti--Villagra Torcomian and Ellenberg, for the general Q-curve
  image hypotheses used in the independently reviewed CM exclusion.

The relevant author-hosted URLs are recorded in the ordinary proofs
and bibliography. These established results remain ordinary
dependencies, rather than new Lean theorems of this checkpoint.

## Exact evidence

The author's GP-plus-Python implementation and the adversarial
researcher's separate `mftwist`-plus-coordinate-permutation
implementation independently passed all 98,312 coordinate equalities.
The root researcher subsequently read the implementations and ran both
wrappers with `--check`; both canonical hashes matched. Exact arrays,
version, field, character, scope and replay commands are inventoried
in README.md. The two programs do not share coefficient caches or
the field-substitution implementation.

The author reviewed the peer's final
`eighth_round/paper/cm_boundary_shadow.tex`: PASS; details are in
`cm_elimination_review.md`. Peer records include
`2026_09_07_adversarial_audit/eighth_round/twist_sturm_review.md` and
`torsion_support_review.md`, and the critical researcher's eighth-round
review record.

## Boundaries

No uniform point-height upper bound, moving-prime-tail estimate, or
complete pure-power exclusion is proved. The fixed-p density statement
does not supply uniform errors as p varies. The root's new arithmetic
Lean module is separate from these ordinary representation-theoretic
dependencies and has not been independently source-reviewed by this
author. Actual integrated PDF pages 431--434 passed visual review;
see `visual_review.md` for the exact PDF SHA and layout checks.
