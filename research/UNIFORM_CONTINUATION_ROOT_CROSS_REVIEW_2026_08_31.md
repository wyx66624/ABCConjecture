# Root mathematical and formal-scope review of the August 31 continuation

Reviewer: ChatGPT, coordinating agent. Date: 2026-08-31.

This is an internal independent-agent review, not external human peer
review. The mathematical arguments were written before their Lean
implementations. The review below does not certify an unconditional
proof or disproof of ABCConjecture.

## 1. Complete two-prime support

The root reviewer read Sections 2--4 of
`ANALYTIC_UNIFORM_GATE_2026_08_31.md` and all declarations and proofs in
`ABCTwoPrimeSupport20260831.lean`. The argument begins with the actual
prime-factor support of positive primitive a+b=c. Additivity of the
support cardinalities under coprimality forces an addend to be one;
when the other two entries exceed one, they are actual powers of
distinct primes. Consecutiveness makes exactly one base equal to two.

The integer geometric-sum lemma is valid with its written signs. An odd
integer divisor of a power of two has absolute value one. In its use in
the proof, the geometric cofactor cannot be minus one because its
product with the positive base difference equals a positive power of
two. Odd exponents in either ordering are therefore one. An even
exponent in the ordering q^v+1=2^u contradicts the residue modulo four.
For q^v=2^u+1 the factors q^(v/2)-1 and q^(v/2)+1 must be powers of two
at distance two, hence two and four. This gives precisely q=3,v=2,u=3.

The product radical in the formal statements is the unchanged
`abcRadical`, not a surrogate. The final inequality 2c≤3rad(abc) has
no assumed prime-power classification, no Catalan hypothesis and no
abc hypothesis. Its equality classification is correct. No conclusion
for three or more moving primes is inferred. All 22 named theorems
have the intended arithmetic scope.

## 2. Rational return and the exact arithmetic fibre

The actual-trace module was written by the root after the separate
proof note `TRACE_COVARIANT_RATIONAL_RETURN_PROOFS_2026_08_31.md`.
The arithmetic-geometry reviewer independently checked all seven
theorems and the note and reported no mandatory correction. It uses
`Algebra.trace`, `algebraMap` and `Module.finrank`. The weighted trace
balance retains both dimensions. Equal positive dimensions can be
cancelled in a characteristic-zero field even if their common integer
is divisible by the residue characteristic. A nonzero scalar input
returning to the scalar line forces the action on that entire line.
Valuation preservation additionally requires that the trace multiplier
has valuation zero. The zero multiplier is allowed only in statements
which do not impose that valuation condition.

The root also independently checked the arithmetic argument in the
analytic report's Section 4 and wrote
`ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md` before the fibre module.
Two odd coordinates determine the third endpoint. In one labelled
odd-part fibre, an even addend forces C>A+B, and an even sum forces
C<A+B. These parity types cannot coexist. Equality of the parity of
the first addend therefore determines the entire point. The resulting
map to Fin 2 is an explicit injection, and finiteness is proved before
the Nat.card bound is used. The two genuine points (4,3,7) and (1,6,7)
show that the bound is attained. The analytic agent independently read
all 18 fibre theorems and the proof note; its separate review records
the actual definitions and this non-vacuity check.

The logarithmic application still needs exact prime support, preservation
of the labelled odd-prime endpoints and pointwise rational return.
Membership in a common hull does not supply those hypotheses. Allowing
an arbitrary integral coefficient-unit map in addition to an identity
Galois map is a larger category than strict automorphisms with a fixed
Tate framing. The paper's sharpness example is asserted only in the
larger category.

## 3. The entire rational isogeny class

The root read the complete arithmetic-geometry report and the new
23-theorem Lean module, and independently checked the numerical and
geometric argument. The IUT agent separately reviewed Sections 3--7;
the analytic agent separately reviewed the module's actual objects.
Both written reports are retained.

The completed cyclic-degree classification was checked directly in
Balakrishnan and Mazur (2025), Theorem 2.2, printed page 239. The
new composite isogeny really has cyclic kernel of order 4ell: its
2-primary kernel has order four but only two elements killed by two.
This excludes all odd prime degrees except three for a curve with full
rational two-torsion. The argument does not replace a stable subgroup
by a rational generator.

