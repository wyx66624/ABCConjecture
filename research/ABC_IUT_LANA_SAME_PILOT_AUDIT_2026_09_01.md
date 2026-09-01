# Independent audit of the Project LANA Corollary 3.12 interface and the same-pilot gate

**Author:** ChatGPT  
**Audit date:** 2026-09-01  
**LANA code snapshot:** `lana-agents/iut`, commit
`ddaddc274281adb5674d647e24fa478745ac6d40` (2026-07-27)  
**Status:** exact no-inhabitant theorem for the current low-resolution
`RHSData` signature; exact type audit; positive same-pilot reduction; no proof
or disproof of IUT III, Corollary 3.12, IUT, or the abc conjecture.

## 1. Principal mathematical result: the current `RHSData` record is uninhabited

This issue comes before the intended same-pilot comparison.  The following
argument uses every relevant hypothesis exactly as it is typed in the snapshot.

### Theorem 1.1 (empty-set obstruction)

For every `D : InitialThetaData AG TG`, the type `RHSData D` at commit
`ddaddc2` is uninhabited.

#### Proof

Assume that `R : RHSData D` exists.

1. The admissible prime in `D` satisfies \(\ell\ge 5\)
   (`AdmissiblePrimeData.five_le`).  The field
   `R.proc_standard` identifies the container procession with
   `Procession.standard ((D.ℓ - 1) / 2)`.  Hence
   \[
      R.\mathrm{container}.\mathrm{proc}.\mathrm{length}
        =(\ell-1)/2\ge 2,
   \]
   so one may choose a capsule index \(i\).

2. Fix the rational prime \(p=2\) (the Lean term is
   `⟨2, Nat.prime_two⟩ : Nat.Primes`).  The log-volume field
   `R.vol.weight_sum_one` states
   \[
     \sum_{v\in R.\mathrm{container}.\mathrm{Fiber}(.\mathrm{finite}\ p)}
       w_p(v)=1.
   \]
   Therefore this fiber is nonempty: if it were empty, the sum would be zero.
   Choose \(v\) in the fiber.  The constant function with value \(v\) is a
   component
   \[
     c\in R.\mathrm{container}.\mathrm{Components}(i,p).
   \]

3. Let \(U=\varnothing\) in the field summand indexed by \(c\).  Lines 93--96
   of `Iut/Cor312/LogVolume.lean` assert, for **every** set \(U\),
   \[
   \operatorname{componentVol}
      \bigl((x\mapsto p x)^{-1}U\bigr)
    =\operatorname{componentVol}(U)+\log p. \tag{1.1}
   \]
   But the inverse image of the empty set is empty.  Substituting
   \(U=\varnothing\) and \(p=2\) into (1.1) gives
   \[
      \operatorname{componentVol}(\varnothing)
       =\operatorname{componentVol}(\varnothing)+\log 2.
   \]
   Cancellation gives \(\log 2=0\), whereas \(\log 2>0\).  This is a
   contradiction. \(\square\)

The proof does not require an existence theorem for a finite place of the
number field.  The already typed equation `weight_sum_one` forces the needed
fiber to be nonempty.  It also does not use any IUT theorem, any disputed
same-pilot implication, or the desired inequality.

The complete source dependency chain is:

| Step | Pinned source at `ddaddc2` |
|---|---|
| \(5\le\ell\) | `Iut/Cor312/ThetaData/AdmissiblePrime.lean`, lines 110--116 |
| `RHSData` contains `container`, `proc_standard`, and `vol` | `Iut/Cor312/RightHandSide.lean`, lines 61--76 |
| `Procession.standard n` has length `n` | `Iut/Cor312/Procession.lean`, lines 99--110 |
| Each rational-place fiber is finite and `Components i vQ` is the function type from capsule labels to that fiber | `Iut/Cor312/Container.lean`, lines 86--101 and 125--137 |
| Every fiber's weights sum to one | `Iut/Cor312/LogVolume.lean`, lines 74--83 |
| The prime-preimage equation quantifies over every set `U` | `Iut/Cor312/LogVolume.lean`, lines 84--96 |

Thus the contradiction follows through actual fields of a putative `R`; no
field has been erased, weakened, or replaced by an informal analogue.
This means that this record specification has no instances; it does not mean
that Lean's ambient logic is inconsistent.

