# Independent review of the quartic-square and parity geometry

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read `2026_09_07_independent_route/third_round/quartic_square_geometry.md`
in full, QG1--QG5. The substantive mathematics passes independent review.
The external elliptic-curve and Faltings inputs remain ordinary mathematics,
and no new Lean verification is claimed by this record.

## QG1--QG2: actual infinite positive square second norms

Checked both rational maps between y^2=F(x) and
Y^2=X^3-X^2-3X, including their exceptional denominators. Substituting
u=1-X/2 gives the quartic difference

    x^2/4 [X(X-4)x^2-6Xx-4X-3].

The specified Y is its quadratic completion and gives exactly the elliptic
equation. The maps are inverse on a nonempty open set. The quartic
discriminant and the distinct cubic roots ensure the stated smooth curves.

The explicit points P,2P,3P,4P were checked by the rational group formulas.
In particular 3P=(75,645), and 4P has X=361/144 and Y=2413/1728.
In the doubling formula, negative two-adic X valuation s gives numerator
valuation 4s and denominator valuation 2+3s, hence the new valuation s-2.
Starting at 4P proves infinite order without a rank table or finite search.

P lies on the real identity component X>=(1+sqrt(13))/2 together with
infinity. That compact connected one-dimensional real Lie group is a circle.
An infinite-order point generates a dense cyclic subgroup, and the inverse
map sends a neighborhood of 3P to positive x. The displayed inverse value
is x=101/355 and y=-192529/126025. Infinitely many distinct curve points
give infinitely many rational x, since each x has at most two y values.
Reducing x=a/b then gives an integer square: a rational number whose square
is the integer F(a,b) must itself be integral. Thus heights a+b are unbounded.

The actual square second norm yields an oriented exponent-two extraction
with unit residual and lambda_1=1/2. This supplies an infinite positive
family but does not reach the two-step sufficient threshold.

## QG3: explicit descent and complete rational point lists

The two-isogeny formulas, dual scaling by 1/4 and 1/8, and their composition
with multiplication by two are consistent with the displayed models. The
square-class homomorphism has the asserted kernel. For a nonzero square
target X=t^2 the inverse quadratic has discriminant (Y/t)^2, giving rational
preimages. At the exceptional target T=(0,0), membership in the dual image
is equivalent to b being a rational square; O always lies in the image.
The translation formula x(P+T)=b/x(P) handles lines through T in the
square-class homomorphism argument. Vertical lines give alpha(P)alpha(-P)=1.

For integral model coefficients, valuation comparison shows that each image
class is a signed squarefree divisor of b. Substitution x=dU^2/V^2 with
gcd(U,V)=1 gives the quartic covering equation. Its rational W is an
integer because its square is integral. These are necessary local conditions
for all nonexceptional points, while the exceptions have already been assigned.

For E_1 with a=2,b=-3, all four possible alpha classes are realized. The
dual has a=-4,b=16, admits only positive classes 1,2, and class two is
excluded by the three primitive parity residues 2,6,8 modulo sixteen.
For E_3 with a=6,b=-27, its four rational two-torsion points realize all
four classes. Its dual has a=-12,b=144. The exclusions for classes two
and six have respectively residues (2,14,8) and (6,2,8) modulo sixteen.
Class three forces divisibility of W by three; after division the expression
U^4-U^2V^2+V^4 is one modulo three unless both coordinates are divisible
by three. That contradicts primitivity. All these exclusions are correct.

The trivial dual image gives E/2E of order four in both cases. Since both
curves have four rational points of order dividing two, Mordell--Weil finite
generation gives rank zero. The reductions at five and seven have orders
(8,8) and (4,8), respectively, at genuinely good primes. Prime-to-p torsion
injections bound the full torsion orders by eight and four. The displayed
rational lists attain those bounds and are therefore complete. Finite point
counts are used only after rank zero has been established by descent.

Finally checked the substitution u=x+1/x, v=2u+3 and
t=4h(x+1)/x^2. It gives d t^2=(v^2-1)(v^2+3). For d=1 the resulting
elliptic X is v^2>=49; for d=3 the scaling (3X,9Y) gives E_3 X>=147.
Both contradict the complete lists. Thus neither N(x)F(x) nor its quotient
by three is a rational square for positive x. The b^6 homogenization factor
is itself a square, so the conclusion concerns actual primitive seeds.

This excludes the entire two-step even-exponent, unit-residual branch,
including moving roots, rather than merely proving finiteness. It does not
exclude odd extraction exponents or the general nonunit-residual route.

## QG4--QG5: fixed-class covers and the dynamic genus calculation

For QG4, the norm polynomial and quartic have discriminants -3 and 117.
Reduction of F modulo N is x^2 and their resultant is one. Their disjoint
simple root sets make their geometric square classes independent. The
connected degree-four cover has six finite branch points, each contributing
two to ramification; infinity is unramified. Riemann--Hurwitz therefore
gives genus three, and the rational square coordinates of an actual seed
are A/b and B/b^2. Each fixed twist has only finitely many seeds.

