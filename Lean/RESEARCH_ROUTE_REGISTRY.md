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
   together with an archived immutable commit retaining the original route.

Build failures, API drift, lack of a current inhabitant, or lack of community
acceptance are not counterexamples and are not grounds for deleting a route.

## September 1, 2026 global-filter checkpoint

No broad route has been deleted.  The latest mathematical ledger is
`../research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_09_01.md`; standard
`ABCConjecture` remains open in both directions.

- The affine route now has the unconditional seed-sensitive upper gate
  `#E(X) << R^(-2/3)X^(2mu/3+epsilon)`.  Its matching lower gate remains
  active.  The explicit same-prime local counterexample deletes only an
  independence model.
- The balancing-Pell route now forces every hypothetical squarefull term to a
  four-prime, two-depth-three same-rank packet at an odd prime index.  No
  depth-three prime occurs through 2,500,000, and only `1873,1951` remain
  unresolved through index 2000.  These finite exclusions delete no route.
- The Danilov--Hall route now forces every squarefull index into the explicit
  progression with representative
  `122136955032565025967809449110840347537827` and modulus
  `183205432548847538951714173666260521306741`.  The surviving progression
  is active.
- Mordell EDS, Cohn--Nitaj, Frey, geometric, and IUT routes remain active.
  Walsh remains conditional on positive rank of `Y^2=X^3-432p^2` for the
  selected odd prime.

The three new Lean result modules contain 57 theorems and 30 definitions or
structures.  Their four direct targets and the 9,151-job aggregate build pass,
with no `sorry`, `admit`, `native_decide`, declared axiom, `opaque`, or
`unsafe`.  Evidence is frozen in
`verification/2026_09_01_balanced_persistence_continuation/VALIDATION.md`.
The 111-page ChatGPT paper is
`../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_09_01.pdf`, SHA256
`609962b0bf64daf51e5822410c1dbcdff4f55ae452c70d2da6db9fc3e9f87bbc`.

## August 31, 2026 balanced-persistence continuation

No broad route has been deleted.  The newest synthesis is
`../research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_08_31.md`.
The standard unconditional `ABCConjecture` remains unachieved in both
directions.

The **affine-amplification route** remains active.  Its deterministic core
now supplies a primitive injective two-parameter fibre of raw size at least
`c^6/32` below height `c^8`.  Actual exceptional outputs must carry a
large repeated-prime excess in the three new affine factors.  Current
counting theorems give a three-way upper budget but do not refute the
required lower target `|E_c|>=c^(17/4)`.  The exponent `14/3` is only
the relaxed worst-shape lower envelope of those budget exponents, never a
per-seed fibre upper bound.  Fixed-full slices, exact square completion,
and the certified odd-power CRT thickening are closed only in their stated
forms; they do not eliminate the full shear or accidental large-power tails.

The **Pell/Lucas route** remains active in both directions.  The balancing
root factors into two coprime Pell coordinates and is squarefull exactly
when both are squarefull.  Under that still-open premise, adjacent primitive
points have radical slope `1/2`, and even indices have signature
`(3,4,4)`.  Saturation, largest-prime descent, primitive divisors, and
  double-Wieferich packets are necessary conditions, not counterexamples to
  the route.  No theorem in the audited literature forces an exponent-one
  divisor at every large index.

The **Hall--Danilov route** remains active at squarefullness of the moving
Hall remainder.  The exact Hall gate proves slope below `11/12` from
squarefull `K` and `K^2<=X`; Danilov supplies the unbounded primitive
critical-scale source.  Siegel finiteness closes each fixed exact-power
specialization, not moving squarefull values.

The **Mordell EDS route** has an unbounded primitive critical
`(2,6,3)` family.  Its powerful numerator, denominator, or ordinate
upgrades remain active because elliptic primitive divisors do not guarantee
first-occurrence valuation one.  The **Cohn--Nitaj** base families are
genuine infinite `(3,3,3)` families on the critical line.  The analogous
**Walsh** family retains its explicit positive-rank hypothesis.  Their
displayed fullness certificate is insufficient, while additional actual
radical savings or Walsh powerful-coordinate upgrades remain open.

