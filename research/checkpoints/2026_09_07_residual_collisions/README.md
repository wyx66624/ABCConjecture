# Residual collision checkpoint

The third research round proves exact cancellation of a common Eisenstein
factor, bounds the repeated depth of prime factors across small residuals,
and studies private depth using a finite reference measure. All claims retain
their stated scope. ABC and the general private-depth estimate remain open.

`Lean/ResidualCollisions.lean` proves 15 actual integer declarations using
the existing Eisenstein definitions and boundary gcd theorem. These include
the cross-residual gcd identity, norm and Gram identities, and the actual
annotated-arm norm bound `3*q^2 <= 4*N(v)*N(w)` with nonzero determinant.
The ordinary proofs and the exact formalization boundary are in
`ordinary_proofs.md`. `Lean/QuarticTwistArithmetic.lean` adds twelve declarations:
the actual primitive integer obstructions modulo 16 and three used in the
independent elliptic descent, their residue-transfer helpers, a cleared
denominator polynomial identity, and an exact square example. It does not
formalize the elliptic group, rank, torsion classification, or the full
combined-norm nonsquare theorem. The probability results and full lcm bound
are ordinary mathematics and are not included in the Lean theorem count.

Run in the existing Linux/WSL environment:

```sh
python3 research/checkpoints/2026_09_07_residual_collisions/verify_round.py
```

The verifier copies all five exact sources into a fresh standalone Lake
project, uses Lean 4.32.0, treats warnings as errors, recompiles 52 dependency
declarations, and audits every theorem's printed axioms. The allowed union
is `propext`, `Classical.choice`, and `Quot.sound`. It saves source SHA-256
values and the full compiler output in `verification/`. It does not use
prebuilt outputs for the five local source modules. The new total is 27
declarations, separate from the 52 unchanged dependency declarations.

The new full manuscript contains 391 pages at the user-designated PDF path.
Its source inventory, PDF SHA-256 and actually reviewed page list are recorded
in `verification/manuscript_validation.json` after sealing. The preceding
379-page seal remains available in the second-round verification record.
No theorem here is asserted to resolve ABC or to supply an unbounded two-norm
gate family.
