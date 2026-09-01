# ABC multi-route research note v29b: exact cross-endpoint contact depth

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Canonical variables

For a primitive positive abc triple, write

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad M+m=c,
\]

and split the two large endpoints canonically as

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
\boxed{RA+m=SB}.
\]

The residuals `A,B` are squarefree.  Every prime of `R` lies in `A`, and every
prime of `S` lies in `B`.

Write

\[
R=\prod_{p\mid A}p^{\rho_p},
\qquad
S=\prod_{q\mid B}q^{\sigma_q},
\]

where zero exponents are allowed for primes occurring only to the first power
in the corresponding endpoint.

## 2. The affine contact sees support, not multiplicity

Choose `x,y` with `Rx+Sy=1`, and write every residual solution as

\[
A_t=-mx+tS,\qquad B_t=my+tR.
\]

The exact identities

\[
t-mxy=yA_t+(tx)R,
\qquad
t+mxy=xB_t+(ty)S
\]

show that

\[
\operatorname{rad}(R)\mid t-mxy,\qquad
\operatorname{rad}(S)\mid t+mxy.
\]

Hence, away from the explicit right-square collapse,

\[
\operatorname{rad}(R)\operatorname{rad}(S)\mid
 t^2-m^2x^2y^2.
\]

This is a genuine shared-support restriction, but it is only radical-level.
It does **not** imply

\[
p^{\rho_p}\mid t-mxy
\]

or its right-hand analogue.  In fact, because `A_t` is squarefree and `y` is
a unit at every prime of `R`, the first term `yA_t` usually has valuation
exactly one.  Therefore the affine contact cannot by itself control the total
modulus exponent height.  This closes a tempting but incorrect route.

## 3. The full multiplicities occur in the endpoint contacts

The original endpoint equation gives the correct high-order contacts:

\[
SB-m=RA,
\qquad
RA+m=SB.
\]

Let `p` be a prime dividing `A`.  Since `A` is squarefree,

\[
v_p(RA)=v_p(R)+1=\rho_p+1.
\]

Consequently

\[
\boxed{
v_p(SB-m)=\rho_p+1.
}
\]

Likewise, for every prime `q` dividing `B`,

\[
\boxed{
v_q(RA+m)=\sigma_q+1.
}
\]

The statements are exact: the displayed prime power divides, and the next
prime power does not.

This identifies both exponent vectors with cross-endpoint lifting depths.

## 4. Exact height identities

The total left modulus exponent height is

\[
H_R=\log R=
\sum_{p\mid A}\rho_p\log p.
\]

Using the exact contact formula,

\[
\boxed{
H_R=
\sum_{p\mid A}
\bigl(v_p(SB-m)-1\bigr)\log p.
}
\]

Similarly,

\[
\boxed{
H_S=\log S=
\sum_{q\mid B}
\bigl(v_q(RA+m)-1\bigr)\log q.
}
\]

Thus controlling the two exponent vectors is exactly the same as controlling
the total lifting excess in two families of cross-supported S-unit
differences.

This is more precise than a general S-unit height interface: it specifies the
actual local quantities whose weighted sum must be bounded.

## 5. Unit structure at every contact prime

Primitivity implies the three prime supports of `m`, `M`, and `c` are disjoint.
Hence, for `p|A`,

\[
p\nmid mSB,
\qquad
SB\equiv m\pmod{p^{\rho_p+1}}.
\]

The ratio `SB/m` is therefore a p-adic unit satisfying

\[
\frac{SB}{m}\equiv1\pmod{p^{\rho_p+1}}.
\]

For odd `p`, raising to `p-1` removes the Teichmueller component and produces
a principal-unit logarithmic form.  Formally, after choosing p-adic logarithms,

\[
(\rho_p+1)\log p
\]

is controlled by the valuation of

\[
\sum_{q\mid B}(\sigma_q+1)\log_p q
-
\sum_{r\mid m}v_r(m)\log_p r.
\]

The right side has the symmetric system with `p` and `q` exchanged.

This produces a coupled bipartite family of p-adic linear forms.  A complete
proof now requires a **global weighted estimate for their total valuations**,
not an estimate for one fixed prime at a time.

## 6. Precise remaining theorem

A sufficient non-circular theorem is the following total-contact estimate.
For every `epsilon>0`, prove a constant `C_epsilon` such that every canonical
solution satisfies

\[
\begin{aligned}
&\sum_{p\mid A}
  \bigl(v_p(SB-m)-1\bigr)\log p\\
&\quad+
\sum_{q\mid B}
  \bigl(v_q(RA+m)-1\bigr)\log q\\
&\le
\epsilon\log c
+(1+\epsilon)
 \log\bigl(\operatorname{rad}(m)AB\bigr)
+C_\epsilon.
\end{aligned}
\]

The left side is exactly `log R+log S`.  Because

\[
\log c=\log S+\log B
\]

and

\[
\log\operatorname{rad}(abc)
=
\log\operatorname{rad}(m)+\log A+\log B,
\]

an estimate with the correct one-sided allocation immediately yields the abc
height inequality.  The main analytic difficulty is preventing the same small
set of cross primes from carrying conductor-scale lifting depth simultaneously
on both sides.

## 7. Proposed next attack

The next proof attempt should form a global determinant from the principal-unit
logarithmic forms.  The target dichotomy is:

1. a nonzero p-adic-log determinant exists; a product-formula estimate then
   bounds the weighted sum of contact depths;
2. every relevant determinant vanishes; the exponent vectors satisfy a global
   multiplicative dependence, contradicting the disjoint rational-prime
   supports except for explicitly classifiable perfect-power slices.

The determinant must be constructed from the actual bases in `A`, `B`, and
`rad(m)`, and its nonvanishing must be proved before any height estimate is
invoked.  Merely applying a one-prime p-adic logarithm theorem separately will
produce constants too large to recover the coefficient `1+epsilon`.

## 8. Lean deliverables

The branch contains two unconditional modules:

```text
Lean/IUTThreeClosures/SharedSupportAffineContact.lean
Lean/IUTThreeClosures/CanonicalEndpointContactDepth.lean
```

The second module proves:

```lean
factorization_mul_squarefree_eq_add_one
left_cross_contact_depth
right_cross_contact_depth
left_contact_prime_pow_dvd
left_contact_next_prime_pow_not_dvd
right_contact_prime_pow_dvd
right_contact_next_prime_pow_not_dvd
weighted_contact_excess_eq_exponent_height
```

No abc estimate, total-contact estimate, `axiom`, `sorry`, or `admit` is
introduced.  The missing global p-adic determinant estimate remains a genuine
mathematical theorem to prove.