Two broader-sounding negative statements retain narrow scopes.
Darmon--Granville rules out one fixed strict generalized-Fermat equation
and every finite residual-kernel packet; a fixed Pell or elliptic source may
still produce infinitely many kernels.  Mason--Stothers rules out a
polynomial-full tripod; it does not rule out sparse powerful values or
moving denominator kernels.

The permanent
[`targeted counterexample-search bundle`](../research/computation/2026_08_31_targeted_counterexample_search/REPORT.md)
is a finite checkpoint, not a deletion certificate.  It proves
non-squarefullness for every balancing term with `2<=n<=1000` by 999 explicit
exponent-one prime certificates, including all 168 prime indices.  Through
`n=2000`, 1,990 of 1,999 nonunit terms are certified; the nine unresolved
indices are
`[1009,1181,1667,1699,1723,1847,1873,1901,1951]`, each neither a hit nor a
certified non-hit.  The former composite exception `1711=29*59` now has a
`p=44560482149` certificate modulo `p^2`.  Each of the 81 forward Danilov
points with `0<=t<=80` has `v_p(K_t)=1`; the five-small-prime sieve first
leaves `t=326` uncovered, which is not a squarefull hit.  Permanent-directory
replay of `exact_audit.py` validates all 85 manifest entries.  The
[`manifest`](../research/computation/2026_08_31_targeted_counterexample_search/manifest.json)
has SHA256
`62abe5c80716d9e4d5697df95e5330b9fb3d011f463d4647e72332c9288bbac3`.
None of these bounded computations closes the Pell or Danilov route.

The user-directed persistence rule is controlling: mathematical proof comes
before Lean, and no route is removed because it is hard, because a finite
search is negative, or because a necessary condition is severe.  An actual
counterexample rejects only its exact universal claim.  A proved
impossibility theorem closes only the mechanism covered by its hypotheses.

The four new mathematical modules are
`PellAdjacentFactorCounterexample20260831`,
`PellSquareRootDescent20260831`,
`HallSquarefullCounterexample20260831`, and
`AffineShearAmplification20260831`.  Their explicit hand-written top-level
source inventory is **62 theorem declarations plus 15 definitions or
structures, for 77 declarations total**.  Automatically generated structure
machinery and recursive equation declarations are not included.  The separate
`ResearchBalancedPersistence20260831Audit` entry enumerates all 77 with
`#check` and `#print axioms`; it is not counted as a fifth mathematical
module.  The frozen evidence in
`verification/2026_08_31_balanced_persistence/VALIDATION.md` records direct
exit-zero, warning-free compilation of those five files; an 8,767-job audit
target with 19 historical warnings and zero new-module warnings; and 9,147-job
library and default builds with 265 warnings whose multisets exactly match
the dual-route baseline.  No `sorry`, `admit`, axiom declaration, `unsafe`,
or `sorryAx` is present; the dependency union is only `propext`,
`Classical.choice`, and `Quot.sound`.  Thirteen JSON files parse, the 22-file
manifest agrees, and all 23 `SHA256SUMS` entries verify.  Its checksum-list
SHA256 is
`4e25867f5026bbd04a05240de9d6f51e06abc6518bf9819d48aaa03d1bb85916`.
The released ChatGPT paper is
`../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31.pdf`: 109 pages,
830,854 bytes, SHA256
`ccbc4d77d112aec78a869caba53104b133467f6cd4a60ee528e09437f79d2e3e`.
All 109 pages were rerendered at 110 dpi.  Only pages 102--109 changed from
the preceding fully inspected candidate, and all eight passed original-size
inspection.  Extracted text has 340,732 characters, with at least 1,926 on
every page.  All 29 fonts are embedded; the PDF has no forms or JavaScript;
and the log has only one pre-existing underfull box.  The retained QA
directory is
`../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31_QA`, whose
`SHA256SUMS` SHA256 is
`206f1edb9c9e190ec65c3333ddf2a3166fefe06f907e132f349725897be18e98`.

## August 31, 2026 dual-route continuation

No route has been deleted. The newest completed increment is
`../research/ABC_DUAL_ROUTE_CONTINUATION_2026_08_31.md`, with exact validation
in `verification/2026_08_31_dual_route_continuation/VALIDATION.md`. The
standard unconditional ABC target remains unachieved.

