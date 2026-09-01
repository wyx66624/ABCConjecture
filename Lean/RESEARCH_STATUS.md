# Research status

## Trust and dependency policy

Kernel dependency reports are used for transparency, not as an aesthetic
admission test.  Finite certified evaluation (`native_decide`), classical
choice, and precisely cited theorems already accepted in the mathematical
literature may be used.  They must be identified at the point of use.  What
remains forbidden is circularly assuming abc, Szpiro, or an equivalent target;
using an open conjecture as if it were a theorem; or hiding an unsourced
critical input behind a definition or opaque interface.

## September 1, 2026 determinant, totient-concentration, and refined-factor checkpoint

The standard unconditional `ABCConjecture` remains unproved and
undisproved.  The three continuations below sharpen positive proof targets
while retaining counterexample searches.  A difficult or presently
unformalized estimate leaves its route active; only the precise strengthened
claims met by the recorded full-premise counterexamples are retired.

- **Mersenne totient-divisor route.**  The probability
  `mu_m(d)=phi(d)/m` on divisors turns the exact endpoint into a bounded-
  convergence statement.  For every nonnegative mass bounded by
  `C*phi(d)`, its divisor sum is `o(m)` exactly when every fixed normalized-
  excess set has totient weight `o(m)`.  The logarithmic divisor deficit has
  exact expectation
  `sum_(p^a || m) (1-p^(-a))/(p-1)*log p`, which is
  `O(log log(3m))`; Lean's finite Markov theorem therefore discards all
  `d <= m*exp(-(log log(3m))^2)`.  The actual Mersenne target is reduced to
  exceptional totient mass on the remaining `m^(1-o(1))` near-diagonal
  divisors.  The exact-order cyclotomic seam is also closed in Lean:
  `E_d | Phi_d(2) <= 3^phi(d)`, so the required actual-block cap is
  unconditional.  Primorials give a full counterexample only to replacing the
  moving deficit by one fixed multiple of `log log m` for arbitrary bounded
  masses.  They do not model the Mersenne blocks.  The existing `3511` and
  `1093` witnesses retire only universal finite linear-cap shortcuts.
- **Affine determinant-layer route.**  The product of the three pairwise
  coprime affine moduli divides every determinant of two fixed-template
  difference vectors.  At the canonical parameters it exceeds twice the
  square of the box side, forcing each template into one line.  Separation
  at scales `floor(c^4/12)` and `floor(s*c^4/22)`, `s^3 <= R`, gives
  capacities below `31*c^2/(10*R)` and `57*c^2/(10*R*s)`.  Partitioning by
  the unique minimal repeated kernel forces, for `kappa,eta>0`, more than
  `(5*kappa/57)*R^(2/3)*c^(2+eta)` realized exact-lossless triples under the
  matching lower bound.  One exact point refutes an area-only estimate and
  two adjacent points refute automatic separation of an unrestricted
  point-adaptive union; the empty packet at `kappa=0` refutes only the
  positivity-omitted strict entropy statement.  None refutes the corrected
  positive-density canonical correlated-kernel route.
- **IUT refined-factor route.**  In the generic fixed-stage finite-etale
  interface, once its finite/etale instances are supplied, a place tuple is
  refined by every primitive field factor of its tensor algebra, and zero
  is retained by an explicit tag.  On each factor, an exponent together with
  the complete complementary field element reconstructs the original
  element; dependent products and the existing semisimple equivalence give
  a faithful all-tuple signature.  Componentwise covariance is proved under
  explicit field-equivalence, scale, and exponent-covariance hypotheses.
  Source volume compatibility, a raw label permutation, or a bare Ind3
  inclusion does not imply those hypotheses; exact algebraic examples mark
  each boundary without refuting IUT.  The module does not construct an
  instance for the complete actual IUT packet.  The active gate is still a
  source-level refined multiplicative/valuation transport or signature-image
  containment through the horizontal link and all required indeterminacies.

The mathematical proofs are in
`../research/ABC_MERSENNE_TOTIENT_DIVISOR_CONCENTRATION_2026_09_01.md`,
`../research/ABC_AFFINE_DETERMINANT_LAYER_ENTROPY_2026_09_01.md`, and
`../research/IUT_REFINED_FACTOR_ZERO_AWARE_SIGNATURE_2026_09_01.md`.
Their companion modules are
`IUTThreeClosures/MersenneTotientDivisorConcentration20260901.lean`,
`IUTThreeClosures/AffineDeterminantLayerEntropy20260901.lean`, and
`IUTThreeClosures/IUTRefinedFactorZeroAwareSignature20260901.lean`.
They contain no unconditional terminal term of `ABCConjecture` or its
negation and do not hide any remaining arithmetic or IUT bridge as an axiom.

The permanent replay package is
`verification/2026_09_01_determinant_totient_refined_signature/`.  It freezes
469 local Lean and Lake inputs and records 105 theorems, 20 lemmas, and 26
definitions, for 151 counted declarations.  Its generated same-scope audit
covers all 125 proofs one for one, including 13 private proofs; the axiom union
is exactly `Classical.choice`, `Quot.sound`, and `propext`.  The three direct
compilations and generated audit are warning-free, the aggregate build passes
with exactly 9212 jobs, and the 20-file package and its post-seal replay both
verify.  This certifies the stated formal reductions, not `ABCConjecture` or
its negation.

The integrated English manuscript by ChatGPT is the 152-page A4 artifact
`../output/pdf/ChatGPT_ABC_Determinant_Totient_Refined_Factor_2026_09_01.pdf`
with SHA-256
`8a793426c185bc343bb6b5204297ad66a45cb7b0fcfb197479db5321554dedf2`.
All-page contact sheets, 36 retained high-resolution renders, compilation
logs, PDF checks, and recursive TeX audits are in the adjacent `_QA`
directory.

## September 1, 2026 affine entropy and Mersenne divisor-average depth

The standard unconditional `ABCConjecture` remains unproved and
undisproved.  Proof and counterexample searches continue in parallel.  Only a
counterexample satisfying every hypothesis closes the exact statement it
contradicts; difficulty, an unavailable estimate, and a finite no-hit do not
retire a route.  The combined proof ledger is
`../research/ABC_AFFINE_ENTROPY_MERSENNE_DEPTH_AVERAGE_2026_09_01.md`.

- **Affine certificate route.**  A complete cubic-product separation argument
  now includes all three zero-factor branches and their necessary individual
  modulus caps.  With `M=floor(c^6/(4R))` and
  `L=floor(c^4/13)`, the exact constant calculation gives fewer than
  `12*c^4/R^2` parameters in one full-strength template.  Therefore an
  exceptional family of size at least `kappa*R^(-2/3)*c^(4+eta)` requires
  more than `(kappa/12)*R^(4/3)*c^eta` templates.  The `d_U=31` two-point
  example refutes only the cap-omitted strengthening.  Adaptive and
  correlated templates, large unions, algebraic parametrizations, and
  accidental residual excess remain active.
- **Mersenne order/depth route.**  The exact power-loss endpoint is equivalent
  to the divisor average `sum_(d|m) log E_d=o(m)`, a strictly weaker target
  than the earlier pointwise `log E_d=o(phi(d))`.  The super-Wieferich factor
  has an exact finite layer-cake expansion.  A moving threshold splits it
  into one-copy support and high-depth tail, producing pointwise and still
  weaker divisor-average sufficient gates.  No cited fixed-base theorem
  supplies the open weighted gate.  The full certificate
  `ord_3511(2)=1755`, `v_3511(2^1755-1)=2` refutes only the assertion that
  every base-two Wieferich exact order is even.  Its depth is two, so it does
  not refute the super-Wieferich route.  The complete prime scan through
  `10^7` is finite evidence and closes no eventual assertion.

The mathematical proofs precede
`IUTThreeClosures/AffineTemplateEntropy20260901.lean`,
`IUTThreeClosures/MersenneWeightedOrderTail20260901.lean`, and
`IUTThreeClosures/MersenneSuperWieferichDepth20260901.lean`.  These modules
check the finite separation and packing algebra, divisor-average endpoint,
depth layer cake, moving-threshold implications, and exact narrow
counterexamples.  They do not install the open analytic gates as axioms, and
there is no terminal Lean term of `ABCConjecture` or its negation.

The permanent validation package is
`verification/2026_09_01_affine_entropy_mersenne_depth_average/`.  Its three
direct module compilations are warning-free; all 74 theorem declarations have
exact compiler dependency reports, and the 21 definitions bring the counted
total to 95 declarations.  The allowed dependency union is exactly
`Classical.choice`, `propext`, and `Quot.sound`.  The two deterministic
computation replays and the 9209-job aggregate build pass.
The integrated English journal manuscript by ChatGPT is retained as the
145-page A4 artifact
`../output/pdf/ChatGPT_ABC_Affine_Entropy_Mersenne_Depth_Average_2026_09_01.pdf`,
with page renders and structural checks in the adjacent `_QA` directory.

## September 1, 2026 four-route checkpoint: global omega, prime/unit/label, two-arm CRT, and Mersenne order blocks

The standard unconditional `ABCConjecture` remains unproved and
undisproved.  Positive deductions and counterexample searches continue in
parallel.  Only a counterexample meeting every hypothesis closes the exact
statement it contradicts; difficulty and a bounded no-hit do not retire a
route.  All four broad routes below remain active.  Their common ledger is
`../research/ABC_MULTI_ROUTE_PRIME_UNIT_TWO_ARM_LAYER_2026_09_01.md`.

- **Carella global-omega / prime-power-neighbour route.**  Primorial
  multiples prove that whenever `w(x) <= 2 log log x`, the printed global set
  `{n <= x : omega(n) > w(x)}` has cardinality `x^(1-o(1))`, rather than
  `o(x^(3/5))`.  This is a full asymptotic counterfamily to Carella v2's
  displayed global hypothesis and its claimed unconditional invocation.  It
  does not refute an unbounded sparse subsequence of low-radical neighbours.
  The minimal positive gate is to produce, for some fixed `k`, infinitely many
  unbounded `p^k < c <= p^k + (p^k)^(3/5)` with `p` not dividing `c` and
  `rad(c) <= (p^k)^(sigma+o(1))`, where `sigma < 2/5 - 1/k`.  See
  `../research/ABC_CARELLA_GLOBAL_OMEGA_HYPOTHESIS_2026_09_01.md` and
  `IUTThreeClosures/CarellaGlobalOmegaHypothesis20260901.lean`.
- **IUT prime/unit/label route.**  Complete prime exponent and unit
  coordinates reconstruct rational and actual `Q_p` points; preserving them
  at fixed labels reconstructs packets and turns signature-image containment
  into region containment.  Exact examples at `p=5` close only exponent-only
  reconstruction, exponent plus one residue reconstruction, and unordered
  aggregate-holonomy reconstruction.  They do not refute the actual IUT
  construction or an interface that returns an explicit label permutation.
  The live gate is source-level all-place/all-label preservation or image
  containment through the actual theta link, log-Kummer correction,
  determinant normalization, and required Ind1--Ind3 branches.  See
  `../research/ABC_IUT_PRIME_UNIT_LABEL_VECTOR_BRIDGE_2026_09_01.md` and
  `IUTThreeClosures/IUTPrimeUnitLabelVectorBridge20260901.lean`.
- **Minimal affine two-arm CRT route.**  For seed `(1,242,243)`, an exact CRT
  class supplies `318322715` canonical parameters satisfying both necessary
  long-arm excess gates.  Its first point meets every seed, box,
  admissibility, cap, primitive-output, and marginal-gate hypothesis, but has
  `rad(ABC)^4 > C^3`.  This full-premise example closes only the assertion
  that the two marginal gates suffice for a three-quarter exception.  The
  affine route remains open at the full three-arm excess inequality and a
  lower bound of at least `kappa R^(-2/3)c^(4+eta)` canonical parameters on
  each fixed subcritical seed range.  See
  `../research/ABC_AFFINE_TWO_ARM_CRT_PACKET_2026_09_01.md` and
  `IUTThreeClosures/AffineTwoArmCRTPacket20260901.lean`.
- **Mersenne prime-layer / order-block route.**  Composite odd-prime layers
  have the proved quadratic radical carrier, and the largest-prime-factor
  input asymptotically yields `E_ell/Phi_ell(2) << 1/(ell^2 log ell)`.  This polynomial
  estimate does not imply the required `log E_d = o(phi(d))`.  The corrected
  paper ledger is `W_m = L_m * prod_(d|m) E_d`, with `L_m | m`.  The complete
  example `m=6` closes only the identity that omits `L_m`; the exact layers
  `ell=37` and `ell=11` close only the universal three-support and cubic
  radical strengthenings, respectively.  The no-repeated-factor scan through
  prime index `61` is finite and closes no eventual claim.  The completed
  `IUTThreeClosures/MersennePrimeLayerRadical20260901.lean` checks the
  prime-layer arithmetic, finite base-mass estimate, and an abstract bridge
  under explicit hypotheses.  The directly compiling
  `IUTThreeClosures/MersenneOrderBlockDecomposition20260901.lean` additionally
  checks exact-order local LTE, `L_m | m`, the supported-prime exponents of
  `B_m`, and the exact finite product `W_m = L_m * prod_(d|m) E_d`.  The
  companion `IUTThreeClosures/MersenneOrderBlockAsymptotic20260901.lean`
  identifies relative blocks with canonical, index-independent `E_d`, proves
  the logarithmic divisor-sum identity, and kernel-checks the conditional
  passage `log E_d = o(phi(d)) -> log W_m = o(m)`.  The antecedent is still
  open and appears as an explicit theorem premise.  Finally,
  `IUTThreeClosures/MersenneCanonicalBlockWitness20260901.lean` checks
  `ord_1093(2)=364`, exact valuation two, and `1093 | E_364`; this closes only
  the strengthening that every canonical block is one.  The original-source
  audit now identifies `E_d=Phi_d(2)/rad(Phi_d(2))` and proves that repeated
  exact-order support below `phi(d)^2/log log(3d)` has logarithmic mass
  `o(phi(d))`.  Any failure must persist through deep super-Wieferich lifts,
  an `Omega(phi(d)/log d)` same-order transition cluster, or a weighted tail
  of exceptional small-order primes.  The finite powerful-part comparison,
  mass trichotomy, transition-cardinality core, and the exact ambient
  square-budget ratio from (6.15) compile in
  `IUTThreeClosures/MersenneWieferichTailReduction20260901.lean`; the cited
  cyclotomic, Brun--Titchmarsh, totient, and order-distribution inputs remain
  outside Lean.  See
  `../research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`.

The paper arguments precede their corresponding Lean cores.  No missing
infinite family, actual IUT multiradial transport, literature asymptotic, or
abc statement is introduced as an axiom.  There is no terminal Lean term of
unconditional `ABCConjecture` or of its rigorous negation.

The sealed validation bundle is
`verification/2026_09_01_prime_unit_two_arm_layer/`.  It records 176 theorem
declarations, 37 definitions, three abbreviations, and four structures, for
220 counted top-level declarations, with 177 complete `#print axioms` reports.
The dependency union is exactly `Classical.choice`, `propext`, and
`Quot.sound`; all eight direct compilations, four deterministic replays, and
the 9206-job aggregate target pass.  The 482-entry Git-index frozen-input
manifest has SHA-256
`e4c91809276e2890008e5ca1689a59d85e938620938ab87fedcc8756a8b31462`,
and the sealed package ledger has SHA-256
`36cb329de8038b6bbb96a4a14760d4bb8211b00a34581a99769c28faa8e80bff`.
The 134-page, ChatGPT-authored journal manuscript is
`../output/pdf/ChatGPT_ABC_Prime_Unit_Two_Arm_Layer_Continuation_2026_09_01.pdf`,
SHA-256 `594ef475fd66d43f4e2fc8bae355bde9af1fde21f66a64a3e67e8a370846ddad`;
its complete render and metadata audit is in the adjacent `_QA` directory.

## September 1, 2026 holonomy, density, and deep-prime continuation

The standard unconditional `ABCConjecture` remains unproved and
undisproved.  This checkpoint continues positive deductions and
counterexample searches on four independent routes.  No broad route is
retired for difficulty or for a bounded search with no hit.  A counterexample
closes only the statement whose complete hypotheses it satisfies.  The
combined mathematical ledger is
`../research/ABC_MULTI_ROUTE_HOLONOMY_DEPTH_CONTINUATION_2026_09_01.md`.

- **Corrected IUT/LANA log-volume route.**  On the inhabited domain of
  p-adic valuation balls of finite positive Haar measure, prime preimage
  shifts log volume by exactly `log p`; normalized finite packets and
  processions retain that shift.  Logarithmic transports compose additively,
  and an object-level closed transport has zero holonomy.  Hence an
  uncorrected loop with a positive accumulated scale shift is impossible and
  any genuine correction must contribute the negative shift.  Distinct
  rational-prime logarithms are independent over the rationals, so rational
  place coefficients cancel prime by prime.  They are not independent over
  the reals.  More sharply, the report constructs two distinct strictly
  positive normalized weight triples on `log 2, log 3, log 5` having the same
  weighted scalar.  This full counterexample closes scalar reconstruction
  from one normalized real volume, but it does not address an object-level
  same-pilot theorem retaining labelled local data.  The corrected object
  construction, all genuine IUT links and corrections, and the final output
  estimate remain active.  See
  `../research/ABC_IUT_CORRECTED_VOLUME_HOLONOMY_2026_09_01.md` and
  `IUTThreeClosures/IUTCorrectedVolumeHolonomy20260901.lean`.
- **Minimal affine-shear route.**  The cofactor gaps recover the seed
  exactly.  The reverse characterization of a positive-parameter shear
  requires `1<U<W<V`.  The row `(U,W,V)=(1,3,5)` satisfies every divisibility
  and coprimality hypothesis of the weaker `1<=U` statement but reconstructs
  `h=0`; it is therefore a full counterexample to that boundary relaxation.
  For the corrected positive statement, every target three-quarter exception
  satisfies both `8192*E(V)>R*c` and `8192*E(W)>R*c`.  In the other direction,
  for each fixed `theta<5/2` and all sufficiently large seeds with
  `R<c^theta`, a positive proportion
  `(1/2)*(5-pi^2/2)*N^2` of the canonical box is admissible with `U,V,W` all
  squarefree.  This generic nonexceptional bulk can coexist with the thinner
  exceptional lower target and does not refute it.  The support-closed
  simultaneous two-arm high-excess construction remains active.  See
  `../research/ABC_AFFINE_DENSITY_ATTACK_2026_09_01.md` and
  `IUTThreeClosures/AffineDensityAttack20260901.lean`.
- **Balancing-Pell four-prime route.**  Each channel now has a pointwise
  simple-or-odd-depth-three alternative.  If the global depth-three set is
  finite, both channels have simple divisors at the same prime index for all
  but finitely many indices.  The signed Fellini--Murty argument gives a
  separate infinite simple-index set in each channel; infinitude alone gives
  no intersection theorem.  The second-order quotient ledger modulo
  `4*ell^2` and the all-pairs quadratic-character ledger give necessary
  packet constraints, but no contradiction.  Two independent exhaustive
  implementations scan all 50,847,533 odd primes through `10^9`; both find
  exactly `13,31,1546463`, all at exact depth two, and no depth-three prime.
  Thus every rational balancing depth-three prime, including the two required
  by a full opposite-channel packet, is greater than `10^9`.  This is a
  certified finite lower bound and does not exclude the packet.  See
  `../research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md`,
  `../research/computation/2026_09_01_pell_four_prime_coupling/`, and
  `IUTThreeClosures/PellFourPrimeCoupling20260901.lean`.
- **Danilov/Fibonacci deep-prime route.**  Let `Q_*` be the verified
  4,398-digit squarefree modulus with 638 distinct prime factors.  If a member
  of the final progression is a squarefull Danilov survivor, the factor-bound
  amplification theorem forces at least `2^638-622` distinct
  Wall--Sun--Sun primes.  A distinguished `2^637`-prime subfamily lies
  entirely above `10^2199`, and Hong's large primitive-divisor theorem gives
  one forced prime above `10^4399`.  These are unconditional implications
  from the survivor hypothesis, not contradictions: no available theorem
  bounds the total Wall--Sun--Sun population.  The exact identity
  `Phi_10(-3)=11^2`, with derivative and discriminant nonzero modulo 11,
  refutes the generic shortcut from a simple modular root or nonzero
  discriminant to valuation one.  It does not refute the Fibonacci survivor
  implication.  The saved seven-prime local classes do not cover the final
  progression, so the Danilov route remains active.  See
  `../research/ABC_DANILOV_WSS_ESCAPE_2026_09_01.md`,
  `../research/computation/2026_09_01_danilov_wss_escape/`, and
  `IUTThreeClosures/DanilovWSSEscape20260901.lean`.

The mathematical proofs precede the four Lean modules.  The modules check
the elementary valuation-ball, holonomy, affine, Pell, and abstract Danilov
counting kernels; they do not turn the cited perfect-power,
primitive-divisor, valuation, or large-prime results into new axioms.  There
is still no terminal Lean term of `ABCConjecture` or its negation, and all
four broad routes remain active at the gates stated above.

The permanent validation package is
`verification/2026_09_01_holonomy_depth_continuation/`.  All four direct
module compilations are warning-free; the aggregate target completes 9,198
jobs.  The comment-stripped inventory is 65 theorems, 18 definitions, four
abbreviations, and five structures, hence 92 declarations, with 58
`#print axioms` reports.  Their dependency union is exactly
`Classical.choice`, `propext`, and `Quot.sound`.  Three computation bundles
and three source ledgers pass their strict manifests and lightweight replays;
the frozen Pell `q<=10^9` C++ scans are verified but not rerun.  The final
124-page ChatGPT-authored paper is
`../output/pdf/ChatGPT_ABC_Holonomy_Depth_Continuation_2026_09_01.pdf`,
SHA-256
`02c415a2f49575117dc5ae86f43c810a63c3cc6e201b1e82def151d93d934df9`;
its complete rendered-page audit is in the adjacent `_QA` directory.

## September 1, 2026 five-route continuation: packet attacks, recursive lifts, and the pinned LANA audit

The standard unconditional `ABCConjecture` remains unproved and undisproved.
The work below advances positive deductions and counterexample searches in
parallel.  A bounded search with no hit is never promoted to an infinite
theorem, and a counterexample closes only the exact statement whose complete
hypotheses it satisfies.  The unified mathematical ledger is
`../research/ABC_MULTI_ROUTE_GLOBAL_PACKET_CONTINUATION_2026_09_01.md`.

- **Affine radical-step route.**  The generalized shear works for every
  `Q` containing the prime support of the seed, in particular for the minimal
  step `Q=rad(abc)`.  It preserves primitivity and all three pair-projection
  injections while improving the raw supply from the `abc`-step exponent to
  the radical-step exponent.  Multiples of the minimal step give nested
  subfamilies rather than independent amplification.  Given the established
  exceptional upper bound, the eventual matching lower bound is logically
  equivalent to boundedness of the subcritical seed locus; its reverse
  implication is vacuous above a height threshold.  The fixed-CRT-template
  main term is too small, but large-period boundary terms, unions of templates,
  and accidental solutions remain open.  The exact `(1,8,9)` search over
  447,120,793 admissible points has no exception, and the certified all-square
  rows are nonexceptional.  These are finite no-go results, not a refutation of
  the eventual lower gate.  See
  `../research/ABC_AFFINE_MATCHING_LOWER_GATE_2026_09_01.md` and
  `IUTThreeClosures/AffineRadicalStep20260901.lean`.
- **Balancing-Pell global packet route.**  The exact prime-power rank formula
  and two-channel quotient coupling are now proved.  The global alternative
  extracted from Fellini--Murty Section 8 was obtained only after auditing and
  repairing the printed proof architecture; it is not an unchanged invocation
  of the published argument or the literal wording of its Theorem 2.3.  The
  exhaustive scan of all 5,761,454 odd primes through `10^8` finds exactly
  `13,31,1546463`, all at depth two, and no depth-three prime.  Exact examples
  at `13` and `1546463` refute the proposed channel, prime-rank, and boundary-
  equality shortcuts to valuation one.  They do not refute the required
  four-prime, two-depth-three packet exclusion, which remains active.  See
  `../research/ABC_PELL_GLOBAL_PACKET_ATTACK_2026_09_01.md` and
  `IUTThreeClosures/PellPrimeRankCounterexamples20260901.lean`.
