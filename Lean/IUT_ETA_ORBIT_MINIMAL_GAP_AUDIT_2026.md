# IUT eta-orbit minimal-gap audit (2026)

**Status date:** 2026-08-27
**Scope:** the repository's IUT/three-closure route from the public Lean
interfaces to an unconditional `ABCConjecture`
**Methodological rule:** disputed IUT conclusions are not treated as accepted
theorems, and no new axiom is introduced.

## Executive conclusion

The current three-closure chain cannot be closed by instantiating one missing
Lean structure from already accepted mathematics.

There are two independent formal obstructions.

1. The current public `LogVolumeData` scaling law is quantified over every
   set.  Applying it to the empty set makes the relevant public source types
   uninhabited.  Thus the literal upstream type is not merely unproved; it is
   refuted by the repository.
2. The current downstream field is strong enough to contain the ABC conclusion.
   The repository proves that inhabiting the downstream bridge is equivalent
   to `ABCConjecture` (subject only to an inhabited input type).  Thus this
   field is not an independently established IUT IV theorem.

After replacing the inconsistent volume carrier by the honest finite-positive
carrier, the smallest concrete IUT III payload actually used by the Corollary
3.12 proof is an honest analogue of `ActualPilotWitness`: a genuinely
reachable native q-pilot region, membership in the theta possible-image
region, its exact root-normalized q-volume, and volume monotonicity.  The
non-elementary atomic assertion is the genuine reachability/membership claim.
In the terminology of the July 2026 LANA report, this is the existence of a
suitable anabelian output whose eta map agrees with the q-native eta map.

No generally accepted theorem currently constructs that output.  Moreover,
even such an IUT III witness would not alone imply ABC: a source-derived,
uniformly quantified IUT IV/GenEll estimate for the authentic selected odd
q-divisor would still be required.  The repository's global-j substitutions
do not supply that estimate because they cross a false normalization.

## 1. Literal Lean dependency chain

### 1.1 `ThreeClosureCertificate` stores the downstream implication

`IUTThreeClosures/ThreeClosureTheorems.lean:29-52` defines
`ThreeClosureCertificate`.  Its decisive field is

```lean
actualIUTIVDownstream :
  (∀ x, Corollary312Variant (dataAt x)) → ABCConjecture
```

The theorem
`ThreeClosureCertificate.abc_conjecture_of_three_closures` at lines 73-77
only constructs the pointwise `Corollary312Variant` family and applies this
stored implication.

`IUTThreeClosures/CircularityAudit.lean:78-94` proves the exact logical audit

```lean
Nonempty ThreeClosureCertificate ↔
  Nonempty UpstreamCertificate ∧ ABCConjecture.
```

Consequently, `Nonempty ThreeClosureCertificate` is not an independent
mathematical target from which ABC can honestly be extracted.

### 1.2 `NonCircularIUTIVBridge` is also target-strength

`IUTThreeClosures/NonCircularDownstream.lean:57-81` defines
`NonCircularIUTIVBridge` with freely supplied encoding, q-log, different,
condition and error terms, comparisons, and a uniform q-estimate.

`IUTThreeClosures/BridgeInhabitationAudit.lean:37-77` constructs this bridge
from ABC by taking, in effect, `logQ = 6 * height`; the construction need not
use the Corollary 3.12 premise.  Lines 79-91 prove its inhabitation equivalent
to ABC.  The version without an input typeclass is
`IUTThreeClosures/BridgeInhabitationExact.lean:43-52`:

```lean
Nonempty (NonCircularIUTIVBridge Input ...) ↔
  Nonempty Input ∧ ABCConjecture.
```

This does not accuse the individual algebraic lemmas used after the bridge of
circularity.  It identifies the exact point where the missing global estimate
has been stored rather than derived.

## 2. The public log-volume carrier is inconsistent on the empty set

The public dependency defines a component scaling law in
`.lake/packages/iut/Iut/Cor312/LogVolume.lean:93-96`.  It is stated for every
set `U`.  At `U = ∅`, prime preimage also preserves the empty set, so the law
requires

```text
vol(∅) = vol(∅) + log(p),
```

which is impossible for a prime `p` and real-valued log-volume.

