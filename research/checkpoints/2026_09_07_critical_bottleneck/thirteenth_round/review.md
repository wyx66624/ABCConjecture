# Thirteenth-round review ledger

UM1--UM4 received FULL ordinary PASS from root, adversarial_audit and
independent_route before the arithmetic formalization began. The
reviewed next-note was copied into uniform_moments.md; no twelfth-round
published source was changed.

UniformMomentArithmetic.lean contains fifteen declarations. The final
author run freshly compiled the source and executed all fifteen axiom
queries under Lean 4.32.0 and Mathlib
81a5d257c8e410db227a6665ed08f64fea08e997. The union consists only of
propext, Classical.choice and Quot.sound. No local dependency module
was rebuilt; the pinned compiled Mathlib cache was reused.
Source SHA256:
646308163a102479ea842b33b2f06eb8b1adf342e459f13cf8b4a51c597d1568.
Final validation SHA256:
a67a2119fdaa1b2faaee2c783d3903971ae41197410e55461ac9a5411226e047.
The real finite-layer and normalization statements retain their
explicit depth, cardinality, height and weight interfaces.

I independently read root's ordinary_private_valuation_multisets.md
in full: ordinary PASS. A commutative monoid and private integer-valued
homomorphisms with nonzero diagonal values suffice to recover all
multiset counts. Neither positivity of those values nor cancellation
in the source monoid is required. The actual product and stars-and-bars
construction preserve repeated indices. The natural subtraction
formula handles the empty index set and zero length correctly.

I then read root's PrivateValuationMultisets.lean, all eight
declarations and proofs, in full: source/scope PASS. Source SHA256:
0a28ed0c5ea812ba89c64b3dec801e86e83293dc9db8d6a99b9c7312ec4871f7.
The mapped multiset product is literal; its finite count grouping,
valuation evaluation and integer cancellation prove injectivity,
rather than assuming it. The actual Sym product and verified cardinality
give the stated choose bound. Modular rigidity and arithmetic
construction of valuations are still explicit inputs. I did not
repeat root's compiler run.

The adversarial next_multiplicative_matroid.md, NC1--NC3, was
independently read in full: ordinary PASS. The actual support graph
has the proved degree bound, including floor endpoints; greedy
coloring and nonzero ideal valuations prove independence in each
class. The full-block norm-mass argument gives the stated size for
fixed theta. The colors' full cost and the intermediate-depth layers
are retained. I requested an explicit comparison with MC: below
window exponent one half, MC already has density tending to one.
The colored-domain theorem is not a higher-coverage result in that
range. The smooth complementary set remains uncontrolled.

CL1--CL3, cubic_unit_local_gate.md, was read in full: ordinary PASS.
All four projective residue classes make E a unit. The S=T modulo
three case has C of valuation one, and after removing the square
factor nine the right side is minus a sixth power modulo three.
The other case has odd valuation. This covers infinity as well as
finite points of the smooth projective quotient. The projective
power-map factorization defines a nonconstant morphism to the cubic
curve, so the full Q_3 obstruction propagates to odd exponents
divisible by three. The identity-unit integral obstruction is
separately identified; neither nontrivial unit class is excluded.
I personally reopened Stacks tag 0BXX for the projective curve
extension statement. No rational-point or rank computation is claimed.

The expanded adversarial thirteenth-round colored_norm_support.md,
NC1--NC5, was then read in full: final ordinary PASS. Its all-x endpoint
is explicit, and its theta-uniform estimates keep a fixed positive
lower endpoint. Summing the uniform-moment ledger over the actual
colors yields the factor 80D without deleting any positive depth.
The logarithmic cutoff, whole-block Markov and the density
(5-kappa)/8 have the correct domains. The comparison with MC below
exponent one half, and the absence of a claimed endpoint comparison,
are now explicit.

EQ1--EQ3, elliptic_quotient_gate.md, was read in full: ordinary PASS.
I checked the even-sextic transformation, both degree-two coordinate
maps and both nonzero discriminants. The exact square criterion for
the first elliptic image treats s=-1, infinity, X=-2 and the excluded
double-discriminant point. Both doubling coordinates are exact.
For negative v_2(x), the numerator and denominator have unique least
valuations 4s and 2+3s, so repeated doubling supplies actual points
of infinite order. The resulting rank lower bound does not use the
software rank observations. I did not rerun its PARI or point search.
The extra common-source and real-domain conditions remain necessary.

