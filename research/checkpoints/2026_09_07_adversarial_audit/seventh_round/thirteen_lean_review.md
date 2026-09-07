# Independent scope review of ThirteenMapArithmetic

Date: 2026-09-07. Status: full source and statement review PASS.

Read the complete root-owned
`2026_09_07_boundary_descent/Lean/ThirteenMapArithmetic.lean` and its
`verification/lean_validation.json`. This review did not modify or
recompile the frozen root source. The root's manifest records a fresh
Lean 4.32.0 scoped Lake build with seven new declarations and 65 existing
dependency declarations, and complete axiom queries containing only
Classical.choice, Quot.sound, and propext. Independently recomputed all
five source-file SHA256 hashes and checked every one against that
manifest: all match.

New source SHA256:
`4f07b9574be916ad673d4b748b9eddb1614e7e1473721855ee693477658284f4`.

The first three declarations are the actual complement, sum and integral
map identities in Int, with `second` rewritten to the repository's
actual homogeneous quartic. The fourth substitutes the actual equation
F=13s² to obtain the weighted cubic equation. The fifth derives U≠0
from this equation and a−b≠0, using the complement identity and integer
nonvanishing of a fourth power. Its hypothesis does not contain the
desired nonvanishing. The sixth constructs the explicit nontrivial
integer point U,V,c, with c=a−b and both nonzero conditions.

The seventh declaration is intentionally conditional. Its parameter

    hE : forall U V c : Int, c != 0 ->
      V^2 = U^3 - 13*U^2*c^2 - 507*U*c^4 -> U = 0

is visibly an argument of the theorem; it is not introduced as an
axiom, proved by tactics, or silently assumed by the first six results.
With this argument the source correctly derives a=b from F=13s².
The ordinary rational group classification implies hE by passing to
(U/c²,V/c³), but that rational passage and elliptic classification
are not formalized in this module. In particular its seven declarations
must not be reported as an unconditional formal proof of Q13, elliptic
rank zero, or ABC. The module's own documentation makes this separation
explicit.
