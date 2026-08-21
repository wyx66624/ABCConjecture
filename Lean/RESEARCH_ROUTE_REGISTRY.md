# Research route registry

This repository deliberately preserves mathematically distinct routes toward the
abc conjecture. A route is not deleted merely because it is incomplete, has been
superseded by a stronger implementation, or currently fails to compile against a
newer interface.

## Deletion rule

A research branch may be deleted only after one of the following has been recorded:

1. a concrete mathematical counterexample to its defining claim;
2. a Lean theorem deriving `False` from the route's hypotheses without using the
   public inconsistent total log-volume specification;
3. a proof that every theorem unique to the branch is already present on `main`,
   together with an archived immutable tag or commit retaining the original route.

Build failures, API drift, lack of a current inhabitant, or lack of community
acceptance are not counterexamples and are not grounds for deleting a route.

## Retained routes

- `formalize/bridge-inhabitation-audit`: logical/circularity audit of downstream
  bridge packages.
- `formalize/canonical-source-derived-bridge`: canonical q-pilot, honest
  finite-positive volume, source and orbicurve construction experiments.
- `formalize/frey-j-height-*`: exact Frey/Legendre rational Weil-height route.
- `formalize/frey-discriminant-*`: discriminant radical and conductor route.
- `formalize/frey-calibrated-*`: strict bridge calibrated by the actual Frey
  `j`-height.
- `formalize/shifted-j-*`: nonintegral shifted-`j` curve route toward a uniform
  non-CM/open-image input.
- `formalize/legendre-j-height`: primitive Legendre-ratio height route.
- `research/joshi-arithmetic-teichmuller`: independent audit and possible
  formalization of Kirti Joshi's Arithmetic Teichmuller Spaces.

## Merge policy

Only kernel-checked, non-circular statements are merged into `main`. When an old
branch contains useful results but also stale history or broken interfaces, the
result is ported onto a fresh branch based on current `main`; the old branch is
retained unchanged.

No entry in this registry asserts a parameter-free proof of `ABCConjecture`.
