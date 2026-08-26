# Obstruction to a constant rank-two characteristic-zero lift

## 1. Purpose

Over `F_ell`, the projective permutation module modulo constants is explicitly
isomorphic to `Sym^(ell-1)(F_ell^2)^*`.  It is tempting to interpret this as a
characteristic-zero symmetric power of a constant rank-two representation and
to apply an ordinary Hodge slope estimate.

For growing auxiliary primes this interpretation is impossible.  The finite
interpolation theorem is genuinely characteristic `ell`.  A successful global
lift must be geometric and semilinear over the full-level modular cover, not a
constant two-dimensional complex representation of `GL_2(F_ell)`.

## 2. The two-dimensional representation obstruction

### Theorem 2.1

Let `ell>=7` be prime.  Every two-dimensional complex representation

\[
  \rho:\operatorname{SL}_2(\mathbf F_\ell)
       \longrightarrow\operatorname{GL}_2(\mathbf C)
\]

is trivial.

### Proof

Because the group is finite, every complex representation is semisimple.

If `rho` is reducible, it is a direct sum of one-dimensional characters.  The
group `SL_2(F_ell)` is perfect for `ell>=5`, hence has no nontrivial complex
characters.  The representation is therefore trivial.

Suppose that `rho` is irreducible.  By Schur's lemma the center acts by
scalars, so projectivization produces

\[
  \bar\rho:
  \operatorname{PSL}_2(\mathbf F_\ell)
  \longrightarrow\operatorname{PGL}_2(\mathbf C).
\]

The group `PSL_2(F_ell)` is nonabelian simple for `ell>=5`.  Since an
irreducible two-dimensional representation is not scalar, `bar rho` is
nontrivial; simplicity makes it injective.

The finite subgroups of `PGL_2(C)` are cyclic, dihedral, `A_4`, `S_4`, and
`A_5`.  The only nonabelian simple group in this list is `A_5`, of order sixty.
But

\[
 |\operatorname{PSL}_2(\mathbf F_\ell)|
 =\frac{\ell(\ell^2-1)}2>60
\]

for `ell>=7`.  This contradiction excludes the irreducible case.

### Corollary 2.2

Every two-dimensional complex representation of `GL_2(F_ell)` is trivial on
`SL_2(F_ell)` and hence factors through the determinant quotient
`F_ell^x`.

In particular, no such representation can have a reduction modulo `ell` whose
restriction to `SL_2(F_ell)` is the natural two-dimensional module.

## 3. Consequence for the symmetric-power interpolation route

The isomorphism

\[
 \mathbf F_\ell[\mathbf P^1(\mathbf F_\ell)]/\mathbf F_\ell\mathbf1
 \simeq
 \operatorname{Sym}^{\ell-1}(\mathbf F_\ell^2)^\vee
\]

cannot be lifted by choosing a constant rank-two complex representation `W`
and replacing the right side by `Sym^(ell-1)(W^*)`.

This is a strict no-go theorem for the **constant representation lift**.  It
does not refute the active geometric route, because on a full-level modular
cover the deck group acts semilinearly:

- it moves the base point;
- it pulls back the Hodge/de Rham bundle;
- it need not act through one fixed two-dimensional complex fiber.

Thus a surviving theta--symmetric-power morphism must be a morphism of
Galois-equivariant vector bundles or local systems on the modular cover, with
its descent cocycle, metrics and level-prime reduction recorded explicitly.

## 4. Corrected global target

The target is not

\[
 \operatorname{St}_\ell(\mathbf C)
 \cong\operatorname{Sym}^{\ell-1}(W)
\]

for a constant two-dimensional `W`.  It is a geometric morphism

\[
 \mathcal V_\ell^{\rm theta}
 \longrightarrow
 \operatorname{Sym}^{\ell-1}(\mathcal H_{\rm dR})^\vee
 \otimes\mathcal J_\ell
\]

on a full-level modular stack, or an equivalent correspondence after derived
pushforward to the base.  Its reduction at the level prime may be the finite
interpolation map, even though no constant characteristic-zero representation
lift exists.

The morphism must satisfy:

1. semilinear deck equivariance;
2. good-place integrality;
3. exact compatibility with the cyclic theta distribution identities;
4. `O(ell log ell)` archimedean and level-prime operator cost;
5. a descent/different estimate compatible with the final maximal-slope
   inequality.

## 5. Route policy

The constant rank-two representation version is eliminated by Theorem 2.1.
The geometric modular-bundle version remains active because the theorem does
not apply to semilinear bundle actions over a moving base.

## 6. Formalization boundary

A Lean formalization naturally divides into:

1. perfectness and absence of one-dimensional characters of `SL_2(F_ell)`;
2. the abstract statement that an irreducible two-dimensional representation
   gives a projective embedding of the simple central quotient;
3. the classification of finite subgroups of `PGL_2(C)`.

The third item is not currently available as a Mathlib theorem and should not
be inserted as an axiom.  Formalization is deferred until that classical
classification is implemented or replaced by an independently formalizable
character-degree lower bound.
