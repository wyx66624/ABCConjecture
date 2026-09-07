# Actual radical transport and the second research continuation

Standard ABC is still unproved and undisproved. This directory supplies the
actual integer-radical bridge and coordinates the second continuation's
verification. Ordinary proofs were written first in `ordinary_proofs.md`.

The new `RadicalTransport.lean` has nine declarations: actual norm-transform
primitivity, one- and two-step radical identities, shared-factor radical
compression, and an integer sufficient bound on the second radical.
`TwoStepABCObstruction.lean` adds four declarations, ending with a conditional
implication to the negation of the **original repository** `ABCConjecture`.
The premise requires an unbounded family of positive coprime seeds satisfying
`[rad(M0)*rad(M1)]^5 <= a+b`. No such family is supplied or asserted to exist.

All thirteen declarations passed Lean 4.32.0 individually with warnings as
errors and only `propext`, `Classical.choice`, and `Quot.sound`. The separate
fresh compilation and complete axiom inventory are recorded in `verification/`.
The independent ordinary/formal contract review is in
`../2026_09_07_adversarial_audit/second_round/radical_transport_review.md`.

Run from the repository's `Lean` directory, using its pinned environment:

```sh
lake env python3 ../research/checkpoints/2026_09_07_radical_transport/verify_mathlib.py
```

This compiles two unchanged original source dependencies and both new modules
into fresh outputs, then queries every theorem. It checks Mathlib revision
`81a5d257c8e410db227a6665ed08f64fea08e997`. It does not claim to rebuild all
Mathlib source, the whole repository, or the full manuscript.

The other second-round formal module is
`../2026_09_07_adversarial_audit/second_round/Lean/ShiftedResidueCounts.lean`:
eight checked declarations on actual residue counts and a stopping orbit.
These second-round totals are separate from the published first-round
22 new and 74 dependency declarations.

The sealed full manuscript has 379 pages and SHA-256
`d1f0c548e9fbae7216eb6618910ff87cdf47c8a3087248f8ff5ba26176f28aec`.
The final TeX build recorded 110 source files, zero overfull boxes and zero
unresolved references. Pages 1 and 356--375 were actually rendered and
visually reviewed across three agents. The manuscript record contains the
source and raster hashes and identifies the narrower visual-review scope.
`build_manuscript.py` rebuilds using the existing TeX environment;
`seal_manuscript.py` requires a matching completed visual-review record and
the successful formal inventory before copying to the user-designated PDF.

The ordinary research branches include exact shifted-rank towers; uniform
elementary moving-prime averages and common good-index sets; actual radical
transport; a quartic unit controlling the second norm; and simultaneous
prime-depth lifting. The remainder-proportion refinement additionally replaces
the older sufficient parameter `rho=lambda*log(4+g)` by estimates depending
on `lambda` alone. These ordinary analytic conclusions have their own source
and independent review records; they are not encoded by the thirteen radical
declarations. The signed large-prime estimate and unbounded two-step
compression family remain open.
