# Independent review: residual collisions and annotated congruence lattices

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Reviewed `2026_09_07_critical_bottleneck/next_global_tail.md`, GC1--GC5,
and the subsequent annotated-lattice lemma communicated by its author.
The following are ordinary mathematics, separate from the second-round
manuscript seal and from every earlier Lean theorem count.

## Exact cancellation, including small primes

The boundary overlap identity needed for GC1 requires x primitive but does
not require its multiplier y to be primitive. Indeed, if p^e divides P(x),
exactly one of the three boundary coordinates is divisible by p. Modulo p^e,
x is consequently a unit multiple of an invertible rational scalar. Thus
P(yx) is congruent to that scalar cubed times P(y), up to sign. Truncated
p-adic valuations agree at every prime, including two and three.

For z_i=v_i H, take x=z_1 and y=v_2 bar(v_1). Then yx=N(v_1)z_2.
The primitive norm-boundary gcd implies gcd(P(z_1),N(v_1))=1, so this norm
scalar cancels exactly in the gcd. This proves the full equality in GC1.

If P(v_2 bar(v_1))=0, the cross element is an integer multiple of one of
the six units. Thus v_2 is a rational multiple of a unit times v_1.
For primitive integer coordinate pairs that rational multiplier must be
one or minus one, by reducing its numerator and denominator. This proves
the nonvanishing assertion for nonassociate residuals. The cubic identity
then gives the stated bound by (N(v_1)N(v_2))^(3/2).

## Duplicate depth and the signed remainder

At a fixed prime, sort e_1<=...<=e_K. The exponent in the product divided
by the least common multiple is sum_{i<K} e_i; the exponent in the product
of pairwise gcds is sum_{i<K}(K-i)e_i. This proves the divisibility in GC3.
Each log N(v_i) appears in exactly K-1 pairs, giving the displayed budget.

The signed identity in GC4 is exact prime by prime. In particular the
support-multiplicity credit E_Y^(-3) is retained, rather than replacing all
signed contributions by their positive parts. The nonowned full mass R_i(Y)
is nonnegative, and its sum is exactly log D_Y. This is the quantity to which
Markov can legitimately be applied. A small signed aggregate alone would
not justify such a conclusion about individual residuals.

The most-residual statement can be made simultaneous in every cutoff. Put

    delta=3(K-1)log B/(g log Q).

Use Markov on R_i(1), and note R_i(Y)<=R_i(1) for every Y>=1. If delta>0,
apart from a fraction at most sqrt(delta), all indices satisfy
R_i(Y)/t_i<=sqrt(delta) for every cutoff simultaneously. If delta=0 all
these contributions vanish. Hence K log B=o(g log Q) gives exactly the
claimed vanishing error on a proportion tending to one. This conclusion
does not bound the owner's maximum depth at any prime.

GC5 also holds for an arbitrary integer modulus q>B^3, not just a prime
power. In particular every prime p>B^3 has at most one supported residual
in a pairwise nonassociate family. The collision budget is zero in that
furthest range; the private-depth problem remains there in full.

## An actual boundary example separating maximal and repeated depth

Let w=2+zeta, v_1=1, v_2=1+5zeta, and g_k=2*5^k for k>=1.
The norms 7 and 31 are coprime; all products v_i w^g are primitive and
have nonzero boundary. At five the homogeneous step has rank d_5=2 and
first depth s_5=1, so

    v_5(P(w^g_k))=k+1.

The cross boundary is P(v_2)=30. GC1 therefore gives

    min(v_5(P(w^g_k)),v_5(P(v_2 w^g_k)))=1,

and hence the second valuation is exactly one. Both specified lambda
parameters tend to zero, while the maximal depth is unbounded and repeated
depth stays one. This is a strict obstruction to deriving a maximum-depth
bound from the collision budget. It is not a signed-tail counterexample:
the fixed prime five eventually lies below the moving cutoff.

## Annotated congruence lattice

Fix H=r+s*zeta and q=product p^e with p not dividing N(H). For each prime
choose one of the three boundary arms. Requiring that arm of vH to vanish
modulo p^e defines a rank-two integer lattice of index exactly q.

