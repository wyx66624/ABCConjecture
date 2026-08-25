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

### 3. Local torsion-line energy and its global obstruction

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

At one fixed place, the three Picard-Lefschetz directions of the
Frey-Legendre family satisfy a positive concentration theorem. If their local
weights are `W_0,W_1,W_infinity`, one direction has score at least

\[
  \frac{(\ell-1)(\ell-2)}{36\ell}
  (W_0+W_1+W_\infty).
\]

However, a second theorem proves that every fixed place-independent weighted
packet cancels after transitive projective Galois averaging. For fixed weights
`w_D` and canonical line `C`, put

\[
 S_C(w)=A_\ell w_C+B_\ell\sum_{D\ne C}w_D,
\]

where `A_ell=(ell-1)/12` and `B_ell=-(ell-1)/(12ell)`. Then

\[
 \frac1{\ell+1}\sum_C S_C(w)=0.
\]

This is a strict no-go theorem for the naive fixed three-line determinant.
The corrected route must use locally adaptive canonical-line filtrations and
an adelic slope/selection theorem.

Detailed branch: `research/abc-torsion-line-energy-v8`.

### 4. Corrected classical adelic Hodge-Arakelov target

At each multiplicative place, enhance the local norm in the canonical inertia
line selected by the three-direction concentration theorem. These local
choices define an adelic filtered two-dimensional representation rather than
one fixed global cyclic subgroup.

A classical proof of abc is reduced to an explicit maximal-slope estimate

\[
  \kappa_\ell Q
  \le K_\ell(D+N)+6\kappa_\ell E_\ell,
  \qquad
  \kappa_\ell=\frac{(\ell-1)(\ell-2)}{12\ell},
\]

with

\[
  \frac{K_\ell}{6\kappa_\ell}=1+o(1),
  \qquad E_\ell=O(\log\ell).
\]

The normalized different of a cyclic-line field is already controlled. If
`L_C` is the field of one cyclic line and the projective image is transitive,
then

\[
  \frac1{\ell+1}\log|D_{L_C}|
  \le
  \frac{\ell-1}{\ell+1}\log N_E+2\log\ell.
\]

The decisive unresolved input is now an asymptotically sharp adelic
maximal-slope/archimedean estimate for the place-dependent canonical-line
filtrations, together with good-place integral unitness.

Detailed branch: `research/abc-classical-hodge-arakelov-v8`.

## Retained independent routes

- uniform radical-height bounds on varying diagonal conics;
- exceptional-set amplification by level structures, isogenies, polynomial
  identities, or norms;
- the locally adaptive adelic torsion-line route;
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

The fixed place-independent three-line packet has now been excluded by the
Galois-average cancellation theorem. The broader torsion-energy route remains
active in its locally adaptive adelic form.

## Current closest target

The closest new target is the adelic maximal-slope estimate for the
place-dependent canonical inertia-line filtrations. It uses conventional
elliptic curves, local Neron functions, adelic norms, Arakelov slopes, and the
number-field product formula. It is independent of the disputed IUT/ATS
Rosetta identification, while the cancellation theorem prevents us from
mistaking a fixed packet for a valid global source.

An eight-page conventional paper draft containing the proofs and the corrected
no-go theorem has been prepared as
`ChatGPT_ABC_MultiRoute_Research_v8_0.tex`; it will be expanded as the adelic
slope and good-place integral estimates are attacked.