# The exact one-sixth coefficient from the Legendre parabolic Hodge bundle

## 1. The globally labelled object

Let

\[
  U=\mathbb P^1\setminus\{0,1,\infty\}
\]

and let `f:E->U` be the Legendre family.  The three boundary divisors are
globally labelled before any arithmetic specialization.  This is the
additional structure missing from a fixed packet of geometric `ell`-torsion
lines.

Let `L=f_* Omega^1_{E/U}` be the Hodge line of the weight-one variation.  For
the Deligne/parabolic extension to `P^1`, the Kodaira--Spencer map is maximal:

\[
  L^{\otimes2}\simeq
  \Omega^1_{\mathbb P^1}(\log\{0,1,\infty\})
\]

in the natural orbifold or rational-line-bundle sense.  Since

\[
  \deg\Omega^1_{\mathbb P^1}(\log\{0,1,\infty\})=1,
\]

we have

\[
  \deg L=\frac12.
\]

## 2. Symmetric-power Hodge cost

For an odd prime `ell`, set `m=ell-1`.  The highest Hodge line in
`Sym^m R^1f_*` is `L^m`; therefore

\[
  \deg L^{\ell-1}=\frac{\ell-1}{2}.
\]

At a split Tate boundary, the canonical cyclic `ell`-line has local Neron
energy coefficient

\[
  A_\ell=\frac{\ell-1}{12}.
\]

### Theorem 2.1 (exact coefficient identity)

\[
  \frac{\deg L^{\ell-1}}{A_\ell}=6.
\]

Equivalently,

\[
  A_\ell=\frac16\deg L^{\ell-1}.
\]

This is exactly the coefficient required to transform the global Tate
q-weight into the logarithmic abc height.

## 3. Significance

The coefficient `1/6` is therefore not specific to a disputed prime-strip
normalization.  It is already encoded in two classical facts:

1. the canonical Tate-line Bernoulli energy is `(ell-1)/12`;
2. the Legendre variation is maximal Higgs, so its `(ell-1)`-st highest Hodge
   line has degree `(ell-1)/2`.

The identity also explains why a fixed three-line product was too expensive:
three independent Hodge lines would have three times the required degree.  The
correct object must be one globally labelled variation whose local monodromy
filtration changes with the cusp.

## 4. Arithmetic specialization target

The geometric coefficient identity does not by itself prove abc.  The missing
arithmetic theorem is now precise.

### Target theorem 4.1 (parabolic arithmetic specialization)

For every `epsilon>0`, construct an integral/parabolic metric on the highest
Hodge line `L^(ell-1)` such that for every primitive rational specialization
`lambda=a/c`:

1. its finite boundary contribution is

   \[
     \frac{\ell-1}{12}\,Q(a,b,c),
   \]

   where `Q` is the global Tate/discriminant weight;
2. its good finite places contribute zero;
3. its level-prime and metric-Jacobian error is `O(log ell)`;
4. its arithmetic degree is at most

   \[
     \frac{\ell-1}{2}
       (\log\operatorname{Diff}+\log\operatorname{Cond})
     +o_\ell(\ell)\,
       (\log\operatorname{Diff}+\log\operatorname{Cond})
     +O_\epsilon(\ell\log\ell).
   \]

Dividing by `(ell-1)/2` and using Theorem 2.1 gives

\[
  \frac16Q
  \le (1+o_\ell(1))
      (\log\operatorname{Diff}+\log\operatorname{Cond})
      +O(\log\ell).
\]

A quantifier-correct auxiliary prime with `log ell=o(log c)` then proves abc.

## 5. Remaining source-facing content

Target theorem 4.1 is a classical arithmetic intersection/slope statement,
not a categorical identification.  It requires:

- an integral Deligne extension of the symmetric-power Hodge line;
- exact comparison of its boundary metric with the canonical Tate-line Neron
  function;
- a good-place unit theorem;
- control at the level prime;
- an arithmetic maximal-slope or determinant estimate with the parabolic
  coefficient above.

The fixed-packet route and the generic full-orbit Minkowski selector have been
eliminated by rigorous cancellation theorems.  The globally labelled
three-cusp parabolic variation survives those counterexamples and remains an
active independent route.