### Corollary 1.2 (the assembled data type is empty)

`Corollary312VariantData AG TG` contains a field
`rhsData : RHSData data`.  Theorem 1.1 therefore implies that the assembled
type is uninhabited.  Consequently the universal assertion

```text
forall X : Corollary312VariantData AG TG, Corollary312Variant X
```

is vacuously true by elimination from the impossible `rhsData` field.  Such a
proof would have no mathematical content about Corollary 3.12.

### Exact scope of Theorem 1.1

The theorem closes the current `ddaddc2` **low-resolution signature as a
satisfiable specification**.  It does not close any of the following routes:

* constructing a corrected log-volume interface;
* proving the same-pilot comparison after that correction;
* the full argument of IUT III, Corollary 3.12;
* IUT or the abc conjecture.

It also explains why there is no counterexample satisfying every field of the
current LANA interface: there is no object satisfying those fields in the
first place.  It would be incorrect to present a scalar or toy countermodel as
a full `Corollary312VariantData` counterexample.

### Minimal signature repair

The module documentation says that the scaling law is intended only in the
finite, nonzero volume regime, but the type quantifies over all sets.  A direct
repair is to introduce a component-indexed predicate such as

\[
  \operatorname{ComponentValid}(i,v_{\mathbb Q},c,U)
   := U\text{ is measurable, nonempty, and has finite nonzero Haar volume}
\]

and type (1.1) as

```text
componentVol_prime_preimage :
  forall i p c U, ComponentValid i (.finite p) c U ->
    componentVol i (.finite p) c ((fun x => p * x) ⁻¹' U)
      = componentVol i (.finite p) c U + Real.log p
```

with a theorem that the preimage is again valid.  Another coherent design is
to use an extended-real logarithmic codomain and define its behavior at zero
and infinite volume.  Merely changing the prose while retaining the present
unrestricted quantifier does not repair the contradiction.

## 2. Exact relationship between `qPilot` and `rhsData`

The assembled structure is literally

```lean
structure Corollary312VariantData (AG) (TG) where
  data    : InitialThetaData AG TG
  qPilot  : QPilotData data
  rhsData : RHSData data
```

and the target is definitionally

```lean
X.qPilot.lhs ≤ X.rhsData.rhs
```

This yields the following complete inventory.

### 2.1 Relationships that are present in the types

| Typed relationship | Exact content |
|---|---|
| Common initial data | Both fields depend definitionally on the same `X.data`.  They therefore share the number field \(F\), elliptic curve \(E\), admissible prime \(\ell\), torsion field \(K\), and the other initial-theta data. |
| Common prime parameter | `qPilot.absLogQ` divides by `2 * D.ℓ`, while `rhsData.proc_standard` fixes the procession length to `(D.ℓ - 1) / 2`. |
| Left-side Tate data | `qPilot.logQ` uses the actual `D.prime.qOrder` at the finite bad places enumerated by `badFinset`. |
| Right-side field and places | The RHS container is indexed by `Place D.prime.torsionField`; its finite rational-place map is required to have the correct residue characteristic, and its infinite places map to the archimedean rational place. |
| RHS internal typing | `thetaPilot` is a family of admissible regions of its own container, is assumed hull-admissible, and is assumed contained in the container log-shell. |
| Hull typing | `thetaHull` is the packetwise hull of `thetaPilot`; from the hull interface one can prove `thetaPilot i ≤ thetaHull i`. |
| Scalar codomain | `qPilot.lhs` and `rhsData.rhs` both have type `Real`. |

These are real dependencies, but none is a comparison between the two pilots.
In particular, sharing `D` is only sharing a parameter; it does not produce a
map, equality, containment, or order relation between objects built from `D`.

The absence claims below come from an exhaustive field audit, not from the
module documentation alone.  The complete field lists are `QPilotData` at
`Iut/Cor312/LeftHandSide.lean`, lines 58--67; `RHSData` at
`Iut/Cor312/RightHandSide.lean`, lines 61--91; and
`Corollary312VariantData` at `Iut/Cor312/Statement.lean`, lines 66--74.  The
only derived scalar endpoints are `lhs` at `LeftHandSide.lean`, lines 81--93,
and `rhs` at `RightHandSide.lean`, lines 97--106.

### 2.2 Relationships missing from the types