The **positive uniformity route** now has an exact endpoint: standard abc is
equivalent to bounding height on every fixed subcritical radical locus
`R <= mu H`, `mu<1`. Positive-power counting and square gaps are proved
logically insufficient by an explicit super-sparse countermodel. This route
remains active at the source-amplification gate: construct, for each bad
source, more distinct actual targets than the best uniform target count
allows, or prove an eventual empty-shell estimate.

The **mixed-full counterexample route** remains active under sharper
constraints. A strict unbounded family must escape through infinitely many
residual-kernel triples, and it cannot arise from a polynomial-full tripod.
The Pell orbit `x^2-8y^2=1` supplies a valid conditional disproof mechanism:
an unbounded squarefull subsequence of `y` would give primitive `(7,3,2)`
triples and disprove the unchanged standard target. That subsequence is not
known. Primitive divisors alone do not settle their valuations. Future
search must target squarefull recurrence values or another kernel-escaping
fixed-slope family; finite numerical scans are only consistency checks.

The **Frey/isogeny route** now proves a coefficient-below-six obstruction for
the displayed entire rational isogeny class. This does not prove a global
optimal coefficient six and does not supply small radical. The
**three-prime-support route** records exact signature and placement results,
while the **finite-product IUT route** proves a local product-span formula.
The latter still lacks construction and comparison of the complete globally
synchronized marked family.

The six modules contribute 94 theorems and 15 additional declarations. All
109 reports pass the kernel-dependency audit; the full 9142-job build has the
same 265-warning multiset as the frozen baseline and zero new module warnings.
The 102-page ChatGPT manuscript passed full-page render inspection. These
checks preserve the distinction between a formally verified implication and
the unproved mathematical premise needed to close either route.

## August 31, 2026 two-prime support, entire-class heights and canonical membership

No broad route is abandoned. The newest completed increment is
`../research/ABC_UNIFORM_CONTINUATION_2026_08_31.md`, with its exact
scope in `verification/2026_08_31_uniform_continuation/VALIDATION.md`.
The standard unconditional ABC target remains unachieved.

The analytic route now proves the complete moving two-prime subclass
and the exact labelled odd-part fibre bound. It still needs control of
general prime support or a valid amplification lower bound in the
previously proved necessary window. The scalar-return constraint is
conditional on actual pointwise return and support/label preservation;
forming an ideal hull does not preserve those conditions automatically.

The geometry route determines an entire rational isogeny class in an
unbounded Frey family and calculates its exact least Weil height.
The family is a counterexample to two specified universal replacement
steps: obtaining a sixth-power minimal discriminant by choosing an
isogenous representative, and reducing the leading Weil-height
coefficient below six by that choice alone. It does not have a proved
small radical. The general Frey/Szpiro, conductor/height, Arakelov and
moving-support routes remain open.

The IUT route now includes the standard finite theta torsion source
and one source-compatible synchronized base branch. Its canonical
transfer action is `M_alpha^(-1)`. The proof keeps the three cyclotomes,
preceding carrier and transported unit explicit. On the rational
field-of-moduli specialization, one selected place gives literal
local raw-set membership; for a multiple-place packet it gives only
projection membership. The exact orbit hull gives `P_j` as a lower
inclusion. It does not prove equality with the whole raw union, the
IUT III/IV global upper comparison, or ABC.

The arithmetic-bundle construction supplies genuine objects and
isometric determinant descent. Its connection with the whole published
global pilot, all vertical branches, IPL/SHE, the horizontal codomain
and the unchanged q-pilot still requires proof with identical markings
and measure references. These obligations are not dismissed for being
difficult, and the new local membership is not listed as still missing.

Every new Lean theorem had a preceding mathematical proof. Five new
modules, 97 public theorems and 9 extra constructions passed the
106-declaration audit and 9135-job build. The 93-page ChatGPT paper
was compiled and every page was visually inspected. No complete
local reconstruction or entire-class classification is falsely counted
as Lean formalization. The older 705/506/447 manifests are unchanged.

## August 31, 2026 exact local hulls and global initial data (historical)

This is the preceding completed increment. The newer local membership
result above supersedes only its specific one-branch source obligation;
its complete global comparison was not thereby proved.

