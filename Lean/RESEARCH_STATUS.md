# Research status

## Proven and formalized

- `ActualPilotWitness -> Iut.Corollary312Variant`
- generated output union and definitional membership
- pointwise source family -> pointwise Corollary 3.12 family
- explicit q-height comparison package -> `ABCConjecture`
- full-poly Kummer conjugation in the abstract structured setting
- q-pilot scalar calibration and ramification correction
- packet marginalization, finite-positive monotonicity, procession averaging
- finite exceptional-set absorption, elementary prime avoidance
- scalar IUT IV algebra
- exact inhabitation audit of the current downstream bridge
- odd-period theta automorphy and the explicit algebraic equivalence of its
  Kummer root locus
- the corrected graph-period cyclic quotient, its free integer action,
  proper discontinuity, and the resulting ordinary topological orbit covering
- a continuous comparison from that orbit quotient to the Tate `K`-point
  quotient and its valuation circle, together with the characteristic-zero
  norm-one-kernel obstruction to injectivity
- existence and set-level uniqueness of least products of scaled maximal
  valuation rings for compact local packets with nonzero projections
- normalized local additive Haar measure and honest finite-positive nonzero
  scaled integral balls
- residue-cardinality normalization of the local Haar character, the bridge
  from norm-uniformizers to DVR uniformizers, and the actual bad-place formula
  `log Delta(q) = -qOrder * log(#k)` under explicit local-field typeclasses
- fixed-place rational prime scale rigidity after prime specialization
- the unique labelwise `1/j^2` theta calibration, its finite weighted form,
  and the common-fixed-scale obstruction at labels one and two
- an explicit source-faithful bound absorbing
  `sqrt(q) * log(A*q)` into an arbitrarily small multiple of `q`
- an explicit affine Fermat/Kummer algebra over the tripod which is finite
  etale, free of exact rank `n^2`, faithfully flat, surjective on prime
  spectra, and whose generators satisfy `x^n+y^n=1`

These new results are local or scalar components.  They do not construct the
rigid/Berkovich theta quotient or tempered comparison, the genuine IUT III
possible-image system, the IUT IV source estimate, or the projective
GenEll/Belyi height package.

## Claims retired by concrete counterexamples

- The map obtained from `r^ell=q` and `v |-> v^ell` is not the graph-direction
  degree-`ell` cover: on the normalized Tate skeleton it has degree one and its
  pointwise kernel is the angular group `mu_ell(K)`.  The associated Lean
  results remain useful as a cyclotomic/Kummer isogeny route.
- The complete global Frey `j`-height cannot replace the odd bad Tate
  q-divisor in the IUT IV component formula with a uniformly negligible
  conductor error.  For `(1,2^m,2^m+1)` the omitted packet exceeds twice the
  logarithmic radical, up to a positive constant.  This retires only the
  direct complete-packet substitution, not the source-faithful odd-q route.
- The Tate `K`-point quotient cannot itself be identified injectively with
  the valuation circle in characteristic zero: the nontrivial class of `-1`
  lies in the kernel.  This retires only the direct `K`-point equivalence; it
  does not refute the noninjective Berkovich retraction from an analytic space
  onto its skeleton.

## New exact obstruction

For every pointwise IUT III family `F` over an inhabited input type, the current
`NonCircularIUTIVBridge F` satisfies

```lean
Nonempty (NonCircularIUTIVBridge F) ↔ ABCConjecture
```

Consequently the current four-stage package satisfies

```lean
Nonempty FourStageProgram ↔
  Nonempty UpstreamCertificate ∧ ABCConjecture
```

The forward implication is the intended transfer to abc. The reverse implication
constructs the bridge from an already available abc inequality and ignores the
Corollary 3.12 premise. Thus the bridge is syntactically free of an
`ABCConjecture` field, but its unrestricted inhabitation is still logically as strong
as abc. This prevents it from being counted as an independently constructed IUT IV
bridge.

At the IUT III scale layer, one common scalar cannot calibrate both concrete
labels `1` and `2`, since their log norms differ by the square factor four.
The unique pointwise calibration is `1/j^2`, and it preserves a separate
product formula after uniformly rescaling every place within one label.
However, this scalar-copy model changes the log-volume effect of integer
multiplication between labels and therefore does not construct the source's
cross-label tensor/procession compatibility.  This is a no-go theorem for a
fixed-place/common-scale adapter, not a refutation of genuinely different
untilts or arithmetic holomorphic structures.

## Not proved

- a concrete implementation of `AnabelianGeometry`
- a concrete implementation of `TemperedGeometry`
- actual admissible-prime data uniformly attached to every abc input
- actual orbicurve/core/cusp data in the intended anabelian geometry
- actual local theta-data and tempered comparison data
- actual Hodge-theater/Frobenioid/Kummer/log-link/multiradial output realization
- the rigid/Berkovich analytic quotient, theta-root `H^1` and divisor control,
  and tempered fundamental-group/skeleton comparison for the odd theta-root
  locus
- the genuine cross-label AHS/untilt and Ind1--Ind3 degree-line bridge
- the finite-product packet/log-volume formula and degree-normalized
  p-preimage scaling beyond the proved single-place Tate-q normalization
- derivation of the DVR, finite-residue, proper-space, and Borel instances for
  every actual adic-completion `TateField` used by the thin bad-place wrapper
- Lean formalizations of the root-pullback and global-j-packet
  counterexamples recorded above (the valuation-circle kernel is formalized)
- a source-derived, uniformly quantified IUT IV q-height theorem
- geometric irreducibility, projective compactification, boundary
  ramification, and the noncritical Belyi/height package for the Fermat cover
- `Nonempty UpstreamCertificate`
- parameter-free `abc_conjecture`

These are mathematical construction theorems, not missing record syntax. No
`sorry`, `admit`, new axiom, or theorem equivalent to abc may be used to mark them
complete.
