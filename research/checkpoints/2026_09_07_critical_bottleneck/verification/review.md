# Independent ordinary-proof review

Date: 2026-09-07. Team task: continuation of the ABC research repository.

The authoring research agent was `/root/critical_bottleneck`; independent
ordinary-proof review was performed by `/root/independent_route`, with an
additional direct review of the rho, balance and tail calculations by `/root`.
These are independently running research agents within the present team, not
external human peer review.

## First review

The independent reviewer read `ordinary_proofs.md` and separately opened
Bugeaud's primary source, arXiv:2209.00275v1. The reviewer confirmed:

- shared oriented prime support between columns does not invalidate the height
  bounds, nonvanishing of the individual eta_j, or p-adic unit conditions;
- Theorem 1.1 (1.2) and the first inequality of Theorem 1.3 have the required
  degree-only base constants and no multiplicative independence premise;
- all substitutions and quantifiers in the rho, balance, and conditional-tail
  theorems are valid.

The reviewer identified one missing edge condition: the definition needed
`m>=1` to ensure `m+1>=2` in the p-adic source. This was corrected in the
ordinary proof and manuscript text. The no-split-factor triple `(1,1,2)` is
now explicitly handled outside that argument.

## Second review: strict improvement over all partitions

The reviewer independently checked every displayed bound in Theorem 6:
the ceiling and norm bounds (S1), uniform convergence over `L>=log 7` (S2),
the exact block-size/content bound (S3), and both partition regimes (S4)--(S5).
The cases include a number of blocks growing with r. No gap was found.

The reviewer also separately opened arXiv:1802.00085v3 in HTML and PDF and
verified that the stated `1/160` error bound used for the dyadic prime supply
is a valid weakening of the source's applicable bounds. The inference giving
at least `X/(3 log(2X))` split primes eventually was confirmed.

The reviewer confirmed the interpretation boundary: the lower bound concerns
the old proof envelope, not the true angular defect; the new sublinear envelope
does not prove the outstanding signed high-prime budget.

## Formal-signature review

The authoring agent independently read the sibling `OverlapColumns.lean` and
confirmed that the finite list contains actual integer pairs and both exponent
columns; multiplication order and exponent factor order differ from the ordinary
display only by commutativity. Its norm theorem matches the reconstruction,
and no disjoint-support condition is hidden in the signature. The formal
Euclidean split is valid even at zero, while the analytic theorem separately
requires `g>=1`.

Compiler execution and axiom output are recorded by the parent agent in the
sibling formal checkpoint. This review does not claim that the external
analytic theorems, asymptotics, or all of ABC were Lean-verified.
