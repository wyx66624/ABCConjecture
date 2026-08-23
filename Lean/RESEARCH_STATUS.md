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
- ideal-theoretic lifting of every finite place of a number-field extension
- nonemptiness of the corrected inverse image of every nonempty finite-place locus
- construction of a corrected mixed finite/infinite valuation section
- containment of the old strict bad-place set in the corrected ideal-theoretic set

## Exact obstruction: finite-place normalization

The pinned IUT source uses `AbsoluteValue.LiesOver` for finite places.  This is
literal equality after restriction of the independently normalized absolute values.
For a prime `P | p` with ramification index `e` and residue degree `f`, Mathlib's
normalization gives

```text
|x|_P = |x|_p^(e*f)       for x in the base field.
```

Consequently literal equality is generally stronger than arithmetic lying-over and
normally requires local degree `e*f = 1`.

This affects both

```lean
Iut.ValuationSection.sectFin_liesOver
Iut.badPlacesOver
```

The second occurrence permits a nonempty `V_mod^bad` to have an empty strict inverse
image in `F`.  Multiplicative-reduction, Tate-parameter and q-order fields indexed by
that inverse image may then be vacuous.  The corrected definitions and proofs are in
`IUTThreeClosures.ValuationSectionNormalization`; the full mathematical audit is in
`VALUATION_NORMALIZATION_AUDIT.md`.

A stronger global diagnosis follows from derangements and Chebotarev: a nontrivial
finite extension has finite base places with no local-degree-one prime above them, so
a strict section at every finite place should not exist.  This last global no-go is
not yet a Lean theorem because the pinned Mathlib version does not contain the needed
Chebotarev theorem.

## Exact obstruction: downstream inhabitation

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

- replacement of the pinned strict finite-place fields throughout `InitialThetaData`
  by the corrected ideal-theoretic/equivalence-class formulation
- a concrete implementation of `AnabelianGeometry`
- a concrete implementation of `TemperedGeometry`
- actual admissible-prime data uniformly attached to every abc input
- actual orbicurve/core/cusp data in the intended anabelian geometry
- actual local theta-data and tempered comparison data
- actual Hodge-theater/Frobenioid/Kummer/log-link/multiradial output realization
- source-binding of every Ind1/Ind2/Ind3 generator to those actual local objects
- a source-derived, uniformly quantified IUT IV q-height theorem
- `Nonempty UpstreamCertificate`
- parameter-free `abc_conjecture`

These are mathematical construction theorems, not missing record syntax. No
`sorry`, `admit`, new axiom, or theorem equivalent to abc may be used to mark them
complete.
