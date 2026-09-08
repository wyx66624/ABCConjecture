# Root full independent review of ZD2.1--ZD2.6

PASS as an ordinary mathematical proof for the specified fixed curve.
Root actually read every paragraph of
`2026_09_07_independent_route/nineteenth_round/next_zeta_squared_two_descent.md`,
SHA256 `ecbd3ace69864dd32541157d013f82c6260fda2eac2274a54c839f967bb55d5a`.
This separate review upgrades the rank-zero condition in the earlier Z2
note by checking the new full descent. It does not rewrite the earlier
source, count finite reductions as a rank oracle, or claim a Lean proof.

## Model, global descent and cubic arithmetic

The actual substitution X=-3s, Y=9y gives the stated monic quintic;
its right side is exactly 81 times the original right side. The etale
algebra is Q x Q x K with alpha=-3theta. The odd-degree descent is on
the entire Jacobian and has exact kernel 2J. Root actually reopened
Stoll's construction and Lemmas 4.1 and 4.3, checking naturality, the
whole-divisor scope and the branch evaluation formula. The derivative
values are both -81 and the two displayed descent triples have the
correct signs. The norm kernel condition is explicitly retained.

The cubic polynomial has the three stated real root intervals and
discriminant 81. A nontrivial order index would give a field discriminant
at most nine and a Minkowski ideal-class bound below one, impossible
even for the identity class. The resulting maximal order is monogenic.
At two its irreducible cubic residue excludes norm-two ideals, so the
exact Minkowski bound two proves class number one. The Eisenstein shift
at three and the norm-three element give the unique prime and its actual
generator, with residue degree one.

The units -1, theta and theta+1 have independent sign vectors. Dirichlet
gives precisely dimension three modulo squares, making the full signature
map an isomorphism. This does not require an unproved integral fundamental
unit basis. Root actually opened Milne's Algebraic Number Theory,
Theorems 4.3 and 5.1, and checked the exact constant and unit rank used.

## All closed points, including the prime two

The discriminant calculation is exactly 3^24. For every other prime the
five roots are integral with unit differences in an unramified splitting
extension. The proof considers an arbitrary closed-point residue field E,
not just Q_p-rational affine points. With negative x valuation, odd degree
five and the square equation force every factor valuation to be even.
With integral x, at most one factor has positive valuation, again even.

The tensor factors for the etale algebra become unramified over E.
Further splitting is unramified too, so normalized valuations do not
acquire a misleading even ramification factor. Norms to each base
component multiply those even valuations by residue degrees, preserving
parity. This handles all integer divisor multiplicities, including
negative ones, and the moved-divisor representative of every class.
It is valid at two as well. It asserts even ideal valuations there,
not an unjustified good-reduction or unramified quadratic-extension claim.

Class number one then gives exactly the listed global square-class
representatives, with one possible odd exponent at the unique prime
above three. Arbitrary denominators are included by fractional ideals.

## The local image, real signs and the complete point list

The factorization over Q3 has three irreducible factors, so the rational
two-torsion dimension is two. The local quotient by doubling also has
order four, either by the explicitly explained compact formal subgroup
or Stoll Lemma 4.4. The first components -1 and 3 of the two actual
torsion images are independent Q3 square classes. Thus these images
exhaust the entire local quotient; knowing the torsion order alone
would not have sufficed.

Each global first component is one of four signed three-unit classes
and these inject into Q3 square classes. Matching a single rational
torsion element therefore trivializes both first components globally.
The remaining norm condition removes the unique three-prime exponent,
leaving an ordinary unit of K.

The real root order and all three allowed real intervals give exactly
the stated five-sign rows. The first two signs distinguish the four
elements they generate. Complex closed points contribute positive norms
at each real embedding, so the conclusion applies to all real divisor
classes and therefore all J(R). No restriction to rational curve points
is hidden in this step. A remaining image (1,1,u) forces u totally
positive, hence a square. The global quotient has exactly four elements.
Mordell--Weil and the two-torsion dimension then force rank zero.

The previously independently replayed good-prime orders 12 and 52
bound full rational torsion; they are used only after the rank argument.
The four-element rational Jacobian is therefore established. The
Abel--Jacobi injection and the one-dimensional Riemann--Roch space for
the sum of the two finite branch points exclude the fourth group element
from the curve image. The stated three rational points are complete.

At each of the three actual sources, A0 is homogeneously nonzero and
v=0; the second square has precisely the two simple roots +/-2. Every
rational point of the common-source normalization maps to this complete
first quotient. Thus there are exactly six rational points on this
specified D_(3,zeta^2), with t=0 or -2 and none in the positive domain.

## Scope and independently reopened primary sources

The result is an internally independently reviewed ordinary proof of
rank zero, the fixed rational locus and the specified same-source
boundary consequence. It does not supply arbitrary residuals,
ramification coverage, moving-exponent uniformity, or ABC. It is not a
formal construction of the Jacobian, descent map or rational-point
classification in Lean. Those formal dependencies remain work to do.

- Stoll, Acta Arith. 98 (2001), construction and Lemmas 4.1, 4.3,
  4.4, 4.8, printed pages 250--251 and 254:
  https://www.impan.pl/shop/en/publication/transaction/download/product/83397
- Milne, Algebraic Number Theory, Theorems 4.3 and 5.1, PDF pages
  72 and 87 (one-based): https://www.jmilne.org/math/CourseNotes/ANT.pdf
