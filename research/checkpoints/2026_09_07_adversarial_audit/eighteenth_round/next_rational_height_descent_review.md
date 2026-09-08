# RD1--RD3 independent full ordinary review

Status: PASS for the exact algebraic descent and its stated analytic domain.
Actual complete source read on 2026-09-07:
`research/checkpoints/2026_09_07_collective_content_closure/next_rational_height_descent.md`,
SHA256 `d2653fede03eddad81457a18e2327e9e1207ffceeb3d4151284d126d90503466`.

Differentiating `X = phi/psi^2` gives `X' = D/psi^3`. The actual invariant
differential pullback by [9] is multiplication by nine; thus the ordinate
is `yD/(9 psi^3)`, not its negative and not `9yD/psi^3`. Consequently
`delta = -9phi/(yD)` and the comparison `yD = 9 omega_9` have the correct
normalization. Nonconstancy in characteristic zero ensures that D is not
identically zero.

For the two given quotient maps, `y2/y1 = -9/z^3` gives precisely the factor
`-9 u^39` in Xcal. Squaring the ninth-multiple parameter gives constants
5184 and 64 in V1 and V2. These are rational-function identities first on
the common open set; the source explicitly uses the already proved ZS
extensions at removable points. It does not evaluate an uncancelled
quotient at zero or infinity, or extend the unit and `25 Z5` assertions to
arbitrary u outside the actual local image.

Regrouping the even R0 series and the square of the odd logarithm series
in powers of T^2 preserves convergence and the old tail bounds with the
original T degrees. The signs and factors `-2/81, -alpha1/81, +alpha2/81`
agree with ZS9. The coordinate u is etale on the finite nonzero unit disks;
at zero and infinity the local square map has ramification two. The note
keeps this condition and does not infer simplicity of central zeros.

This review proves no disk zero count and performs no new series replay.
It reads the full new ordinary proof and uses the previously audited ZS/DS
interfaces; no primary-source reread or Lean verification is claimed here.