- **Danilov recursive-lift route.**  The orbit has an exact Fibonacci-index
  identity.  A simple primitive divisor at every adaptive index supplies a
  fresh nondegenerate prime-square lift; iteration would then contradict the
  finite prime support of one fixed nonzero integer.  The exact computation
  constructs 626 packets and a 4,398-digit modulus with exactly 638 prime
  factors.  Failure to find a next packet with `p<=10^8` is only a finite
  endpoint.  The explicit mod-49 countermodel refutes automatic infinite
  continuation from a one-step abstract slope, while leaving the actual
  Fibonacci/Danilov route open.  See
  `../research/ABC_DANILOV_RECURSIVE_LIFT_2026_09_01.md` and
  `IUTThreeClosures/DanilovRecursiveLift20260901.lean`.
- **Fibonacci simple-primitive-divisor route.**  The mathematical audit shows
  that a primitive divisor at an index `n>5`, `5|n`, is split and satisfies
  `p ≡ 1 (mod n)`; repeatedness is exactly the relevant Fibonacci-Wieferich
  condition.  At the current Danilov endpoint, failure of simplicity would
  force a powerful primitive cyclotomic factor supported on Wall--Sun--Sun
  primes, including one at least `41*n+1`.  This is a necessary condition,
  not a contradiction.  The real nondegenerate coprime-parameter Lucas
  sequence `P=2,Q=-3` has unique primitive prime `11` at index ten with
  `11^2 || U_10`.  Lean therefore closes the exact sequence-uniform claim
  that standard real Lucas hypotheses force a simple primitive divisor at
  every `10*q`.  The example is not Fibonacci and does not close the Danilov
  SPD route.  The further exact example `n=15,p=61` closes the parity-free
  half-Lucas sign lemma omitted from an earlier draft; all actual indices
  `10Q` are even, so the corrected auxiliary statement remains applicable.
  A bounded search certifies 207 of 252 eligible `Q<=1000`; the
  remaining 45 are unresolved, and the absence of a found counterexample is
  not a proof.  See
  `../research/ABC_DANILOV_SIMPLE_PRIMITIVE_DIVISOR_2026_09_01.md` and
  `IUTThreeClosures/DanilovSimplePrimitiveNoGo20260901.lean`.
- **Pinned LANA and same-pilot route.**  At Project LANA commit `ddaddc2`,
  the actual `RHSData D` signature is uninhabited: weight normalization gives
  a component, while the real-valued prime-preimage shift asserted for every
  set gives `log 2=0` when applied to the empty set.  Thus the assembled
  variant-data type is empty and its universal target is vacuous.  This rules
  out only that pinned low-resolution signature as a satisfiable specification;
  it proves neither the intended Corollary 3.12 nor a failure of IUT or abc.
  A corrected nonempty/finite-volume interface and the object-level pointed
  same-pilot certificate remain positive open routes.  See
  `../research/ABC_IUT_LANA_SAME_PILOT_AUDIT_2026_09_01.md` and
  `IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean`.

The five new Lean modules formalize only their proved elementary and exact
counterexample cores.  In particular, no unformalized Fibonacci valuation,
primitive-divisor, or large-prime literature theorem is inserted as a Lean
axiom.  There is still no terminal Lean term of `ABCConjecture` or its
negation.

The frozen global replay package is
`verification/2026_09_01_global_packet_continuation/README.md`.  It counts
122 theorem/lemma declarations, 37 definitions or abbreviations, and five
structures/classes/inductives, for 164 top-level declarations.  All 83
declaration-level `#print axioms` commands report only `Classical.choice`,
`propext`, and `Quot.sound` in union.  The five direct compilations have zero
warnings; `lake build IUTThreeClosures` completes 9194 jobs, and all four
computation manifests plus the pinned IUT snapshot and its dedicated replay
pass.  The package `SHA256SUMS` hash is
`da4e28c8e80c0439bb8a9954bbe76cbc853bbeda1a04c735721890b766f17e8f`.
The corresponding ChatGPT-authored 119-page paper is
`../output/pdf/ChatGPT_ABC_Global_Packet_Continuation_2026_09_01.pdf`; its
SHA256 is
`6d3e1faed22053e973f8d87fd669423d7c02a8bed6cc557435a9458b3d8b237e`,
with QA at
`../output/pdf/ChatGPT_ABC_Global_Packet_Continuation_2026_09_01_QA/QA.md`.

## September 1, 2026 earlier balanced-persistence checkpoint: global arithmetic filters

The standard unconditional `ABCConjecture` remains unproved and
undisproved.  This checkpoint's synthesis is
`../research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_09_01.md`.

- **Affine shear.**  For inherited seed radical `R`, target cap `X`, and
  `0<mu<1`, the actual exceptional set satisfies
  `#E(X) << R^(-2/3) X^(2mu/3+epsilon)`, uniformly in the seed.  At
  `X=c^8, mu=3/4` the exact comparison is
  `R^(-2/3)c^(4+epsilon)`.  The matching positive lower gate is open.
  Same-prime independence is refuted by pairwise-disjoint local events; that
  counterexample closes only the heuristic, not the affine route.
- **Balancing Pell orbit.**  Every hypothetical nonunit squarefull term
  descends to a squarefull odd-prime index.  There it forces four distinct
  same-rank balancing-Wieferich primes, with one first-occurrence valuation at
  least three in each of the two coprime Pell channels.  The exhaustive scan of
  183,071 odd primes through 2,500,000 finds only `13,31,1546463`, all at
  depth exactly two.  Through index 2000, exactly `1873,1951` remain
  unresolved; they are not squarefull hits.
- **Danilov--Hall orbit.**  Squarefullness of the normalized remainder forces
  the nonnegative index into
  `t = 122136955032565025967809449110840347537827`
  modulo `183205432548847538951714173666260521306741`.  The indices below the
  displayed representative are excluded, while the surviving progression is
  undecided and active.
- **Other routes.**  Mordell EDS, Cohn--Nitaj, Frey, geometry, and IUT routes
  remain active at their stated global gates.  Walsh's family is infinite only
  under its explicit positive-rank hypothesis for
  `Y^2=X^3-432p^2`; the repository does not erase that premise.

The three result modules contain 57 theorems and 30 definitions or structures,
87 counted declarations.  Four direct Lean elaborations and the aggregate
9,151-job build pass.  The source scan finds no `sorry`, `admit`,
`native_decide`, declared axiom, `opaque`, or `unsafe`; declaration-level
dependency output is contained in `propext`, `Classical.choice`, and
`Quot.sound`.  Reproduction and hashes are in
`verification/2026_09_01_balanced_persistence_continuation/VALIDATION.md`.

That checkpoint's ChatGPT paper is
`../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_09_01.pdf`: 111 A4 pages,
844,056 bytes, SHA256
`609962b0bf64daf51e5822410c1dbcdff4f55ae452c70d2da6db9fc3e9f87bbc`.
Its claim audit, text checks, and rendered-page inspection pass.  No terminal
Lean term of `ABCConjecture` or its negation is claimed.

## August 31, 2026 balanced-persistence continuation: affine amplification and arithmetic upgrade gates

The standard unconditional `ABCConjecture` remains unproved and
undisproved.  The latest mathematical synthesis is
`../research/ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_08_31.md`.
It combines the final affine-amplification audit with the Pell/Lucas, Hall,
Mordell EDS, Danilov, Cohn--Nitaj, and Walsh source reviews.  It is a
partial-results and route-status report, not a proof or disproof of abc.

- **Positive affine route:** the two-parameter shear gives a primitive,
  injective fibre and at least `c^6/32` raw outputs below height `c^8`.
  The exact low-radical criterion requires large repeated-prime excess in
  the three new affine factors.  The unconditional upper ledger leaves the
  worst-shape target window above the BBLT threshold open; in particular,
  the seed-uniform lower bound `|E_c| >= c^(17/4)` on every fixed
  subcritical locus is not contradicted and remains unproved.  The value
  `14/3` is a lower envelope of available budget exponents on the relaxed
  region `rho<3, sigma<1`, not a per-seed upper bound.
- **Pell/Lucas route:** the balancing term factors exactly as
  `u_n=A_n B_n` with coprime Pell coordinates, and it is squarefull
  exactly when both coordinates are squarefull.  The adjacent primitive
  points then have radical slope `1/2`; even indices have strict signature
  `(3,4,4)`.  Index saturation, largest-prime descent, and the
  double-Wieferich condition are necessary conditions only.  Carmichael and
  Bilu--Hanrot--Voutier do not force valuation one.  The audited literature
  supplies neither an unbounded squarefull subsequence nor an eventual
  valuation-one theorem.
- **Hall, Danilov, and Mordell EDS:** primitive Hall data with squarefull
  `K` and `K^2<=X` have radical slope below `11/12`.  Danilov gives an
  unbounded primitive critical-scale family, but squarefullness of its
  moving remainder is open.  The Mordell EDS family
  `C_n^2+2B_n^6=A_n^3` is unbounded and primitive on the critical
  `(2,6,3)` line; its three powerful-coordinate upgrades remain open.
- **Cohn--Nitaj and Walsh:** Cohn--Nitaj give genuine infinite 3-full
  families with base signature `(3,3,3)`.  Walsh gives the corresponding
  family under the stated positive-rank hypothesis.  The displayed fullness
  certificates are critical rather than counterexamples, and no cited theorem
  produces the required strict powerful-coordinate subsequence.
- **Exact local closures:** Darmon--Granville closes only a fixed strict
  generalized-Fermat equation or a finite residual-kernel packet.
  Mason--Stothers closes only a polynomial-full tripod.  Siegel closes each
  fixed-exponent perfect-power specialization of the Danilov remainder.
  These theorems do not cover moving kernels, sparse powerful values, or the
  active Pell and elliptic upgrade gates.

The permanent
[`targeted counterexample-search bundle`](../research/computation/2026_08_31_targeted_counterexample_search/REPORT.md)
records exact finite computation only, with
[`REPRODUCE.md`](../research/computation/2026_08_31_targeted_counterexample_search/REPRODUCE.md)
and [`manifest.json`](../research/computation/2026_08_31_targeted_counterexample_search/manifest.json).
For the balancing recurrence, all 999 terms with `2<=n<=1000` have an
explicit exponent-one prime certificate, including all 168 prime indices.
The extension through `n=2000` certifies 1,990 of 1,999 nonunit terms; the
nine indices
`[1009,1181,1667,1699,1723,1847,1873,1901,1951]` are unresolved and are
neither hits nor certified non-hits.  The composite index `1711=29*59` is
certified by `p=44560482149` modulo `p^2`.  All 81 Danilov points with
`0<=t<=80` have `v_p(K_t)=1` certificates.  The five-small-prime sieve first
leaves `t=326` uncovered; this is not a squarefull hit.  Rerunning
`exact_audit.py` in the permanent directory leaves all 85 manifest entries
valid.  The manifest SHA256 is
`62abe5c80716d9e4d5697df95e5330b9fb3d011f463d4647e72332c9288bbac3`.
These finite results close neither the Pell nor the Danilov route.

The research rule is explicit: mathematics precedes Lean; no open arithmetic
premise is introduced as an axiom.  A route is not abandoned because it is
difficult, because a finite scan is negative, or because only a necessary
condition is known.  A concrete counterexample rejects only the exact claim
it contradicts, and a no-go theorem closes only its stated mechanism.

Four new mathematical modules contain exactly **62 explicitly written
theorem declarations and 15 explicitly written definitions or structures,
for 77 top-level source declarations total**:

- `IUTThreeClosures/PellAdjacentFactorCounterexample20260831.lean`;
- `IUTThreeClosures/PellSquareRootDescent20260831.lean`;
- `IUTThreeClosures/HallSquarefullCounterexample20260831.lean`; and
- `IUTThreeClosures/AffineShearAmplification20260831.lean`.

`IUTThreeClosures/ResearchBalancedPersistence20260831Audit.lean`
enumerates the 77 declarations with matching `#check` and
`#print axioms`; it is not a fifth mathematical module.  Automatically
generated structure projections, constructors, recursors, and equation
declarations are outside this 77-item count.  The frozen evidence is in
`verification/2026_08_31_balanced_persistence/VALIDATION.md`.  Direct
compilation of the four modules and audit entry exits zero with no warnings.
The audit target passes 8,767 jobs with 19 historical dependency warnings
and zero new-module warnings; the library target and default build each pass
9,147 jobs with 265 warnings, exactly matching the dual-route baseline
warning multiset.  Source and kernel audits find no `sorry`, `admit`, axiom
declaration, `unsafe`, or `sorryAx`; the dependency union is exactly
`propext`, `Classical.choice`, and `Quot.sound`.  All 13 JSON files parse,
the 22-file manifest agrees with the files, and all 23 `SHA256SUMS` entries
verify.  The `SHA256SUMS` SHA256 is
`4e25867f5026bbd04a05240de9d6f51e06abc6518bf9819d48aaa03d1bb85916`.
The released ChatGPT paper is
`../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31.pdf`: 109 pages,
830,854 bytes, SHA256
`ccbc4d77d112aec78a869caba53104b133467f6cd4a60ee528e09437f79d2e3e`.
All 109 pages were rerendered at 110 dpi.  Only pages 102--109 changed from
the preceding fully inspected candidate, and all eight passed original-size
page inspection.  Extracted text has 340,732 characters, with at least 1,926
on every page.  All 29 fonts are embedded; the PDF has no forms or
JavaScript; and the log has only one pre-existing underfull box.  The QA
directory is
`../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31_QA`, whose
`SHA256SUMS` SHA256 is
`206f1edb9c9e190ec65c3333ddf2a3166fefe06f907e132f349725897be18e98`.

## August 31, 2026 dual-route continuation: exact positive gate and conditional Pell disproof gate

The standard unconditional `ABCConjecture` remains unproved and undisproved.
The newest completed partial-results account is
`../research/ABC_DUAL_ROUTE_CONTINUATION_2026_08_31.md`, with reproducible
evidence in `verification/2026_08_31_dual_route_continuation/VALIDATION.md`.
The original target, Lean 4.32.0 toolchain, package pins, and protected
downstream statements are unchanged.

- **Positive route, exact quantifiers:** standard logarithmic abc is proved
  equivalent to uniform height boundedness on every fixed locus
  `R(P) <= mu H(P)`, `0 <= mu < 1`. This is a theorem about the unchanged
  target, not a replacement definition. A super-sparse sequence with
  `X_(n+1)=X_n^2` proves that a positive-power count, even with square gaps,
  cannot imply this pointwise boundedness. Decaying shell counts and a
  single-source amplification with exponent `beta > kappa*theta` are proved
  sufficient upgrades; constructing either upgrade for actual abc points is
  still open.
- **Counterexample route, exact survival conditions:** canonical power-residue
  decomposition plus Darmon--Granville proves that any unbounded strict
  mixed-full family must visit infinitely many residual-kernel triples.
  Mason--Stothers rules out a pairwise-coprime polynomial-full identity in the
  strict reciprocal range. Neither result excludes sparse specializations or
  a Pell/elliptic source whose residual kernels escape.
- **Conditional Pell gate:** the positive solutions of `x^2-8y^2=1` give
  primitive triples `(1,8y^2,x^2)`. If an unbounded subsequence of the roots
  `y` is squarefull, the triples have strict signature `(7,3,2)` and radical
  slope at most `3/4` up to an additive constant, so the unchanged standard
  `ABCConjecture` is false. The squarefull-subsequence premise is open. The
  Bilu--Hanrot--Voutier primitive-divisor theorem does not assert valuation
  one and therefore does not negate that premise.
- **Complementary checks:** the mixed-full module proves the exact radical
  compression and standard-target implication; the three-prime module
  checks the relevant signatures and small-support placements; the Frey
  module proves that every leading coefficient below six fails uniformly
  across the exhibited rational isogeny class, without claiming coefficient
  six is attained as an optimal general theorem; the finite-product IUT
  module proves a selected-place product-span identity, not the missing
  globally synchronized comparison.

Six new modules contain **94 public theorems and 15 additional definitions
or structures**. The declaration audit covers all **109** items: five are
axiom-free, and every other dependency is a subset of `propext`,
`Classical.choice`, and `Quot.sound`. There is no `sorryAx`, declaration-style
mathematical axiom, or unsafe proof. Direct compilation, the audit target, and
the full **9142-job** build pass. Its **265** warning lines exactly match the
frozen baseline multiset; the new modules add zero warnings.

The English manuscript by **ChatGPT** has **102 pages**. The final TeX pass
has zero diagnostics in the audited categories, and all pages were rendered
and visually inspected. The accepted artifact is
`../output/pdf/ChatGPT_ABC_Dual_Route_2026_08_31.pdf`, SHA256
`cbbd600376a9c27754e6969612efa9ed2833060f60cb1a48d4b64ed03c25bfc4`.
This is a rigorous partial-results paper, not an unconditional abc proof or
disproof and not external peer review.

Both directions remain active. The positive route next needs an actual
source-to-target construction strong enough to force pointwise boundedness,
or another uniform estimate equivalent to the subcritical-locus statement.
The counterexample route next needs an unbounded squarefull Pell subsequence
or another primitive, fixed-slope, height-unbounded kernel-escaping family.
The IUT route still needs the complete globally synchronized family,
markings, Ind3 and cross-Frobenius comparison. No route is abandoned merely
because this remaining theorem is hard.

## August 31, 2026 uniform continuation: exact heights and canonical local membership

The standard unconditional `ABCConjecture` remains unproved and undisproved.
The latest completed partial-results account is
`../research/ABC_UNIFORM_CONTINUATION_2026_08_31.md`, with evidence in
`verification/2026_08_31_uniform_continuation/VALIDATION.md`.
The original target and downstream interface, Lean 4.32.0, all dependency
pins and the tracked dependency worktrees are unchanged.

- **Complete two-prime subclass:** every actual primitive positive triple
  with at most two distinct prime divisors satisfies `2c ≤ 3 rad(abc)`.
  Equality occurs only at `(1,8,9)` and `(8,1,9)`; all other triples in
  that subclass satisfy `c ≤ rad(abc)`. The prime-power classification
  is proved from the actual support, not assumed.
- **Actual trace and arithmetic fibres:** a nonzero scalar return under
  the stated trace covariance determines the entire scalar-line action.
  Equal dimensions and the valuation-unit condition retain their exact
  hypotheses. Labelled odd-part fibres of actual ABCPoint values have
  cardinality at most two, with a proved finite type and an attained
  two-point example. Pointwise return must not be replaced by hull membership.
- **Entire isogeny class and exact Weil height:** for `c=1792n+2`, `n≥1`,
  the rational isogeny class has four actual models. Its maximum minimal
  discriminant has order `c^5`, while the unique least absolute
  logarithmic Weil height is `3 log(c²−16c+16)=6 log c+o(1)`.
  The reduced denominator explains the difference from complex absolute
  magnitude. Classification, Frobenius and minimal-model arguments are
  paper proofs. Lean checks actual curves, rational numerators and
  denominators, actual library heights and the attained four-model minimum.
- **Canonical IUT local source:** for the standard finite theta ambiguity,
  the attained native point hull is the actual ideal `P_j`. One synchronized
  copy representative and the source's reciprocity comparison place the
  canonical `M_alpha^(-1)` orbit in a fixed same-column basic branch of
  the raw possible-image set. The preceding carrier, three cyclotomes,
  transported test vector and selected-place packet are explicit.
  General multiple-place packets only give projection membership.
  This proves a local lower inclusion, not equality with the full hull
  or the complete global comparison. This reconstruction remains outside Lean.
- **Arithmetic objects:** the specified local ideals define actual
  metrized vector bundles, and an integral weighted determinant descends
  isometrically to Q. Its precise weights and reference changes are
  computed; these objects are not identified with the entire global pilot.

Five new modules contain **97 public theorems and 9 additional
proof-bearing declarations**. The complete **106-report** audit passed:
3 declarations are axiom-free; all other dependencies are subsets of
`propext`, `Classical.choice`, `Quot.sound`. The full **9135-job** build
passed with precisely the previous multiset of **265** warnings, zero
new warnings. Older 145/89/43 audits were rerun and exactly parsed.
No new mathematical axiom, `sorryAx`, or disabled linter fills a gap.

The English manuscript by **ChatGPT** has **93 pages**, zero final TeX
warnings and an actual image review of every page. Its accepted output is
`../output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf`, SHA256
`0dfc4b7be5f7b32c65d357bf43d1e0df91a4ec8c35eb68cec7f46c56898e4e9f`.
The older same-name PDF open in WPS is left unchanged and is not the
current deliverable. The accepted 66-page predecessor is separately
preserved in this stage's previous_snapshot. The frozen 705/506/447-entry
manifests replay through 6/6/10 recorded mappings without a mismatch.
No original/user PDF, prior manifest, commit, or external submission was changed.

The analytic all-support uniformity estimate, geometry's varying-support
height/conductor estimate, and IUT's full same-family global comparison
remain active. A counterexample to a specified discriminant or height
replacement is not an ABC counterexample. No broad route is abandoned,
and internal agent review is not external human peer review.

## August 31, 2026 full Galois lifts and complete initial theta data (historical)

The following preserves the preceding 145-declaration, 66-page increment.
Its specific remaining local-source questions are superseded only to the
limited scope stated in the newer entry above; its acceptance is immutable.

The standard unconditional `ABCConjecture` remains unproved and undisproved.
The preceding completed increment is `../research/ABC_GALOIS_LIFTS_2026_08_31.md`;
its exact acceptance record is
`verification/2026_08_30_galois_lifts/VALIDATION.md`. The date in that
directory records the start of work; final proof and PDF checks occurred
on August 31. The original target, protected downstream file, toolchain,
dependency manifest and package revisions are unchanged.

- **Actual full local Galois maps:** explicit cross-handle words preserve
  the full Jannsen–Wingberg presentation. An integral basis and a common
  inertia/parabolic choice give one actual Kummer arrow for every square
  label in the specified tame family. No arbitrary GL action is assumed.
- **Exact pre-ideal hull:** with absolute algebra trace,
  `B^dual = product I subset A^dual`, and the normalized pre-ideal lies
  in that dual. Its transported B-hull is exactly the attained point
  hull `P`; the larger whole-product input gives `p^(-1)*P`. The previous
  unresolved middle-set question is thus settled for these examples.
  Every coordinate and the source must change together under conversion
  from normalized to standard logarithms; native positivity is not a
  disproof of a standard-coordinate comparison.
- **Actual arithmetic and unbounded family:** rational Frey models,
  genuine point counts and SL2 image arguments realize the local fields.
  The exact level-43 arithmetic is checked without factoring the enormous
  endpoints. A CRT/power-free count and the archived effective Linnik
  exponent 5.2 construct an unbounded balanced family with prime-to-level
  Tate orders and unbounded height in a fixed original bounding domain.
- **Full original initial theta data:** all conditions of IUT I
  Definition 3.1 hold for the level-43 example and every member of that
  family. The proof includes the core, dual-isogeny graph cover,
  distinguished cusp, separate place choices and theta/orientation
  conditions over `Q(i,D[30*ell])`. No extra torsion-field extension is
  hidden. This complete geometric construction is still a paper proof.
- **Formal scope:** seven modules contain 130 public theorems and 15
  additionally audited constructions. They prove actual free-group,
  linear/matrix, Weierstrass, finite-field, prime-exponent, real-logarithm,
  label-arithmetic and trace-dual/submodule statements. The latter uses
  actual algebra trace and the span after transport, not an assumed
  desired containment. Full profinite/LCFT/Tate reconstruction, Linnik,
  initial-data geometry and global IUT comparison remain outside Lean.

The final default build passes with **9129 jobs**, **zero new warnings**
and **265 pre-existing warning entries**. All **145** new declaration
reports pass; six are axiom-free and the rest use only `propext`,
`Classical.choice`, and `Quot.sound`. Previous 89- and 43-declaration
audits were rerun successfully. No linter was disabled or mathematical
axiom added. The English manuscript by **ChatGPT** has **66 pages**, no
final TeX warning, and a recorded image inspection of every page.
Internal independent-agent reviews are not external human peer review.

The previous 34-page artifact and five other mutable canonical files
were captured before replacement. Its unchanged **506-entry** manifest
replays with six documented mappings and zero failures. Earlier snapshots
and source PDFs are preserved. No commit, push, external submission, or
edit to an original or user PDF was made.

The next IUT gate is the complete same-family global pilot, its weights,
Ind3 and cross-Frobenius compatibility. Initial-data existence and the
local attaining maps are no longer left as that gate. Analytic radical
amplification and arithmetic-geometric all-epsilon uniform estimates
remain independent active routes. No unconditional ABC closed term or
rigorous disproof has been obtained, and no broad route is abandoned.

## August 30, 2026 uniform estimates and admissible Galois maps (historical)

The following is the preserved account of the preceding completed
increment. Its then-open full-Galois and initial-data questions are
superseded where explicitly stated in the August 31 entry above; its
89-theorem and 34-page acceptance record remains immutable.

