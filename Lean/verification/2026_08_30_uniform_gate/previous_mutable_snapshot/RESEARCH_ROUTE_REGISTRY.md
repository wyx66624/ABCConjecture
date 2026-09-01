# Research route registry

This repository deliberately preserves mathematically distinct routes toward the
abc conjecture. A route is not deleted merely because it is incomplete, has been
superseded by a stronger implementation, or currently fails to compile against a
newer interface.

## Deletion rule

A research branch may be deleted only after one of the following has been recorded:

1. a concrete mathematical counterexample to its defining claim;
2. a Lean theorem deriving `False` from the route's hypotheses without using the
   public inconsistent total log-volume specification;
3. a proof that every theorem unique to the branch is already present on `main`,
   together with an archived immutable commit retaining the original route.

Build failures, API drift, lack of a current inhabitant, or lack of community
acceptance are not counterexamples and are not grounds for deleting a route.

## August 30, 2026 continuation

The latest result is effective finiteness of the specified positive
Pell--Chebyshev packet, uniformly in its integer index, by the original
normalized Matveev bound and BEG. It is a positive theorem for that
packet, not elimination of the whole Pell/Frey route and not a global
reduction from abc. Fundamental-unit cases and the required weighted
radical estimate remain active mathematical problems.

The analytic route retains amplification using actual small radicals;
only the two explicitly size-certified CRT/conic constructions now have
proved output-count restrictions. The local IUT route retains genuine
source-family comparison after the native point and coefficient-hull
containment. The 109-adic example rejects one direct dictionary, not
IUT. Its failure of Joshi's prime window is explicitly recorded.
Likewise, the exact hull in the full integral-linear automorphism model
cannot be transferred to a smaller Galois-induced family: a strict
counterexample to that unrestricted transfer is recorded in the new
cross-review.

No branch was deleted. Proofs, formal scope, and the next uniform gates
are collected in `../research/ABC_CONTINUATION_2026_08_30.md` and
`verification/2026_08_30_continuation/VALIDATION.md`.

## Retained routes

- `formalize/bridge-inhabitation-audit`: logical/circularity audit of downstream
  bridge packages.
- `formalize/canonical-source-derived-bridge`: canonical q-pilot, honest
  finite-positive volume, source and orbicurve construction experiments.
- `formalize/corrected-theta-graph-period`: odd theta-root graph-period
  descent, ordinary topological orbit cover, and the still-open
  rigid/Berkovich/tempered comparison.
- `formalize/multiradial-ahs-scale`: construction of genuinely distinct
  arithmetic holomorphic structures satisfying the cross-label
  tensor/procession compatibility; fixed-place scalar adapters are only
  diagnostic models.
- `formalize/source-faithful-iut4`: residue-normalized actual q-pilot,
  local/procession estimates, and the authentic odd-q Theorem 1.10 route.
- `formalize/concrete-genell-fermat`: the affine finite-etale Fermat cover,
  followed by projective compactification, ramification, Belyi descent, and
  height comparison.
- `formalize/frey-j-height-*`: exact Frey/Legendre rational Weil-height route.
- `formalize/frey-discriminant-*`: discriminant radical and conductor route.
- `formalize/frey-calibrated-*`: strict bridge calibrated by the actual Frey
  `j`-height.
- `formalize/shifted-j-*`: nonintegral shifted-`j` curve route toward a uniform
  non-CM/open-image input.
- `formalize/legendre-j-height`: primitive Legendre-ratio height route.
- `research/joshi-arithmetic-teichmuller`: independent audit and possible
  formalization of Kirti Joshi's Arithmetic Teichmuller Spaces.
- `research/abc-powerful-core-v8`: square-core, cube-core, diagonal-conic and
  diagonal-cubic reductions for prospective counterexamples.
- `research/abc-exceptional-amplification-v8`: incidence amplification criterion
  converting a power-saving exceptional-set estimate into finiteness.
- `research/abc-torsion-line-energy-v8`: local Tate-line energies and locally
  adaptive adelic successors after the fixed-packet no-go theorem.
- `research/abc-legendre-parabolic-higgs-v8`: globally labelled three-cusp
  parabolic/Higgs route; its arithmetic specialization theorem remains open.

## Variants eliminated by proved no-go theorems

### Fixed place-independent torsion packet

For canonical/noncanonical Tate coefficients

`A_ell = (ell - 1)/12`, `B_ell = -(ell - 1)/(12*ell)`,

every fixed line-weight system satisfies

`average_C S_C(w) = 0`