The multiplication matrix is [[r,-s],[s,r+s]], with determinant N(H),
and is invertible modulo p^e. Each arm row is unimodular. The local map to
Z/p^e is therefore onto; the two-coordinate Chinese remainder theorem
proves surjectivity onto the product over distinct primes. Its kernel has
the asserted index. Two independent vectors in this kernel have determinant
divisible by q, since their generated sublattice has index a multiple of q.

For v=(a,b),v'=(a',b'), the exact positive-definite identity is

    4N(v)N(v')-(2aa'+ab'+ba'+2bb')^2=3 det(v,v')^2.

Thus independent vectors satisfy N(v)N(v')>=3q^2/4. If both norms are at
most B and q>2B/sqrt(3), all such vectors are on a single rational line;
primitive integer vectors on that line form at most the pair plus/minus v.
This is a second-minimum statement. It does not give a lower bound for the
unique first minimum and therefore does not control a single private owner.

## A sharper linear threshold for common prime-power depth

The lattice union over the three arms at each prime has at most
2*3^omega(q) primitive integer vectors of norm at most B when
q>2B/sqrt(3) and gcd(q,N(H))=1. The full solution set is closed under the
six units, acting freely on nonzero vectors and preserving both the norm
and boundary divisibility. Therefore there are at most 3^(omega(q)-1)
unit-associate classes for q>1. In particular a specified prime power above
2B/sqrt(3) occurs in at most one class. This improves the earlier cubic
B^3 threshold for prime powers, though not the full common-divisor bound.

There is also a direct local proof. If a prime p divides both A_1 and A_2,
then p does not divide V_1V_2. Thus the cross element D=v_2 bar(v_1) is
primitive at p, and exactly one of its three boundary factors carries the
entire shared p-power. GC1 identifies that power as
p^min(v_p(A_1),v_p(A_2)). All three factors are nonzero for nonassociate
residuals. Each satisfies the sharp elementary bound

    3*(boundary factor)^2 <= 4*N(D)=4*V_1*V_2.

For coordinates a,b these inequalities are respectively the nonnegative
squares (a+2b)^2, (2a+b)^2, and (a-b)^2. Consequently

    p^min(v_p(A_1),v_p(A_2)) <= (2/sqrt(3))*sqrt(V_1*V_2).

This sharper packing is again a bound on common depth only. Above this
linear threshold a prime-power witness is private, so its maximal owner
depth remains outside the collision budget.

## Deterministic nonowner envelope, without an exceptional set

The preceding prime-power inequality yields a stronger positive conclusion.
Let X=2B/sqrt(3) and L_X=lcm(1,...,floor X). For a fixed residual i, any
nonowned prime p has another residual j with v_p(A_j)>=v_p(A_i). Hence
p^v_p(A_i)<=X. Since L_X contains every prime power at most X, the actual
nonowner integer satisfies

    product_{p supported by i but not owned by i} p^v_p(A_i) divides L_X.

Consequently R_i(Y)<=log L_X=psi(X) for every residual and every cutoff
simultaneously, independent of the number of residuals or the common factor.
Here psi is the usual sum of log p over prime powers up to X.

For completeness, an elementary estimate is psi(x)<=4x log 2<=3x for x>=1.
Every prime power in (n,2n] contributes one to the corresponding prime's
valuation in the central binomial coefficient: the relevant difference
floor(2n/p^j)-2floor(n/p^j) is one, and all other terms are nonnegative.
Therefore psi(2n)-psi(n)<=log binomial(2n,n)<=2n log 2. Sum over powers
of two and use monotonicity to get the stated bound. The interval 1<=x<2
is immediate, and log 2<=3/4 suffices for the last inequality.

It follows that R_i(Y)<=2sqrt(3)B<4B. For H=w^g and Q=N(w)>=7,

    R_i(Y)/t_i <= 8B/(g log Q),

for all members and all cutoffs, since t_i>=g log Q/2. Thus B=o(g log Q)
gives vanishing normalized nonowner mass for the entire bounded-norm family,
without the previous Markov exceptional set or any bound on its cardinality.
This is still only the nonowner part; the signed owner packet remains open.

## Independent source review of the fifteen-declaration Lean core

Read the actual `2026_09_07_residual_collisions/Lean/ResidualCollisions.lean`
after the five bound lemmas and three actual same-arm divisibility lemmas
were added. Final reviewed source SHA-256:
`9887fcba9924c858f56dbd376fd31529d8e57b60ab8b2aba1b64c5b763879dc0`.
Its fifteen declarations faithfully express the indicated integer statements.

The cross-residual theorem uses the real `Int.gcd`, the actual Eisenstein
pair multiplication and norm, and the prior boundary overlap theorem.
Only the first product is assumed primitive, which is sufficient for the
norm-scalar cancellation; the stronger second-primitivity condition was not
silently inserted into a proof of the weaker signature. Signs are handled
by the integer gcd itself. No free boundary or norm function is postulated.

The Gram identity and each linear-factor square identity are actual
coordinate identities. Their inequality consequences use the nonnegativity
of integer squares. `nonzero_divisor_square` uses the fact that a nonzero
integer multiplier has square at least one. The last theorem explicitly
retains both determinant nonvanishing and divisibility by q; negative q is
harmless because the conclusion uses its square, and q=0 is inconsistent
with those premises. It does not assume the desired norm bound.

The final three declarations prove actual same-arm determinant divisibility,
cancel N(H) under gcd(q,N(H))=1 after multiplication, and derive the
norm-product lower bound with nonzero determinant. They hold for every
integer q; no unneeded primality assumption is hidden. Their precise scope
is one specified arm for the whole modulus q. The general annotated lattice
with different arm choices at different primes, including its CRT index
computation, is still ordinary mathematics and is not claimed by these
single-arm signatures.

The file includes an axiom query for every theorem and contains no custom
axiom, sorry, or admit. Also checked the final fresh Lake verification
record: fifteen new collision declarations, twelve companion quartic
arithmetic declarations, and 52 original dependency declarations,
Lean 4.32.0, with only the three standard axioms. Its recorded source hash
was independently compared to the actual file bytes and matches the hash
above. This independent source review does not claim a formalization of
the lcm envelope, finite probability laws, entropy transfer, or private depth.

The companion finite replay checks the cancellation and nonassociation
claims directly on small integer pairs, modular examples of the exact-depth
family, and the exact indices of several annotated lattices. These checks
supplement the ordinary proofs and do not replace their universal arguments.
# Final third-round manuscript transcription review

Read the complete stable critical-agent
`third_round/paper/residual_collisions.tex`. Its GC1--GC9 transcription
passes independent mathematical review. The exact common-factor gcd
identity retains all prime-power multiplicities, and the pointwise
nonowner theorem uses only valuations shared with a maximal-depth owner.
No estimate for that owner's own private depth is inferred.

The annotated-lattice proof states the norm-coprimality, exact index,
rational independence, primitive-vector and specified-packet conditions.
The raw bound divided by six is valid because unit multiplication acts
freely on the full solution set and preserves norm and boundary divisibility.
The linear common-prime-power bound applies the one-arm property to the
cross element with unit norm modulo the common prime; it is not inferred
from the weaker total gcd bound alone.

For X=2B/sqrt(3), the nonowner integer divides lcm(1,...,floor X).
The elementary estimate psi(2m)-psi(m)<=log binomial(2m,m)<=2m log 2
is correct: in the valuation formula every level contributes a nonnegative
integer, and every prime power in (m,2m] contributes one. Dyadic summation
then gives psi(X)<4X log 2<=3X<4B. This yields a pointwise bound at every
residual and every cutoff, independent of the number of residuals. The
critical agent independently checked this last dyadic constant before the
final transcription was frozen.

The older average bound separately applies Markov only to nonnegative
nonowner full mass and uses one common good set for all cutoffs. The exact
five-adic family disproves only a maximal-depth inference; its fixed prime
eventually leaves the moving tail. Both the private owner depth and the
special-orbit transfer remain explicit open bottlenecks.