The standard `ABCConjecture` remains unproved and undisproved. Its definition,
`ABCPoint`, radical, the protected downstream file, toolchain and dependency
pins are unchanged. The latest completed account is
`../research/ABC_UNIFORM_GATE_2026_08_30.md`; the reproducible validation record
is `verification/2026_08_30_uniform_gate/VALIDATION.md`.

- **Actual radicals:** using the original explicit S-unit bound gives a
  count with prescribed squarefree radical divisor `R`, without a height
  restriction: for `X=Y/R>=1`, at most
  `905*45^omega(R)*X*(1+log X)^44` positive primitive triples have radical
  at most `Y` and divisible by `R`. The exact new-prime/excess identity
  applies to actual integer conic lifts. Combined with the complete-fibre
  bound, it yields a necessary amplification window `K>rho+4*sigma`,
  `3*sigma/K<mu<(3/4)*(1-rho/K)`. This is an upper bound and a necessary
  window, not an amplification lower bound or abc finiteness.
- **Moving geometric family:** canonical factorization modulo three gives
  three actual integer Mordell points, their exact local prime costs, and
  three rational points on one curve `Y^2=X^3+16N^2`, related by its
  rational 3-torsion. The cubic field/index calculation retains the field
  regulator in an effective relative bound obtained from Pasten's 2026
  preprint. Siegel's original theorem proves the stated asymptotic only
  when the support `R0` is bounded. An infinite family with `R0=3` rules
  out treating bounded residual support as finiteness of abc triples.
- **Actual IUT definitions:** the all-open-subgroup condition in the
  original Ism definition, together with local class field theory, forces
  multiplication by `Z_p` units. The resulting Ind2 operation leaves
  every fixed holomorphic `B`-module hull unchanged. Mono-analytic
  processions allow local outer Galois representatives; this does not
  identify their linear image with all integral matrices. The genuine
  Kummer action preserves trace up to a scalar unit, which distinguishes
  certain affine trace depths but not their coefficient-module hulls.
- **Formal boundary:** five new modules contain 89 public theorems. They
  check actual radical and coordinate identities, algebraic geometry
  calculations, trace-obstruction implications, scalar-orbit spans,
  trace-preserving transvections, and the p-adic all-neighborhoods rigidity
  argument. They do not formalize the whole S-unit theorem, Pasten,
  Siegel, local class field theory, full Galois reconstruction, or IUT's
  global comparison. None of these inputs is hidden as a new Lean axiom.

The final default build succeeds with **9121 jobs**, zero warnings from the
five new modules or their audit, and 265 pre-existing warning entries.
All **89** new public theorem dependencies and **43** declarations from
the preceding continuation were checked: only `propext`, `Classical.choice`
and `Quot.sound` occur. No linter was disabled. The 34-page English paper
by ChatGPT compiles without final TeX warnings and has been inspected on
every page. Separate-agent mathematical and visual checks are internal
cross-review, not external peer review.

A subsequent explicit construction using the full Jannsen--Wingberg
presentation is being checked in separate minimum-layer research logs.
It is not included in the above 89-theorem or 34-page acceptance record.
The previous 22-page paper, mutable status files and aggregate imports
were preserved byte for byte; all 447 entries of the previous manifest
were successfully replayed using ten documented path remappings.
No broad research route was abandoned.

## August 30, 2026 continuation: effective finiteness of the specified Pell family

The standard `ABCConjecture` is still unproved and undisproved here. The
target definition, `ABCPoint`, radical, toolchain, and pinned dependencies
are unchanged. The consolidated account for this earlier increment is
`../research/ABC_CONTINUATION_2026_08_30.md`; its verification record is
`verification/2026_08_30_continuation/VALIDATION.md`.

- **Uniform Pell result:** for positive integers satisfying
  `b+2=3r^2`, `b+3=s^2`, `b^2+3b+1=T_p(X)`, `p>=3`, `X>1`,
  Matveev Corollary 2.3 with its normalized coefficient parameter gives
  `p<2^59`. Combining the independently checked BEG application bounds
  `b+2` by `exp(exp(4300*2^295))`. The specified moving-index packet is
  therefore effectively finite. Primality and the endpoint congruences
  are not needed. This supersedes the earlier open numerical corridor
  for that packet, but does not supply a global abc reduction.
- **Formal scope of that result:** `MatveevPellFinitePacket20260830`
  proves actual square-root and Pell-coordinate identities, strict
  approximation, normalized-coefficient algebra, and constant absorption.
  Matveev/BEG conclusions remain explicit arguments where used; their
  full theorems and the complete finiteness statement are not formalized.
- **Local Haar:** `DVRReachableHaar20260830` proves the minimum determinant
  on actual reachable columns, exact quotient size, closedness, Haar
  measure, and log-volume for the full-rank compact integral lattice.
  The ambient local-field restriction bridge and deficient-rank zero
  measure are still paper proofs. No source reachability is inferred
  from this abstract local result.
- **Amplification and geometry:** exact CRT and conic certificates now
  have quantitative output counts; the stated size-certified families
  cannot beat the compared exceptional-set exponents. Actual radical
  exceptions need not satisfy those certificates. Fixed-norm methods
  give `H^4 <= K D log(2D)^6` without needing a nontrivial Chebyshev
  decomposition, so the fundamental-unit branch remains relevant.
  The primitive Frey--Mordell point and its split cubic are checked.
- **IUT source comparison:** a marked unit point supplies a full lattice
  after the specified holomorphic hull. The rational selected-place
  set, tensor/maximal-order normalization, and fixed-source target-reset
  covariance have explicit proofs. The original upper container uses
  a squared-exponent input. The 109-adic direct-dictionary example fails
  Joshi's prime window and is not a global IUT counterexample. A further
  exact-hull/window result applies only to the explicitly maximal
  integral-linear automorphism model; it is not granted to the actual
  Galois-induced family without a reachability proof.

Six companion modules and `ResearchContinuation20260830Audit` were added
to the default development. The final default build passes with **9115
jobs**; the new audit reports **43 declarations**, all using only
`propext`, `Classical.choice`, and `Quot.sound`. New modules emit no
warnings; 265 older warning entries remain. No linter was disabled to
obtain this result. The English manuscript has been updated accordingly.

Full mathematical proofs precede the Lean implementations. The latest
exact-hull/window note is mathematical work whose complete formalization
remains pending. Internal cross-review by separate agents is not external
human peer review. No broad route is abandoned merely because an interface
remains unproved.

## August 30, 2026 first increment: historical source audit

The following records the earlier increment. Its unbounded Pell corridor
and paper-only full-rank Haar boundary are superseded by the continuation
above; the older verification record and paper snapshot are preserved.

This increment does not prove or disprove `ABCConjecture`. Mathematical
arguments were written before the corresponding Lean components were
implemented, and were cross-reviewed by independent route agents. The user requested a new
literature review, superseding the older source-learning freeze for this
session. Full proofs are in `../research/*SESSION_2026_08_30.md`.

- **Analytic route:** an actual prime-power encoding proves
  `#{n<=N: P+(n)<=Y, omega(n)<=w} <= (1+Y*floor(log_2 N))^w`.
  Together with Younis's unconditional short-interval theorem and the
  classical long-interval estimate, it disproves Carella v2, Lemmas 4.2 and
  4.4 and the relative exceptional estimate (4.24), in their stated range.
  The low-support subset is negligible within the smooth set; an extremely
  sparse unbounded sequence is still not excluded. Lean checks the actual
  integer encoding, finite cardinalities, and finite first moment; it does
  not formalize the external analytic theorems.
- **Signed endpoints:** actual prime-factor sums now realize the v17
  identity and its coupled, abc-equivalent estimate. Genuine triples
  `(1,2^N,2^N+1)` refute separate-endpoint slopes below one without making
  any assertion about the odd neighbour's radical lower bound. The existing
  v17 source needed an explicit endpoint import, one algebraic proof step,
  and an unfolding-order repair; all three were fixed without weakening a
  statement. A merge description alone was not accepted as proof evidence.
- **IUT/local lattices:** the closed integral span of actual reachable
  vectors in a normalized local lattice has measure `q^(-d)`, where `d`
  is the minimum nonzero determinant valuation, or zero measure in the
  rank-deficient case. This full Haar statement has a paper proof. Lean
  checks the unit-determinant span certificate and the strict simultaneous
  tensor counterexample, including characteristic two. Independent
  admissible generation and actual IUT normalization remain open. The
  July 30 Joshi response and pinned July LANA report were checked directly.
- **Arithmetic geometry:** effective integral-point results and square-factor
  descent force both the index and the squarefree quadratic kernel to grow in the specifically stated
  Pell--Chebyshev residual, with `log(D)/log(b) -> 0`; the resulting bounds
  are still compatible. A new actual Frey bound
  `c^4 <= 1024 * den(j_Frey)` shows that each fixed small-denominator
  hypothesis covers only finitely many positive Frey triples. Pasten's
  August 24, 2026 preprint was checked for its real hypotheses, with point
  heights distinguished from curve heights. External effective-height
  estimates remain explicit hypotheses in the Lean scalar implications.

The English manuscript is `../paper/ChatGPT_ABC_Uniformity_2026.tex`.
The consolidated verification record is
`verification/2026_08_30/VALIDATION.md`; it distinguishes complete builds,
component checks, external inputs and the final target for which no proof
term has been constructed.
No broader route is abandoned merely because it remains incomplete.

## Current parallel program

Prime-by-prime testing is no longer a main research line.  The completed
`(p,X)=(43,47)` and `(37,239)` calculations are one-time counterexamples to
two proposed prescribed-Frobenius **strategy statements**; neither is a
solution of the shifted-square equation or a counterexample to abc.  Further
finite-index work is admitted only when it tests a genuinely uniform lemma or
supplies an input to one of the following global gates.

- **Uniform proof route.**  Prove the eventual Frey modified-Szpiro estimate,
  equivalently the missing normalized modular-degree/Szpiro-strength bound,
  with the threshold and constant chosen uniformly before the abc point.  The
  exact eventual-to-uniform implication is kernel-checked below.
- **Deep-theory proof route.**  Construct a genuine theta possible-image
  output with its native q-pilot volume and then a quantifier-correct global
  IUT IV bridge of the form `for every epsilon, there are global choices that
  work for every abc point`.  Accepted external theorems may be used, but an
  unrestricted bridge whose inhabitation is already equivalent to abc is not
  counted as an independent input.
- **Uniform disproof route.**  Produce a fixed positive repeated-prime excess
  along one height-unbounded, reindexed family.  The exact excess-mass
  implication to `not ABCConjecture` is kernel-checked below.  Isolated
  high-quality triples cannot satisfy the required uniform quantifiers.

These routes run in parallel.  Computation is subordinate to them rather than
an open-ended search over successive primes.

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
- odd-period theta automorphy and the explicit algebraic equivalence of its
  Kummer root locus
- the corrected graph-period cyclic quotient, its free integer action,
  proper discontinuity, and the resulting ordinary topological orbit covering
- a continuous comparison from that orbit quotient to the Tate `K`-point
  quotient and its valuation circle, together with the characteristic-zero
  norm-one-kernel obstruction to injectivity
- the exact norm-one angular kernel of the valuation-circle map and, for a
  discretely valued field, the finite `K`-rational radial image
  `range(rho) ~= ZMod(order_pi(q))` with its exact cardinality
- genuine non-classical polynomial Gauss absolute values of every positive
  radius and their strict extension to Laurent polynomials, with
  `|T|=r`, `|T^-1|=r^-1`, an explicit `T |-> qT` automorphism and exact
  covariance; the positive radial orbit quotient is homeomorphic to the
  logarithmic circle
- the actual uniform completion of each positive-radius Laurent--Gauss norm,
  with a complete normed `K`-algebra structure, exact multiplicativity of the
  completed norm, an isometric injective dense Laurent embedding,
  `||T^n||=r^n`, and an isometric completed `T |-> qT` equivalence between
  radii `||q||r` and `r`
- the honest Hausdorff pointwise space of contractive multiplicative
  seminorms extending the base-field norm on each completion, its
  contravariant functoriality under isometric algebra equivalences, the
  completed Gauss point, and the scaling homeomorphism between the radius
  `r` and `||q||r` spaces; when `||q||=1` this specializes to an actual
  fixed-radius `Z`-action
- existence and set-level uniqueness of least products of scaled maximal
  valuation rings for compact local packets with nonzero projections
- normalized local additive Haar measure and honest finite-positive nonzero
  scaled integral balls
- residue-cardinality normalization of the local Haar character, the bridge
  from norm-uniformizers to DVR uniformizers, and the actual bad-place formula
  `log Delta(q) = -qOrder * log(#k)` with the DVR, finite-residue, proper and
  Borel structures derived from the actual adic completion
- the finite actual bad-place Haar packet: the completed residue field has
  cardinality `absNorm(w)`, each signed entry is
  `-qOrder(w) * log(absNorm(w))`, and the normalized negative packet sum is
  exactly the degree of the explicit q-divisor and `arithmeticLogQ`; its
  identification with public `logQ` is correctly conditional on weight-degree
  compatibility
- a genuine finite-positive distinguished-label slice of the standard
  procession, with exact square-label Haar log-volumes, exact finite square
  averaging, source-derived odd bad-place selection, and a newly constructed
  canonical residue-degree weighted `QPilotData` whose public `logQ` agrees
  with the actual arithmetic q-divisor normalization
- fixed-place rational prime scale rigidity after prime specialization
- the unique labelwise `1/j^2` theta calibration, its finite weighted form,
  and the common-fixed-scale obstruction at labels one and two
- actual nonarchimedean absolute-value copies rescaled by `1/j^2`, together
  with the fixed-place theorem that no ring equivalence between the label-one
  and label-two `Q_p` copies can preserve logarithmic norm
- the balanced cross-label tensor theorem identifying multiplication by an
  integer in every label, its compatibility with direct-sum tuple expansion,
  and the exact finite-positive degree-line Haar law
  `log vol(nU)=log|n|+log vol(U)`; a complementary p-adic theorem rules out
  embedding the fixed-place `1/j^2` copies isometrically into that common
  packet while identifying integers
- an explicit source-faithful bound absorbing
  `sqrt(q) * log(A*q)` into an arbitrarily small multiple of `q`
- an explicit affine Fermat/Kummer algebra over the tripod which is finite
  etale, free of exact rank `n^2`, faithfully flat, surjective on prime
  spectra, and whose generators satisfy `x^n+y^n=1`
- Eisenstein irreducibility and integrality of the affine Fermat presentation,
  its honest boundary localization with both coordinates invertible, and a
  target-local standard-smooth proof for the bivariate affine Fermat quotient
- an explicit equivalence between the bivariate quotient and `AdjoinRoot`
  presentations, transporting smoothness first to the integral affine ring
  and then to the honest boundary localization
- an explicit `K`-algebra equivalence from that honest open Fermat ring to
  the two-stage tripod Kummer algebra, proved by localization, `AdjoinRoot`,
  and two standard-etale universal properties
- the Fermat power map's exact coordinate fibres over `0,1,infinity`, its
  local power laws, and a base-compatible equivalence identifying the honest
  open Fermat ring with the iterated Kummer presentation; under this
  equivalence the honest open is finite etale of exact rank `n^2` over the
  punctured tripod
- the generic local DVR theorem that a uniformizer identity
  `t = unit * x^n` forces additive order `n`, extended maximal ideal
  `m_R S = m_S^n`, and ramification index exactly `n`
- the genuinely graded homogeneous Fermat quotient and its actual `Proj`
  scheme, covered by the three coordinate basic opens, with each chart
  canonically affine and the `X_2`-chart ratios satisfying `u^n+v^n=1`
- an explicit `K`-algebra equivalence from the `X_2` homogeneous chart ring
  to the bivariate affine Fermat quotient, proved in both directions from
  chart generators, and transport of affine `Algebra.Smooth` to that chart
- for every odd positive degree in characteristic zero, explicit equivalences
  from all three homogeneous coordinate charts to the affine Fermat quotient
  and a Zariski-local proof that the genuine structural morphism
  `Proj(K[X,Y,Z]/(X^n+Y^n-Z^n)) -> Spec(K)` is smooth
- at the genuine `X_2` homogeneous chart point `(u,v)=(0,1)` over zero,
  the actual maximal ideal `(u,v-1)`, its `AtPrime` stalk DVR with
  uniformizer `u`, the target DVR `K[t]_(t)`, and the localized power map
  `t |-> u^n`, with additive valuation, extended maximal ideal, and
  ramification index all exactly `n`
- the exact Arakelov/tripod identities `N_D^(1)(a/c)=log rad(abc)` and
  `h_K(x^n)=n*h_K(x)`, together with the complete numerical
  Riemann--Hurwitz, ramification-degree, and log-canonical-degree profile of
  the degree-`n^2` Fermat cover and its connection to the actual finite-etale
  rank; in particular `deg(K+D)/deg(beta)=1`, so bare cover-degree
  normalization cannot improve a fixed counting coefficient
- the exact rational S-unit reformulation: the prime support of `a/c` and
  `1-a/c` is exactly the support of `abc`, every rational `0<x<1` has a
  canonical inverse primitive positive abc triple, and
  `ABCConjecture <-> UniformRationalSUnitTripodBound` with the same uniform
  quantifier order
- the exact support-entropy optimizer for a varying finite set of primes:
  any nonnegative local overhead with tail cost `g(p)=o(log p)` is absorbed
  into `epsilon*log rad + C_epsilon` by a finite smooth/rough split.  In
  particular `O(|S|)` and `sum log log p` losses are harmless when they arise
  after taking the logarithm of multiplicative height; this is a sufficient
  bookkeeping theorem, not an actual S-unit height estimate
- the anchored-descent audit for the rational S-unit tripod: all words in
  complementation and inversion remain in one orbit of at most six points,
  while the genuine Euclidean family
  `(q+1,1,q+2) -> (q,1,q+1)` introduces the arbitrarily large new prime `q`.
  The paper audit also separates the expanded-chain support explosion from
  the compressed continued-fraction and power-chain failures.  The surviving
  sufficient interface is a same-support descendant count linear in
  `c/(rad*entropyLoss)`; it is explicitly open, not a proved height estimate
- the ordinary-derivation obstruction over `Z` and `Q`, the canonical
  integer-valued `p`-derivation with its exact twisted additive and Leibniz
  laws, the local multiplicity test
  `p | delta_p(n) <-> p^2 | n` under `p | n`, and an explicit powers-of-two
  proof that its raw size is unbounded while the input radical stays `2`
- for the displayed integral Frey model, the actual modified height
  `log max(|c4|^3,|Delta|)` lies between `6 log c` and
  `6 log c + log 4096`, and a uniform slope-`6+6 epsilon` bound for this
  quantity conditionally implies abc; the displayed discriminant-radical
  differs from the elementary abc conductor by at most `log 2`
- the standard rational 2-torsion quotient equation has been checked by a
  cleared-denominator affine-map identity, with
  `c4'=16(a^2-14ab+b^2)` and `Delta'=-256abc^4`; direct displayed-model
  size arguments therefore improve the limiting coefficient from `3/2` to
  `6/5`, but do not reach `1`
- all three immediate rational two-torsion quotient models have now been
  computed exactly: their absolute displayed discriminants are
  `256abc*c^3`, `256abc*b^3`, and `256abc*a^3`.  The first is always maximal,
  their product is exactly `256^3*(abc)^6`, and an explicit endpoint family
  proves that the maximum of the original model and all three quotients still
  has only fifth-power growth
- the canonical generalized-Fermat exponent decomposition
  `x=kappa_n*X_n^n`, its exact real-weight identity `T=K_n+n*Q_n`, and the
  mixed-signature kernel budget `(n-1)(R_a+R_b)+(r-1)R_c`.  Together with
  the Frey discriminant identity, this proves that increasing the extracted
  exponent does not automatically dilute discriminant height
- the exact exponent-divisibility level proxy: at an odd prime the Frey
  discriminant exponent is twice the abc exponent, so an odd residual prime
  sees precisely whether it divides that exponent.  Lean proves the
  exponent-one support inclusion, product/weight versions, finite-family
  double counting, and the complete-support return when the modulus exceeds
  every exponent
- strict finite-modulus and finite-coefficient obstructions: arbitrarily
  large exponents `1+t*prod(ell)` evade every chosen finite modulus, while
  the primitive family `(1,p,p+1)` forces the canonical fixed-`n`
  coefficient to be the unbounded prime `p`
- the exact higher-prime-power arithmetic shadow: for odd `p` and odd
  residual `ell`, `ell^k` divides the Frey discriminant exponent exactly
  when it divides the corresponding abc exponent.  Constant local depth on
  any finite support passes at depth `k` and fails at `k+1`, so repetition
  alone does not multiply congruence depth
- an away-from-the-support coefficient barrier: the numerical
  level-raising proxy `e=p-2`, `A=3` has linear exponent depth, satisfies the
  Weil-size and divisibility conditions, and every residual prime dividing
  `e` is odd and different from `p`.  Lean also verifies the primitive family
  `(3^e,2,3^e+2)`, its exact unbounded `3`-adic Frey exponent, and the
  nonsquare tangent-cone certificate; the Kodaira and Tamagawa conclusions
  remain paper mathematics
- the canonical exponent-excess module
  `ZMod (n / rad(n))`.  Its finite arithmetic degree is exactly
  `sum_{p|n} (v_p(n)-1)*log p`, and Lean proves the radical-plus-excess
  decomposition as well as the exact equivalence between a radical upper
  bound for this degree and the corresponding product-height inequality.
  This constructs the missing `log p` weighting but does not prove its
  global upper bound
- a geometric source for the same weight at odd Frey places: on paper,
  inversion freely pairs the `2e` nodes of an `I_(2e)` polygon, and the
  quotient node algebra modulo constants has residue-field dimension
  `e-1`.  Over `Q_p` its cardinality and arithmetic degree are exactly
  `p^(e-1)` and `(e-1)*log p`.  Lean proves the paired-node combinatorics,
  quotient-by-constants finite model, exact degree, fixed-support
  unboundedness, and the scalar equivalence with slope-six Szpiro; it does
  not formalize the minimal regular model or finite-etale quotient scheme
- the full rational two-torsion/inversion node-action audit: the abstract
  affine group is `C_2^3`, but its effective permutation image on the
  `I_(2e)` nodes is only `V_4`.  The coarse invariant rank
  `ceil(e/2)-1` does not contract the exponent excess, because the missing
  sign rank is `floor(e/2)` and the two ranks add exactly to `e-1`.
  Paper local algebra gives the same verdict: the node-fixing `mu_2`
  quotient has equation `XY=pi^2`, ordinary coarse orbits resolve into two
  nodes, and the odd branch-swapping orbit becomes ramification.  The three
  cyclic two-isogeny contact exponents `4e,e,e` average back to `2e`, while
  the full translation quotient is `[2]`.  Lean checks only the abstract
  paired-node action and the resulting rank, cardinality, degree, parity,
  and contact conservation identities; the Tate polygon, Burnside quotient,
  actual character submodules, invariant rings, and resolutions remain
  paper mathematics
- the Frey four-branch binary-quartic audit: for
  `F=Z*X*(X-a*Z)*(X+b*Z)`, the classical invariants satisfy
  `I=a^2+a*b+b^2`, `J=(a-b)*(2a+b)*(a+2b)`, and
  `4*I^3-J^2=27*a^2*b^2*c^2`.  Primitive abc data give
  `gcd(I,abc)=1`, so high bad-prime multiplicity is genuine high-order
  cancellation rather than removable common content.  The marked stable,
  coarse discriminant, and reduced-base boundary multiplicities are
  respectively `e_p`, `2*e_p`, and `1`.  A fixed-prime primitive family
  strictly rules out any local bound using only the reduced fiber or its
  mod-prime GIT orbit, while an adjacent family shows that replacing the
  discriminant by invariant height yields no fixed coefficient saving.
  Lean checks the invariant identities, cusp parameters, coprimality,
  coefficient comparison, fixed-prime excess obstruction, and exact
  slope-six scalar equivalence; GIT, stable models, minimization, cluster
  pictures, and Arakelov intersections remain paper mathematics
- the exact modular-degree/Petersson exponent audit on the Frey locus.  With
  the unnormalized Petersson convention, the modular-area identity is
  `2*h_rel = log(delta/c_f^2)-log((2*pi)^2*||f||^2)`, while the unconditional
  symmetric-square lower bound supplies
  `log((2*pi)^2*||f||^2) >= log N-O(log log N)`.  The optimal quotient is
  joined to the displayed Frey curve by a rational isogeny of degree at most
  `163`, stable Faltings height is no larger than relative height, and the
  logarithmic error in the Faltings--`j` comparison has been explicitly
  absorbed rather than treated as a constant.  Consequently the sole
  remaining main-exponent input in this route is the normalized polynomial
  modular-degree bound `delta/c_f^2 <= C_eta*N^(2+eta)`; it would give the
  `6+epsilon` `j`-height slope and hence abc.  Existing unconditional and
  Rankin--Selberg-GRH estimates only bound `log delta` by respectively
  `O(N log N)` and `O(N log log N)`, so this audit is not a proof of that
  input.  Lean checks only the real scalar identities, the Pazuki-error
  absorption, and exact coefficient/no-cancellation witnesses
