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
- a source-derived, uniformly quantified IUT IV q-height theorem
- `Nonempty UpstreamCertificate`
- parameter-free `abc_conjecture`

These are mathematical construction theorems, not missing record syntax. No
`sorry`, `admit`, new axiom, or theorem equivalent to abc may be used to mark them
complete.