No route has been deleted. The preceding completed increment is
`../research/ABC_GALOIS_LIFTS_2026_08_31.md`, with the exact proof/formal
boundary in `verification/2026_08_30_galois_lifts/VALIDATION.md`.
The standard unconditional ABC target is still unachieved.

The IUT route now has actual full-group minimum-layer maps, a common
arrow for every square label in the specified tame family, and the
sharp equality between the pre-transport ideal hull and the point hull.
The whole-product source remains strictly larger. Full original initial
theta data are constructed for an exact level-43 Frey curve and an
unbounded power-free family over the stated torsion fields. The earlier
missing full-Galois lift and initial-data existence are not repeatedly
listed as open after these proofs.

The remaining IUT task is to compute and compare the complete published
global families, including weights, markings, Ind3 and cross-Frobenius
compatibility. The singleton root, its powered label, a full principal-
unit multiplication image, and an ideal formed before transport retain
their distinct quantifiers. Consistent standard-log scaling changes
every tensor factor and the source. Neither local native positivity nor
a loose upper container is an IUT or ABC counterexample.

One precise formulation is refuted: a compact set in ambient Qbar2 with
nonempty interior cannot exist. The original finite-extension slice
compactness condition is different and is satisfied by the constructed
fixed domain. This does not refute the corrected domain or the IUT route.

The analytic route retains actual-radical uniform counting and the
unproved required amplification lower bound. The arithmetic-geometric
route retains uniform height/conductor, varying-support and regulator
control. The unbounded power-free family supplies genuine geometric
inputs but is not an ABC counterexample or a replacement for an
all-epsilon estimate. New proofs must precede any new Lean claims.

Seven new modules, 130 public theorems and 15 additional constructions
have complete standard-axiom audits. The 66-page ChatGPT manuscript and
older snapshots are retained. Full local-field and initial-data geometry
are not falsely included in that formal count. No broad route is closed
merely for remaining incomplete.

## August 30, 2026 uniform estimates and admissible maps (historical)

The following records the preceding 89-theorem increment. Its separate
full-Galois work has since been completed to the scope stated above.

No route has been deleted. The latest completed increment is recorded in
`../research/ABC_UNIFORM_GATE_2026_08_30.md` and
`verification/2026_08_30_uniform_gate/VALIDATION.md`. It does not contain
an unconditional proof or disproof of standard `ABCConjecture`.

The analytic route now counts triples with actual bounded radical and a
prescribed radical divisor, and gives exact excess identities for integer
conic lifts. Its necessary window remains open for a sufficiently strong
lower bound. Concrete cancellation and quadratic-tripod examples reject
only the corresponding universal support/quality claims, not every
rational transformation or amplification strategy.

The Frey/Mordell route now uses all three actual points associated to
every `ABCPoint`. It retains cubic-field indices and regulators and
identifies their common curve and rational 3-torsion orbit. Fixed-support
Siegel asymptotics do not settle varying support. The infinite `R0=3`
family specifically disproves finiteness from bounded residual support;
it is not an abc counterexample.

The IUT route now uses the original all-open-subgroup Ism definition:
its action is scalar, and actual Ind2 does not enlarge a fixed `B`-module
hull. The mono-analytic procession retains local outer Galois
representatives without a curve-lift requirement. The remaining Ind1
image is nevertheless a genuine Galois/Kummer image, subject to a trace
constraint. Neither all integral matrices nor their trace stabilizer
is silently inserted as that image. A full Jannsen--Wingberg group
construction is under separate proof review and is not included in
the completed 89-theorem audit.

## August 30, 2026 continuation

The principal result of this earlier increment is effective finiteness of the specified positive
Pell--Chebyshev packet, uniformly in its integer index, by the original
normalized Matveev bound and BEG. It is a positive theorem for that
packet, not elimination of the whole Pell/Frey route and not a global
reduction from abc. Fundamental-unit cases and the required weighted
radical estimate remain active mathematical problems.

The analytic route retains amplification using actual small radicals;
only the two explicitly size-certified CRT/conic constructions now have
proved output-count restrictions. The local IUT route retains genuine
source-family comparison after the native point and coefficient-hull
containment. The 109-adic example rejects one direct dictionary, not
IUT. Its failure of Joshi's prime window is explicitly recorded.
Likewise, the exact hull in the full integral-linear automorphism model
cannot be transferred to a smaller Galois-induced family: a strict
counterexample to that unrestricted transfer is recorded in the new
cross-review.