- the Frey Selmer--regulator audit.  Full rational two-torsion gives the
  honest ambient estimate `rank E(Q) <= 2*|S_f|`, but the primitive family
  `(3^(2*n+2),2,3^(2*n+2)+2)` has a constant support/parity profile at `3`
  and unbounded discriminant depth, so this qualitative rank bound cannot
  control height.  At an odd `I_(2e)` place the three nonzero two-torsion
  local heights are `e/6,-e/12,-e/12` times `log p`: the exponent mass is
  visible but cancels exactly.  The real period calculation gives
  `log c = 2*log(1/Omega_E)+O(log log c)`, and strong BSD rewrites
  `-log Omega_E` as the logarithm of the regulator--Sha--Tamagawa quotient
  divided by the leading term and torsion square.  Consequently the needed
  half-slope bound for this quotient is equivalent, up to the explicit
  period corridor, to the missing abc-height budget; it is not a consequence
  of BSD, GRH, or the Selmer rank estimate alone.  Lean checks the finite
  support/parity obstruction, signed local-height ledger, Selmer dimension
  algebra, and conditional scalar bridge; Tate uniformization, the period
  integral, BSD, and any global Mordell--Weil selector remain paper inputs
- the Frey real-period/AGM audit.  For the invariant differential
  `dx/(2y)`, the primitive positive period is
  `2*c^(-1/2)*K(sqrt(b/c)) = pi/AGM(sqrt(c),sqrt(a))`.  The first Landen
  ratio satisfies a reciprocal quadratic with discriminant `16*a*c`; its
  selected real contraction is inverted by the other square-root embedding,
  and its algebraic height remains `1/2*log c+O(1)`.  On a fixed-prime
  adjacent family the quadratic field is unramified at `3`, while the
  nonmaximal-order index carries the entire unbounded `3`-adic depth.
  Moreover the hypergeometric argument has exact height `log c`, and its
  linear term already has denominator `4*c`.  Thus classical AGM convergence
  and ordinary G-function denominator control do not yield radical saving;
  the sufficient missing input is the critical radical-sensitive period
  lower bound `Omega >= C_eta*rad(abc)^(-1/2-eta)`.  Lean checks the
  reciprocal algebra, discriminant, finite valuation and denominator
  identities, and scalar coefficient transfer; periods, number-field
  heights, order indices, and the Goldfeld-type lower bound remain paper
  mathematics
- the critical-period/Padé specialization audit.  Writing
  `-log Omega=(1/2)*log c-log(2*K(sqrt(b/c)))`, the elliptic-integral kernel
  is nonnegative and uniformly sublinear in `log c`; consequently the
  all-eta period bound with exponent `1/2+eta` is quantitatively equivalent
  to the all-epsilon abc budget, with every constant dependency explicit.
  The six modular-lambda branches, eta/discriminant formula, odd-prime Tate
  nome and locally integral Padé specialization all preserve the full
  source height or valuation depth.  In particular a degree-`N`
  specialization with unit leading coefficient pays exactly `N*v_p(c)`,
  and taking all number-field conjugates multiplies rather than dilutes this
  exponent.  Lean checks the uniform-budget equivalence, sharp scalar
  coefficient and exact Horner denominator carrier; special-function,
  period and number-field norm interpretations remain paper mathematics
- the Frey reduction-cycle spectral audit.  For the geometric `I_(2e)`
  cycle the antipodal resistance is `e/2`, the metric/Tate Green row is
  `e/6,-e/12,-e/12`, and the discrete Moore--Penrose Green differs by the
  explicit subdivision constant.  Grouping bad primes by their colliding
  two-torsion pair gives three fixed global pair energies whose sum is the
  full weighted mass, so one fixed pair captures at least one third.  This
  is a genuine non-circular selector, but the selected divisor is torsion:
  Faltings--Hriljac and the product formula force its positive graph energy
  to be cancelled by the remaining finite and archimedean terms.  Lean
  checks the cycle formulas, Green-normalization difference, one-third
  selection and scalar no-go; regular models, admissible intersections and
  Faltings--Hriljac remain paper mathematics
- the weighted Poitou--Tate selector audit.  The actual Frey curve for
  `(1,8,9)` has positive `3`-adic exponent excess but rank zero: a full
  two-descent supported on `{-1,2,3}` leaves exactly four classes after the
  primitive modulo-`16` and modulo-`9` tests, and all four are represented
  by its explicit eight torsion points.  This strictly refutes a universal
  non-torsion selector on every Frey curve.  Locally, for Tate parameter
  `q=p^(4m)`, two points in the same mod-two Kummer class can have Bernoulli
  parameters `0` and `1/2`, hence opposite local-height signs; mod-two
  descent alone cannot retain the desired weight.  Lean kernel-checks the
  finite residue table, actual positive excess and abstract quantified
  no-go.  The Kummer injection, rank deduction, Poitou--Tate criterion,
  Cassels--Tate obstruction and local-height interpretation remain explicit
  paper mathematics
- the bounded-abscissa quadratic selector.  CRT residue avoidance plus the
  degree-two torsion classification gives, for every positive loss target,
  a non-torsion point `(j,sqrt(j*(j-a)*(j+b)))` over degree at most two with
  `j` bounded only by that target.  A normalized composite weight makes the
  same point retain the prescribed fraction of both exponent-excess and
  reduced-radical mass, and normalized local degrees preserve the exact
  identity-component coefficient.  This genuinely resolves the local
  existence/Poitou--Tate obstruction after degree two.  Conversely, an
  explicit infinite CRT family proves that every fixed finite abscissa
  universe can be forced to pay a positive multiple of `log c` in both a
  new twist conductor and the quadratic-field discriminant.  Thus the
  fixed bounded-abscissa sublinear-conductor/discriminant refinement is
  rigorously closed, while global cancellation, adaptive unbounded
  abscissas and different auxiliary geometries remain open.  Lean checks
  the collision/double-counting core, separated-mass ledger, normalized
  degree identity and character orthogonality; Merel/classification, Neron
  local heights, conductor induction and the infinite family are paper
  mathematics
- the exact fixed-abscissa height obstruction.  On the family
  `(a,b,c)=(1,b,b+1)`, the selector section lives on a rational elliptic
  surface with fibres `4 I_2 + I_4`, Shioda pairing one, and hence
  `hhat(P_j)=(1/4) log b+O_j(1)`.  A simultaneous-power family makes every
  member of any fixed finite abscissa list meet the identity component at
  all odd bad primes; its finite local leading term is `(1/3) log b` and
  the archimedean term is `-(1/12) log b`, leaving the sharp global
  quarter-slope.  This rules out a small-height choice among the original
  fixed points, but not bounded-degree division points: an explicit half
  exists over degree at most eight and has slope `1/16`.  Lean checks the
  duplication/twist identities and the exact scalar ledgers; elliptic
  surfaces, Shioda heights and specialization remain paper mathematics
- the adaptive pair-square selector.  The three abscissas
  `k*a`, `-k*b`, and `a+(k-1)*c` extract respectively an `a^2`, `b^2`, or
  `c^2` factor from the cubic value.  Sacrificing the lightest of the three
  bad-prime packets, then applying weighted CRT and uniform degree-two
  torsion boundedness, gives a non-torsion quadratic point with
  `|Disc K|=O_delta(c)`, bad-depth loss at most `1/3+delta`, and retained
  odd component ledger at least `(1-3*delta)W/12`.  A simultaneous CRT
  family proves that every fixed finite coefficient universe still pays a
  positive source-height share in new twist conductor and field
  discriminant.  Unbounded coefficients survive, but require a genuinely
  uniform large-square-divisor theorem for varying cubic values.  Lean
  checks the pair-square identities, weighted ledgers and linear carriers;
  the Neron/conductor interpretation and infinite-family construction are
  paper mathematics
- the division-height conservation audit.  An explicit half of a fixed
  selector section has function-field canonical height `1/8` and
  specialization slope `1/16`; when its half-field is genuinely quadratic,
  the two conjugate places at every covered deep odd prime occupy the
  identity and opposite components, so their normalized Bernoulli component
  term is exactly one quarter of the original.  Rational-square degeneration
  can instead produce one packet.  Forcing such a packet squareclass to
  collapse globally produces a K3 section whose
  retained local term and global height both rise by the reciprocal factor
  four.  More generally the Bernoulli multiplication formula shows that
  the average over all `m^2` division branches and canonical height both
  scale by `m^(-2)`.  This closes division by itself and branch averaging,
  not a favorable single-branch theorem: asymmetric packet selection,
  same-character cancellation and adverse finite/archimedean control remain
  open.  Lean checks the half-point polynomial identities, numerical fibres,
  Bernoulli finite sum and homogeneous scalar ledger; Tate uniformization,
  Shioda pairings and specialization remain paper mathematics
- the asymmetric division-branch audit.  For a non-torsion identity-component
  point whose conjugate branch packets form a uniformly weighted coset of
  order `d | m`, the normalized Bernoulli coefficient is `d^(-2)` and its
  exact gain relative to canonical-height scaling is `(m/d)^2`.  A single
  identity packet retains the full positive local term, and Hensel lifting
  constructs such a branch over an unramified local extension with zero
  relative different.  Thus averaging does not close the single-branch
  route.  A genuinely quadratic fixed-abscissa half has `d=2`; rational
  squareclass collapse may give `d=1`, but the elementary aligned-root
  mechanism pays a quadratic naive-height cost.  The exact surviving global
  theorem is a simultaneous small-packet selector with radical-scale branch
  discriminant/conductor and a lower bound for all adverse finite and
  archimedean terms.  Lean checks the uniformly weighted packet algebra,
  local-degree cancellation, exact gain and alignment inequality; local
  fields, Kummer orbits and global height compensation remain paper mathematics
- the global two-Kummer packet classification.  On the full rational
  two-torsion Frey curve the three odd collision types have identity lines
  `<T_b>`, `<T_a>`, and `<T_0>`.  If `H` is the Galois difference subgroup of
  one half, its exact packet count is `|H/(H intersect L_p)|`; hence one
  nontrivial quadratic orbit can be single-packet for only one collision
  type, while two distinct single-packet types force the half to be rational.
  The line condition is exactly membership of the original point in the
  corresponding dual two-isogeny image.  The primitive family
  `(6,s^2-8,s^2-2)` with point `(8,4s)` is non-torsion but has orbit line
  `<T_b>`, so only the fixed odd `a`-mass is single-packet and both growing
  types remain double-packet for every half.  This strictly closes choosing
  the heaviest type by translating a prescribed point; it leaves adaptive
  construction of a short point in the required dual-isogeny image open.
  Lean checks the three finite torsion lines, packet counts, intersections,
  quotient coefficients and counterfamily identities; the Galois cocycle,
  isogeny equivalence and formal-group non-torsion proof are paper mathematics
- the adelic packet-compensation audit.  With finite norm absolute values
  and degree weights kept consistent, the Tate theta/intersection term on
  the basic annulus is nonnegative.  Thus the odd finite contribution has
  the sharp identity-packet gain `e_p/(6*d_p^2)` and opposite-packet floor
  `-e_p/12`; the remaining adverse terms lie over `2` and infinity.  After
  passing to one common field containing the branch and all torsion
  translates, the place-by-branch deficit matrix has both row and column
  sums zero.  More strictly, a fixed-field `Q(sqrt 6)` Pell--Frey family has
  a non-torsion single-packet point with finite contribution
  `(1/3)*log b+O(1)`, canonical height `(1/4)*log b+O(1)`, and archimedean
  contribution `-(1/12)*log b+O(1)`, while the field discriminant remains
  `24`.  Consequently an archimedean lower bound with coefficient `kappa`
  is exactly equivalent on this family to a radical bound with coefficient
  `12*kappa`; the critical `(1+epsilon)/12` input already has abc strength
  on this genuine subfamily.  Lean checks the Bernoulli lower bounds,
  finite/complement scalar ledgers, Pell identities and coefficient
  equivalence; Tate heights, common-field Green functions and elliptic-surface
  specialization remain paper mathematics
- the same-character rank-two obstruction.  Rubin--Silverberg specialization
  supplies two points in one quadratic squareclass with generic canonical
  Gram matrix `I_2`; the only fixed carrier collapses at `v=+/-1`, exactly
  where the two points become linearly dependent.  More strictly, a fixed
  twist `D=6` Pell family has fibres `8 I_2 + 2 I_4`, canonical Gram `I_2`,
  and every nonzero integer combination, even with coefficients varying
  along the family, has height at least `(1/4-o(1))*log b` while retaining
  the identity-component/Bernoulli baseline at the odd bad primes.  Rank two
  in one character space is therefore insufficient; a proof would need a
  genuinely small first successive minimum together with favorable local
  components, not rank alone.  Lean checks the curve/carrier identities,
  Pell points and the exact orthogonal scalar ledger; elliptic-surface fibres,
  Shioda pairings and specialization are paper mathematics
- the near-singular height-lattice audit.  A displayed real Gram eigenvalue
  is not a Mordell--Weil lattice invariant: the unimodular shear
  `Q_N=N*P+R` can make that eigenvalue arbitrarily small while preserving
  the complete set of nonzero integral quadratic-form values, the first
  successive minimum and the regulator.  Applied to the actual fixed-`D=6`
  Pell--Frey family, this costs no new field, conductor or local-component
  condition and gives `lambda_min/log b -> 0` while the integral minimum
  remains at least `(1/4-o(1))*log b`.  Rational two-isogenies only rescale
  an existing lattice, a one-point dual orbit remains rank one, and finite
  base change multiplies a pullback height lattice and its source divisor by
  the same degree.  Shioda's formula further shows that an identity-target
  section of `o(chi)` height needs at least `8*chi-o(chi)` auxiliary fibre
  degree to cancel the baseline.  The valid target is therefore a genuinely
  small integral first minimum or an explicit bounded-coefficient short
  vector, with all auxiliary fibre and arithmetic costs retained.  Lean
  checks the unimodular value-set identity, determinant/Rayleigh ledgers,
  isogeny and base-change scalars and the Shioda correction inequality;
  canonical heights and elliptic-surface geometry remain paper mathematics
- the Pell radical-recurrence barrier extracted from the fixed-field adelic
  family.  With `q_n+p_n*sqrt(3)=(2+sqrt(3))^n`, its doubled coordinates
  satisfy `s_n^2-3*r_n^2=1`, while the consecutive abc values
  `b_n=s_n^2-3` and `c_n=s_n^2-2` obey the same nondegenerate order-three
  recurrence `u_(n+3)=195*u_(n+2)-195*u_(n+1)+u_n`.  Their height is
  `n*log(97+56*sqrt(3))+O(1)`, and abc on this actual infinite family is
  exactly the missing joint estimate
  `log rad(b_n)+log rad(c_n)>=(1-eta)*n*log(97+56*sqrt(3))-O_eta(1)`.
  Stewart's general square-free-part theorem supplies only an `o(n)`
  logarithmic lower bound, and Lucas/Lehmer primitive-divisor theorems do
  not apply directly to these shifted order-three values.  Lean checks the
  Pell orbit, doubled recurrence, consecutive identities and characteristic
  polynomial; asymptotics, toric factorization and recurrence radical bounds
  remain paper mathematics
- the Pell first-hit and lifting refinement.  Every odd prime in the same
  pair `b_n*c_n` has both `2` and `3` as quadratic residues, hence is
  congruent to `+1` or `-1` modulo `24` and splits completely in
  `Q(sqrt(2),sqrt(3))`.  For either toric target its hit indices are exactly
  two classes `+r,-r` modulo the order of the Pell unit.  On either class the
  complete valuation is an affine `p`-adic logarithm: it is either constant,
  or equals `h+v_p(k-kappa)` for one `kappa in Z_p`, so every higher depth is
  one residue class.  Same-target gcds retain full prime powers in two square
  Pell carriers, while the cross gcd satisfies
  `gcd_odd(b_m,c_n) | |B_n-C_m|` for explicit nonzero unit traces.  These are
  genuine structural restrictions, but a separate finite local model proves
  that first occurrence, simple roots, unique Hensel classes and disjoint gcd
  carriers alone are compatible with logarithmic radical and linear size; it
  is explicitly not an actual Pell counterexample.  The surviving input is a
  uniform truncated-counting or first-hit-depth theorem for the fixed global
  units as the prime moves.  Lean checks the toric Bezout/discriminant, trace
  and scalar radical identities; reciprocity, local fields, `p`-adic logs and
  the gcd carriers remain paper mathematics
- the dual two-isogeny short-point reduction.  If a Frey curve has positive
  rank and `R` realizes its first integral Mordell--Weil minimum, then `2*R`
  lies in all three rational dual two-isogeny images and its rational half has
  one Kummer packet at every odd collision type.  Purely from
  `2*Lambda subset H_0 intersect H_a intersect H_b`, the shortest point in
  the common image costs at most four times the first integral minimum; this
  is the optimal abstract containment constant, not a claim of sharpness for
  every Frey image.  The actual curve `(a,b,c)=(1,8,9)` has rank zero and
  positive odd exponent excess, strictly ruling out an all-Frey rational
  non-torsion selector.  Even in positive rank, one packet does not certify
  the identity component or a favorable sign: a split `I_4` local example
  stays on components one and three under all rational two-torsion
  translations.  Lean checks the abstract dual-image containments, quadratic
  height scaling, packet row and scalar local counterexample; actual
  isogenies, Mordell--Weil minima and Tate uniformization remain paper mathematics
- the four-half archimedean compensation audit on the same fixed-field Pell
  family.  The four global translates of the single-packet point have
  abscissas `2`, `-b/2`, `b+2`, and `-b/(b+2)`.  The last denominator
  contributes `(1/2)*log b+O(1)` at good primes, so it cannot be omitted when
  cancelling its archimedean term.  After separating odd bad, good finite and
  infinite places, the centered four-column deficit matrix has every row and
  column sum zero.  Any nonnegative global weighting with nonnegative
  archimedean leading term has selected odd-bad mass at most its total height;
  equality is only the repeated critical mixture, never a strict abc margin.
  Signed combinations do not help because all four translates define the
  same rank-one class modulo torsion.  This is a strict obstruction for
  torsion translations and isomorphic relabellings of one Frey motive, not
  for a genuinely different auxiliary motive.  Lean checks the translated
  abscissas, complete slope/deficit ledgers and positive-weight optimization;
  local heights, Pell specialization and Faltings--Hriljac remain paper mathematics
- the exact place-over-two packet ledger for primitive Frey curves.  If the
  unique even entry has depth `e>=5`, the two large-depth branches are either
  multiplicative `I_(2e-8)` or additive-star `I^*_(2e-4)`, but both have the
  same sharp component lower bound `-(e-4)*log(2)/12`.  In the additive-star
  branch the rational two-torsion packet is exactly two identity translates
  and the same spinor translate twice; the vector component is geometrically
  valid but is not visited.  Its corrected four-translate average is
  `(e+8)*log(2)/24`, while a complete `m`-division packet has the usual
  `m^(-2)` Bernoulli lower bound.  The actual families `(1,2^e,2^e+1)` and
  `(3,2^e,2^e+3)` show that bounded conductor at the fixed prime `2` does not
  make a chosen branch `O(1)`: the worst local value tends to minus infinity.
  Lean checks the reduction-index scalars, corrected torsion averages and
  packet inequalities; Tate's algorithm, blow-up component tracing and local
  Neron functions remain paper mathematics
- the cyclic two-isogeny cross-motive audit.  At a split `I_(2e)` fibre the
  three quotient parameters are `q^2`, `sqrt(q)` and `-sqrt(q)`, with target
  depths `4e,e,e` and identity-component values `e/3,e/12,e/12`.  For the
  fixed-field Pell point their quotient abscissas are `(b+2)/2`, `2*(b+2)`
  and `2/(b+2)`.  Restoring the last point's growing good denominator gives
  the complete bad/good/infinite/height slopes
  `(5/12,0,1/12,1/2)`, `(5/12,0,1/12,1/2)` and
  `(1/6,1/2,-1/6,1/2)`.  Thus every nonzero nonnegative combination has
  selected odd-bad mass strictly below its total canonical-height cost and
  at most `5/6` of it; exact archimedean cancellation forces the sharper
  ratio `2/3`.  Lean checks the Bernoulli distributions, quotient-image
  identities and complete scalar optimization; Tate curves, Velu isogenies,
  local heights and Pell specialization remain paper mathematics
- the non-diagonal correspondence audit on the same three quotient motives.
  The dual-transported Pell points all equal `[2]Q`, so their canonical Gram
  matrix has rank one.  A genuine nef Laplacian correspondence nevertheless
  exists, with integral matrix `4*(3*I-J)` and zero cost on the selected
  diagonal graph.  Interpolating it with the product polarization and
  clearing denominators is honest, but the complete metrized ledger scales
  simultaneously to odd bad `1-t`, good finite `(1-t)/2`, archimedean `0`
  and total height `3*(1-t)/2`; the retained ratio is still exactly `2/3`.
  If a different frame is asserted to retain bad mass `1`, product-formula
  compensation forces good plus archimedean slope `1/2-3*t/2`, which is
  strictly negative as soon as the claimed height falls below the bad mass.
  Thus ordinary Rosati, Poincare-difference, fibre-product and Kani--Rosen
  projectors do not provide a shared-height saving.  The surviving input
  would be a new local positivity theorem for a noncanonical metrized
  correspondence, controlling both good and infinite rows.  Lean checks the
  quadratic forms, spectra, cleared interpolation and full scalar ledger;
  abelian schemes, cubical metrics and the Hom-classification remain paper mathematics
- the Pell global truncated-counting audit.  For
  `X_n = (s_n^2 - 3) * (s_n^2 - 2)`, Yu's Theorem 1' gives the corrected
  moving-prime estimate
  `v_p(X_n) << (p - 1) / log(p) * log(64 * max(n,3))`; hence the powerful
  excess below `sqrt(n / log log n)` is pointwise `O(n / log log n) = o(n)`.
  For every fixed gap `d`, a product of sixteen nonzero norm differences
  gives a full-prime-power carrier
  `gcd_odd(X_m,X_n) | R_|m-n|` with `log R_d = O(d)`, so radical overlap in
  a fixed index window is bounded.  The coefficient ledger also corrects an
  important scale issue: Pell abc needs only
  `E_n <= (1 + eta) * n * log(lambda) + O_eta(1)`, not `E_n = o(n)`.
  Equivalently, the surviving input is a four-target, one-orbit truncated
  count with coefficient `4 - 2 = 2`, or just the corresponding tail bound
  over moving primes above `sqrt(n / log log n)`.  Existing fixed-group gcd,
  Subspace and ordinary average theorems do not supply that pointwise tail.
  Lean checks the radical/excess coefficients, finite aggregation and the
  corrected cleared-denominator cutoff; Yu's theorem, number fields, norm
  carriers and truncated counting remain explicit paper mathematics
- the shifted large-prime Pell audit.  Bilu--Hong--Gun's auxiliary-prime
  construction remains valid after replacing one fixed target by any of the
  four Pell targets: with exactly `m - 2` rational auxiliaries, the dimension
  stays `m`, multiplicative independence is preserved, and `delta = 1` is
  admissible.  It gives the pointwise improvement
  `E_n(p <= sqrt(n) * exp(kappa * log(n) / log log(n))) = o(n)` for every
  fixed `0 < kappa < 1 / 8000`.  The remaining local estimates still permit
  a balanced pair of distinct first-hit cubes, one in each coprime factor,
  with `3 * L_b = 3 * L_c = H`; this respects the separate factor heights
  and has combined excess `4 * H / 3`.  It is only a finite-local/method
  countermodel, not a Pell or abc counterexample.  Lean checks the cutoff
  scalar substitution and the balanced prime-power ledger; the p-adic
  logarithm theorem, prime sums and the unresolved moving-prime tail remain
  paper mathematics
- the squarefull and primitive-divisor Pell audit.  The joint product is an
  exact simple nondegenerate order-five recurrence, but Stewart's unconditional
  theorem gives only
  `log rad(X_n) >> log(n) * log_2(n) / log_3(n) = o(n)`.  BHV applies
  legitimately only to the normalized homogeneous Pell--Lucas carrier, with
  the exact identity
  `b_(m+k) - b_m = c_(m+k) - c_m = 3 * r_k * r_(2*m+k)`; it does not control
  a first-hit prime's extra copies.  The actual recurrence
  `M_n = 2 * (2^n - 1)^3` has eventual primitive support, no perfect powers
  at positive indices and negligible fixed support, yet its normalized
  powerful excess has lower limit at least `4 / 3`.  Thus those outputs alone
  cannot yield the critical coefficient.  Lean verifies both recurrences,
  the homogeneous carrier and the exact scalar gap; Stewart, BHV and
  Zsigmondy remain explicitly paper-only
