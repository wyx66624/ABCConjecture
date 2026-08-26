# Stack and parabolic correction for the Legendre Hodge line

## 1. Purpose

The v8 programme identifies the coefficient `1/6` through the relation between
the canonical Tate-line Bernoulli energy and the Hodge bundle of the Legendre
variation.  This branch audits the geometric category in which that relation
is valid.

The conclusion is a correction, not a rejection of the route:

- the required square-root relation cannot hold for ordinary line bundles on
  the coarse projective line;
- it does hold in the parabolic/orbifold category, where the half-integral
  contribution at infinity is retained;
- any arithmetic specialization theorem must therefore carry the parabolic
  weight, or pass to a finite stack-killing cover and record the resulting
  ramification and Jacobian terms.

## 2. Parity obstruction on the coarse projective line

Let

\[
  X=\mathbb P^1,
  \qquad
  D=\{0,1,\infty\}.
\]

Then

\[
  \deg\Omega_X^1(\log D)=-2+3=1.
\]

### Theorem 2.1 (coarse-line no-go)

There is no ordinary algebraic line bundle `L` on `P^1` such that

\[
  L^{\otimes2}\simeq\Omega_X^1(\log D).
\]

#### Proof

Every line bundle on `P^1` has integral degree.  Taking degrees in the proposed
isomorphism would give

\[
  2\deg L=1,
\]

which is impossible.

### Consequence

Any statement of the form

\[
  L^{\otimes2}=\Omega^1_{\mathbb P^1}(\log\{0,1,\infty\})
\]

for the Legendre variation must be interpreted on a stack, as a parabolic line
bundle, or after a ramified cover.  Treating it as an ordinary line-bundle
identity loses a half-integral boundary contribution.

## 3. Where the half weight comes from

The period equation of the Legendre family is the hypergeometric equation

\[
 \lambda(1-\lambda)f''+(1-2\lambda)f'-\frac14f=0.
\]

Its local exponents are

\[
 (0,0)\text{ at }0,
 \qquad
 (0,0)\text{ at }1,
 \qquad
 (1/2,1/2)\text{ at }\infty.
\]

Thus the local monodromy at infinity has semisimple part `-1`.  The Deligne
extension of the weight-one variation consequently carries a parabolic weight
`1/2` at infinity.  This is the geometric origin of the missing half degree on
the coarse line.

Let `L_par` denote the parabolic Hodge line.  For the maximal-Higgs Legendre
variation, the parabolic Kodaira--Spencer map is an isomorphism

\[
  L_{\rm par}^{\otimes2}
  \simeq
  \Omega_X^1(\log D)
\]

in the parabolic category.  Taking parabolic degrees gives

\[
  2\,\operatorname{pardeg}L_{\rm par}=1,
\]

and hence

\[
  \operatorname{pardeg}L_{\rm par}=\frac12.
\]

The same conclusion may be obtained after passing to a finite cover that kills
the order-two semisimple monodromy, but then the cover degree, ramification,
and descent back to the coarse base must be included explicitly.

## 4. Correct coefficient identity

For an odd prime `ell`, the highest Hodge line in the `(ell-1)`-st symmetric
power has parabolic degree

\[
  \operatorname{pardeg}
  L_{\rm par}^{\ell-1}
  =\frac{\ell-1}{2}.
\]

The canonical Tate cyclic line has local Bernoulli/Neron coefficient

\[
  A_\ell=\frac{\ell-1}{12}.
\]

Therefore the exact identity is

\[
  \frac{
   \operatorname{pardeg}L_{\rm par}^{\ell-1}
  }{A_\ell}=6.
\]

The coefficient `1/6` survives the audit, but it is a **parabolic degree
identity**, not an identity of ordinary line-bundle degrees on the coarse
`P^1`.

## 5. The two natural arithmetic realizations

A rigorous arithmetic proof may follow either of two equivalent frameworks.

### 5.1 Arithmetic parabolic bundle

Work directly with an arithmetic parabolic line bundle on

\[
 (\mathbb P^1;0,1,\infty),
\]

including the weight `1/2` at infinity.  The arithmetic degree must then
contain:

1. the ordinary finite and archimedean metric contributions;
2. the explicit parabolic boundary term;
3. the model-change and different terms at the additive/potentially
   multiplicative infinity fibre.

### 5.2 Stack-killing finite cover

Pass to a finite cover on which the semisimple part of the monodromy becomes
unipotent and the Hodge square root becomes an honest line bundle.  One must
then prove:

1. the degree and metric estimate upstairs;
2. the exact ramification divisor of the cover;
3. the Jacobian/Haar correction;
4. descent of the final inequality with normalized degree weights.

The two approaches are numerically equivalent only after all these terms are
included.

## 6. Corrected arithmetic target

The surviving source theorem is the following.

### Target 6.1 (parabolic arithmetic specialization)

For every `epsilon>0`, construct a metrized parabolic extension of the highest
Hodge line such that, for every primitive rational specialization
`lambda=a/c`, its arithmetic parabolic degree satisfies:

1. finite boundary contribution

   \[
     \frac{\ell-1}{12}Q(a,b,c);
   \]

2. zero defect at good finite places;
3. total level-prime, infinity-weight, different, and Jacobian error

   \[
     O(\ell\log\ell)+O_\epsilon(\ell);
   \]

4. upper slope estimate

   \[
   \widehat{\operatorname{pardeg}}
   \le
   \left(\frac{\ell-1}{2}+o_\ell(\ell)\right)
   (\log\operatorname{Diff}+\log\operatorname{Cond})
   +O_\epsilon(\ell\log\ell).
   \]

Dividing by `(ell-1)/2` and using the verified parabolic coefficient identity
would yield

\[
 \frac16Q
 \le
 (1+o_\ell(1))
 (\log\operatorname{Diff}+\log\operatorname{Cond})
 +O(\log\ell).
\]

A quantifier-correct auxiliary prime with `log ell=o(log c)` would then imply
abc.

## 7. Route status

The ordinary coarse-line square-root formulation is excluded by the degree
parity theorem.  The parabolic/stack formulation is not excluded and is the
correct successor route.  Its geometric coefficient is understood; the
arithmetic metric and specialization estimate in Target 6.1 remain unproved.
