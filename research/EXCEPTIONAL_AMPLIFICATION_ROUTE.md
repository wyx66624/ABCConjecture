# Exceptional-set amplification route

## 1. Motivation

Recent determinant-method work proves that abc violations are sparse.  A
sparsity theorem alone is not a pointwise theorem, but it becomes one if every
single violation can be amplified into sufficiently many further violations
with controlled height and bounded overlap.

This branch isolates the exact theorem needed for that strategy.  It does not
assume that an amplification operation already exists.

Fix `epsilon>0`.  Let `E_epsilon(X)` denote the number of primitive triples
`a+b=c` with `c<=X` and

\[
  \operatorname{rad}(abc)<c^{1-\epsilon}.
\]

Suppose an exceptional-set theorem gives

\[
  E_\epsilon(X)\leq C_\epsilon X^\alpha
\]

for some `alpha<1`.

## 2. Abstract amplification theorem

### Theorem 2.1

Let `alpha,beta,gamma,kappa` be nonnegative real numbers.  Assume:

1. `E_epsilon(Y)<=C Y^alpha` for every `Y>=1`.
2. For every exceptional triple `T` of height `H(T) in [X,2X]`, there is a
   finite set `A(T)` of exceptional triples, each of height at most `X^kappa`,
   with

   \[
     |A(T)|\geq X^\beta.
   \]

3. Every exceptional triple of height at most `X^kappa` belongs to at most
   `X^gamma` of the sets `A(T)` with `H(T) in [X,2X]`.

Then the number `N_epsilon(X)` of exceptional triples in the dyadic shell
`[X,2X]` satisfies

\[
  N_\epsilon(X)
  \leq C X^{\gamma+\kappa\alpha-\beta}.
\]

In particular, if

\[
  \beta>\gamma+\kappa\alpha,
\]

there are no exceptional triples in `[X,2X]` for all sufficiently large `X`,
and the abc conjecture follows for this `epsilon`.

#### Proof

Count incidences

\[
  \mathcal I=
  \{(T,U): H(T)\in[X,2X],\ U\in A(T)\}.
\]

The lower bound in assumption 2 gives

\[
  |\mathcal I|\geq N_\epsilon(X)X^\beta.
\]

By assumption 3, every possible output `U` is counted at most `X^gamma`
times, while assumption 1 gives at most `C X^{kappa alpha}` possible outputs.
Hence

\[
  |\mathcal I|\leq C X^{\gamma+\kappa\alpha}.
\]

Comparison proves the result.

## 3. Why this is not merely a restatement of abc

The input `alpha<1` is already supplied by unconditional analytic number
theory.  The new problem is constructive: from one high-quality triple, build
many controlled high-quality triples.  The inequality

\[
  \beta>\gamma+\kappa\alpha
\]

quantifies exactly how much amplification is required.

The route is therefore testable.  A proposed transformation can be rejected
only after one proves that it fails to preserve the radical inequality, has
insufficient multiplicity, or has overlap too large to satisfy the displayed
criterion.

## 4. Candidate amplification mechanisms

The following mechanisms are retained as independent subroutes.

### 4.1 Level-structure amplification

Attach to the Frey curve of an exceptional triple many level-`ell` structures.
There are polynomially many such structures in `ell`.  The unresolved step is
to map them back to distinct rational abc triples while controlling both
height and radical.  Merely producing distinct points on a modular curve does
not satisfy Theorem 2.1.

### 4.2 Isogeny-orbit amplification

Use cyclic `ell`-isogenies of the Frey curve.  The unresolved step is to prove
that sufficiently many isogenous curves again admit Frey-Legendre models with
controlled radical.  The modular polynomial alone gives no such radical
control.

### 4.3 Polynomial-identity amplification

Search for identities

\[
  A_t+B_t=C_t
\]

parametrized by `t`, specializing at one known triple and preserving unusually
large prime powers.  Any candidate must be tested against the exact incidence
exponents `beta,gamma,kappa`.

### 4.4 Galois-orbit and norm amplification

Use conjugates of torsion or theta values and take norms to produce rational
integers.  The main difficulty is preventing the norm from introducing so
many new prime factors that the radical condition is destroyed.

## 5. Current external input

Current work proves power-saving exceptional-set bounds rather than
finiteness.  The amplification theorem above converts any such exponent into a
concrete quantitative design target.  This branch remains active until every
candidate amplification mechanism is either implemented or eliminated by a
strict counterexample or a theorem proving that its incidence exponents cannot
satisfy the criterion.
