# Multiplicity entropy and Kummer root-discriminant control

## 1. Multiplicity entropy

Let `P` be a finite set of rational primes and let `m_p>=1` be integers. Put

\[
  H(P,m)=\sum_{p\in P}m_p\log p,
  \qquad
  \mathcal E(P,m)=\sum_{p\in P}\log(m_p+1).
\]

The first quantity is the full logarithmic multiplicity mass. The second is
the information needed to record the individual exponents.

### Theorem 1.1 (uniform sublinearity of multiplicity entropy)

For every `eta>0`, there is a constant `C_eta`, independent of `P` and of all
multiplicities, such that

\[
  \mathcal E(P,m)\leq\eta H(P,m)+C_\eta.
\]

#### Proof

Choose an integer `Y>=3` so large that

\[
  \frac{\log2}{\log Y}\leq\frac\eta2.
\]

Split `P=P_< union P_>=` according as `p<Y` or `p>=Y`.

For `p>=Y`, the elementary inequality `m+1<=2^m` gives

\[
 \log(m_p+1)\leq m_p\log2
 \leq\frac\eta2m_p\log p.
\]

Thus

\[
 \sum_{p\in P_\geq}\log(m_p+1)
 \leq\frac\eta2H(P,m).
\]

There are fewer than `Y` primes below `Y`. Since every prime is at least two,

\[
  m_p\log2\leq H(P,m),
\]

and hence

\[
 \sum_{p\in P_<}\log(m_p+1)
 \leq Y\log\left(1+\frac{H(P,m)}{\log2}\right).
\]

Put

\[
  \rho=\frac{\eta\log2}{2Y}>0.
\]

The scaled logarithm inequality

\[
  \log(1+x)\leq\rho x+ho-1-\log\rho
  \qquad(x\geq0)
\]

follows by applying `log u<=u-1` to `u=rho(1+x)`.  With
`x=H(P,m)/log2`, it gives

\[
 Y\log\left(1+\frac{H(P,m)}{\log2}\right)
 \leq\frac\eta2H(P,m)
 +Y(\rho-1-\log\rho).
\]

The desired theorem follows with

\[
  C_\eta=Y\max\{0,\rho-1-\log\rho\}.
\]

### Corollary 1.2

The same conclusion holds with `log m_p` in place of `log(m_p+1)`:

\[
  \sum_{p\in P}\log m_p
  \leq\eta H(P,m)+C_\eta.
\]

## 2. Pure Kummer fields

For every `p in P`, let

\[
  K_p=\mathbb Q(\alpha_p),
  \qquad
  \alpha_p^{m_p}=p.
\]

The polynomial `X^{m_p}-p` is Eisenstein at `p`, so

\[
  [K_p:\mathbb Q]=m_p.
\]

Its polynomial discriminant is

\[
  \operatorname{disc}(X^{m_p}-p)
  =\pm m_p^{m_p}p^{m_p-1}.
\]

Since the field discriminant divides the discriminant of every integral power
basis, we obtain

\[
  \frac1{[K_p:\mathbb Q]}\log|D_{K_p}|
  \leq\log m_p+\left(1-\frac1{m_p}\right)\log p.
\]

## 3. The compositum

Let

\[
  K=\prod_{p\in P}K_p
\]

be the compositum in one fixed algebraic closure.

We use the standard root-discriminant inequality for composita:

\[
  \operatorname{rd}(KL)
  \leq\operatorname{rd}(K)\operatorname{rd}(L),
  \qquad
  \operatorname{rd}(F)=|D_F|^{1/[F:\mathbb Q]}.
\]

It follows inductively that

\[
  \frac1{[K:\mathbb Q]}\log|D_K|
  \leq
  \sum_{p\in P}
  \left[
    \log m_p+\left(1-\frac1{m_p}\right)\log p
  \right].
\]

### Theorem 3.1 (radical plus sublinear multiplicity cost)

For every `eta>0`, there is `C_eta` such that

\[
  \frac1{[K:\mathbb Q]}\log|D_K|
  \leq
  \log\left(\prod_{p\in P}p\right)
  +\eta H(P,m)+C_\eta.
\]

#### Proof

Discard the negative terms `-(log p)/m_p` and apply Corollary 1.2 to
`sum log m_p`.

## 4. Significance for abc

If `m_p=v_p(abc)`, then

\[
  H(P,m)=\log(abc),
  \qquad
  \log\prod_{p\in P}p=\log\operatorname{rad}(abc).
\]

Thus a compositum that records one root degree for every local multiplicity
has normalized discriminant

\[
  \frac1{[K:\mathbb Q]}\log|D_K|
  \leq
  \log\operatorname{rad}(abc)
  +\eta\log(abc)+C_\eta.
\]

This is precisely the error shape that can be absorbed in an abc proof.

The theorem does **not** itself lower the multiplicity of the Hodge or Tate
parameter. Ordinary base change preserves the normalized arithmetic degree of
the original object. A successful Kummer-saturation route still needs a new
geometric construction whose local object is a chosen root of the Tate or
boundary parameter and whose product formula uses the field above with the
stated different cost.

## 5. Exact remaining Kummer-saturation theorem

A proof of abc would follow from a functorial construction `Sat(E,P,m)` with:

1. at every multiplicative prime `p`, a distinguished local parameter `r_p`
   satisfying `r_p^{m_p}=q_p` and normalized local order one;
2. a global adelic line or determinant whose finite positive contribution is
   `sum_{p in P} log p` rather than `sum m_p log p`;
3. all failures of the local roots to come from one global section bounded by
   the normalized discriminant in Theorem 3.1 and by `O(log ell)` level terms;
4. an archimedean contribution of arbitrarily small height slope;
5. compatibility with the ordinary product formula and with the original Frey
   height.

The multiplicity-entropy and root-discriminant parts are now closed. The
existence of this saturated global object remains open. This route is retained
until that theorem is proved or a no-go theorem shows that every such
construction necessarily restores the full multiplicity mass.
