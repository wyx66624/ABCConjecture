# The Steinberg packet as a Hodge twist

## 1. Purpose

The nonlinear Steinberg/sup-packet route already isolates the local Tate
coefficient

\[
 A_\ell=\frac{\ell-1}{12}.
\]

Its global target had an apparently conjectural geometric leading coefficient
`(ell-1)/2`.  This note proves that coefficient from the transformation law of
the cyclic kernel polynomial and the finite-monodromy geometry of the
projective-line representation.  The remaining problem is arithmetic, not the
geometric slope.

Throughout, `ell` is an odd prime.  Let `X(2)` denote the compactified
level-two modular stack, let `omega` be its Hodge line, and let

\[
 \mathcal P_\ell
\]

be the rank-`ell+1` finite local system whose fibre is the permutation space on
cyclic order-`ell` subgroups of the universal elliptic curve.  Its augmentation
subsystem is

\[
 \mathcal{St}_\ell
 =\ker\!\left(\mathcal P_\ell\longrightarrow\mathbf 1\right),
\]

of rank `ell`.  Over characteristic zero this is the Steinberg constituent of
the permutation representation on `P^1(F_ell)`.

## 2. Hodge weight of the cyclic kernel polynomial

Let `E/S` be an elliptic curve with origin `O`, and let
`C subset E[ell]` be a cyclic subgroup.  Put

\[
 \psi_C(X)=
 \prod_{\{P,-P\}\subset C\setminus\{O\}}
 (X-x(P)).
\]

There are `(ell-1)/2` factors.  The previously established divisor identity is

\[
 \operatorname{div}(\psi_C(x))
 =\sum_{P\in C\setminus\{O\}}(P)-(\ell-1)(O).
\tag{2.1}
\]

### Theorem 2.1 (exact Hodge weight)

Under an admissible scaling of Weierstrass coordinates

\[
 x=u^2x',\qquad y=u^3y',
\]

one has

\[
 \psi'_C(x')=u^{-(\ell-1)}\psi_C(x).
\tag{2.2}
\]

If `omega` and `omega'` are the corresponding invariant differentials, then

\[
 \omega'=u\omega,
\]

and therefore

\[
 \psi'_C(x')\,(\omega')^{\ell-1}
 =\psi_C(x)\,\omega^{\ell-1}.
\tag{2.3}
\]

Consequently the collection of cyclic kernel sections is naturally a
vector-valued section with Hodge twist `omega^(ell-1)`.

#### Proof

Every root scales as

\[
 x'(P)=u^{-2}x(P).
\]

Hence

