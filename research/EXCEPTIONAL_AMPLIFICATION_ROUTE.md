# Exceptional-set amplification route

## 1. Motivation

A sparsity theorem for abc violations becomes a pointwise theorem if every
single violation can be amplified into sufficiently many further violations
with controlled height and bounded overlap.

Fix `epsilon>0`. Let `E_epsilon(X)` denote the number of primitive triples
`a+b=c` with `c<=X` and

\[
  \operatorname{rad}(abc)<c^{1-\epsilon}.
\]

Suppose

\[
  E_\epsilon(X)\leq C_\epsilon X^\alpha
\]

for some `alpha<1`.

## 2. Abstract amplification theorem

### Theorem 2.1

Let `alpha,beta,gamma,kappa` be nonnegative real numbers. Assume:

1. `E_epsilon(Y)<=C Y^alpha` for every `Y>=1`.
2. For every exceptional triple `T` of height in `[X,2X]`, there is a finite
   set `A(T)` of exceptional triples, each of height at most `X^kappa`, with

   \[
     |A(T)|\geq X^\beta.
   \]

3. Every exceptional triple of height at most `X^kappa` belongs to at most
   `X^gamma` of the sets `A(T)` with input height in `[X,2X]`.

Then the number `N_epsilon(X)` of exceptional triples in `[X,2X]` satisfies

\[
  N_\epsilon(X)
  \leq C X^{\gamma+\kappa\alpha-\beta}.
\]

If

\[
  \beta>\gamma+\kappa\alpha,
\]

there are no exceptional triples in `[X,2X]` for all sufficiently large `X`.

#### Proof

Count incidences

\[
  \mathcal I=\{(T,U):T\text{ is in the shell and }U\in A(T)\}.
\]

Assumption 2 gives

\[
  |\mathcal I|\geq N_\epsilon(X)X^\beta.
\]

Assumptions 1 and 3 give

\[
  |\mathcal I|
  \leq X^\gamma E_\epsilon(X^\kappa)
  \leq C X^{\gamma+\kappa\alpha}.
\]

Comparison proves the result.

## 3. Research consequence

The inequality

\[
  \beta>\gamma+\kappa\alpha
\]

is a quantitative design target for level-structure, isogeny-orbit,
polynomial-identity, and Galois/norm amplification mechanisms. This route is
retained until the mechanisms are implemented or eliminated by strict
counterexamples or no-go theorems.
