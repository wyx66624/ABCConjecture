# Independent review of boundary-congruence prime support

Date: 2026-09-07. Read all BC1--BC3 in
`2026_09_07_independent_route/seventh_round/boundary_congruence_support.md`.
Result: ordinary proof PASS. Its premise is an actual residual-module
isomorphism, and it neither supplies that isomorphism nor a Frey--Mazur
theorem.

At q!=p dividing F, good reduction of E0 and the full module
isomorphism force the actual multiplicative Tate representation modulo
p to be unramified, hence p divides its parameter valuation. At q=p,
which splits whenever it divides F, the completion is Qp. Serre's
reviewed semistable weight formula gives the same divisibility from
the weight-two good-reduction boundary module. Scalar extension to
Fbar_p does not erase the extension class or change this weight.
All valuations of F are multiples of p and F>=13, proving a pure
integer p-th power with base greater than one.

The residual Frobenius trace at a multiplicative q!=p is plus or
minus(q+1). Its difference from the integer E0 trace is strictly
nonzero by Hasse and at most(sqrt(q)+1)^2. Divisibility by p therefore
gives q>=(sqrt(p)-1)^2. No trace claim at q=p is inserted. The exact
depth-one result excludes13; the two norm-seven traces give the
nonzero integer48 and exclude7 when p>7.

The GL2 count is exact. The set having eigenvalue1 has
(p-2)p(p+1)+p^2=p(p^2-2) elements. The analogous negative-eigenvalue
set has equal size and their intersection has p(p+1) elements. Thus
the union has p(2p^2-p-5), with denominator |GL2|=p(p-1)^2(p+1).
An independent direct enumeration of all matrices at seven primes
gave the following total-invertible/allowed counts:

|p|GL2 count|allowed count|
|---:|---:|---:|
|3|48|30|
|5|480|200|
|7|2016|602|
|11|13200|2486|
|13|26208|4160|
|17|78336|9452|
|19|123120|13262|

This enumeration also independently checked the two eigenvalue
counts and intersection. It supplements the all-prime counting proof.

Independently opened the primary Serre1972 PDF and actually viewed
its rendered printed259--260 using view_image. Assertion(7) explicitly
states eventual equality with the full mod-prime automorphism group
for a non-CM curve over a number field. The non-CM hypothesis and
the fixed curve/field scope are essential. Source:
https://www.college-de-france.fr/media/jean-pierre-serre/UPL5874918517843398173_Serre_proprie_te_s_galoisiennes_des_courbes_elliptiques.pdf

Independently opened Milne ANT Definition8.30 and Theorem8.31 at
https://www.jmilne.org/math/CourseNotes/ANT.pdf . They give natural
density among prime ideals ordered by norm. Chebotarev applies to
the conjugacy-invariant permitted set at each fixed full-image p.
Its density is exactly(2p^2-p-5)/((p-1)^2(p+1)). The note correctly
does not infer a bound uniform in the moving extension and cutoff,
or an obstruction to a polynomial value using only allowed primes.
No new Lean theorem is claimed.
# Final review of the quadratic-twist and whole-orbit additions

The updated BC1--BC4 manuscript was reread in full. PASS. A quadratic
character unramified outside the places over 6 changes no inertia at
q>3, including p>7. Hence it preserves the good/finite-flat local input
at p and the unramified Tate-parameter criterion at q≠p. Its Frobenius
sign is absorbed by the multiplicative splitting sign, so the original
trace-square equation and Hasse cutoff remain unchanged. The density
statement continues to use the single original E0 image and does not
need an image threshold uniform over varying twists.

The rational-prime density is delta_p/2: conjugate split places have
trace squares equal by the explicit two-isogeny and its quadratic
twist, each permitted split prime contributes two prime ideals, and
inert prime ideals of norm at most X number O(sqrt(X)). This is a
fixed-p natural-density conclusion, with no uniform error asserted.

BC4 correctly retains chi conjugation. An embedding of the identified
level-576 orbit can yield chi or chi^{-1}; cancellation gives the
quadratic character chi^sigma/chi in {1,psi_3|G_K}, rather than always
the untwisted module. Both cases satisfy the strengthened BC1 premise.
Compatibility/algebraic Frobenius identities establish the boundary
restrictions for all embeddings; the actual large-image theorem supplies
absolute irreducibility, so residual semisimplification loses no module
extension in this application. The conclusion V=1 for p-power-free
residual V is conditional on the actual residual congruence and BM's
independently reviewed ordinary plus exact-software identification.
It does not assert existence of that congruence or impossibility of the
pure branch.
