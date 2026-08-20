# IUT/ABC comprehensive research formalization v4.1

Author: ChatGPT

This Lean 4.32 project consolidates formal results obtained in the IUT/ABC
research programme. It uses the public `lana-agents/iut` Corollary 3.12 types
and imports selected public IUT IV/general-position interfaces.

## Formalized components

- the standard logarithmic statement of the abc conjecture;
- actual admissible-region witnesses for the public Corollary 3.12 variant;
- construction of the public theta-pilot region as the union of concrete outputs;
- the correct pointwise quantifier structure for a universal Diophantine theorem;
- a circularity audit of the old downstream certificate;
- an explicit q-height comparison package and its implication to abc;
- Kummer conjugation in a full poly-isomorphism and generated ordinary membership;
- a countermodel for proper restricted coric families;
- finite-positive logarithmic-measure monotonicity;
- ramification-correct local q-pilot response;
- q-pilot normalization fork and arithmetic-divisor calibration;
- product packet-weight marginalization and distinguished-label reading;
- prime-power component log-volume formulas;
- procession averaging from capsule-wise calibration;
- finite exceptional-set absorption and prime avoidance;
- nested-chain hull lemmas;
- the scalar Corollary 3.12 / IUT IV coefficient algebra;
- the exact four-stage closure programme;
- an inhabitation audit of the current `NonCircularIUTIVBridge`.

## Exact conditional theorem proved by the package

```lean
theorem FourStageProgram.abc_conjecture
    (P : FourStageProgram) :
    ABCConjecture
```

and equivalently

```lean
theorem abc_of_four_stages_inhabited
    (h : Nonempty FourStageProgram) :
    ABCConjecture
```

## Critical inhabitation audit

For an inhabited arithmetic input type and a fixed pointwise IUT III family `F`,
the current bridge type satisfies

```lean
Nonempty (NonCircularIUTIVBridge F) ↔ ABCConjecture
```

and the current four-stage package satisfies

```lean
Nonempty FourStageProgram ↔
  Nonempty UpstreamCertificate ∧ ABCConjecture
```

The reverse construction fills `qEstimate` from an already available abc
inequality and does not use the Corollary 3.12 premise. Therefore the bridge is
syntactically free of an `ABCConjecture` field, but unrestricted bridge
inhabitation is still logically as strong as abc. It must not be counted as an
independently constructed IUT IV theorem.

## What is not proved

No term of type `FourStageProgram` is constructed from the intended IUT source.
In particular, the package does not construct:

1. a concrete `AnabelianGeometry` implementation;
2. a concrete `TemperedGeometry` implementation;
3. the actual admissible-prime family for every arithmetic input;
4. the actual orbicurve/core/cusp and local theta-data families;
5. the actual IUT III Hodge-theater/Frobenioid/Kummer/log-link/multiradial outputs;
6. a source-derived uniform IUT IV geometric height theorem;
7. an unparameterized theorem `abc_conjecture : ABCConjecture`.

The public IUT repository leaves the required source constructions behind
interfaces/specification boundaries. Merely defining replacement structures or
populating their fields from an assumed abc inequality does not prove their
inhabitation.

## Build

```bash
lake update
lake exe cache get
lake build --wfail
```

A GitHub Actions workflow runs the Lean build and `leanchecker` from the `Lean/`
package directory. A successful workflow run, together with the axiom report in
`IUTThreeClosures/AxiomAudit.lean`, is required before a change is described as
kernel-checked.

## Honesty rules

The formal target may not be closed with `sorry`, `admit`, a new axiom, an opaque
existence assumption, or a structure field whose inhabitation is equivalent to
`ABCConjecture`. Such a declaration would only rename the missing theorem.
