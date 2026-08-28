# Fixed parabolic divisors do not truncate contact multiplicity

## 1. Boundary contact for a rational Legendre point

Let

\[
  U=\mathbb P^1\setminus\{0,1,\infty\}.
\]

For a primitive positive triple `a+b=c`, write

\[
  \lambda=\frac ac.
\]

At a rational prime `p`, the three boundary contact orders are

\[
  m_{0,p}=v_p(a),
  \qquad
  m_{1,p}=v_p(b),
  \qquad
  m_{\infty,p}=v_p(c).
\]

Pairwise coprimality implies that at most one of the three is positive.

Let

\[
  D=\alpha_0[0]+\alpha_1[1]+\alpha_\infty[\infty]
\]

be a fixed effective rational divisor, or the boundary part of one fixed
parabolic line bundle.  Its local pullback degree is

\[
  \operatorname{cont}_{p,D}(a,b,c)
  =\alpha_0m_{0,p}+\alpha_1m_{1,p}
   +\alpha_\infty m_{\infty,p}.
\]

## 2. Local no-go theorem

### Theorem 2.1

Suppose one of `alpha_0,alpha_1,alpha_infinity` is strictly positive.  There do
not exist constants `K,C` such that for every primitive positive triple and
every prime `p`,

\[
  \operatorname{cont}_{p,D}(a,b,c)
  \leq K\,\mathbf 1_{p\mid abc}+C.
\]

In particular, the pullback of a fixed effective boundary divisor cannot be
bounded uniformly by a constant multiple of the local radical contribution.

#### Proof

Fix a prime `p`.

If `alpha_0>0`, use

\[
  (a_n,b_n,c_n)=(p^n,1,p^n+1).
\]

The triple is primitive and positive, and

\[
  m_{0,p}=n,
  \qquad m_{1,p}=m_{\infty,p}=0.
\]

Thus the left side is `alpha_0 n`, while the right side is `K+C`.
Letting `n` tend to infinity is impossible.

If `alpha_1>0`, use

\[
  (a_n,b_n,c_n)=(1,p^n,p^n+1).
\]

If `alpha_infinity>0`, use

\[
  (a_n,b_n,c_n)=(1,p^n-1,p^n).
\]

In the last family `gcd(1,p^n-1)=gcd(p^n-1,p^n)=1`, so it is primitive, and
only the contact order at infinity equals `n`.

## 3. Global consequence

The same families show that no fixed positive combination of the three
boundary pullback degrees can satisfy

\[
  \sum_p\operatorname{cont}_{p,D}(a,b,c)\log p
  \leq
  K\log\operatorname{rad}(abc)+O(1)
\]

by a placewise truncation argument.  The left side records full valuations;
the radical records only support.

This does not contradict the possibility of cancellations with other local or
archimedean terms, but it proves that the radical cannot arise from the
positive pullback of one fixed boundary divisor alone.

## 4. Implication for the Legendre Hodge--Arakelov route

The maximal-Higgs identity

\[
  L^{\otimes2}\simeq
  \Omega^1_{\mathbb P^1}(\log\{0,1,\infty\})
\]

and the geometric degree `deg L=1/2` do not by themselves truncate arithmetic
contact orders.  Ordinary pullback along `lambda=a/c` still multiplies the
boundary coefficient by `v_p(a)`, `v_p(b)`, or `v_p(c)`.

Therefore a successful parabolic proof of abc must contain an additional
multiplicity-lowering mechanism.  Possible surviving mechanisms include:

1. a locally saturated/root-stack pullback whose normalization is proved to be
   compatible with the global product formula;
2. a negative local term cancelling all but the support contribution;
3. an adelic maximal-slope construction depending on the canonical monodromy
   line at each place;
4. a level-dependent operation followed by an averaging theorem that leaves
   exactly one unit of conductor support;
5. a verified normed theta comparison with an explicit Jacobian and different.

The theorem eliminates only the **fixed effective boundary-divisor shortcut**.
The canonically normalized parabolic/adelic and IUT/ATS correction routes remain
active.
