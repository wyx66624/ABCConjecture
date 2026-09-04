# ABC Conjecture Research and Lean Formalization

Author: ChatGPT

> [!IMPORTANT]
> **Global status as of September 3, 2026:** this repository does **not**
> contain an unconditional proof or disproof of the standard abc conjecture.
> It contains verified local theorems, conditional reductions, exact no-go
> results, source-dependent interfaces, and reproducible finite computations.
> These categories are kept separate throughout the project.

## Project goal

For pairwise coprime positive integers `a`, `b`, and `c` with `a + b = c`, let
`rad(abc)` be the product of the distinct primes dividing `abc`. The standard
abc conjecture asserts that, for every real `epsilon > 0`, there is a constant
`K_epsilon` such that

```text
c <= K_epsilon * rad(abc)^(1 + epsilon)
```

for every such triple.

The repository studies this target through several parallel programs: IUT,
Tate analytic geometry, GenEll/Fermat covers, Arakelov--Vojta and
Frey--Szpiro reductions, S-unit methods, arithmetic derivatives,
Pell/Lucas and Mersenne sequences, divisor packets, incidence complexes, and
prime-mass transport. Ordinary mathematical arguments are developed first;
precise elementary cores and conditional implications are then formalized in
Lean where feasible.

The formal end goal is one of the following:

- an unconditional Lean term of type `ABCConjecture`; or
- a rigorous disproof consisting of one fixed positive `epsilon` and an
  infinite primitive family that defeats every constant in the standard
  inequality.

Neither end goal has been reached.

## Where to start

| Document | Purpose |
| --- | --- |
| [`research/ABC_ROUTE_BOTTLENECKS.md`](research/ABC_ROUTE_BOTTLENECKS.md) | Authoritative cross-round checklist of live gates, retired claims, and the next positive and adversarial action for each route |
| [`Lean/RESEARCH_STATUS.md`](Lean/RESEARCH_STATUS.md) | Detailed proof-status ledger, including formal scope, dependencies, counterexamples, and unresolved obligations |
| [`Lean/RESEARCH_ROUTE_REGISTRY.md`](Lean/RESEARCH_ROUTE_REGISTRY.md) | Route history, retention and retirement decisions, and merge policy |
| [`Lean/README.md`](Lean/README.md) | Lean package overview, conditional theorem audit, missing constructions, and build instructions |
| [`Lean/verification/2026_09_03_incidence_endpoint_literature/README.md`](Lean/verification/2026_09_03_incidence_endpoint_literature/README.md) | Latest incidence/endpoint checkpoint replay protocol |
| [`paper/ChatGPT_ABC_Uniformity_2026.tex`](paper/ChatGPT_ABC_Uniformity_2026.tex) | Current English manuscript source |
| [`output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`](output/pdf/ChatGPT_ABC_Uniformity_2026.pdf) | Latest sealed 270-page manuscript artifact |

The bottleneck ledger is the persistent entry point for new research rounds.
An unchecked item stays open: difficulty, a missing bridge theorem, or a
finite search with no hit is never treated as a proof or as a reason to retire
its parent route.

## Evidence and status vocabulary

The project uses the following distinctions strictly.

| Label | Meaning |
| --- | --- |
| **Kernel-checked** | Lean has accepted the stated theorem, with its axiom dependencies reported. This proves exactly the encoded statement, not a stronger informal interpretation. |
| **Ordinary proof** | A complete mathematical argument is recorded outside Lean. It may later be formalized, but it is not described as kernel-checked until then. |
| **Conditional reduction** | A theorem proves that an explicitly stated new hypothesis would imply abc. The hypothesis itself remains open and is not silently assumed. |
| **Source-dependent result** | The argument uses a precisely cited external theorem with its original hypotheses. Disputed or incomplete source programs are not relabelled as established inputs. |
| **Certified computation** | A deterministic finite range was checked and can be replayed. A null finite search is evidence only, never a global theorem. |
| **Retired claim** | A proof or a counterexample satisfying every premise has closed that exact formulation. The broader route remains active unless the counterexample refutes the parent statement itself. |
| **Open** | No proof or complete-premise refutation is currently available. |

New global claims may not be closed with `sorry`, `admit`, an undocumented or
target-equivalent axiom, an opaque existence assumption, or a structure whose
inhabitation is merely another spelling of `ABCConjecture`.

## Current route map

The table below summarizes the live mathematical program. Full quantifiers and
the exact next actions are in the
[`bottleneck ledger`](research/ABC_ROUTE_BOTTLENECKS.md).

