# ABC multi-route research board, version 9

## Operating rule

Every workstream proceeds in the order

1. precise mathematical definition;
2. theorem and complete proof or explicit source theorem;
3. adversarial audit and boundary examples;
4. Lean formalization with no `sorry` or hidden target field;
5. all-module kernel CI;
6. merge into `main` only after the preceding steps.

A route is not abandoned because it is difficult, unconventional, or lacks a
current library implementation.  It is closed only after a concrete
counterexample, a logical contradiction, or a theorem proving that its
required quantitative implication is impossible.

No current workstream is allowed to claim an unconditional proof or disproof
of `abc`.

## Workstream A: stack-correct Legendre Hodge--Arakelov

### Newly closed

- On coarse `P^1`, `Omega^1(log{0,1,infinity})` has degree one.
- It has no ordinary integral-degree square root.
- The half-degree Hodge line must live on the level-two modular stack or in a
  parabolic/rational Picard group.
- For `ell=12m+1`, `Delta_Leg^m` is an integral section of
  `omega^(ell-1)` with cusp coefficient `(ell-1)/6`.
- Its primitive specialization has finite boundary contribution
  `((ell-1)/12) log |Delta_min| + O(ell)` and is a unit at ordinary good
  finite places.

### Current target

Prove the stack-normalized archimedean/level-prime compensation estimate with
leading Hodge coefficient `(ell-1)/2+o(ell)`, including the generic `mu_2`
descent and every metric Jacobian.

### Elimination condition

A family showing that the required stack-normalized compensation exceeds the
conductor by a fixed positive proportion would refute this exact route.

## Workstream B: simultaneous local Picard--Lefschetz monodromy

### Closed algebra

- Two nonparallel nonzero transvections generate `SL_2(F_ell)`.
- Candidate inertia exponents have logarithmic height growth.

### Current target

Construct, in one global `ell`-torsion basis, the actual inertia actions at two
distinct Frey--Legendre boundary primes, including the potentially
multiplicative two-adic case.  Derive the matrices from the Tate/Kummer or
Picard--Lefschetz comparison, rather than assuming them as fields.

### Elimination condition

A specialization for which the two geometrically distinct boundary vanishing
cycles become parallel modulo every admissible auxiliary prime would refute
the proposed two-direction theorem.

## Workstream C: cyclotomic auxiliary-prime selector

### Mathematical theorem proved

For

`M=6*B!*m_1*m_2`,

every prime divisor of

`Phi_12(M)=M^4-M^2+1`

is greater than `B`, avoids `m_1m_2`, and is congruent to one modulo twelve.
It is at most `M^4+1`, hence retains the uniform sublinear bound
`log ell=o(log c)` when `m_i=O(log c)`.

### Current target

Formalize exact multiplicative order twelve in `(ZMod ell)^x`, then assemble
the threshold, avoidance, congruence and upper-bound package in Lean.

## Workstream D: powerful square/cube cores

### Closed

Every prospective counterexample has:

- a polynomially large square core in one of its two largest terms;
- a polynomially large cube core in `abc`;
- a primitive point on a varying squarefree diagonal conic;
- a primitive point on a varying cube-free diagonal cubic.

The prime-exponent inequalities have entered Lean formalization.

### Current targets

1. Uniform radical-height bounds on the varying diagonal conics.
2. A 3-descent/Selmer formulation for the cube-free diagonal cubics that uses
   the proven large-coordinate condition.
3. A counterexample search for any proposed uniform coefficient bound.

## Workstream E: exceptional-set amplification

### Closed

The incidence theorem gives

`N(X)=O(X^(gamma+kappa*alpha-beta))`.

### Newly excluded

A fixed number of cyclic isogeny steps at one subpolynomial level supplies only
`X^{o(1)}` outputs and therefore has amplification exponent zero.

### Retained candidates

- growing-depth Hecke trees with controlled overlap;
- simultaneous use of many levels;
- polynomial identities preserving high prime powers;
- Galois/norm amplification with radical control;
- modular-point amplification producing several abc triples per endpoint.

## Workstream F: IUT/ATS normed numerical comparison

### Closed downstream

The target-free Corollary 3.12 ledger and the conditional `q`-bound-to-`abc`
chain are formalized.

### Current target

Prove, or refute by an explicit local model, a normed and weight-preserving
Rosetta theorem for the exact possible-image locus.  It must preserve the
concrete `j^2` theta values, tensor cross norm, local-degree weights,
procession averaging, Haar Jacobians and Ind1--Ind3 inclusion directions.

No categorical or set-theoretic identification alone is accepted.

## Workstream G: direct disproof search

A disproof requires one fixed `epsilon_0>0` and infinitely many primitive
triples with

`c / rad(abc)^(1+epsilon_0) -> infinity`.

Search families are organized by:

- exponential recurrences;
- high-power polynomial identities;
- elliptic divisibility sequences;
- norm-form identities;
- smooth-value constructions.

Record-quality isolated triples do not constitute a disproof.

## Current dependency front

The two most direct proof fronts are:

1. stack-correct Legendre archimedean/level compensation;
2. actual simultaneous local Picard--Lefschetz inertia plus the cyclotomic
   `ell=1 mod 12` selector.

The strongest independent fallback fronts are the powerful-core geometry and
exceptional-set amplification programmes.  IUT/ATS remains retained, but only
through independently verified numerical source theorems.
