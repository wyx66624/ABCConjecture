# IUT/ABC comprehensive research formalization v4.2

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
- an inhabitation audit of the current `NonCircularIUTIVBridge`;
- odd-period theta-root equivariance, its free properly discontinuous integer
  action, and the resulting ordinary topological orbit covering;
- the exact angular kernel and finite cyclic radial image of the Tate
  `K`-point quotient in the discretely valued case;
- genuine non-classical polynomial and Laurent Gauss points, strict
  polynomial-to-Laurent extension, exact radial covariance under
  `T |-> qT`, and the positive radial orbit quotient's homeomorphism with
  the logarithmic circle;
- honest local maximal-valuation-ring hulls and residue-normalized Haar
  volume for a Tate parameter at an actual bad place;
- the finite actual bad-place Haar packet, including completed/global residue
  cardinality comparison, exact signed local terms, and reconstruction of
  the arithmetic q-divisor degree and normalized `arithmeticLogQ`;
- fixed-place multiradial scale obstructions and actual label-rescaled
  nonarchimedean absolute-value copies;
- concrete Fermat/Kummer algebras over the punctured tripod, including
  integrality, exact rank `n^2`, finite etaleness, faithful flatness, affine
  smoothness, and explicit coordinate formulas for the fibres over
  `0`, `1`, and `infinity`;
- a local DVR theorem turning a uniformizer power law
  `t = unit * x^n` into exact additive order, maximal-ideal exponent, and
  ramification index `n`;
- a genuine homogeneous Fermat `Proj`, its three coordinate basic-open
  cover, canonical affine chart presentations, and the Fermat equation on
  the `X_2` chart;
- an explicit equivalence between the `X_2` homogeneous chart and the
  bivariate affine Fermat quotient, together with the transported affine
  smoothness certificate.

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
7. completion of the Laurent Gauss ray to a Tate analytic space, the full
   rigid/adic/Berkovich theta quotient, its angular and
   retraction theory, and the tempered fundamental-group comparison;
8. scheme-level packaging of the identified affine chart and honest
   localization as a compactification inside the genuine Fermat `Proj`, its
   scheme-level smoothness/normality, boundary DVR identifications and
   instantiated ramification indices, and the noncritical Belyi and
   height/different/conductor comparisons needed for the general-position
   proof package;
9. an unparameterized theorem `abc_conjecture : ABCConjecture`.

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

`kernel-checked` is one completion label, not the only admissible method.  The
repository may also use an exact named interface to a generally accepted
theorem or certified computation that is not yet in mathlib, under the source
and trust-ledger requirements of `ACCEPTED_THEOREM_DEPENDENCY_POLICY.md`.

## Honesty rules

The formal target may not be closed with `sorry`, `admit`, an undocumented or
target-equivalent axiom, an opaque existence assumption, or a structure field
whose inhabitation is equivalent to `ABCConjecture`.  A named external theorem
interface is admissible only when it represents independently accepted
mathematics or a certified exact computation and carries the dependency ledger
required by `ACCEPTED_THEOREM_DEPENDENCY_POLICY.md`.  Giving an open, disputed,
or abc-equivalent statement such a name would only rename the missing theorem.
