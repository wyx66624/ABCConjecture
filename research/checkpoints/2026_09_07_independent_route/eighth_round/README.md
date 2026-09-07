# Eighth round: exact boundary twists and torsion support

Status: ordinary proofs BT1--BT4 and TS1--TS3, and their complete TeX
transfers, have passed independent full review by both research peers
and the root researcher. The three paper sources are frozen for
integration after the final explicit-prime wording correction. New
mathematics belongs in `ninth_round/`. Earlier sealed rounds are unchanged.

## Results and remaining gap

The two surviving pure-power non-CM newform orbits at levels 288 and
576 are quadratic twists, with exact coefficient-field embeddings.
Two independent computations compared every coefficient through the
proved common-level bound 12288. This identifies the boundary module
for every actual positive primitive seed with
`F(a,b)=Q^p`, `Q>1`, prime `p>7`.

The rational two-torsion of the boundary curve then excludes the
exponent prime from the support, by comparison of local characters.
Every prime `q | Q` satisfies
`q >= (sqrt(2p)-1)^2 > p`. In particular, with `H=max(a,b)`,
`p^p < F(a,b) <= 13 H^4`. These are support restrictions and lower
bounds on seed height. They do not rule out moving large primes or
arbitrarily high seeds, and do not prove or disprove ABC.

## Files

- `boundary_twist_support.md`: complete ordinary BT proof, common
  level, valence bound, exact software certificate and boundary module.
- `torsion_support_refinement.md`: complete ordinary TS proof, including
  the exponent-prime local argument and stronger support/height bounds.
- `paper/boundary_twist_support.tex`,
  `paper/torsion_support_refinement.tex`,
  `paper/bibliography_additions.tex`: complete reviewed paper inputs.
- `boundary_twist_certificate.gp`, `replay_boundary_twist.py`,
  `boundary_twist_results.json`: authoritative exact replay and full
  coefficient arrays. `twist_288_probe.gp` is earlier exploratory code.
- `REVIEW.md`: review and verification scope.
- `cm_elimination_review.md`: this author's independent review of the
  peer's ordinary CM exclusion and its final TeX transfer.

## Replay

Requires PARI/GP 2.15.4 and standard-library Python. From this directory:

```text
python3 replay_boundary_twist.py --check
```

The wrapper rejects unexpected GP stderr/output, checks version,
character, coefficient field and complete array dimensions, and compares
98,312 rational coordinates. Both forms include coefficients at all
indices 0 through 12288, including multiples of 2 and 3. The canonical
UTF-8/LF JSON SHA256 is:

```text
c8181912aa36023ff86ac94c72bc59cf0279a67a42849035450de866ea115549
```

The independently implemented `mftwist` replay is at
`2026_09_07_adversarial_audit/eighth_round/replay_twist_independent.py`
relative to the checkpoints directory. Its canonical
`independent_twist_results.json` SHA256 is:

```text
9864149fe7dc844d34f71306192e49b05c90d40bb22728fe71940b173a9807e0
```

The root researcher independently executed both wrappers with `--check`
and obtained these hashes. These computations support ordinary
modular-form arguments; they are not Lean formalization of modularity,
the local elliptic representations, or ABC.

## Formal scope and layout

The root researcher separately reports fresh verification of a new
10-declaration arithmetic module, with 55 dependencies and standard
axioms. That module is integrated and documented by the root checkpoint;
this author has not independently read its latest source. Its reported
source SHA256 is
`347807a83ae6c6772dc6741f245e22b50b44178bb93966e0f643651a2815d8d1`.
No complete elliptic-representation or modular-form formalization is
claimed here. Actual integrated PDF pages 431--434 passed visual review;
the final PDF SHA and detailed scope are recorded in `visual_review.md`.