No branch was deleted. Proofs, formal scope, and the next uniform gates
are collected in `../research/ABC_CONTINUATION_2026_08_30.md` and
`verification/2026_08_30_continuation/VALIDATION.md`.

## Retained routes

- `formalize/bridge-inhabitation-audit`: logical/circularity audit of downstream
  bridge packages.
- `formalize/canonical-source-derived-bridge`: canonical q-pilot, honest
  finite-positive volume, source and orbicurve construction experiments.
- `formalize/corrected-theta-graph-period`: odd theta-root graph-period
  descent, ordinary topological orbit cover, and the still-open
  rigid/Berkovich/tempered comparison.
- `formalize/multiradial-ahs-scale`: construction of genuinely distinct
  arithmetic holomorphic structures satisfying the cross-label
  tensor/procession compatibility; fixed-place scalar adapters are only
  diagnostic models.
- `formalize/source-faithful-iut4`: residue-normalized actual q-pilot,
  local/procession estimates, and the authentic odd-q Theorem 1.10 route.
- `formalize/concrete-genell-fermat`: the affine finite-etale Fermat cover,
  followed by projective compactification, ramification, Belyi descent, and
  height comparison.
- `formalize/frey-j-height-*`: exact Frey/Legendre rational Weil-height route.
- `formalize/frey-discriminant-*`: discriminant radical and conductor route.
- `formalize/frey-calibrated-*`: strict bridge calibrated by the actual Frey
  `j`-height.
- `formalize/shifted-j-*`: nonintegral shifted-`j` curve route toward a uniform
  non-CM/open-image input.
- `formalize/legendre-j-height`: primitive Legendre-ratio height route.
- `research/joshi-arithmetic-teichmuller`: independent audit and possible
  formalization of Kirti Joshi's Arithmetic Teichmuller Spaces.
- `research/abc-powerful-core-v8`: square-core, cube-core, diagonal-conic and
  diagonal-cubic reductions for prospective counterexamples.
- `research/abc-exceptional-amplification-v8`: incidence amplification criterion
  converting a power-saving exceptional-set estimate into finiteness.
- `research/abc-torsion-line-energy-v8`: local Tate-line energies and locally
  adaptive adelic successors after the fixed-packet no-go theorem.
- `research/abc-legendre-parabolic-higgs-v8`: globally labelled three-cusp
  parabolic/Higgs route; its arithmetic specialization theorem remains open.

## Variants eliminated by proved no-go theorems

### Fixed place-independent torsion packet

For canonical/noncanonical Tate coefficients

`A_ell = (ell - 1)/12`, `B_ell = -(ell - 1)/(12*ell)`,

every fixed line-weight system satisfies

`average_C S_C(w) = 0`

under the complete transitive projective orbit. This eliminates the naive fixed
three-line determinant variant. Its original work is retained at commit
`30430eadad8a4f4035c35479e80cd2cc630c6cc0`; the no-go theorem and useful
different estimate are ported into the v8 integration commit.

### Generic full-orbit CRT/Minkowski selector

The general congruence-lattice selector retains only a `1/(ell+1)` fraction of
projective depth, while

`B_ell + (A_ell - B_ell)/(ell + 1) = 0`.

Thus that generic selector cannot produce a positive uniform q-coefficient.
Its original work is retained at commit
`a3decfc45e01e011dc38a6d4542b4dbcf4a2d662`; the dimension-barrier theorem is
ported into the v8 integration commit.

The corrected successors use locally adaptive filtrations or globally labelled
three-cusp parabolic data and are not excluded by these no-go theorems.

## Retired claims with recorded counterexamples

- **Most smooth numbers in the selected short intervals have very few prime
  factors.** Finite prime-power encoding and Younis's unconditional theorem
  show that, at the stated subexponential smoothness scale and interval
  length `x^(3/5)`, the relative population with
  `omega(n)<=2 log log x` tends to zero, while the proposed moment assertions
  would imply the opposite behavior. The exact claims in Carella v2,
  Lemmas 4.2 and 4.4 and (4.24), are refuted; a sparse-neighbour route remains.
  See `../research/ANALYTIC_ROUTE_SESSION_2026_08_30.md`.