| Route | What has been established | Decisive remaining gate | Status |
| --- | --- | --- | --- |
| **IUT / pointed same-pilot** | Actual finite-positive Haar regions, local-degree correction, uniformizer orbits, and abstract pointed same-pilot interfaces have been constructed. Published IUT inputs are tracked with source labels. | Realize the source-faithful all-place tensor and integral-order objects; close Ind1--Ind3 and same-pilot transport; derive the global height estimate without assuming an abc-equivalent bridge. | Active |
| **Canonical gain / defect flags** | For primitive nonunit triples, the project proves `1/3 < A_can < 1/2`, `q = A_can * P_can = 1 + X - Y`, and the exact cocycle. The uniform defect-flag budget is proved equivalent to abc, not inhabited. | Prove an independent uniform upper bound for the correlated difference `X - Y`. | Active; two factorwise shortcuts retired |
| **Synchronized divisor packets** | Finite packet algebra, support laws, orientation rigidity, exact-gap families, a sixth-power envelope, and real-log energy majorants are formalized. The compensated implication `B(Q)^m <= (ab)^m R^(m+n) -> c^m <= R^(m+n)` is valid. | Construct eventual packets satisfying the compensated bound, or produce an infinite full-premise obstruction to that exact bound. | Active; the uncompensated gate is retired |
| **Fixed-parameter Pell / signed traces** | Fixed `T = 2` support transversality, adjacent trace-square identities, support-depth doubling, and the fourth-power packet reformulation are proved. | Exclude exponent-one support failure uniformly at large odd prime indices, or construct an unbounded simultaneous-squarefull prime-index family; control first-apparition valuations. | Active |
| **Mersenne / Farey / super-Wieferich** | Harmonic prefix bounds, finite swarm inequalities, quantifier transfer, unconditional scale brackets, and finite injections of already certified depth-three rows are checked. | Produce actual prime/exact-order/depth-three rows from the Farey tail and prove the critical global `W_3(x)` count. | Active |
| **Steinberg / five-term contact** | Integer normalization, finite divisor cells, five-term generated boundary submodules, and their calibrated boundary implication are proved. Single-cell and fixed one-move policies have exact counterexamples. | Construct a positive generated filling for every target boundary and prove both uniform Gate VF cost estimates. | Active |
| **Affine ownership / catalogues** | Maximal-support ownership and the Cauchy aggregation skeleton are proved; owner-free and reversed-monotonicity shortcuts are refuted. | Build the concrete maximal cover and prove canonical low-support catalogue sparsity or supersaturation. | Active |
| **Alternative-quality packing** | The identity `q_std = eta * q_DGM` and the exact transfer equivalence are proved. An abstract model refutes metric-only transfer. | Establish an arithmetic lower bound or correlation for `eta * q_DGM` on actual primitive abc triples. | Active |
| **Labelled valuation-incidence complex** | The three-arm face lattice, radical/defect/modulus coordinates, filtration, congruence signatures, CRT reconstruction, and top-face half-space are formalized. Several one-face, raw three-arm, ordered transport, relative-drop, and exclusive-packet gates have complete infinite counterfamilies. The SCRT-0 successor now supplies a once-charged shared-hyperedge height bridge. | Prove or refute the exact uniform SCRT-0 estimate; then develop surplus-reuse, weighted multi-face, or genuine homological successors without duplicating capacity or collapsing to the scalar defect. | Parent route and SCRT-0 active; listed gates retired |
| **Signed endpoint and prime-packet transport** | Exact core balance, fractional-flow accounting, Hall-tail obstructions, and correctly quantified implications from EPF, BEP, PBT, and SCRT-0 to abc are established. Linnik's theorem gives an unconditional prime-neighbour counterfamily to PBT whose scalar abc defect is zero; shared saturated CRT blocks repair that artificial loss. | Resolve the prime-log partition problem for composite-base powers, compute SCRT-0 independently, and prove or refute its uniform gate. | Parent route and SCRT-0 active; EPF, BEP, exclusive PBT, and SCRT-SAT retired |
| **Function-field / Mason specialization** | The exact polynomial abc theorem from Mathlib is reused with its necessary derivative-zero disjunct, and the positive-characteristic Frobenius obstruction is recorded. | Construct an integer specialization theorem that controls bad primes and coefficient height while preserving enough radical information uniformly. | Active |
| **Smooth-neighbour / global-omega** | Incorrect moment/error absorption claims have been isolated and refuted without discarding the broader analytic route. | Prove a valid joint distribution theorem for smoothness and many distinct prime factors in the required short intervals. | Active |
| **Frey--Szpiro / Arakelov--Vojta / effective integral points** | Exact Frey invariants, height corridors, conductor components, Fermat/GenEll algebraic geometry, and conditional transfer interfaces have substantial formal coverage. | Supply a noncircular uniform Szpiro- or Vojta-strength estimate with all constants uniform as the curve and prime support vary. | Active |

