# The Legendre discriminant section and the finite boundary term

## 1. Motivation

After correcting the Hodge line to a stacky/parabolic object, the next task is
to realize its finite multiplicative contribution without an abstract theta
packet.  The classical modular discriminant already supplies such a section.

Let

\[
  \mathcal X(2)
\]

be the compactified level-two modular stack, let `omega` be its Hodge line, and
let

\[
  D=D_0+D_1+D_\infty
\]

be the three labelled cusp divisors.

## 2. Divisor of the Legendre discriminant

On the affine Legendre chart

\[
  E_\lambda:y^2=x(x-1)(x-\lambda),
\]

the algebraic discriminant relative to the standard invariant differential is

\[
  \Delta_{\rm Leg}(\lambda)
  =16\lambda^2(1-\lambda)^2.
\]

As a section of `omega^12` on the compactified stack, it has divisor

\[
  \operatorname{div}(\Delta_{\rm Leg})
  =2D_0+2D_1+2D_\infty=2D.
\]

The apparent pole at infinity in the affine coefficient is cancelled by the
change of Hodge frame; in the stacky line bundle the section vanishes to order
two at every cusp.  The degree check is

\[
  \deg\omega^{12}=12\cdot\frac12=6
  =\deg(2D).
\]

## 3. Integral powers at levels `ell = 1 mod 12`

Choose an auxiliary prime

\[
  \ell\equiv1\pmod{12},
  \qquad
  m=\frac{\ell-1}{12}.
\]

Then

\[
  s_\ell=\Delta_{\rm Leg}^{\,m}
\]

is an honest integral section of

\[
  \omega^{\ell-1},
\]

and

\[
  \operatorname{div}(s_\ell)
  =2mD
  =\frac{\ell-1}{6}D.
\]

This avoids taking a fractional power of the discriminant and makes every
finite-place multiplicity integral.

## 4. Arithmetic specialization

Let

\[
  a+b=c,
  \qquad
  \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1,
\]

and specialize at

\[
  \lambda=\frac ac,
  \qquad
  1-\lambda=\frac bc.
\]

At a finite prime `p`, pairwise coprimality implies that at most one of
`a,b,c` has positive `p`-adic valuation.  The local intersection multiplicity
with the labelled cusp divisor is therefore

\[
  i_p(\lambda,D)
  =v_p(a)+v_p(b)+v_p(c)
  =v_p(abc).
\]

Consequently the finite divisor contribution of `s_ell` is

\[
  \sum_{p<\infty}
   \frac{\ell-1}{6}v_p(abc)\log p
  =\frac{\ell-1}{6}\log(abc).
\]

For the Frey--Legendre curve,

\[
  \log|\Delta_{\min}|
  =2\log(abc)+O(1),
\]

where the bounded term is supported at the fixed small primes.  Hence

\[
  \frac{\ell-1}{6}\log(abc)
  =\frac{\ell-1}{12}\log|\Delta_{\min}|
   +O(\ell).
\]

This is exactly the canonical Tate-line coefficient found from the local
Bernoulli calculation.

## 5. Good-place unit theorem

### Theorem 5.1

At every finite prime

\[
  p\nmid 2abc\ell,
\]

the specialized discriminant section `s_ell` is an integral unit in the
standard smooth level-two model.

### Proof

At such a prime, `lambda` and `1-lambda` are units and the Legendre equation has
good reduction.  The coefficient

\[
  16\lambda^2(1-\lambda)^2
\]

is a unit, the Hodge frame is integral, and raising to the integral power `m`
does not introduce a denominator.  The level structure is etale because
`p != ell`.  Thus the local logarithmic defect is zero.

## 6. What this closes

The discriminant section proves, in a completely classical way:

1. the exact finite boundary slope `(ell-1)/12` against the Frey discriminant;
2. zero defect at ordinary good finite places;
3. integrality of the relevant Hodge power when `ell=1 mod 12`.

The congruence condition can be incorporated into the auxiliary-prime problem
as one fixed arithmetic progression condition; it does not alter the logical
form of the prime-selection and sublinear-logarithm route.

## 7. What remains

The product formula forces the finite positive boundary term to be balanced by
archimedean, level-prime, and descent/Jacobian contributions.  The decisive
remaining theorem is now narrower:

### Target theorem 7.1 (archimedean and level-prime compensation)

For the stack-normalized metric on `omega^(ell-1)`, prove

\[
 -\sum_{v\mid\infty\text{ or }v\mid\ell}
   \log\|s_\ell(\lambda)\|_v
 \le
 \left(\frac{\ell-1}{2}+o_\ell(\ell)\right)
   (\log\operatorname{Diff}+\log\operatorname{Cond})
 +O(\ell\log\ell),
\]

including the generic `mu_2` descent and all metric Jacobians.

Together with the finite calculation above and the identity

\[
  \frac{(\ell-1)/2}{(\ell-1)/12}=6,
\]

this would yield the required `Q/6` inequality.

The present theorem does not prove Target theorem 7.1.  It removes the finite
boundary and good-place portions from that target and leaves only the genuinely
global analytic/Arakelov compensation problem.