The following data or theorems do not occur in
`Corollary312VariantData`, `QPilotData`, or `RHSData`.

1. **No RHS-container realization of the q-pilot.**  `QPilotData` contains a
   bad-place finset and positive scalar weights, then immediately computes a
   real number.  It contains no global q-pilot object, arithmetic line bundle,
   or admissible region in `rhsData.container`.

2. **No q-volume identification.**  There is no region \(P_q\) and no theorem
   `processionVol Pq = qPilot.lhs`.

3. **No bridge between the two weight systems.**  `qPilot.weight` is an
   arbitrary positive weight on bad places of \(F\).  `rhsData.vol.weight` is
   a positive, fiberwise normalized weight on places of \(K\).  There is no
   restriction, extension, localization, or degree formula relating them.

4. **No multiradial output map.**  `rhsData.thetaPilot` is input data.  It is
   not the output of a typed algorithm from the q-pilot or theta-pilot.

5. **No possible-image family or output ray.**  The interface chooses one
   region family and one hull volume.  It does not model the collection of
   Ind1--Ind3 possibilities or prove that a selected value lies in
   \(\mathbb R_{\le -|\log\Theta|}\).

6. **No IPL, SHE, or APT structure.**  These words appear in explanatory
   comments but there is no field expressing a full poly-isomorphism to the
   input prime strip, simultaneous holomorphic expressibility, or algorithmic
   parallel transport.

7. **No pointed same-pilot certificate.**  There is no typed statement that a
   q-pilot point is fixed by, transported around, or recovered from a closed
   diagram.  In particular, there are no maps `etaQ` and `etaAnab S` of the
   July 2026 LANA report.

8. **No determinant or tensor-power normalization.**  The passage from a
   rank-greater-than-one hull to the suitably normalized positive tensor power
   of its determinant in Corollary 3.12, Step (xi-d), is absent.

9. **No relevant log-volume monotonicity.**  The hull system proves set
   extensivity, but `LogVolumeData` deliberately records no monotonicity law,
   even for nonempty finite-volume admissible regions.  Thus
   `thetaPilot ≤ thetaHull` cannot be converted into a volume inequality.

10. **No hull-approximant class \(\Phi(P_q)\).**  The code models the least
    hull operation \(\varphi\), but not the class of log-volume approximants
    \(\Phi(P)\) from Remark 3.9.5(iii), and especially not membership for the
    same native q-pilot region.

11. **No coefficient relation.**  There is no field or theorem identifying
    `rhsData.rhs` with \(C_\Theta |\log q|\).

Therefore, even after repairing Theorem 1.1's signature defect, the inequality
does not follow from the currently visible cross-typing.

For comparison only, erasing all nested structure leaves the outer shape
`D; q : Q(D); r : R(D)`.  The one-point parameter model with
`q.lhs = -1` and `r.rhs = -2` satisfies the erased dependency shape and
falsifies `q.lhs ≤ r.rhs`.  This is a countermodel to the claim that *sharing a
parameter alone* gives an order relation.  It is not a model of `RHSData` and
is not a counterexample to the LANA declaration, IUT, or abc.

## 3. What IUT III actually requires in Steps (xi-d)--(xi-g)

Put

\[
  q_*=-|\log q|,\qquad T=-|\log\Theta|.
\]

The source makes four distinct moves.

1. **Step (xi-d), printed pp. 183--184.**  The output possibilities are said
   to be linked by full isomorphisms of the relevant prime strips to the
   representation of the q-pilot in the 1-column.  They become comparable to
   the q-pilot arithmetic line bundle only after taking a suitable positive
   tensor power of the determinant and applying normalized log-volume.

2. **Step (xi-e), p. 184.**  IPL and SHE are used to say that the output
   construction remains executable relative to the 1-column arithmetic
   holomorphic structure under the condition that the input pilot volume has
   the fixed value \(q_*\).

3. **Step (xi-f), p. 184.**  The paper describes the output construction as a
   construction, perhaps up to approximation, of the input pilot volume and
   then asserts \(q_*\in\mathbb R_{\le T}\).

4. **Step (xi-g), pp. 184--185.**  This is summarized as two tautologically
   equivalent ways to compute the log-volume of the q-pilot at \((1,0)\).

