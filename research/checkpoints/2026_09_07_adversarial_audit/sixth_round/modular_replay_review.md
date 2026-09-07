# Independent exact modular-space replay

Date: 2026-09-07. Executed a separate GP script and canonical wrapper,
`replay_modular_spaces.gp` and `replay_modular_spaces.py`, with PARI/GP
2.15.4 under Ubuntu24.04. Both the initial run and `--check` passed.

The character input12 is the Kronecker character (12/.), namely psi_3.
The exact newspace constructor is `mfinit([N,2,12],0)`. The official
[PARI modular-form documentation](https://pari.math.u-bordeaux.fr/dochtml/html-stable/Modular_forms.html)
was independently opened to check newspace flags, eigenbasis and
coefficient-field semantics, exact dimensions, and the CM-test return
values. The constructor and eigenbasis are algebraic rather than
dependent on floating-point precision. The code additionally checks
that the sum of eigenorbit field degrees equals the newspace dimension.

| Level | Dimension | Eigenorbit fields | PARI CM discriminants |
|---:|---:|---|---|
|36|2|Q(sqrt(-2))|-4|
|72|0|none|none|
|144|2|Q(sqrt(-2))|-4|
|288|4|Q(zeta_8)|0|
|576|8|Q(sqrt(-2)), Q(sqrt(-2)), Q(zeta_8)|-4,-4,0|

Each orbit's exact coefficients through25 are retained. The two
non-CM candidate orbits have a_13=4 at level288 and a_13=-4 at576,
invariant under coefficient-field embeddings. These results agree
with the independent-route agent's separate probe.

Canonical `verification/modular_space_results.json` byte SHA256:
`a9a8d26becc22223498c7402d7d13c9ac9520eb2ba2b331cb3f7764580bb3521`.
The wrapper also seals its GP source and requires the recorded PARI
version. Reproduction uses

    python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_modular_spaces.py --check

This is exact software-assisted evidence for the specified modular
spaces, independently reproduced. It is not a Lean verification of
the modular-form algorithms, a proof that an arbitrary seed has one
of these levels, or an exclusion of the remaining non-CM orbits.
The level-lowering dependency belongs to the separately reviewed FM5
argument. The E0 boundary requires its own identification argument;
the corrected local character trace is -4, so its proposed orbit is
the level576 one, conditional on membership in this list.