- the residual-order and cubeful-tail Pell audit.  Writing `C3_n` for the
  logarithmic copies beyond the square layer and `S1_n` for exponent-one
  support gives the exact identity
  `2*E_n-log(X_n)=C3_n-S1_n`; prime squares are therefore neutral at the
  critical coefficient, and the missing estimate is a balance between
  super-square and exponent-one mass.  Yu's 2013 Main theorem, specialized
  through the residual subgroup of order `t_p`, together with a fixed-order
  norm carrier, proves that the high-prime contribution with
  `t_p <= n^(1/3)/log(n)` is `o(n)`.  Combined with the shifted
  Bilu--Hong--Gun cutoff, the only remaining tail has simultaneously
  `p > sqrt(n)*exp(kappa*log(n)/log log(n))` and
  `t_p > n^(1/3)/log(n)`.  The exact full-power identity shows why the norm
  carrier can retain only one copy of a shifted first-hit cube, so the final
  required proposition is the pointwise super-square balance (8.1), not an
  ordinary support or gcd bound.  Lean checks the exponent-layer identities,
  critical equivalence, component-correct cube ledger and scalar absorption;
  Yu's theorem, residual orders, norm carriers and the final tail remain
  explicitly paper-only
- the first-hit Kummer and cyclotomic refinement for the same Pell tail.  The
  exact identities `lambda=q^8` and `gamma_i=beta_i^2` give the residual-order
  squeezes `p-1>16*n` or `p-1>4*n`, according to the two support classes
  modulo `24`, while preserving the full shifted depth in one square-root
  branch.  If `d=gcd(n,t)`, `n=d*a` and `t=d*T`, then the target has exact
  order `T>2*a`, and
  `Res(Phi_t(X),X^n-Y)=Phi_T(Y)^(phi(t)/phi(T))`.  Order lifting gives the
  exact truncated synchronization
  `min(e,h_gamma)=min(e,h_lambda+v_p(a))`; at a first hit the last valuation
  vanishes.  Every remaining collision layer is therefore an anomalously
  small least representative modulo `t*p^(J-h)`, with the cube case bounded
  by `1/(2*p^2)`.  Tame Kummer theory sees the residual class but not this
  depth, and the required cumulative least-representative estimate remains
  unproved.  Lean checks the scalar identities and an exact fixed-Pell
  `p=23,n=1552` depth-three diagnostic.  Three finite certificates use
  `native_decide` and are disclosed as such; local order lifting, resultants,
  Kummer theory and the sufficient cumulative estimate remain paper-level
- the repeated-hit prime-power reduction.  At each medium-order prime the
  exact layer identity
  `(e_p-2)_+=B_p+J_p+D_p` separates base depth, at most one transition copy,
  and layers first in the selected inverse-target pair.  The total transition
  mass is `o(n)`.  Splitting `D=C_cross+F_four` exposes a full prime-power
  carrier for every cross-target layer, but summing its moving earlier index
  gives only a quadratic budget; the base carrier has the analogous moving-
  order defect.  The resulting minimum open inequality is the current-index
  balance `W_n+C_n+F_n <= S1(X_n)+2*eta*H_n+o_eta(n)`.  Two conditional
  fixed-unit profiles show that the audited marginal inputs do not imply this
  balance; they explicitly respect target order, separate factor heights and
  the full fixed-gap carrier, and are not asserted to occur in the Pell
  sequence.  Lean checks the layer algebra, transition cutoff and the
  carrier-compatible moving-index scalar profiles
- the four-point same-index bridge.  On the Pell orbit
  `b_n,b_n+1,b_n+2=3*r_n^2,b_n+3=s_n^2`, the two square branches consume at
  most one height unit.  A level-one truncated inequality for the divisor
  `{0,-1,-2,-3}` with coefficient `4-2=2` would therefore yield the missing
  radical coefficient one and the complete current-index `W+C+F` balance.
  Existing unconditional truncated approximation, fixed-support Subspace,
  gcd-carrier and recurrence-radical theorems do not supply this pointwise
  coefficient; obtaining it by two gap-two abc applications is circular.
  Lean checks the exact coefficient subtraction and a two-index aggregate
  counterprofile showing why a window average cannot replace the pointwise
  statement.  The truncated coefficient-two inequality itself is explicitly
  conjectural and is not stored as a theorem
- the squarefree-part fundamental-unit audit for the Pell companion
  `c_n=A_n*y_n^2`.  The exact quartic identity
  `9*r_n^4-A_n*(y_n*s_n)^2=1`, Bennett--Walsh's uniqueness/index theorem and
  a Chebyshev calculation modulo `3` force
  `(c_n+1)+y_n*s_n*sqrt(A_n)` to be the first positive Pell unit.  Since
  `A_n=23 (mod 24)` and a prime `23 (mod 24)` divides it, there is no
  norm-minus-one unit; the displayed element is therefore the actual field
  fundamental unit, and the parameters `A_n` are pairwise distinct.  The
  exact class-number formula and Louboutin's all-conductor bound give only
  `A_n >= (16-o(1))*H_n^2/log(H_n)^2`.  Retaining the fixed Euler factors at
  `2` and `3` in Granville--Soundararajan improves the asymptotic constant to
  `64/(2-2/sqrt(e))^2 = 103.347...`, but not the polynomial scale.  The
  surviving coefficient-one input is still
  `log(A_n) >= (1-o(1))*H_n`; Lean checks the elementary Pell, quartic,
  Chebyshev and injectivity ledgers, while the cited Diophantine and analytic
  theorems remain explicit paper inputs
- the nonmaximal quadratic-order conductor audit for the same decomposition.
  Because `A_n=3 (mod 4)`, the order `Z[y_n*sqrt(A_n)]` has exact conductor
  `y_n` and discriminant `4*c_n`.  Its unit index, both wide and narrow, is
  one, and the fundamental unit is congruent to one modulo the conductor.
  Consequently the exact multiplier
  `y_n*prod_(p|y_n)(1-chi(p)/p)` in the real ring-class formula is absorbed
  by the enlarged order class number and cancels identically from the
  imprimitive analytic formula.  Ray and genus class groups store the same
  conductor mass rather than bounding it.  The correct radical identity is
  `rad(c_n)=A_n*rad(y_n)/gcd(A_n,y_n)`; an exact computation gives the actual
  overlap `v_23(c_1575)=3`.  Thus the one-factor coefficient-one conclusion
  is equivalent to `log(y_n)=o(H_n)`, not to an almost-squarefree estimate
  for `y_n`.  Lean checks the scalar cancellation, radical deficit, recurrence
  certificate and transparent finite evaluation
- the parity-squareclass recurrence audit for `c_n=A_n*y_n^2`.  Stewart's
  printed `Q(m)` is exactly `rad(m)`, not the squarefree representative
  `A_n`; the fixed-multiplier Shorey--Stewart/Ribenboim theorems and the
  McDaniel--Ribenboim collision theorem have no uniform index-versus-`log A`
  conclusion.  The exact same-spectrum model `Z_n=2*s_n^2=2*c_n+4` retains
  the reciprocal cubic recurrence while its squareclass is constantly `2`,
  and the fixed parameter `47=23 (mod 24)` supports an infinite norm-two
  Pell orbit once the simultaneous `Q(sqrt 3)` and least-unit conditions are
  removed.  The factorization over `Q(sqrt 2)` only rewrites the same
  regulator obstruction as a binary quadratic form.  Thus the strongest
  accepted pointwise estimate audited here is still polynomial in `H_n`,
  and the exact missing statement remains `log(y_n)=o(H_n)`.  Lean checks
  the recurrence, fixed-47 orbit and scalar squareclass ledger
- the Tatuzawa/class-number family audit.  Injectivity of the discriminants
  correctly pulls Tatuzawa's one possible exceptional character back to at
  most one index for each fixed exponent, and hence gives the ineffective
  full-tail relation `log L(1,chi_D)=o(log A_n)`.  This is a lower `L`-bound
  and does not invert the large real-quadratic regulator: together with the
  class-number formula it yields only
  `log(A_n) >= (2-o(1))*log(H_n)`.  The norm-two element makes the ramified
  prime above `2` narrow-principal but does not remove another ordinary
  genus bit.  Yokoi's invariant specializes exactly to `m_A=2*y_n^2`, so
  its denominator is again `H_n+O(1)`; the Richaud--Degert remainder `-2`
  occurs exactly at `y_n=1`, where `A_n=c_n` is already the easy case.  Lean
  checks the exceptional-index pullback, norm-two/Yokoi identities and the
  division-free direction ledger; Tatuzawa, the class-number formula and
  Yokoi remain explicitly cited paper inputs
- the accepted-theorem delta audit through 26 August 2026 for the same
  square-base bottleneck.  The Lucas-atom valuation theorem of
  Alecci--Miska--Murru--Romeo specializes here only to the first-occurrence
  identity and does not control later depth when the Pell parameter moves.
  Fellini--Murty's published Theorem 2.1 unconditionally detects the
  existence of at least one ramified non-Wieferich core prime, but its
  quantitative Theorems 2.2--2.4 require either number-field abc or the
  unproved finiteness of super-Wieferich primes.  Exact-power modular results
  fix the moving squarefree coefficient and therefore do not provide a
  uniform level.  An actual recurrence certificate
  `v_23(c_57)=2` confirms that radical support and parity core genuinely
  diverge in the Pell family.  The exact surviving target remains
  `log(y_n)=o(H_n)`; a coefficient-one radical estimate would imply it but is
  strictly stronger.  Lean checks the full epsilon--constant quantifier
  ledger, the coefficient-one implication and the separating scalar profile;
  every cited arithmetic theorem and each conditional hypothesis remain
  explicit in the accompanying audit
- the congruent-number-twist realization of the Pell square-base system.
  For `D_n=3*A_n`, the exact integral point
  `X_n=9*A_n*r_n^2`, `Y_n=9*A_n^2*s_n*r_n*y_n` lies on
  `Y^2=X^3-D_n^2*X`, and
  `X_n/D_n^2=y_n^2/3+1/(3*A_n)`.  Bennett's theorem on three
  prescribed consecutive square classes makes the moving `A_n` pairwise
  distinct.  Chan's 2024 uniform theorem therefore gives the unconditional
  sparse-set estimate
  `#{n:3*A_n<=X} <<_epsilon X*(log X)^(-1/4+epsilon)`.
  This is a genuine distributional advance but not a pointwise height bound:
  Chan's fixed-twist/coset theorem permits up to thirty large integral points
  on every moving twist.  The proof-level assertion excluding all such large
  points for every exponent margin uses abc with an adjustable parameter and
  is therefore circular here.  The surviving noncircular target is the
  orbitwise estimate
  `log(X_n)<=(2+eta)*log(3*A_n)+C_eta` for every positive `eta`.
  Lean checks the curve map, factor identities, ratio and the injectivity
  deduction from Bennett's explicitly supplied positive-coefficient premise
- the index-transfer audit for that congruent-twist route.  The already
  available pointwise class-number estimate
  `A_n >> n^2/(log n)^2` implies
  `#{n:3*A_n<=X} << sqrt(X)*log X`, which is asymptotically stronger than
  Chan's unordered support count and therefore shows that the latter adds no
  pointwise square-core information here.  An exact adjacent Pell Bezout
  identity has fixed carrier `240`; the actual orbit is coprime to `240`, so
  `gcd(c_n,c_(n+1))=1`.  A PNT-in-progressions separation profile nevertheless
  has distinct squarefree cores `A_n` of size about `n^2*log n`, linear total
  height, adjacent coprimality and `log(A_n)/log(c_n) -> 0`.  It is explicitly
  a logical profile rather than a Pell solution.  Thus support sparsity,
  pairwise distinct twists and adjacent coprimality together still do not
  imply the missing pointwise coefficient-one core bound.  Lean checks the
  exact resultant, divisor carrier, division-free counting envelope and
  scalar separation ledger; PNT in arithmetic progressions remains a cited
  accepted input in the accompanying note
- the four-consecutive-product refinement.  Writing
  `b=A*u^2`, `b+1=B*v^2`, `b+2=3*r^2`, `b+3=s^2` gives the genuine norm-one
  unit with coefficient `D=3*A*B` and the additional constraint
  `4*T_k(T)+5=(2*b+3)^2`.  Even unit indices are impossible.  For an odd
  index, the tempting Jacobi-symbol shortcut requires an additional
  congruence such as `5 | T_(k/p)(T)` and does not give an unconditional
  restriction on the prime divisors of `k`; the audit records the explicit
  `T=9,p=3` diagnostic preventing that misuse.  No accepted theorem located
  in the audit proves the stronger uniform assertion that the displayed
  square condition forces `k=1`; the extensive finite scan is recorded only
  as evidence.  Even if that assertion were proved, generic regulator
  inversion would give only
  `A*B >> H^2/log(H)^2`, still far below the radical coefficient one.  The
  remaining target is a moving-coefficient Pell--Mahler lower bound for the
  square-base radical after overlap.  Lean checks the four-consecutive
  algebra, norm equations, radical ledger and height-correct scalar barrier;
  no uniform Chebyshev-square or radical theorem is assumed
- the exact index-three elimination inside the residual Chebyshev-square
  problem.  At `k=3`, the substitution `X=4*T`, `Y=2*y` identifies
  `y^2=4*T_3(T)+5` with the elliptic curve
  `Y^2=X^3-12*X+20` (216a1).  Magma V2.29-9, with a proved saturated
  Mordell--Weil basis, and the independent LMFDB record give the complete
  integral `X`-list `{-4,-2,1,2,4,10,22,89}`; its only positive multiple of
  four is `4`.  Chebyshev composition therefore proves, relative to this
  transparently named external certificate, that every residual solution
  with `T>1` has `3` not dividing its unit index.  Lean proves the
  substitution, finite filter, growth and composition and accepts integral-
  point completeness only as an explicit hypothesis
- the exact prime-five elimination inside the same residual problem.  The
  substitution `X=-2*T` identifies
  `y^2=64*T^5-80*T^3+20*T+5` with the genus-two curve
  `Y^2=-2*X^5+10*X^3-10*X+5`.  An exact Magma V2.29-9 two-cover descent
  leaves one candidate in a possibly enlarged but rational-point-complete
  candidate superset.  Its elliptic quotient over a quintic field has a
  finite-odd-index Mordell--Weil subgroup, and single-prime elliptic
  Chabauty returns `N=#V=8` and `R=1`.  Pullback gives exactly
  `infinity, (-2,+/-3), (2,+/-1)`, so the original rational bases are only
  `T=+/-1` and no `T>1` solution exists.  The full executable input and exact
  transcript were independently rerun; no GRH, BSD, analytic-rank guess or
  height cutoff enters.  Lean checks the substitution and deductions from a
  transparently named external certificate.  Thus the residual uniform
  prime-index proposition now starts at `p>=7`
- the exact prime-seven elimination inside the same residual problem.  The
  genus-three curve
  `y^2=256*T^7-448*T^5+224*T^3-28*T+5` has Jacobian rank exactly two:
  an unconditional Magma V2.29-9 2-Selmer computation gives rank at most two,
  while two rational divisor classes have independent 5-adic logarithms.
  On the good monic model at `5`, the resulting annihilating differential is
  nonzero at every one of the six residue classes.  The elementary local
  power-series estimate therefore gives at most one Coleman zero in each
  disc, including at `p=5`; five rational points occupy five discs, and the
  sixth zero is the non-rational 5-adic Weierstrass point.  Consequently the
  only rational bases are `T=+/-1`, so no `T>1` solution exists.  The complete
  Magma and SageMath 10.9 scripts were independently rerun in fresh official
  sessions, and no GRH, BSD, saturation assumption, analytic-rank guess or
  search cutoff enters.  Lean checks the scalar deductions from a transparent
  external certificate.  Thus the residual uniform prime-index proposition
  now starts at `p>=11`
- the exact prime-eleven elimination.  On the genus-five curve
  `y^2=4*T_11(T)+5`, an unconditional Magma V2.29-9 phi-Selmer computation
  gives `Sel_2(J)=(Z/2Z)^2`.  Two explicit half-divisors have the correct
  odd-degree descent images `[-U_1(theta)]` and `[-U_9(theta)]`; they generate
  the full Selmer group, so `rank J(Q)=2` and their subgroup has finite odd
  index.  A SageMath 10.9 Coleman computation at `5` gives a primitive
  annihilating differential nonzero on all six residue discs.  Five rational
  points occupy five discs, while the last zero is the unique non-rational
  5-adic Weierstrass point.  Thus the only rational bases are `T=+/-1` and
  there is no `T>1` solution at index `11`.  The complete Magma and Sage
  scripts were independently rerun; no GRH, BSD, analytic-rank assumption,
  search cutoff or abc input enters.  Lean checks the exact scalar models and
  deductions from a transparently named external certificate.  The residual
  prime indices become `p=13` and `p>=17`
- the exact prime-thirteen elimination.  On the genus-six curve
  `y^2=4*T_13(T)+5`, an unconditional Magma V2.29-9 computation gives
  `Sel_2(J)=(Z/2Z)^2`; two explicit half-divisors have distinct nonzero
  descent images generating that group, so `rank J(Q)=2` and their subgroup
  has finite odd index.  At the good prime `5`, SageMath 10.9 computes the
  full Mordell--Weil logarithm kernel and a primitive annihilating
  differential nonzero on all six residue discs.  Five rational points
  occupy five discs; the sixth Coleman zero is the unique non-rational
  5-adic Weierstrass point.  Therefore the only rational bases are
  `T=+/-1`, and no `T>1` solution exists at index `13`.  The complete Magma
  and Sage scripts and outputs were independently rerun; no GRH, BSD,
  analytic-rank guess, saturation assumption or height cutoff enters.  Lean
  checks the exact model changes and the deductions from a transparent
  external certificate.  The residual prime indices are now `p>=17`
- the exact ambiguous-class and S-unit descent for that remaining prime-index
  proposition.  If a hypothetical solution at prime `p>=11` is written as
  `b=A*u^2`, `b+1=B*v^2`, `b+2=3*r^2`, `b+3=s^2`, then
  `alpha=1+2*epsilon^p` has square ideal and its class is exactly the
  ramified-prime class `[P_B]`.  In the biquadratic square-root field
  `L=Q(sqrt(B),sqrt(3*A))`, the explicit element
  `beta=v*s*sqrt(B)+u*r*sqrt(3*A)` satisfies `beta^2=alpha`; this field is
  correctly not called the strict genus field because it remains ramified
  above `2`.  The complete two-adic ledger is
  `(2)=P^4` and `(beta-1)=(beta+1)=P^2`, while the three subfield norms reduce
  to the exact unit equation `(delta-1)^2*epsilon^p=2*delta`.  Kubota's unit
  classification and the degree-eight factorization see only the parity
  squareclass of the odd exponent.  Beukers--Schlickewei supplies a uniform
  numerical solution count but no uniform height for an individual moving-
  field solution; the other audited S-unit, modular and Lucas results retain
  fixed-field or fixed-coefficient hypotheses.  An exact fundamental-unit
  example at `T=479,p=17` shows that all BHV primitive divisors can split in
  `Q(sqrt(5))`, so primitive-divisor existence plus the necessary splitting
  condition is not a contradiction.  This is a method diagnostic, not a
  solution of the shifted-square equation.  At this audit stage the residual
  exclusion for every prime `p>=17` was explicitly unproved; the pointwise
  `p=17,19` closures recorded below supersede those two cases.  Lean checks
  all scalar
  coordinates, norms, unit identities, degree-eight factorization and the
  large-integer diagnostic without asserting the number-field residual
- the local-permutation barrier for the same prime-index problem.  For every
  fixed odd residue characteristic below a sufficiently large prime index,
  the Chebyshev map is a permutation and the complete half-angle, four-
  consecutive, norm and square-root residual has a nonsingular local point;
  the explicit signed branches at `2` and `3` then give a simultaneous CRT
  point for every fixed finite prime-power test.  A moving prime with an
  exact order-`2*p` eigenvalue can likewise satisfy all required quadratic
  splitting and residual equations.  These are local method barriers, not
  global Pell points.  On the positive side, fundamental-unit minimality
  gives the general necessary power inequality.  The accepted fixed-index
  closure at `p=31` moves the active range to `p>=37` and sharpens it to
  `(3*A*B+1)^37 <= Z^2`.  The actual
  four-consecutive residues `A=22 (mod 24)` and `B=23 (mod 24)` force
  `A*B>=506`; together with `Z^2<(b+2)^4`, exact integer comparison gives
  the unconditional height floor
  `b+2>260000000000000000000000000000`.  This removes a still larger finite
  initial segment but does not give a uniform exclusion; the audited
  squarefree-kernel literature remains below the required `4/37` scale.
  Lean checks the full scalar local blocks, the generalized division-free
  threshold, the active residue product floor and the exact height
  comparison; finite-field permutation, Hensel lifting and Dirichlet remain
  explicitly cited accepted inputs.  The companion
  `FREY_PELL_CHEBYSHEV_LOCAL_SIMPLE_ROOT_CORE.md` and its Lean module now
  close the previously abstract polynomial seam with Mathlib's actual
  Chebyshev polynomials: they prove
  `T_n(x)^2-1=(x^2-1)U_(n-1)(x)^2`, evaluate `T_n'`, and show that a
  target-five preimage in characteristic at least `5` is non-endpoint with
  unit derivative when the characteristic does not divide the prime index.
  Under an explicit bijectivity hypothesis it also proves uniqueness of the
  target-five preimage, uniqueness of an abscissa for every ordinate, and
  the scalar CRT bridge.  Dickson's permutation theorem and Hensel lifting
  remain explicitly accepted published interfaces; the resulting points
  are local points, not asserted global Pell/fundamental-unit solutions
- the fixed-five and primitive-divisor refinement of the active prime-index
  residual.  Every prime `q!=5` in the support of `T_p(X)` satisfies
  `q=+/-1 (mod 5)`; if `5|T_p(X)`, then its valuation is exactly one.
  This yields the complete CRT split
  `X=71 or 119 (mod 120)` off 5 and the two classes `455` or `95 (mod 600)`
  on the ramified branch.  Class number one of `Q(sqrt(5))` turns every
  solution into the exact integral norm-composition residual
  `r^2-5*s^2=4*X`, `u^2-5*v^2=4*H_p(X)`, `r*v+s*u=2`, with parity and
  positivity.  The BHV primitive-divisor theorem at index `2*p` supplies a
  prime `q|H_p(X)` with `q=+/-1 (mod 5)` and `4*p|q-1` or `4*p|q+1`, hence
  `q>=4*p-1`, sharpened to `q>=8*p-1` when `5|X`.  The residue filters,
  norm-composition algebra, adjacent-square gap, CRT tables and boundary
  arithmetic are kernel checked; quadratic reciprocity, ideal selection and
  BHV are explicitly accepted interfaces.  Local examples show that these
  constraints remain compatible and therefore do not close the active
  `p>=37` family after the separate fixed-index closure at `p=31`
- the primitive-divisor odd-valuation audit for the same quotient.  If
  `p=2*m+1`, then `H_m=T_p/X` is exactly the Lucas cyclotomic block at index
  `2*p`, equivalently the `p`-th term of the Lehmer pair
  `(X+sqrt(X^2-1),-X+sqrt(X^2-1))`; the classical cyclotomic index is `4*p`.
  BHV therefore gives a primitive `q` with
  `4*p | q-( (X^2-1)/q )`, and the shifted-square equation adds
  `q=+/-1 (mod 5)`.  BHV alone does not control `v_q(H_m)`, and the direct
  application of Granville Theorem 3 has the incompatible hypothesis
  `c=2 (mod 4)`.  The Bennett--Walsh/Cohn repair below nevertheless excludes
  both exceptional shapes in the general Granville Corollary 5 and therefore
  supplies a primitive prime of odd exact valuation.  Every positive
  valuation can still occur in the complete local primitive/five-split
  packet, and an odd valuation is allowed by the split norm in `Q(sqrt 5)`.
  Thus the valuation gap is closed but the shifted-square branch is not.
  The exact source and quantifier audit is frozen in
  `FREY_PELL_CHEBYSHEV_PRIMITIVE_ODD_VALUATION_AUDIT.md`