The repeated phrase “q-pilot” is not by itself a typed identity.  The logical
work is the proof that the output construction hits the same *pointed* pilot
class after the horizontal link, vertical log-Kummer correction, Ind1--Ind3,
determinant, globalization, and normalization.

## 4. Remark 3.9.5 and the approximation issue

For a direct-product region \(P\), Remark 3.9.5(ii)--(iii) defines its least
hull \(\varphi(P)\) and

\[
 \Phi(P)=\{H\in\mathcal H:
       H\subseteq\varphi(P),\quad
       \mu_{\log}(P)\le\mu_{\log}(H)
          \le\mu_{\log}(\varphi(P))\}. \tag{4.1}
\]

Thus a correctly typed witness \(H\in\Phi(P_q)\), together with
\(\mu_{\log}(H)\le T\), immediately gives

\[
 q_*=\mu_{\log}(P_q)\le\mu_{\log}(H)\le T. \tag{4.2}
\]

This is source-faithful, but membership in \(\Phi(P_q)\) already includes the
first numerical inequality in (4.2).  It is not an independent proof if that
membership is justified only by appealing to the desired conclusion.

Remark 3.9.5(vi)--(ix) explains why the missing proof has to occur before
forgetting the object-level structure:

* hulls and positive determinant powers are used to obtain objects comparable
  to the q-pilot arithmetic line bundle;
* merely passing to log-volumes loses the local Galois and unit data needed for
  the log-Kummer comparison;
* the vertical shift must be corrected by the log-Kummer correspondence;
* the resulting chain must form a closed loop; the source explicitly says a
  non-closed loop gives no nontrivial conclusion.

This supports a pointed same-pilot certificate, not an unpointed assertion that
two prime strips happen to be isomorphic.

## 5. The weakest same-pilot certificate that suffices

The July LANA report formulates a main goal

\[
   \eta^q=\eta^{\mathrm{anab}}_S:
       \mathbb R^{\mathrm{val}}\longrightarrow\mathbb R^{\mathrm{ss}}
   \tag{5.1}
\]

for a suitable output choice \(S\).  Equality of the entire maps is stronger
than is needed for the numerical conclusion.

### Proposition 5.1 (minimal pointed-hit certificate)

Let \(p\) be the canonical q-pilot point of
\(\mathbb R^{\mathrm{val}}\).  Suppose there is a source-permitted globally
synchronized output choice \(S\) such that:

1. `q-coordinate`:
   \[
     \nu(\eta^q(p))=q_*;
   \]
2. `output-ray typing`:
   \[
     \nu(\eta^{\mathrm{anab}}_S(p))\le T;
   \]
3. `same-pilot hit`:
   \[
     \eta^q(p)=\eta^{\mathrm{anab}}_S(p).
     \tag{5.2}
   \]

Then \(q_*\le T\).

#### Proof

Apply \(\nu\) to (5.2).  Conditions 1 and 2 give

\[
 q_*=\nu(\eta^q(p))
    =\nu(\eta^{\mathrm{anab}}_S(p))
    \le T.
\]

This is the desired inequality. \(\square\)

Condition (5.2) is strictly weaker than the map equality (5.1): it asks only
that one canonical point be hit.  It is also stronger than the existence of an
unpointed BPS isomorphism, which the LANA report observes is vacuous in its
connected groupoid of BPSs.

### Non-circularity requirement

As a scalar statement, Proposition 5.1 is elementary.  Its mathematical
content lies in how (5.2) is proved.  A non-circular certificate must lift
(5.2) to the object level before taking the volume quotient.  Concretely, it
must provide a closed, globally synchronized, pointed diagram which:

* starts from the fixed q-pilot arithmetic line object;
* follows the specified theta link, IPL/SHE/APT construction, all required
  Ind1--Ind3 branches, and the log-Kummer vertical correction;
* takes the source-prescribed positive determinant power and normalization;
* returns to the same right-hand arithmetic holomorphic structure and maps the
  distinguished q-pilot object to the selected output object;
* is compatible with all finite-place localizations, archimedean metrics, and
  the global degree/log-volume functor.

Only after proving this object-level pointed commutativity may one apply
log-volume to obtain (5.2).  Declaring equality in a quotient whose equality
is *defined* by equality of volumes, without an independent lift, would simply
restate the missing numerical assertion.

There are two useful stronger certificates:

* a proof that the selected output hull is a member of \(\Phi(P_q)\) for the
  same native q-pilot region, derived independently from the object maps; or
