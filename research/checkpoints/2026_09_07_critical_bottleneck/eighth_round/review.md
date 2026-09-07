# Eighth-round review ledger

I read `2026_09_07_adversarial_audit/eighth_round/cm_boundary_shadow.md`, CB1--CB3, in full. The ordinary argument passes independent review. At (-1,1), the actual Frey curve is Y^2=X^3+12rX; the displayed order-four automorphism proves its CM endomorphism directly. At split primes q congruent to seven modulo twelve, the quadratic-character terms cancel in opposite abscissas, yielding zero trace at both places. The actual positive primitive family (Lk-1,1) simultaneously preserves both norm power residues and any specified finite coefficient precision. Its mixed-seed and inverse-square conditions are actual polynomial facts. No modular-orbit membership, residual isomorphism or global power equation is inferred. The independently established no-coordinate-one square theorem excludes every pure even exponent in that family, while the affine-slice theorem gives effective finiteness across all pure exponents without purporting to classify the odd members.

`all_index_sieved_window.md`, AW1--AW2, passed final full independent review by adversarial_audit, recorded in `2026_09_07_adversarial_audit/eighth_round/all_index_window_review.md`. The Euler logarithmic series, theta partial-summation endpoints, constants below 15 and 3, floor in Z and all-index Markov quantifiers were all checked. It retains the actual root-block and finite-window scope and leaves the private upper tail and exceptional roots open.

Root subsequently read AW1--AW2 in full and independently confirmed the entire ordinary proof, including the large-prime Euler-factor count and the cancellation in the all-index endpoint. The self-contained transcription is `paper/all_index_sieved_window.tex`; it has been submitted for final transcription review and writes the normalization inside the actual finite mean explicitly.

## CB4--CB5: the global projective-image obstruction

I read the complete CB4--CB5 addition. Its ordinary proof passes independent review. I actually reopened Ellenberg's author-hosted original PDF, Theorem 3.14 and its displayed G_Q to PGL_2(F_p) target, and the current Pacetti--Villagra Torcomian version, Theorem 5.2, explicitly giving N_3=7. The degree-two actual curve has multiplicative reduction above an odd prime greater than three. The published large-image theorem therefore applies independently of a power decomposition.

Restriction to G_K gives a normal subgroup of index at most two, containing the perfect PSL_2(F_p). The elementary-unipotent commutator argument establishes perfectness at p>3. This image is nonsolvable. A characteristic-zero CM form is induced from a character of its imaginary quadratic field; an induced lattice reduces to a monomial representation. Its projective semisimplification is solvable, including the coincident-character case over the algebraic closure in odd characteristic. Scalar twists and coefficient embeddings do not change this obstruction. Thus all actual congruences to CM forms at p>7 are excluded by the full projective-image theorem, not just by the fact that the characteristic-zero actual curve lacks CM.

The pure branch's five fixed levels consequently leave the two non-CM orbits 288 and 576. The same CM exclusion also applies to varying-level and varying-weight branches, but does not reduce those larger spaces to those same two orbits. This distinction is explicit and correct. The earlier finite local shadows remain valid and do not refute this different global representation obstruction.

Primary sources personally opened for this review:

* https://people.math.wisc.edu/~ellenberg/A4B2Cp.pdf
* https://arxiv.org/html/2007.11486v3

## Final eighth-round transcriptions

The adversarial reviewer read `paper/all_index_sieved_window.tex` in full and approved the final transcription. The proof, constants, actual finite mean and open upper-tail scope match AW1--AW2.

I read `2026_09_07_adversarial_audit/eighth_round/paper/cm_boundary_shadow.tex` in full. CB1--CB5 pass final mathematical transcription review: the actual positive local shadows, the separate projective-image obstruction, restriction to the nonsolvable subgroup on G_K, induced CM residual solvability, and the two-orbit conclusion restricted to the pure fixed-level branch are all faithful to the reviewed ordinary proof. One harmless doubled comma in the displayed elementary commutator was reported to its owner for correction. No new mathematical gap was found.

## HB1--HB4 ordinary height budget

I read `2026_09_07_cm_image/pure_power_height_budget.md` in full. All four ordinary implications pass independent review under the explicitly retained BC support premise. At a split prime q at least seven, the Hasse bound gives |t_q|<q-1; the nonzero positive p-multiple q+1 plus or minus t_q is therefore less than 2q. The q=p case is separately immediate. The split support with 7 and 13 excluded gives Q at least 19. The monomial bound F<=13 H^4, strict p log(p/2)<T, and monotonicity argument for p<2T/log T at T>=exp(2) are correct, including the strict inequality 2 log z<z for z>=2. The conclusions are necessary lower point-height / upper exponent bounds conditional on this support, not an upper point-height bound.

## BT1--BT4 exact twist and support reduction

