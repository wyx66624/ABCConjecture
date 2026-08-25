# ABC multi-route research programme, version 8.2

This branch coordinates independent routes toward a proof or disproof of the
abc conjecture. It does not assume the correctness of IUT, ATS, or any other
claimed proof. Correct results from those theories may be imported only after
the exact numerical statement has been independently verified.

## New unconditional reductions and no-go theorems

### 1. Powerful cores and the square--cube horizon

For `n=prod p^e_p` and `k>=2`, define

\[
 U_k(n)=\prod_pp^{\lfloor e_p/k\rfloor}.
\]

Then

\[
 U_k(n)^k\ge n/\operatorname{rad}(n)^{k-1}.
\]

If a primitive triple satisfies

\[
 c>\operatorname{rad}(abc)^{1+\epsilon},
\]

then

\[
 U_k(abc)^k
 >c^{(3+2\epsilon-k)/(1+\epsilon)}(1-1/c).
\]

For arbitrarily small positive `epsilon`, only `k=2` and `k=3` give a
polynomially growing fixed-power core.  Thus the pure multiplicity route has two
canonical outputs:

\[
 Ax^2+By^2=Cz^2,
 \qquad
 Ax^3+By^3=Cz^3,
\]

with squarefree or cube-free coefficients. Higher-power cores require extra
arithmetic input.

### 2. Exceptional-set amplification

If exceptions up to `Y` are `O(Y^alpha)`, and every exception of height `X`
produces `X^beta` outputs of height at most `X^kappa`, with overlap at most
`X^gamma`, then

\[
 N_\epsilon(X)=O(X^{\gamma+\kappa\alpha-\beta}).
\]

Hence

\[
 \beta>\gamma+\kappa\alpha
\]

implies eventual emptiness.

Two proposed amplifier subclasses are now eliminated.

#### Exact three-point rational maps

For a degree-`d` rational map `f:P^1->P^1`, Riemann--Hurwitz gives

\[
 |f^{-1}(\{0,1,\infty\})|\ge d+2.
\]

Therefore exact support preservation forces `d=1`, giving only one of the six
anharmonic permutations. A degree-`d>1` map introduces at least `d-1` new
boundary points.

#### Rational cyclic isogenies over `Q`

The Mazur--Kenku classification gives an absolute bound for the number of
rational cyclic subgroup schemes of an elliptic curve over `Q`. A rational
isogeny amplifier therefore has `beta=0` and cannot satisfy the amplification
criterion for a positive exceptional-set exponent.

Varying maps, growing number fields, Galois-orbit norms, and controlled descent
remain active.

### 3. Local torsion-line energy and its global obstruction

For a split Tate curve, the canonical cyclic `ell`-line contributes

\[
 A_\ell(-\log|q|),
 \qquad A_\ell=\frac{\ell-1}{12},
\]

while every noncanonical line contributes

\[
 B_\ell(-\log|q|),
 \qquad B_\ell=-\frac{\ell-1}{12\ell}.
\]

The full nonzero torsion packet cancels exactly. More generally, every fixed
place-independent weighted packet has zero average over the transitive
projective Galois orbit.

A generic CRT/Minkowski selector retains only a `1/(ell+1)` fraction of local
projective depth, and

\[
 B_\ell+\frac{A_\ell-B_\ell}{\ell+1}=0.
\]

Thus fixed packets and generic full-orbit selectors are excluded. Locally
adaptive filtrations or globally labelled pre-specialization geometry remain
active.

### 4. Cyclic-line different and good-place determinant unitness

For a semistable elliptic curve with transitive projective mod-`ell` image, a
cyclic-line field `L_C` satisfies

\[
 [L_C:\mathbb Q]=\ell+1,
\]

and

\[
 \frac1{\ell+1}\log|D_{L_C}|
 \le
 \frac{\ell-1}{\ell+1}\log N_E+2\log\ell.
\]

At a good finite place of residue characteristic different from `ell`, the
cyclic subgroup extends as a finite etale subgroup scheme.  The exact sequence

\[
 0\to O_E((\ell-1)e-D)
 \to O_E((\ell-1)e)
 \to O_D((\ell-1)e)\to0
\]

is integral, and `O_E((ell-1)e-D)` is trivial because the nonzero cyclic points
sum to the zero section.  Its determinant-of-cohomology isomorphism is therefore
an isomorphism of free rank-one valuation-ring modules and has norm one.  Thus
good finite places contribute exactly zero determinant defect.

### 5. Closest surviving classical target

The globally labelled Legendre three-cusp variation remains active.  Its Hodge
line has parabolic degree `1/2`, so the highest line in the `(ell-1)`-st
symmetric power has degree `(ell-1)/2`.  Dividing by the canonical Tate-line
coefficient `(ell-1)/12` gives the exact factor six.

The remaining theorem is an arithmetic specialization/maximal-slope estimate
whose finite boundary term is `(ell-1)Q/12`, whose good-place defect is now
zero, whose level-prime/Jacobian error is `O(ell log ell)`, and whose leading
arithmetic degree is `(ell-1)/2+o(ell)` times different plus conductor.

If proved, this yields

\[
 Q/6\le(1+o(1))(\operatorname{Diff}+\operatorname{Cond})+O(\log\ell),
\]

and hence abc after quantifier-correct auxiliary-prime selection.

## Retained independent routes

- square-core diagonal conics and cube-core diagonal genus-one curves;
- exceptional-set amplification using varying maps, growing fields, polynomial
  identities with quantified new factors, or norm/descent constructions;
- locally adaptive torsion-line and parabolic Hodge--Arakelov slopes;
- IUT/ATS only through independently verified normed comparisons;
- uniform varying-`S` unit estimates;
- modular/Szpiro estimates specialized to full rational 2-torsion Frey curves;
- arithmetic-differentiation substitutes;
- probabilistic/entropy methods plus deterministic exceptional-set elimination;
- explicit computational searches for a fixed-epsilon counterexample family.

## Elimination policy

No route is removed because it is unconventional, incomplete, or presently
lacks a library implementation. A route may be closed only after a concrete
counterexample, a logical contradiction, or a theorem proving that its required
quantitative implication is impossible.

## Formalization order

The new mathematical package is intentionally kept on a research branch before
Lean formalization. The next formal targets are:

1. the finite combinatorial form of the amplification incidence theorem;
2. the power-core inequalities in `Nat` and `Real.log` form;
3. the finite-set average cancellation identities;
4. the determinant-line good-place unit theorem once the required algebraic
   geometry API is available;
5. a formal Riemann--Hurwitz import or a separate function-field proof of the
   three-point no-go theorem.

No theorem in this document claims an unconditional proof or disproof of abc.
