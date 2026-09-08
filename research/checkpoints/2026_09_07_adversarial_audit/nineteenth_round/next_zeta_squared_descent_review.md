# ZD2.1--ZD2.6: full independent descent review

Reviewed source: `research/checkpoints/2026_09_07_independent_route/nineteenth_round/next_zeta_squared_two_descent.md`.

SHA256: `ecbd3ace69864dd32541157d013f82c6260fda2eac2274a54c839f967bb55d5a`.

Verdict: full ordinary proof PASS. I read all six sections, checked the complete chain independently, and opened the primary sources during this review. The proof establishes rank zero for this fixed Jacobian, not merely a condition on rational abscissas. It makes no new Lean, moving-family or ABC claim.

## Primary theorem audit

The precise odd-degree descent construction and its kernel were checked in Stoll, printed pp.250--251, construction before Lemma 4.1 and Lemmas 4.1 and 4.3. They provide the full Jacobian map, naturality and the branch-divisor evaluation formula. Lemma 4.4 gives the odd-local-prime quotient dimension; Lemma 4.8, printed p.254, gives the real image description. The manuscript uses their monic odd-degree setting and rational infinity point. It does not substitute the even-degree fake-descent map or restrict the kernel assertion to classes of rational curve points. [Stoll, original paper](https://www.impan.pl/shop/en/publication/transaction/download/product/83397).

Milne Theorems 4.3 and 5.1 were also actually checked: they give the ideal-class Minkowski bound and unit rank used here. No numerical class-group, regulator or analytic-rank output is needed. [Milne, Algebraic Number Theory](https://www.jmilne.org/math/CourseNotes/ANT.pdf).

## Checks specific to this curve

The substitution X=-3s, Y=9y produces the literal monic polynomial X(X-3)(X cubed-27X+27), with its one rational point at infinity. The etale algebra is Q times Q times K with T=(0,3,-3theta). The two branch images have the displayed signs: F'(0)=F'(3)=-81, so delta(D0)=(-1,-3,3theta) and delta(D3)=(3,-1,3(theta+1)). Norms are squares, as required. These are images of actual rational torsion classes.

The cubic h=U cubed-3U-1 is irreducible and totally real. Its discriminant is 81. A nontrivial integral index must have a factor 3, so the field discriminant would be at most 9; the resulting Minkowski bound at most 2/3 is impossible. Thus the order is maximal. The bound then equals two, and h mod2 is irreducible, so no ideal of norm two exists. Every ideal class is trivial. The shifted Eisenstein polynomial U cubed+3U squared-3 proves that there is one prime above three with e=3 and f=1. The element theta-1 has norm three and generates it.

The signatures of -1, theta and theta+1 are independent in three real signs. Unit rank two and torsion {1,-1} imply that these eight classes already exhaust units modulo squares. Thus every totally positive unit is square. This needs no assertion that the two displayed units are an integral fundamental basis.

## The full closed-point valuation argument

This is the part requiring more than a rational-point check. The polynomial discriminant is exactly 3^24: its two factor discriminants are 3^2 and 3^10 and their resultant is -3^6. For every ell different from three, all five roots split in a finite unramified extension with unit pairwise differences.

Take an arbitrary finite residue field E/Q_ell of a closed point in a moved divisor. Passing to its compositum with this unramified splitting field preserves normalized valuations on E. If x has negative valuation, all five factors have that valuation and 2v(y)=5v(x) forces it even. If x is integral, at most one factor is nonunit and its valuation is even because the full product is y squared.

For each component M of the etale algebra, the field factors of E tensor M are unramified over E; any further splitting extension is again unramified. The same parity therefore holds in each such factor before taking its norm to M. Norm valuations multiply by residue degree, retaining evenness. Negative divisor multiplicities also preserve parity. This covers every class of the local Jacobian via divisor moving and then every global class by naturality.

The reasoning is valid at ell=2. It asserts only even ideal valuations there, not that every resulting quadratic square class is unramified or that the displayed hyperelliptic equation has good reduction at two. No local condition at two has been silently replaced by either stronger assertion.

With the class group trivial, an arbitrary K-component, including denominators, is a unit times pi to exponent zero or one times a square. The two rational components similarly reduce to the four classes {1,-1,3,-3}. This derives the finite global class domain rather than assuming an S-unit representative.

## Three-adic matching and real elimination

The cubic remains irreducible over Q3, so F has exactly three irreducible factors there. Hence local two-torsion has dimension two. The local quotient by doubling has order four; the manuscript gives both the applicable cited formula and a correct direct proof using a small formal subgroup on which doubling is bijective. Lifting and uniquely halving the correction in that subgroup identifies the relevant kernel as well as the cokernel of the finite quotient.

The first coordinates -1 and 3 of the two torsion images are independent local square classes. Thus their images exhaust the entire four-element local image. The map from the four global rational classes to Q3 square classes is injective. This forces exactly the four paired global first-coordinate choices listed in ZD2.9, not independently chosen first and second coordinates. Multiplying by the corresponding actual global torsion image leaves (1,1,beta).

The norm condition now makes the single pi exponent even, because its norm has three-adic valuation one. The remaining K-component is a unit of norm one. The real roots have the exact order alpha1<0<alpha3<3<alpha2. Their three curve-interval evaluation patterns generate a four-element sign group in which only the identity has both rational-coordinate signs positive.

This restriction applies to all of J(R). A moved real divisor has real closed points giving the interval patterns and nonreal closed points whose conjugate-pair norms are positive at every real root. Products and inverse multiplicities stay in the same sign group. It follows that the remaining unit is totally positive and hence square. This proves that the global descent image has exactly four elements. The kernel is 2J(Q), and rational two-torsion already has order four, so finite generation forces rank zero.

## Point-set consequence and limits

The already independently replayed good-five and good-seven orders 12 and 52 give full rational torsion (2,2). Combining this separate finite input with rank zero identifies the whole rational Jacobian. I did not rerun that finite program in this review; my actual prior read-only replay and its hashes are recorded in `next_zeta_squared_review.md`.

The Abel map is injective. Its potential fourth torsion class would force R+O equivalent to the two finite rational branch points. That degree-two divisor is not canonical by the explicit pole basis {1,X}; Riemann--Roch gives a unique effective representative, excluding R+O. Thus H has precisely its three rational branch points.

The actual same-source inverse retains all three projective inputs 0,-1,infinity. Each has v=0 and two unramified second-square lifts w=2,-2, so the normalization has exactly six rational points. Their t values -2 and 0 are outside the positive domain. This closes the specified squared-unit cubic branch. Combining it with the other unit branches still requires the separately established actual unit extraction, as the manuscript explicitly says. Arbitrary residuals, ramified first norms, moving exponents and uniform height estimates remain outside this result.

No mathematical correction is required to the reviewed bytes. No new rank computation, global-generator assertion, saturation assumption or computational completeness oracle was used in this independent review.