A least-degree rational isogeny with given endpoints is cyclic, since
a noncyclic kernel would contain a full E[ell], permitting division of
the degree by ell^2. Uniqueness of the factor makes this factorization
descend over Q. Characteristic subgroups of a cyclic kernel then give
a rational prime-degree path. The claim is about the existence of a
path, not a factorization of every originally given map.

For c=1792n+2, n≥1, the actual curve reduces to y^2=x^3-x modulo seven.
The affine point counts are 1,1,0,0,2,2,1; including infinity gives eight
points. The Frobenius polynomial modulo three is T^2+1, so no rational
three-isogeny exists. The three two-isogeny neighbors have exactly one
nonzero rational two-torsion point, their dual edge. Odd-isogeny absence
transfers over the two-isogeny edges. Together with the prime-degree
path lemma this exhausts the entire rational isogeny class.

The displayed discriminant bound 256c^5 is valid for all four models.
For the lower minimal-discriminant bound, the zero-kernel model is
minimal at every odd discriminant prime, because c4 is a unit there.
Its retained odd part is (c-1)(c/2)^4≥c^5/32. No missing 2-adic
minimality computation is needed. The corresponding bounds
2c≤min|j|≤32c use the ordinary complex absolute value, not Weil height.
They follow from the actual c4 and discriminant formulas with positive
denominators. These facts refute only the specified attempt to recover
c^(6-o(1)) from a minimal discriminant by choosing an isogenous curve.
They supply no small-radical family and hence do not refute abc or Szpiro.

In Lean, the four-model indexing type is not declared to be an isogeny
class. Its genuine Weierstrass equations are identified with the prior
canonical Frey/quotient definitions. Its point count uses the actual
elliptic point type, not an artificially chosen finite type. Classification,
Frobenius interpretation and minimal-model theory are paper inputs.

## 4. The global arithmetic bundle and normalization calculations

The root read Sections 3--5 of
`IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md`, including the added
object-level descent corollary, and independently checked the main
calculations. The arithmetic-geometry agent separately recomputed all
normalizations and the complete ell=43 table in its written review.

On the stated actual Galois field K, the fractional ideal assigning
eta_j to every prime over p gives a genuine projective bundle of rank
N_j. With fixed ambient Hermitian metrics, its normalized degree per
rank is -eta_j log(p)/e. The finite unit-ball norm of the section 1
is q_w^(eta_j), fixing the sign. Independence of section follows from
the product formula with the stated complex multiplicity two.

The local Haar volume is p^(-fN_j eta_j); division by D_j=efN_j gives
exactly the same value. Conjugate-place weights sum to one. Integer
determinant powers C/(hN_j) give the label average, and common twisting
of all vector bundles tensors the result by Q^C. When C is sufficiently
divisible, its ideal is p^t O_K, t=C sum(eta_j)/(eh), with the standard
ambient metric. This is an isometric pullback of p^t Z, not merely a
coincidence of degrees.

The finite residue-sum formula and the A/B correction were recomputed.
At ell=43 they give R=473, sum(k_j)=164 and mean native degree
18836 log(p)/4515. The order-to-normalization index enters with a plus
sign in the A-normalized log-volume. Changing every tensor entry from
rho to the standard logarithm changes a fixed-reference value by
-m_j log(p); transporting the infinite metrics instead gives an
isometry and cancels this change. The almost-everywhere fixed-reference
test concerns only its explicitly declared background branch, not a
claim of divergence for the full published Ind3 construction.

These statements provide genuine bundles and descent. The choice of
the standard bundles at other finite places and of the ambient infinite
metrics remains part of this construction. It has not been shown to be
a member of the complete published pilot family. The original theta
value-group link and the Ind3/cross-Frobenius comparison must not be
replaced by an arbitrary equality between real degree values.

## 5. Validation scope

The centralized audit selects all 97 public theorems in the five new
modules, and nine additional proof-bearing declarations. The latter
include the two local primality Facts, the three actual ABCPoint
constructors, the two ellipticity instances, the bounded Fin-valued
map and the finite-fibre instance. Compilation, exact source hashes,
all dependency reports, the unchanged core/pins and the final manuscript
rendering are recorded in the new verification directory. This review
does not replace those checks or predeclare their final outcome.

No broad route is abandoned. The general all-epsilon uniform ABC bound,
or a family violating it for one fixed positive epsilon, remains absent.