The consequences are machine-checked in
`IUTThreeClosures/PublicLogVolumeInconsistency.lean`:

- lines 38-52: no `LogVolumeData` when a component exists;
- lines 91-98: a nonempty procession rules out such log-volume data;
- lines 111-129: no `GeneratedRHSData` for any initial theta datum;
- lines 131-139: no `GeneratedNativeSource`;
- lines 141-153: no `PointwiseIUTIIIFamily` on an inhabited input type.

This is a defect of the public Lean interface, not a proof that the analytic
objects intended by IUT are inconsistent.

The correct domain restriction is represented in
`IUTThreeClosures/HonestFinitePositiveLogVolume.lean:23-30` by
`FinitePositiveRegion`.  Lines 48-67 define canonical log-volume and prove its
monotonicity; lines 78-85 state scaling only on finite, positive regions.  Any
continued source-faithful formalization must use this or an equivalent honest
carrier before attempting an eta-orbit witness.

## 3. Minimum object-level IUT III payload after that repair

The public-style minimum is visible in
`IUTThreeClosures/ActualPilotWitness.lean:27-45`:

```lean
structure ActualPilotWitness (X : Corollary312VariantData ...) where
  region : ∀ i, X.rhsData.container.AdmissibleRegion i
  region_le_thetaPilot : ∀ i, region i ≤ X.rhsData.thetaPilot i
  qVolume : X.rhsData.vol.processionVol region = X.qPilot.lhs
  processionVol_mono : ...
```

Lines 51-68 derive `Corollary312Variant X` from precisely these data.
Therefore a complete semantic presentation of every possible output is not
the minimum needed for the numerical corollary.

`IUTThreeClosures/ProcessionMultiradialSemanticSource.lean:175-197` packages a
stronger `SemanticGeneratedNativeSource`, including soundness and completeness
of a presentation.  In the conversion at lines 224-237, the Corollary 3.12
argument uses only native-region identification, exact native volume and
monotonicity.  Presentation completeness is stronger than necessary here.

On the honest finite-positive carrier, the genuine missing assertion should
therefore have the following mathematical content:

```lean
∃ S,
  GenuineEtaOutput datum S ∧
  volume (oneActRegion S) = volume nativeQPilot ∧
  oneActRegion S ≤ thetaPossibleImageRegion.
```

This displayed statement is a proposed target, not an axiom and not a theorem
claimed in this repository.

The important restriction is `GenuineEtaOutput datum S`.  If `S` ranges over
arbitrary regions or arbitrary integral structures, one may simply choose a
same-volume representative and turn the desired result into a tautology.  The
predicate must mean that `S` is produced by the actual cross-label
Hodge-theater/untilt and Ind1--Ind3 machinery.

## 4. What the public package does and does not prove

The checked-in public IUT dependency is explicit about its boundary:

- `.lake/packages/iut/README.md:5-7` says that the package does not verify IUT;
- lines 39-45 classify the Corollary 3.12 strand as a specification and do not
  prove the disputed implication;
- lines 67-99 explain that the variant is a definition, the theta region is an
  input, and the multiradial algorithm is not constructed;
- `.lake/packages/iut/Iut/Cor312/Statement.lean:25-56` records the same
  no-proof/no-axiom boundary;
- `Statement.lean:89-91` shows that `Corollary312Variant` is literally the
  desired q-left-hand-side versus right-hand-side inequality.

The repository has proved genuine local facts.  In particular:

- `ActualBadPlaceQPilotPacket.lean:363-398` identifies Haar mass with the
  arithmetic q-divisor degree and normalized q-log;
- `ActualBadPlaceProcessionAssembly.lean:331-340` proves the procession mass is
  a square-label average times the arithmetic q-log;
- `SourceFaithfulTheorem110.lean:64-105` proves actual Haar scaling and the
  log-volume of q-power regions.

These results validate local scalar calculations.  They do not prove that the
q-native region is a genuine member of the global multiradial possible-output
orbit.  The remaining source gap is described directly in
`ActualIUTOutputRelation.lean:12-39`, and the local relational progress in
`ActualTateRelationalSource.lean:10-30,104-129` does not supply the global
procession or archimedean assembly.