* a direct global containment \(P_q\subseteq H_S\), together with the genuine
  finite-nonzero Haar log-volume monotonicity theorem and
  \(\mu_{\log}(H_S)\le T\).

Neither stronger certificate is currently typed in the LANA snapshot.

## 6. Positive proof attempt inside the current interface

Ignoring the inconsistency of Section 1 temporarily, the strongest positive
chain available from existing fields is

\[
  \operatorname{thetaPilot}_i
   \subseteq
  \operatorname{thetaHull}_i,
  \tag{6.1}
\]

proved from `thetaPilot_hullAdmissible` and hull extensivity.  The attempt then
stops for three independent, exact reasons:

1. no q-pilot region is present, so the left side of (6.1) cannot be identified
   with the object whose volume is `qPilot.lhs`;
2. no log-volume monotonicity law turns (6.1) into a volume comparison;
3. no typed algorithm proves that `thetaPilot` or `thetaHull` is a permissible
   output linked to the same q-pilot.

This is not a route abandonment based on difficulty.  It is an exact list of
missing premises.  After the empty-set law is repaired, each premise remains
an active mathematical obligation.

The current repository result
`research/IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md` proves a
substantive but smaller statement: a specified transfer image belongs to one
same-column raw possible-image branch for one fixed pilot.  It explicitly does
not prove the horizontal same-pilot comparison, all Ind3 branches, or the
global hull/weight identification.  The closed-ray report
`research/IUT_CLOSED_RAY_APPROXIMATION_BRIDGE_2026_09_01.md` proves the scalar
order bridge and correctly leaves this same-pilot typing open.  The present
audit is consistent with both conclusions.

## 7. Comparison with the public July 2026 LANA interim report

The primary public source is the LANA Project's
`Project LANA Interim Report on IUT Theory`, main-branch commit
`293bdd89463473ae13d40834d70fb4b7ba81da1f` (raw TeX SHA256
`13c60b0669644b0e5dea72adfdb55b1dad367ff91f5b11fadf75e48ac0e66f51`).

Its public conclusions are:

1. LANA isolates the unresolved point as the relationship between the direct
   q-pilot construction in its native arithmetic holomorphic structure and
   the construction obtained by anabelian/Kummer multiradial methods.
2. Its precise “main goal” is the existence of suitable \(S\) satisfying
   \(\eta^q=\eta_S^{\mathrm{anab}}\).
3. As of July 2026, LANA does not have a proof of this equality, but also does
   not regard it as manifestly false.
4. LANA agrees that the Scholze--Stix hexagon does not commute and that forcing
   that particular diagram to commute introduces a fatal rescaling.  LANA does
   not infer from this alone that Mochizuki's intended same-side strategy is
   impossible.
5. LANA gives no final verdict on IUT.  It reports that many members think the
   original paper lacks at least a formalizable proof, but the members did not
   reach complete consensus.
6. The report says the low-resolution Lean exchange still contains black boxes
   and is not a complete formal proof.

The current `lana-agents/iut` snapshot is consistent with that stated
epistemic boundary in one respect: its README and `Statement.lean` call the
Corollary 3.12 strand a specification-only project and explicitly decline to
identify it with the published corollary.  It does not implement the report's
eta comparison.  The empty-set obstruction of Section 1 is a separate defect
in the later public low-resolution signature; it is not a conclusion stated
in the July report.

## 8. Route disposition

The audit yields the following exact disposition.

| Route or claim | Disposition |
|---|---|
| Current `ddaddc2` `RHSData` as a satisfiable log-volume specification | **Closed by full contradiction** (Theorem 1.1). |
| Existence of a full-interface counterexample to `lhs ≤ rhs` | **Impossible for this signature**, because there are no full-interface instances. |
| Claim that merely sharing `InitialThetaData` proves the inequality | **Refuted at the erased dependency level**; sharing a parameter has no order content. |
| Source-defined ordered-hull bridge | **Valid**, provided the output is independently proved to lie in \(\Phi(P_q)\) for the same q-pilot region. |
| Pointed same-pilot hit, Proposition 5.1 | **Sufficient and active**; not typed or proved in the snapshot. |
| Full LANA eta equality | **Active and stronger than necessary**; the public July report says it is unproved and not manifestly false. |
| IUT III, Corollary 3.12 / IUT / abc | **Not proved or refuted here; route remains active.** |

