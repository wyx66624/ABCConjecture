# Legendre stack parity and the corrected Hodge--Arakelov route

## 1. Purpose

The v8 Legendre route isolated the numerically attractive identity

\[
  \frac{(\ell-1)/2}{(\ell-1)/12}=6.
\]

Before using it arithmetically, one must identify the geometric object whose
Hodge degree is `1/2`.  This document proves that it cannot be an ordinary line
bundle on the coarse Legendre base.  The half degree is necessarily stacky or
parabolic.  This is a strict correction of the coarse formulation, not a
rejection of the globally labelled three-cusp route.

## 2. The coarse logarithmic cotangent line

Let

\[
  X=\mathbf P^1,
  \qquad
  D=\{0,1,\infty\}.
\]

Since `K_X = O_X(-2)` and `D` has degree three,

\[
  \Omega_X^1(\log D)
  \simeq K_X(D)
  \simeq \mathcal O_X(1).
\]

In particular,

\[
  \deg \Omega_X^1(\log D)=1.
\]

## 3. Coarse square-root obstruction

### Theorem 3.1

There is no ordinary algebraic line bundle `L` on `P^1` satisfying

\[
  L^{\otimes2}\simeq\Omega_X^1(\log D).
\]

### Proof

Every line bundle on `P^1` has an integral degree.  If such an `L` existed,
then additivity of degree under tensor product would give

\[
  2\deg L
  =\deg\Omega_X^1(\log D)
  =1,
\]

which is impossible in `Z`.

### Corollary 3.2

The statement

\[
  L^{\otimes2}\simeq
  \Omega_{\mathbf P^1}^1(\log\{0,1,\infty\}),
  \qquad \deg L=\frac12,
\]

cannot be interpreted in the category of ordinary line bundles on the coarse
projective line.

## 4. Where the half degree actually lives

The moduli problem with full level-two structure still has the generic
involution `[-1]`: it fixes every two-torsion point, hence fixes the level-two
structure, while it acts by `-1` on an invariant differential.  Consequently
the Hodge line has nontrivial generic `mu_2` character and does not descend as
an ordinary line bundle to the coarse `lambda`-line.

Its square has trivial generic character and does descend.  The
Kodaira--Spencer relation is therefore correctly interpreted on the modular
stack, or equivalently in a parabolic/orbifold rational Picard group:

\[
  \omega^{\otimes2}
  \simeq
  \Omega^1(\log D),
  \qquad
  \deg_{\rm par}(\omega)=\frac12.
\]

Thus the numerical ratio six may survive, but only after every arithmetic
degree, metric, Jacobian, and specialization map is normalized in the same
stacky/parabolic category.

## 5. A strict no-go theorem for the naive coarse route

The following proposed proof mechanism is impossible:

1. choose an ordinary coarse line bundle `L` on `P^1`;
2. identify `L^2` with `Omega^1(log D)`;
3. use the integral arithmetic degree of `L` as `(1/2)` times the logarithmic
   cotangent degree.

Step 2 contradicts Theorem 3.1.  Therefore a coarse-line arithmetic
specialization theorem cannot supply the desired coefficient.

This excludes only the **coarse ordinary-line formulation**.  It does not
exclude:

- the Hodge line on the level-two modular stack;
- a `mu_2`-gerbe or root-stack formulation;
- a parabolic `Q`-line bundle with degree `1/2`;
- an equivalent adelic construction that explicitly records the stabilizer
  character and all descent Jacobians.

## 6. Corrected arithmetic target

Let `mathcal X(2)` denote the compactified level-two modular stack, let `omega`
be its Hodge line, and let `D` be its three cusp divisors.  A valid classical
route must prove the following statement in the stacky/parabolic category.

### Target theorem 6.1 (stack-correct arithmetic specialization)

For every `epsilon>0`, choose an auxiliary prime `ell` and construct an
integral adelic metric on `omega^(ell-1)` such that for every primitive
specialization `lambda=a/c`:

1. the finite multiplicative boundary term is

   \[
     \frac{\ell-1}{12}Q(a,b,c);
   \]

2. the ordinary good places contribute zero;
3. the level-prime, stabilizer-descent, and metric-Jacobian defects total

   \[
     O(\ell\log\ell);
   \]

4. the stack-normalized arithmetic degree satisfies

   \[
   \widehat{\deg}_{\rm par}
      \bigl(\lambda^*\overline\omega^{\,\ell-1}\bigr)
   \le
   \left(\frac{\ell-1}{2}+o_\ell(\ell)\right)
      (\log\operatorname{Diff}+\log\operatorname{Cond})
   +O_\epsilon(\ell\log\ell).
   \]

The geometric identity

\[
  \deg_{\rm par}(\omega^{\ell-1})
  =\frac{\ell-1}{2}
  =6\cdot\frac{\ell-1}{12}
\]

would then yield

\[
  \frac16Q
  \le
  (1+o_\ell(1))
  (\log\operatorname{Diff}+\log\operatorname{Cond})
  +O(\log\ell),
\]

and the existing quantifier-correct auxiliary-prime absorption would imply
`abc`.

## 7. New proof obligations created by the correction

The corrected route must now prove, rather than suppress, the following four
compatibilities.

1. **Stack-to-coarse height comparison.**  Relate the parabolic arithmetic
   degree on `mathcal X(2)` to the ordinary logarithmic height of `a/c`.
2. **Generic stabilizer normalization.**  Show exactly how the generic
   `mu_2` character contributes to the metric and to normalized degrees.
3. **Integral extension at the cusps.**  Construct the Deligne/parabolic
   extension whose local norm has the canonical Tate Bernoulli slope.
4. **Specialization Jacobian.**  Track the Jacobian/different introduced when
   a rational Frey specialization is lifted to the stack and then compared
   with the coarse arithmetic model.

These are falsifiable arithmetic statements.  The branch is retained unless
the stack-correct target is contradicted by a concrete family or a rigorous
slope obstruction.

## 8. Formalization boundary

The accompanying Lean module proves the abstract degree-parity theorem:
whenever a degree function is additive under tensor product, a degree-one
object cannot be the square of an object of integral degree.  Formalizing the
actual modular stack, Hodge bundle, and parabolic arithmetic metric remains a
separate geometric development.
