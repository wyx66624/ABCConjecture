# Independent review of quantitative Kummer covers

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read the complete independent-route `fifth_round/quantitative_kummer_covers.md`,
QC1--QC6 and its actual-height conclusion. The ordinary argument passes
independent review.

The reciprocal substitution gives the two quadratic discriminants d0
and bar d0, whose product is thirteen. Each is a nonsquare in Q(zeta)
by its norm, and thirteen is also a nonsquare there. The quadratic
square-class criterion then gives the asserted degree eight splitting
field. It contains the imaginary quadratic field under every embedding,
so its signature is (0,4) and its unit rank is three. At primes outside
117, simple roots of the reduced monic polynomial lift in an unramified
extension; this verifies the needed fixed-field unramified assertion.
No exponent-dependent cyclotomic extension is needed arithmetically.

QC2's norm-three and exact thirteen-adic boundary proof is correct.
For g>8 and g-free V, every residual ideal exponent outside 3 and 13
is exactly v_p(V), assigned to one of four factors at each of at most
eight primes over p. At thirteen the total depth is at most its
ramification index, hence at most eight and strictly below g. Therefore
the residual ideal product really is (V), not just an equality modulo
g-th powers. The bound 9^32 for all exceptional allocations is coarse
but valid. It is harmless that thirteen is also overcounted in omega(V).

For each ideal quadruple the four g-th root class choices number at
most H^4. Fixed integral representatives make the corresponding
principal generators depend only on these choices, g and V. Each
actual element differs by a unit and a g-th power. Ratios to the
fourth element require only three unit classes, giving the factor
w^3 g^9. Thus the bound C_K 4^(8 omega(V)) g^9 is for each fixed
pair (g,V), with all root norms Q included. The subsequent union over
V<=exp(Lg) explicitly adds exp(Lg), giving the coefficient 17 in
the combined exponent instead of silently reusing the fixed-V count.

The geometric degree and genus are as in the independently reviewed
four-branch descent. In particular the simultaneous poles have a
single diagonal inertia group. Counting these covers does not count
or bound their rational points uniformly as g varies.

For coefficient heights, at the four complex places the mean logarithm
of an integral ideal generator is log Norm(J)/8. Unit-lattice reduction
puts its deviation in a fixed bounded region. Multiplication by the
balancing unit preserves integrality, so the positive-part formula for
absolute Weil height gives the stated generator bound. Integral class
representatives have bounded norm; unit classes have representatives
with exponents in [0,g). These give h(xi_i)<=2 log V+C_K' g exactly
as claimed, with the linear term retained.

QC6 supplies a valid strict boundary for that linear term. If a
representative of [epsilon_1^floor(g/2)] differs by a g-th power of a
nonunit, some finite valuation has magnitude at least g. Applying the
height formula to the element or its inverse gives at least g log 2/8.
If it differs by a power of a unit, its first exponent coordinate has
magnitude at least g/3. On the fixed unit-logarithm space the Weil
height is a norm, giving another fixed positive multiple of g. These
classes are in the unrestricted generic unit list; no claim that they
have actual positive seeds is made. Thus a uniform o(g) normalization
of all unit classes is false, while point-compatibility filtering remains
an open possibility.

Finally F/c^4=1-u+u^2 for u=ab/c^2 in (0,1/4] gives precisely
13/16<=F/c^4<1. The actual rational-coordinate height is at least
(g log Q+log V)/4-log 2. This lower bound is not contradicted by a
linear coefficient-height upper bound or a subexponential number of
models; the text correctly retains the missing rational-point bound.

Independently opened the primary author-hosted
[Milne Algebraic Number Theory](https://www.jmilne.org/math/CourseNotes/ANT.pdf),
version 3.08, and located the class-number and unit-lattice chapters,
including Theorems 5.1 and 5.9. These standard inputs remain ordinary
external dependencies, not Lean-verified statements. The fixed field,
allocation count, height comparison, and scope distinctions were checked
separately above. No ABC conclusion is inferred.

Read the complete final `fifth_round/paper/quantitative_kummer_covers.tex`.
The QC1--QC6 transcription also passes. The fixed-field hypotheses,
the union cost for moving residuals, the generic nature of the unit-class
counterexample, and the absence of a uniform point-height conclusion
are all retained accurately in the manuscript version.