## 6. The finite theta point source and coordinate distinction

The root read the complete frozen report
`IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md`, independently
rederived Sections 4--7, and read all of its English manuscript input
`uniform_continuation_theta_points_2026.tex`. The analytic reviewer
separately checked the same proof and the relevant original sources.
The root actually viewed the archived IUT II page images 72 and 73,
IUT III page 105, and the newly rendered IUT III page 24. These are
source checks, separate from the final manuscript's visual review.

The reindexing of the bilateral theta series has the displayed sign
and exponent. Its normalization at i is a unit at odd p. The standard
reciprocal-root orbit is exactly mu_(2ell) r0^(j^2); the source explicitly
permits independent finite torsion choices at the different labels.
The proof does not enlarge this to arbitrary local units.

In the native local field the vectors T_j have exact zero trace,
primitive shell content, and a projective inertia orbit of length ell.
The residue-field argument is valid because a nonzero difference of
the two character residues acts by a unit on the fractional lattice.
A common inertia power avoids the distinguished projective line.
Every hypothesis of the previous finite-family parabolic lemma is then
checked, including the trace-kernel surjection onto I/beta I and the
strict cardinality bound h+1<p. Its integer lifts give actual full
local Galois maps. Passing to the inverse group map is necessary for
the Kummer covariance formula c_alpha M_alpha^(-1).

One resulting tensor has the least permitted valuation in every
Galois component and therefore generates the whole displayed
fractional B-ideal. This proves an actual attained hull for the finite
point source, without assuming the source already contains a B-ideal.
The common map may depend on the full torsion tuple. The tail of
p^(-1) log(1+px) lies one full p-shell deeper than x; invariance of
the filtered lattice under each map proves equality of the two
principal ideals for each map, not equality of the points or of their
multiplicative Kummer classes.

The separate geometry-agent coordinate review was read in full.
IUT III Definition 1.1 uses the standard logarithm to realize the
log-field and then multiplies its pre-shell by p^(-1) at odd primes.
This leaves the native ring unit equal to 1. If the whole field is
instead transported by C(x)=x/p, its product is u star v=p*u*v,
its unit is 1/p, its base embedding sends t to t/p, and its integral
reference is O_E/p. The canonical shell becomes I/p. The tensor
reference and the component decomposition must also be transported.
This independent coordinate calculation agrees with the distinction
already imposed in the point-source proof; it does not settle the
globally synchronized source-membership question by itself.

The current paper retains that question and Ind3 as open obligations.
No global membership, original IUT inequality, or general abc statement
is certified by this review of the declared additive carrier.

## 7. Reduced rational invariants and actual Weil heights

The root read the entire mathematical note
`FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md`, its formal proof note,
all 27 public theorems and three private helpers in
`FreyIsogenyWeilHeight20260831.lean`, and the complete English height
input. The final module hash is
40421af9b48a4898b6e4982dbf68a0b1bdd17dd7885d8026bcfa734781a06587.
The only change after the first full build wrapped two long docstrings;
no proof or linter setting changed. The analytic agent also undertook
an independent mathematical and kernel review.

With u=c/2 odd, the four signed reduced fractions are
64P^3/[u^2(c-1)^2], -Q^3/[(c-1)u^4],
8R^3/[u(c-1)^4], and 8S^3/[u(c-1)]. The polynomial residues modulo
u and c-1 give the claimed coprimalities, including the separate
2-primary check. The zero-kernel numerator has its required minus
sign; rational height takes its absolute value only afterwards.
All bounds for Q, all height minima and uniqueness require n≥1.
At n=0 the original and zero-kernel j-invariants agree, so this
restriction is mathematically substantive.

The code proves actual Rat.num and Rat.den identities and uses
Height.mulHeight₁, Height.logHeight₁ and Heights.normalizedLogHeight.
The latter agrees over Q because the scalar field degree is one.
It is not a newly defined polynomial height with a theorem asserting
an assumed identification. The largest reduced coordinate is the
absolute numerator in all four cases. Comparing the four values
therefore proves IsLeast and the unique minimizer, with least height
3 log Q and bounds 6 log c - 3 log 2 < 3 log Q < 6 log c.

