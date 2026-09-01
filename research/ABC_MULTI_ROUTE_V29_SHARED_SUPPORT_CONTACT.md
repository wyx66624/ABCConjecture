# ABC multi-route research note v29: shared-support affine contact

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Canonical residual setting

For a primitive positive abc triple, let

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad M+m=c.
\]

Write the two large endpoints in canonical radical/powerful form

\[
M=RA,\qquad c=SB,
\]

where

\[
A=\operatorname{rad}(M),\quad R=M/A,
\qquad
B=\operatorname{rad}(c),\quad S=c/B.
\]

Then

\[
SB-RA=m,
\]

and the canonical support-sharing conditions are

\[
\operatorname{rad}(R)\mid A,\qquad
\operatorname{rad}(S)\mid B.
\]

Fix integers `x,y` with

\[
Rx+Sy=1.
\]

Every residual solution is uniquely parametrized by

\[
A_t=-mx+tS,\qquad B_t=my+tR.
\]

The purpose of this note is to use the support-sharing conditions inside this
parametrization rather than merely recording them as fields.

## 2. Exact contact identities

A direct calculation using `Rx+Sy=1` gives

\[
\boxed{
t-mxy=yA_t+(tx)R
}
\]

and

\[
\boxed{
t+mxy=xB_t+(ty)S.
}
\]

Consequently, if `r|R` and `r|A_t`, then

\[
\boxed{r\mid t-mxy}.
\]

Similarly, if `s|S` and `s|B_t`, then

\[
\boxed{s\mid t+mxy}.
\]

Applying this with

\[
r=\operatorname{rad}(R),\qquad
s=\operatorname{rad}(S)
\]

uses the canonical support-sharing hypotheses and yields

\[
\boxed{
\operatorname{rad}(R)\mid t-mxy,\qquad
\operatorname{rad}(S)\mid t+mxy.
}
\]

Multiplying the two divisibilities gives the global quadratic contact:

\[
\boxed{
\operatorname{rad}(R)\operatorname{rad}(S)\mid
 t^2-m^2x^2y^2.
}
\]

This constraint is absent for a general affine residual solution. It is the
first exact arithmetic restriction produced specifically by sharing the prime
supports of the moduli and the squarefree residuals.

## 3. Nonvanishing and the exceptional branch

Suppose `m>0`, `R>0` and `A_t>0`. If

\[
t-mxy=0,
\]

then substitution into `A_t=-mx+tS` and use of `Rx+Sy=1` gives

\[
A_t=-mRx^2\le0,
\]

contradicting positivity. Hence

\[
\boxed{t-mxy\ne0.}
\]

If the other factor vanishes,

\[
t+mxy=0,
\]

then

\[
\boxed{B_t=mSy^2.}
\]

For canonical abc data, `B_t` is squarefree and coprime to `m`. Therefore the
identity forces `m=1`; it also forces `|y|=1` and `S` squarefree. In that
exceptional branch

\[
c=SB=S^2,
\]

so the right endpoint is an exact square. This branch belongs to the already
isolated square/cube--Mordell frontier rather than the generic shared-support
case.

Outside this square-collapse branch, the quadratic contact is nonzero, and
therefore

\[
\boxed{
\operatorname{rad}(R)\operatorname{rad}(S)\le
\left|t^2-m^2x^2y^2\right|.
}
\]

## 4. Interpretation for the two exponent vectors

Write

\[
R=\prod_{p\mid A}p^{\rho_p},
\qquad
S=\prod_{q\mid B}q^{\sigma_q}.
\]

The total exponent heights are

\[
H_R=\sum_{p\mid A}\rho_p\log p=\log R,
\qquad
H_S=\sum_{q\mid B}\sigma_q\log q=\log S.
\]

The new quadratic contact does not yet bound `H_R+H_S`, because a fixed prime
support can still carry arbitrarily large exponents. What it does prove is a
sharp separation of the remaining task:

1. the **support component** is constrained by a single explicit quadratic
   integer,
   \[
   \log\operatorname{rad}(RS)
   \le
   \log|t^2-m^2x^2y^2|;
   \]
2. the only uncontrolled component is now the **multiplicity component**
   \[
   \log(RS)-\log\operatorname{rad}(RS)
   =
   \sum_p(\rho_p-1)_+\log p+
   \sum_q(\sigma_q-1)_+\log q.
   \]

Thus any proof must control high multiplicities on a support already forced
into the two contact factors `t-mxy` and `t+mxy`.

## 5. Refined final target

The next non-circular target is no longer a general height inequality. It is a
pointwise lifting estimate for the two contact factors:

> Bound the multiplicity with which primes dividing `R` can divide
> `t-mxy`, and primes dividing `S` can divide `t+mxy`, uniformly in the
> canonical residual data.

Equivalently, one seeks, for every `epsilon>0`, a bound of the shape

\[
\log(RS)
\le
(1+\epsilon)
\log\operatorname{rad}(RS)
+
\epsilon\log(\operatorname{rad}(m)AB)
+O_\epsilon(1),
\]

but proved through the explicit contact identities and their local lifting
structure, not assumed as a closure record.

At each prime `p|R`, the exact equation is a high-order congruence

\[
t\equiv mxy\pmod{p^{\rho_p}},
\]

and at each `q|S`,

\[
t\equiv -mxy\pmod{q^{\sigma_q}}.
\]

The two exponent vectors have therefore become two families of exact contact
orders of the same affine parameter with the two opposite centers `+mxy` and
`-mxy`. This is the concrete local object to attack using p-adic logarithms,
lifting-the-exponent arguments, or a determinant/product-formula method.

## 6. Lean deliverable

The module

```text
Lean/IUTThreeClosures/SharedSupportAffineContact.lean
```

formalizes:

```lean
left_contact_identity
right_contact_identity
left_shared_support_dvd_contact
right_shared_support_dvd_contact
shared_support_product_dvd_quadratic_contact
shared_support_product_natAbs_le_quadratic_contact_natAbs
left_contact_ne_zero_of_positive
right_residual_eq_of_right_contact_zero
positive_shared_support_contact_dichotomy
```

No abc estimate, exponent-height bound, `axiom`, `sorry`, or `admit` is added.
The result is an unconditional reduction of the shared-support condition to an
explicit pair of local contact orders.