- the exact scalar elimination inside that fixed-five residual.  The three
  norm/cross equations imply
  `X*v^2=H*s^2-s*u+1=H*s^2+r*v-1`, the inverse congruences
  `X*v^2=1 (mod s)` and `H*s^2=1 (mod v)`, and the complete gcd ledger
  `gcd(s,X)=gcd(v,H)=gcd(s,v)=gcd(r,u)=1`, with both same-factor gcds
  dividing two.  After fixing one ideal factor and reducing its totally
  positive generator by the norm-one unit action, the nonsquare target base
  gives natural coordinates `a=s>=1`, `a^2<X` and `b=-v>=0`.  The exact
  mixed equation then yields the pointwise square sandwich
  `X*b^2<a^2*H<X*(b+1)^2`, hence
  `b=floor(a*sqrt(H/X))`.  Lean kernel-checks the elimination, explicit
  Bezout certificates, parity gcd argument, `r<2*X`, and the integer
  sandwich, the strict real square-root interval and the exact natural-floor
  identity.  Only the unit-orbit normalization which supplies the reduced
  representative remains a paper-level interface.  This makes each fixed
  `(X,p)` a finite exact check but supplies no uniform bound on either
  parameter
- the exact odd-Chebyshev quotient ledger and its first new interaction with
  the fixed-five residual.  For every `m>=0`, Lean now defines the scalar
  quotient `H_m`, proves `T_(2*m+1)(X)=X*H_m(X)`, and kernel-checks
  `H_m(X)=(-1)^m*(2*m+1) (mod X^2)`,
  `gcd(X,H_m(X))=gcd(X,2*m+1)`, and
  `H_m(X)=1 (mod X^2-1)` (hence modulo eight for odd `X`).  In the ramified
  branch `X=5*A`, the square equation and the full `X^2` congruence sharpen
  the former first digit to
  `A*(-1)^m*(2*m+1)=1,6,or 11 (mod 25)`.  For `p=31` this leaves exactly
  `X=20,95,120 (mod 125)`.  The mixed equation also fixes the exact floor in
  one residue class modulo `X^2` away from five: the norm residual gives
  `gcd(r,X)|5`, so its quadratic derivative is a unit when `5` does not
  divide `X`.  All of these scalar statements and a strictness witness are
  kernel checked.  The local Hensel audit shows why this extra digit is still
  a necessary filter rather than a uniform contradiction
- the fourth-order odd-quotient lift.  If `p=2*m+1`, Lean now proves the exact
  coefficient identity
  `6*d_m=(-1)^(m+1)*p*(p^2-1)` and the congruence
  `H_m(X)=c_m+d_m*X^2 (mod X^4)`.  On the ramified branch `X=5*A`, put
  `E=4*A*c_m+1+100*d_m*A^3`.  The singular old class
  `A*c_m=6 (mod 25)` then forces
  `E mod 625` to lie in `{0,125,500}`.  At index `31` the complete third-digit
  filter leaves eleven classes modulo `625`, and the singular branch has only
  `X=620,1245,1870 (mod 3125)`; the corresponding index-`41` branch is
  `X=705,1330,1955 (mod 3125)`.  Lean checks the coefficient, fourth-order
  congruence, finite residue lists, and two witnesses showing that the third
  and fourth digits are genuinely stronger than the preceding truncated
  data.  The two nonsingular square branches still lift, and even the three
  singular classes remain locally compatible.  Thus this is a sharper
  necessary filter, not a uniform exclusion.  The all-depth no-go below
  shows that computing the `X^4` coefficient and further digits would only
  resolve more of the same local solution graph, not produce a pure
  five-adic contradiction
- the all-depth ramified-five no-go theorem for the actual quotient.  Put
  `F_m(A,z)=5*z^2-4*A*H_m(5*A)-1`.  If `5` does not divide `p=2*m+1`, then
  `F_m(A,z)=A*c_m-1 (mod 5)` and its `A`-slope is the unit `-4*c_m`.
  Lean kernel-checks the stronger exact digit formula
  `F_m(A+5^n*t,z)-F_m(A,z)=-4*5^n*t*c_m (mod 5^(n+1))` for every depth,
  as well as simultaneous CRT compatibility with
  `A=19 (mod 24)`, `z=1 (mod 24)` and the full equation modulo `24`.
  Standard simple-root Hensel therefore gives, for every `z in Z_5`, a
  unique `A in Z_5` solving the exact local equation.  Consequently no
  finite-depth sieve, nor even complete pure five-adic analysis, can empty
  this ramified branch.  This is a local no-go only: the Hensel point need
  not be an ordinary positive integer point and supplies neither a solution
  nor a counterexample to `abc`
- the moving-primitive/fundamental-Pell no-go beyond the fixed-five graph.
  Preserving either Lucas or Lehmer root ratio makes Granville's
  `c=2 (mod 4)` hypothesis contradict coprimality invariantly.  More
  decisively, for every fixed five-adic depth and every prescribed positive
  valuation at a moving primitive prime, a simultaneous squarefree sieve
  produces infinitely many genuine fundamental Pell bases satisfying all
  of the finite primitive-order, five-split, reciprocity and local target
  conditions.  The exact `p=41` witness has valuation one and a solution
  modulo `5^5`, while a nonsquare modulo seven proves that it has no global
  integer ordinate.  Lean checks the root-ratio contradictions, Pell
  template, modulo-24 square-shape restriction and the full finite witness;
  Dirichlet, Hensel, reciprocity and the two-linear-form squarefree sieve are
  explicit accepted interfaces.  This rules out the entire finite moving-q
  packet as a uniform closure method, not the shifted-square equation and
  not `abc`
- the Bennett--Walsh/Cohn elimination of both Granville square classes.
  Write `X=B*u^2` and realize `X=R_k` in the trace sequence of the fundamental
  unit for the squarefree kernel of `X^2-1`.  Bennett--Walsh Theorem 1.2 and
  Cohn's coefficient-one theorem exclude `H_p(X)=z^2`.  For
  `H_p(X)=p*z^2`, the cases `p|B` and `p∤B` are handled separately; the
  squarefree odd-multiple occurrence law and Bennett--Walsh Lemma 5.1 cover
  `B=1`, `B/p=1`, `p|d`, and arbitrary parity of `k`.  Granville Corollary 5
  at index `2*p` then gives a characteristic prime of odd exact multiplicity,
  and the discriminant-rank check makes it primitive.  Lean kernel-checks
  the combination relative to six transparent accepted-theorem interfaces;
  all seven material theorem reports contain only `propext`,
  `Classical.choice`, and `Quot.sound`.  The odd primitive valuation is a
  genuine uniform theorem for `p>=31, X>1`, but split-prime ideal allocation
  in `Q(sqrt 5)` still prevents a shifted-square contradiction
- a uniform, unconditional rank-two lower bound for the prime-index
  Chebyshev Jacobians.  For every odd prime `p != 3`, the two explicit
  half-divisors have descent squareclasses `[a-1]` and `[3*(a+1)]` in
  `Q(2^(1/p))^*/Q(2^(1/p))^(2)`.  The first is nonsquare at the unique
  dyadic place and the second has an odd valuation at a cofactor prime over
  `3`; their product is nonsquare for the same reason.  Since the defining
  odd-degree polynomial is irreducible, rational two-torsion vanishes, and
  these classes give `rank J_p(Q) >= 2`.  Exact Selmer computations give
  equality for `p=11,13`; for general `p` the missing reverse inclusion is
  now the explicit growing two-adic localization identity (5.7), with the
  possible `S`-class and Wieferich branches retained.  The uniform mod-5
  Coleman residue-disc argument is also isolated, but its global
  annihilating differential still requires that rank upper bound.  No GRH,
  BSD, Tate--Shafarevich finiteness, or abc input is used.  Lean checks the
  three displayed half-factor identities at `p=11,13,17`; the general
  descent and local-squareclass argument is cited at paper level
- the canonical exact splitting of the missing uniform Selmer upper bound.
  With `E=<[a-1],[3*(a+1)]>`, the odd-admissible `S`-unit quotient has a
  dyadic localization `lambda_U`, while the surviving `S`-class image has a
  connecting map `partial_C` after correction by `im(lambda_U)`.  The
  resulting short exact sequence gives
  `dim Sel_2(J_p)=2+dim ker(lambda_U)+dim ker(partial_C)`.  Thus the desired
  dimension two is exactly the simultaneous vanishing of these two kernels,
  not a consequence of the unique dyadic prime or of a dimension count.  In
  fact, under the precisely audited BSPT Hypotheses 5.2, the ordinary pure-
  field class group injects disjointly from `E`, giving
  `dim Sel_2(J_p)>=2+dim Cl(Q(2^(1/p)))[2]`.  Those hypotheses hold without
  a component-group calculation when `p` is non-Wieferich to base `2` and
  `ord_p(3)` is even; the complementary branches remain open.  This is an
  unconditional exact reduction and a conditional class-group no-go, not a
  uniform Selmer upper bound.  Lean checks only the scalar consequences;
  the descent, class-group and local Kummer statements are cited at paper
  level with their exact hypotheses
- the exact index-seventeen descent obstruction.  PARI/GP certifies
  `Cl(Q(2^(1/17)))=1`; the signature and four `S`-places therefore give a
  thirteen-dimensional `K(S,2)`.  Thirteen explicit `S`-supported classes
  are independently certified as a full basis by exhausting all `8191`
  nonempty squareclass products.  The norm kernel has dimension nine, and
  imposing the complete `Q_3` Kummer image leaves an eight-dimensional
  space `W_3`.  The remaining Selmer upper bound is now the single dyadic
  equality `ker(lambda_2)=<D_1,D_9>`; neither the official Magma descent
  implementations nor the present exact scripts prove it.  Independently,
  the exact Frobenius polynomial and root-ratio resultant at `67`, together
  with Chebyshev real multiplication, specialization, the central `[-1]`
  twist cocycle and the Rosati/Galois action, give geometric Neron--Severi
  rank eight but rational rank one.  Hence the available `rank<=8` does not
  satisfy quadratic Chabauty's strict `rank<8` condition.  This audit uses
  reproducible PARI, Magma and Sage certificates without GRH, BSD or `abc`,
  but it deliberately does not eliminate index `17`.  Lean checks the
  displayed half-factor and Frobenius coefficient ledgers only
- the superseding exact closure of prime Chebyshev index `17`.  Eight proved
  local divisor classes span the full eight-dimensional dyadic Kummer image;
  its intersection with the eight-dimensional odd-place survivor has
  dimension two and is exactly `<D_1,D_9>`.  The formerly omitted `Q_17` and
  real-place conditions are also checked, so the global 2-Selmer group has
  dimension two and the Jacobian has rank two.  A saturated modulo-5
  Coleman--Chabauty calculation then gives the complete rational-point list
  `{O,(-1,+/-1),(1,+/-3)}` and excludes every integral base `T>1`.  The
  finite-precision quartic factor is promoted to an exact local squareclass
  by a Hensel margin `616>34`.  Independent Magma and Sage reruns agree, and
  no GRH, BSD, `abc`, bounded search or conjectural rank input is used.  Lean
  checks the exact polynomial and scalar ledgers and keeps the external
  rational-point certificate as an explicit proposition
- the earlier odd-place descent at prime indices `19` and `23`.  For `p=19`,
  PARI/GP unconditionally certifies the pure-field class number one, and
  the explicit `S`-supported basis is independently deconditioned by a
  full squareclass-product check.  The global space has dimension fourteen,
  the norm kernel dimension ten, and the complete `Q_3` condition leaves
  the expected genus-nine space `W_19`; hence only the rank-seven dyadic
  quotient map remained at that stage.  At `p=23`, the earlier candidate
  ledger `17 -> 13 -> 11` is retained only as provenance; its former
  class-group gate is superseded by the unconditional target-disk
  certificate below.  Lean checks the scalar dimension ledgers and the
  exact half-factor/discriminant identities
- the superseding dyadic computation at prime Chebyshev index `19`.  Nine
  exact local divisor classes span the full nine-dimensional dyadic Kummer
  image, while their stack with the nine-dimensional odd-place survivor has
  rank fifteen.  Thus the dyadic quotient rank is six, not the previously
  targeted seven, and the global 2-Selmer group has dimension three.  The
  intersection is exactly `<D_1,D_9,E_extra>`, with the extra class supported
  away from both endpoint coordinates.  The pure-field class-number input is
  independently certified by PARI, all non-dyadic local conditions and the
  complete squareclass basis are checked, and an independent official Magma
  rerun reproduces the matrices and Hilbert pairings.  Consequently the
  Mordell--Weil rank is only known to be two or three: no finiteness of Sha,
  rank-three assertion, or rational-point classification is inferred from
  this Selmer computation.  Lean checks the horizontal polynomial identities
  and the exact scalar rank-nullity ledgers
- the superseding unconditional closure of prime Chebyshev index `19`, which
  bypasses the unresolved distinction between Mordell--Weil and Tate--Shafarevich
  origins of the extra Selmer class.  For
  `Gamma_2=<H_1,H_9>`, an exact implementation of Stoll's Selmer-saturation
  criterion proves that every rational point in the Pell residue disk
  `X in -4+32 Z_2` maps into `sat(Gamma_2)`.  The full shell computation uses
  all sixteen odd residues modulo `32` at depths `3,4,5`, verifies the local
  constancy thresholds `5,6,7`, and closes the infinite tail at equality in
  Stoll's Lemma 3.10.  The hyperelliptic negative branch is handled with the
  exact base-point correction `-i-2D_0=-i+4H_1`.  A characteristic-zero
  `Q_5` Coleman differential, defined by a unit minor of the two actual
  logarithms, is nonvanishing on all six residue disks and leaves only the
  five known rational points; the sixth local anchor is a non-rational
  Weierstrass point.  Consequently the target disk contains only
  `(-4,+/-512)`, so no integral base `T>1` occurs at index `19`.  Official
  Magma computations at precisions `4000` and `5000` have identical decisive
  output, and an independent Sage 10.9 rerun agrees.  The global extra-class
  representative is linked to the local one by exact square tests, and the
  finite-precision Coleman zeros are used only as stability evidence: exact
  annihilation is the algebraic unit-minor construction.  No GRH, BSD,
  finiteness of Sha, `abc`, bounded search, or conjectural rank input is used
- the superseding unconditional target-disk closure at prime Chebyshev index
  `23`.  For `K=Q(a)`, `a^23=2`, exact principal generators certify all
  `598492` degree-one prime ideals through norm `8928769` (the primes over
  `2` and `23` being handled separately).  The unconditional
  Brueggeman--Doud/Poitou explicit formula then proves `Cl(K)[2]=0`; it does
  not claim `Cl(K)=1`.  This makes the seventeen frozen `S`-unit
  squareclasses complete.  The exact norm and `Q_3` conditions reduce them
  through dimensions `17 -> 13 -> 11`, and the full dyadic Hilbert
  signatures inject that eleven-dimensional Selmer over-approximation.
  Stoll's complete shell recursion on the actual disk
  `T+1 in 8 Z_2`, followed by the `Q_5` Coleman unit-minor argument, gives
  the integral target-disk implication
  `(T+1)%8=0` and `y^2=4*T_23(T)+5` only if `T=-1` or `T=1`.
  Since `T=23 (mod 24)` lies in this disk, no such Pell-relevant base
  `T>1` occurs at index `23`.  This is a pointwise theorem for that dyadic
  disk only: it does not classify the rest of the genus-eleven curve,
  treat another prime index, or prove `abc`.  Lean checks the polynomial
  and scalar consequences and exposes the external target-disk result as
  the transparent proposition
  `PARISageRationalTargetDiskCertificateIndexTwentyThree`; unconditionality
  comes from the frozen external certificate, not from a hidden Lean axiom
- the exact odd-index-to-prime-index quantifier bridge.  The Lean module
  `FreyPellChebyshevPrimeIndexReduction` proves that a hypothetical solution
  at any odd `k>1`, base `T>1` with `T=23 (mod 24)`, produces a solution at
  a prime divisor `p>=29` with cofactor `m` odd and new base
  `X=T_m(T)>1`, still `X=23 (mod 24)`.  The small-prime premise is derived
  explicitly from the eight frozen certificate interfaces at
  `3,5,7,11,13,17,19,23`; the formerly missing prime-19 target-disk
  proposition is now exposed in its Stoll--Gamma Lean companion.  The
  residue hypothesis is deliberately explicit: oddness of the base alone
  does not imply the class `23 (mod 24)`.  Supplying the separately frozen
  prime-29 proposition
  `PARISageRationalTargetDiskCertificateIndexTwentyNine` to the new Lean
  bridge first moves the active residual to
  `OddPrimeShiftSquareExclusionAtLeastThirtyOne`.  Supplying the separately
  frozen prime-31 proposition
  `PARISageRationalTargetDiskCertificateIndexThirtyOne` then uses the exact
  absence of a prime strictly between 31 and 37 to move it to
  `OddPrimeShiftSquareExclusionAtLeastThirtySeven`
- an accepted-literature audit of the remaining uniform prime-index family.
  No currently accepted theorem found in the fixed-curve, hyperelliptic
  integral-point, BHV primitive-divisor, modular/Frey, uniform Chabauty, or
  two-descent literature proves the required all-`p`, all-`X` exclusion.
  Moreover, no finite collection of congruence obstructions can do so:
  for every modulus `M`, bases `X=-1 (mod lcm(24,M))` and `y=1 (mod M)`
  are local solutions because odd `T_p(-1)=-1`.  After the fixed-index
  prime-31 closure below, the active residual named proposition
  `OddPrimeShiftSquareExclusionAtLeastThirtySeven` is a genuine new input,
  not a disguised published theorem.  Bilu--Tichy gives only fixed-`p`
  finiteness, Bérczes--Evertse--Győry gives a huge fixed-`p` effective height,
  and the one-point-at-infinity model fails the verified Runge inequalities.
  BHV/Granville plus Bennett--Walsh/Cohn supplies an odd-valuation primitive
  divisor, but a solution forces that prime to split in `Q(sqrt(5))`, where
  odd ideal exponents remain compatible.  The formerly proposed sufficient
  target--a primitive divisor with prescribed inert Frobenius--is now known to
  be false.  Exact recurrence and primality certificates at `(p,X)=(43,47)`
  give a quotient consisting of one prime congruent to `1 (mod 5)`, so there
  is no inert divisor at all.  The stronger exact example `(p,X)=(37,239)`
  has four prime factors, all split modulo five, while `X % 5 = 4`; thus merely
  restricting the uniform target to the three base classes allowed by the
  main equation modulo five does not repair it.  Neither example is a
  shifted-square solution, so these are counterexamples to a strategy, not to
  the residual equation or to `abc`.  If one keeps the full four-consecutive
  structure, the post-31 worst-index target is
  `(3*A*B+1)^37 > (b^2+3*b+1)^2`, whose critical squarefree-core scale is
  `A*B` of order `b^(4/37)`; available unconditional radical estimates do not
  reach this power scale.  The exact audit and trust boundary are frozen in
  `FREY_PELL_CHEBYSHEV_POST_P31_LITERATURE_AUDIT.md` and
  `FREY_PELL_CHEBYSHEV_PRESCRIBED_FROBENIUS_COUNTEREXAMPLE.md`
- a direct main-equation modulo-five sieve, with no primitive-divisor input.
  For prime `p>5`, Lean proves `T_p(X)=X (mod 5)`, so a shifted-square
  solution forces `X % 5` to lie in `{0,1,4}`.  In the ramified branch
  `X=5*u`, the exact first digit is
  `((-1)^m*(2*m+1)*u) % 5 = 1`; in particular `25` does not divide `X`.
  Under the positive Pell residue conditions the same equation forces the
  Jacobi symbol `J(5|p)=1`, eliminating every ramified branch with
  `J(5|p)=-1`.  These are uniform necessary conditions, not a closure of the
  all-`p`, all-`X` residual
- a fixed-index `p=37` feasibility scout, now frozen as a complexity audit
  rather than the start of another prime-by-prime program.  The exact field
  has degree `37`, signature `(1,18)`, discriminant `2^36*37^37` and five
  relevant `S`-places.  Direct BDF scaling projects billions of prime ideals,
  weeks of computation and hundreds of gigabytes before the class-group gate;
  the present local/Stoll probes are discovery data, not a certificate.
  `P37_CHEBYSHEV_FIXED_INDEX_SCOUT.md` records the exact margins and the
  decision not to run this pipeline without a compact `Cl_S[2]=0` proof
- a fixed-index program at `p=29`, recorded separately in
  `P29_CHEBYSHEV_FIXED_INDEX_SCOUT.md`.  Exact field arithmetic gives
  signature `(1,14)` and `|S|=4`.  PARI 2.17.1 and Oscar/Hecke independently
  exposed
  generic unconditional certification bounds of
  `2660292872242387` and `2660292872242388`; both runs were manually stopped
  and explicitly record `CERTIFICATE_COMPLETED=false`.  Thus the tentative
  class number one was not promoted to a theorem by those runs.  Directly
  scaling the p=23 split-prime explicit formula was predicted to require roughly
  `1.5*10^9` records.  This generic barrier has now been bypassed at the
  generation stage by Belabas--Diaz y Diaz--Friedman Corollary 5.2.  A
  256-bit RealBall certificate with strict cutoff `T=40,000,000` has lower
  margin `0.603060850068841328...>0`, and therefore proves unconditionally
  that every prime ideal below that norm bound generates the full class
  group.  The complete factor base has 2,434,953 ideals: 2,434,529 of
  residue degree one and only 424 of higher residue degree.  The full
  16-shard producer run is now complete, and an independent exact verifier
  that constructs no BNF, class group, regulator, or unit group has proved a
  principal generator for every factor-base ideal.  Its exact residue-degree
  counts are `{1:2434529,2:406,4:14,7:4}`.  Therefore the BDF generation
  theorem and the principal-ideal certificate prove unconditionally
  `Cl(Q(2^(1/29)))=1`.  This is an accepted published theorem plus exact
  finite certificate, not a wholly kernel-formalized number-field proof.  The
  formula gate, full relation data, recovery provenance, frozen replay, and
  trust boundary are recorded in `P29_CL2_BDF_FACTORBASE_ROUTE.md`.
  Consequently `dim_F2 K(S,2)=19`.  The next exact certificate has also
  passed: nineteen explicitly supported squareclasses have combined detection
  rank 19, the norm and 3-adic conditions leave a fourteen-dimensional global
  over-approximation `W`, and an exact `14 x 18` dyadic Hilbert-signature
  matrix has rank 14.  Hence `W`, and therefore the actual 2-Selmer image,
  localizes injectively at 2.  This closes Stoll's first condition without
  trusting a provisional fundamental-unit computation; the source, runtime,
  exact matrix and trust ledger are in
  `P29_CHEBYSHEV_GLOBAL_DYADIC_CERTIFICATE.md`.  The complete Stoll recursion
  then checks all 48 shell representatives, with maxima `5,6,7` and the tail
  closing at equality in the fifth shell.  The frozen `Q_5` Coleman unit-minor
  computation has normalized logarithm rank two and is nonvanishing on all
  six residue disks.  The exact-lift, diskwise injectivity, endpoint scaling,
  and trust ledger are assembled in
  `P29_CHEBYSHEV_STOLL_COLEMAN_CLOSURE.md`.  They prove at the accepted
  published-theorem/frozen-computation interface that the target disk contains
  no integral base `T>1`; Lean checks the polynomial/model/scalar consequences
  while retaining the rational-point result as an explicit external
  proposition.  At that stage the active uniform residual started at odd
  primes `p>=31`; the prime-31 package below supersedes that boundary and
  moves it to `p>=37`.
  A separate historical paper-level alternative, superseded for proving
  `Cl(K)=1` by the BDF certificate above, shows that nonzero `Cl(K)[2]` would put a
  28- or 29-dimensional `G`-stable submodule in
  `Hom(Cl(N),F_2)`, where `N=Q(2^(1/29),zeta_29)`: the 29-point permutation
  module is `1` plus an irreducible 28-dimensional augmentation module, and
  splitting at 2 and 29 excludes the one-dimensional central quotient by a
  complete signed rational-quadratic squareclass check.  This still does not
  prove vanishing; it reduces the new arithmetic target to an independent
  upper bound `dim_F2 Cl(N)/2 < 28` or another exclusion of that augmentation
  constituent.  For `r_K=dim Cl(K)/2` the argument in fact amplifies to
  `dim Cl(N)/2 >= 28*r_K`, using the defect-zero block and semilinear descent
  to prevent independent characters from sharing one augmentation copy.
  The odd-denominator norm relations of Biasse--Fieker--Hofmann--Page do not
  close this bound: Proposition 3.7 counts a subfield-class-group copy for
  every relation term, while rank one of `N_C28` on the augmentation module
  forces at least 28 `K`-terms.  Thus the tempting upper bound with a single
  `Cl(K)` copy is invalid and is explicitly withdrawn.  The class-field,
  local-field, and norm-relation bridges are documented but not yet
  formalized in Lean.  The isolated finite fact
  `orderOf (2 : ZMod 29)=28` is now kernel checked in `P29FiniteCore.lean`,
  without `sorryAx` or a `native_decide` axiom; this does not formalize the
  missing bridges.  The new `P29BDFFactorbaseCore.lean` separately kernel
  checks the finite-group implication from a generating factor base whose
  classes are doubles (or zero) to vanishing two-torsion (or a trivial class
  group); it does not encode BDF as an axiom.  The 2026 Chavarri
  Villarello--Dahmen Lean certificate
  generator was also audited: its `p`-saturation layer assumes a previously
  certified full generating set, while its current `v1` generator enumerates
  the Minkowski factor base through the same `2.66029287224239e15` bound.
  It therefore cannot serve as a ready-made 2-primary shortcut without a new
  odd-cokernel or mod-2 generation theorem.  Finally, the strict prime-31 BDF
  threshold scan evaluates the complete formula, not only its degree-one
  lower sub-sum.  Its certified lower endpoint at `80,000,000` is
  `0.294405860175708454...>0`, so the prime ideals below that strict norm
  cutoff generate `Cl(Q(2^(1/31)))`.  A 16-shard certificate now supplies
  principal generators for all `4,668,356` such ideals, with independently
  reconstructed residue-degree counts `{1:4667696,2:600,3:60}`.  The exact
  verifier constructs no BNF, class group, regulator or unit group and checks
  complete interval coverage, splitting, ideal membership and resultant
  norms.  It was rerun during an audited publish recovery and ended with
  `EXIT_CODE=0`; both earlier exit-1 ledgers and the generation-version GP
  range-guard syntax diagnostic remain frozen, while verifier-side range and
  completeness checks remove dependence on that skipped guard.  Consequently
  the BDF theorem plus finite certificate proves unconditionally, at the
  accepted-interface boundary, `Cl(Q(2^(1/31)))=1`.  This is not yet a wholly
  Lean-kernel number-field proof and does not by itself settle the index-31
  curve.  The exact scan is in `P31_CHEBYSHEV_BDF_THRESHOLD_SCAN.md`, and the
  principal certificate and trust ledger are in
  `P31_CL1_BDF_FACTORBASE_ROUTE.md`