The paper separately uses the already proved classification of the
entire rational isogeny class. The exact gap between the least Weil
height and the least complex logarithmic absolute value is
log((c-1)u^4). Its leading coefficient is five. Choosing an isogenous
representative saves only a bounded additive constant in Weil height.
The asymptotic and the entire-class leading-exponent obstruction
are paper proofs, not extra claims about the scope of the Lean
indexing type. No bound on the radical is supplied by this family.

The final 9135-job build passed with precisely the previous warning
multiset of 265 entries. The 106 central dependency reports match
all scoped declarations: three are axiom-free and the remainder use
only subsets of propext, Classical.choice and Quot.sound. The exact
input hashes stayed unchanged during the build and audit. Older
145/89/43 audits and 705/506/447 manifest replays also passed.
These proof checks do not predeclare final PDF acceptance.

## 8. Canonical local membership in one source-defined branch

The root read the complete report
`IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md`, final hash
6ca3f92988be870df06b3536d9f1f6b598e9ed1f87cbd2feef5d8785e3f6d3d9,
and all of the independent analytic review, hash
c3e62d570623fec67dcdf8b09c116985c7155baada7435c2aad1932d0c4cf5a4.
The limited local statement passes the root review. The source
report remains immutable; this section records the subsequent verdict.

In addition to earlier source checks, the root read IUT I 5.3(ii),
IUT III Definition 1.1 and Remark 1.1.2, Proposition 1.3,
Propositions 3.4--3.5 (in particular the predecessor option on p.104),
the local-ideal and global-pilot definitions on pp.110--112, and the
raw-union and comparison paragraphs on pp.173--175. The root also
read AbsTopIII Proposition 5.8, pp.139--141, and Corollary 5.10(iv)(c),
(d) with its proof, pp.148--149. Rendered IUT III pp.102 and 104 and
AbsTopIII p.139 were actually viewed. Text extraction, render creation
and actual image viewing are distinguished in the source evidence.

One complete copy identity, with the bijective D-to-F strip lift and
its stated synchronization, supplies the standard-log representative
simultaneously. Independent local linear charts would not suffice.
The previous multiplicative cyclotome, new log-field cyclotome and
current cyclotome have separate roles. The new log-field unit is y(1),
not the old multiplicative identity. The linear old-unit Kummer class
does not acquire a nonzero valuation component by this argument.

In the canonical unit-perfection reconstruction the chart is
sigma_E(x)=p^(-N)[rec_E(exp(p^N x))]. The natural comparison with
the Kummer reconstruction is the reciprocity comparison explicitly
described in AbsTopIII p.149. Its shell image is sigma_E(I), without
another division by p. On abelianizations the source uses
contravariant transfer, so the canonical action is M_alpha^(-1).
Taking the inverse of the actual previously constructed Galois lift
gives the required minimum operator; a freely chosen Tate coefficient
unit is neither needed nor inserted in this canonical statement.

The two adjacent-layer diagrams use the predecessor carrier in
Proposition 3.5(i). They do not assert commutation of every vertical
log-Kummer square. The actual global pilot's local fractional ideals
contain all the specified torsion-unit multiples of their generator.
Transporting an ideal and its multiplicative action transports the
test module and vector too: Phi J=(Phi m_z Phi^(-1))(Phi R), and
evaluation is at Phi(1). Keeping the native vector 1 fixed would be
a different calculation.

In general there is only membership in the projection of the raw
packet onto the all-v tensor component. The rational specialization
F_mod=Q has exactly one selected v above p, because the selected set
V maps bijectively to places of F_mod. Thus its E^(tensor m) is the
whole selected local packet. These selected places are not all the
conjugate primes of K used in the separate arithmetic bundle.

It follows that the same-column raw union contains the canonical
point subfamily in the single fixed basic branch. The previous exact
hull theorem gives P_j as a lower inclusion in the hull of that union,
not an equality for the full union. The trace formula for the
logarithmically perturbed points is nonzero, whereas the pure labels
have trace zero; matching point-generated ideals does not identify
these points or their orbits.

The result relies on the cited reconstruction theorems with their
stated scope. It does not independently reprove them, assume the
full IUT III multiradial theorem, or certify its global inequality.
Horizontal transport into an independently marked codomain, the full
Ind3 family, IPL/SHE compatibility and the IUT IV global comparison
remain open in this research program. No broad route is discarded.