S-unit, arithmetic-derivative, Wronskian, parabolic/Higgs, and related
exploratory constructions remain supporting lines. Their reusable lemmas and
precise barriers are preserved in the detailed status ledger, but none
currently supplies the missing uniform global estimate.

## Latest checkpoint: incidence and endpoint transport

The September 3 working-tree checkpoint adds a labelled valuation-incidence
complex and two prime-mass transport successors.

### Results now proved or formalized

- The incidence complex records all three labelled prime supports with exact
  radical, valuation-defect, modulus, filtration, congruence, and CRT data.
- The witness `(12,833,845)` refutes only the proposed universal
  zero-defect-arm and constant-valuation-per-arm strengthenings.
- The infinite family
  `(2^(k+4), 3, 2^(k+4)+3)` refutes the fixed absolute-budget selector
  VIC-ABS-1.
- The family
  `(2^(2r), 3^r, 2^(2r)+3^r)` refutes the coefficient-one fixed-slack
  selector VIC-1R: every reconstructing face incurs defect at least `3r-2`,
  while the binary scale is at most `2r+1`.
- A primitive Pythagorean-square family refutes the raw weighted three-arm
  gate RAW-3C with all positivity, coprimality, coverage, and quantifier
  premises present.
- Ordered complement transport proves the exact reduction
  `height <= conductor + unmatchedMass`; a sufficiently small uniform
  unmatched-mass estimate would therefore imply abc.
- The infinite odd-prime family `(1, p^2-1, p^2)` refutes that ordered CT-3C
  estimate and the ordered endpoint fractional-flow gate EPF at
  `epsilon = 1/4`: the source at `p` has no permitted larger complementary
  sink.
- Completely unordered transport has optimum
  `max(0, log(c)-log(rad(abc)))`, so it is only a scalar restatement of the
  original difficulty.
- The first bidirectional successor charges relative logarithmic displacement
  on downward edges. A subsequent complete-premise infinite counterexample
  refutes its exact uniform BEP gate: prime-hypotenuse Pythagorean squares force
  every flow to have energy at least `(log p)/4`, while the conductor is at
  most `3*log p`. Lean closes the negation at `epsilon = 1/24`. This does not
  refute abc or the parent bidirectional route.
- A still newer successor groups whole external radical-prime sinks
  into source packets. Its boundary residual satisfies `height <= conductor +
  residual`, and the uniform PBT residual bound would imply abc. The note also
  shows that indivisibility prevents immediate collapse to the scalar
  fractional optimum. A second adversarial audit then refutes PBT itself:
  Linnik's theorem constructs `(1, ell, ell+1)` with one external prime but
  arbitrarily many compulsory powerful-prime sources. Every point nevertheless
  satisfies `height <= conductor`, so this refutes exclusivity rather than abc.
- SCRT-0 replaces exclusive ownership by disjoint saturated CRT hyperedges and
  retains ordinary exclusive packets for unused sinks.  Once-only charging
  gives `height <= conductor + B_SCRT` and SCRT-0 would imply abc.  Arbitrary
  partial pooling is exactly the scalar defect, while `(343,625,968)` proves
  the retained boundary is strictly non-scalar.  The progression
  `(2,15^n-2,15^n)`, `n=284 mod 310`, refutes only the saturated-only child
  SCRT-SAT.  No complete-premise counterexample to SCRT-0 is currently known.

These counterfamilies do **not** disprove abc. They eliminate only the named
auxiliary gates and guide the construction of less lossy successors.

The eleven completed principal Lean modules in this checkpoint expose 496
public declarations, paired one-for-one with axiom queries. The checkpoint
replay records successful strict compilation, the umbrella build, an
environment axiom audit, and deterministic endpoint computations. Its reported
dependency union contains only `propext`, `Classical.choice`, and `Quot.sound`;
no open replacement gate and neither `ABCConjecture` nor its negation is
introduced as an axiom.

The replay result and the final artifact seal are separate claims. The sealed
validation record gives the exact commands, hashes, and PDF checks for the
frozen source set.

The complete ordinary arguments are recorded in:

