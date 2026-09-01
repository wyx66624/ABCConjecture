# Independent coordinating review of the Galois-lift continuation

Author: ChatGPT. Research date: 2026-08-30.

This is an internal mathematical and formal-scope review, not external
journal peer review. It does not certify an abc proof or disproof.

**Update of 2026-08-31:** Sections 1–4 below preserve the review at its
original intermediate point. The formerly unidentified middle hull in
Section 2 is now exactly determined, and full original initial theta
data are now constructed for both the balanced example and an unbounded
family. The complete dated follow-up review is Section 5; these earlier
sentences are not assertions that those questions remain open.

## 1. Full-group and integral-lattice arguments

I checked the forward and inverse cross-handle words in
`IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md`, including both compositions,
literal preservation of the ordered boundary, and the four abelian images.
The Lean module `IUTFullGaloisWordLift20260830` constructs a genuine
automorphism of the discrete free group and proves the identities in
arbitrary groups. It does not identify this group with a local Galois group.

The mathematical passage to the full absolute Galois group retains the
relative free profinite product with the entire tame factor, the closed
normal wild subgroup, its characteristic maximal-pro-p kernel, and the
additional Jannsen--Wingberg relator. Both word substitutions preserve
each quotient kernel. In particular, the distinguished p-power term is
fixed literally. The proof does not assert that an arbitrary automorphism
of a maximal pro-p quotient lifts to the full group.

For the tame range e <= p-2, the logarithm is defined on the entire
principal-unit group and its image is the maximal ideal. The extra
Hoshi--Nishio generator is eliminated by a coefficient congruent to 1
modulo p; hence the rational basis in that source is an integral basis
in these examples. The even-degree trace-kernel statement is applied in
this same basis. No odd-degree theorem is applied to an even-degree field.

The cup-product evaluation identity gives Kummer transport c*M^(-1),
with c a p-adic unit. The attaining covariant map M is therefore used
through the inverse group arrow. This direction is preserved at every
repeated label. The central composition law is asserted only for the
linear images, not as a relation between chosen nonabelian word lifts.

## 2. Six vectors, two source families, and the intermediate pilot

The three-label proof in
`IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md` works for every
rational b0 of valuation 1. Its Eisenstein root need not satisfy pi^105=p.
I separately obtained the whole-family vectors

    X_s = pi^(15s-104) / p^floor(s/7),  s=1,4,9,

with valuations (-89,-44,-74)/105 and exact trace zero. These agree
with the independently derived vectors in
`IUT_NATIVE_PILOT_DICTIONARY_2026_08_30.md`. The six normalized point
and whole-family vectors all lie in pi*I outside p*I. Their respective
C7 inertia characters are (1,4,2) and (2,5,3), all nontrivial.
At most six of the seven inertia choices are forbidden by the single
distinguished line. After a common choice, the finite-hyperplane and
parabolic argument works for all six vectors and the background u.

This proves the point exponents (-103,-207,-206) and the whole-family
exponents (-208,-312,-311). The common arrow is actually constructed
using the full-group lifts above. The universal upper containers use
preservation of p^n*I; no arbitrary GL(I) reachability is assumed.

The root/log bridge is valid after each integral arrow because the
logarithmic error lies in the next p-content layer. This gives equal
principal ideals after transport, without asserting equality of points
or multiplicativity of the arrow. The saturated units 1+p*a*I map onto
the entire a*I under rho=p^(-1)*log_BK_standard. This equality is an
equality of sets before any hull operation.

The trace-dual proof is also valid: for the tensor order A and its
normalization B, integrality of trace gives B subset A^dual=I^tensor.
It yields the same-source sandwich

    point hull subset hull of transported (a tensor 1...)*B
               subset whole-product hull.

The two endpoints differ by p, but the middle hull is not thereby
identified with either endpoint. Applying B-span before and after a
merely Qp-linear map remains distinct. Convex closure is justified by
the common closed product containers and retained attaining tuples,
not by an unjustified interchange with tensor formation.

## 3. Actual rational curves and the larger example

I checked the two rational models in
`FREY_139_TATE_210_REALIZATION_2026_08_30.md`, including the invariants,
split nodes, point counts at five, and the elementary two-transvection
argument for the mod-seven image. The direct Legendre representative
(1,2362,2363) removes the twist present in the first proposed model.
The local torsion-field equality uses equality of Galois kernels in
the Tate quotient, not just containment of torsion coordinates.

The independent arithmetic report correctly strengthens the exception
boundary: with the defined normalized Q, theta(10)<20/3 forces the
source's xi_prm>10, so every numerical ell=7 candidate is in that
particular proof's small-Q exclusion when it belongs to the domain.
The later printed sum omitting the degree normalization is a separate
source discrepancy, and is not silently used as the same quantity.

For `FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md`, I checked
the rational Legendre change x=A^2*X, y=A^3*Y, all odd split nodes,
and the true uniformizer beta=pi^323/p. Here v(b0)=2 and v(q)=4;
pi is not a uniformizer. This changes the relevant inertia characters
from 15*j^2+1 to 30*j^2+1. In particular j=15 has a short whole-family
orbit: ignoring this would invalidate a C43-only argument.

