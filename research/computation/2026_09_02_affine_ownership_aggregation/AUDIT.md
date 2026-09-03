# Adversarial audit boundary

The positive finite claims checked here are:

1. The top family is pair-saturated before maximalization.
2. Every repeated non-arm large label has a maximal owner on the same line.
3. Every pair inside a maximal support has that exact top.
4. Distinct maximal supports meet in at most one selected point.
5. Owner sets partition the repeated non-arm labels exactly.
6. Every owned catalogue is contained in its full top catalogue and in the
   pairwise-coprime direction-lcm envelope.
7. With `H3=sum Q(top)/(r_top-1)^3`, the exact inequalities
   `S^2 <= E*H3`, `S < K*N*H3`, and `E < (K*N)^2*H3` hold in every tested
   nonempty configuration.
8. Full maximal-top catalogue reuse is charged injectively to support
   pairs, giving `sum_top Q(top) <= E_non` in every tested configuration.

Full-premise counterexamples retire only these exact strengthenings:

- A maximal top period cannot be used as a lower bound for every owned label
  period: the canonical boundary has `T_lambda=1<T_mu=3`.
- A kernel class need not belong to only one maximal top: the canonical
  three-point boundary has one class in two tops.
- Pairwise enumeration need not be ownership preserving: three canonical
  pairs can have the same exact top and catalogue.
- Neither `Q(mu) <= w_mu` nor `Q(mu) <= 2*w_mu` follows from canonical
  admissibility plus the maximal-owner/full-catalogue premises.  The latter
  has the full-box local witness `B=55123,C=55124,M=3` with
  `Q/w_mu=9187/4200`.
- Maximality, ownership, cap coverage, support size at least two, and linear
  support alone do not imply a strict Cauchy saving or a linear top count:
  the abstract complete-graph ledger is equality sharp.

The abstract complete-graph ledger is not a canonical affine selection and
does not satisfy the direction/excess hypotheses.  The canonical local
boundaries are not asserted exceptional.  Therefore none of these finite
certificates refutes or closes the affine mother route, and no finite no-hit
is used that way.

The conventional asymptotic estimates for maximal-top counts and the
`R0^-4` high-support tail are proved in the report and are not replaced by
these computations.

The Lean module contains 24 theorem declarations and 24 inline
`#print axioms` commands.  The separate
`AffineOwnershipMaximalIntersectionAggregation20260902AxiomAudit.lean`
contains the same 24 print commands and imports no analytic hypothesis.
