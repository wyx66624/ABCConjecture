# Independent finite phase arithmetic and counting review

Reviewer: adversarial_audit. Date: 2026-09-07. Status: PASS for the
specified finite arithmetic, with the scope below. No eleventh-round
file was modified.

I read all 15 declarations and their proofs in
`2026_09_07_critical_bottleneck/twelfth_round/Lean/DeepRootPhaseArithmetic.lean`,
the complete preceding `ordinary_phase_formal_scope.md`, the complete
`verify_phase.py`, the manifest and all 44 recorded axiom outputs.
I independently recomputed source hashes, matched the complete theorem
and query sets, and required one output per query with only the three
standard axioms. I did not rerun the compiler; the fresh two-module
compilation is the author's recorded successful run.

- New source SHA256:
  `d001e6d61dfa6a9d98cdef75737cac15395033f2fd305ed5134d5326dce4a6c9`.
- Manifest SHA256:
  `38bee4489e359f194e22d1cbd899e116a80ec7ec00392075535c1c13135203d4`.
- Complete build/axiom log SHA256:
  `5663cd10fac32ee3fdcacfe03ef4f991b4651cb126c2cccd94c8b9ff4baf4687`.
- Inventory: 15 new plus 29 unchanged Eisenstein declarations, 44 unique
  complete queries. Axiom union: propext, Classical.choice, Quot.sound.
- Recorded compiler: Lean 4.32.0, commit
  `8c9756b28d64dab099da31a4c09229a9e6a2ef35`; pinned Mathlib
  `81a5d257c8e410db227a6665ed08f64fea08e997`, whose existing cache is reused.

The pair and conjugate-cross-product formulas use the actual existing
integer Eisenstein multiplication. The factor positivity is proved from
the phase equation and positive coordinates, so taking natAbs does not
silently identify opposite signs. The injection recovers the first
coordinate by cancellation of positive v and the second by cancellation
of the positive first factor. It is an actual injection of the given
finite pair set into Nat.divisors, not an injection supplied as a premise.
Diagonal pairs are retained. The positive constant excludes the empty
divisor convention at zero.

The block determinant bound, strict-modulus rigidity and 2500 B^4
constant bound have their domains explicitly proved. The latter bound
does not actually require gcd(u,v)=1, which is useful for the parent's
unreduced-coordinate counting bridge. The numerical repeated-pair example
is valid, but its theorem does not claim the example lies in a common
deep-prime set. The accompanying ordinary scope correctly makes that
distinction.

Still ordinary: finite norm-one torsion/lifting, divisibility derived from
same group image, divisor asymptotics, prime progression and sieve bounds,
all exceptional-set or signed-tail membership conclusions. The formal
rigidity theorem explicitly assumes its integer divisibility input.

## Parent's ordinary counting bridge

I also read in full
`2026_09_07_multiplicative_coherence/ordinary_count_bridge.md`, SHA256
`61e848a3d4158d901ce1e047920582b02fe76fcd56552774d942cd537ee3a7d0`.
Status: ordinary proof PASS; no claim that a later implementation has
already been reviewed.

The finite envelope D(N) over all 0<=k<=N exists, and only positive K
is used in a nonempty fiber. Choosing actual unreduced u=ab-1 and
v=a+b+1 is legitimate for factor positivity, divisor injection and the
height bound; reduction of the fraction is unnecessary. Empty fibers
contribute zero. Partitioning all ordered pairs by the finite product
image gives |S|^2<=|H|D(2500 B^4), including diagonal pairs. No group
laws on H are needed beyond the displayed operation, and the strict
same-image divisibility and target-cardinality interfaces remain explicit.
For positive n and q>6n^3, the fourth-power comparison is strict with
constants 1296>864. Taking square roots is restricted to nonnegative
quantities. This supplies a finite counting implication, not the analytic
or pointwise tail bound.

## Completed six-theorem counting implementation

I subsequently read all six declarations and proofs of
`2026_09_07_multiplicative_coherence/Lean/ActualDeepRootCount.lean`,
source SHA256
`06e2e8b5bbc7f0f3906de91964488bc6965a4b7fdb934a05c3b9823df41c9891`,
and the complete parent verifier. Status: source/scope PASS. I also
independently recomputed all three source hashes, complete theorem/query
sets and every recorded axiom output in the joint manifest:

- Joint inventory: 21 new (15 phase plus 6 count), 29 old, 50 unique queries.
- Manifest SHA256:
  `e5d218ca546c55d83402f6cc5adb3ad9ab6f8416adf9e876930318a47c5daff7`.
- Log SHA256:
  `1901ee10fa29c42e4062cceeeba546d81db9fc1e65de8001178b35496310a393`.
- All axiom outputs remain restricted to the same three standard axioms.

The actual finite supremum includes every K<=N, including N itself.
The nonempty image fiber chooses actual coordinates, derives positive
u,v without a coprimality assumption, then uses proved rigidity and the
actual divisor injection. Empty fibers are handled separately. The
finite sum partitions S.product S by every target element and yields
the square bound rather than assuming it. The Int/Nat coercion uses
positive B and K; the fourth-depth instantiation and final Real.sqrt
inequality follow from proved nonnegative bounds.

The names containing fourth_depth do not assert a hidden boundary
valuation theorem: q need not be prime in these finite signatures, and
the finite target size and same-image q^4-divisibility are explicit
premises. The actual finite-ring construction is still ordinary. The
finite target requires only Mul, Fintype and decidable equality, not
assumed associativity or commutativity. These facts agree with the
preceding ordinary proof. The author's fresh compilation is independently
audited here; no new compiler execution is claimed by this reviewer.