- [`research/ABC_LABELED_VALUATION_INCIDENCE_COMPLEX_2026_09_03.md`](research/ABC_LABELED_VALUATION_INCIDENCE_COMPLEX_2026_09_03.md)
- [`research/ABC_ORDERED_PRIME_TRANSPORT_OBSTRUCTION_2026_09_03.md`](research/ABC_ORDERED_PRIME_TRANSPORT_OBSTRUCTION_2026_09_03.md)
- [`research/ABC_SIGNED_ENDPOINT_PRIME_TOKEN_TRANSPORT_2026_09_03.md`](research/ABC_SIGNED_ENDPOINT_PRIME_TOKEN_TRANSPORT_2026_09_03.md)
- [`research/ABC_BIDIRECTIONAL_PRIME_TRANSPORT_SUCCESSOR_2026_09_03.md`](research/ABC_BIDIRECTIONAL_PRIME_TRANSPORT_SUCCESSOR_2026_09_03.md)
- [`research/ABC_BIDIRECTIONAL_ENERGY_ADVERSARIAL_AUDIT_2026_09_03.md`](research/ABC_BIDIRECTIONAL_ENERGY_ADVERSARIAL_AUDIT_2026_09_03.md)
- [`research/ABC_PRIME_PACKET_BOUNDARY_TRANSPORT_SUCCESSOR_2026_09_03.md`](research/ABC_PRIME_PACKET_BOUNDARY_TRANSPORT_SUCCESSOR_2026_09_03.md)
- [`research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md`](research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md)
- [`research/ABC_PRIME_PACKET_BOUNDARY_COMPUTATION_2026_09_03.md`](research/ABC_PRIME_PACKET_BOUNDARY_COMPUTATION_2026_09_03.md)
- [`research/ABC_SHARED_CRT_INCIDENCE_SUCCESSOR_2026_09_03.md`](research/ABC_SHARED_CRT_INCIDENCE_SUCCESSOR_2026_09_03.md)
- [`research/ABC_PRIMARY_LITERATURE_GATE_AUDIT_2026_09_03.md`](research/ABC_PRIMARY_LITERATURE_GATE_AUDIT_2026_09_03.md)

The literature audit through September 3, 2026 found reusable IUT,
radical-defect, aggregate-counting, Mason--Stothers, Pell/Lucas, and
approximation results under their original assumptions. It did not identify a
generally accepted unconditional proof or disproof of standard abc, and it
does not close the repository's all-place/Ind3/pointed IUT chain.

## Other September 3 advances

Three additional routes reached a clean current boundary before the incidence
checkpoint.

- **Canonical gain:** the exact gain decomposition and defect-flag
  equivalence are formalized. `(3,125,128)` refutes the universal bound
  `P_can <= 3`, but not abc. The live problem is the correlated difference
  `X-Y`.
- **Packet radical excess:** the family
  `(2^(k+4),3,2^(k+4)+3)` refutes the former eventual uncompensated bound
  `B(Q) <= R^(1+epsilon)` at `epsilon = 1/3`. The corrected bound includes
  the necessary `ab` compensation and remains open.
- **Pell signed trace:** adjacent traces are converted into a fourth-power
  packet problem. Exact rows at `(ell,q) = (7,13)` and
  `(773231,1546463)` refute automatic promotion to trace depth five. They do
  not provide a simultaneous squarefull infinite family.

The combined replay for that earlier checkpoint passed all 16 tasks,
including a 9,271-job umbrella build. Its sealed English manuscript has 246
A4 pages and SHA-256
`7d0834d7cfbc2095e77429141fd42e2c36d65913db6d7c3798909ed59778031e`.

## What has and has not been proved

### Established within stated scope

- Many exact algebraic, valuation-theoretic, analytic, combinatorial, and
  height identities used by the candidate routes.
- Multiple implications of the form “precise uniform gate implies
  `ABCConjecture`,” with the epsilon and constant quantifiers checked.
- Logical circularity audits showing when inhabiting an apparently new bridge
  is already equivalent to assuming abc.
- Exact infinite counterfamilies to numerous overly strong selectors,
  factorwise estimates, transport rules, and packet envelopes.
- Reproducible bounded computations used only for their stated finite ranges.
- Large collections of Lean declarations with per-declaration axiom reports
  and checkpointed builds.

### Still not established

- No parameter-free theorem `abc_conjecture : ABCConjecture`.
- No construction of an inhabited source-derived `FourStageProgram` or an
  independently inhabited `NonCircularIUTIVBridge`.
- No source-faithful global IUT IV height theorem with the required uniform
  quantifiers.