- using that class-number-one certificate, a separate exact supported-
  squareclass certificate for `K=Q(2^(1/31))` is now frozen.  The signature is
  `(1,15)`, the primes in `S` above `{2,3,31}` have residue degrees
  `2:[1], 3:[1,30], 31:[1]`, and the standard S-unit exact sequence gives
  `dim_F2 K(S,2)=20`.  Twenty explicit representatives have norm support only
  in `S`; an independent Sage verifier which constructs no BNF, class group,
  unit group or regulator gives combined exact norm/3-adic/dyadic Hilbert
  detection rank 20.  Hence they form a basis of `K(S,2)`.  The 19-file
  manifest rechecks both this packet and the preceding p31 class-number-one
  packet.  Applying the rational norm-square condition and the complete
  local Kummer condition at the two places above `3` gives a
  fifteen-dimensional over-approximation `W` with `32768` classes.  Exact
  Hilbert signatures against 33 dyadic test classes have rank fifteen on
  `W`, hence localization is injective on `W` (and therefore on the actual
  Selmer image contained in it); the two endpoint classes have dyadic rank
  two.  The formal rerun, failure ledger for the initially omitted
  `(-1)^15` endpoint sign, exact matrices and 9-file manifest are frozen in
  `P31_CHEBYSHEV_GLOBAL_DYADIC_CERTIFICATE.md`.  This closes the global-
  to-dyadic injectivity input at the accepted odd-degree descent/Sage-exact-
  arithmetic interface.  The subsequent formal precision-12000 Stoll run
  executes all 48 nodes in shells `m=3,4,5`.  Their initial residual
  valuations are respectively `12021`, `12018`, and `12015`; the minimum
  identity valuations are `9795`, `7419`, and `4017`, all above the immutable
  threshold `2000`.  Every terminal membership flag is false, the two
  terminal squareclasses fail direct membership, and the tail closes with
  equality `2*5-3=7`.  The negative branch is covered by the exact correction
  `4H1`.  Independently, the precision-120 `Q_5` Coleman calculation has
  normalized logarithm rank two, a unit minor of determinant `3 (mod 5)`,
  and a lifted differential reducing to numerator `1+x^13+x^14`, a unit on
  all six residue disks.  Diskwise injectivity, rather than an unavailable
  `5>2g` global bound, leaves infinity, four rational endpoints, and one
  non-rational simple Weierstrass point.  Composing the Stoll saturation with
  Coleman annihilation proves that the dyadic target disk contains only the
  two points with `T=-1`; hence there is no Pell-relevant solution at index
  `31`.  The complete composition and trust ledger are frozen in
  `P31_CHEBYSHEV_STOLL_COLEMAN_CLOSURE.md`, with nested formal-Stoll and
  Coleman manifests and a separate outer closure manifest.  The independent
  Lean algebraic core kernel-checks the displayed `T_31` polynomial, the
  original/Coleman/monic coordinate scale, endpoint ordinates, BDF counts and
  dimension scalars.  Its Stoll--Gamma companion checks the copied shell,
  branch, saturation and Coleman scalar ledgers and exposes the rational-
  point result as the transparent external proposition
  `PARISageRationalTargetDiskCertificateIndexThirtyOne`; it introduces no
  external theorem as a Lean axiom.  This is an accepted-published-theorem
  and frozen-exact-computation closure of the fixed index, not a wholly
  kernel-formalized Stoll/Coleman proof and not a proof of `abc`
- a new uniform fixed-elliptic reconstruction of every remaining prime-index
  Chebyshev square.  Writing `U=(T+sqrt(T^2-1))^p` sends the equation to the
  fixed conductor-24 curve `Y^2=X*(X+1)*(X+4)`.  Translation by the rational
  half-point `H=(-2,-2)` gives the rational twist coordinate
  `x=-2*(y+1)/(y-1)` and, on the four-consecutive branch, the explicit point
  `(-2*(b+2)/(b+1), 2*a*r*s/(B^2*v^3))` on the `3*A*B` twist.  On the
  degree-one `X_0(24)` parametrization, the root coordinate is the modular
  unit `U=X/2` with divisor `2[1/12]-2[infinity]`.  Wohlfahrt's theorem and an
  exact CRT/perfectness argument show that every cyclic cover `z^p=U`,
  `p>=5`, is noncongruence; thus congruence modular-curve classifications do
  not close the problem.  The rational split branch is excluded by the exact
  rank-zero torsion group of the fixed curve.  The surviving statement is a
  modular-unit fundamental-unit `p`-th-power exclusion on moving quadratic
  twists; no audited accepted theorem currently has those quantifiers.  Lean
  checks the scalar curve, involution, translation and twist identities, not
  the modular parametrization or the uniform rational-point residual
- the exact arithmetic Leibniz--Wronskian bridge: compatible integer values
  divisible by the three powerful parts and having nonzero Wronskian imply
  `c <= rad(abc) * (|Da|/a + |Db|/b)`; the concrete free-prime-weight
  derivative satisfies the ordinary Leibniz rule and all required local
  divisibilities without storing a target estimate
- the projected powerful-part kernel identity and its exact nondegenerate
  lower bound `cost >= c/rad(abc)`, together with a powers-of-two/Mersenne
  family whose actual compatible nondegenerate normalized derivative cost is
  greater than `m/2`; the complementary paper calculation places the relaxed
  minimum in `[c/R,c/R+1]`
- the first-order multi-derivative classification: congruence compatibility
  modulo the powerful part of `c` already suffices for the Wronskian bound,
  two compatible value columns have an exterior minor divisible by one
  powerful-product, all three pairwise Wronskians are the same transverse
  scalar up to sign, and every triple of compatible value rows has zero
  third exterior determinant
- a genuinely second-order local energy
  `Gamma_x,y(n)=sum_p v_p(n)*((n/p)x_p)*((n/p)y_p)`, with square
  powerful-part divisibility, fourth-power divisibility of its two-direction
  Gram determinant, and the exact conditional jet identity
  `bc*Gamma_a+ac*Gamma_b-ab*Gamma_c=W^2` whenever both first and Hessian
  values respect `a+b=c`
- the exact straight second-jet diagonalization: on the first-compatible
  hyperplane, Hessian compatibility is equivalent to
  `c*(a*Ea+b*Eb-c*Ec)=a*b*(La-Lb)^2`; without imposing compatibility, the
  Hessian defect enters with the literal factor `abc`, so the global
  second-order quantity is the old transverse Wronskian squared rather than
  a second independent normal direction
- finite weighted Cauchy and the projected-lattice energy floor
  `(c/rad(abc))^2/(Omega(a)+Omega(b))`, including the one-empty-prime-block
  endpoint.  These are lower bounds on every nondegenerate integral straight
  jet, not an existence or small-zero theorem
- the integral least-zero audit for straight second jets: the explicit
  internal-coordinate chart and its Gram determinant (Lean for a
  three-prime block), together with the five-variable family
  `u1^2+u2^2-T^2*(v1^2+v2^2+v3^2)`.  For `T=2^k` this family has fixed
  determinant radical `2` but exact least nonzero negative-block energy
  `T^2`; hence dimension, signature, determinant square class, determinant
  radical, and the bad-prime set do not control a least integral zero
- the full straight-jet obstruction on the infinite Mersenne family
  `(1,2^m-1,2^m)`, `m>=3`: the exact moment equation, weighted Cauchy, and
  `Omega(2^m-1)<=m-1` force every arbitrary prime-coordinate real weight to
  vanish.  Lean proves the finite-coordinate theorem internally, not merely
  a block-constant specialization
- the exact radical-power-loss reduction for the same Mersenne endpoint.
  Writing `Q_m=(2^m-1)/rad(2^m-1)`, the order decomposition gives
  `Q_m=W_m*I_m` with `I_m|m`, where `W_m` is the product of the base-2
  Wieferich excesses at primes dividing `2^m-1`.  Hence endpoint abc is
  equivalent to `log W_m=o(m)`.  In the newer total-loss notation recorded at
  the top of this status file, Lean now verifies the finite radical identity,
  the required LTE/factorization lemmas, the lifting divisor, the exact finite
  order-block product, and the square-divisibility transfer
- an explicit order-level obstruction at `p=1093`: Lean proves
  `1093^2 | 2^364-1`, `1093^3` does not divide it, `1093` does not divide
  `364`, and the three maximal-proper-exponent residue checks.  The elementary
  combination `ord_1093(2)=364` remains stated and proved on paper
- the exact first-order-block formulation
  `W_m=prod_{d|m} E_d`, with two honest sufficient targets:
  cumulative first-occurrence mass `sum_{d<=X} log E_d=o(X)`, or a uniform
  block saving `log E_d=O(d^(1-delta))` for some `0<delta<=1`.  The newer Lean
  modules prove the exact finite product and the more flexible conditional
  passage `log E_d=o(phi(d)) -> log W_m=o(m)`, without assuming any of these
  asymptotic estimates
- arbitrary prime-power persistence under an index multiplier coprime to the
  prime, the literal p-adic size budget, and an explicit simple-root/square-
  lift certificate at `1093`.  Lean also constructs divisibility-monotone
  spike models used in the paper proof that a vanishing ordinary normalized
  Cesaro mean need not imply a pointwise bound
- the exact first-order lift calculation modulo `p^2`: Lean proves the
  Taylor remainder, the affine square-divisibility criterion, uniqueness of
  the Hensel correction class, and the base-two Fermat specialization.  The
  resulting conditional density `1/p` is exact when the base lift varies;
  it is not asserted for the fixed base two
- the exact odd-prime multiplicity-one calculation in every imprimitive
  cyclotomic tower step `d*p^j -> d*p^(j+1)`.  The full paper-level
  Moebius--LTE classification consequently gives
  `E_d=Phi_d(2)/rad(Phi_d(2))` and realizes the cumulative first-order mass
  as the powerful part of `lcm_{d<=X} Phi_d(2)`; the classification and lcm
  identity are not yet Lean theorems
- the exact polynomial discriminant of the integral Kummer binomial
  `T^n-A`, its honest prime-support implication, and the numerical tame
  boundary--different identity `g/n + (1-g/n) = 1` locally and over finite
  supports.  The actual local ramification and field-discriminant assembly
  are paper results, not yet Lean theorems
- the scalar truncated-SMT coefficient audit: for a fixed `epsilon`, one may
  select a single cover and allow its additive constant to depend arbitrarily
  on that cover, but the constant must remain uniform in all arithmetic
  points and varying supports; positive averages of complete tame
  boundary--different budgets retain coefficient one
- the exact Mason--Stothers specialization audit: the fixed polynomial
  tripod `T,1-T,-1` is sharp with radical degree two and specializes at
  `T=a/c`, after clearing denominators, to every primitive integer abc
  triple.  The corresponding uniform moving-section inequality is proved
  logically equivalent to `ABCConjecture`, not used as an input
- a translated integral family `1,T+n,T+n+1` with constant degrees and unit
  resultant but unbounded specialization multiplicity at `T=0`, together
  with an explicit coefficient/point-height evaluation loss
- both multiplicity and genuine reduced-support Riemann--Hurwitz bounds for a
  rational correspondence over the tripod.  If `r<=3` old reduced support
  points and `s` new reduced support points occur, then
  `3*d-(r+s)<=2*d-2`, hence `d-s<=1`; positive net gain forces
  `r=3`, `s=d-1`, and equality in Riemann--Hurwitz
- the bounded-shear scalar transfer on `(P1)^2`: rational height changes by a
  bounded multiplier loss, a finite candidate set escapes any finite fibre
  obstruction, and a hypothesized reduced-union surface truncated SMT with
  slope `epsilon/(2*(1+epsilon))` rearranges to the target `1+epsilon`
  coefficient.  The geometric exceptional-locus avoidance and support-union
  inclusion are proved on paper; the surface SMT itself is not assumed by
  the Lean module
- exact gcd/resultant separation for the sheared fourth form `c-u*a`, the
  quadratic re-encoding `(u-1)a^2+c(c-u*a)=b(c-(u-1)a)`, and primitive
  unbounded counterfamilies with one fixed radical, two adjacent radicals
  simultaneously equal to `2,1`, or three consecutive shears all squares
- the polyrelational Wronskian collapse: if a weighted derivative kills the
  fixed coefficients and respects several shear relations, every new
  powerful part divides the same source Wronskian, so a finite family gives
  only one LCM; the Wronskian of two remainders is exactly `(u-v)` times the
  same source normal
- a strict unbounded family for the fixed shears `2,3`: imposing
  `D(2)=D(3)=0` and both shear compatibilities forces the common source
  Wronskian to vanish.  The fixed resultant product estimate and its full
  constant are proved on paper; Lean verifies the common LCM and degeneracy
- the sharp scalar threshold: a coefficient `2-eta` four-form level-one
  inequality, after paying the elementary one-height cost of `c-u*a`, gives
  the desired coefficient `1/(1-eta)`.  The scalar rearrangement is proved;
  the four-form arithmetic inequality is not

These results are genuine components, numerical identities, and exact
reformulations.  They do not construct the rigid/Berkovich theta quotient or
tempered comparison, the genuine IUT III possible-image system, the IUT IV
global source estimate, a uniform S-unit/Vojta estimate, or the complete
boundary-ramification and global GenEll/Belyi height package.

## Claims retired by concrete counterexamples

- The map obtained from `r^ell=q` and `v |-> v^ell` is not the graph-direction
  degree-`ell` cover: on the normalized Tate skeleton it has degree one and its
  pointwise kernel is the angular group `mu_ell(K)`.  The associated Lean
  results remain useful as a cyclotomic/Kummer isogeny route.
- The complete global Frey `j`-height cannot replace the odd bad Tate
  q-divisor in the IUT IV component formula with a uniformly negligible
  conductor error.  For `(1,2^m,2^m+1)` the omitted packet exceeds twice the
  logarithmic radical, up to a positive constant.  This retires only the
  direct complete-packet substitution, not the source-faithful odd-q route.
- The Tate `K`-point quotient cannot itself be identified injectively with
  the valuation circle in characteristic zero: the nontrivial class of `-1`
  lies in the kernel.  This retires only the direct `K`-point equivalence; it
  does not refute the noninjective Berkovich retraction from an analytic space
  onto its skeleton.
- Literal Mason--Stothers transport by an ordinary derivation on `Z` or `Q`
  is impossible because every such relative derivation is zero.  Replacing it
  by the canonical `p`-derivation survives locally, but the family
  `n=2^(m+1)` strictly rules out every bound on its raw single-variable size
  that depends only on `rad(n)`.  These counterexamples do not rule out a
  three-variable arithmetic Wronskian with cross-prime cancellation.
- Pointwise finiteness for every separately fixed support does not imply a
  support-uniform linear height estimate: an explicit finite-fibre toy model
  has unbounded heights at singleton supports.  This is a quantifier
  countermodel only; it does not refute an actual uniform S-unit theorem.
- Iterating the universal tripod symmetries cannot turn one high S-unit
  solution into a large descendant family: the orbit has at most six points.
  Ordinary Euclidean descent can lower height, but already its first step on
  `(q+1,1,q+2)` leaves the old support, and its fully expanded chain acquires
  all primes up to the original height scale.  This retires those standard
  same-support descent mechanisms, not a new arithmetic bounded-additive
  descent valid for every current descendant.
- The exact global Pell/tripod/finite-orbit audit now sharpens this boundary.
  Choosing one favourable member of the six-point tripod orbit is equivalent
  to `ABCConjecture`, with only the universal additive loss `log 2`; likewise,
  the critical uniform radical bound for the actual Frey `j`-height is
  equivalent to `ABCConjecture` through the proved two-sided height corridor.
  There is also a bounded-fibre map from every primitive abc triple to the
  fixed split conic of primitive Pythagorean triples; the critical bound
  `2*log Z <= (1+epsilon)*log rad(X*Y*Z)+O_epsilon(1)` on that conic is again
  equivalent to `ABCConjecture`.  In the standard rational parameter it is
  exactly the coefficient-four truncated estimate for the six points
  `0,infinity,+-1,+-i`, so it is an exact reformulation rather than an accepted
  shortcut.
  A finite catalogue of fixed Pell orbits with uniformly bounded fibres and
  output logarithmic height `O(log c)` cannot encode all primitive triples:
  the endpoint family `(n,1,n+1)` has `N` sources but only `O(log N)` targets
  in those fixed height balls.  A second natural sufficient interface is the
  moving squarebase identity `A*u^2+B*v^2=C*w^2`; for `A*C>1` its quadratic
  field and norm coefficient move, while `A*C=1` is a split quadratic etale
  degeneration.  More precisely, writing `a=A*u^2`, `b=B*v^2`, `D=A*B` and
  dividing by the parity factor `delta=1` or `2` gives a primitive moving
  generalized-Pythagorean equation `X^2+D*Y^2=Z^2` with
  `rad(D*X*Y*Z)<=2*rad(abc)*c` and `Z>=c/2`.  The uniform critical radical
  bound over all squarefree `D` is again equivalent to `ABCConjecture`, by the
  exact rescaling `eta=epsilon/(2+epsilon)`; it is not a fixed-`D` theorem.
  Stewart--Yu's accepted unconditional theorem specializes uniformly to
  `2*log Z << R^(1/3)*(log R)^3`, for `R=rad(D*X*Y*Z)`, so the remaining gap
  is one of growth type rather than a missing numerical coefficient.
  Published `abc` exceptional-set bounds do not amplify either Pythagorean
  bridge to the full conjecture.  The fixed transfer sends source height `c`
  to target height comparable with `c^4`, while the entire squared primitive-
  Pythagorean locus has only `O(T^(1/2))` points through target height `T`;
  every currently applicable exceptional-set exponent is strictly above
  `1/2`.  The moving-`D` transfer likewise creates only boundedly many targets
  per source and worsens the direct counting exponent.  Infinite abc failures
  may also be arbitrarily lacunary, so a positive-power exceptional upper
  bound cannot imply finiteness.  The companion audit records the exact scalar
  inequalities and also rejects Carella's arXiv:2608.16764v2 construction at
  its first decisive estimate: an available summed error bound `O(h/u^6)` is
  treated as `O(h*rho(u))`, although `rho(u)=o(u^(-A))` for every fixed `A`.
  These statements retire finite fixed-Pell catalogues and hidden-coefficient
  bridges, not every possible arithmetic construction.  Lean checks the
  selector and Frey equivalences, both Pythagorean scalar/coefficient ledgers,
  primitivity transfer, and the squarebase scalar identities without assuming
  abc.
- Direct absorption cannot remove either a fixed positive multiple of
  `log rad`, a fixed positive power of the largest support prime in a
  logarithmic-height bound, or a product of two independently growing
  place-logarithms.  The endpoint families `(1,p,p+1)` and
  `(1,p*q,p*q+1)` make these losses explicit.  This retires only those
  residual constant shapes, not a refined Baker, Subspace-Theorem, or gap
  argument that first replaces them by tail-local costs.
- For the original displayed Frey discriminant, no uniform fifth-power lower
  bound in `c` exists; for the displayed rational 2-torsion quotient, no
  uniform sixth-power lower bound exists.  Explicit endpoint triples
  `(1,N,N+1)` prove both failures.  This retires only the two bare
  discriminant-size shortcuts, not a global modified-Szpiro estimate,
  Néron-conductor methods, or other isogeny-class constructions.
- The full rational degree-two isogeny graph does not rescue that shortcut.
  On the infinite endpoint family `a=1`, `b=c-1`, `c=256K+2`, each of the
  three quotient leaves has only its dual rational two-isogeny back to the
  centre, and every vertex has minimal discriminant at most `256*c^5`.
  The Lean module proves the displayed-model ceiling and strict sixth-power
  no-go; the exhaustion of the isogeny graph and passage to minimal models
  are currently paper proofs.  This does not retire modular/Faltings-height
  methods.
- Extracting larger powers, choosing finitely many residual primes, or
  putting generalized-Fermat coefficients in a fixed finite list does not by
  itself improve the Frey coefficient budget.  Exponent-one primes survive
  every modulus; with only odd residual primes, all power-of-two exponent
  layers survive as well.  This retires the factorization-only version, not
  a theorem exploiting the additive equation or higher congruence depth.
- Even the optimistic same-newform/product-of-distinct-ell/Sturm strategy
  first sees only the radical of the exponent product and pays for roughly
  `R*polylog R` candidate form orbits.  It is blind to smooth depth such as
  `2^k`, and bad-prime Hecke compatibility is an additional missing input.
  This paper coefficient audit does not rule out higher `ell^k` congruence
  ideals.
- Unweighted higher-torsion depth does not automatically accumulate over
  removed primes: a common congruence records the minimum local depth, not
  their sum, and repeated branches need a genuine transversality theorem
  before their lengths may be added.  The paper congruence-algebra model and
  the nonsplit Frey family with constant rational Tamagawa number strictly
  retire the unweighted congruence-ideal/Tamagawa strategy audited here, not
  all higher-torsion or all modular approaches.
- Formal arithmetic degree, Fitting ideals, or vertical intersection
  positivity alone cannot bound exponent excess by reduced support.  The
  canonical module is unbounded at fixed radical, distinct `p`- and
  `ell`-primary vertical supports are comaximal when `p!=ell`, and fixed
  unweighted congruence depth permits arbitrarily large `p`-weighted degree.
  These are general vertical countermodels, not counterexamples on the abc
  locus.
- A generic one-row Siegel or Minkowski theorem cannot supply the needed
  nondegenerate Wronskian vector: an explicit family has a norm-one
  degenerate kernel vector while every nondegenerate one has norm at least
  `H`.  In the actual powerful-part projection the first avoiding direction
  already has scale `c/rad(abc)`, so a sufficiently strong naked-lattice
  upper bound is an equivalent reformulation of abc rather than a cheap
  lemma.  This does not rule out extra arithmetic or adelic structure.
- Repeating the same first-order prime-weight derivative, taking exterior
  powers, randomizing weights, or optimizing entropy does not create several
  independent avoiding directions: after the degenerate scaling line is
  removed, the relaxed compatible value lattice has a rank-one quotient of
  exact spacing `c/rad(abc)`.  A sharp paper example `(8,1,9)` also shows that
  the two-column exterior minor need not contain the square of the
  powerful-product.  This retires these first-order repackagings, not the new
  second-order energy route.
