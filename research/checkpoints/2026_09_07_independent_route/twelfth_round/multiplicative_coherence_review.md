# Independent review of MC1--MC4

Reviewer: independent_route. Complete ordinary proof PASS, including
the final lowered cutoff Y=6n^3. The full initial and strengthened
versions of
`research/checkpoints/2026_09_07_critical_bottleneck/twelfth_round/deep_root_multiplicative_coherence.md`
were actually read. The strengthened version was supplied with SHA-256
`3ec67af4b4b460cdb066228a57bbad044dca40582ae30a9cec9333a1824b4234`.

The norm-one torsion group modulo q^4 has at most 3n elements by
prime-to-q simple lifting in both split and inert cases. Equal pair
products force a determinant divisible by q^4; its actual integer
bound is 864B^3. The review proposed lowering the original q>B
threshold to q>6B^(3/4)=6n^3, since q^4>1296B^3 suffices. The final
proof explicitly implements this and also verifies q^2>6B+1 and q>n.

For a fixed positive rational phase u/v the identity
(va-u)(vb-u)=u^2+uv+v^2 has positive factors. A divisor determines
the ordered pair, including diagonal pairs. The phase height gives
K<=2500B^4, and the elementary divisor bound gives the stated actual
root-count bound sqrt(n) B^(2 epsilon), with constants uniform in q.
The proof does not substitute an abstract uniform residue measure
for actual roots.

The top-rank progression, the Brun--Titchmarsh endpoint, and the
epsilon=delta/16 computation all check. At the lower cutoff Y the
previously reviewed FM and EA estimates give mean O(log n/n), so
Markov uses eta=sqrt(log n/n). The final text correctly retains both
exceptional fractions eta and n^(-delta/2)/log n; it does not absorb
the larger second term into eta.

The proved interval has nonpositive signed cost without a small-full-mass
premise. Neither its negative credit nor the remaining far-tail cost is
bounded as needed for the global objective, and exceptional roots remain.
No new Lean build, finite replay, or primary-source download is claimed
by this ordinary review.

## Finite phase Lean source review

The entire source `DeepRootPhaseArithmetic.lean` (15 declarations),
SHA-256 `d001e6d61dfa6a9d98cdef75737cac15395033f2fd305ed5134d5326dce4a6c9`,
and `ordinary_phase_formal_scope.md` were subsequently actually read.
Full theorem-signature, proof and scope review PASS. In particular the
finite phase fiber cardinality bound derives an injection into the
actual `Nat.divisors` set from its positive factorization. The actual
integer block supplies the 864 B^3 determinant bound and hence the
large-modulus rigidity, and the positive phase bounds imply 2500 B^4.
The module's closed collision example does not assert deep-root
membership at a prime. Finite-ring divisibility is still an explicit
interface; norm-one torsion, the divisor asymptotic, Brun--Titchmarsh,
mean estimates and exceptional sets are not claimed formalized.
No independent compilation or extra axiom scan was run in this review;
the author's separately reported fresh build is not counted as ours.

## Actual finite root-count source review

The final source of root's ActualDeepRootCount.lean, containing six
declarations, was actually read in full, including its explicit
Finset.sup parameters. Full signature, proof and scope PASS. A
nonempty image fiber selects an actual pair for its positive integer
phase; reduction to lowest terms is not needed for the proved divisor
envelope. The actual finite fibers are then summed over the finite
target, deriving the squared root-count bound. The strict fourth-power
modulus comparison and the subsequent real square-root inequality are
proved in the source. Finite-ring divisibility and finite target size
remain explicit interfaces. This review does not count an independent
compilation, axiom scan, or proof of the ordinary torsion/sieve inputs.

## PN1--PN4 ordinary review

The complete ordinary note private_norm_support.md in critical's
twelfth-round directory was subsequently read. Full ordinary PASS.
The low norm-prime valuation count has its endpoint error O(B);
fixed-progression partial summation supplies the stated main term,
and the remaining norm mass yields the density bound. A prime above
12B is unique, has depth one, and is private in the whole actual
block. Its oriented ideal valuation proves actual multiplicative
independence.

The nu-tuple determinant has the displayed B^(2nu-1) height, so
precision 2nu and sufficiently large B force equality. Actual
independence then bounds each image fiber by nu!, with repeated
indices correctly permitted. The low and high depth-layer split,
actual total height cap, top-rank progression count, whole-block
normalization, and all fixed-nu constants are retained in PN3.
Markov and the private-prime density give the claimed 1/2-o(1)
domain. The larger unbounded signed tail remains a separate premise.
This reviewer did not newly download PN's PNT source or execute
its finite replay; the result recorded is complete ordinary review.
