# Lean audit artifact: LANA `RHSData` and the pointed same-pilot core

**Author:** ChatGPT  
**Date:** 2026-09-01

This directory is the permanent replay bundle for the mathematical audit in
`research/ABC_IUT_LANA_SAME_PILOT_AUDIT_2026_09_01.md`.

## Verified upstream result

The file `source/upstream/SpecificationNoGoAudit.lean` was compiled against
Project LANA commit `ddaddc274281adb5674d647e24fa478745ac6d40`.  It proves:

* `Iut.rhsData_false`: every putative `RHSData D` yields `False`;
* `Iut.rhsData_isEmpty`: `RHSData D` is uninhabited;
* `Iut.corollary312VariantData_false` and
  `Iut.corollary312VariantData_isEmpty`: the assembled data record is
  uninhabited;
* `Iut.corollary312Variant_universal_vacuous`: the universal variant target
  follows by eliminating the impossible input record.

The proof uses only fields of the pinned low-resolution interface.  The key
specialization is the empty set in the unrestricted real-valued preimage law,
after the procession and normalized weights provide a finite packet component.

## Independently checkable main-project core

The file `source/main/IUTLanaSpecificationNoGo20260901.lean` imports the
pinned `Iut.Cor312.Statement` interface and proves directly:

* `RHSData D` and the assembled `Corollary312VariantData AG TG` are empty;
* the public universal target over the assembled record is therefore vacuous;

It also proves, as independently reusable abstract lemmas:

* an everywhere-defined real set-volume with a preimage-add-shift law has
  zero shift, hence no such law exists for a nonzero shift;
* a finite real weight family summing to one has a nonempty index type;
* a `PointedHitCertificate`, which identifies the two eta constructions at
  one distinguished pilot point, suffices for the scalar inequality;
* equality of the full eta maps implies that pointwise certificate.

The live main-project file is imported by `Lean/IUTThreeClosures.lean`.  The
record-level result refines the earlier generated-interface theorem in
`IUTThreeClosures/PublicLogVolumeInconsistency.lean`; it is not presented as
an independent discovery of the empty-set mechanism.

## Validation

Every build and direct Lean invocation recorded in `logs/` exited with code
zero.  The `#print axioms` output contains only `propext`,
`Classical.choice`, and `Quot.sound`; it contains no `sorryAx`.  The exact
source scan in `logs/forbidden-scan.log` found none of the prohibited Lean
declarations or proof placeholders.

This result identifies an empty record specification in the current
low-resolution Lean interface.  It does not refute the intended same-pilot
route, the published IUT argument, IUT, or the abc conjecture.

`replay.ps1` always rebuilds the main-project abstraction.  It also rebuilds
the exact upstream audit when the pinned full LANA checkout is still present
at `tmp/lana_iut_2026_09_01`; otherwise it retains the archived audit source
and the original exit-zero upstream logs without pretending that the small
source snapshot is a standalone copy of LANA.
