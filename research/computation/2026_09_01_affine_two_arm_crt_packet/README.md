# Affine two-arm CRT packet replay

This bundle verifies the exact arithmetic in
`research/ABC_AFFINE_TWO_ARM_CRT_PACKET_2026_09_01.md`.

It checks:

- the seed radical and canonical upper-half box;
- the two local inverse residues and their CRT combination;
- polynomial identities proving `25|V` and `49|W` for the whole progression;
- the exact progression intersection count `318,322,715`;
- the first row's factorization using deterministic 64-bit primality tests;
- its two long-arm excess inequalities, primitive abc identity, exact radical,
  and strict failure of the exponent-`3/4` exception test.

The packet count is a closed-form count of one residue class, not an
enumeration.  The result is finite and does not prove an asymptotic lower
bound.  The nonexceptional first row is used only as a counterexample to the
specific claim that the two marginal excess inequalities are sufficient.