under the complete transitive projective orbit. This eliminates the naive fixed
three-line determinant variant. Its original work is retained at commit
`30430eadad8a4f4035c35479e80cd2cc630c6cc0`; the no-go theorem and useful
different estimate are ported into the v8 integration commit.

### Generic full-orbit CRT/Minkowski selector

The general congruence-lattice selector retains only a `1/(ell+1)` fraction of
projective depth, while

`B_ell + (A_ell - B_ell)/(ell + 1) = 0`.

Thus that generic selector cannot produce a positive uniform q-coefficient.
Its original work is retained at commit
`a3decfc45e01e011dc38a6d4542b4dbcf4a2d662`; the dimension-barrier theorem is
ported into the v8 integration commit.

The corrected successors use locally adaptive filtrations or globally labelled
three-cusp parabolic data and are not excluded by these no-go theorems.

## Retired claims with recorded counterexamples

- **Most smooth numbers in the selected short intervals have very few prime
  factors.** Finite prime-power encoding and Younis's unconditional theorem
  show that, at the stated subexponential smoothness scale and interval
  length `x^(3/5)`, the relative population with
  `omega(n)<=2 log log x` tends to zero, while the proposed moment assertions
  would imply the opposite behavior. The exact claims in Carella v2,
  Lemmas 4.2 and 4.4 and (4.24), are refuted; a sparse-neighbour route remains.
  See `../research/ANALYTIC_ROUTE_SESSION_2026_08_30.md`.
- **Each large endpoint has a separate subcritical signed-defect bound.**
  The primitive dyadic family has defect `(N-2)log 2` on one endpoint and
  full conductor at most `(N+2)log 2`, ruling out every separate slope
  below one. Only this stronger substitute is rejected; the coupled
  two-endpoint estimate remains exactly equivalent to abc and open.
- **Simultaneous tensor actions generate a complete tensor lattice.**
  The integral span of `v tensor v` in rank two is exactly the symmetric
  submodule and omits `E12`; it has zero ambient Haar measure over a local
  field. This refutes the abstract simultaneous-action substitute, not any
  asserted identification with the full actual IUT output set. The positive
  independent-action and reachable-determinant route is retained.

- **Root-pullback equals graph cover.**  If `r^ell=q`, the map induced by
  `v |-> v^ell` from the `r`-Tate quotient to the `q`-Tate quotient has degree
  one on normalized radial skeletons and angular kernel `mu_ell(K)`.  It is not
  the graph-direction `Z/ell Z` cover.  The cyclotomic/Kummer isogeny results
  are retained; the corrected graph-period route uses `<q^ell> <= <q>`.
- **Complete global `j` packet may directly replace the IUT IV odd q-divisor.**
  The Frey family `(1,2^m,2^m+1)` gives an omitted height packet larger than
  `2 * log(rad(abc))` up to a positive constant, so the replacement forces a
  nonvanishing conductor-error slope.  The source-faithful odd-q and
  compact-tripod/GenEll route is retained.
- **The Tate `K`-point quotient is the valuation skeleton circle.**  In
  characteristic zero the class of `-1` is nontrivial in `K^x/q^Z` but maps
  to zero under the log-norm circle coordinate.  Thus the direct `K`-point
  map is not injective.  The analytic Berkovich retraction and the tempered
  skeleton comparison remain retained targets.
- **One fixed-place scalar supplies the multiradial bridge.**  Labels one and
  two have concrete degrees `L` and `4L`, so no common scalar calibrates both
  to nonzero `L`.  The labelwise scalar `1/j^2` is retained as a diagnostic,
  but it is not the source's cross-label tensor/AHS construction.

The full mathematical arguments are recorded in B.0, B.5.0, C.0, and D.0 of
`CORE_PROOF_NOTEBOOK.md`.  These entries retire only the stated
identifications, not abc, IUT, or the corrected surviving routes.

## Merge policy

Only non-circular statements with a complete dependency audit are merged into
`main`.  They may be Lean-kernel closed or closed relative to a precisely named
accepted-theorem/certified-computation interface, using the labels and trust
ledger in `ACCEPTED_THEOREM_DEPENDENCY_POLICY.md`.  Open, disputed, heuristic,
or target-equivalent inputs remain conditional; explicitly labelled mathematical
research documents may record such open routes without asserting closure.  When
an old branch contains useful results but also stale history, a broken interface,
or an eliminated formulation, the verified result is ported onto a fresh branch
based on current `main`; the old branch is retained unchanged for auditability.

No entry in this registry asserts a parameter-free proof of `ABCConjecture`.
