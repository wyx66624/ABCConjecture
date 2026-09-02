# Certificate audit

The report's symbolic proofs remain primary.  These computations check their
finite arithmetic inputs and counterexample premises.

## Sharp occupancy constants

Direct evaluation verifies the inequalities with coefficients `6`, `3`, and
`8` through occupancy 20,000 and verifies equality at occupancies `2`, `3`,
and `2`, respectively.  The Lean module proves the inequalities for all
natural occupancies and proves the corresponding lower bounds on arbitrary
rational coefficients, so the finite loop is only a replay.

## Complete-premise boundaries

- The `M=388` program enumerates the whole selected box, the exact common
  fibre, every large divisor label, all occupancies, the non-arm direction,
  capture, and period.  It obtains `T=1` and
  `S_non=L_kappa=277704`.
- The `M=170` program enumerates all 26,399 admissible points.  The common
  fibre has exactly two points with different exact powerful kernels, so the
  two kernel classes are singleton classes in the complete admissible box.
- The `B=8` programs use the exact `U` and `V` congruences to classify the
  complete common-label fibre.  They independently obtain the same two
  points, distinct singleton kernels, arm factorizations, pairwise gcds,
  primitive direction, `T=1`, three-label union catalogue, ledger values,
  and exact ratio `23392/23701`.
- The `q=3` program directly enumerates all divisors of `(1,49,27)` and gets
  full Euler mass `539`, capture `441`, reduced period `3`, and large-tail
  mass `84`.  Thus the residual Euler factor and `q_0` cannot be deleted.

## Scope controls

The support-skeleton program keeps non-arm edges for the inverse-period sum.
The report's all-direction repeated-weight inequality explicitly restores
all loop and singleton-pair directions before forgetting periods.  The
direction-count proof applies the excess estimate to the original linear
coefficient after using
`E(|A|^(R)) <= E(|A|)`; it never assumes the `R`-free map is injective.

No finite search result is treated as a proof of catalogue sparsity.  A
counterexample retires only the exact universal strengthening whose complete
premises it satisfies.