For QG5, the map r=x/(x^2+x+1) has exactly the two critical points 1,-1,
including the projective check at infinity and at its simple poles. Minus
one is fixed, the orbit of one remains positive and finite, and infinity
maps to the fixed point zero. Consequently infinity is not postcritical.
Every iterated inverse image of infinity is finite and unramified, and
distinct inverse levels are disjoint. This proves the asserted degrees,
simple roots and pairwise disjoint root sets of the polynomials f_j.

Their geometric square classes are independent. The degree 2^k cover has
2^(k+1)-2 finite branch points, each of contribution 2^(k-1), with no
branching at infinity. This gives

    G_k=1+2^(k-2)(2^(k+1)-6),

and in particular 0,3,21 at the first three levels. Homogenization multiplies
f_j(a/b) by b^(2^(j+1)), exactly the corresponding actual norm and with
a square multiplier. Thus the fixed-class finiteness statements concern
the actual mixed-transform sequence.

The primary [Faltings paper](https://math.uchicago.edu/~drinfeld/Deligne%27s_conjecture_Manin_conf/Faltings_argument/Faltings.pdf)
was independently opened and its Satz 7 on printed page 365 located.
This is an external finiteness theorem for the smooth projective curves;
no effective height bound or uniform bound over moving twists is inferred.

One quantifier clarification was requested: eventual departure from every
fixed finite product of square classes applies to a sequence whose heights
tend to infinity. A merely unbounded sequence may repeat a small seed; in
that case first pass to a subsequence with height tending to infinity.
The conclusion is joint departure of the class vector, not necessarily
departure of one specified coordinate along the full sequence.

The author was also asked to make integral model coefficients and the
exceptional-isogeny and rational-to-integer steps explicit. These clarify
the proof rather than change its conclusions. The moving-class and odd-
exponent branches, and the global ABC problem, remain open.

## Independent review of the twelve-declaration quartic Lean module

Read `2026_09_07_residual_collisions/Lean/QuarticTwistArithmetic.lean`
and checked its final source SHA-256 against the fresh verification inventory:
`00dc490f254853d87f478e7577a890cab265c529df79a1f4505ac9497bf042ee`.
The companion collision source also matches its recorded hash. The final
fresh Lake record has 27 new declarations, split as fifteen collision and
twelve quartic-arithmetic declarations, plus 52 original dependencies.
Only propext, Classical.choice, and Quot.sound occur in the axiom union.

The finite residue tables are connected to arbitrary integers explicitly.
For modulus sixteen, the proof uses the nonnegative integer remainder to
construct a Fin 16 value, and derives its parity condition from the actual
gcd(u,v)=1 hypothesis. It does not assume the required residue exclusion
as a hypothesis of the final no-square theorem. The three dual quartics
are exactly those in the ordinary two-isogeny descent.

For the fourth dual class, a square equal to the actual quartic must have
zero residue modulo three. The proof derives w=3k, divides the integer
equation, and applies the complete nonzero primitive residue table. The
gcd-to-modulus lemma works for its general integer modulus under the stated
nondivisibility-of-one condition. No positivity assumption on u,v,w is
needed for any of these universal integer exclusions.

The degree-eight `reciprocal_twist_identity` is the actual denominator-
cleared Q10 identity in the original two seed integers. The concrete
`actual_square_second_norm` is the genuine equality
F(101,355)=192529^2. These are correct arithmetic statements, not assertions
of the elliptic-curve rank or a generic square norm.

This scoped formal verification does not prove the elliptic isogeny/group
facts, rational point lists, Mordell--Weil theorem, real-density argument,
Faltings theorem, dynamic genus calculations, or the full nonsquare QG3
conclusion. Those ordinary dependencies remain visible. In particular, the
twelve arithmetic declarations are not described as a complete formalized
elliptic descent or as an ABC proof.

## Final manuscript transcription review

Read the complete stable `third_round/paper/quartic_square_geometry.tex`
from the independent-route checkpoint. The QG1--QG5 transcription passes.
The previously requested integral model coefficients, exceptional isogeny
points, rational-square-to-integer step, and height-tending-to-infinity
quantifier are all explicit in the final text. The even-exponent corollary
correctly includes square residual norms, which is slightly stronger than
the unit-residual special case: their combined norm would still be three
to the ramified exponent times a square.

The dynamic proof retains the absence of infinity from the postcritical
set, disjoint inverse levels, and the even-degree condition at infinity.
It does not assert uniformity over moving twists. The elliptic density
argument stays on the real identity component and the positive inverse-map
open set; no finite rank computation replaces infinite order.

Independently opened the primary author-hosted
[Milne text](https://www.jmilne.org/math/Books/EC2.pdf) and located Chapter II,
Corollary 4.2 on printed page 64 and the Chapter IV finite-basis statement
on printed page 105. They provide exactly the good-reduction torsion and
finite-generation inputs used here. The source does not supply the new
explicit descent, which was checked separately above.

The final TeX can be frozen for third-round rendering. Later fourth-power
or moving-class work should use new notes rather than changing this reviewed
manuscript version.