The full C645 argument is valid. The point family forbids at most 315
inertia exponents, the whole family at most 63; 378<645 leaves a
common choice. The subsequent 42-vector parabolic step needs at most
43 proper kernels over F1289. It gives the same actual arrow for all
21 point blocks and all 21 whole blocks. The exponent formulas and
their signs are calculated in integers, never natural subtraction.

The prime-to-43 Tate-order argument uses a bound on all large primes
and an exact primorial/gcd certificate for the small range. It does
not assume the large endpoints have been factored. The numerical
height interval does not alone establish membership outside a
source exceptional set or all initial-data choices.

## 4. English text and formal scope

I read `paper/galois_lifts_continuation_2026.tex` and
`paper/native_pilot_dictionary_2026.tex` against the preceding proofs.
The full-family specialization of Gamma in the exact hull theorem is
explicit. The integral basis, full relative quotient, covariance
conversion and finite-family step are proved, rather than left inside
phrases such as "a suitable lift exists". Their external source inputs
are cited and distinguished from Lean conclusions.

The standard Bloch--Kato logarithm and rho differ by p in each entry.
Thus length-m hulls differ by p^m and normalized log volumes by
-m*log(p). Nonintegrality in rho coordinates cannot refute an
integrality claim in standard coordinates. The original unpowered
singleton, a powered native root, a changed valuation marking, a
whole multiplication image, and a principal ideal before transport
remain separate objects throughout the accepted text.

The new Lean modules prove explicit group words and an actual free
group automorphism, actual linear equivalences and finite avoidance,
actual Weierstrass invariants and finite-field point counts, and
arithmetic bounds. The SL2 module uses mathlib's real matrix groups
and an established transvection-induction theorem. Local class field
theory, Tate uniformization, Galois representations, the full profinite
presentation and global IUT comparisons are not silently axiomatized.

Final build, dependency, document-rendering and snapshot checks are
recorded separately in `Lean/verification/2026_08_30_galois_lifts`.
This mathematical review is not a substitute for those checks, and
neither kind of check supplies the missing uniform abc estimate.

## 5. Completed follow-up review, 2026-08-31

The new sharp proof in `TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md`
uses the absolute algebra trace on the finite étale tensor algebra.
Individual maximal-order idempotents give `B^dual=product I`, without
a degree or component-count factor. For `k=floor(v(a)+(e-1)/e)`, the
entire normalized pre-ideal `p^(-k)*(a tensor 1...)*B` lies in this dual
and hence in `A^dual`. A Qp-linear map preserving `A^dual` therefore
has its transported pre-ideal B-span inside the same exact product
ideal as the point upper bound. The already constructed common point
attainer gives the reverse inclusion. Thus the middle hull is **P**,
while the whole-product source hull is **p^(-1)*P**. Independent
analytic and geometry reviews confirmed the proof.

I read the resulting six-theorem Lean module in full. It uses actual
algebra traces, dual submodules and a multiplicatively closed subalgebra;
it proves the normalized pre-ideal containment from a single dual
membership, then bounds the B-span after any family of K-linear maps
preserving the smaller-order trace dual. It does not assume the desired
image bound. The inverse-different/tensor-order identifications and
Galois attainment remain paper results and are listed as such.

I checked the unbounded CRT family against the exact archived Xylouris
Theorem 1.1 with effective exponent 5.2. Its residue-class modulus has
polynomial growth in ell, while the working interval has exponential
length. The explicit finite bad-point count is sufficient. All prime
divisors of the CRT modulus are treated separately. The ell-power-free
assertion applies to `A`, `A^2+1`, `2*A^2+1`, not to `A^2` or their abc
product. This distinction preserves the prime-to-ell Tate-order proof.
The degree-normalized height, true uniformizer, good reduction at two,
and mod-ell image arguments have the stated uniform hypotheses.

For the complete initial data, I read original IUT I Definition 3.1,
the canonical-curve core results, the original étale-theta cover
definitions, and the four arithmetic once-punctured j-invariants.
The nonarithmetic core follows from a negative j-valuation at a prime
greater than five. The dual-isogeny graph cover has constant kernel;
all its cusps are K-rational and the unramified cusp decomposition
condition holds. SL2 transitivity on decorated pairs permits one fixed
global quotient vector and independent place choices. The graph map is
the identity from `E(q^ell)` to `E(q)`, not the root-pullback. The original
ununderlined curve supplies the mod-ell torsion condition for oriented
covers; no hidden ell-squared torsion extension is needed. The same
criterion applies to every constructed power-free family member.
Independent analytic and geometry reviews agree.

The fixed bounding domain satisfies the original finite-extension-slice
condition. It need not be compact in ambient Qbar2, where nonempty
interior would preclude compactness. The manuscript states the literal
formulation's failure separately and does not use it as an IUT disproof.

I read all six added English sections and the final formal-scope table.
Only subsequent typographical changes were made where needed for line
breaking or bookmarks. The final 66-page PDF has zero final warnings and
has been viewed on every page. Seven modules and all 145 audited
declarations pass; the previous 89 and 43 audits pass independently.
These checks do not assert full formalization of local-field geometry,
initial-data covers, or the full global pilot/Ind3 comparison. The
standard unconditional abc conclusion remains open in this repository.
