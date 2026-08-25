# The remaining Legendre parabolic specialization theorem is the abc inequality

## 1. Heights on the thrice-punctured line

Let

\[
  U=\mathbb P^1\setminus\{0,1,\infty\},
\]

and let

\[
  \lambda=\frac ac\in U(\mathbb Q),
  \qquad
  a+b=c,
  \qquad
  \gcd(a,b,c)=1,
\]

with `a,b,c>0`.  The ordinary logarithmic height is

\[
  h(\lambda)=\log c.
\]

The truncated counting function of the boundary divisor

\[
  D=\{0,1,\infty\}
\]

is

\[
  N_D^{(1)}(\lambda)
  =\sum_{p\mid abc}\log p
  =\log\operatorname{rad}(abc).
\]

Thus the logarithmic abc conjecture is exactly the height inequality

\[
  h(\lambda)
  \le(1+\epsilon)N_D^{(1)}(\lambda)+O_\epsilon(1)
  \tag{1}
\]

for rational points of `U`.

## 2. The Legendre Hodge line

For the Legendre family, let `L` be the parabolic Hodge line.  Maximal
Kodaira--Spencer gives

\[
  L^{\otimes2}\simeq
  \Omega^1_{\mathbb P^1}(\log D),
  \qquad
  \deg L=\frac12.
\]

For any adelic metric differing from the standard projective metric by a
uniformly bounded function,

\[
  h_L(\lambda)=\frac12h(\lambda)+O(1).
\]

For the highest Hodge line in `Sym^(ell-1)`,

\[
  h_{L^{\ell-1}}(\lambda)
  =\frac{\ell-1}{2}h(\lambda)+O_\ell(1).
\]

## 3. Equivalence theorem

### Theorem 3.1

Fix `epsilon>0`.  An estimate of the form

\[
 h_{L^{\ell-1}}(\lambda)
 \le
 \left(\frac{\ell-1}{2}+\eta_\ell\right)
 N_D^{(1)}(\lambda)
 +O_{\epsilon,\ell}(1),
 \qquad
 \frac{2\eta_\ell}{\ell-1}\le\epsilon,
 \tag{2}
\]

for all primitive positive specializations implies the abc inequality (1).
Conversely, (1) implies (2), after enlarging the additive constant, for every
fixed `ell` and every metric uniformly equivalent to the standard Hodge
metric.

### Proof

Substitute

\[
 h_{L^{\ell-1}}(\lambda)
 =\frac{\ell-1}{2}h(\lambda)+O_\ell(1)
\]

into (2) and divide by `(ell-1)/2`.  This gives

\[
 h(\lambda)
 \le
 \left(1+\frac{2\eta_\ell}{\ell-1}\right)
 N_D^{(1)}(\lambda)+O_{\epsilon,\ell}(1),
\]

which is (1).  The reverse implication is obtained by multiplying (1) by
`(ell-1)/2` and absorbing the bounded metric difference.

## 4. Audit consequence

The coefficient identity

\[
  \deg L^{\ell-1}/((\ell-1)/12)=6
\]

is correct and explains the numerical factor `1/6`, but it does not by itself
make the remaining arithmetic specialization theorem easier than abc.  A
pointwise maximal-slope estimate with the sharp conductor coefficient is a
reformulation of geometric abc on the thrice-punctured line unless its proof
uses additional structures that produce a genuinely new inequality.

Therefore the parabolic route remains active only through its proposed
mechanism:

- exact Tate boundary determinants;
- integral good-place unitness;
- level-prime control;
- an archimedean or adelic inequality not already equivalent to assuming (1).

Any proof of the remaining maximal-slope theorem must be audited to ensure that
it does not insert the truncated boundary-height estimate as a hypothesis.
