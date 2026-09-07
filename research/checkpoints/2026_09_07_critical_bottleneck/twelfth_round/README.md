# Twelfth round: actual multiplicative coherence

The ordinary MC1--MC4 and PN1--PN4 proofs were each read in full by
root, independent_route and adversarial_audit, with ordinary PASS.
The candidate headers in their original notes are historical;
the final review status is recorded here and in review.md.
There is no proof or disproof of ABC in this checkpoint.

## Ordinary results and manuscript inputs

- deep_root_multiplicative_coherence.md and
  paper/deep_root_multiplicative_coherence.tex prove a bound on actual
  deep roots using finite torsion, a small integer determinant and
  positive divisor fibers. At prime n with B=n^4, the whole interval
  (6n^3, floor(B n^(1/2-delta))] has depth at most three on one
  explicitly bounded exceptional-set complement. Its signed cost is
  nonpositive; its full mass is not asserted negligible.
- private_norm_support.md and paper/private_norm_support.tex prove
  that at least one half of the actual block asymptotically has a
  private norm prime above 12B. These primes prove multiplicative
  independence on the actual subset. Fixed higher moments control
  complete positive excess to floor(B n^(1-1/nu-delta)), retaining
  the intermediate-depth costs as well as the deepest layers.
  Constants depend on fixed nu and delta.

Both manuscript inputs have independent full transcription review.
The later replacement of legacy cal commands by mathcal and a file-name
line-break hint are layout changes only. Current hashes are in
source_evidence.json. Existing sw, fml and ebi labels are used; the
fixed-progression primary source is linked directly in the PN paper.

The farther signed costs and all excluded roots remain open. The
proved subset is not a surrogate for all roots. Neither a small
full mass nor a positive proportion of compensating radical credit
is presumed for the enlarged window.

## Scoped Lean evidence

Lean/DeepRootPhaseArithmetic.lean contains fifteen declarations.
They prove actual Eisenstein pair coordinates, the conjugate cross
difference, positive divisor factorization, a genuine injection into
Nat.divisors, the finite fiber bound, actual block determinant bounds,
large-modulus rigidity and one closed pair collision.

verify_phase.py freshly compiled this module and the twenty-nine
listed Eisenstein source declarations under Lean 4.32.0 with pinned
Mathlib 81a5d257c8e410db227a6665ed08f64fea08e997. All forty-four axiom
queries ran, with only the standard three axioms. The compiled
Mathlib cache was reused. The evidence is
verification/phase_validation.json and verification/phase-lean.log.
The parser explicitly handles declarations requiring no axioms.

Root subsequently freshly compiled these fifteen plus six new
ActualDeepRootCount statements and all twenty-nine dependencies:
twenty-one new declarations and fifty complete axiom queries.
That independent checkpoint stores the combined manifest. I read
the six new signatures and proofs in full: source/scope PASS.
I did not describe that root compiler run as another run by me.

The finite-ring group-size and modular-divisibility interfaces remain
explicit. Torsion lifting, divisor asymptotics, the sieve, the private
norm density theorem and the analytic tails are not Lean claims here.

## Exact finite replay

Run with Python's standard library:

    python research/checkpoints/2026_09_07_critical_bottleneck/twelfth_round/replay_private_norm.py --check

The author actually ran --write and then the read-only --check.
adversarial_audit read the full source and independently ran --check,
with the same result. It checks:

- 3,522 complete factorizations of actual norms in seven specified
  complete blocks;
- 2,502 private split-prime witnesses, their depth one and their
  absence from every other norm in their block;
- 7,700 actual ordered pairs and triples on the specified private
  subsets, verifying exact phase fibers and their multinomial sizes.

The canonical payload SHA256 is
fcd8227dff68842b8feacef9a11281babc2594644b2a0ded2b968b1cd9b47f45.
The JSON file byte SHA256 is
42b72e6f95b1822f9bce3b708bcfdf5cc876641725a469d9f71365979955313a.
These two hashes measure different encodings and are not conflated.

This finite replay does not prove an asymptotic density, certify a
deep-boundary hit, replace the ideal proof or verify an unbounded tail.
No floating-point estimate enters its certified assertions.

## Independent reviews and subsequent work

review.md records this round's independent reviews of the rational
biquadratic locus, unramified Gaussian cover, hyperelliptic quotients,
denominator-sensitive phase fibers and the root finite-count bridge.
The geometric branch is not replaced by the analytic results.
Subsequent candidates beginning with next_ are outside this reviewed
publication inventory unless separately audited and explicitly added.