\[
 \begin{aligned}
 \psi'_C(X')
 &=\prod_{\{P,-P\}}
    (X'-u^{-2}x(P))\\
 &=u^{-(\ell-1)}
   \psi_C(u^2X').
 \end{aligned}
\]

Substituting `X'=x'=u^{-2}x` gives (2.2).  The invariant differential satisfies

\[
 \frac{dx}{2y+\cdots}=u^{-1}
 \frac{dx'}{2y'+\cdots},
\]

so `omega'=u omega`.  Equation (2.3) follows.

### Corollary 2.2 (packet bundle)

After determinant-of-cohomology correction of the one-dimensional kernel and
cokernel of the evaluation map, the complete cyclic packet has the same
coordinate weight and is a section of

\[
 \omega^{\ell-1}\otimes\mathcal P_\ell.
\]

Its augmentation projection is a section of

\[
 \boxed{\mathcal W_\ell
 =\omega^{\ell-1}\otimes\mathcal{St}_\ell.}
\tag{2.4}
\]

The statement concerns transformation weight; it does not yet assert an
integral metric comparison.

## 3. Parabolic degree of the finite-monodromy factor

The monodromy of `mathcal P_ell` factors through the finite group
`SL_2(F_ell)` acting on `P^1(F_ell)`.  Equip the corresponding complex
representation with an invariant Hermitian metric obtained by averaging over
the finite group.  At the three cusps take the canonical Deligne/parabolic
extension determined by the finite local monodromy.

### Lemma 3.1 (finite-monodromy semistability)

The parabolic bundle underlying `mathcal{St}_ell` is polystable of parabolic
degree zero.  In particular,

\[
 \mu_{\max}^{\rm par}(\mathcal{St}_\ell)=0.
\tag{3.1}
\]

#### Proof

Pass to a finite orbifold cover on which the finite monodromy becomes trivial.
The parabolic pullback is the trivial Hermitian vector bundle.  A subbundle of
a trivial bundle on a smooth projective curve has degree at most zero: its
determinant injects into an exterior power of a trivial bundle, and a line
bundle of positive degree admits no nonzero map to the trivial line.  Thus the
pullback is semistable of degree zero.  Dividing degrees by the degree of the
cover gives parabolic semistability and parabolic degree zero downstairs.
The invariant Hermitian orthogonal decomposition into irreducible finite-group
representations gives polystability.

## 4. Exact geometric maximal slope

On the level-two modular stack, or equivalently in the associated parabolic
Picard group on the coarse lambda-line, the maximal Kodaira--Spencer relation
gives

\[
 \operatorname{pardeg}(\omega)=\frac12.
\tag{4.1}
\]

This is the stack/parabolic statement; the corresponding ordinary coarse line
square root is excluded by the already proved degree-parity obstruction.

### Theorem 4.1 (Steinberg packet slope)

For the bundle `mathcal W_ell` of (2.4),

\[
 \boxed{
 \mu_{\max}^{\rm par}(\mathcal W_\ell)
 =\frac{\ell-1}{2}.}
\tag{4.2}
\]

#### Proof

Tensoring a parabolic vector bundle by a parabolic line shifts every slope by
the parabolic degree of that line.  By Lemma 3.1 all slopes of
`mathcal{St}_ell` are zero, while

\[
 \operatorname{pardeg}(\omega^{\ell-1})
 =(\ell-1)\operatorname{pardeg}(\omega)
 =\frac{\ell-1}{2}.
\]

This proves (4.2).

### Corollary 4.2 (exact one-sixth coefficient)

The ratio of the geometric packet slope to the canonical local Tate
coefficient is exactly

\[
 \frac{(\ell-1)/2}{(\ell-1)/12}=6.
\tag{4.3}
\]

Thus the coefficient in the target inequality

\[
 \frac16Q\le (1+o(1))(D+N)+O(\log\ell)
\]

is forced by classical Hodge weight and finite-monodromy geometry.  No IUT
prime-strip identification is needed for this coefficient.

## 5. What this theorem closes

The following parts of the Steinberg route are now mathematically determined.

1. The cyclic kernel section has Hodge weight exactly `ell-1`.
2. The nontrivial projective-line packet is the Steinberg augmentation factor.
3. The finite-monodromy factor has parabolic maximal slope zero.
4. The complete geometric maximal slope is exactly `(ell-1)/2`, not merely an
   unspecified `O(ell)` quantity.
5. Its ratio with the canonical Tate coefficient is exactly six.

## 6. Remaining arithmetic theorem

The geometric result does **not** by itself prove an arithmetic
height--conductor inequality.  A complete proof still has to construct an
integral adelic metric on `mathcal W_ell` and prove simultaneously:

1. the determinant-of-cohomology section has the exact canonical and
   noncanonical Tate norms supplied by the cyclic theta-distribution formulas;
2. it is a unit at good places away from `ell`;
3. the level-prime and descent/different defects are `O(log ell)` after
   normalized degree;
4. the arithmetic maximal slope differs from the parabolic geometric value
   `(ell-1)/2` only by

   \[
   o(\ell)(D+N)+O(\ell\log\ell).
   \]

The first two items have now been reduced to explicit local theorems in the
kernel-polynomial, theta-distribution and good-place determinant branches.  The
decisive open content is the last arithmetic metric comparison.

## 7. Formalization boundary

The scalar coefficient identity is already kernel-checked elsewhere in the
repository.  A faithful Lean formalization of Theorems 2.1 and 4.1 requires
APIs for Weierstrass coordinate changes, the Hodge line, parabolic degree and
finite-monodromy bundles.  The mathematics is recorded first in accordance
with the repository policy; no placeholder axiom is introduced.
