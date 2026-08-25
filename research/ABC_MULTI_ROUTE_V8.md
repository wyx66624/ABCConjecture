# ABC multi-route research programme, version 8

This branch coordinates independent routes toward a proof or disproof of the
abc conjecture. It does not assume the correctness of IUT, ATS, or any other
claimed proof. Correct results from those theories may be imported only after
the exact numerical statement has been independently verified.

## New unconditional reductions

### 1. Powerful-core theorem

For a primitive triple `a+b=c`, put `R=rad(abc)` and
`exc(n)=n/rad(n)`. If `c>R^(1+epsilon)`, then

\[
  exc(a)exc(b)exc(c)>c^{\epsilon/(1+\epsilon)}.
\]

If `x=max(a,b)`, then

\[
  \max\{exc(x),exc(c)\}
  >2^{-1/2}c^{(1+2\epsilon)/(2(1+\epsilon))}.
\]

The canonical square divisor `t(n)^2` satisfies `t(n)^2>=exc(n)`, so every
counterexample has a polynomially large square core in one of its two largest
terms. This produces a primitive diagonal-conic equation

\[
  A x^2+B y^2=C z^2
\]

with squarefree `A,B,C` and a large square coordinate.

Detailed branch: `research/abc-powerful-core-v8`.

### 2. Exceptional-set amplification theorem

Suppose the number of exceptions up to `Y` is at most `C Y^alpha`. If each
exception of height in `[X,2X]` produces at least `X^beta` exceptions of height
at most `X^kappa`, and each output has at most `X^gamma` preimages, then the
number of input exceptions is at most

\[
  C X^{\gamma+\kappa\alpha-\beta}.
\]

Therefore `beta>gamma+kappa*alpha` implies finiteness. This turns current
power-saving exceptional-set estimates into a precise constructive target.

Detailed branch: `research/abc-exceptional-amplification-v8`.

### 3. Full-torsion cancellation and three-direction recovery

For a split Tate curve, the sum of local Neron heights over the canonical
cyclic `ell`-line is

\[
  \frac{\ell-1}{12}(-\log|q|),
\]

while every noncanonical line contributes

\[
  -\frac{\ell-1}{12\ell}(-\log|q|).
\]

The sum over all nonzero `ell`-torsion points is exactly zero. Thus a fully
Galois-symmetric torsion packet cannot see the Tate parameter.

The Frey-Legendre family has only three Picard-Lefschetz directions. If their
Tate weights are `W_0,W_1,W_infinity`, one of the three global cyclic lines has
score at least

\[
  \frac{(\ell-1)(\ell-2)}{36\ell}
  (W_0+W_1+W_\infty),
\]

and the sum of all three line scores is

\[
  \frac{(\ell-1)(\ell-2)}{12\ell}
  (W_0+W_1+W_\infty).
\]

Detailed branch: `research/abc-torsion-line-energy-v8`.

### 4. Classical three-line Hodge-Arakelov target

Tensor the three evaluation determinants attached to the nonzero points of the
three cyclic lines. Its finite multiplicative q-slope is

\[
  \kappa_\ell=\frac{(\ell-1)(\ell-2)}{12\ell}.
\]

A classical proof of abc is reduced to an explicit determinant estimate

\[
  \kappa_\ell Q
  \le K_\ell(D+N)+6\kappa_\ell E_\ell,
\]

with

\[
  \frac{K_\ell}{6\kappa_\ell}=1+o(1),
  \qquad E_\ell=O(\log\ell).
\]

The unresolved inputs are an asymptotically sharp archimedean theta-determinant
bound and a normalized different estimate for cyclic-line fields of degree at
most `ell+1`.

Detailed branch: `research/abc-classical-hodge-arakelov-v8`.

## Retained independent routes

- uniform radical-height bounds on varying diagonal conics;
- exceptional-set amplification by level structures, isogenies, polynomial
  identities, or norms;
- the three-line determinant route;
- uniform S-unit bounds with essentially linear support dependence;
- modular/Szpiro estimates specialized to full rational 2-torsion Frey curves;
- arithmetic-differentiation replacements that are not derivations of `Z`;
- corrected normed theta comparisons, treated as one route rather than as an
  assumed theorem;
- probabilistic/entropy methods plus a deterministic exceptional-set theorem.

## Elimination policy

No route is removed because it is unconventional, incomplete, or presently
lacks a library implementation. A route may be closed only after a concrete
counterexample, a logical contradiction, or a theorem proving that its
required quantitative implication is impossible.

## Current closest target

The closest new target is the classical three-line determinant estimate. It
uses only conventional elliptic curves, cyclic torsion subgroups, Neron local
functions, determinant lines, Haar/Arakelov norms, and the number-field product
formula. It is independent of the disputed IUT/ATS Rosetta identification.

A seven-page conventional paper draft containing the proofs above has been
prepared as `ChatGPT_ABC_MultiRoute_Research_v8_0.tex`; it will be expanded on
this branch as the archimedean determinant and cyclic-line-field different
estimates are attacked.