The next rigorous steps are therefore:

1. repair the domain of the component scaling law and prove the repaired
   interface is inhabited by genuine local Haar log-volume data;
2. type a q-pilot region or pointed q-pilot arithmetic line object in the same
   RHS container, with its exact normalized volume identity;
3. type the output family, determinant normalization, IPL/SHE/APT and Ind3
   dependencies rather than leaving them in comments;
4. prove the one-point same-pilot hit (5.2), or the stronger eta-map equality,
   from a closed object-level diagram;
5. seek a counterexample only against that fully stated repaired certificate.
   A counterexample to a weaker scalar or qualitative-link projection would
   not close the same-pilot, IUT, or abc route.

## 9. Lean formalization and relation to the earlier public-volume result

The exact pinned-interface argument is formalized in
`Lean/IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean`.  Unlike a toy
or erased scalar model, this module imports `Iut.Cor312.Statement` and proves
directly from a putative upstream `RHSData D` that `False` follows.  It then
derives `IsEmpty (RHSData D)`, emptiness of
`Corollary312VariantData AG TG`, and the vacuity of the public universal
variant target.  The same module separately formalizes the abstract
total-shift no-go, normalized-weight nonemptiness, the minimal pointed-hit
certificate, and the implication from full eta-map equality.

This exact record-level theorem refines an earlier result already present in
`Lean/IUTThreeClosures/PublicLogVolumeInconsistency.lean`.  The earlier module
proved the same empty-set mechanism for `LogVolumeData` and for the
repository's generated RHS/source structures.  The new module does not claim
priority over or independence from that observation; its contribution is to
close the dependency chain through the literal pinned `RHSData` and
`Corollary312VariantData` declarations audited here.

The replay evidence is archived under
`Lean/verification/2026_09_01_iut_lana_specification_nogo/`, and the five-route
continuation is checked again in
`Lean/verification/2026_09_01_global_packet_continuation/`.  The formalized
contradiction concerns satisfiability of the pinned low-resolution signature.
It is not a Lean proof of a contradiction in IUT, of a counterexample to
Corollary 3.12, or of either direction of `ABCConjecture`.

## 10. Primary source ledger

* LANA code snapshot:
  [`Statement.lean`, lines 66--96](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/Statement.lean#L66-L96),
  [`LeftHandSide.lean`, lines 58--93](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/LeftHandSide.lean#L58-L93),
  [`RightHandSide.lean`, lines 61--106](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/RightHandSide.lean#L61-L106),
  [`LogVolume.lean`, lines 74--96](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/LogVolume.lean#L74-L96),
  [`Container.lean`, lines 86--133](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/Container.lean#L86-L133),
  [`Procession.lean`, lines 77--110](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/Procession.lean#L77-L110), and
  [`ContainerHull.lean`, lines 47--112](https://github.com/lana-agents/iut/blob/ddaddc274281adb5674d647e24fa478745ac6d40/Iut/Cor312/ContainerHull.lean#L47-L112).
* Project LANA Interim Report on IUT Theory, pinned TeX:
  [reserved judgment and consequence of the main goal, lines 2415--2423](https://github.com/katobungen/LANA_report_202607/blob/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex#L2415-L2423),
  [the two eta maps and main goal, lines 2502--2539](https://github.com/katobungen/LANA_report_202607/blob/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex#L2502-L2539), and
  [same-side comparison and provisional assessment, lines 2644--2680](https://github.com/katobungen/LANA_report_202607/blob/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex#L2644-L2680).
* Shinichi Mochizuki,
  [Inter-universal Teichmuller Theory III, May 2020 author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
  Remark 3.9.5, printed pp. 127--145, and Corollary 3.12, Step (xi), printed
  pp. 181--185.  Local archived PDF SHA256:
  `9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9`.
  In the supplied plain-text extraction, the definition of `Phi(P)` is at
  lines 7843--7867, the object-level obstruction analysis at lines 8007--8430,
  the closed-loop warning at lines 8642--8718, and Steps (xi-d)--(xi-g) at
  lines 11006--11087.

The mathematical audit was completed before the companion Lean module was
written.  Later archival edits added the formalization and replay record just
described; they do not alter the theorem's hypotheses or scope.
