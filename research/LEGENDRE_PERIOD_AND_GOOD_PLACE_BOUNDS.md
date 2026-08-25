# Archimedean period growth and good-place unitness for the Legendre family

## 1. Complete elliptic integrals

For `0<t<1`, define

\[
  K(t)=\int_0^{\pi/2}\frac{d\theta}
  {\sqrt{1-t\sin^2\theta}}.
\]

With `x=tan(theta)` and `delta=1-t`,

\[
  K(t)=\int_0^\infty
  \frac{dx}{\sqrt{(1+x^2)(1+\delta x^2)}}.
\]

### Theorem 1.1 (elementary cusp bound)

For every `0<t<1`,

\[
  K(t)\leq 2+\frac12\log\frac1{1-t},
\]

and

\[
  K(1-t)\leq 2+\frac12\log\frac1t.
\]

#### Proof

Split the first integral into

\[
  [0,1],\qquad[1,\delta^{-1/2}],\qquad
  [\delta^{-1/2},\infty].
\]

On the first interval the integrand is at most `1`.  On the second it is at
most `1/x`.  On the third it is at most

\[
  \frac1{\sqrt\delta\,x^2}.
\]

The three integrals are bounded by

\[
  1,\qquad \frac12\log(1/\delta),\qquad1,
\]

respectively.  Replace `t` by `1-t` for the second inequality.

## 2. The Hodge norm

Let

\[
  E_t:y^2=x(x-1)(x-t),
  \qquad
  \omega=\frac{dx}{y}.
\]

The period lattice of `omega` is generated, up to fixed absolute factors and
choice of orientation, by a real period proportional to `K(t)` and an
imaginary period proportional to `iK(1-t)`.  Therefore the Hodge norm

\[
  \|\omega\|_{\rm Hdg}^2
  =\frac{i}{2}\int_{E_t(\mathbb C)}
    \omega\wedge\overline\omega
\]

satisfies

\[
  \|\omega\|_{\rm Hdg}^2
  \leq C_0 K(t)K(1-t)
\]

for one absolute constant `C_0>0` determined only by the normalization of the
Legendre differential.

### Theorem 2.1 (log-log archimedean growth)

Let `a,b,c` be positive integers with `a+b=c`, and put `t=a/c`.  Then

\[
  \log\|\omega\|_{\rm Hdg}
  \leq C_1+
  \log\left(2+\frac12\log c\right)
\]

for an absolute constant `C_1`.

#### Proof

Since `a,b>=1`,

\[
  t\geq\frac1c,
  \qquad
  1-t\geq\frac1c.
\]

Theorem 1.1 gives

\[
  K(t),K(1-t)
  \leq2+\frac12\log c.
\]

Insert these inequalities into the Hodge-norm estimate and take logarithms.

### Corollary 2.2 (uniform sublinearity)

For every `eta>0`, there is a constant `C_eta` such that

\[
  \log\|\omega\|_{\rm Hdg}
  \leq \eta\log c+C_\eta
\]

for every positive primitive triple `a+b=c`.

Indeed, the concave function

\[
  h\longmapsto
  \log(2+h/2)-\eta h
\]

is bounded above on `[0,infinity)`.

## 3. Symmetric powers

For every integer `r>=1`,

\[
  \log\|\omega^{\otimes r}\|_{\rm Hdg}
  =r\log\|\omega\|_{\rm Hdg}.
\]

Consequently

\[
  \frac1r
  \log\|\omega^{\otimes r}\|_{\rm Hdg}
  =O(\log\log c)
  =o(\log c),
\]

uniformly in `r`.  In particular, taking `r=ell-1` does not introduce a
positive proportion of the abc height after normalization by `ell-1`.

This closes the basic archimedean period-growth subproblem in the classical
Legendre parabolic/Hodge route.

## 4. Good finite places

Use the integral Frey--Legendre model

\[
  E_{a,b}:y^2=x(x-a)(x+b),
  \qquad a+b=c.
\]

Its discriminant is

\[
  \Delta=16a^2b^2c^2.
\]

### Theorem 4.1 (good-place unitness)

If a rational prime `p` does not divide `2abc`, the displayed model is smooth
over `Z_p`, and its invariant differential

\[
  \omega_{a,b}=\frac{dx}{2y}
\]

is a generator of the Hodge line of the Neron model over `Z_p`.  Hence every
tensor power of `omega_{a,b}` has local integral norm `1`.

#### Proof

The discriminant is a `p`-adic unit, so the Weierstrass equation defines a
smooth elliptic scheme over `Z_p`.  For a smooth Weierstrass model in odd
residue characteristic, `dx/(2y)` is the nowhere-vanishing invariant
differential and generates the relative dualizing/Hodge line.  Tensor powers
of a generator remain generators.

### Corollary 4.2

For the basic Hodge line and all its symmetric tensor powers, good finite
places contribute zero to the logarithmic integral-model defect.  All finite
errors are supported on

\[
  \{p:p\mid2abc\}
\]

and, after adding level structure, on the selected level prime and the field
different.

## 5. What remains

The two pieces most often treated as possible analytic obstacles are therefore
not the decisive gap:

1. the normalized archimedean Hodge norm is only `O(log log c)`;
2. good finite places have exact unit norm.

The surviving global theorem must control the bad-place contribution with
**truncated support** rather than full valuation multiplicity.  In the
parabolic/Hodge language it must compare the place-dependent monodromy
filtrations with an arithmetic maximal slope and show

\[
  \frac16Q
  \leq(1+o(1))(\log\operatorname{Diff}
      +\log\operatorname{Cond})+O(\log\ell).
\]

The present theorem narrows that target to the finite bad places, the level
prime, and the globalization of the locally canonical inertia filtrations.
It does not assume that remaining arithmetic specialization theorem.