## 5. Original IUT III/IV and the exact disputed transition

### 5.1 Original papers

In [IUT III](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
Theorem 3.11 appears around p. 152 and Corollary 3.12 around pp. 172-173.  The
critical part of the Corollary 3.12 proof is around pp. 180-183: after placing
the compared objects in a common container, the proof uses the
simultaneous-holomorphic-structure discussion to hold the native q-pilot
log-volume fixed and treats that value as a possible theta output.  This is the
membership/identification isolated above.

In [IUT IV](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf),
Theorem 1.10 begins on p. 22.  Page 23 explicitly uses

```text
|log(q)| = (1 / (2 ell)) log(q)
```

and then invokes IUT III, Corollary 3.12.  Thus IUT IV does not provide an
independently accepted bypass around the disputed Corollary 3.12 transition.

### 5.2 Scholze--Stix

The primary critique is
[Why abc is still a conjecture](https://www.math.uni-bonn.de/people/scholze/WhyABCisStillaConjecture.pdf).
Its objection is not accurately summarized as “Theorem 3.11 is simply false.”
The issue is the passage from abstract pilots/possible outputs to the concrete
coordinates needed in Corollary 3.12.  In the compressed comparison, theta
coordinates acquire `j^2` scaling while the q-pilot coordinate is kept at its
native normalization.  Restoring a compatible comparison either removes the
claimed numerical content or incurs blurring of average size on the order of
`ell^2`, too large for the ABC application.

This is precisely a coordinate/normalization and orbit-membership issue, not a
minor omitted inequality manipulation.

### 5.3 July 2026 LANA report

The source consulted here is the official
[LANA report TeX](https://raw.githubusercontent.com/katobungen/LANA_report_202607/refs/heads/main/LANA_report_202607.tex).

- lines 338-355 isolate q-native versus anabelian/Kummer multiradial
  compatibility and do not reconstruct a proof;
- lines 2155-2192 describe the intended IPL/SHE/APT route by which the q-pilot
  log-volume should become a possible output value;
- lines 2261-2278 define the quotient `Rss` by equal adelic volume and isolate
  the target
  `∃ suitable S, eta^q = eta^anab_S`;
- lines 2280-2294 interpret this equality as the calibration that makes the
  rigidified q-pilot representable in the output regions;
- lines 2377-2398 compare this intended route with the Scholze--Stix scaled
  hexagon;
- lines 2409-2421 agree that the compressed diagram does not commute and has
  excessive rescaling, while observing that the eta target is not manifestly
  false.  The report does not provide a proof of the eta target and records the
  absence of a complete consensus.

Accordingly, the 2026 material sharpens the missing theorem but does not turn
it into an accepted theorem available for Lean instantiation.

## 6. Two normalization failures that an eta witness would not repair

### 6.1 Selected odd q-divisor is not the complete global j-height

The q-term in IUT IV is root-normalized by `1/(2 ell)` and is built from
selected bad-place q-data.  It is not the all-place height of the Frey
`j`-invariant.

`IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:44-52` instead assumes an
equality `qLog_eq_freyJHeight`.  The audit in `CORE_PROOF_NOTEBOOK.md:987-1094`
separates the complete height, the finite part and the authentic selected odd
q-divisor, and uses the family `(1, 2^m, 2^m + 1)` to show that the lost part
cannot be absorbed with the coefficient required by the proposed direct
route.  That substitution is therefore not a plausible accepted theorem.

The same issue is stated in
`IUTThreeClosures/CompleteGlobalJPacket.lean:21-23`: identifying the procession
q-pilot with the complete all-place packet remains missing.

### 6.2 Ramification changes the weight

At a ramified finite place, the arithmetic divisor contribution has residue
degree weight `f / [F : Q]`, whereas the local-degree expression has weight
`e f / [F : Q]`.  `PublicNormalizationObstruction.lean:22-50` proves that the
naive equality forces `e = 1`.  `QPilotNormalizationAudit.lean:6-18` gives the
same diagnosis, and `CorrectedQPilotDivisor.lean:35-48,104-120` supplies the
correct arithmetic q-log and root normalization.

Thus a future global theorem must use the authentic arithmetic weights; it
cannot silently replace them by local-degree weights.

## 7. Required quantifier order

`IUTThreeClosures/QuantifierCorrectClosure.lean:31-64` distinguishes a source
for every input from one isolated certificate.  Its countermodel at lines
80-95 shows that one certificate cannot supply the required universal family.

For the IUT IV/ABC use, a fixed theta datum cannot make a term such as
`20 * d_mod / ell` smaller than every positive epsilon.
`QuantifierCorrectPublicFreyTheorem110.lean:15-22,79-95` records the necessary
shape:

```lean
∀ ε > 0, ∃ sourceSelection,
  ∀ P : ABCPoint, ...
```

At fixed epsilon, the bounds for the different and error terms must be uniform
in `P`.  A point-dependent constant `C(P)` is insufficient for ABC.  This
quantifier condition remains necessary even after the eta-orbit issue is
resolved.

## 8. Machine-checked elementary reduction

The companion module is
`IUTThreeClosures/EtaOrbitMinimalGap.lean`.  It proves three statements without
postulating any genuine-output existence.

1. `linearEquiv_eq_iff_apply_pilot`: two linear equivalences from a
   one-dimensional vector space are equal exactly when they agree on a chosen
   nonzero pilot.
2. `VolumeQuotientInterface.pilot_eq_iff_volume_eq`: under an abstract quotient
   interface whose represented classes are equal exactly when their volumes
   are equal, pilot equality is equivalent to equality of represented volumes.
3. `VolumeQuotientInterface.etaMap_eq_iff_volume_eq`: after calibrating the two
   eta maps at the pilot, equality of the complete one-dimensional eta maps is
   equivalent to a single volume equality.

Schematically, if

```text
etaQ(pilot)       = [nativeQ],
etaAnab(pilot)    = [oneAct(S)],
```

then the checked theorem gives

```text
etaQ = etaAnab  ↔  volume(nativeQ) = volume(oneAct(S)).
```

The interface is a theorem parameter.  It is not a declaration that the IUT
`Rss` construction exists, and the module contains no `axiom` command and no
`GenuineEtaOutput` existence premise.

Verification on 2026-08-27 with Lean 4.32.0:

```text
lake env lean IUTThreeClosures/EtaOrbitMinimalGap.lean
  exit 0, no warnings

lake build IUTThreeClosures.EtaOrbitMinimalGap
  Build completed successfully (1567 jobs).

lake build IUTThreeClosures.AxiomAudit
  Build completed successfully (8898 jobs).
```

The three added dependency-ledger entries report respectively
`[propext, Classical.choice, Quot.sound]`, `[propext]`, and
`[propext, Classical.choice, Quot.sound]`.  In particular, none depends on
`sorryAx`, a new custom axiom, `ABCConjecture`, or an assumed genuine-output
existence theorem.

## 9. Next honest targets

The elementary next step is to instantiate the abstract
`VolumeQuotientInterface` for an explicit quotient of honest finite-positive
regions by equal canonical measure/log-volume.  This would verify the quotient
logic but still would not address genuine IUT reachability.

The first substantive source theorem must then have a form such as

```lean
∀ ε > 0, ∃ sourceSelection,
  ∀ P : ABCPoint, ∃ S,
    SuitableFromGenuineEtaAlgorithm (sourceSelection P) S ∧
    volume (oneActRegion S) =
      -(arithmeticLogQ (qDivisor (sourceSelection P))) /
        (2 * ell (sourceSelection P)) ∧
    oneActRegion S ≤ thetaPossibleImageRegion (sourceSelection P).
```

This is deliberately recorded as a target proposition, not an axiom.  Its
`SuitableFromGenuineEtaAlgorithm` clause must be traced to actual Hodge-theater,
Kummer, untilt and Ind1--Ind3 constructions.

Finally, reaching unconditional ABC also requires a source-derived downstream
theorem with uniform constants at fixed epsilon, based on the same selected odd
q-divisor and the corrected ramification weights.  Neither that theorem nor
the genuine eta-orbit existence theorem is currently supplied by accepted
results in the repository or by the cited public literature.