I read `2026_09_07_independent_route/eighth_round/boundary_twist_support.md` and its `replay_boundary_twist.py` in full. The ordinary argument and the comparison logic pass independent review. The rational-translation Gauss sum gives the quadratic coefficient twist at level dividing N m^2, with the conjugation matrix integral, its lower-right entry congruent to d modulo N, and v=u d^2 preserving the character. At common level 36864 the index is 73728 and the weight-two bound is 12288. Squaring the product over cosets removes the quadratic multiplier; holomorphy at every cusp and the identity factor give the stated strict contradiction to the level-one valence bound.

I actually reopened Milne's author text, Proposition 4.12 and Example 4.13, to verify that last input in its weight-2k convention: https://www.jmilne.org/math/CourseNotes/MF.pdf . The two eighth-root coefficient automorphisms and the discriminant +8/-8 residue characters match the Python comparison. The full coefficient arrays and the two independent PARI implementations are explicit exact-software dependencies. I did not perform a third GP rerun and do not describe this audit as such.

The complete CM exclusion plus the two exact twist identities makes every surviving pure-branch coefficient embedding a boundary twist. Restriction to G_K gives precisely the four listed quadratic characters; their ramification and the passage from an absolutely irreducible semisimplification to the full module are correctly retained. The resulting BC support and the height consequence are necessary conditions for every actual pure prime power, without asserting existence or exclusion of the remaining seeds. The fixed-p density is not made uniform in p.

## TS1--TS3 complete ordinary review

I read `2026_09_07_independent_route/eighth_round/torsion_support_refinement.md` in full. All three ordinary statements pass final independent review. I personally opened both local primary passages before reviewing the complete writeup:

* Darmon--Diamond--Taylor, Propositions 2.11(c) and 2.12(b), https://www.math.mcgill.ca/darmon/pub/Articles/Expository/05.DDT/paper.pdf .
* Boeckle, Section 1.3.1 and Exercise 1.30, https://math.uni.lu/wiese/galois/Boeckle-Luxemburg-Notes.pdf .

If p divides the actual quartic, the split completion is Q_p and the actual curve is multiplicative. Its Tate subcharacter, after the unramified quadratic twist, is F_p-valued. Existence of that character after coefficient extension descends by the kernel-of-linear-equations argument, contradicting the source's F_p supersingular irreducibility. No unsupported absolute-irreducibility strengthening is required. The good boundary curve is thus ordinary. Exactly one local Jordan--Holder character on each side is inertia-trivial, since omega is ramified while all the auxiliary characters are unramified. Its comparison gives the unit-root eigenvalue plus or minus one modulo p even when either extension splits. The unit root reduces to the integer good-reduction trace; this is a quotient-character calculation, not a two-dimensional unramified Frobenius trace at p.

Rational two-torsion makes that integer trace even, whereas the strict Hasse interval at p>7 leaves only the odd possibilities plus or minus one. This excludes p from the quartic support. For every remaining support prime the BC difference is a nonzero even p-multiple, giving 2p<=(sqrt(q)+1)^2 and hence q>p. The unconditional pure-power corollary correctly invokes the complete BT modular identification as a separate dependency. Its root and height lower bounds preserve their one-way scope, and all finite local shadows remain compatible with these global necessary conditions.

Final transcription approval: I subsequently read both `2026_09_07_independent_route/eighth_round/paper/boundary_twist_support.tex` and `paper/torsion_support_refinement.tex` completely. Both pass final independent mathematical transcription review. The common-level proof, complete-cutoff software dependencies, all coefficient embeddings, full boundary module, source-safe F_p scalar-extension argument, unique unramified Jordan--Holder character, exclusion of the exponent prime and the one-way height conclusions match the reviewed ordinary manuscripts. No mathematical correction was required; both owners were notified that these transcriptions can be frozen.

## Root BoundarySupportArithmetic: final signature and proof-scope audit

I read all ten theorem signatures and complete proof terms in `2026_09_07_cm_image/Lean/BoundarySupportArithmetic.lean`. The formal scope is faithful to HB/TS arithmetic. The strict Hasse interval, vanishing small divisible integer, even trace excluding unit residue classes, and doubling an odd divisor of an even integer are proved over actual integers. The cutoff theorem takes the exact disjunction of trace congruences as an explicit antecedent; it does not silently assert it for arbitrary seeds. The quartic sum identity, two polynomial height bounds and symmetric maximum bound concern the actual imported quartic. The final Nat-exponent pure-power height theorem retains p<Q as an explicit hypothesis, separate from the ordinary local/modular proof supplying it. No root-prime classification, local representation theorem, logarithmic inversion, or modular-form computation is claimed by these signatures. I found no scope mismatch. This was a full independent read of the source; the recorded fresh compilation was performed by root and the other reviewer, and is not claimed as my own additional rerun.