- **Each large endpoint has a separate subcritical signed-defect bound.**
  The primitive dyadic family has defect `(N-2)log 2` on one endpoint and
  full conductor at most `(N+2)log 2`, ruling out every separate slope
  below one. Only this stronger substitute is rejected; the coupled
  two-endpoint estimate remains exactly equivalent to abc and open.
- **Simultaneous tensor actions generate a complete tensor lattice.**
  The integral span of `v tensor v` in rank two is exactly the symmetric
  submodule and omits `E12`; it has zero ambient Haar measure over a local
  field. This refutes the abstract simultaneous-action substitute, not any
  asserted identification with the full actual IUT output set. The positive
  independent-action and reachable-determinant route is retained.

- **Root-pullback equals graph cover.**  If `r^ell=q`, the map induced by
  `v |-> v^ell` from the `r`-Tate quotient to the `q`-Tate quotient has degree
  one on normalized radial skeletons and angular kernel `mu_ell(K)`.  It is not
  the graph-direction `Z/ell Z` cover.  The cyclotomic/Kummer isogeny results
  are retained; the corrected graph-period route uses `<q^ell> <= <q>`.
- **Complete global `j` packet may directly replace the IUT IV odd q-divisor.**
  The Frey family `(1,2^m,2^m+1)` gives an omitted height packet larger than
  `2 * log(rad(abc))` up to a positive constant, so the replacement forces a
  nonvanishing conductor-error slope.  The source-faithful odd-q and
  compact-tripod/GenEll route is retained.
- **The Tate `K`-point quotient is the valuation skeleton circle.**  In
  characteristic zero the class of `-1` is nontrivial in `K^x/q^Z` but maps
  to zero under the log-norm circle coordinate.  Thus the direct `K`-point
  map is not injective.  The analytic Berkovich retraction and the tempered
  skeleton comparison remain retained targets.
- **One fixed-place scalar supplies the multiradial bridge.**  Labels one and
  two have concrete degrees `L` and `4L`, so no common scalar calibrates both
  to nonzero `L`.  The labelwise scalar `1/j^2` is retained as a diagnostic,
  but it is not the source's cross-label tensor/AHS construction.

The full mathematical arguments are recorded in B.0, B.5.0, C.0, and D.0 of
`CORE_PROOF_NOTEBOOK.md`.  These entries retire only the stated
identifications, not abc, IUT, or the corrected surviving routes.

## Merge policy

Only non-circular statements with a complete dependency audit are merged into
`main`.  They may be Lean-kernel closed or closed relative to a precisely named
accepted-theorem/certified-computation interface, using the labels and trust
ledger in `ACCEPTED_THEOREM_DEPENDENCY_POLICY.md`.  Open, disputed, heuristic,
or target-equivalent inputs remain conditional; explicitly labelled mathematical
research documents may record such open routes without asserting closure.  When
an old branch contains useful results but also stale history, a broken interface,
or an eliminated formulation, the verified result is ported onto a fresh branch
based on current `main`; the old branch is retained unchanged for auditability.

No entry in this registry asserts a parameter-free proof of `ABCConjecture`.

## 2026-09-01 integrated cloud continuations

The current integrated line retains the following distinct verified advances:

- the v27 natural exponent-profile bridge, canonical cube-divisor extraction,
  and coprime residual-product core;
- the v29 canonical exponent-height and support-congruence ledgers;
- the symmetric cross-support depth and cubeful-tail reformulation;
- the v29b--v29i shared-support contact identities, coefficient ledgers,
  positive-contact closure, square-collapse descent, and two precise unit-gap
  no-go results;
- the source-defined ordered-hull and closed-real-ray approximation criteria
  for the scalar step isolated from IUT III, Corollary 3.12.

The first four items reduce a hypothetical height violation to sharper
exponent, support, contact, or cube-divisor obligations.  They do not supply
the uniform high-depth estimate needed to close abc.  The final item proves
the scalar implication of a correctly typed hull approximant and exactly what
a vanishing numerical approximation would imply, while leaving the same-pilot
global hull identification open.  Temporary
branch-specific CI marker workflows, diagnostic-only branches, and versions
strictly superseded by these continuations were not copied into the integrated
tree; their remote histories remain available for audit.
