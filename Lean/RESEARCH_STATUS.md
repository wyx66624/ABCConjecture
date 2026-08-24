# Research status

## Proven and formalized

- `ActualPilotWitness -> Iut.Corollary312Variant`
- generated output union and definitional membership
- pointwise source family -> pointwise Corollary 3.12 family
- explicit q-height comparison package -> `ABCConjecture`
- full-poly Kummer conjugation in the abstract structured setting
- q-pilot scalar calibration and ramification correction
- packet marginalization, finite-positive monotonicity, procession averaging
- finite exceptional-set absorption, elementary prime avoidance
- scalar IUT IV algebra
- exact inhabitation audit of the current downstream bridge
- odd-period theta automorphy and the explicit algebraic equivalence of its
  Kummer root locus
- existence and set-level uniqueness of least products of scaled maximal
  valuation rings for compact local packets with nonzero projections
- normalized local additive Haar measure and honest finite-positive nonzero
  scaled integral balls
- fixed-place rational prime scale rigidity after prime specialization
- an explicit source-faithful bound absorbing
  `sqrt(q) * log(A*q)` into an arbitrarily small multiple of `q`

These new results are local or scalar components.  They do not construct the
analytic theta quotient, the genuine IUT III possible-image system, the IUT IV
source estimate, or the final GenEll/Belyi height package.

## Claims retired by concrete counterexamples

- The map obtained from `r^ell=q` and `v |-> v^ell` is not the graph-direction
  degree-`ell` cover: on the normalized Tate skeleton it has degree one and its
  pointwise kernel is the angular group `mu_ell(K)`.  The associated Lean
  results remain useful as a cyclotomic/Kummer isogeny route.
- The complete global Frey `j`-height cannot replace the odd bad Tate
  q-divisor in the IUT IV component formula with a uniformly negligible
  conductor error.  For `(1,2^m,2^m+1)` the omitted packet exceeds twice the
  logarithmic radical, up to a positive constant.  This retires only the
  direct complete-packet substitution, not the source-faithful odd-q route.

## New exact obstruction

For every pointwise IUT III family `F` over an inhabited input type, the current
`NonCircularIUTIVBridge F` satisfies

```lean
Nonempty (NonCircularIUTIVBridge F) ↔ ABCConjecture
```

Consequently the current four-stage package satisfies

```lean
Nonempty FourStageProgram ↔
  Nonempty UpstreamCertificate ∧ ABCConjecture
```

The forward implication is the intended transfer to abc. The reverse implication
constructs the bridge from an already available abc inequality and ignores the
Corollary 3.12 premise. Thus the bridge is syntactically free of an
`ABCConjecture` field, but its unrestricted inhabitation is still logically as strong
as abc. This prevents it from being counted as an independently constructed IUT IV
bridge.

## Not proved

- a concrete implementation of `AnabelianGeometry`
- a concrete implementation of `TemperedGeometry`
- actual admissible-prime data uniformly attached to every abc input
- actual orbicurve/core/cusp data in the intended anabelian geometry
- actual local theta-data and tempered comparison data
- actual Hodge-theater/Frobenioid/Kummer/log-link/multiradial output realization
- the analytic quotient, proper discontinuity, divisor control, and tempered
  fundamental-group comparison for the odd theta-root locus
- the residue-cardinality Haar formula, product/log volume formula, and
  degree-normalized p-preimage scaling in the new maximal-ring hull model
- Lean formalizations of the two counterexamples recorded above
- a source-derived, uniformly quantified IUT IV q-height theorem
- `Nonempty UpstreamCertificate`
- parameter-free `abc_conjecture`

These are mathematical construction theorems, not missing record syntax. No
`sorry`, `admit`, new axiom, or theorem equivalent to abc may be used to mark them
complete.