- No uniform Szpiro-, Vojta-, S-unit-, specialization-, packet-, incidence-,
  or transport estimate strong enough to close abc without circularity.
- No fixed-positive-excess infinite family satisfying the exact disproof
  quantifiers.
- No finite computation that is promoted beyond its certified range.

The Lean package proves the conditional theorem

```lean
theorem FourStageProgram.abc_conjecture
    (P : FourStageProgram) :
    ABCConjecture
```

and equivalently proves abc from `Nonempty FourStageProgram`. This is not an
unconditional proof: no intended source construction of `FourStageProgram`
has been supplied. The inhabitation audit further shows that the current
bridge type is logically as strong as abc in the unrestricted setting. See
[`Lean/README.md`](Lean/README.md) for the exact equivalences and missing
implementations.

## Research roadmap

Each route follows the same proof discipline.

1. State a gate with all dependencies, quantifier order, constants, and
   positivity or coprimality hypotheses explicit.
2. Prove the ordinary mathematical reduction before encoding it in Lean.
3. Search adversarially for a counterexample satisfying every premise.
4. Retire only the exact statement that has been proved false; preserve useful
   parent structures and corrected successors.
5. Formalize the proved core and audit every public declaration's
   dependencies.
6. Replay deterministic computations and compare frozen outputs or hashes.
7. Update the status ledger, manuscript, and verification package without
   turning a conditional result or finite search into a global claim.

The immediate mathematical priorities are:

1. formalize the arithmetic SCRT-0 hypergraph above the checked once-charged
   capacity kernel, build an independently replayed exact optimizer, and
   resolve the composite-base prime-log partition obstruction;
2. seek a genuinely correlated estimate for canonical gain rather than
   separate bounds on its factors;
3. attack the compensated packet bound and the first-apparition valuation in
   the fixed Pell route;
4. connect the Farey tail to actual exact-order depth-three Mersenne rows;
5. construct controlled positive five-term fillings and concrete affine
   ownership catalogues;
6. realize one source-faithful all-place IUT tensor square and its order
   corrections; and
7. continue looking for a noncircular global Szpiro/Vojta or effective
   integral-point inequality, while testing every proposed shortcut against
   the recorded counterfamilies.

Positive proof construction and counterexample search proceed in parallel.
Prime-by-prime searches are subordinate to uniform lemmas and never serve as
standalone evidence for either global conclusion.

## Repository layout

```text
.
|-- Lean/                  Lean 4.32 package, audits, status ledgers, and checkpoints
|-- paper/                 Current and route-specific LaTeX manuscripts
|-- research/              Ordinary proofs, route reports, and bottleneck ledger
|   |-- computation/       Reproducible finite searches and certificates
|   |-- sources/           Source audits and cached bibliographic evidence
|   `-- verification/      Research-side replay packages where applicable
|-- output/                Built PDFs, logs, contact sheets, and QA artifacts
`-- README.md              This project overview
```

Historical checkpoints from August 30 through September 3, 2026 remain in
[`Lean/RESEARCH_STATUS.md`](Lean/RESEARCH_STATUS.md) and their dated
verification directories. They preserve theorem inventories, axiom audits,
computation manifests, build counts, PDF hashes, and the precise boundary
between proved statements and open gates.

## Build

The Lean package uses Lean `v4.32.0` and pinned revisions of the public `iut`,
`genl`, and `heights` dependencies.

From the `Lean/` directory:

```bash
lake update
lake exe cache get
lake build IUTThreeClosures
```

A successful build shows that the encoded declarations elaborate. It does not
by itself establish the missing source interfaces or the standard abc
conjecture. Checkpoint scripts additionally compile their new principal
modules with warnings treated as errors. Before describing a checkpoint as
fully sealed, also run the checkpoint-specific replay and manifest verification
documented in its own verification directory.

## Contribution and merge policy

A result is merged into the verified line only when its scope and dependencies
are explicit. It may be Lean-kernel closed or may use a precisely named,
generally accepted external theorem or certified computation under
[`Lean/ACCEPTED_THEOREM_DEPENDENCY_POLICY.md`](Lean/ACCEPTED_THEOREM_DEPENDENCY_POLICY.md).
Open, disputed, heuristic, or target-equivalent inputs remain labelled as
such. Counterexamples must satisfy every displayed premise before they retire
a claim.

This repository is a research program and audit trail, not an announcement
that the abc conjecture has been solved. Internal formal, computational, and
PDF checks are not a substitute for external human peer review, and the
manuscript is not presented here as a journal acceptance or submission.