- Straight Hessian compatibility does not create a second independent
  transverse direction: its exact global defect identity closes on `W^2`.
  Hence entropy, circle-method, or geometry-of-numbers arguments cannot
  construct an integral jet below the proved projected-lattice energy floor.
  This retires only claims of a free quadratic normal; it does not retire
  high-dimensional rational isotropy or a genuinely new arithmetic selector.
- There is no universal nondegenerate prime-dependent straight second-jet
  selector: the infinite Mersenne family forces all its real weights to zero.
  Nor can a general least-zero theorem depend only on coarse quadratic-form
  invariants, by the fixed-radical five-variable counterfamily.  These
  counterexamples do not retire mixed directions, controlled accelerations,
  or an argument that treats the anisotropic endpoint by a complementary
  arithmetic mechanism.
- Primitive-divisor existence, pairwise cyclotomic resultants, and
  cyclotomic discriminants do not by themselves control the multiplicity
  mass in `2^m-1`.  The order-level square at `1093` strictly refutes the
  shortcut that every primitive prime occurs only once.  This does not
  retire cyclotomic or p-adic methods capable of proving a genuinely
  subexponential total Wieferich excess.
- Ordinary Cesaro averaging of the repeatedly counted masses, monotonicity
  under divisibility, a fixed valuation ceiling `w_p<=B>1`, or the literal
  estimate `p^w<=2^d-1` do not imply the needed pointwise subexponential
  bound.  The spike model strictly refutes the average-to-pointwise shortcut;
  the fixed-ceiling and size arguments retain a positive linear coefficient.
  This leaves averages of the nonredundant first-order blocks and genuinely
  uniform varying-prime p-adic distribution estimates open.
- The exact `1/p` Hensel density obtained by varying the base cannot be
  specialized to the fixed base `2` by a standard large sieve.  An exponent
  sieve also sees every exceptional prime in the same order block through
  the identical condition `d|n`, so their multiplicity mass is perfectly
  correlated.  These quantifier barriers retire the naive base-average,
  exponent-sieve, and fixed-extension Chebotarev transfers, not a genuinely
  fixed-base weighted theorem.
- Cross-level cyclotomic resultants, polynomial discriminants and ordinary
  derivative gcds cannot detect the order-level excess: on paper
  `gcd(Phi_d(2),Phi'_d(2))=gcd(Phi_d(2),d)`, while `E_d` is coprime to the
  cyclotomic discriminant, and every later `p`-tower layer retains only one
  radical copy.  The explicit `p=1093,d=364` lift separates square contact
  at the literal base `2` from simple contact at an adjacent lift.  This
  retires these standard depth proxies, not a fixed-base singular-tail
  integrability or average squarefree-value theorem.
- Increasing the Fermat/Kummer degree alone cannot dilute the tame conductor
  coefficient below one: at every tame supported prime, normalized reduced
  boundary plus normalized different is exactly `log p`.  This retires only
  bare cover-degree averaging; a genuine bounded-degree truncated Vojta or
  second-main-theorem estimate on the lifted points remains viable.
- A product of correlated Kummer lifts cannot copy the height more than twice
  while paying one uniform counting/discriminant budget: any asserted
  inequality `k*h<=q+rho*h+C` with `k-rho>2` is contradicted by the unbounded
  family `(1,m,m+1)`.  A valid higher-dimensional theorem may put the whole
  correlated diagonal in its exceptional set.  Replacing the diagonal by a
  support-preserving tripod self-map also gives no infinite freedom:
  Riemann--Hurwitz forces degree one.  These statements do not refute a
  genuine truncated surface theorem outside its exceptional locus.
- Allowing new branch support in a rational tripod correspondence has net
  reduced-support gain at most one, with a rigid equality case.  This retires
  any claim that ordinary branching alone yields arbitrarily many free height
  copies.  It does not rule out a new arithmetic estimate showing unusually
  small radicals for the extra divisor values.
- Pairwise gcd/resultant separation for a fixed finite list of shears does
  not force radical growth.  Strict primitive families defeat one prescribed
  shear, two adjacent shears, and a uniform `2/3` radical gain from three
  consecutive shears simultaneously.  This retires resultant-only finite-
  shear arguments, not a growing candidate set or a genuine variable-prime
  truncation theorem.
- Adding finitely many fixed first-order shear relations does not add normal
  rank: all remainder determinants are scalar multiples of one Wronskian.
  Moreover the fixed pair `2,3` has an infinite primitive family on which
  coefficient killing plus simultaneous compatibility forces exact
  degeneracy.  This retires that universal fixed-shear selector, not adaptive
  parameters or controlled nonzero coefficient derivatives.
- Horizontal Mason degree, horizontal radical, bad-fibre support, and
  pairwise resultants do not control arithmetic specialization height: the
  unit-resultant family `1,T+2^m,T+2^m+1` has arbitrarily large intersection
  multiplicity at the fixed section.  This strictly retires coefficient-free
  or bad-fibre-only function-field-to-number-field bridges, not arithmetic
  deformation with a genuinely uniform moving-section theorem.

## New exact obstruction

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

At the IUT III scale layer, one common scalar cannot calibrate both concrete
labels `1` and `2`, since their log norms differ by the square factor four.
The unique pointwise calibration is `1/j^2`, and it preserves a separate
product formula after uniformly rescaling every place within one label.
The balanced tensor packet now proves that, once all labelled modules really
live over one common scalar ring, integer multiplication in any factor is the
same global scalar endomorphism and has the expected one-dimensional Haar
Jacobian.  What remains missing is precisely the source map placing the alien
rescaled AHS/untilt/Kummer/log-link objects into this common packet.  Indeed,
the fixed-place `1/j^2` copies cannot be embedded isometrically into one metric
packet while identifying a rational prime.  This is a no-go theorem for the
naive fixed-place isometric adapter, not a refutation of genuinely different
untilts or arithmetic holomorphic structures.

The 2026 eta-orbit audit makes the source boundary still more explicit.  The
literal public `LogVolumeData` carrier is uninhabited because its scaling law
is quantified over the empty set; a source-faithful continuation must first
use the honest finite-positive carrier.  After that repair, the smallest
substantive IUT III input is not an arbitrary same-volume quotient class but a
genuinely reachable anabelian output `S` whose one-action region has exactly
the native q-pilot volume and lies in the theta possible-image region.  Equality
of the associated one-dimensional eta maps then reduces formally to that one
volume equality, but no accepted theorem currently proves the genuine-output
existence.  Even such an eta witness would still leave the uniformly quantified
IUT IV estimate for the authentic selected odd q-divisor and corrected
ramification weights.

A strict audit of Joshi's Arithmetic Teichmuller Parts III--IV reaches the
same boundary and supplies several earlier source-level diagnostics.  The
Part III rule sending a product tuple to its pure tensor is called a linear
map, but is not additive already for two rational factors.  The later positive-
volume theorem infers containment of a full tensor lattice from containment of
distinguished points without proving independent-coordinate reachability or
module stability, and its printed Corollary 9.11.1.1 has a nonpositive left
side and positive right side.  Part IV additionally calls equality of two
Frobenius-shifted hull volumes a tautology, imports the IUT IV Step-(v) upper
bound without identifying its objects and normalization with the new locus,
and equates a positive normalized Tate-divisor degree with a negative sum of
local logarithms.  The claimed final Vojta theorem would have the correct
uniform quantifiers and would imply standard abc, but these source and
normalization interfaces are not proved by the cited accepted results.

## Not proved

- a concrete implementation of `AnabelianGeometry`
- a concrete implementation of `TemperedGeometry`
- actual admissible-prime data uniformly attached to every abc input
- actual orbicurve/core/cusp data in the intended anabelian geometry
- actual local theta-data and tempered comparison data
- actual Hodge-theater/Frobenioid/Kummer/log-link/multiradial output realization
- a coefficient-series/affinoid universal-property identification of the
  proved single-radius Laurent--Gauss completions, followed by the full
  compact Berkovich/adic spectrum and `q^Z` quotient (for Tate `q`, the proved
  scaling moves between different radius fibres rather than acting on one
  fixed fibre), theta-root `H^1` and divisor control, angular directions,
  deformation retraction, and tempered
  fundamental-group/skeleton comparison for the odd theta-root locus
- the genuine cross-label AHS/untilt and Ind1--Ind3 degree-line bridge
- the genuine Ind1--Ind3 possible-image/procession upper bound beyond the
  proved finite actual bad-place Haar/q-divisor identity and distinguished
  square-label procession slice; in particular, exhaustion by Theorem 3.11
  possible images and the full capsule product remain open
- Lean formalizations of the root-pullback and global-j-packet
  counterexamples recorded above (the valuation-circle kernel is formalized)
- a source-derived, uniformly quantified IUT IV q-height theorem
- scheme-level normality/properness consequences not already supplied by the
  `Proj` construction, the remaining root-of-unity branches above zero and
  the boundary fibres above one and infinity, their global ramification and
  different divisor assembly, and the noncritical Belyi/height package
- a scheme-level canonical-divisor/genus Riemann--Hurwitz theorem for the
  constructed Fermat `Proj`, normalized-height invariance under number-field
  extension, and a uniform truncated second-main-theorem estimate controlling
  the Fermat lifts' field discriminants and boundary counts; the numerical
  cover identities alone have coefficient ratio one and do not supply this
  estimate
- a quantitative rational S-unit/Baker/Subspace-Theorem estimate uniform as
  the prime support varies.  A concrete sufficient surviving target is a
  coefficient-one radical bound whose extra local cost is uniformly
  `g(p)=o(log p)`, equivalently a multiplicative-height envelope of the form
  `H <= C*rad*A^|S|*prod_p(1+log p)^B`.  The proved smooth/rough optimizer
  would absorb those entropy factors, but no actual arithmetic theorem of
  this form has been established; the unrestricted uniform tripod statement
  remains exactly equivalent to abc.  Equivalently, it would suffice to
  produce at least `c/(rad*A^|S|*prod_p(1+log p)^B)` same-support solutions
  from every high one, or a bounded additive descent that yields this count;
  none of the audited tripod, Euclidean, continued-fraction, or power maps
  supplies that anchor
- a nondegenerate small-weight theorem for the free-prime arithmetic
  derivative: one must impose `D(a)+D(b)=D(c)`, avoid the Wronskian hyperplane
  `a*D(b)-b*D(a)=0`, and control the resulting archimedean weight; the basic
  Siegel lemma may return only degenerate short vectors and is insufficient
  without exploiting the special abc coefficient structure
- a replacement for the now-refuted universal straight second-jet selector:
  either mixed multi-direction Hessians, accelerations carrying an additional
  arithmetic restriction rather than a free affine variable, or a separate
  endpoint mechanism for `(1,2^m-1,2^m)`.  Any viable construction must also
  beat the proved projected-lattice energy floor when a nondegenerate jet
  exists
- a uniform bound for the weighted base-2 Wieferich mass
  `W_m=prod_{p|2^m-1} p^(v_p(2^(p-1)-1)-1)`: for every `eta>0`, prove
  `W_m<=exp(eta*m)` for all sufficiently large `m`, or find a different
  treatment of the Mersenne endpoint.  The exact reduction shows that
  polynomial radical bounds, a merely polynomial or sub-full-exponential
  primitive factor, and layerwise resultant separation are quantitatively
  insufficient
- equivalently, prove one of the sharper nonredundant block estimates:
  `sum_{d<=X} log E_d=o(X)`, or a uniform power saving
  `log E_d=O(d^(1-delta))` for some `0<delta<=1`.  An average over `W_n`
  itself is insufficient; the mass must be assigned once, at its first
  multiplicative order.  A necessary first step is to prove that for every
  `eta>0` only finitely many order-level Wieferich primes satisfy
  `log p >= eta*ord_p(2)`, followed by a weighted bound for the remaining
  small-prime and higher-valuation layers.  The exact paper identity
  `E_d=Phi_d(2)/rad(Phi_d(2))` reformulates this as uniform integrability of
  the singular fixed section against varying exact torsion divisors, or as
  a sufficiently strong average squarefree-value theorem for `Phi_d(2)`;
  ordinary Bezout, discriminant and total-height estimates do not supply it
- a quantitative integral least-zero theorem for the compatible
  linear--quadratic second-jet system.  In the indefinite internal dimension
  at least five, Meyer's theorem gives a nonzero rational isotropic vector on
  paper, but clearing denominators has no subpower bound; the proved energy
  floor shows that any such bound must already control `c/rad(abc)`.  Such a
  theorem must retain the full integral lattice index or coefficient
  valuations: determinant radical and other coarse form invariants have been
  strictly ruled out
- the arithmetic realization refinements recorded only on paper for the
  Wronskian lattice: the exact `tau(n)` image subgroup and the relaxed Cramer
  upper bound.  The full arbitrary-weight Mersenne nonexistence theorem is
  now kernel-checked in its finite-coordinate moment form
- actual local Kummer extensions at the three Fermat boundary fibres,
  `e=n/gcd(n,m)`, tame different exponent `e-1`, unramifiedness outside
  `nabc`, the fixed-`n` wild bound, and their number-field discriminant
  assembly in Lean.  Even after these are built, the decisive missing input
  is the bounded-degree truncated Vojta inequality for the specifically
  chosen rational ample divisor `(K+D)/n^2`
- the reduced-union surface inequality on
  `((P1)^2, pr1^*{0,1,infinity}+pr2^*{0,1,infinity})` outside a proper
  exceptional set.  The bounded shear `(lambda,u*lambda)` avoids any one
  fixed proper exceptional locus and has paper-level support inclusion
  `supp <= supp(abc) union supp(u) union supp(c-u*a)`, but the required
  variable-prime level-one truncation is of Vojta/abc strength and is not a
  consequence of the standard fixed-place Schmidt or fixed-support S-unit
  theorem
- the coefficient-two level-one inequality for the four forms
  `a,b,c,c-u*a`, uniform in primitive points.  The quadratic identity at
  `u=2` shows why applying an abc estimate to obtain it is circular, while
  the explicit shear families show that standalone radical lower bounds for
  the new form cannot replace it
- a noncyclic polyrelational selector using either point-adaptive shear
  parameters with the complete resultant cost, controlled `D(u) != 0`
  correction terms, or an invariant genuinely independent of the common
  rank-one Wronskian
- a uniform arithmetic specialization theorem for moving sections of the
  fixed polynomial tripod.  Its most direct height-versus-truncated-
  intersection form has now been proved exactly equivalent to abc, so any
  surviving Mason/deformation route must add genuinely new arithmetic data
  rather than reuse the constant horizontal polynomial degrees
- a genuinely global Frey-locus upper bound for the now-explicit
  exponent-excess module, equivalently for the node-orbit module supplied by
  the odd `I_(2e)` fibers.  On the odd semistable Frey divisor it is
  `D_exc = (1/2)*D_Delta-D_N`; an estimate
  `D_exc <= (2+epsilon/2)*D_N+O_epsilon(1)` is exactly the
  `6+epsilon` discriminant-conductor slope.  Thus the missing step is a new
  global arithmetic theorem of Szpiro strength, not construction of the
  weighted finite module, the geometric node carrier, or a formal
  Fitting/Deligne identity.  Fixed-prime Tate fibers and the actual Frey
  family `(3^e,2,3^e+2)` rule out any per-place reduced-support-only upper
  bound.  Passing to the full rational two-torsion quotient does not weaken
  this missing theorem: if `E_plus` denotes the retained coarse invariant
  degree, then the exact paper identity is
  `E=2*E_plus+R_even`; controlling `E_plus` with the needed coefficient is
  another equivalent Szpiro-strength global input, not a quotient-theoretic
  consequence.  The four-branch description sharpens the same missing input
  to a cross-prime bound for the high-order congruences
  `J^2 congruent 4*I^3`: reduced GIT data sees only their support, whereas
  the required exponent-excess degree is their full contact multiplicity.
  A global stable-height-to-truncated-boundary estimate of the required
  strength is precisely the abc/Vojta step, and a branch-discriminant upper
  is precisely the slope-six step
- alternatively, a uniform arithmetic estimate for the exponent-one
  radical layer.  It is a common sub-support for every exponent-divisibility
  proxy; when only odd residual primes are admissible the permanent layer is
  larger and includes all power-of-two exponent depths
- a uniform modified-Szpiro estimate for the actual Frey height and an honest
  bridge to the minimal model and Néron conductor.  The current
  `freyDiscriminantConductor` is only the radical of a displayed
  discriminant.  Likewise, the checked rational quotient formula is not yet
  packaged as a characteristic-not-two degree-two elliptic-curve isogeny
  with kernel and extension across the affine exceptional points
- the actual rational two-isogenies, dual maps, endpoint graph exhaustion,
  and minimal-discriminant comparison in Lean
- the polynomial normalized modular-degree estimate on the Frey locus
  `delta_(1,N)/c_f^2 <= C_eta*N^(2+eta)`.  The modular-area normalization,
  optimal-to-displayed-curve isogeny seam, relative-to-stable direction,
  Petersson lower coefficient one, 2-adic local-factor loss, and logarithmic
  Faltings--`j` error have now all been audited.  Thus this bound is
  sufficient for, and of the missing `6+epsilon`/abc strength; it is not
  supplied by qualitative modularity, Manin-constant boundedness, the
  adjoint-L nonvanishing bound, GRH, or the known exponential modular-degree
  estimates
- the exact eventual-to-uniform quantifier gate for the modified-Szpiro
  route.  It is enough to prove the slope `6+6*epsilon` estimate for all Frey
  points above a threshold `H_epsilon` chosen uniformly before the point.  A
  single enlarged constant
  `max(C_epsilon,6*H_epsilon+log(4096))` absorbs every lower-height point via
  the unconditional Frey height corridor; no finite enumeration is needed.
  Lean then applies the already checked uniform modified-Szpiro implication
  to obtain `ABCConjecture`.  This removes a quantifier distraction but does
  not supply the eventual Szpiro-strength estimate itself; the mathematical
  proof and formal gate are in `FREY_EVENTUAL_MODIFIED_SZPIRO_GATE.md` and
  `FreyEventualModifiedSzpiroGate.lean`
- the radical-sensitive Frey period lower bound
  `Omega_E >= C_eta*rad(abc)^(-1/2-eta)`, or an adelic hypergeometric/Padé
  theorem strong enough to imply it while controlling every conjugate and
  nonmaximal-order index.  The audited AGM/Landen identities merely move the
  full height among real contraction, reciprocal conjugates and order
  conductors; the critical period bound is itself of Goldfeld/abc strength
- the pointwise Pell square-base estimate `log(y_n)=o(H_n)`, equivalently
  `log(A_n)>=(1-o(1))*H_n` for `c_n=A_n*y_n^2`.  Accepted radical,
  primitive-divisor, fixed-multiplier squareclass, Tatuzawa, class-number,
  ring-class and generic regulator results have now been checked with their
  exact quantifiers and stop at polynomial growth of `A_n`.  In the related
  four-consecutive unit-index reduction, Chebyshev index three is eliminated
  by the complete integral-point calculation on 216a1 and index five is
  eliminated by the complete two-cover/elliptic-Chabauty calculation above;
  indices seven, eleven, thirteen, seventeen, nineteen, twenty-three,
  twenty-nine and thirty-one are likewise eliminated by the exact or
  accepted-interface certificates above.  What remains is the
  prime-index statement that `4*T_p(X)+5` is not a square for every odd
  prime `p>=37` and every relevant composite-reduction base
  `X=T_(k/p)(T)>1` with `X=23 (mod 24)`, followed even then by a moving
  square-base radical estimate.  Restricting `X` to a first fundamental-unit
  coordinate would not cover composite odd indices.  Neither statement is
  assumed by the current formal package
- the matching uniform gate for a genuine abc disproof.  For adjacent triples
  `(1,b_n,b_n+1)`, put `H_n=log(b_n+1)` and
  `E_n=log(b_n*(b_n+1))-log(rad(b_n*(b_n+1)))`.  Lean proves that if the
  heights are unbounded and fixed constants `0<delta<1,K` satisfy
  `E_n >= (1+delta)*H_n-K` throughout a reindexed family, then
  `ABCConjecture` is false.  The proof chooses
  `epsilon=delta/(2*(1-delta))` and contradicts the uniform abc constant.
  No existing Pell, squarebase, four-consecutive or moving-`D` result proves
  this fixed positive excess: all audited bounds stop at the critical
  coefficient one.  Thus finite high-quality triples and individual prime
  certificates do not count as a disproof.  The exact gate and its trust
  ledger are in `ABC_COUNTEREXAMPLE_EXCESS_MASS_GATE.md` and
  `ABCCounterexampleExcessMassGate.lean`
- a global height/cancellation theorem for a non-torsion auxiliary selector.
  The local existence problem itself is now solved after degree at most two:
  CRT plus uniform torsion boundedness produces a bounded-abscissa point
  retaining arbitrarily large fractions of both exponent and radical mass.
  The adaptive pair-square construction lowers the selector squareclass to
  linear source size after sacrificing at most one third of the weighted
  support, but every fixed coefficient universe still has a strict linear
  conductor/discriminant obstruction.  Complete division-orbit averaging
  cannot improve the local-height/global-height ratio, and merely placing
  two independent points in one character space is also insufficient: the
  fixed-`D=6` Pell family has a uniformly positive integral height minimum.
  What remains is more precise.  One algebraic division branch can retain a
  full local identity packet while its canonical height scales by `m^(-2)`;
  in the rational two-division case its global Kummer line can privilege at
  most one of the three collision types.  Positive-rank membership in the
  required dual image is no longer a separate gap: doubling a shortest
  rational point lands in all three images at a universal factor-four height
  cost.  What remains is an abc-useful upper bound for that first integral
  minimum, a replacement on rank-zero curves, a favorable component/sign
  theorem, and control of branch discriminant, new conductor, places over
  `2`, and the archimedean sum with a subcritical coefficient.  Odd finite
  theta terms are already nonnegative and therefore are not the missing loss.
  A fixed-field Pell family shows that discriminant control alone is also
  insufficient: the entire deficit can be `-(1/12)*log b` at infinity, and a
  critical radical-scale lower bound for it is exactly the joint radical
  theorem for the two explicit consecutive order-three recurrence values.
  The four global two-torsion translates cannot cancel this deficit with a
  strict margin: their missing mass reappears at good finite denominators and
  their Mordell--Weil Gram matrix has rank one.  Thus a successful
  continuation needs a genuinely different auxiliary motive with a new
  cross-motive inequality, or an independent proof of the critical Pell
  recurrence/archimedean estimate.
  Alternatively one needs a same-character
  Mordell--Weil lattice whose first integral successive minimum, not merely
  the real Gram eigenvalue in a chosen basis, is genuinely small.  The
  rational all-Frey formulation remains ruled out by `(1,8,9)`, and after
  strong BSD the alternative missing statement is the same half-slope
  regulator--Sha--Tamagawa bound
- `Nonempty UpstreamCertificate`
- parameter-free `abc_conjecture`

These are mathematical construction theorems, not missing record syntax.
`sorry`, `admit`, an unsourced or circular axiom, or an open theorem equivalent
to abc may not be used to mark them complete.  A transparent interface to a
precisely cited theorem already accepted in the literature is allowed under the
trust policy at the top of this file.

## 2026-09-01 cloud-integration checkpoint

The verified local continuation was rebased through remote `main` and merged
with the non-superseded arithmetic content of five cloud lines:

- `formalize/canonical-exponent-height-ledger-v29`;
- `formalize/cross-support-exponent-depth-v29`;
- `formalize/shared-support-affine-contact-v29`;
- `formalize/cross-endpoint-contact-depth-v29b`, including its v29b--v29i
  continuation history;
- `formalize/coprime-residue-product-core-v27`.

The combined modules now share the pre-existing `ABCPoint.endpointMin` and
`ABCPoint.largeEndpoint` definitions instead of redeclaring them.  Lean 4.32
compatibility repairs close anonymous sections correctly, make the natural to
real finite-product cast explicit, correct three contact-identity signs, expose
the nonnegativity premise needed by the reverse cubeful-tail comparison, and
replace brittle cancellation and normalization steps by checked arguments.
The default library build completes successfully with 9189 jobs.  The repaired
theorems' axiom audits contain no `sorryAx`.

The local closed-ray approximation bridge dated 2026-09-01 is also retained.
It proves that a correctly typed source-defined ordered hull approximant gives
the required scalar inequality, proves the elementary equivalence between
arbitrarily accurate approximation inside a real closed lower ray and
membership in that ray, and records exact counterexamples to fixed-tolerance
and uncalibrated qualitative-link variants.  It does not identify the global
Step (xi-f) hull with an approximant of the same input pilot.  The exponent-tail,
shared-support, contact-depth, and IUT source-level uniform estimates remain
open; no parameter-free abc theorem or abc counterexample is claimed.  See
`verification/2026_09_01_cloud_integration/VALIDATION.md`.
