# Pell--Lucas correlated all-order replay

This directory supports
`research/ABC_PELL_LUCAS_CORRELATED_ALL_ORDER_EXCLUSION_2026_09_01.md`.

The producer and the verifier are separate implementations.  The verifier
does not import the producer.  It independently recomputes the Pell orbit,
the bounded divisor scan, the coefficient identities, the two multiplication
polynomials, complete small incidence graphs, and every stored witness.

Frozen parameters:

* all 57 odd prime indices `3 <= ell <= 271`;
* candidate divisor bound `q <= 2,000,000`;
* coefficient correlation at all prime indices `ell <= 2000`;
* four modular evaluations of both multiplication polynomials at every prime
  index through 271;
* complete odd-kernel incidence graphs at the 13 prime indices through 43.

Certified output:

* every prime index through 271 has a proved exponent-one divisor, so the
  actual product `A_ell B_ell` is not squarefull there;
* 527,352 bounded candidate-prime tests find only
  `13^2 || B_7` and no depth-three hit;
* 138,675 first coefficients are rebuilt from their product/factorial
  formula and satisfy `(2*j+1)c_j = ell*d_j` against the independently
  computed companion binomial coefficients;
* 228 modular recurrence evaluations satisfy both all-order polynomials,
  using those product-derived first coefficients;
* every stored incidence row satisfies the row, column, quartic-two, and
  global sign laws;
* at index eleven the row at `r=5741` contains one negative and one positive
  edge, certifying sharpness of the parity conclusion.
* the Lean module proves the passage from the original odd-factor product
  coefficient to its binomial closed form and passes with
  `-DwarningAsError=true`; its reported axiom union is contained in
  `propext`, `Classical.choice`, and `Quot.sound`.

The bounded absence of depth-three hits is not a proof beyond the stated
range and does not retire the Pell/Lucas route.  No full-premise squarefull
counterexample is present in the range.
