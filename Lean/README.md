# IUT/ABC comprehensive research formalization v4.0

Author: ChatGPT

This Lean 4.32 project consolidates the formal results obtained in the IUT/ABC
research programme. It uses the public `lana-agents/iut` Corollary 3.12 types
and imports selected public IUT IV/general-position interfaces.

## Formalized components

- the standard logarithmic statement of the abc conjecture;
- actual admissible-region witnesses for the public Corollary 3.12 variant;
- construction of the public theta-pilot region as the union of concrete outputs;
- the correct pointwise quantifier structure for a universal Diophantine theorem;
- a circularity audit of the old downstream certificate;
- a non-circular IUT IV certificate and its implication to abc;
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
- the exact four-stage non-circular closure programme.

## Exact final theorem proved by the package

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

## What is not proved

No term of type `FourStageProgram` is constructed. In particular, the package
does not construct:

1. the actual initial theta-data family for every arithmetic input;
2. the actual IUT III Hodge-theater/Frobenioid/multiradial output family;
3. the actual uniform IUT IV geometric height bridge;
4. an unparameterized theorem `abc_conjecture : ABCConjecture`.

The public IUT repository explicitly leaves the required source constructions
behind interfaces/specification boundaries. Merely defining replacement
structures does not prove their inhabitation.

## Build

```bash
lake update
lake exe cache get
lake build --wfail
```

The current ChatGPT runtime did not contain a Lean toolchain, so this v4.0
archive has undergone static source auditing but not a fresh local kernel build.

## Static audit

See `STATIC_AUDIT.json`. The source contains no explicit `sorry`, `admit`, or
user-declared `axiom`.
