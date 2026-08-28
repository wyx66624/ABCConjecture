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
- `research/abc-exceptional-amplification-v8`: incidence amplification criterion;
  exact three-point maps and rational isogenies have been removed as amplifier
  subroutes, while varying maps, norm constructions and growing field orbits
  remain active.
- `research/abc-torsion-line-energy-v8`: local Tate-line energies and locally
  adaptive adelic successors after the fixed-packet no-go theorem.
- `research/abc-legendre-parabolic-higgs-v8`: globally labelled three-cusp
  parabolic/Higgs route; good-place determinant unitness is established, while
  its arithmetic specialization/maximal-slope theorem remains open.

## Variants eliminated by proved no-go theorems

### Fixed place-independent torsion packet

For canonical/noncanonical Tate coefficients

`A_ell = (ell - 1)/12`, `B_ell = -(ell - 1)/(12*ell)`,

every fixed line-weight system satisfies

`average_C S_C(w) = 0`

under the complete transitive projective orbit. This eliminates the naive fixed
three-line determinant variant. Its original work is retained at commit
`30430eadad8a4f4035c35479e80cd2cc630c6cc0`; the no-go theorem and useful
different estimate are ported into `main`.

### Generic full-orbit CRT/Minkowski selector

The general congruence-lattice selector retains only a `1/(ell+1)` fraction of
projective depth, while

`B_ell + (A_ell - B_ell)/(ell + 1) = 0`.

Thus that generic selector cannot produce a positive uniform q-coefficient.
Its original work is retained at commit
`a3decfc45e01e011dc38a6d4542b4dbcf4a2d662`; the dimension-barrier theorem is
ported into `main`.

### Exact three-point rational-map amplification

For a degree-`d` rational map `f : P^1 -> P^1`, Riemann--Hurwitz gives

`|f^{-1}({0,1,infinity})| >= d + 2`.

Hence a map whose inverse image of the three-point boundary is contained in the
same three points has degree one and is only an anharmonic permutation. Every
map of degree greater than one introduces at least `d-1` new boundary points.
This eliminates exact prime-support-preserving Belyi/self-map amplification,
but not amplification schemes that control the new factors quantitatively.

### Rational cyclic-isogeny amplification over `Q`

The Mazur--Kenku classification gives an absolute finite set of rational cyclic
isogeny degrees. Consequently the number of rational cyclic subgroup schemes
of any elliptic curve over `Q` is absolutely bounded. Such a mechanism has
amplification exponent `beta = 0` and cannot satisfy

`beta > gamma + kappa*alpha`

for a positive exceptional-set exponent. Isogenies over growing fields, Galois
orbits and norm/descent constructions remain active only with explicit radical,
different and overlap control.

The corrected successors use locally adaptive filtrations, globally labelled
three-cusp parabolic data, varying maps, or growing arithmetic orbits and are not
excluded by these no-go theorems.

## Retired claims with recorded counterexamples

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
