# ABC multi-route research note v28: canonical powerful-part residual core

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Purpose

The v27 affine parametrization classifies every residual equation of the form

\[
SB-RA=m.
\]

For a genuine abc point the variables are not arbitrary.  There is a canonical
choice in which the residual coefficients are exactly radicals and the moduli
are exactly powerful parts.  This note records that specialization and all of
its support and coprimality constraints.

## 2. Canonical decomposition

For a positive primitive triple

\[
a+b=c,
\]

put

\[
m=\min(a,b),\qquad M=\max(a,b).
\]

For a positive integer `n`, write

\[
r(n)=\operatorname{rad}(n),
\qquad
q(n)=\frac{n}{r(n)}.
\]

Define

\[
R=q(M),\qquad A=r(M),
\]

\[
S=q(c),\qquad B=r(c).
\]

Then

\[
M=RA,\qquad c=SB,\qquad m+M=c,
\]

so

\[
\boxed{SB-RA=m.}
\tag{2.1}
\]

This is the affine residual equation with no discretionary choice of modulus
or residual coefficient.

## 3. Exact arithmetic restrictions

Because `M` and `c` are coprime, so are all divisors selected from the two
opposite endpoints.  In particular,

\[
\gcd(R,S)=1,
\qquad
\gcd(A,B)=1.
\]

The gap is also coprime to both endpoint radicals:

\[
\gcd(m,A)=1,
\qquad
\gcd(m,B)=1.
\]

The residuals are squarefree by construction:

\[
A=r(M),\qquad B=r(c).
\]

Finally the support of each powerful modulus is contained in its associated
residual:

\[
\boxed{r(R)\mid A,\qquad r(S)\mid B.}
\tag{3.1}
\]

Thus the actual core is not an arbitrary pair of coprime moduli and arbitrary
affine residuals.  It is a support-saturated S-unit equation: the moduli use
only primes already recorded once in the squarefree residual coefficients.

## 4. Relation to the abc height

Pairwise coprimality gives

\[
\operatorname{rad}(abc)=r(m)AB.
\]

Hence the abc conjecture becomes the pointwise estimate

\[
\boxed{
SB
\le
C_\varepsilon\,[r(m)AB]^{1+\varepsilon}
}
\tag{4.1}
\]

for every canonical solution of (2.1), subject to the conditions in Section 3.

Equivalently, writing

\[
R=\prod_{p\mid A}p^{\rho_p},
\qquad
S=\prod_{q\mid B}q^{\sigma_q},
\]

with nonnegative exponent excesses, one must bound the size created by these
excess exponent vectors in terms of the squarefree supports `r(m),A,B`.

This is a genuine prime-exponent problem rather than a freely populated
closure record.  It is nevertheless equivalent in strength to the unresolved
pointwise abc bound; the present note does not assume or prove (4.1).

## 5. Interaction with v27

Since `gcd(R,S)=1`, choose integers `x,y` with

\[
Rx+Sy=1.
\]

Then the canonical radicals `A,B` occur at the unique v27 parameter

\[
t=yA+xB.
\]

All v27 identities therefore apply:

\[
A=-mx+tS,\qquad B=my+tR,
\]

\[
A_tB_u-A_uB_t=m(t-u),
\]

and

\[
(SB+RA)^2-4RSAB=m^2.
\]

The new content of the canonical specialization is (3.1): the prime support
of each moving modulus is already present in the corresponding residual.
Any next positive argument must exploit this support saturation together with
the small radical of the gap.  The unrestricted affine family cannot do so,
as its trivial-modulus slice contains every additive pair.

## 6. Lean formalization

The module is

```text
Lean/IUTThreeClosures/CanonicalPowerfulResidualCore.lean
```

Its main declarations are

```lean
ABCPoint.endpointMin_add_largeEndpoint_eq_c
ABCPoint.canonicalLarge_factorization
ABCPoint.canonicalSum_factorization
ABCPoint.canonical_residual_gap_nat
ABCPoint.canonical_residual_gap_int
ABCPoint.canonicalPowerfulModuli_coprime
ABCPoint.canonicalRadicalResiduals_coprime
ABCPoint.endpointMin_coprime_canonicalLargeResidual
ABCPoint.endpointMin_coprime_canonicalSumResidual
ABCPoint.canonicalLargeResidual_squarefree
ABCPoint.canonicalSumResidual_squarefree
ABCPoint.radical_canonicalLargeModulus_dvd_residual
ABCPoint.radical_canonicalSumModulus_dvd_residual
```

No `axiom`, `sorry`, or `admit` is introduced.  This is an unconditional
specialization of the remaining core, not a complete proof of the abc
conjecture.
