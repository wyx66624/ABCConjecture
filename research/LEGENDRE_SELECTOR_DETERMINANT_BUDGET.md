# The Determinant Budget of the Simultaneous Legendre Selector

**Author:** ChatGPT  
**Status:** unconditional arithmetic theorem; this is a no-go result only for the naive determinant/sup-norm metric

## 1. Setting

Let

\[
 a,b,c\in \mathbf Z_{>0},\qquad a+b=c,
\]

and, when the arithmetic `abc` setting is intended, also assume
`\gcd(a,b)=1`.  The simultaneous Legendre selector is

\[
 v=(b,-a)\in\mathbf Z^2.
\]

It lies at full depth in all three boundary directions modulo `a`, `b`, and
`c`.  The exact congruence lattice is

\[
 \Lambda_{a,b,c}
 =\{(x,y)\in\mathbf Z^2:a\mid y,\ b\mid x,\ c\mid x-y\}
 =\mathbf Z(b,-a)+\mathbf Z(0,ac),
\]

and consequently

\[
 \det(\Lambda_{a,b,c})=abc.
\]

Write

\[
 m=\min(a,b),\qquad M=\max(a,b).
\]

Since `\lVert v\rVert_\infty=M`, the most direct determinant quotient attached
to the selector is

\[
 \mathcal R_\infty(a,b,c)
 :=\frac{\det(\Lambda_{a,b,c})}{\lVert v\rVert_\infty}
 =\frac{abc}{M}.
\]

The purpose of this note is to compute this quotient exactly and determine
whether the simultaneous full-depth selector, by itself, has removed the
prime-power multiplicities that distinguish `abc` from a conventional height
estimate.

## 2. Exact residual formula

### Theorem 2.1 — determinant factorization

For positive `a,b,c`,

\[
 \boxed{\mathcal R_\infty(a,b,c)=mc}
\]

and

\[
 \boxed{M\,\mathcal R_\infty(a,b,c)=abc.}
\]

#### Proof

The elementary identity

\[
 \min(a,b)\max(a,b)=ab
\]

implies

\[
 \frac{abc}{M}=\frac{mMc}{M}=mc,
\]

because `M>0`.  Multiplication by `M` gives the second identity.  ∎

This calculation is independent of coprimality.  Coprimality is needed for the
usual primitive `abc` interpretation and for the Smith normal form statement,
but not for the determinant budget itself.

## 3. The residual still contains full multiplicity

### Theorem 3.1 — sharp elementary window

If `a,b>0` and `a+b=c`, then

\[
 \boxed{ab<\mathcal R_\infty(a,b,c)\le 2ab.}
\]

#### Proof

Since `c=m+M`,

\[
 \mathcal R_\infty=mc=m(m+M)=m^2+mM=m^2+ab.
\]

The strict lower bound follows from `m>0`.  Since `m\le M`, one has
`m^2\le mM=ab`; hence

\[
 \mathcal R_\infty=m^2+ab\le 2ab.
\]

Both assertions follow.  ∎

Thus the quotient is not a radicalized conductor-like quantity.  It retains
ordinary multiplicative size.  In logarithmic form,

\[
 \log a+\log b
 <\log\mathcal R_\infty
 \le\log a+\log b+\log 2.
\]

The direct determinant quotient therefore differs from `\log(ab)` by less
than `\log 2`; it does not, merely from the congruence construction, replace
valuation multiplicities by their supports.

### Corollary 3.2 — any radical bound for the residual is already an `abc`
height bound

Because `m\ge1`,

\[
 c\le mc=\mathcal R_\infty.
\]

Consequently, for every nonnegative comparison quantity `B`,

\[
 \mathcal R_\infty(a,b,c)\le B
 \quad\Longrightarrow\quad
 c\le B.
\]

In particular, a theorem of the form

\[
 \mathcal R_\infty(a,b,c)
 \le C_\varepsilon\operatorname{rad}(abc)^{1+\varepsilon}
\]

would already imply the usual `abc` height inequality with the same constant.
It is therefore not a preliminary estimate weaker than `abc`; it contains an
`abc`-strength conclusion.

## 4. A balanced primitive family

### Theorem 4.1 — quadratic residual on balanced triples

For every integer `n\ge1`, set

\[
 a=n,\qquad b=n+1,\qquad c=2n+1.
\]

Then `a+b=c`, `\gcd(a,b)=1`, and

\[
 \mathcal R_\infty(n,n+1,2n+1)=n(2n+1).
\]

Moreover,

\[
 \boxed{c^2\le3\mathcal R_\infty(n,n+1,2n+1).}
\]

Equivalently,

\[
 \mathcal R_\infty(n,n+1,2n+1)\ge\frac{c^2}{3}.
\]

#### Proof

Here `m=n`, so the exact formula gives

\[
 \mathcal R_\infty=n(2n+1)=nc.
\]

For `n\ge1`,

\[
 c=2n+1\le3n.
\]

Multiplying by the positive number `c` yields

\[
 c^2\le3nc=3\mathcal R_\infty.
\]

Finally, consecutive integers are coprime.  ∎

Hence the naive residual can have logarithmic size

\[
 \log\mathcal R_\infty\ge2\log c-\log3.
\]

This is substantially larger than a single height term on balanced triples.
The selector is short relative to the full determinant, but not short enough
for the unmodified determinant quotient to supply the desired radical
compression.

## 5. Consequence for the Hodge--Arakelov route

The simultaneous selector theorem remains a genuine positive result: one
primitive global vector enters all three locally canonical Legendre boundary
lines at their full prime-power depths.  The present theorem does **not** refute
that route.

It does refute the following naive completion:

1. take the congruence lattice of determinant `abc`;
2. take the selector line of ordinary sup-norm `M`;
3. use only the unmodified quotient `abc/M` as the transverse arithmetic
   degree;
4. expect the quotient to have automatically forgotten prime-power
   multiplicities.

The quotient is exactly `mc`, so step 4 is false.  A viable successor must
change the metric comparison in a mathematically controlled way.  Possible
survivors include a parabolic degree, a relative determinant in which the
boundary multiplicity is subtracted once, a conductor-normalized local norm,
or a nonlinear truncation whose global defect is separately estimated.

The conservative-transfer theorem gives the complementary audit criterion:
any such renormalization must exhibit its nonconservative defect explicitly.
A relabelling or weight-preserving transport of the same determinant budget
cannot create the missing strict gain.

## 6. Lean formalization contract

The companion Lean file formalizes the multiplicative core over `\mathbf N`:

- `legendreResidualDeterminant`;
- `max_mul_legendreResidualDeterminant`;
- `mul_lt_legendreResidualDeterminant`;
- `legendreResidualDeterminant_le_two_mul`;
- `height_le_legendreResidualDeterminant`;
- `balanced_legendreResidualDeterminant`;
- `balanced_height_sq_le_three_residual`.

The logarithmic corollaries follow from monotonicity and additivity of the real
logarithm.  They are intentionally downstream of the exact natural-number
identities, so the arithmetic obstruction is kernel-checkable without adding
analytic or arithmetic-geometric axioms.

## 7. Boundary of the result

This theorem neither proves nor disproves the `abc` conjecture.  It removes one
specific metric shortcut while preserving every successor route that supplies
a genuine parabolic, relative, conductor-normalized, or otherwise
nonconservative correction and proves the required global estimate for that
correction.
