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
- the exact norm-one angular kernel of the valuation-circle map and, for a
  discretely valued field, the finite `K`-rational radial image
  `range(rho) ~= ZMod(order_pi(q))` with its exact cardinality
- genuine non-classical polynomial Gauss absolute values of every positive
  radius and their strict extension to Laurent polynomials, with
  `|T|=r`, `|T^-1|=r^-1`, an explicit `T |-> qT` automorphism and exact
  covariance; the positive radial orbit quotient is homeomorphic to the
  logarithmic circle
- existence and set-level uniqueness of least products of scaled maximal
  valuation rings for compact local packets with nonzero projections
- normalized local additive Haar measure and honest finite-positive nonzero
  scaled integral balls
- residue-cardinality normalization of the local Haar character, the bridge
  from norm-uniformizers to DVR uniformizers, and the actual bad-place formula
  `log Delta(q) = -qOrder * log(#k)` with the DVR, finite-residue, proper and
  Borel structures derived from the actual adic completion
- the finite actual bad-place Haar packet: the completed residue field has
  cardinality `absNorm(w)`, each signed entry is
  `-qOrder(w) * log(absNorm(w))`, and the normalized negative packet sum is
  exactly the degree of the explicit q-divisor and `arithmeticLogQ`; its
  identification with public `logQ` is correctly conditional on weight-degree
  compatibility
- fixed-place rational prime scale rigidity after prime specialization
- the unique labelwise `1/j^2` theta calibration, its finite weighted form,
  and the common-fixed-scale obstruction at labels one and two
- actual nonarchimedean absolute-value copies rescaled by `1/j^2`, together
  with the fixed-place theorem that no ring equivalence between the label-one
  and label-two `Q_p` copies can preserve logarithmic norm
- an explicit source-faithful bound absorbing
  `sqrt(q) * log(A*q)` into an arbitrarily small multiple of `q`
- an explicit affine Fermat/Kummer algebra over the tripod which is finite
  etale, free of exact rank `n^2`, faithfully flat, surjective on prime
  spectra, and whose generators satisfy `x^n+y^n=1`
- Eisenstein irreducibility and integrality of the affine Fermat presentation,
  its honest boundary localization with both coordinates invertible, and a
  target-local standard-smooth proof for the bivariate affine Fermat quotient
- an explicit equivalence between the bivariate quotient and `AdjoinRoot`
  presentations, transporting smoothness first to the integral affine ring
  and then to the honest boundary localization
- an explicit `K`-algebra equivalence from that honest open Fermat ring to
  the two-stage tripod Kummer algebra, proved by localization, `AdjoinRoot`,
  and two standard-etale universal properties
- the Fermat power map's exact coordinate fibres over `0,1,infinity`, its
  local power laws, and a base-compatible equivalence identifying the honest
  open Fermat ring with the iterated Kummer presentation; under this
  equivalence the honest open is finite etale of exact rank `n^2` over the
  punctured tripod
- the generic local DVR theorem that a uniformizer identity
  `t = unit * x^n` forces additive order `n`, extended maximal ideal
  `m_R S = m_S^n`, and ramification index exactly `n`
- the genuinely graded homogeneous Fermat quotient and its actual `Proj`
  scheme, covered by the three coordinate basic opens, with each chart
  canonically affine and the `X_2`-chart ratios satisfying `u^n+v^n=1`
- an explicit `K`-algebra equivalence from the `X_2` homogeneous chart ring
  to the bivariate affine Fermat quotient, proved in both directions from
  chart generators, and transport of affine `Algebra.Smooth` to that chart

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
- completion of the proved Laurent Gauss ray to a Tate algebra and full
  rigid/Berkovich analytic quotient, theta-root `H^1` and divisor control,
  angular directions, deformation retraction, and tempered
  fundamental-group/skeleton comparison for the odd theta-root locus
- the genuine cross-label AHS/untilt and Ind1--Ind3 degree-line bridge
- the genuine Ind1--Ind3 possible-image/procession upper bound beyond the
  proved finite actual bad-place Haar/q-divisor identity, including a
  source construction of public weight compatibility and odd-place selection
- Lean formalizations of the root-pullback and global-j-packet
  counterexamples recorded above (the valuation-circle kernel is formalized)
- a source-derived, uniformly quantified IUT IV q-height theorem
- geometric irreducibility, scheme-level packaging of the now identified
  affine chart and honest localization as a compactification inside the
  genuine Fermat `Proj`, scheme-level smoothness/normality/properness,
  boundary local DVR/uniformizer identifications, and the noncritical
  Belyi/height package
- `Nonempty UpstreamCertificate`
- parameter-free `abc_conjecture`

These are mathematical construction theorems, not missing record syntax. No
`sorry`, `admit`, new axiom, or theorem equivalent to abc may be used to mark them
complete.
