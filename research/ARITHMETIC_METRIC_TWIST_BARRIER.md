# The arithmetic metric-twist barrier

## 1. Purpose

The Steinberg packet has now been identified geometrically as

\[
 \mathcal W_\ell=\omega^{\ell-1}\otimes\mathcal{St}_\ell,
\]

with exact parabolic maximal slope

\[
 \mu_{\max}^{\rm par}(\mathcal W_\ell)=\frac{\ell-1}{2}.
\]

The full torsion-field root discriminant and the good finite-place determinant
lattices are also controlled.  This note proves that these algebraic and finite
place data do not, by themselves, bound the **arithmetic** maximal slope.  An
explicitly normalized archimedean/theta metric is indispensable.

## 2. Metric twisting

Let `K` be a number field and let

\[
 \overline E=(E,(\Lambda_v)_{v<\infty},(\|\cdot\|_\sigma)_{\sigma\mid\infty})
\]

be an adelic Hermitian vector bundle of positive rank `r`.  For `T in R`,
define the uniform archimedean twist

\[
 \overline E\langle T\rangle
\]

by leaving the algebraic vector space and every finite lattice unchanged and
setting, at every archimedean embedding,

\[
 \|x\|_{\sigma,T}=e^{-T}\|x\|_\sigma.
\tag{2.1}
\]

### Theorem 2.1 (degree and slope shift)

With the standard normalized Arakelov degree convention,

\[
 \widehat{\deg}(\overline E\langle T\rangle)
 =\widehat{\deg}(\overline E)+rT,
\tag{2.2}
\]

and

\[
 \widehat\mu_{\max}(\overline E\langle T\rangle)
 =\widehat\mu_{\max}(\overline E)+T.
\tag{2.3}
\]

#### Proof

For a rank-`s` subspace `F`, the determinant norm is multiplied by
`e^{-sT}` at each normalized archimedean component.  The negative logarithm of
that norm, hence the arithmetic degree of `F`, increases by `sT`.  Therefore
its slope increases by `T`.  Taking the maximum over all nonzero subspaces
gives (2.3); taking `F=E` gives (2.2).

### Corollary 2.2 (unboundedness at fixed algebraic data)

Fix:

- the algebraic bundle `E`;
- all finite integral lattices;
- the parabolic structure and geometric degree;
- the conductor and every descent-field discriminant.

Then

\[
 \sup_T\widehat\mu_{\max}(\overline E\langle T\rangle)=+\infty.
\]

Thus no upper bound for arithmetic maximal slope can follow solely from those
fixed data.

## 3. Product-formula distinction

If the metric change is induced by multiplying a rational section by one
algebraic scalar, the finite and infinite changes satisfy the product formula
and the global degree is unchanged.  The twist (2.1) is deliberately not such
a scalar rescaling: it changes the metrization itself while keeping the finite
lattices fixed.

Consequently a valid proof must show that its metric is canonically determined
by the theta/determinant construction and compare that canonical metric to the
integral lattice at every place.  Merely naming a Hodge, Faltings, Quillen, sup,
or Euclidean metric is insufficient unless the normalization and all
Jacobians are fixed.

## 4. Consequence for the Steinberg packet

The following ingredients remain valid and useful:

1. Hodge weight `ell-1`;
2. parabolic geometric slope `(ell-1)/2`;
3. exact canonical/noncanonical Tate norms;
4. unitness at good finite places;
5. root-discriminant control by conductor plus `O(log ell)`.

But they imply the desired arithmetic inequality only after proving a metric
comparison of the form

\[
 \widehat\mu_{\max}(\overline{\mathcal W}_\ell^{\rm can})
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)(D+N)
 +O(\ell\log\ell),
\tag{4.1}
\]

for one explicitly constructed canonical adelic metric.  Theorem 2.1 prevents
(4.1) from being inferred from the underlying parabolic bundle alone.

## 5. Relation to existing no-go theorems

This theorem is distinct from the primitive-covector counterexample.  That
counterexample shows that an arbitrary quotient line can have large height in
a fixed Euclidean lattice.  The present theorem shows that even the ambient
arithmetic slope itself is undefined up to an arbitrary additive constant
until the archimedean metric is normalized.

Neither theorem refutes the canonical theta/Hecke packet route.  Together they
specify the exact remaining source theorem:

\[
 \boxed{\text{canonical metric construction plus a global metric comparison}.}
\]

## 6. Formalization boundary

The accompanying Lean module verifies the scalar degree/slope identities and
the resulting unboundedness.  A full Arakelov-vector-bundle formalization will
replace the scalar model once the necessary determinant-norm APIs are available.
No arithmetic slope inequality is inserted as an axiom.
