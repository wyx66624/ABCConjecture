# Fixed-depth isogeny amplification cannot close a power-saving exceptional set

## 1. Context

The exceptional-set route starts from an upper bound

\[
  E_\varepsilon(X)\ll X^\alpha,
  \qquad \alpha>0,
\]

and seeks an amplification operation producing at least `X^beta` controlled
exceptions from every one exception.  The incidence criterion requires

\[
  \beta>\gamma+\kappa\alpha,
\]

so in particular it requires a genuinely positive power `beta`.

One candidate is to attach cyclic isogenies to the Frey curve.  This note proves
that a fixed number of small-level isogeny steps cannot supply the required
power amplification.

## 2. Exact branching count

For a prime `ell`, cyclic order-`ell` subgroups of an elliptic curve over an
algebraic closure are the points of

\[
  \mathbf P^1(\mathbf F_\ell),
\]

hence there are exactly

\[
  \ell+1
\]

possible cyclic `ell`-isogenies from one curve, counted with their subgroup
labels.

A labelled path of depth `r` therefore has at most

\[
  (\ell+1)^r
\]

possible choices.  Collisions between endpoints can only decrease the number
of distinct output curves or output abc triples.

## 3. Subpolynomial-level no-go theorem

### Theorem 3.1

Let `r>=1` be fixed.  Suppose the level prime selected for an input of height
`X` satisfies

\[
  \log\ell(X)=o(\log X).
\]

Then the number of outputs obtainable from all labelled isogeny paths of depth
at most `r` is

\[
  X^{o(1)}.
\]

In particular, for every fixed `beta>0`, it is smaller than `X^beta` for all
sufficiently large `X`.

### Proof

The total number of paths of lengths at most `r` is bounded by

\[
  1+(\ell+1)+\cdots+(\ell+1)^r
  \leq (r+1)(\ell+1)^r.
\]

Taking logarithms gives

\[
  \log(r+1)+r\log(\ell+1)=o(\log X),
\]

because `r` is fixed and `log ell=o(log X)`.  Exponentiation gives the claim.

### Corollary 3.2

A fixed-depth isogeny construction at a quantifier-correct auxiliary prime with
subpolynomial size has amplification exponent

\[
  \beta=0.
\]

It cannot satisfy

\[
  \beta>\gamma+\kappa\alpha
\]

when `alpha>0` and `gamma,kappa>=0`.

## 4. Scope of the obstruction

This theorem eliminates only the following mechanism:

- one auxiliary prime `ell=X^{o(1)}`;
- a fixed number of cyclic `ell`-isogeny steps;
- at most one output for each labelled path.

It does **not** eliminate:

1. depth growing with `X`;
2. simultaneous use of many distinct level primes;
3. extraction of many arithmetic objects from one isogeny path;
4. a polynomial-size family of Hecke correspondences whose radical and height
   can be controlled;
5. amplification by modular points rather than only endpoint curves.

These surviving variants must still control height, radical preservation, and
overlap.  In particular, allowing depth to grow creates a new problem: modular
heights and the number of repeated/isomorphic endpoints also grow and must be
included in the exponents `kappa` and `gamma`.

## 5. Lean formalization

The accompanying Lean module formalizes the exact finite combinatorics: a
labelled depth-`r` path with `ell+1` choices per step is a function

`Fin r -> Fin (ell+1)`

and the type has cardinality `(ell+1)^r`.  The image of any endpoint map has
cardinality at most this number.  The asymptotic interpretation above remains
an analytic corollary to be formalized after a common asymptotic interface is
chosen.