Root and adversarial_audit independently read all fifteen final
UniformMomentArithmetic signatures and proofs, with full source/scope
PASS. Adversarial_audit also checked the final manifest and all fifteen
axiom log entries; this was a source/evidence review, not another
compiler run. The full finite excess and explicit prime/height/count
interfaces were retained in both reviews.

The final UM TeX received adversarial_audit full transcription PASS.
The only wording refinement explicitly states that q is prime and nu
is a positive integer in the multiset theorem. The final reviewed hash is
d87e28d3df6aa21dd825bfaf789998c98b19e653ce4d302dd3c508f9d8bd121c.

Independent_route subsequently read all fifteen final Lean signatures
and proofs and the entire final UM TeX, with full source/scope and
transcription PASS. Its separate record is
independent_route/thirteenth_round/uniform_moments_review.md.
This review did not repeat the author's fresh compiler execution.

I read all six CubicUnitLocalArithmetic declarations, their ordinary
scope and the author's build manifest. Full source/scope PASS. The
actual SHA256 ec5f2f2d1783d4c8c6a1d698c5b2f6555a95ef0d0af8dc14489e01a82e90147a
matches the manifest. The complete kernel-decided Fin 27 table is
transferred to arbitrary signed integer remainders, then to actual
divisibility and the Int.gcd=1 contradiction. The modulus-reduction
identity is stated for all integer moduli. The six recorded axiom
inventories contain only the standard three axioms, with the finite
table itself having no axioms. I did not independently rerun the
compiler. The local field, projective curve and all-exponent curve
morphisms remain ordinary, independently reviewed mathematics.

The complete CL and EQ TeX inputs were subsequently read in full:
final mathematical transcription PASS. Their SHA256 values are
21db28a8bbff2dc6eccc4eef1d0f9feff3b8794853cf74a54e103b2aebdc7c4e
and
3e4618fdd412eaea27f024cc2a77d5a4dbf763df07991520f5a858e4222fd950,
respectively. The local proof includes infinity, and the elliptic
image proof keeps all chart exceptions. The two-adic doubling proof
and the Jacobian rank lower bound remain independent of the finite
search. I did not independently rerun the bounded genus-two probe.

The expanded NC TeX was read in full: final transcription PASS at
SHA256 9eeeac82d4826301cf40cc68c604ebc921de1b15760bafa9332e1fb74a384ce2.
The actual degree bound and nonzero oriented witnesses, the complete
small-prime cutoff endpoint, the fixed theta range, all positive
depths in the factor 80D, and the whole-block Markov statements match
the reviewed ordinary proof. The comparison with MC and the
uncontrolled smooth complement and far tail remain explicit.

The final eight ActualUniformDepthBudget declarations were read in
full: source/scope PASS. SHA256
20a0b16f9b72aa11fe322bfad777090060ab415b915a2409d75eed63c5233af4
matches root's final 37-declaration manifest. The final three
connections derive the low and high symmetric-product count bounds
from private witnesses and explicit product rigidity. They then sum
the actual finite index depths, perform natural-number subtraction
before casting, and prove the weighted and normalized budgets.
The eight explicit axiom outputs use only the standard three axioms.
I did not repeat root's joint compiler execution. The supplied
arithmetic valuations, finite target construction, rigidity and
height cap remain explicit mathematical interfaces.

Both root manuscript inputs were read in full. Their mathematics
and research status match the reviewed source and ordinary proofs.
I requested two precise domain words in actual_private_depth_bridge:
the cap C is natural, and the paper's displayed moment is a positive
integer. The underlying Lean already has the correct natural domains.
The two clarified lines were then actually reread in the final file.
Final transcription PASS binds
actual_private_depth_bridge.tex at SHA256
935d66417edea27dfa5c12e5808770c862711bc51b1a28e4d14ee33ab401276e.
The complete thirteenth_research_status.tex also has final
transcription PASS at SHA256
161ac1f55af1092d6449d1cddd45fb969dedbe11c1c2469a758a64b9809f2d93.
